--[[ ZAPNUTIE DEBUGGERA
lrdb = require("lrdb_server")
lrdb.activate(21110)
--]]

JSON = require("JSON")

astManager = require "luadb.manager.AST"
extractor = require "luadb.extraction.moduleExtractor"  -- MODULEEXTRACTOR nie obycajny extractor!!!!!
utils = require "luadb.utils"

-- vrati velky graf ale len s dolezitymi uzlami a hranami,
-- rooty zacinaju v uzle typu "file" cize graf moze byt rozdeleny na viacero nespojenych grafov podla .lua suborov
local function myExtract(graph)
	local newGraph = {edges={}, nodes={}}
	-- extrakcia dolezitych hran
	for _, edge in pairs(graph.modified_edges) do
		local fNodeType, tNodeType = edge.from[1].meta.type, edge.to[1].meta.type
		-- vytriedenie len potrebnych hran podla uzlov, s ktorymi su prepojene
		if (not string.find(fNodeType, "comment") and not string.find(fNodeType, "metrics") and not string.find(fNodeType, "body") and fNodeType ~= "directory" and fNodeType ~= "cyclomatic" and fNodeType ~= "lines of code" and
		not string.find(tNodeType, "comment") and not string.find(tNodeType, "metrics") and not string.find(tNodeType, "body") and tNodeType ~= "directory" and tNodeType ~= "cyclomatic" and tNodeType ~= "lines of code") then
			table.insert(newGraph.edges, edge)
			-- pridanie modulePath do uzla typu modul
			if (edge.from[1].meta.type == "module") then
				edge.from[1].meta.modulePath = edge.from[1].data.path
				-- pridanie modulePath do uzlov ktore su kontajnery
				if (string.find(edge.to[1].meta.type, 'container')) then
					edge.to[1].meta.modulePath = edge.from[1].meta.modulePath
				end
			end
		end
	end
	-- extrakcia dolezitych uzlov
	for _, node in pairs(graph.modified_nodes) do
		local nodetype = node.meta.type
		if (not string.find(nodetype, "comment") and not string.find(nodetype, "metrics") and not string.find(nodetype, "body") and nodetype ~= "directory" and nodetype ~= "cyclomatic" and nodetype ~= "lines of code") then
			table.insert(newGraph.nodes, node)
		end
	end
	return newGraph
end 

-- vlozenie uzla do listu
local function insertNode(nodes_list, node)
	local myNode = {id = node.id, type = string.lower(node.meta.type), text = ""}
	if (myNode.type == "module") then
		myNode.text = node.data.name
	elseif (myNode.type == "function") then
		myNode.text = node.data.text or ""
	elseif (myNode.type == "statement") then
		myNode.type = myNode.type .. ":" .. string.lower(node.data.tag)
		myNode.text = node.data.str
	elseif (myNode.type == "global function") then
		myNode.text = node.data.name
	end
	table.insert(nodes_list, myNode)
end

-- zisti, ci sa uz dane ID v liste uzlov nachadza
local function containsId(nodes, id)
	for _, node in pairs(nodes) do
		if (node.id == id) then
			return true
		end
	end
	return false
end

-- najde v liste uzlov uzol s najmensim ID od indexu start po index stop a vrati jeho index
local function findMinID(nodes, start, stop)
	minIndex = start
	for i=start,stop do
		if (nodes[i].id < nodes[minIndex].id) then
			minIndex = i
		end
	end
	return minIndex
end

local function getStatementID(graph, statement_text)
	for _, node in pairs(graph.nodes) do
		if (node.text == statement_text) then
			return node.id
		end
	end
	return -1
end

local function handleFunctionAsArument(graph)
	for _, functionCallNode in pairs(graph.nodes) do
		if (functionCallNode.type == 'statement:functioncall') then
			for _, functionNode in pairs(graph.nodes) do
				if (functionNode.type == 'function') then
					if (string.find(functionCallNode.text, functionNode.text, nil, true)) then
						local newEdge = {from=functionCallNode.id, label='hasArgument', to=functionNode.id}
						table.insert(graph.edges, newEdge)
					end
				end
			end
		end
	end
end

