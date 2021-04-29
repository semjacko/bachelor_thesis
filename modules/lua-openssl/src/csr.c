#include "openssl.h"

static int openssl_csr_tostring(lua_State*L);
static int openssl_csr_free(lua_State*L);
static int openssl_csr_get_public(lua_State*L);


LUA_FUNCTION(openssl_csr_parse);
LUA_FUNCTION(openssl_csr_export);
LUA_FUNCTION(openssl_csr_sign);

static luaL_reg csr_cfuns[] = {
	{"export",			openssl_csr_export	},
	{"parse",			openssl_csr_parse	},
	{"sign",			openssl_csr_sign	},
	{"get_public",		openssl_csr_get_public	},

	{"__tostring",		openssl_csr_tostring	},
	{"__gc",			openssl_csr_free	},

	{NULL,				NULL	}
};



static X509_EXTENSION *do_ext_i2d(const X509V3_EXT_METHOD *method, int ext_nid,
								  int crit, void *ext_struc)
{
	unsigned char *ext_der;
	int ext_len;
	ASN1_OCTET_STRING *ext_oct;
	X509_EXTENSION *ext;
	/* Convert internal representation to DER */
	if (method->it)
	{
		ext_der = NULL;
		ext_len = ASN1_item_i2d(ext_struc, &ext_der, ASN1_ITEM_ptr(method->it));
		if (ext_len < 0) goto merr;
	}
	else
	{
		unsigned char *p;
		ext_len = method->i2d(ext_struc, NULL);
		if(!(ext_der = OPENSSL_malloc(ext_len))) goto merr;
		p = ext_der;
		method->i2d(ext_struc, &p);
	}
	if (!(ext_oct = M_ASN1_OCTET_STRING_new())) goto merr;
	ext_oct->data = ext_der;
	ext_oct->length = ext_len;

	ext = X509_EXTENSION_create_by_NID(NULL, ext_nid, crit, ext_oct);
	if (!ext) goto merr;
	M_ASN1_OCTET_STRING_free(ext_oct);

	return ext;

merr:
	X509V3err(X509V3_F_DO_EXT_I2D,ERR_R_MALLOC_FAILURE);
	return NULL;

}  


/* Check the extension string for critical flag */
static int v3_check_critical(char **value)
{
	char *p = *value;
	if ((strlen(p) < 9) || strncmp(p, "critical,", 9)) return 0;
	p+=9;
	while(isspace((unsigned char)*p)) p++;
	*value = p;
	return 1;
}

static int v3_check_generic(char **value)
{
	int gen_type = 0;
	char *p = *value;
	if ((strlen(p) >= 4) && !strncmp(p, "DER:", 4))
	{
		p+=4;
		gen_type = 1;
	}
	else if ((strlen(p) >= 5) && !strncmp(p, "ASN1:", 5))
	{
		p+=5;
		gen_type = 2;
	}
	else
		return 0;

	while (isspace((unsigned char)*p)) p++;
	*value = p;
	return gen_type;
}


static unsigned char *generic_asn1(char *value, X509V3_CTX *ctx, long *ext_len)
{
	ASN1_TYPE *typ;
	unsigned char *ext_der = NULL;
	typ = ASN1_generate_v3(value, ctx);
	if (typ == NULL)
		return NULL;
	*ext_len = i2d_ASN1_TYPE(typ, &ext_der);
	ASN1_TYPE_free(typ);
	return ext_der;
}

