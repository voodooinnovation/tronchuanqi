//***********************************************************
//Eran Bodankin (bsalsa) -  D2005 update                    *
//                                                          *
//            IETravelLog ver 9.00 (Oct 19, 2005)           *
//                                                          *
//                       For Delphi 4 & 5 & 6               *
//                     Freeware Component                   *
//                            by                            *
//                     Per Linds� Larsen                    *
//                   per.lindsoe@larsen.mail.dk             *
//                                                          *
//                                                          *
//        Documentation and updated versions:               *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//***********************************************************

unit IETravelLog;

interface

uses
  Activex, Windows, Messages, SysUtils, Classes, EmbeddedWB ;

const

  TLEF_RELATIVE_INCLUDE_CURRENT = $00000001;
  TLEF_RELATIVE_BACK = $00000010;
  TLEF_RELATIVE_FORE = $00000020;
  TLEF_INCLUDE_UNINVOKEABLE = $00000040;
  TLEF_ABSOLUTE = $00000031;

  IID_ITravelLogEntry: TGUID = '{7EBFDD87-AD18-11d3-A4C5-00C04F72D6B8}';
  IID_IEnumTravelLogEntry: TGUID = '{7EBFDD85-AD18-11d3-A4C5-00C04F72D6B8}';
  IID_ITravelLogStg: TGUID = '{7EBFDD80-AD18-11d3-A4C5-00C04F72D6B8}';
  SID_STravelLogCursor: TGUID = '{7EBFDD80-AD18-11d3-A4C5-00C04F72D6B8}';

type

  ITravelLogEntry = interface(IUnknown)
    ['{7EBFDD87-AD18-11d3-A4C5-00C04F72D6B8}']
    function GetTitle(var ppszTitle: POleStr): HRESULT; stdcall;
    function GetUrl(var ppszURL: POleStr): HRESULT; stdcall;
  end;

  IEnumTravelLogEntry = interface(IUnknown)
    ['{7EBFDD85-AD18-11d3-A4C5-00C04F72D6B8}']
    function Next(cElt: ULONG; out rgElt: ITravelLogEntry; out pcEltFetched: ULONG): HRESULT; stdcall;
    function Skip(cElt: ULONG): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
    function Clone(out ppEnum: IEnumTravelLogEntry): HRESULT; stdcall;
  end;

  ITravelLogStg = interface(IUnknown)
    ['{7EBFDD80-AD18-11d3-A4C5-00C04F72D6B8}']
    function CreateEntry(pszURL, pszTitle: POleStr; ptleRelativeTo: ITravelLogEntry;
      fPrepend: BOOL; out pptle: ITravelLogEntry): HRESULT; stdcall;
    function TravelTo(ptle: ITravelLogEntry): HRESULT; stdcall;
    function EnumEntries(flags: DWORD; out ppenum: IEnumTravellogEntry): HRESULT; stdcall;
    function FindEntries(flags: DWORD; pszURL: POleStr; out ppenum: IEnumTravelLogEntry): HRESULT; stdcall;
    function GetCount(flags: DWORD; out pcEntries: DWORD): HRESULT; stdcall;
    function RemoveEntry(ptle: ITravelLogEntry): HRESULT; stdcall;
    function GetRelativeEntry(iOffset: Integer; out ptle: ITravelLogEntry): HRESULT; stdcall;
  end;


  TOnEntryEvent = procedure(Title, Url: string; var Cancel: Boolean) of object;



  TIETravelLog = class(TComponent)
  private
    FIsBack: Boolean;
    { Private declarations }
    FOnEntry: TOnEntryEvent;
    FWebbrowser: TEmbeddedWB;
  protected
    { Protected declarations }
    Stg: ITravelLogStg;
    Enum: IEnumTravelLogEntry;
    Entry: ITravelLogEntry;
    procedure _Enumerate(flags: Cardinal);
  public
    { Public declarations }
    function GetCount(flags: DWORD; out Entries: DWORD): HRESULT;
    procedure ClearSession;
    procedure EnumerateBack;
    procedure EnumerateForward;
    procedure Enumerate;
    function Connect: Boolean;
    function TravelTo(Offset: Integer): HRESULT;
    function GetRelativeEntry(Offset: Integer; out Title, Url: string): HRESULT;
    function CreateEntry(Offset: Integer; URL, Title: string): HRESULT;
    function RemoveEntry(Offset: Integer): HRESULT;
    function RemoveEntryByTitle(title: string): HRESULT;
    function RemoveEntryByUrl(Url: string): HRESULT;
    property IsBack: Boolean read FIsBack;
  published
    { Published declarations }
    property Webbrowser: TEmbeddedWB read FWebbrowser write FWebbrowser;
    property OnEntry: TOnEntryEvent read FOnEntry write FOnEntry;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TIETravelLog]);
