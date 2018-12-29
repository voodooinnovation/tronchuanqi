{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvOdacSmartQuery.PAS, released on 2002-05-26.

The Initial Developer of the Original Code is Jens Fudickar
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Description:
  Oracle Dataset with Threaded Functions

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvOdacSmartQuery.pas 11411 2007-07-10 21:57:06Z jfudickar $

unit JvOdacSmartQuery;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes, StdCtrls, ExtCtrls, Forms, Controls,
  DB,
  OraSmart, Ora, DBaccess,
  JvThread, JvThreadDialog, JvDynControlEngine,
  JvBaseDBThreadedDataset;

type
  TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions =
    class(TJvBaseThreadedDatasetAllowedContinueRecordFetchOptions)
  public
    constructor Create; override;
  published
    property All;
  End;

  TJvOdacThreadedDatasetEnhancedOptions = Class(TJvBaseThreadedDatasetEnhancedOptions)
  private
    function GetAllowedContinueRecordFetchOptions: TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions;
    procedure SetAllowedContinueRecordFetchOptions(
      const Value: TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions);
  protected
    function CreateAllowedContinueRecordFetchOptions: TJvBaseThreadedDatasetAllowedContinueRecordFetchOptions;
      override;
  published
    property AllowedContinueRecordFetchOptions: TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions read
      GetAllowedContinueRecordFetchOptions write SetAllowedContinueRecordFetchOptions;
  end;

  TJvOdacDatasetThreadHandler = class(TJvBaseDatasetThreadHandler)
  protected
    function CreateEnhancedOptions: TJvBaseThreadedDatasetEnhancedOptions; override;
  End;

  TJvOdacSmartQuery = class(TSmartQuery, IJvThreadedDatasetInterface)
    procedure BreakExecution;
    procedure DoInheritedAfterOpen;
    procedure DoInheritedAfterRefresh;
    procedure DoInheritedBeforeOpen;
    procedure DoInheritedBeforeRefresh;
    procedure DoInheritedInternalLast;
    procedure DoInheritedInternalRefresh;
    procedure DoInheritedSetActive(Active: Boolean);
    procedure DoInternalOpen;
    function GetDatasetFetchAllRecords: Boolean;
    function IsThreadAllowed: Boolean;
    procedure SetDatasetFetchAllRecords(const Value: Boolean);
  private
    FBeforeFetch: TBeforeFetchEvent;
    FThreadHandler: TJvBaseDatasetThreadHandler;
    function GetAfterThreadExecution: TJvThreadedDatasetThreadEvent;
    function GetBeforeThreadExecution: TJvThreadedDatasetThreadEvent;
    function GetDialogOptions: TJvThreadedDatasetDialogOptions;
    function GetEnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions;
    function GetThreadOptions: TJvThreadedDatasetThreadOptions;
    procedure SetAfterThreadExecution(const Value: TJvThreadedDatasetThreadEvent);
    procedure SetBeforeThreadExecution(const Value: TJvThreadedDatasetThreadEvent);
    procedure SetDialogOptions(Value: TJvThreadedDatasetDialogOptions);
    procedure SetEnhancedOptions(const Value:
        TJvOdacThreadedDatasetEnhancedOptions);
    procedure SetThreadOptions(const Value: TJvThreadedDatasetThreadOptions);
    property ThreadHandler: TJvBaseDatasetThreadHandler read FThreadHandler;
  protected
    procedure DoAfterOpen; override;
    procedure DoAfterRefresh; override;
    procedure DoBeforeOpen; override;
    procedure DoBeforeRefresh; override;
    procedure InternalLast; override;
    procedure InternalRefresh; override;
    procedure ReplaceBeforeFetch(Dataset: TCustomDADataSet; var Cancel: Boolean);
    procedure SetActive(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CurrentFetchDuration: TDateTime;
    function CurrentOpenDuration: TDateTime;
    function ErrorMessage: string;
    function ErrorException: Exception;
    function ThreadIsActive: Boolean;
  published
    property AfterThreadExecution: TJvThreadedDatasetThreadEvent read
        GetAfterThreadExecution write SetAfterThreadExecution;
    property BeforeFetch: TBeforeFetchEvent read FBeforeFetch write FBeforeFetch;
    property BeforeThreadExecution: TJvThreadedDatasetThreadEvent read
        GetBeforeThreadExecution write SetBeforeThreadExecution;
    property DialogOptions: TJvThreadedDatasetDialogOptions read GetDialogOptions write SetDialogOptions;
    property EnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions read GetEnhancedOptions write SetEnhancedOptions;
    property ThreadOptions: TJvThreadedDatasetThreadOptions read GetThreadOptions write SetThreadOptions;
  end;

  TJvOdacOraQuery = class(TOraQuery, IJvThreadedDatasetInterface)
    procedure BreakExecution;
    procedure DoInheritedAfterOpen;
    procedure DoInheritedAfterRefresh;
    procedure DoInheritedBeforeOpen;
    procedure DoInheritedBeforeRefresh;
    procedure DoInheritedInternalLast;
    procedure DoInheritedInternalRefresh;
    procedure DoInheritedSetActive(Active: Boolean);
    procedure DoInternalOpen;
    function GetDatasetFetchAllRecords: Boolean;
    function IsThreadAllowed: Boolean;
    procedure SetDatasetFetchAllRecords(const Value: Boolean);
  private
    FBeforeFetch: TBeforeFetchEvent;
    FThreadHandler: TJvBaseDatasetThreadHandler;
    function GetAfterThreadExecution: TJvThreadedDatasetThreadEvent;
    function GetBeforeThreadExecution: TJvThreadedDatasetThreadEvent;
    function GetDialogOptions: TJvThreadedDatasetDialogOptions;
    function GetEnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions;
    function GetThreadOptions: TJvThreadedDatasetThreadOptions;
    procedure SetAfterThreadExecution(const Value: TJvThreadedDatasetThreadEvent);
    procedure SetBeforeThreadExecution(const Value: TJvThreadedDatasetThreadEvent);
    procedure SetDialogOptions(Value: TJvThreadedDatasetDialogOptions);
    procedure SetEnhancedOptions(const Value:
        TJvOdacThreadedDatasetEnhancedOptions);
    procedure SetThreadOptions(const Value: TJvThreadedDatasetThreadOptions);
    property ThreadHandler: TJvBaseDatasetThreadHandler read FThreadHandler;
  protected
    procedure DoAfterOpen; override;
    procedure DoAfterRefresh; override;
    procedure DoBeforeOpen; override;
    procedure DoBeforeRefresh; override;
    procedure InternalLast; override;
    procedure InternalRefresh; override;
    procedure ReplaceBeforeFetch(Dataset: TCustomDADataSet; var Cancel: Boolean);
    procedure SetActive(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CurrentFetchDuration: TDateTime;
    function CurrentOpenDuration: TDateTime;
    function ErrorException: Exception;
    function ErrorMessage: string;
    function ThreadIsActive: Boolean;
  published
    property AfterThreadExecution: TJvThreadedDatasetThreadEvent read
        GetAfterThreadExecution write SetAfterThreadExecution;
    property BeforeFetch: TBeforeFetchEvent read FBeforeFetch write FBeforeFetch;
    property BeforeThreadExecution: TJvThreadedDatasetThreadEvent read
        GetBeforeThreadExecution write SetBeforeThreadExecution;
    property DialogOptions: TJvThreadedDatasetDialogOptions read GetDialogOptions write SetDialogOptions;
    property EnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions read GetEnhancedOptions write SetEnhancedOptions;
    property ThreadOptions: TJvThreadedDatasetThreadOptions read GetThreadOptions write SetThreadOptions;
  end;

type
  TJvOdacOraTable = class(TOraTable, IJvThreadedDatasetInterface)
    procedure BreakExecution;
    procedure DoInheritedAfterOpen;
    procedure DoInheritedAfterRefresh;
    procedure DoInheritedBeforeOpen;
    procedure DoInheritedBeforeRefresh;
    procedure DoInheritedInternalLast;
    procedure DoInheritedInternalRefresh;
    procedure DoInheritedSetActive(Active: Boolean);
    procedure DoInternalOpen;
    function GetDatasetFetchAllRecords: Boolean;
    function IsThreadAllowed: Boolean;
    procedure SetDatasetFetchAllRecords(const Value: Boolean);
  private
    FBeforeFetch: TBeforeFetchEvent;
    FThreadHandler: TJvBaseDatasetThreadHandler;
    function GetAfterThreadExecution: TJvThreadedDatasetThreadEvent;
    function GetBeforeThreadExecution: TJvThreadedDatasetThreadEvent;
    function GetDialogOptions: TJvThreadedDatasetDialogOptions;
    function GetEnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions;
    function GetThreadOptions: TJvThreadedDatasetThreadOptions;
    procedure SetAfterThreadExecution(const Value: TJvThreadedDatasetThreadEvent);
    procedure SetBeforeThreadExecution(const Value: TJvThreadedDatasetThreadEvent);
    procedure SetDialogOptions(Value: TJvThreadedDatasetDialogOptions);
    procedure SetEnhancedOptions(const Value:
        TJvOdacThreadedDatasetEnhancedOptions);
    procedure SetThreadOptions(const Value: TJvThreadedDatasetThreadOptions);
    property ThreadHandler: TJvBaseDatasetThreadHandler read FThreadHandler;
  protected
    procedure DoAfterOpen; override;
    procedure DoAfterRefresh; override;
    procedure DoBeforeOpen; override;
    procedure DoBeforeRefresh; override;
    procedure InternalLast; override;
    procedure InternalRefresh; override;
    procedure ReplaceBeforeFetch(Dataset: TCustomDADataSet; var Cancel: Boolean);
    procedure SetActive(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CurrentFetchDuration: TDateTime;
    function CurrentOpenDuration: TDateTime;
    function ErrorException: Exception;
    function ErrorMessage: string;
    function ThreadIsActive: Boolean;
  published
    property AfterThreadExecution: TJvThreadedDatasetThreadEvent read
        GetAfterThreadExecution write SetAfterThreadExecution;
    property BeforeFetch: TBeforeFetchEvent read FBeforeFetch write FBeforeFetch;
    property BeforeThreadExecution: TJvThreadedDatasetThreadEvent read
        GetBeforeThreadExecution write SetBeforeThreadExecution;
    property DialogOptions: TJvThreadedDatasetDialogOptions read GetDialogOptions write SetDialogOptions;
    property EnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions read GetEnhancedOptions write SetEnhancedOptions;
    property ThreadOptions: TJvThreadedDatasetThreadOptions read GetThreadOptions write SetThreadOptions;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvOdacSmartQuery.pas $';
    Revision: '$Revision: 11411 $';
    Date: '$Date: 2007-07-10 14:57:06 -0700 (Tue, 10 Jul 2007) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

//=== { TJvOdacSmartQuery } ==================================================

constructor TJvOdacSmartQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThreadHandler := TJvOdacDatasetThreadHandler.Create(Self, Self);
  inherited BeforeFetch := ReplaceBeforeFetch;
end;

destructor TJvOdacSmartQuery.Destroy;
begin
  FreeAndNil(FThreadHandler);
  inherited Destroy;
end;

procedure TJvOdacSmartQuery.BreakExecution;
begin
  BreakExec;
end;

function TJvOdacSmartQuery.CurrentFetchDuration: TDateTime;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.CurrentFetchDuration
  else
    Result := 0;
end;

function TJvOdacSmartQuery.CurrentOpenDuration: TDateTime;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.CurrentOpenDuration
  else
    Result := 0;
end;

procedure TJvOdacSmartQuery.DoAfterOpen;
begin
  ThreadHandler.AfterOpen;
end;

procedure TJvOdacSmartQuery.DoAfterRefresh;
begin
  ThreadHandler.AfterRefresh;
end;

procedure TJvOdacSmartQuery.DoBeforeOpen;
begin
  ThreadHandler.BeforeOpen;
end;

procedure TJvOdacSmartQuery.DoBeforeRefresh;
begin
  ThreadHandler.BeforeRefresh;
end;

procedure TJvOdacSmartQuery.DoInheritedAfterOpen;
begin
  inherited DoAfterOpen;
end;

procedure TJvOdacSmartQuery.DoInheritedAfterRefresh;
begin
  inherited DoAfterRefresh;
end;

procedure TJvOdacSmartQuery.DoInheritedBeforeOpen;
begin
  inherited DoBeforeOpen;
end;

procedure TJvOdacSmartQuery.DoInheritedBeforeRefresh;
begin
  inherited DoBeforeRefresh;
end;

procedure TJvOdacSmartQuery.DoInheritedInternalLast;
begin
  inherited InternalLast;
end;

procedure TJvOdacSmartQuery.DoInheritedInternalRefresh;
begin
  inherited InternalRefresh;
end;

procedure TJvOdacSmartQuery.DoInheritedSetActive(Active: Boolean);
begin
  inherited SetActive(Active);
end;

procedure TJvOdacSmartQuery.DoInternalOpen;
begin
  InternalOpen;
end;

function TJvOdacSmartQuery.ErrorMessage: string;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ErrorMessage
  else
    Result := '';
end;

function TJvOdacSmartQuery.ErrorException: Exception;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ErrorException
  else
    Result := Nil;
end;

function TJvOdacSmartQuery.GetAfterThreadExecution:
    TJvThreadedDatasetThreadEvent;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.AfterThreadExecution
  else
    Result := nil;
end;

function TJvOdacSmartQuery.GetBeforeThreadExecution:
    TJvThreadedDatasetThreadEvent;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.BeforeThreadExecution
  else
    Result := nil;
end;

function TJvOdacSmartQuery.GetDatasetFetchAllRecords: Boolean;
begin
  Result := FetchAll;
end;

function TJvOdacSmartQuery.GetDialogOptions: TJvThreadedDatasetDialogOptions;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.DialogOptions
  else
    Result := nil;
end;

function TJvOdacSmartQuery.GetEnhancedOptions: TJvOdacThreadedDatasetEnhancedOptions;
begin
  if Assigned(ThreadHandler) then
    Result := TJvOdacThreadedDatasetEnhancedOptions(ThreadHandler.EnhancedOptions)
  else
    Result := nil;
end;

function TJvOdacSmartQuery.GetThreadOptions: TJvThreadedDatasetThreadOptions;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ThreadOptions
  else
    Result := nil;
end;

procedure TJvOdacSmartQuery.InternalLast;
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.InternalLast;
end;

procedure TJvOdacSmartQuery.InternalRefresh;
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.InternalRefresh;
end;

function TJvOdacSmartQuery.IsThreadAllowed: Boolean;
begin
  if Assigned(MasterSource) and Assigned(MasterSource.Dataset) and (MasterSource.Dataset is TJvOdacSmartQuery) then
    Result := not TJvOdacSmartQuery(MasterSource.Dataset).ThreadHandler.ThreadIsActive
  else
    Result := True;
end;

procedure TJvOdacSmartQuery.ReplaceBeforeFetch(Dataset: TCustomDADataSet; var Cancel: Boolean);
begin
  if Assigned(ThreadHandler) then
    Cancel := ThreadHandler.CheckContinueRecordFetch <> tdccrContinue;
  if Assigned(BeforeFetch) then
    BeforeFetch(Dataset, Cancel);
end;

procedure TJvOdacSmartQuery.SetActive(Value: Boolean);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.SetActive(Value);
end;

procedure TJvOdacSmartQuery.SetAfterThreadExecution(const Value:
    TJvThreadedDatasetThreadEvent);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.AfterThreadExecution := Value;
end;

procedure TJvOdacSmartQuery.SetBeforeThreadExecution(const Value:
    TJvThreadedDatasetThreadEvent);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.BeforeThreadExecution := Value;
end;

procedure TJvOdacSmartQuery.SetDatasetFetchAllRecords(const Value: Boolean);
begin
  FetchAll := Value;
end;

procedure TJvOdacSmartQuery.SetDialogOptions(Value: TJvThreadedDatasetDialogOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.DialogOptions.Assign(Value);
end;

procedure TJvOdacSmartQuery.SetEnhancedOptions(const Value: TJvOdacThreadedDatasetEnhancedOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.EnhancedOptions.Assign(Value);
end;

procedure TJvOdacSmartQuery.SetThreadOptions(const Value: TJvThreadedDatasetThreadOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.ThreadOptions.Assign(Value);
end;

function TJvOdacSmartQuery.ThreadIsActive: Boolean;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ThreadIsActive
  else
    Result := False;
end;

//=== { TJvOdacDatasetThreadHandler } ========================================

function TJvOdacDatasetThreadHandler.CreateEnhancedOptions: TJvBaseThreadedDatasetEnhancedOptions;
begin
  Result := TJvOdacThreadedDatasetEnhancedOptions.Create;
end;

//=== { TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions } ============

constructor TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions.Create;
begin
  inherited Create;
  All := True;
end;

function
  TJvOdacThreadedDatasetEnhancedOptions.CreateAllowedContinueRecordFetchOptions:
    TJvBaseThreadedDatasetAllowedContinueRecordFetchOptions;
begin
  Result := TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions.Create;
end;

function
  TJvOdacThreadedDatasetEnhancedOptions.GetAllowedContinueRecordFetchOptions:
    TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions;
begin
  Result := TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions(inherited AllowedContinueRecordFetchOptions);
end;

procedure
  TJvOdacThreadedDatasetEnhancedOptions.SetAllowedContinueRecordFetchOptions(
    const Value: TJvOdacThreadedDatasetAllowedContinueRecordFetchOptions);
begin
  inherited AllowedContinueRecordFetchOptions := Value;
end;

//=== { TJvOdacSmartQuery } ==================================================

constructor TJvOdacOraQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThreadHandler := TJvOdacDatasetThreadHandler.Create(Self, Self);
  inherited BeforeFetch := ReplaceBeforeFetch;
end;

destructor TJvOdacOraQuery.Destroy;
begin
  FreeAndNil(FThreadHandler);
  inherited Destroy;
end;

procedure TJvOdacOraQuery.BreakExecution;
begin
  BreakExec;
end;

function TJvOdacOraQuery.CurrentFetchDuration: TDateTime;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.CurrentFetchDuration
  else
    Result := 0;
end;

function TJvOdacOraQuery.CurrentOpenDuration: TDateTime;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.CurrentOpenDuration
  else
    Result := 0;
end;

procedure TJvOdacOraQuery.DoAfterOpen;
begin
  ThreadHandler.AfterOpen;
end;

procedure TJvOdacOraQuery.DoAfterRefresh;
begin
  ThreadHandler.AfterRefresh;
end;

procedure TJvOdacOraQuery.DoBeforeOpen;
begin
  ThreadHandler.BeforeOpen;
end;

procedure TJvOdacOraQuery.DoBeforeRefresh;
begin
  ThreadHandler.BeforeRefresh;
end;

procedure TJvOdacOraQuery.DoInheritedAfterOpen;
begin
  inherited DoAfterOpen;
end;

procedure TJvOdacOraQuery.DoInheritedAfterRefresh;
begin
  inherited DoAfterRefresh;
end;

procedure TJvOdacOraQuery.DoInheritedBeforeOpen;
begin
  inherited DoBeforeOpen;
end;

procedure TJvOdacOraQuery.DoInheritedBeforeRefresh;
begin
  inherited DoBeforeRefresh;
end;

procedure TJvOdacOraQuery.DoInheritedInternalLast;
begin
  inherited InternalLast;
end;

procedure TJvOdacOraQuery.DoInheritedInternalRefresh;
begin
  inherited InternalRefresh;
end;

procedure TJvOdacOraQuery.DoInheritedSetActive(Active: Boolean);
begin
  inherited SetActive(Active);
end;

procedure TJvOdacOraQuery.DoInternalOpen;
begin
  InternalOpen;
end;

function TJvOdacOraQuery.ErrorException: Exception;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ErrorException
  else
    Result := Nil;
end;

function TJvOdacOraQuery.ErrorMessage: string;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ErrorMessage
  else
    Result := '';
end;

function TJvOdacOraQuery.GetAfterThreadExecution:
    TJvThreadedDatasetThreadEvent;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.AfterThreadExecution
  else
    Result := nil;
end;

function TJvOdacOraQuery.GetBeforeThreadExecution:
    TJvThreadedDatasetThreadEvent;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.BeforeThreadExecution
  else
    Result := nil;
end;

function TJvOdacOraQuery.GetDatasetFetchAllRecords: Boolean;
begin
  Result := FetchAll;
end;

function TJvOdacOraQuery.GetDialogOptions: TJvThreadedDatasetDialogOptions;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.DialogOptions
  else
    Result := nil;
end;

function TJvOdacOraQuery.GetEnhancedOptions:
    TJvOdacThreadedDatasetEnhancedOptions;
begin
  if Assigned(ThreadHandler) then
    Result := TJvOdacThreadedDatasetEnhancedOptions(ThreadHandler.EnhancedOptions)
  else
    Result := nil;
end;

function TJvOdacOraQuery.GetThreadOptions: TJvThreadedDatasetThreadOptions;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ThreadOptions
  else
    Result := nil;
end;

procedure TJvOdacOraQuery.InternalLast;
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.InternalLast;
end;

procedure TJvOdacOraQuery.InternalRefresh;
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.InternalRefresh;
end;

function TJvOdacOraQuery.IsThreadAllowed: Boolean;
begin
  if Assigned(MasterSource) and Assigned(MasterSource.Dataset) and (MasterSource.Dataset is TJvOdacSmartQuery) then
    Result := not TJvOdacSmartQuery(MasterSource.Dataset).ThreadHandler.ThreadIsActive
  else
    Result := True;
end;

procedure TJvOdacOraQuery.ReplaceBeforeFetch(Dataset: TCustomDADataSet; var
    Cancel: Boolean);
begin
  if Assigned(ThreadHandler) then
    Cancel := ThreadHandler.CheckContinueRecordFetch <> tdccrContinue;
  if Assigned(BeforeFetch) then
    BeforeFetch(Dataset, Cancel);
end;

procedure TJvOdacOraQuery.SetActive(Value: Boolean);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.SetActive(Value);
end;

procedure TJvOdacOraQuery.SetAfterThreadExecution(const Value:
    TJvThreadedDatasetThreadEvent);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.AfterThreadExecution := Value;
end;

procedure TJvOdacOraQuery.SetBeforeThreadExecution(const Value:
    TJvThreadedDatasetThreadEvent);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.BeforeThreadExecution := Value;
end;

procedure TJvOdacOraQuery.SetDatasetFetchAllRecords(const Value: Boolean);
begin
  FetchAll := Value;
end;

procedure TJvOdacOraQuery.SetDialogOptions(Value:
    TJvThreadedDatasetDialogOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.DialogOptions.Assign(Value);
end;

procedure TJvOdacOraQuery.SetEnhancedOptions(const Value:
    TJvOdacThreadedDatasetEnhancedOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.EnhancedOptions.Assign(Value);
end;

procedure TJvOdacOraQuery.SetThreadOptions(const Value:
    TJvThreadedDatasetThreadOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.ThreadOptions.Assign(Value);
end;

function TJvOdacOraQuery.ThreadIsActive: Boolean;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ThreadIsActive
  else
    Result := False;
end;

//=== { TJvOdacSmartQuery } ==================================================

constructor TJvOdacOraTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThreadHandler := TJvOdacDatasetThreadHandler.Create(Self, Self);
  inherited BeforeFetch := ReplaceBeforeFetch;
end;

destructor TJvOdacOraTable.Destroy;
begin
  FreeAndNil(FThreadHandler);
  inherited Destroy;
end;

procedure TJvOdacOraTable.BreakExecution;
begin
  BreakExec;
end;

function TJvOdacOraTable.CurrentFetchDuration: TDateTime;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.CurrentFetchDuration
  else
    Result := 0;
end;

function TJvOdacOraTable.CurrentOpenDuration: TDateTime;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.CurrentOpenDuration
  else
    Result := 0;
end;

procedure TJvOdacOraTable.DoAfterOpen;
begin
  ThreadHandler.AfterOpen;
end;

procedure TJvOdacOraTable.DoAfterRefresh;
begin
  ThreadHandler.AfterRefresh;
end;

procedure TJvOdacOraTable.DoBeforeOpen;
begin
  ThreadHandler.BeforeOpen;
end;

procedure TJvOdacOraTable.DoBeforeRefresh;
begin
  ThreadHandler.BeforeRefresh;
end;

procedure TJvOdacOraTable.DoInheritedAfterOpen;
begin
  inherited DoAfterOpen;
end;

procedure TJvOdacOraTable.DoInheritedAfterRefresh;
begin
  inherited DoAfterRefresh;
end;

procedure TJvOdacOraTable.DoInheritedBeforeOpen;
begin
  inherited DoBeforeOpen;
end;

procedure TJvOdacOraTable.DoInheritedBeforeRefresh;
begin
  inherited DoBeforeRefresh;
end;

procedure TJvOdacOraTable.DoInheritedInternalLast;
begin
  inherited InternalLast;
end;

procedure TJvOdacOraTable.DoInheritedInternalRefresh;
begin
  inherited InternalRefresh;
end;

procedure TJvOdacOraTable.DoInheritedSetActive(Active: Boolean);
begin
  inherited SetActive(Active);
end;

procedure TJvOdacOraTable.DoInternalOpen;
begin
  InternalOpen;
end;

function TJvOdacOraTable.ErrorException: Exception;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ErrorException
  else
    Result := Nil;
end;

function TJvOdacOraTable.ErrorMessage: string;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ErrorMessage
  else
    Result := '';
end;

function TJvOdacOraTable.GetAfterThreadExecution:
    TJvThreadedDatasetThreadEvent;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.AfterThreadExecution
  else
    Result := nil;
end;

function TJvOdacOraTable.GetBeforeThreadExecution:
    TJvThreadedDatasetThreadEvent;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.BeforeThreadExecution
  else
    Result := nil;
end;

function TJvOdacOraTable.GetDatasetFetchAllRecords: Boolean;
begin
  Result := FetchAll;
end;

function TJvOdacOraTable.GetDialogOptions: TJvThreadedDatasetDialogOptions;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.DialogOptions
  else
    Result := nil;
end;

function TJvOdacOraTable.GetEnhancedOptions:
    TJvOdacThreadedDatasetEnhancedOptions;
begin
  if Assigned(ThreadHandler) then
    Result := TJvOdacThreadedDatasetEnhancedOptions(ThreadHandler.EnhancedOptions)
  else
    Result := nil;
end;

function TJvOdacOraTable.GetThreadOptions: TJvThreadedDatasetThreadOptions;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ThreadOptions
  else
    Result := nil;
end;

procedure TJvOdacOraTable.InternalLast;
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.InternalLast;
end;

procedure TJvOdacOraTable.InternalRefresh;
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.InternalRefresh;
end;

function TJvOdacOraTable.IsThreadAllowed: Boolean;
begin
  if Assigned(MasterSource) and Assigned(MasterSource.Dataset) and (MasterSource.Dataset is TJvOdacSmartQuery) then
    Result := not TJvOdacSmartQuery(MasterSource.Dataset).ThreadHandler.ThreadIsActive
  else
    Result := True;
end;

procedure TJvOdacOraTable.ReplaceBeforeFetch(Dataset: TCustomDADataSet; var
    Cancel: Boolean);
begin
  if Assigned(ThreadHandler) then
    Cancel := ThreadHandler.CheckContinueRecordFetch <> tdccrContinue;
  if Assigned(BeforeFetch) then
    BeforeFetch(Dataset, Cancel);
end;

procedure TJvOdacOraTable.SetActive(Value: Boolean);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.SetActive(Value);
end;

procedure TJvOdacOraTable.SetAfterThreadExecution(const Value:
    TJvThreadedDatasetThreadEvent);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.AfterThreadExecution := Value;
end;

procedure TJvOdacOraTable.SetBeforeThreadExecution(const Value:
    TJvThreadedDatasetThreadEvent);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.BeforeThreadExecution := Value;
end;

procedure TJvOdacOraTable.SetDatasetFetchAllRecords(const Value: Boolean);
begin
  FetchAll := Value;
end;

procedure TJvOdacOraTable.SetDialogOptions(Value:
    TJvThreadedDatasetDialogOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.DialogOptions.Assign(Value);
end;

procedure TJvOdacOraTable.SetEnhancedOptions(const Value:
    TJvOdacThreadedDatasetEnhancedOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.EnhancedOptions.Assign(Value);
end;

procedure TJvOdacOraTable.SetThreadOptions(const Value:
    TJvThreadedDatasetThreadOptions);
begin
  if Assigned(ThreadHandler) then
    ThreadHandler.ThreadOptions.Assign(Value);
end;

function TJvOdacOraTable.ThreadIsActive: Boolean;
begin
  if Assigned(ThreadHandler) then
    Result := ThreadHandler.ThreadIsActive
  else
    Result := False;
end;



{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}
end.