/* Create a generic extension: for now just handle DER type */
static X509_EXTENSION *v3_generic_extension(ASN1_OBJECT *obj, char *value,
											int crit, int gen_type,
											X509V3_CTX *ctx)
{
	unsigned char *ext_der=NULL;
	long ext_len;
	ASN1_OCTET_STRING *oct=NULL;
	X509_EXTENSION *extension=NULL;

	if (gen_type == 1)
		ext_der = string_to_hex(value, &ext_len);
	else if (gen_type == 2)
		ext_der = generic_asn1(value, ctx, &ext_len);

	if (ext_der == NULL)
	{
		X509V3err(X509V3_F_V3_GENERIC_EXTENSION,X509V3_R_EXTENSION_VALUE_ERROR);
		ERR_add_error_data(2, "value=", value);
		goto err;
	}

	if (!(oct = M_ASN1_OCTET_STRING_new()))
	{
		X509V3err(X509V3_F_V3_GENERIC_EXTENSION,ERR_R_MALLOC_FAILURE);
		goto err;
	}

	oct->data = ext_der;
	oct->length = ext_len;
	ext_der = NULL;

	extension = X509_EXTENSION_create_by_OBJ(NULL, obj, crit, oct);

err:
	ASN1_OBJECT_free(obj);
	M_ASN1_OCTET_STRING_free(oct);
	if(ext_der) OPENSSL_free(ext_der);
	return extension;
}


static X509_EXTENSION *do_ext_nconf(X509V3_CTX *ctx, int ext_nid,
									int crit, char *value)
{
#if OPENSSL_VERSION_NUMBER > 0x10000000L
	const X509V3_EXT_METHOD *method;
#else
	X509V3_EXT_METHOD *method;
#endif
	X509_EXTENSION *ext;
	STACK_OF(CONF_VALUE) *nval;
	void *ext_struc;
	if (ext_nid == NID_undef)
	{
		X509V3err(X509V3_F_DO_EXT_NCONF,X509V3_R_UNKNOWN_EXTENSION_NAME);
		return NULL;
	}
	if (!(method = X509V3_EXT_get_nid(ext_nid)))
	{
		X509V3err(X509V3_F_DO_EXT_NCONF,X509V3_R_UNKNOWN_EXTENSION);
		return NULL;
	}
	/* Now get internal extension representation based on type */
	if (method->v2i)
	{
		nval = X509V3_parse_list(value);
		if(sk_CONF_VALUE_num(nval) <= 0)
		{
			X509V3err(X509V3_F_DO_EXT_NCONF,X509V3_R_INVALID_EXTENSION_STRING);
			ERR_add_error_data(4, "name=", OBJ_nid2sn(ext_nid), ",section=", value);
			return NULL;
		}
		ext_struc = method->v2i(method, ctx, nval);
		sk_CONF_VALUE_pop_free(nval, X509V3_conf_free);
		if(!ext_struc) return NULL;
	}
	else if(method->s2i)
	{
		if(!(ext_struc = method->s2i(method, ctx, value))) return NULL;
	}
	else if(method->r2i)
	{
		if(!ctx->db || !ctx->db_meth)
		{
			X509V3err(X509V3_F_DO_EXT_NCONF,X509V3_R_NO_CONFIG_DATABASE);
			return NULL;
		}
		if(!(ext_struc = method->r2i(method, ctx, value))) return NULL;
	}
	else
	{
		X509V3err(X509V3_F_DO_EXT_NCONF,X509V3_R_EXTENSION_SETTING_NOT_SUPPORTED);
		ERR_add_error_data(2, "name=", OBJ_nid2sn(ext_nid));
		return NULL;
	}

	ext  = do_ext_i2d(method, ext_nid, crit, ext_struc);
	if(method->it) ASN1_item_free(ext_struc, ASN1_ITEM_ptr(method->it));
	else method->ext_free(ext_struc);
	return ext;

}


/* {{{ x509 CSR functions */

