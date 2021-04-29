// ===========================================================================
// Purpose:     wxHtml library
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxHTML && wxUSE_HTML

// ---------------------------------------------------------------------------
// wxHtmlCell

%include "wx/html/htmlcell.h"

%define wxHTML_COND_ISANCHOR
%define wxHTML_COND_ISIMAGEMAP
%define wxHTML_COND_USER

%class %delete wxHtmlCell, wxObject
    wxHtmlCell()

    // %override [bool, int pagebreak] wxHtmlCell::AdjustPagebreak(int pagebreak)

    // %override bool AdjustPagebreak(int pagebreak) // int* known_pagebreaks, int number_of_pages)
    // C++ Func: bool AdjustPagebreak(int pagebreak, int* known_pagebreaks, int number_of_pages)
    %not_overload !%wxchkver_2_8 virtual bool AdjustPagebreak(int pagebreak) // int* known_pagebreaks, int number_of_pages)

    // %override bool AdjustPagebreak(int pagebreak, wxArrayInt& known_pagebreaks)
    // C++ Func: bool AdjustPagebreak(int pagebreak, wxArrayInt& known_pagebreaks)
    %not_overload %wxchkver_2_8 virtual bool AdjustPagebreak(int pagebreak, wxArrayInt& known_pagebreaks)

    //virtual void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo& info)
    //virtual void DrawInvisible(wxDC& dc, int x, int y, wxHtmlRenderingInfo& info)

    // %override wxHtmlCell* wxHtmlCell::Find(int condition, [none, string, or int])
    // C++ Func: virtual const wxHtmlCell* Find(int condition, void *param = 0)
    virtual const wxHtmlCell* Find(int condition, void *param = 0)

    int GetDescent() const
    wxHtmlCell* GetFirstChild()
    int GetHeight() const
    virtual wxString GetId() const
    virtual wxHtmlLinkInfo* GetLink(int x = 0, int y = 0) const
    wxHtmlCell* GetNext() const
    wxHtmlContainerCell* GetParent() const
    int GetPosX() const
    int GetPosY() const
    int GetWidth() const
    virtual void Layout(int w)
    //virtual void OnMouseClick(wxWindow* parent, int x, int y, const wxMouseEvent& event)
    void SetId(const wxString& id)
    void SetLink(const wxHtmlLinkInfo& link)
    void SetNext(wxHtmlCell *cell)
    void SetParent(wxHtmlContainerCell *p)
    void SetPos(int x, int y)
%endclass

// ---------------------------------------------------------------------------
// wxHtmlWidgetCell

%include "wx/html/htmlcell.h"

%class wxHtmlWidgetCell, wxHtmlCell
    wxHtmlWidgetCell(wxWindow* wnd, int w = 0)
%endclass


// ---------------------------------------------------------------------------
// wxHtmlContainerCell

%include "wx/html/htmlcell.h"

%define wxHTML_UNITS_PIXELS
%define wxHTML_UNITS_PERCENT
%define wxHTML_INDENT_TOP
%define wxHTML_INDENT_BOTTOM
%define wxHTML_INDENT_LEFT
%define wxHTML_INDENT_RIGHT
%define wxHTML_INDENT_HORIZONTAL
%define wxHTML_INDENT_VERTICAL
%define wxHTML_INDENT_ALL
%define wxHTML_ALIGN_LEFT
%define wxHTML_ALIGN_JUSTIFY
%define wxHTML_ALIGN_CENTER
%define wxHTML_ALIGN_RIGHT
%define wxHTML_ALIGN_BOTTOM
%define wxHTML_ALIGN_TOP