end;

{ TIETravelLog }

function TIETravelLog.TravelTo(Offset: Integer): HRESULT;
begin
  Result := S_FALSE;
  if Stg.GetRelativeEntry(OffSet, entry) = S_OK then
    Result := Stg.Travelto(entry);
end;


procedure TIETravelLog._Enumerate(flags: Cardinal);
var
  Cancel: Boolean;
  Fetched: Cardinal;
  Url, Title: PWidechar;
begin
  Cancel := False;
  Stg.EnumEntries(flags, Enum);
  if Enum <> nil then
    while (enum.next(1, Entry, Fetched) = S_OK) and not Cancel
      do begin
      Entry.GetTitle(Title);
      Entry.GetUrl(Url);
      if Assigned(FOnEntry) then FonEntry(title, url, Cancel);
    end;

end;

procedure TIETravelLog.EnumerateBack;
begin
  _Enumerate(TLEF_RELATIVE_BACK);
  FIsBack := True;
end;

procedure TIETravelLog.EnumerateForward;
begin
  _Enumerate(TLEF_RELATIVE_FORE);
  FIsBack := False;
end;

function TIETravelLog.Connect: Boolean;
var
  ISP: IServiceProvider;
begin
  Result := FALSE;
  if Assigned(Webbrowser) and Assigned(Webbrowser.Document)
    then begin
    if Failed(Webbrowser.Application.QueryInterface(IServiceprovider, ISP))
      then exit;
    if Succeeded(ISP.QueryService(SID_STravelLogCursor, IID_ITravelLogStg, Stg))
      then Result := TRUE;
  end;
end;


function TIETravelLog.GetRelativeEntry(Offset: Integer; out Title, Url: string): HRESULT;
var
  WUrl, WTitle: PWidechar;
begin
  Result := Stg.GetRelativeEntry(OffSet, entry);
  if Result = S_OK then
  begin
    Entry.GetTitle(Wtitle);
    Entry.GetUrl(WUrl);
  end;
end;


function TIETravelLog.GetCount(flags: DWORD; out Entries: DWORD): HRESULT;
begin
  Result := Stg.GetCount(flags, Entries);
end;

function TIETravelLog.CreateEntry(Offset: Integer; URL,
  Title: string): HRESULT;
var
  dummy: ITravelLogEntry;
begin
  Result:=S_FALSE;
  if Stg.GetRelativeEntry(OffSet, entry) = S_OK
    then Result := Stg.CreateEntry(StringtoOleStr(url), StringtoOleStr(title), Entry, TRUE, Dummy)
end;

procedure TIETravelLog.Enumerate;
begin
  _Enumerate(TLEF_ABSOLUTE);
end;

function TIETravelLog.RemoveEntry(Offset: Integer): HRESULT;
var
  Title, Url: string;
begin
  Result:=S_FALSE;
  If GetRelativeEntry(Offset, Title, Url)=S_OK then
  Result:=RemoveEntryByUrl(Url);
end;

function TIETravelLog.RemoveEntryByTitle(title: string): HRESULT;
var
  Fetched: Cardinal;
  PTitle: PWidechar;
begin
  Result:=S_FALSE;
  if Stg.EnumEntries(TLEF_ABSOLUTE, Enum) = S_OK
    then
    while (enum.next(1, Entry, Fetched) = S_OK) do
    begin
      Entry.GetTitle(PTitle);
      if title = pTitle then Result:=stg.RemoveEntry(Entry);
    end;
end;


function TIETravelLog.RemoveEntryByUrl(Url: string): HRESULT;
var
  Fetched: Cardinal;
  PUrl: PWidechar;
begin
  RESULT:=S_FALSE;
  if Stg.EnumEntries(TLEF_ABSOLUTE, Enum) = S_OK
    then
    while (enum.next(1, Entry, Fetched) = S_OK) do
    begin
      Entry.GetUrl(PUrl);
      if Url = pUrl then Result := stg.RemoveEntry(Entry);
    end;
end;

procedure TIETravelLog.ClearSession;
var
  Fetched: Cardinal;
begin
  if Stg.EnumEntries(TLEF_ABSOLUTE, Enum) = S_OK
    then while (enum.next(1, Entry, Fetched) = S_OK) do Stg.RemoveEntry(Entry);
end;

end.