/* {{{ openssl_make_REQ */
static int openssl_make_REQ(lua_State*L, 
							X509_REQ * csr,
							EVP_PKEY *pkey, 
							int dn, 
							int attribs,
							int extensions)
{
	/* setup the version number: version 1 */
	if (X509_REQ_set_version(csr, 0L)) {
		X509_NAME * subj;
		
		subj = X509_REQ_get_subject_name(csr);
		/* apply values from the dn hash */

		/* table is in the stack at index 't' */
		lua_pushnil(L);  /* first key */
		while (lua_next(L, dn) != 0) {
			/* uses 'key' (at index -2) and 'value' (at index -1) */
			/* 
			printf("%s - %s\n", lua_typename(L, lua_type(L, -2)), lua_typename(L, lua_type(L, -1)));
			*/
			const char * strindex = lua_tostring(L,-2); 
			const char * strval = lua_tostring(L,-1); 

			if (strindex) {
				int nid = OBJ_txt2nid(strindex);
				if (nid != NID_undef) {
					if (!X509_NAME_add_entry_by_NID(subj, nid, MBSTRING_ASC, (unsigned char*)strval, -1, -1, 0))
					{
						luaL_error(L, "dn: add_entry_by_NID %d(%s) -> %s (failed)", nid, strindex, strval);
					}
				} else {
					luaL_error(L, "dn: %s is not a recognized name", strindex);
				}
			}
			/* removes 'value'; keeps 'key' for next iteration */
			lua_pop(L, 1);
		}

		if (attribs) {
			/* table is in the stack at index 't' */
			lua_pushnil(L);  /* first key */
			while (lua_next(L, attribs) != 0) {
				/* uses 'key' (at index -2) and 'value' (at index -1) */
				/* 
				printf("%s - %s\n", lua_typename(L, lua_type(L, -2)), lua_typename(L, lua_type(L, -1)));
				*/
				int vall = 0;
				const char * strindex = lua_tostring(L,-2); 
				const char * val = luaL_checklstring(L,-1,&vall); 

				if (strindex) {
					int nid = OBJ_txt2nid(strindex);
					if (nid != NID_undef) {
						if (!X509_REQ_add1_attr_by_NID(csr,nid,MBSTRING_ASC,val,vall)) {
							luaL_error(L, "attribs: X509_REQ_add1_attr %s -> %s (failed)", strindex, val);
							return -1;
						}
					} else {
						luaL_error(L, "attribs: %s is not a recognized name", strindex);
					}
				}

				/* removes 'value'; keeps 'key' for next iteration */
				lua_pop(L, 1);
			}
		}

		if(extensions) {
			/* Check syntax of file */
			X509V3_CTX ctx;
			STACK_OF(X509_EXTENSION) *exts = sk_X509_EXTENSION_new_null();
			X509V3_set_ctx_test(&ctx);

			lua_pushnil(L);  /* first key */
			while (lua_next(L, extensions) != 0) {
				/* uses 'key' (at index -2) and 'value' (at index -1) */
				/* 
				printf("%s - %s\n", lua_typename(L, lua_type(L, -2)), lua_typename(L, lua_type(L, -1)));
				*/
				int vall = 0;
				const char * key = lua_tostring(L,-2);
				char* val = (char*)lua_tostring(L,-1);
				int nid = OBJ_txt2nid(key);

				if (nid != NID_undef) {
					const X509V3_EXT_METHOD *method = X509V3_EXT_get_nid(nid);
					int crit = v3_check_critical(&val);
					int ext_type = v3_check_generic(&val);
					X509_EXTENSION *ret;
					ASN1_OBJECT * obj = OBJ_nid2obj(nid);
					if (!obj)
					{
						X509V3err(X509V3_F_V3_GENERIC_EXTENSION,X509V3_R_EXTENSION_NAME_ERROR);
						luaL_error(L, "OBJ_nid2obj(%s) failed");
					}

					if (ext_type) 
						ret = v3_generic_extension(obj, val, crit, ext_type, &ctx);
					else
						ret = do_ext_nconf(&ctx, nid, crit, val);
					if (!ret)
					{
						X509V3err(X509V3_F_X509V3_EXT_NCONF,X509V3_R_ERROR_IN_EXTENSION);
						ERR_add_error_data(4,"name=", key, ", value=", val);
					}
					else
						X509v3_add_ext(&exts, ret, -1);
				} else {
					luaL_error(L, "extensions: %s is not a recognized name", key);
				}

				/* removes 'value'; keeps 'key' for next iteration */
				lua_pop(L, 1);
			}
			X509_REQ_add_extensions(csr, exts);
			sk_X509_EXTENSION_pop_free(exts,X509_EXTENSION_free);
		}
	}

	X509_REQ_set_pubkey(csr, pkey);
	return 0;
}

/* }}} */

/* {{{ openssl.csr_read(string data)->openssl.x509_req */