%class wxHtmlContainerCell, wxHtmlCell
    wxHtmlContainerCell(wxHtmlContainerCell *parent)

    int GetAlignHor() const
    int GetAlignVer() const
    wxColour GetBackgroundColour()
    int GetIndent(int ind) const
    int GetIndentUnits(int ind) const
    void InsertCell(wxHtmlCell *cell)
    void SetAlign(const wxHtmlTag& tag)
    void SetAlignHor(int al)
    void SetAlignVer(int al)
    void SetBackgroundColour(const wxColour& clr)
    void SetBorder(const wxColour& clr1, const wxColour& clr2)
    void SetIndent(int i, int what, int units = wxHTML_UNITS_PIXELS)
    void SetMinHeight(int h, int align = wxHTML_ALIGN_TOP)
    void SetWidthFloat(int w, int units)
    void SetWidthFloat(const wxHtmlTag& tag, double pixel_scale = 1.0)

    // %wxchkver_2_6 wxHtmlCell* GetFirstChild() see wxHtmlCell
    // !%wxchkver_2_6 wxHtmlCell* GetFirstCell() - nobody probably uses this
%endclass

// ---------------------------------------------------------------------------
// wxHtmlColourCell

%if %wxchkver_2_8

%include "wx/html/htmlcell.h"

%class wxHtmlColourCell, wxHtmlCell
    wxHtmlColourCell(const wxColour& clr, int flags = wxHTML_CLR_FOREGROUND)

    //virtual void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo& info);
    //virtual void DrawInvisible(wxDC& dc, int x, int y, wxHtmlRenderingInfo& info);
%endclass

%endif // %wxchkver_2_8

// ---------------------------------------------------------------------------
// wxHtmlFontCell

%if %wxchkver_2_8

%include "wx/html/htmlcell.h"

%class wxHtmlFontCell, wxHtmlCell
    wxHtmlFontCell(wxFont *font)

    //virtual void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo& info);
    //virtual void DrawInvisible(wxDC& dc, int x, int y, wxHtmlRenderingInfo& info);
%endclass

%endif // %wxchkver_2_8

// ---------------------------------------------------------------------------
// wxHtmlCellEvent

%if %wxchkver_2_8

%include "wx/html/htmlwin.h"

%class %delete wxHtmlCellEvent, wxCommandEvent
    wxHtmlCellEvent()
    wxHtmlCellEvent(wxEventType commandType, int id, wxHtmlCell *cell, const wxPoint &pt, const wxMouseEvent &ev)

    wxHtmlCell* GetCell() const
    wxPoint GetPoint() const
    wxMouseEvent GetMouseEvent() const

    void SetLinkClicked(bool linkclicked)
    bool GetLinkClicked() const
%endclass

%endif // %wxchkver_2_8


// ---------------------------------------------------------------------------
// wxHtmlLinkInfo

%include "wx/html/htmlcell.h"

%class %delete %noclassinfo wxHtmlLinkInfo
    wxHtmlLinkInfo(const wxString& href, const wxString& target = "")

    const wxMouseEvent * GetEvent()
    const wxHtmlCell * GetHtmlCell()
    wxString GetHref()
    wxString GetTarget()
%endclass

// ---------------------------------------------------------------------------
// wxHtmlTag

%include "wx/html/htmltag.h"

%class wxHtmlTag, wxObject
    //wxHtmlTag(const wxString& source, int pos, int end_pos, wxHtmlTagsCache* cache)

    const wxString GetAllParams() const
    int GetBeginPos() const
    int GetEndPos1() const
    int GetEndPos2() const
    wxString GetName() const
    wxString GetParam(const wxString& par, bool with_commas = false) const

    // %override [bool, wxColour] wxHtmlTag::GetParamAsColour(const wxString& par) const
    // C++ Func: bool GetParamAsColour(const wxString& par, wxColour *clr) const
    bool GetParamAsColour(const wxString& par) const

    // %override [bool, int value] wxHtmlTag::GetParamAsInt(const wxString& par) const
    // C++ Func: bool GetParamAsInt(const wxString& par, int *value) const
    bool GetParamAsInt(const wxString& par) const

    bool HasEnding() const
    bool HasParam(const wxString& par) const
    //bool IsEnding() const
    //wxString ScanParam(const wxString& par, const wxString &format, void *value) const
