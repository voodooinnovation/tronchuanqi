{*************************************************************}
{            HTTPGet component for Delphi 32                  }
{ Version:   1.94                                             }
{ E-Mail:    info@utilmind.com                                }
{ WWW:       http://www.utilmind.com                          }
{ Created:   October  19, 1999                                }
{ Modified:  June 6, 2000                                     }
{ Legal:     Copyright (c) 1999-2000, UtilMind Solutions      }
{*************************************************************}
{ PROPERTIES:                                                 }
{   Agent: String - User Agent                                }
{                                                             }
{*  BinaryData: Boolean - This setting specifies which type   }
{*                        of data will taken from the web.    }
{*                        If you set this property TRUE then  }
{*                        component will determinee the size  }
{*                        of files *before* getting them from }
{*                        the web.                            }
{*                        If this property is FALSE then as we}
{*                        do not knows the file size the      }
{*                        OnProgress event will doesn't work. }
{*                        Also please remember that is you set}
{*                        this property as TRUE you will not  }
{*                        capable to get from the web ASCII   }
{*                        data and ofter got OnError event.   }
{                                                             }
{   FileName: String - Path to local file to store the data   }
{                      taken from the web                     }
{   Password, UserName - set this properties if you trying to }
{                        get data from password protected     }
{                        directories.                         }
{   Referer: String - Additional data about referer document  }
{   URL: String - The url to file or document                 }
{   UseCache: Boolean - Get file from the Internet Explorer's }
{                       cache if requested file is cached.    }
{*************************************************************}
{ METHODS:                                                    }
{   GetFile - Get the file from the web specified in the URL  }
{             property and store it to the file specified in  }
{             the FileName property                           }
{   GetString - Get the data from web and return it as usual  }
{               String. You can receive this string hooking   }
{               the OnDoneString event.                       }
{   Abort - Stop the current session                          }
{*************************************************************}
{ EVENTS:                                                     }
{   OnDoneFile - Occurs when the file is downloaded           }
{   OnDoneString - Occurs when the string is received         }
{   OnError - Occurs when error happend                       }
{   OnProgress - Occurs at the receiving of the BINARY DATA   }
{*************************************************************}
{ Please see demo program for more information.               }
{*************************************************************}
{                     IMPORTANT NOTE:                         }
{ This software is provided 'as-is', without any express or   }
{ implied warranty. In no event will the author be held       }
{ liable for any damages arising from the use of this         }
{ software.                                                   }
{ Permission is granted to anyone to use this software for    }
{ any purpose, including commercial applications, and to      }
{ alter it and redistribute it freely, subject to the         }
{ following restrictions:                                     }
{ 1. The origin of this software must not be misrepresented,  }
{    you must not claim that you wrote the original software. }
{    If you use this software in a product, an acknowledgment }
{    in the product documentation would be appreciated but is }
{    not required.                                            }
{ 2. Altered source versions must be plainly marked as such,  }
{    and must not be misrepresented as being the original     }
{    software.                                                }
{ 3. This notice may not be removed or altered from any       }
{    source distribution.                                     }
{*************************************************************}

unit HTTPGet;

interface

uses
  Windows, Messages, SysUtils, Classes, WinInet, Forms;

type
  TOnProgressEvent = procedure(Sender: TObject; TotalSize, Readed: Integer) of object;
  TOnDoneFileEvent = procedure(Sender: TObject; FileName: string; FileSize: Integer) of object;
  TOnDoneStringEvent = procedure(Sender: TObject; Result: string) of object;
  TOnDoneStreamEvent = procedure(Sender: TObject; Stream: TMemoryStream) of object;
  TGetType = (g_File, g_String, g_Stream);
  THTTPGetThread = class(TThread)
  private
    FTAcceptTypes,
      FTAgent,
      FTURL,
      FTFileName,
      FTStringResult,
      FTUserName,
      FTPassword,
      FTPostQuery,
      FTReferer: string;
    FTBinaryData,
      FTUseCache: Boolean;

    FTResult: Boolean;
    FTFileSize: Integer;
    FTToFile: Boolean;
    FGetType: TGetType;
    BytesToRead, BytesReaded: DWord;

    FTProgress: TOnProgressEvent;
    FStream: TMemoryStream;
    procedure UpdateProgress;
  protected
    procedure Execute; override;
  public
    constructor Create(aAcceptTypes, aAgent, aURL, aFileName, aUserName, aPassword, aPostQuery, aReferer: string;
      aBinaryData, aUseCache: Boolean; aProgress: TOnProgressEvent; aGetType: TGetType; aStream: TMemoryStream; ThreadDone: TNotifyEvent = nil);
  end;

  THTTPGet = class(TComponent)
  private
    FAcceptTypes: string;
    FAgent: string;
    FBinaryData: Boolean;
    FURL: string;
    FUseCache: Boolean;
    FFileName: string;
    FUserName: string;
    FPassword: string;
    FPostQuery: string;
    FReferer: string;
    FStringResult: string;
    FWaitThread: Boolean;

    FThread: THTTPGetThread;
    FError: TNotifyEvent;
    FResult: Boolean;

    FProgress: TOnProgressEvent;
    FDoneFile: TOnDoneFileEvent;
    FDoneString: TOnDoneStringEvent;
    FDoneStream: TOnDoneStreamEvent;
    FStream: TMemoryStream;
    procedure ThreadDone(Sender: TObject);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function Get: string;
    procedure GetFile;
    procedure GetString;
    procedure GetStream;
    procedure Abort;
  published
    property AcceptTypes: string read FAcceptTypes write FAcceptTypes;
    property Agent: string read FAgent write FAgent;
    property BinaryData: Boolean read FBinaryData write FBinaryData;
    property URL: string read FURL write FURL;
    property UseCache: Boolean read FUseCache write FUseCache;
    property FileName: string read FFileName write FFileName;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property PostQuery: string read FPostQuery write FPostQuery;
    property Referer: string read FReferer write FReferer;
    property WaitThread: Boolean read FWaitThread write FWaitThread;

    property OnProgress: TOnProgressEvent read FProgress write FProgress;
    property OnDoneFile: TOnDoneFileEvent read FDoneFile write FDoneFile;
    property OnDoneString: TOnDoneStringEvent read FDoneString write FDoneString;
    property OnDoneStream: TOnDoneStreamEvent read FDoneStream write FDoneStream;
    property OnError: TNotifyEvent read FError write FError;
  end;

procedure Register;

implementation

//  THTTPGetThread

constructor THTTPGetThread.Create(aAcceptTypes, aAgent, aURL, aFileName, aUserName, aPassword, aPostQuery, aReferer: string;
  aBinaryData, aUseCache: Boolean; aProgress: TOnProgressEvent; aGetType: TGetType; aStream: TMemoryStream; ThreadDone: TNotifyEvent = nil);
begin
  FreeOnTerminate := True;
  inherited Create(True);
  OnTerminate := ThreadDone;
  FTAcceptTypes := aAcceptTypes;
  FTAgent := aAgent;
  FTURL := aURL;
  FTFileName := aFileName;
  FTUserName := aUserName;
  FTPassword := aPassword;
  FTPostQuery := aPostQuery;
  FTReferer := aReferer;
  FTProgress := aProgress;
  FTBinaryData := aBinaryData;
  FTUseCache := aUseCache;
  FStream := aStream;
  FGetType := aGetType;
  Resume;
end;

procedure THTTPGetThread.UpdateProgress;
begin
  FTProgress(Self, FTFileSize, BytesReaded);
end;

procedure THTTPGetThread.Execute;
var
  hSession, hConnect, hRequest: hInternet;
  HostName, FileName, HostPort: string;
  f: file;
  Buf: Pointer;
  dwBufLen, dwIndex: DWord;
  Data: array[0..$400] of Char;
  TempStr: string;
  RequestMethod: PChar;
  InternetFlag: DWord;
  AcceptType: LPStr;

  nPort: integer;
  procedure ParseURL(URL: string; var HostName, FileName, HostPort: string);

    procedure ReplaceChar(c1, c2: Char; var St: string);
    var
      p: Integer;
    begin
      while True do
      begin
        p := Pos(c1, St);
        if p = 0 then
          Break
        else
          St[p] := c2;
      end;
    end;

  var
    i: Integer;
    sPortPos, ePortPos: integer;
  begin
    if Pos('http://', LowerCase(URL)) <> 0 then
      System.Delete(URL, 1, 7);

    i := Pos('/', URL);
    HostName := Copy(URL, 1, i - 1);
    FileName := Copy(URL, i, Length(URL) - i + 1);

    sPortPos := Pos(':', Url);
    if sPortPos > 0 then
    begin
      ePortPos := Pos('/', Url);
      HostPort := Copy(Url, sPortPos + 1, ePortPos - sPortPos - 1);
      HostName := Copy(HostName, 0, Pos(':', HostName) - 1);
    end;

    if (Length(HostName) > 0) and (HostName[Length(HostName)] = '/') then
      SetLength(HostName, Length(HostName) - 1);
  end;
  {procedure ParseURL(URL: string; var HostName, FileName: string);

    procedure ReplaceChar(c1, c2: Char; var St: string);
    var
      p: Integer;
    begin
      while True do
      begin
        p := Pos(c1, St);
        if p = 0 then Break
        else St[p] := c2;
      end;
    end;

  var
    I: Integer;
  begin
    if Pos('http://', LowerCase(URL)) <> 0 then
      System.Delete(URL, 1, 7);

    I := Pos('/', URL);
    HostName := Copy(URL, 1, I);
    FileName := Copy(URL, I, Length(URL) - I + 1);

    if (Length(HostName) > 0) and (HostName[Length(HostName)] = '/') then
      SetLength(HostName, Length(HostName) - 1);
  end; }

  procedure CloseHandles;
  begin
    InternetCloseHandle(hRequest);
    InternetCloseHandle(hConnect);
    InternetCloseHandle(hSession);
  end;

begin
  try
    //ParseURL(FTURL, HostName, FileName);
    HostPort := '80';
    ParseURL(FTURL, HostName, FileName, HostPort);
    try
      nPort := StrToInt(HostPort);
    except
      nPort := 80;
    end;

    if Terminated then
    begin
      FTResult := False;
      Exit;
    end;

    if FTAgent <> '' then
      hSession := InternetOpen(PChar(FTAgent),
        INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
    else
      hSession := InternetOpen(nil,
        INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

    hConnect := InternetConnect(hSession, PChar(HostName),
      nPort, PChar(FTUserName), PChar(FTPassword),
      INTERNET_SERVICE_HTTP, 0, 0);

    {hConnect := InternetConnect(hSession, PChar(HostName),
      INTERNET_DEFAULT_HTTP_PORT, PChar(FTUserName), PChar(FTPassword), INTERNET_SERVICE_HTTP, 0, 0);}

    if FTPostQuery = '' then RequestMethod := 'GET'
    else RequestMethod := 'POST';

    if FTUseCache then InternetFlag := 0
    else InternetFlag := INTERNET_FLAG_RELOAD;

    AcceptType := PChar('Accept: ' + FTAcceptTypes);
    hRequest := HttpOpenRequest(hConnect, RequestMethod, PChar(FileName), 'HTTP/1.0',
      PChar(FTReferer), @AcceptType, InternetFlag, 0);

    if FTPostQuery = '' then
      HttpSendRequest(hRequest, nil, 0, nil, 0)
    else
      HttpSendRequest(hRequest, 'Content-Type: application/x-www-form-urlencoded', 47,
        PChar(FTPostQuery), Length(FTPostQuery));

    if Terminated then
    begin
      CloseHandles;
      FTResult := False;
      Exit;
    end;

    dwIndex := 0;
    dwBufLen := 1024;
    GetMem(Buf, dwBufLen);

    FTResult := HttpQueryInfo(hRequest, HTTP_QUERY_CONTENT_LENGTH,
      Buf, dwBufLen, dwIndex);

    if Terminated then
    begin
      FreeMem(Buf);
      CloseHandles;
      FTResult := False;
      Exit;
    end;

    if FTResult or not FTBinaryData then
    begin
      if FTResult then
        FTFileSize := StrToInt(StrPas(Buf));

      BytesReaded := 0;

      case FGetType of
        g_File: begin
            AssignFile(f, FTFileName);
            Rewrite(f, 1);
          end;
        g_String: FTStringResult := '';
        g_Stream: FStream.Clear;
      end;
      {
      if FTToFile then
      begin
        AssignFile(f, FTFileName);
        Rewrite(f, 1);
      end
      else FTStringResult := '';
      }
      while True do
      begin
        if Terminated then
        begin
          //if FTToFile then CloseFile(f);
          if FGetType = g_File then CloseFile(f);
          FreeMem(Buf);
          CloseHandles;

          FTResult := False;
          Exit;
        end;

        if not InternetReadFile(hRequest, @Data, SizeOf(Data), BytesToRead) then Break
        else
          if BytesToRead = 0 then Break
        else
        begin
          case FGetType of
            g_File: BlockWrite(f, Data, BytesToRead);
            g_String: begin
                TempStr := Data;
                SetLength(TempStr, BytesToRead);
                FTStringResult := FTStringResult + TempStr;
              end;
            g_Stream: FStream.Write(Data, BytesToRead)
          end;
          {
          if FTToFile then
            BlockWrite(f, Data, BytesToRead)
          else
          begin
            TempStr := Data;
            SetLength(TempStr, BytesToRead);
            FTStringResult := FTStringResult + TempStr;
          end;
          }
          inc(BytesReaded, BytesToRead);
          if Assigned(FTProgress) then
            Synchronize(UpdateProgress);
        end;
      end;

      case FGetType of
        g_File: FTResult := FTFileSize = Integer(BytesReaded);
        g_String: begin
            SetLength(FTStringResult, BytesReaded);
            FTResult := BytesReaded <> 0;
          end;
        g_Stream: FTResult := FTFileSize = Integer(BytesReaded);
      end;
      {
      if FTToFile then
        FTResult := FTFileSize = Integer(BytesReaded)
      else
      begin
        SetLength(FTStringResult, BytesReaded);
        FTResult := BytesReaded <> 0;
      end;
      }
      if FGetType = g_File then CloseFile(f);
      //if FTToFile then CloseFile(f);
    end;

    FreeMem(Buf);

    CloseHandles;
  except
  end;
end;

// HTTPGet

constructor THTTPGet.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FAcceptTypes := '*/*';
  FAgent := 'UtilMind HTTPGet';
  FStream := TMemoryStream.Create;
end;

destructor THTTPGet.Destroy;
begin
  Abort;
  FStream.Free;
  inherited Destroy;
end;

function THTTPGet.Get: string;
var
  Msg: TMsg;
begin
  Result := '';
  FStringResult := '';
  if not Assigned(FThread) then
  begin
    FThread := THTTPGetThread.Create(FAcceptTypes, FAgent, FURL, FFileName, FUserName, FPassword, FPostQuery, FReferer,
      FBinaryData, FUseCache, FProgress, g_String, FStream, ThreadDone);
    //FThread.OnTerminate := ThreadDone;
    if FWaitThread then begin
      while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
      while (FThread <> nil) {and FThread.Terminated} do begin
        //Sleep(1);
        Application.ProcessMessages;
      end;

      Result := FStringResult;
    end;
  end
end;

procedure THTTPGet.GetFile;
var
  Msg: TMsg;
begin
  if not Assigned(FThread) then
  begin
    FThread := THTTPGetThread.Create(FAcceptTypes, FAgent, FURL, FFileName, FUserName, FPassword, FPostQuery, FReferer,
      FBinaryData, FUseCache, FProgress, g_File, FStream, ThreadDone);
    //FThread.OnTerminate := ThreadDone;
    if FWaitThread then
      while Assigned(FThread) do
        while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
        begin
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end;
  end
end;

procedure THTTPGet.GetString;
var
  Msg: TMsg;
begin
  if not Assigned(FThread) then
  begin
    FThread := THTTPGetThread.Create(FAcceptTypes, FAgent, FURL, FFileName, FUserName, FPassword, FPostQuery, FReferer,
      FBinaryData, FUseCache, FProgress, g_String, FStream, ThreadDone);
    //FThread.OnTerminate := ThreadDone;
    if FWaitThread then
      while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
  end
end;

procedure THTTPGet.GetStream;
var
  Msg: TMsg;
begin
  if not Assigned(FThread) then
  begin
    FThread := THTTPGetThread.Create(FAcceptTypes, FAgent, FURL, FFileName, FUserName, FPassword, FPostQuery, FReferer,
      FBinaryData, FUseCache, FProgress, g_Stream, FStream, ThreadDone);
    //FThread.OnTerminate := ThreadDone;
    if FWaitThread then
      while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
  end
end;

procedure THTTPGet.Abort;
begin
  if Assigned(FThread) then
  begin
    FThread.Terminate;
    FThread.FTResult := False;
  end;
end;

procedure THTTPGet.ThreadDone(Sender: TObject);
begin
  FResult := FThread.FTResult;
  if FResult then begin
    case FThread.FGetType of
      g_File: if Assigned(FDoneFile) then FDoneFile(Self, FThread.FTFileName, FThread.FTFileSize);
      g_String: if Assigned(FDoneString) then FDoneString(Self, FThread.FTStringResult);
      g_Stream: if Assigned(FDoneStream) then FDoneStream(Self, FThread.FStream);
    end;
  end else if Assigned(FError) then FError(Self);
  {
  if FResult then
    if FThread.FTToFile then
      if Assigned(FDoneFile) then FDoneFile(Self, FThread.FTFileName, FThread.FTFileSize) else
    else
      if Assigned(FDoneString) then FDoneString(Self, FThread.FTStringResult) else
  else
    if Assigned(FError) then FError(Self);
  }
  FStringResult := FThread.FTStringResult;
  FThread := nil;
end;

procedure Register;
begin
  RegisterComponents('UtilMind', [THTTPGet]);
end;

end.