int openssl_csr_read(lua_State*L)
{
	X509_REQ * csr = NULL;
	char * filename = NULL;
	BIO * in = NULL;
	int dlen;
	const char*data;

	data = luaL_checklstring(L,1,&dlen);

	in = BIO_new_mem_buf((void*)data, dlen);
	if (in == NULL) {
		return 0;
	}
	csr = PEM_read_bio_X509_REQ(in, NULL,NULL,NULL);
	if(!csr)
	{
		BIO_reset(in);
		csr = d2i_X509_REQ_bio(in,NULL);
	}
	BIO_free(in);

	if(csr)
	{
		PUSH_OBJECT(csr,"openssl.x509_req");
		return 1;
	}

	return 0;
}
/* }}} */

/* {{{ proto string openssl_csr_export(resource csr [, boolean pem [,bool notext=true]])
   Exports a CSR to a var */
LUA_FUNCTION(openssl_csr_export)
{
	X509_REQ * csr = CHECK_OBJECT(1,X509_REQ,"openssl.x509_req");
	int pem, notext;
	BIO * bio_out;
	int top = lua_gettop(L);
	
	pem = lua_gettop(L)>1 ? lua_toboolean(L,2) : 1;
	notext = (pem && top>2) ? lua_toboolean(L,3) : 1;

	bio_out = BIO_new(BIO_s_mem());
	if(pem)
	{
		if (!notext) {
			X509_REQ_print(bio_out, csr);
		}

		if (PEM_write_bio_X509_REQ(bio_out, csr)) {
			BUF_MEM *bio_buf;

			BIO_get_mem_ptr(bio_out, &bio_buf);
			lua_pushlstring(L,bio_buf->data, bio_buf->length);
		}else
		{
			lua_pushnil(L);
		}
	}else
	{
		if(i2d_X509_REQ_bio(bio_out, csr)) {
			BUF_MEM *bio_buf;

			BIO_get_mem_ptr(bio_out, &bio_buf);
			lua_pushlstring(L,bio_buf->data, bio_buf->length);
		}else
		{
			lua_pushnil(L);
		}
	}
	BIO_free(bio_out);
	return 1;
}
/* }}} */

int openssl_conf_load_idx(lua_State*L, int idx);
/* {{{ proto resource openssl_csr_sign(obj csr, obj x509, obj priv_key [,table args = {serialNumber=...,num_days=...,...}][,string group])
   Signs a cert with another CERT */