%endclass

// ---------------------------------------------------------------------------
// wxHtmlWindow

%include "wx/wxhtml.h"

%define wxHW_SCROLLBAR_NEVER
%define wxHW_SCROLLBAR_AUTO

%class wxHtmlWindow, wxScrolledWindow
    wxHtmlWindow(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHW_SCROLLBAR_AUTO, const wxString& name = "wxHtmlWindow")

    //static void AddFilter(wxHtmlFilter *filter)
    bool AppendToPage(const wxString& source)
    wxHtmlContainerCell* GetInternalRepresentation() const
    wxString GetOpenedAnchor()
    wxString GetOpenedPage()
    wxString GetOpenedPageTitle()
    wxFrame* GetRelatedFrame() const
    bool HistoryBack()
    bool HistoryCanBack()
    bool HistoryCanForward()
    void HistoryClear()
    bool HistoryForward()
    virtual bool LoadFile(const wxFileName& filename)
    bool LoadPage(const wxString& location)
    void ReadCustomization(wxConfigBase *cfg, wxString path = wxEmptyString)
    void SelectAll()
    wxString SelectionToText()
    void SelectLine(const wxPoint& pos)
    void SelectWord(const wxPoint& pos)
    void SetBorders(int b)

    // %override void wxHtmlWindow::SetFonts(wxString normal_face, wxString fixed_face, Lua int table)
    // C++ Func: void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes)
    void SetFonts(wxString normal_face, wxString fixed_face, LuaTable intTable)

    bool SetPage(const wxString& source)
    void SetRelatedFrame(wxFrame* frame, const wxString& format)
    void SetRelatedStatusBar(int bar)
    wxString ToText()
    void WriteCustomization(wxConfigBase *cfg, wxString path = wxEmptyString)
%endclass


// ---------------------------------------------------------------------------
// wxLuaHtmlWindow

%if wxLUA_USE_wxLuaHtmlWindow

%include "wxbind/include/wxhtml_wxlhtml.h"

%class wxLuaHtmlWindow, wxHtmlWindow
    wxLuaHtmlWindow(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHW_SCROLLBAR_AUTO, const wxString& name = "wxLuaHtmlWindow")

    // The functions below are all virtual functions that you can override in Lua.
    // See the html sample and wxHtmlWindow for proper parameters and usage.
    //bool OnCellClicked(wxHtmlCell *cell, wxCoord x, wxCoord y, const wxMouseEvent& event)
    //void OnCellMouseHover(wxHtmlCell *cell, wxCoord x, wxCoord y)
    //void OnLinkClicked(const wxHtmlLinkInfo& link)
    //void OnSetTitle(const wxString& title)

%endclass

// ---------------------------------------------------------------------------
// wxLuaHtmlWinTagEvent

%class %delete wxLuaHtmlWinTagEvent, wxEvent
    %define_event wxEVT_HTML_TAG_HANDLER // EVT_HTML_TAG_HANDLER(id, fn)

    const wxHtmlTag      *GetHtmlTag() const
    wxHtmlWinParser      *GetHtmlParser() const
    void                  SetParseInnerCalled(bool fParseInnerCalled = true)
    bool                  GetParseInnerCalled() const
%endclass

%endif //wxLUA_USE_wxLuaHtmlWindow


// ---------------------------------------------------------------------------
// wxHtmlParser

//%enum wxHtmlURLType
//    wxHTML_URL_PAGE
//    wxHTML_URL_IMAGE
//    wxHTML_URL_OTHER
//%endenum