-- preindexovanie uzlov a hran (aby boli idcka 0 az n-1)
local function reindex(graph)
	local nnodes = #graph.nodes
	for i=1,nnodes do
		-- najde sa namjemnsie ID od indexu i az po koniec
		local minIDindex = findMinID(graph.nodes, i, nnodes)
		-- switchnutie uzlov
		graph.nodes[i], graph.nodes[minIDindex] = graph.nodes[minIDindex], graph.nodes[i] 
		-- preindexovanie hran
		for _, edge in pairs(graph.edges) do
			if (edge.from == graph.nodes[i].id) then
				edge.from = i - 1 -- aby bolo od nuly pre neuronku
			end
			if (edge.to == graph.nodes[i].id) then
				edge.to = i - 1 -- aby bolo od nuly pre neuronku
			end
		end
		-- preindexovanie uzla
		graph.nodes[i].id = i - 1 -- aby bolo od nuly pre neuronku
	end
end

local function saveTableAsJSON(tableObj, path, filename)
	-- vytvorenie zlozky pre JSON
	local repo = string.match(path, "/(.*)")  -- vytiahne z "modules/nazov" iba "nazov"
	os.execute("mkdir data 2> /dev/null")
	os.execute("mkdir data/"..repo.." 2> /dev/null")
	local file = io.open("./data/"..repo.."/"..filename..".json", "w+")
	
	local serializedJSON = JSON:encode_pretty(tableObj)
	file:write(serializedJSON)
	file:close()
end

-- zaciatok programu
utils.logger:setLevel(logging.INFO)
astMan = astManager.new()
path = arg[1]  -- cesta k modulu z ktoreho sa vytvara graf (napr. "modules/abelhas"), berie sa ako argument z terminalu

-- velky graf nad celym priecinkom
local extractedGraph = extractor.extract(path, astMan)

-- velky graf len s dolezitymi uzlami a hranami
local myExtractedGraph = myExtract(extractedGraph)

for _, fileNode in pairs(myExtractedGraph.nodes) do
	-- hladanie uzlov len typu "file"
	if (fileNode.meta.type == 'file' and fileNode.data.astID) then
		local fileGraph = {edges={}, nodes={}}
		local filePath = fileNode.data.path
		local fileAstID = fileNode.data.astID
		for _, edge in pairs(myExtractedGraph.edges) do
			-- ak sa nodeFrom alebo nodeTo nachadza v rovnakom module alebo rovnakom ASTcku
			if (edge.from[1].meta.modulePath == filePath or edge.from[1].data.astID == fileAstID or edge.to[1].meta.modulePath == filePath or edge.to[1].data.astID == fileAstID) then
				local fNodeType, tNodeType = edge.from[1].meta.type, edge.to[1].meta.type
				local myEdge = {from = edge.from[1].id, label = edge.label, to = edge.to[1].id}
				-- otestuj ci sa uz rovnaky statement v grafe nenachadza
				local specialNode = {from=false, to=false}
				if (edge.from[1].meta.type == 'statement') then
					local statementID = getStatementID(fileGraph, edge.from[1].data.str)
					if (statementID > -1) then
						myEdge.from = statementID
						specialNode.from = true
					end
				end
				if (edge.to[1].meta.type == 'statement') then
					local statementID = getStatementID(fileGraph, edge.to[1].data.str)
					if (statementID > -1) then
						myEdge.to = statementID
						specialNode.to = true
					end
				end
				-- vlozenie hrany
				table.insert(fileGraph.edges, myEdge)
				-- vlozenie uzlov, ak sa nenachadzaju
				if (not specialNode.from and not containsId(fileGraph.nodes, edge.from[1].id)) then
					insertNode(fileGraph.nodes, edge.from[1])
				end
				if (not specialNode.to and not containsId(fileGraph.nodes, edge.to[1].id)) then
					insertNode(fileGraph.nodes, edge.to[1])
				end
			end
		end

		-- funkcie ako argumenty
		handleFunctionAsArument(fileGraph)
		
		-- preindexovanie uzlov a hran v grafe
		reindex(fileGraph)

		-- zapisanie hran a uzlov do dvoch CSV suborov
		-- createCSV(fileGraph, path, fileNode.data.name)

		fileGraph._filename = fileNode.data.name
		fileGraph._path = fileNode.data.path
		fileGraph._isTest = string.find(string.lower(fileNode.data.path), "/test", nil, true) ~= nil
		fileGraph._isSpec = string.find(string.lower(fileNode.data.path), "/spec", nil, true) ~= nil
		
		local file = io.open(fileGraph._path, "r")
		firstLine = file:read()
		fileGraph._isShebang = string.sub(firstLine, 0, 2) == "#!"
		io.close(file)
		
		saveTableAsJSON(fileGraph, path, fileNode.data.name)
	end
end


--[[ VYPNUTIE DEBUGGERA
lrdb.deactivate()
--]]