LUA_FUNCTION(openssl_csr_sign)
{
	long serial = 0L;
	X509 * cert = NULL, *new_cert = NULL;
	X509_REQ * csr;
	BIGNUM *bn = NULL;
	EVP_PKEY * key = NULL, *priv_key = NULL;
	int i;
	int ret = 0;
	int dn, digest, num_days;

	csr = CHECK_OBJECT(1,X509_REQ,"openssl.x509_req");
	cert = lua_isnil(L,2) ? NULL: CHECK_OBJECT(2,X509,"openssl.x509");
	priv_key = CHECK_OBJECT(3,EVP_PKEY,"openssl.evp_pkey");

	luaL_checktype(L,4,LUA_TTABLE);
	dn = digest = 0;

	lua_getfield(L, 4, "serialNumber");
	if(lua_isnil(L,-1))
		luaL_error(L,"paramater #4 must have serialNumber key and value must be string or number type");

	BN_dec2bn(&bn,lua_tostring(L,-1));
	BN_set_negative(bn,0);
	lua_pop(L, 1);
		

	lua_getfield(L, 4, "digest");
	if(lua_isstring(L, -1) || auxiliar_isclass(L,"openssl.evp_digest", -1))
	{
		digest = lua_gettop(L);
	}else if(!lua_isnoneornil(L, -1))
		luaL_error(L, "paramater #4 if have digest key, it's value must be string type or openssl.evp_digest object");

	lua_getfield(L,4, "num_days");
	if(lua_isnoneornil(L,-1))
		luaL_error(L, "paramater #4 must have num_days key and value must be number");
	else
		num_days = luaL_checkint(L, -1);

	if (cert && !X509_check_private_key(cert, priv_key)) {
		luaL_error(L,"private key does not correspond to signing cert");
	}
	
	/* Check that the request matches the signature */
	key = X509_REQ_get_pubkey(csr);
	if (key == NULL) {
		luaL_error(L,"error unpacking public key");
		goto cleanup;
	}
	i = X509_REQ_verify(csr, key);

	if (i < 0) {
		luaL_error(L,"Signature verification problems");
		goto cleanup;
	}
	else if (i == 0) {
		luaL_error(L,"Signature did not match the certificate request");
		goto cleanup;
	}
	
	/* Now we can get on with it */
	// 1)
	new_cert = X509_new();
	if (new_cert == NULL) {
		luaL_error(L, "No memory");
		goto cleanup;
	}
	// 2)
	/* Version 3 cert */
	lua_getfield(L, 4,"version");
	if (lua_isnil(L,-1)) {
		if (!X509_set_version(new_cert, 2))
			goto cleanup;
	}else{
		if (!X509_set_version(new_cert, lua_tointeger(L,-1)))
			goto cleanup;
	}
	lua_pop(L,1);

	// 3)
	X509_set_serialNumber(new_cert, BN_to_ASN1_INTEGER(bn,X509_get_serialNumber(new_cert)));
	// 4)
	if (cert == NULL) {
		cert = new_cert;
	}
	if (!X509_set_issuer_name(new_cert, X509_get_subject_name(cert))) {
		goto cleanup;
	}
	X509_set_subject_name(new_cert, X509_REQ_get_subject_name(csr));

	// 5
	X509_gmtime_adj(X509_get_notBefore(new_cert), 0);
#if OPENSSL_VERSION_NUMBER > 0x10000002L 
	if (!X509_time_adj_ex(X509_get_notAfter(new_cert), num_days, 0, NULL)) 
		goto cleanup;
#else
	X509_gmtime_adj(X509_get_notAfter(new_cert), (long)60*60*24*num_days);
#endif

	//6
	if (!X509_set_pubkey(new_cert, key)) {
		goto cleanup;
	}

	//
	lua_getfield(L, 4, "extentions");
	if ( lua_isnil (L, -1) ) {
		new_cert->cert_info->extensions = X509_REQ_get_extensions(csr);
	}
	else{
		X509V3_CTX ctx;
		LHASH* conf = NULL;
		const char* group = luaL_checkstring(L, 5);

		X509V3_set_ctx(&ctx, cert, new_cert, csr, NULL, 0);

		if(openssl_conf_load_idx(L,-1)==1)
		{
			conf = CHECK_OBJECT(-1,LHASH,"openssl.conf");
			lua_pop(L,1);
		}else
		{
			luaL_error(L,"load openssl config object failed");
		}

		X509V3_set_conf_lhash(&ctx, conf);
		if (!X509V3_EXT_add_conf(conf, &ctx, (char*)group, new_cert)) 
		{
			goto cleanup;
		}
			
	}
	lua_pop(L,1);

	/* Now sign it */
	{
		const EVP_MD* md = NULL;
		if (lua_isuserdata(L,digest)) {
			md = CHECK_OBJECT(digest,EVP_MD,"openssl.evp_digest");
		}
		else if(lua_isstring(L,digest)) {
			md = EVP_get_digestbyname(luaL_checkstring(L,digest));
			if(!md) luaL_error(L,"EVP_get_digestbyname(%s) failed",luaL_checkstring(L,digest));
		}else
			md = EVP_get_digestbyname("sha1WithRSAEncryption");


		if (!X509_sign(new_cert, priv_key, md)) {
			luaL_error(L,"failed to sign it");
			goto cleanup;
		}

	}

	/* Succeeded; lets return the cert */
	PUSH_OBJECT(new_cert,"openssl.x509");
	ret = 1;

	new_cert = NULL;
	
cleanup:

	if (cert == new_cert) {
		cert = NULL;
	}

	return ret;
}
/* }}} */

/* {{{openssl.csr_new(openssl.evp_pkey pkey, table dn, [ arg = {[, table extraattribs, [table config [,string md|openssl.evp_digest md]] }]  ) = >openssl.x509_req
   Generates CSR with gived private key, dn, and extraattribs */