%class wxHtmlParser, wxObject
    //wxHtmlParser()

    //void AddTag(const wxHtmlTag& tag)
    //void AddTagHandler(wxHtmlTagHandler *handler)
    //void AddWord(const wxString &txt) - not in 2.6?
    void DoParsing(int begin_pos, int end_pos)
    void DoParsing()
    virtual void DoneParser()
    //virtual wxObject* GetProduct()
    //wxString* GetSource()
    void InitParser(const wxString& source)
    //virtual wxFSFile* OpenURL(wxHtmlURLType type, const wxString& url)
    //wxObject* Parse(const wxString& source)
    //void PushTagHandler(wxHtmlTagHandler* handler, wxString tags)
    //void PopTagHandler()
    //void SetFS(wxFileSystem *fs)
    //void StopParsing()
%endclass

// ---------------------------------------------------------------------------
// wxHtmlWinParser

%class wxHtmlWinParser, wxHtmlParser
    wxHtmlWinParser(wxHtmlWindow *wnd)

    wxHtmlContainerCell* CloseContainer()
    wxFont* CreateCurrentFont()
    wxColour GetActualColor() const
    int GetAlign() const
    int GetCharHeight() const
    int GetCharWidth() const
    wxHtmlContainerCell* GetContainer() const
    wxDC* GetDC()
    //wxEncodingConverter * GetEncodingConverter() const
    int GetFontBold() const
    wxString GetFontFace() const
    int GetFontFixed() const
    int GetFontItalic() const
    int GetFontSize() const
    int GetFontUnderlined() const
    //wxFontEncoding GetInputEncoding() const
    const wxHtmlLinkInfo& GetLink() const
    wxColour GetLinkColor() const
    //wxFontEncoding GetOutputEncoding() const
    %wxchkver_2_8 wxHtmlWindowInterface *GetWindowInterface()
    !%wxchkver_2_8 wxWindow* GetWindow()
    wxHtmlContainerCell* OpenContainer()
    void SetActualColor(const wxColour& clr)
    void SetAlign(int a)
    wxHtmlContainerCell* SetContainer(wxHtmlContainerCell *c)
    void SetDC(wxDC *dc, double pixel_scale = 1.0)
    void SetFontBold(int x)
    void SetFontFace(const wxString& face)
    void SetFontFixed(int x)
    void SetFontItalic(int x)
    void SetFontSize(int s)
    void SetFontUnderlined(int x)

    // %override void wxHtmlWinParser::SetFonts(wxString normal_face, wxString fixed_face, Lua int table)
    // C++ Func: void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes)
    void SetFonts(wxString normal_face, wxString fixed_face, LuaTable intTable)

    void SetLink(const wxHtmlLinkInfo& link)
    void SetLinkColor(const wxColour& clr)
%endclass

// ---------------------------------------------------------------------------
// wxHtmlWindowInterface

%if %wxchkver_2_8

%enum wxHtmlWindowInterface::HTMLCursor
    HTMLCursor_Default
    HTMLCursor_Link
    HTMLCursor_Text
%endenum

%class %noclassinfo wxHtmlWindowInterface

    virtual void SetHTMLWindowTitle(const wxString& title)
    virtual void OnHTMLLinkClicked(const wxHtmlLinkInfo& link)
    //virtual wxHtmlOpeningStatus OnHTMLOpeningURL(wxHtmlURLType type, const wxString& url, wxString *redirect) const
    virtual wxPoint HTMLCoordsToWindow(wxHtmlCell *cell, const wxPoint& pos) const
    virtual wxWindow* GetHTMLWindow()
    virtual wxColour GetHTMLBackgroundColour() const
    virtual void SetHTMLBackgroundColour(const wxColour& clr)
    virtual void SetHTMLBackgroundImage(const wxBitmap& bmpBg)
    virtual void SetHTMLStatusText(const wxString& text)
    virtual wxCursor GetHTMLCursor(wxHtmlWindowInterface::HTMLCursor type) const
%endclass

// ----------------------------------------------------------------------------
// wxSimpleHtmlListBox - Use this instead of having to override virtual functions in wxHtmlListBox

%include "wx/htmllbox.h"

%define wxHLB_DEFAULT_STYLE
%define wxHLB_MULTIPLE

%class wxSimpleHtmlListBox, wxHtmlWindowInterface //: public wxHtmlListBox, public wxItemContainer
    wxSimpleHtmlListBox()
    wxSimpleHtmlListBox(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, const wxArrayString& choices, long style = wxHLB_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxSimpleHtmlListBox")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, const wxArrayString& choices, long style = wxHLB_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxSimpleHtmlListBox")

    void SetSelection(int n)
    int GetSelection() const
    virtual unsigned int GetCount() const
    virtual wxString GetString(unsigned int n) const
    wxArrayString GetStrings() const
    virtual void SetString(unsigned int n, const wxString& s)
    virtual void Clear()
    virtual void Delete(unsigned int n)
    void Append(const wxArrayString& strings)
    int Append(const wxString& item)
    int Append(const wxString& item, voidptr_long number) // C++ is (void *clientData) You can put a number here
    int Append(const wxString& item, wxClientData *clientData)
%endclass

%endif //%wxchkver_2_8

// ---------------------------------------------------------------------------
// wxHtmlDCRenderer

%include "wx/html/htmprint.h"

%class %delete %noclassinfo wxHtmlDCRenderer, wxObject
    wxHtmlDCRenderer()

    void SetDC(wxDC* dc, double pixel_scale = 1.0)
    //void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes = NULL)
    void SetSize(int width, int height)
    void SetHtmlText(const wxString& html, const wxString& basepath = "", bool isdir = true)
    !%wxchkver_2_8 int Render(int x, int y, int from = 0, int dont_render = false) //, int *known_pagebreaks = NULL, int number_of_pages = 0)
    %wxchkver_2_8 int Render(int x, int y, wxArrayInt& known_pagebreaks, int from = 0, int dont_render = false, int to = INT_MAX);
    int GetTotalHeight()
%endclass

// ---------------------------------------------------------------------------
// wxHtmlEasyPrinting

%include "wx/html/htmprint.h"

%class %delete %noclassinfo wxHtmlEasyPrinting, wxObject
    wxHtmlEasyPrinting(const wxString& name = "Printing", wxFrame* parent_frame = NULL)

    bool PreviewFile(const wxString& htmlfile)
    bool PreviewText(const wxString& htmltext, const wxString& basepath = "")
    bool PrintFile(const wxString& htmlfile)
    bool PrintText(const wxString& htmltext, const wxString& basepath = "")
    %wxchkver_2_4&!%wxchkver_2_6 void PrinterSetup()
    void PageSetup()
    //void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes = NULL)
    void SetHeader(const wxString& header, int pg = wxPAGE_ALL)
    void SetFooter(const wxString& footer, int pg = wxPAGE_ALL)
    wxPrintData* GetPrintData()
    wxPageSetupDialogData* GetPageSetupData()
%endclass

// ---------------------------------------------------------------------------
// wxHtmlPrintout

%include "wx/html/htmprint.h"

%class %delete %noclassinfo wxHtmlPrintout, wxPrintout
    wxHtmlPrintout(const wxString& title = "Printout")

    //void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes = NULL)
    void SetFooter(const wxString& footer, int pg = wxPAGE_ALL)
    void SetHeader(const wxString& header, int pg = wxPAGE_ALL)
    void SetHtmlFile(const wxString& htmlfile)
    void SetHtmlText(const wxString& html, const wxString& basepath = "", bool isdir = true)
    void SetMargins(float top = 25.2, float bottom = 25.2, float left = 25.2, float right = 25.2, float spaces = 5)
%endclass

// ---------------------------------------------------------------------------
// wxHtmlHelpData

%if wxLUA_USE_wxHtmlHelpController && wxUSE_WXHTML_HELP

//%if !%wxchkver_2_6|%wxcompat_2_4
//%struct %noclassinfo wxHtmlContentsItem
//    // needs access functions
//%endstruct
//%endif

%include "wx/html/helpdata.h"