LUA_FUNCTION(openssl_csr_new)
{
	X509_REQ *csr = NULL;

	EVP_PKEY *pkey = CHECK_OBJECT(1, EVP_PKEY, "openssl.evp_pkey");
	int dn, attribs, extentions, digest;

	luaL_checktype(L, 2, LUA_TTABLE);
	luaL_checktype(L, 3, LUA_TTABLE);
	dn = 2;
	attribs = extentions = digest = 0;

	lua_getfield(L,3, "digest");
	if(lua_isstring(L, -1) || auxiliar_isclass(L,"openssl.evp_digest", -1))
	{
		digest = lua_gettop(L);
	}else if(!lua_isnoneornil(L, -1))
		luaL_error(L, "paramater #3 if have digest key, it's value must be string type or openssl.evp_digest object");


	lua_getfield(L,3,"attribs");
	if (lua_isnil(L,-1)) {
		attribs = 0;
		lua_pop(L,1);
	}else{
		luaL_checktype(L, -1, LUA_TTABLE);
		attribs = lua_gettop(L);
	}

	lua_getfield(L,3, "extentions");
	if (lua_isnil(L, -1)) {
		extentions = 0;
		lua_pop(L,1);
	}else {
		luaL_checktype(L, -1, LUA_TTABLE);
		extentions = lua_gettop(L);
	}
	
	csr = X509_REQ_new();
	if(!csr) luaL_error(L,"out of memory!");

	if (openssl_make_REQ(L, csr, pkey, dn, attribs, extentions) == 0) {
		const EVP_MD* md = NULL;
		if (lua_isuserdata(L,digest)) {
			md = CHECK_OBJECT(digest,EVP_MD,"openssl.evp_digest");
		}
		else if(lua_isstring(L,digest)) {
			md = EVP_get_digestbyname(luaL_checkstring(L,digest));
			if(!md) luaL_error(L,"EVP_get_digestbyname(%s) failed",luaL_checkstring(L,digest));
		}else
			md = EVP_get_digestbyname("sha1WithRSAEncryption");

		if (X509_REQ_sign(csr, pkey, md)) {
			PUSH_OBJECT(csr,"openssl.x509_req");
		} else {
			luaL_error(L,"Error signing request");
		}
	}

	return 1;
}
/* }}} */

/* {{{ csr.parse(openssl.x509_req csr, boolean shortname)=>table 
   Returns the table that contains all infomration about x509_req */