//%class %delete %encapsulate %noclassinfo wxHtmlBookRecord
//    wxHtmlBookRecord(const wxString& bookfile, const wxString& basepath, const wxString& title, const wxString& start)
//
//    wxString GetBookFile() const
//    wxString GetTitle() const
//    wxString GetStart() const
//    wxString GetBasePath() const
//    void SetContentsRange(int start, int end)
//    int GetContentsStart() const
//    int GetContentsEnd() const
//
//    void SetTitle(const wxString& title)
//    void SetBasePath(const wxString& path)
//    void SetStart(const wxString& start)
//    wxString GetFullPath(const wxString &page) const;
//%endclass
//
//%class %delete %encapsulate %noclassinfo wxHtmlBookRecArray
//    wxHtmlBookRecArray()
//
//    size_t Add(const wxHtmlBookRecord& book, size_t copies = 1)
//    void Clear()
//    int GetCount() const
//    void Insert(const wxHtmlBookRecord& book, int nIndex, size_t copies = 1)
//    wxHtmlBookRecord Item(size_t nIndex) const
//    void Remove(const wxString &sz)
//    void RemoveAt(size_t nIndex, size_t count = 1)
//%endclass

%class %delete wxHtmlHelpData, wxObject
    wxHtmlHelpData()

    bool AddBook(const wxString& book)
    wxString FindPageById(int id)
    wxString FindPageByName(const wxString& page)
    //wxHtmlBookRecArray GetBookRecArray()
    //wxHtmlHelpDataItems GetContentsArray()
    //wxHtmlHelpDataItems GetIndexArray()
    void SetTempDir(const wxString& path)

    // rem these out to get rid of deprecated warnings
    //!%wxchkver_2_6|%wxcompat_2_4 wxHtmlContentsItem* GetContents()
    //!%wxchkver_2_6|%wxcompat_2_4 int GetContentsCnt()
    //!%wxchkver_2_6|%wxcompat_2_4 wxHtmlContentsItem* GetIndex()
    //!%wxchkver_2_6|%wxcompat_2_4 int GetIndexCnt()
%endclass

// ---------------------------------------------------------------------------
// wxHtmlHelpController

%include "wx/html/helpctrl.h"

%define wxHF_TOOLBAR
%define wxHF_FLAT_TOOLBAR
%define wxHF_CONTENTS
%define wxHF_INDEX
%define wxHF_SEARCH
%define wxHF_BOOKMARKS
%define wxHF_OPEN_FILES
%define wxHF_PRINT
%define wxHF_MERGE_BOOKS
%define wxHF_ICONS_BOOK
%define wxHF_ICONS_FOLDER
%define wxHF_ICONS_BOOK_CHAPTER
%define wxHF_DEFAULT_STYLE

%class %delete wxHtmlHelpController, wxHelpControllerBase
    wxHtmlHelpController(int style = wxHF_DEFAULT_STYLE)

    bool AddBook(const wxString& book, bool show_wait_msg)
    bool AddBook(const wxFileName& book_file, bool show_wait_msg)
    //virtual wxHtmlHelpFrame* CreateHelpFrame(wxHtmlHelpData * data)
    void Display(const wxString& x)
    void Display(const int id)
    //void DisplayContents() - see wxHelpControllerBase
    void DisplayIndex()
    // bool KeywordSearch(const wxString& keyword, wxHelpSearchMode mode = wxHELP_SEARCH_ALL) // see base
    void ReadCustomization(wxConfigBase* cfg, wxString path = "")
    void SetTempDir(const wxString& path)
    void SetTitleFormat(const wxString& format)
    void UseConfig(wxConfigBase* config, const wxString& rootpath = "")
    void WriteCustomization(wxConfigBase* cfg, wxString path = "")
%endclass

%endif //wxLUA_USE_wxHtmlHelpController && wxUSE_WXHTML_HELP

%endif //wxLUA_USE_wxHTML && wxUSE_HTML