LUA_FUNCTION(openssl_csr_parse)
{
	X509_REQ * csr = CHECK_OBJECT(1,X509_REQ,"openssl.x509_req");
	int  shortnames = lua_gettop(L)==1?1:lua_toboolean(L,2);

	X509_NAME * subject = X509_REQ_get_subject_name(csr);
	EVP_PKEY* pubkey=X509_REQ_get_pubkey(csr);
	STACK_OF(X509_EXTENSION) *exts  = X509_REQ_get_extensions(csr);
	STACK_OF(X509_ATTRIBUTE) *attrs = csr->req_info->attributes;
	BIO* out = BIO_new(BIO_s_mem());
	char *name = NULL;
	BUF_MEM *buf = NULL;

	lua_newtable(L);
	add_assoc_int(L,"version",ASN1_INTEGER_get(csr->req_info->version));
	add_assoc_name_entry(L, "subject", subject, shortnames);


	{
		X509_REQ_INFO* ri=csr->req_info;
		lua_newtable(L);
		

		ADD_ASSOC_ASN1(ASN1_OBJECT, out,ri->pubkey->algor->algorithm, "algorithm");

		/*
		i2a_ASN1_OBJECT(out,ri->pubkey->algor->algorithm);
		ASSOC_BIO("algorithm");
		*/

		PUSH_OBJECT(pubkey,"openssl.evp_pkey");
		lua_insert(L,1);
		openssl_pkey_parse(L);
		lua_setfield(L,-2,"pubkey");
		lua_remove(L,1);

		lua_setfield(L,-2,"pubkey");
	}

	if(attrs && X509at_get_attr_count(attrs))
	{
		int i, attr_nid;

		lua_newtable(L);

		for (i=0; i< X509at_get_attr_count(attrs); i++) {
			X509_ATTRIBUTE *attr = X509at_get_attr(attrs,i);
			ASN1_TYPE *av;
#if 0
			{
				char* dat = NULL;
				int i = i2d_X509_ATTRIBUTE(attr,&dat);
				if(i>0) {
					lua_pushlstring(L,dat,i);
					OPENSSL_free(dat);
				}else
					lua_pushnil(L);

				lua_rawseti(L,-2,i+1);

			}
#else
			lua_newtable(L);

			if(attr->single)
			{
				lua_pushinteger(L,attr->value.single->type);
				lua_setfield(L,-2,"type");
				lua_pushlstring(L,attr->value.single->value.bit_string->data,attr->value.single->value.bit_string->length);
				lua_setfield(L,-2,"bit_string");
			}else
			{
				attr_nid = OBJ_obj2nid(attr->object);
				if(attr_nid == NID_undef) {
					ADD_ASSOC_ASN1(ASN1_OBJECT, out,attr->object, "object");
					name = NULL;
				} else 
					name  = shortnames ? (char*)OBJ_nid2sn(attr_nid) : (char*)OBJ_nid2ln(attr_nid) ;

				if(sk_ASN1_TYPE_num(attr->value.set)) {
					av = sk_ASN1_TYPE_value(attr->value.set, 0);
					switch(av->type) {
				case V_ASN1_BMPSTRING:
					{
#if OPENSSL_VERSION_NUMBER > 0x10000000L
						char *value = OPENSSL_uni2asc(av->value.bmpstring->data,av->value.bmpstring->length);
						add_assoc_string(L, name?name:"bmpstring", value,1);
						OPENSSL_free(value);
#else
						lua_pushlstring(L,av->value.bmpstring->data,av->value.bmpstring->length);
						lua_setfield(L,-2, name?name:"bmpstring");
#endif
					}
					break;

				case V_ASN1_OCTET_STRING:
					lua_pushlstring(L, av->value.octet_string->data, av->value.octet_string->length);
					lua_setfield(L, -2, name?name:"octet_string");
					break;

				case V_ASN1_BIT_STRING:
					lua_pushlstring(L, av->value.bit_string->data, av->value.bit_string->length);
					lua_setfield(L, -2, name?name:"bit_string");
					break;

				default:
					if(name)
						lua_pushstring(L,name);
					else
						lua_pushfstring(L,"tag:%d",av->type);

					{
						unsigned char* dat = NULL;
						int i = i2d_ASN1_TYPE(av,&dat);
						if(i>0) {
							lua_pushlstring(L,dat,i);
							OPENSSL_free(dat);
						}else
							lua_pushnil(L);

					}
					lua_settable(L,-3);
					break;
					}
				}
			}

			lua_rawseti(L,-2,i+1);
#endif
		}
		lua_setfield(L,-2,"attributes");

	} 
	add_assoc_x509_extension(L, "extensions", exts, out);
	BIO_free(out);

	return 1;
}
/* }}} */

/* }}} */

static LUA_FUNCTION(openssl_csr_tostring) {
	X509_REQ *csr = CHECK_OBJECT(1,X509_REQ,"openssl.x509_req");
	lua_pushfstring(L,"openssl.x509_req:%p",csr);
	return 1;
}

static LUA_FUNCTION(openssl_csr_free) {
	X509_REQ *csr = CHECK_OBJECT(1,X509_REQ,"openssl.x509_req");
	X509_REQ_free(csr);
	return 0;
}

static LUA_FUNCTION(openssl_csr_get_public) {
	X509_REQ *csr = CHECK_OBJECT(1,X509_REQ,"openssl.x509_req");
	PUSH_OBJECT(csr->req_info->pubkey,"openssl.evp_pkey");
	return 1;
}

LUA_FUNCTION(openssl_register_csr) {
	auxiliar_newclass(L,"openssl.x509_req", csr_cfuns);
	return 0;
}
