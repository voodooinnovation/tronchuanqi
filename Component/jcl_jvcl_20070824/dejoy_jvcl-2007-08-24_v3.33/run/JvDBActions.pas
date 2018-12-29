{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBActions.Pas, released on 2004-12-30.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBActions.pas 11458 2007-08-13 23:51:25Z jfudickar $

unit JvDBActions;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, ActnList, ImgList, Graphics,
  Forms, Controls, Classes, DB,
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  cxGridCustomTableView, cxDBData,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  {$IFDEF USE_3RDPARTY_SMEXPORT}
  SMEWIZ, ExportDS, SMEEngine,
  {$ENDIF USE_3RDPARTY_SMEXPORT}
  {$IFDEF USE_3RDPARTY_SMIMPORT}
  SMIWiz, SMIBase,
  {$ENDIF USE_3RDPARTY_SMIMPORT}
  DBGrids, JvActionsEngine, JvDBActionsEngine, JvDynControlEngineDBTools;

type

  TJvChangeDataComponent = procedure(DataComponent: TComponent) of object;
  TJvDatabaseActionList = class(TActionList)
  private
    FDataComponent: TComponent;
    FOnChangeDataComponent: TJvChangeDataComponent;
  protected
    procedure SetDataComponent(Value: TComponent);
  public
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property DataComponent: TComponent read FDataComponent write SetDataComponent;
    property OnChangeDataComponent: TJvChangeDataComponent read
      FOnChangeDataComponent write FOnChangeDataComponent;
  end;

  TJvDatabaseActionBaseEngineClass = class of TJvDatabaseActionBaseControlEngine;

  TJvDatabaseExecuteEvent = procedure(Sender: TObject; ControlEngine: TJvDatabaseActionBaseControlEngine;
    DataComponent: TComponent) of object;
  TJvDatabaseExecuteDataSourceEvent = procedure(Sender: TObject; DataSource: TDataSource) of object;

  TJvDatabaseBaseAction = class(TJvActionEngineBaseAction)
  private
    FDatabaseControlEngine: TJvDatabaseActionBaseControlEngine;
    FOnExecute: TJvDatabaseExecuteEvent;
    FOnExecuteDataSource: TJvDatabaseExecuteDataSourceEvent;
    FDatasetEngine: TJvDatabaseActionBaseDatasetEngine;
    FOnChangeDataComponent: TJvChangeDataComponent;
  protected
    //1 This Procedure is called when the ActionComponent is changed
    procedure ChangeActionComponent(const AActionComponent: TComponent); override;
    function GetDataComponent: TComponent;
    procedure SetDataComponent(Value: TComponent);
    procedure SetEnabled(Value: Boolean);
    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function EngineIsActive: Boolean;
    function EngineHasData: Boolean;
    function EngineFieldCount: Integer;
    function EngineRecordCount: Integer;
    function EngineRecNo: Integer;
    function EngineCanInsert: Boolean;
    function EngineCanUpdate: Boolean;
    function EngineCanDelete: Boolean;
    function EngineEof: Boolean;
    function EngineBof: Boolean;
    function EngineCanNavigate: Boolean;
    function EngineCanRefresh: Boolean;
    function EngineControlsDisabled: Boolean;
    function EngineEditModeActive: Boolean;
    function EngineSelectedRowsCount: Integer;
    function GetEngineList: TJvActionEngineList; override;
    property DatabaseControlEngine: TJvDatabaseActionBaseControlEngine read
        FDatabaseControlEngine;
    property DatasetEngine: TJvDatabaseActionBaseDatasetEngine read FDatasetEngine;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    property DataSource: TDataSource read GetDataSource;
    property DataSet: TDataSet read GetDataSet;
  published
    property OnChangeDataComponent: TJvChangeDataComponent read
        FOnChangeDataComponent write FOnChangeDataComponent;
    property OnExecute: TJvDatabaseExecuteEvent read FOnExecute write FOnExecute;
    property OnExecuteDataSource: TJvDatabaseExecuteDataSourceEvent
      read FOnExecuteDataSource write FOnExecuteDataSource;
    property DataComponent: TComponent read GetDataComponent write SetDataComponent;
  end;

  TJvDatabaseSimpleAction = class(TJvDatabaseBaseAction)
  private
    FIsActive: Boolean;
    FHasData: Boolean;
    FCanInsert: Boolean;
    FCanUpdate: Boolean;
    FCanDelete: Boolean;
    FEditModeActive: Boolean;
    FManualEnabled: Boolean;
    procedure SetManualEnabled(const Value: Boolean);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    // If this paramater is active, the Action will be enabled if for the datacomponent-dataset is active
    property IsActive: Boolean read FIsActive write FIsActive default True;
    // If this paramater is active, the Action will be enabled if for the datacomponent-dataset contains records
    property HasData: Boolean read FHasData write FHasData default True;
    // If this paramater is active, the Action will be enabled if insert is allowed for the datacomponent-dataset
    property CanInsert: Boolean read FCanInsert write FCanInsert default False;
    // If this paramater is active, the Action will be enabled if update is allowed for the datacomponent-dataset
    property CanUpdate: Boolean read FCanUpdate write FCanUpdate default False;
    // If this paramater is active, the Action will be enabled if delete is allowed for the datacomponent-dataset
    property CanDelete: Boolean read FCanDelete write FCanDelete default False;
    // If this paramater is active, the Action will be enabled if the datacomponent-dataset is in edit mode
    property EditModeActive: Boolean read FEditModeActive write FEditModeActive default False;
    // This property allows you enable / disable the action independently from the
    // automatic handling by IsActive, HasData, CanInsert, CanUpdate, EditModeActive
    property ManualEnabled: Boolean read FManualEnabled write SetManualEnabled default True;
  end;

  TJvDatabaseBaseActiveAction = class(TJvDatabaseBaseAction)
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

  TJvDatabaseBaseEditAction = class(TJvDatabaseBaseActiveAction)
  public
    procedure UpdateTarget(Target: TObject); override;
  end;

  TJvDatabaseBaseNavigateAction = class(TJvDatabaseBaseActiveAction)
  end;

  TJvDatabaseFirstAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseLastAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabasePriorAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseNextAction = class(TJvDatabaseBaseNavigateAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabasePriorBlockAction = class(TJvDatabaseBaseNavigateAction)
  public
    FBlockSize: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property BlockSize: Integer read FBlockSize write FBlockSize default 50;
  end;

  TJvDatabaseNextBlockAction = class(TJvDatabaseBaseNavigateAction)
  private
    FBlockSize: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property BlockSize: Integer read FBlockSize write FBlockSize default 50;
  end;

  TJvDatabaseRefreshAction = class(TJvDatabaseBaseActiveAction)
  private
    FRefreshLastPosition: Boolean;
    FRefreshAsOpenClose: Boolean;
  protected
    procedure Refresh;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property RefreshLastPosition: Boolean read FRefreshLastPosition write FRefreshLastPosition default True;
    property RefreshAsOpenClose: Boolean read FRefreshAsOpenClose write FRefreshAsOpenClose default False;
  end;

  TJvDatabasePositionAction = class(TJvDatabaseBaseNavigateAction)
  private
    FMinCountSelectedRows: Integer;
    FShowSelectedRows: Boolean;
  protected
    procedure SetCaption(Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ShowPositionDialog;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MinCountSelectedRows: Integer read FMinCountSelectedRows write
        FMinCountSelectedRows default 2;
    property ShowSelectedRows: Boolean read FShowSelectedRows write
      FShowSelectedRows default True;
  end;

  TJvDatabaseInsertAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseOnCopyRecord = procedure(Field: TField; OldValue: Variant) of object;
  TJvDatabaseBeforeCopyRecord = procedure(DataSet: TDataSet; var RefreshAllowed: Boolean) of object;
  TJvDatabaseAfterCopyRecord = procedure(DataSet: TDataSet) of object;

  TJvDatabaseCopyAction = class(TJvDatabaseBaseEditAction)
  private
    FBeforeCopyRecord: TJvDatabaseBeforeCopyRecord;
    FAfterCopyRecord: TJvDatabaseAfterCopyRecord;
    FOnCopyRecord: TJvDatabaseOnCopyRecord;
  public
    procedure CopyRecord;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property BeforeCopyRecord: TJvDatabaseBeforeCopyRecord read FBeforeCopyRecord write FBeforeCopyRecord;
    property AfterCopyRecord: TJvDatabaseAfterCopyRecord read FAfterCopyRecord write FAfterCopyRecord;
    property OnCopyRecord: TJvDatabaseOnCopyRecord read FOnCopyRecord write FOnCopyRecord;
  end;

  TJvDatabaseEditAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseDeleteAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabasePostAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseCancelAction = class(TJvDatabaseBaseEditAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseSingleRecordWindowAction = class(TJvDatabaseBaseActiveAction)
  private
    FOnCreateDataControlsEvent: TJvDataSourceEditDialogCreateDataControlsEvent;
    FOptions: TJvShowSingleRecordWindowOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure ShowSingleRecordWindow;
  published
    property OnCreateDataControlsEvent:
        TJvDataSourceEditDialogCreateDataControlsEvent read
        FOnCreateDataControlsEvent write FOnCreateDataControlsEvent;
    property Options: TJvShowSingleRecordWindowOptions read FOptions write FOptions;
  end;

  TJvDatabaseOpenAction = class(TJvDatabaseBaseActiveAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TJvDatabaseCloseAction = class(TJvDatabaseBaseActiveAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  {$IFDEF USE_3RDPARTY_SMEXPORT}

  TJvDatabaseSMExportOptions = class(TPersistent)
  private
    FOnAfterExecuteExport: TNotifyEvent;
    FOnBeforeExecuteExport: TNotifyEvent;
    FHelpContext: THelpContext;
    FFormats: TExportFormatTypes;
    FTitle: TCaption;
    FDefaultOptionsDirectory: string;
    FKeyGenerator: string;
    FOptions: TSMOptions;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SMEWizardDlgGetCellParams(Sender: TObject; Field: TField; var Text: string;
      AFont: TFont; var Alignment: TAlignment; var Background: TColor; var CellType: TCellType);
    procedure SMEWizardDlgOnBeforeExecute(Sender: TObject);
  published
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property Formats: TExportFormatTypes read FFormats write FFormats;
    property Title: TCaption read FTitle write FTitle;
    property DefaultOptionsDirectory: string read FDefaultOptionsDirectory write FDefaultOptionsDirectory;
    property KeyGenerator: string read FKeyGenerator write FKeyGenerator;
    property Options: TSMOptions read FOptions write FOptions;
    property OnAfterExecuteExport: TNotifyEvent read FOnAfterExecuteExport write FOnAfterExecuteExport;
    property OnBeforeExecuteExport: TNotifyEvent read FOnBeforeExecuteExport write FOnBeforeExecuteExport;
  end;

  TJvDatabaseSMExportAction = class(TJvDatabaseBaseActiveAction)
  private
    FOptions: TJvDatabaseSMExportOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure ExportData;
  published
    property Options: TJvDatabaseSMExportOptions read FOptions write FOptions;
  end;

  {$ENDIF USE_3RDPARTY_SMEXPORT}

  {$IFDEF USE_3RDPARTY_SMIMPORT}

  TJvDatabaseSMImportOptions = class(TPersistent)
  private
    FHelpContext: THelpContext;
    FFormats: TImportFormatTypes;
    FTitle: TCaption;
    FDefaultOptionsDirectory: string;
    FOptions: TSMIOptions;
    FWizardStyle: TSMIWizardStyle;
  public
    constructor Create;
  published
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property Formats: TImportFormatTypes read FFormats write FFormats;
    property Title: TCaption read FTitle write FTitle;
    property DefaultOptionsDirectory: string read FDefaultOptionsDirectory write FDefaultOptionsDirectory;
    property Options: TSMIOptions read FOptions write FOptions;
    property WizardStyle: TSMIWizardStyle read FWizardStyle write FWizardStyle;
  end;

  TJvDatabaseSMImportAction = class(TJvDatabaseBaseEditAction)
  private
    FOptions: TJvDatabaseSMImportOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure ImportData;
  published
    property Options: TJvDatabaseSMImportOptions read FOptions write FOptions;
  end;

  {$ENDIF USE_3RDPARTY_SMIMPORT}

  TJvDatabaseModifyAllAction = class(TJvDatabaseBaseEditAction)
  private
    FEnabledOnlyIfSelectedRows: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure ModifyAll;
    procedure UpdateTarget(Target: TObject); override;
  published
    property EnabledOnlyIfSelectedRows: Boolean read FEnabledOnlyIfSelectedRows
      write FEnabledOnlyIfSelectedRows default True;
  end;

  TJvDatabaseShowSQLStatementAction = class(TJvDatabaseBaseActiveAction)
  private
    FWordWrap: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure ShowSQLStatement;
    procedure UpdateTarget(Target: TObject); override;
  published
    //1 Defines if the memo for the sql-statement is word-wrapped
    property WordWrap: Boolean read FWordWrap write FWordWrap default True;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvDBActions.pas $';
    Revision: '$Revision: 11458 $';
    Date: '$Date: 2007-08-13 16:51:25 -0700 (Mon, 13 Aug 2007) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, Grids, TypInfo,
  {$IFDEF HAS_UNIT_STRUTILS}
  StrUtils,
  {$ENDIF HAS_UNIT_STRUTILS}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  cxGrid, cxGridDBDataDefinitions,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  {$IFDEF USE_3RDPARTY_SMEXPORT}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEEngCx,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  sme2sql, IniFiles,
  {$ENDIF USE_3RDPARTY_SMEXPORT}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  cxCustomData,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  JvResources, JvParameterList, JvParameterListParameter,
  JvDSADialogs,
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  Dialogs, StdCtrls, Clipbrd;

//=== { TJvDatabaseActionList } ==============================================

procedure TJvDatabaseActionList.SetDataComponent(Value: TComponent);
var
  I: Integer;
begin
  if Value <> FDataComponent then
  begin
    FDataComponent := Value;
    if FDataComponent <> nil then
      FDataComponent.FreeNotification(Self);
    for I := 0 to ActionCount - 1 do
      if Actions[I] is TJvDatabaseBaseAction then
        TJvDatabaseBaseAction(Actions[I]).DataComponent := Value;
    if Assigned(OnChangeDataComponent) then
      OnChangeDataComponent(Value);
  end;
end;

procedure TJvDatabaseActionList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FDataComponent then
      DataComponent := nil;
end;

//=== { TJvDatabaseBaseAction } ==============================================

constructor TJvDatabaseBaseAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if Assigned(AOwner) and (AOwner is TJvDatabaseActionList) then
    DataComponent := TJvDatabaseActionList(AOwner).DataComponent;
  FDatabaseControlEngine := Nil;
end;

//=== { TJvActionEngineBaseAction } ========================================

procedure TJvDatabaseBaseAction.ChangeActionComponent(const AActionComponent:
    TComponent);
begin
  inherited ChangeActionComponent(AActionComponent);
  if Assigned(ControlEngine) and (ControlEngine is TJvDatabaseActionBaseControlEngine) then
    FDatabaseControlEngine := TJvDatabaseActionBaseControlEngine(ControlEngine)
  else
    FDatabaseControlEngine := Nil;
  if Assigned(Dataset) then
  begin
    if Assigned(EngineList) and (EngineList is TJvDatabaseActionEngineList) then
      FDatasetEngine := TJvDatabaseActionEngineList(EngineList).GetDatasetEngine(Dataset)
    else
      FDatasetEngine := Nil;
  end
  else
    FDatasetEngine := nil;
end;

function TJvDatabaseBaseAction.GetDataSet: TDataSet;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.DataSet(ActionComponent)
  else
    Result := nil;
end;

function TJvDatabaseBaseAction.GetDataSource: TDataSource;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.DataSource(ActionComponent)
  else
    Result := nil;
end;

procedure TJvDatabaseBaseAction.SetDataComponent(Value: TComponent);
begin
  ActionComponent := Value;
end;

procedure TJvDatabaseBaseAction.SetEnabled(Value: Boolean);
begin
  if Enabled <> Value then
    Enabled := Value;
end;

function TJvDatabaseBaseAction.EngineIsActive: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.IsActive (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineHasData: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.HasData (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineFieldCount: Integer;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.FieldCount (DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.EngineRecordCount: Integer;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.RecordCount (DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.EngineRecNo: Integer;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.RecNo (DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.EngineCanInsert: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.CanInsert (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineCanUpdate: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.CanUpdate (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineCanDelete: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.CanDelete (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineEof: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.EOF (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineBof: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.Bof (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineCanNavigate: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.CanNavigate (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineCanRefresh: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.CanRefresh (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineControlsDisabled: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.ControlsDisabled (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineEditModeActive: Boolean;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.EditModeActive (DataComponent)
  else
    Result := False;
end;

function TJvDatabaseBaseAction.EngineSelectedRowsCount: Integer;
begin
  if Assigned(DatabaseControlEngine) then
    Result := DatabaseControlEngine.SelectedRowsCount (DataComponent)
  else
    Result := -1;
end;

function TJvDatabaseBaseAction.HandlesTarget(Target: TObject): Boolean;
begin
  //  Result := inherited HandlesTarget(Target);
  Result := Assigned(ControlEngine);
end;

procedure TJvDatabaseBaseAction.UpdateTarget(Target: TObject);
begin
  if Assigned(DataSet) and not EngineControlsDisabled then
    SetEnabled(True)
  else
    SetEnabled(False);
end;

procedure TJvDatabaseBaseAction.ExecuteTarget(Target: TObject);
begin
  if Assigned(FOnExecute) and Assigned(DatabaseControlEngine) then
    FOnExecute(Self, DatabaseControlEngine, DataComponent)
  else
    if Assigned(FOnExecuteDataSource) then
      FOnExecuteDataSource(Self, DataSource)
    else
      inherited ExecuteTarget(Target);
end;

function TJvDatabaseBaseAction.GetDataComponent: TComponent;
begin
  Result := ActionComponent;
end;

function TJvDatabaseBaseAction.GetEngineList: TJvActionEngineList;
begin
  Result := RegisteredDatabaseActionEngineList;
end;

//=== { TJvDatabaseSimpleAction } ============================================

constructor TJvDatabaseSimpleAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsActive := True;
  FHasData := True;
  FCanInsert := False;
  FCanUpdate := False;
  FCanDelete := False;
  FEditModeActive := False;
  FManualEnabled := True;
end;

procedure TJvDatabaseSimpleAction.SetManualEnabled(const Value: Boolean);
begin
  FManualEnabled := Value;
  UpdateTarget(Self);
end;

procedure TJvDatabaseSimpleAction.UpdateTarget(Target: TObject);
var
  Res: Boolean;
begin
  if Assigned(DataSet) and not EngineControlsDisabled then
  begin
    Res := ManualEnabled;
    if IsActive then
      Res := Res and EngineIsActive;
    if HasData then
      Res := Res and EngineHasData;
    if CanInsert then
      Res := Res and EngineCanInsert;
    if CanUpdate then
      Res := Res and EngineCanUpdate;
    if CanDelete then
      Res := Res and EngineCanDelete;
    if EditModeActive then
      Res := Res and EngineEditModeActive;
    SetEnabled(Res);
  end
  else
    SetEnabled(False);
end;

//=== { TJvDatabaseBaseActiveAction } ========================================

procedure TJvDatabaseBaseActiveAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive);
end;

//=== { TJvDatabaseBaseEditAction } ==========================================

procedure TJvDatabaseBaseEditAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    (EngineCanInsert or EngineCanUpdate or EngineCanDelete));
end;

//=== { TJvDatabaseFirstAction } =============================================

procedure TJvDatabaseFirstAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DatabaseControlEngine) and not EngineControlsDisabled and EngineIsActive and
    not EngineBof and EngineCanNavigate);
end;

procedure TJvDatabaseFirstAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DatabaseControlEngine.First (DataComponent);
end;

//=== { TJvDatabaseLastAction } ==============================================

procedure TJvDatabaseLastAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DatabaseControlEngine) and not EngineControlsDisabled and EngineIsActive and
    not EngineEof and EngineCanNavigate);
end;

procedure TJvDatabaseLastAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DatabaseControlEngine.Last (DataComponent);
end;

//=== { TJvDatabasePriorAction } =============================================

procedure TJvDatabasePriorAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DatabaseControlEngine) and not EngineControlsDisabled and EngineIsActive and
    not EngineBof and EngineCanNavigate);
end;

procedure TJvDatabasePriorAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DatabaseControlEngine.MoveBy(DataComponent,-1);
end;

//=== { TJvDatabaseNextAction } ==============================================

procedure TJvDatabaseNextAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DatabaseControlEngine) and not EngineControlsDisabled and EngineIsActive and
    not EngineEof and EngineCanNavigate);
end;

procedure TJvDatabaseNextAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DatabaseControlEngine.MoveBy(DataComponent,1);
end;

//=== { TJvDatabasePriorBlockAction } ========================================

constructor TJvDatabasePriorBlockAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBlockSize := 50;
end;

procedure TJvDatabasePriorBlockAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DatabaseControlEngine) and not EngineControlsDisabled and EngineIsActive and
    not EngineBof and EngineCanNavigate);
end;

procedure TJvDatabasePriorBlockAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  with DatabaseControlEngine do
  try
    DisableControls(DataComponent);
    MoveBy(DataComponent, -BlockSize);
  finally
    EnableControls(DataComponent);
  end;
end;

//=== { TJvDatabaseNextBlockAction } =========================================

constructor TJvDatabaseNextBlockAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBlockSize := 50;
end;

procedure TJvDatabaseNextBlockAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DatabaseControlEngine) and not EngineControlsDisabled and EngineIsActive and
    not EngineEof and EngineCanNavigate);
end;

procedure TJvDatabaseNextBlockAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  with DatabaseControlEngine do
  try
    DisableControls(DataComponent);
    MoveBy(DataComponent, BlockSize);
  finally
    EnableControls(DataComponent);
  end;
end;

//=== { TJvDatabaseRefreshAction } ===========================================

constructor TJvDatabaseRefreshAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRefreshLastPosition := True;
  FRefreshAsOpenClose := False;
end;

procedure TJvDatabaseRefreshAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  Refresh;
end;

procedure TJvDatabaseRefreshAction.Refresh;
var
  MyBookmark: TBookmark;
begin
  with DatabaseControlEngine.DataSet(DataComponent) do
  begin
    MyBookmark := nil;
    if RefreshLastPosition then
      MyBookmark := GetBookmark;

    try
      if RefreshAsOpenClose then
      begin
        Close;
        Open;
      end
      else
        Refresh;

      if RefreshLastPosition then
        if Active then
          if Assigned(MyBookmark) then
            if BookmarkValid(MyBookmark) then
            try
              GotoBookmark(MyBookmark);
            except
            end;
    finally
      if RefreshLastPosition then
        FreeBookmark(MyBookmark);
    end;
  end;
end;

//=== { TJvDatabaseBaseActiveAction } ========================================

procedure TJvDatabaseRefreshAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and EngineCanRefresh);
end;

//=== { TJvDatabasePositionAction } ==========================================

constructor TJvDatabasePositionAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowSelectedRows := True;
  FMinCountSelectedRows := 2;
end;

procedure TJvDatabasePositionAction.UpdateTarget(Target: TObject);
const
  cFormat = ' %3d / %3d ';
  cFormatSelected = ' %3d / %3d (%d)';
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and
    EngineIsActive and EngineHasData and EngineCanNavigate);
  try
    if not EngineIsActive then
      SetCaption(Format(cFormat, [0, 0]))
    else
      if EngineRecordCount = 0 then
        SetCaption(Format(cFormat, [0, 0]))
      else
        if ShowSelectedRows and (EngineSelectedRowsCount >= MinCountSelectedRows) then
          SetCaption(Format(cFormatSelected, [EngineRecNo, EngineRecordCount, EngineSelectedRowsCount]))
        else
          SetCaption(Format(cFormat, [EngineRecNo, EngineRecordCount]));
  except
    SetCaption(Format(cFormat, [0, 0]));
  end;
end;

procedure TJvDatabasePositionAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  ShowPositionDialog;
end;

procedure TJvDatabasePositionAction.SetCaption(Value: string);
begin
  if Value <> Caption then
    Caption := Value;
end;

procedure TJvDatabasePositionAction.ShowPositionDialog;
const
  cCurrentPosition = 'CurrentPosition';
  cNewPosition = 'NewPosition';
  cKind = 'Kind';
var
  ParameterList: TJvParameterList;
  Parameter: TJvBaseParameter;
  S: string;
  Kind: Integer;
begin
  if not Assigned(DataSet) then
    Exit;
  ParameterList := TJvParameterList.Create(Self);
  try
    Parameter := TJvBaseParameter(TJvEditParameter.Create(ParameterList));
    with TJvEditParameter(Parameter) do
    begin
      SearchName := cCurrentPosition;
      ReadOnly := True;
      Caption := RsDBPosCurrentPosition;
      AsString := IntToStr(EngineRecNo + 1) + ' / ' + IntToStr(EngineRecordCount);
      Width := 150;
      LabelWidth := 80;
      Enabled := False;
    end;
    ParameterList.AddParameter(Parameter);
    Parameter := TJvBaseParameter(TJvEditParameter.Create(ParameterList));
    with TJvEditParameter(Parameter) do
    begin
      Caption := RsDBPosNewPosition;
      SearchName := cNewPosition;
      // EditMask := '999999999;0;_';
      Width := 150;
      LabelWidth := 80;
    end;
    ParameterList.AddParameter(Parameter);
    Parameter := TJvBaseParameter(TJvRadioGroupParameter.Create(ParameterList));
    with TJvRadioGroupParameter(Parameter) do
    begin
      Caption := RsDBPosMovementType;
      SearchName := cKind;
      Width := 305;
      Height := 54;
      Columns := 2;
      ItemList.Add(RsDBPosAbsolute);
      ItemList.Add(RsDBPosForward);
      ItemList.Add(RsDBPosBackward);
      ItemList.Add(RsDBPosPercental);
      ItemIndex := 0;
    end;
    ParameterList.AddParameter(Parameter);
    ParameterList.ArrangeSettings.WrapControls := True;
    ParameterList.ArrangeSettings.MaxWidth := 350;
    ParameterList.Messages.Caption := RsDBPosDialogCaption;
    if ParameterList.ShowParameterDialog then
    begin
      S := ParameterList.ParameterByName(cNewPosition).AsString;
      if S = '' then
        Exit;
      Kind := TJvRadioGroupParameter(ParameterList.ParameterByName(cKind)).ItemIndex;
      DataSet.DisableControls;
      try
        case Kind of
          0:
            begin
              DataSet.First;
              DataSet.MoveBy(StrToInt(S) - 1);
            end;
          1:
            DataSet.MoveBy(StrToInt(S));
          2:
            DataSet.MoveBy(StrToInt(S) * -1);
          3:
            begin
              DataSet.First;
              DataSet.MoveBy(Round((EngineRecordCount / 100.0) * StrToInt(S)) - 1);
            end;
        end;
      finally
        DataSet.EnableControls;
      end;
    end;
  finally
    ParameterList.Free;
  end;
end;

//=== { TJvDatabaseInsertAction } ============================================

procedure TJvDatabaseInsertAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and
    EngineIsActive and EngineCanInsert and not EngineEditModeActive);
end;

procedure TJvDatabaseInsertAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Insert;
end;

//=== { TJvDatabaseCopyAction } ==============================================

procedure TJvDatabaseCopyAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    EngineCanInsert and EngineHasData and not EngineEditModeActive);
end;

procedure TJvDatabaseCopyAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  CopyRecord;
end;

procedure TJvDatabaseCopyAction.CopyRecord;
var
  Values: array of Variant;
  I: Integer;
  Value: Variant;
  Allowed: Boolean;
begin
  with DataSet do
  begin
    if not Active then
      Exit;
    if State in [dsInsert, dsEdit] then
      Post;
    if State <> dsBrowse then
      Exit;
    Allowed := True;
  end;
  if Assigned(FBeforeCopyRecord) then
    FBeforeCopyRecord(DataSet, Allowed);
  with DataSet do
  begin
    // (rom) this suppresses AfterCopyRecord. Is that desired?
    if not Allowed then
      Exit;
    SetLength(Values, FieldCount);
    for I := 0 to FieldCount - 1 do
      Values[I] := Fields[I].AsVariant;
    Insert;
    if Assigned(FOnCopyRecord) then
      for I := 0 to FieldCount - 1 do
      begin
        Value := Values[I];
        FOnCopyRecord(Fields[I], Value);
      end
    else
      for I := 0 to FieldCount - 1 do
        Fields[I].AsVariant := Values[I];
  end;
  if Assigned(FAfterCopyRecord) then
    FAfterCopyRecord(DataSet);
end;

//=== { TJvDatabaseEditAction } ==============================================

procedure TJvDatabaseEditAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    EngineCanUpdate and EngineHasData and not EngineEditModeActive);
end;

procedure TJvDatabaseEditAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Edit;
end;

//=== { TJvDatabaseDeleteAction } ============================================

procedure TJvDatabaseDeleteAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and
    EngineCanDelete and EngineHasData and not EngineEditModeActive);
end;

procedure TJvDatabaseDeleteAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Delete;
end;

//=== { TJvDatabasePostAction } ==============================================

procedure TJvDatabasePostAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and EngineEditModeActive);
end;

procedure TJvDatabasePostAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Post;
end;

//=== { TJvDatabaseCancelAction } ============================================

procedure TJvDatabaseCancelAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and EngineIsActive and EngineEditModeActive);
end;

procedure TJvDatabaseCancelAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Cancel;
end;

//=== { TJvDatabaseSingleRecordWindowAction } ================================

constructor TJvDatabaseSingleRecordWindowAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := TJvShowSingleRecordWindowOptions.Create;
end;

destructor TJvDatabaseSingleRecordWindowAction.Destroy;
begin
  FOptions.Free;
  inherited Destroy;
end;

procedure TJvDatabaseSingleRecordWindowAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  ShowSingleRecordWindow
end;

procedure TJvDatabaseSingleRecordWindowAction.ShowSingleRecordWindow;
begin
  DatabaseControlEngine.ShowSingleRecordWindow(DataComponent, Options, onCreateDataControlsEvent);
end;

//=== { TJvDatabaseOpenAction } ==============================================

procedure TJvDatabaseOpenAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineIsActive);
end;

procedure TJvDatabaseOpenAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Open;
end;

//=== { TJvDatabaseCloseAction } =============================================

procedure TJvDatabaseCloseAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and EngineIsActive and not EngineEditModeActive);
end;

procedure TJvDatabaseCloseAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  DataSet.Close;
end;

{$IFDEF USE_3RDPARTY_SMEXPORT}

//=== { TJvDatabaseSMExportOptions } =========================================

constructor TJvDatabaseSMExportOptions.Create;
var
  Fmt: TTableTypeExport;
  Option: TSMOption;
begin
  inherited Create;
  FFormats := [];
  for Fmt := Low(Fmt) to High(Fmt) do
    FFormats := FFormats + [Fmt];
  FOptions := [];
  for Option := Low(Option) to High(Option) do
    FOptions := FOptions + [Option];
  //  FDataFormats := TSMEDataFormats.Create;
end;

destructor TJvDatabaseSMExportOptions.Destroy;
begin
  //  FreeAndNil(FDataFormats);
  inherited Destroy;
end;

procedure TJvDatabaseSMExportOptions.SMEWizardDlgGetCellParams(Sender: TObject; Field: TField;
  var Text: string; AFont: TFont; var Alignment: TAlignment; var Background: TColor; var CellType: TCellType);
const
  SToDateFormatLong = 'TO_DATE(''%s'', ''DD.MM.YYYY HH24:MI:SS'')';
  SToDateFormatShort = 'TO_DATE(''%s'', ''DD.MM.YYYY'')';
  SFormatLong = 'dd.mm.yyyy hh:nn:ss';
  SFormatShort = 'dd.mm.yyyy';
  SNull = 'NULL';
var
  DT: TDateTime;
begin
  if Sender is TSMExportToSQL then
    if Assigned(Field) then
    begin
      if Field.IsNull or (Field.AsString = '') then
      begin
        Text := SNull;
        CellType := ctBlank;
      end
      else
        case Field.DataType of
          ftFloat, ftBCD, ftCurrency:
            Text := AnsiReplaceStr(Text, ',', '.');
          ftDate, ftDateTime:
            begin
              DT := Field.AsDateTime;
              if DT <= 0 then
                Text := SNull
              else
                if DT = Trunc(DT) then
                  Text := Format(SToDateFormatShort, [FormatDateTime(SFormatShort, DT)])
                else
                  Text := Format(StoDateFormatLong, [FormatDateTime(SFormatLong, DT)]);
              CellType := ctBlank;
            end;
        end;
    end
    else
      if Text = '' then
      begin
        Text := SNull;
        CellType := ctBlank;
      end
      else
        case CellType of
          ctDouble, ctCurrency:
            Text := AnsiReplaceStr(Text, ',', '.');
          ctDateTime, ctDate, ctTime:
            begin
              try
                DT := VarToDateTime(Text);
                if DT <= 0 then
                  Text := SNull
                else
                  if DT = Trunc(DT) then
                    Text := Format(SToDateFormatShort, [FormatDateTime(SFormatShort, DT)])
                  else
                    Text := Format(StoDateFormatLong, [FormatDateTime(SFormatLong, DT)]);
              except
                Text := Format(StoDateFormatLong, [Text]);
              end;
              CellType := ctBlank;
            end;
        end;
end;

procedure TJvDatabaseSMExportOptions.SMEWizardDlgOnBeforeExecute(Sender: TObject);
begin
  if Assigned(FOnBeforeExecuteExport) then
    FOnBeforeExecuteExport(Sender)
  else
    if Sender is TSMExportToSQL then
      TSMExportToSQL(Sender).SQLQuote := '''';
end;

//=== { TJvDatabaseSMExportAction } ==========================================

constructor TJvDatabaseSMExportAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := TJvDatabaseSMExportOptions.Create;
end;

destructor TJvDatabaseSMExportAction.Destroy;
begin
  FOptions.Free;
  inherited Destroy;
end;

procedure TJvDatabaseSMExportAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  ExportData;
end;

procedure TJvDatabaseSMExportAction.ExportData;
const
  cLastExport = '\Last Export.SME';
var
  SMEWizardDlg: TSMEWizardDlg;
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEEngineCx: TSMEcxCustomGridTableViewDataEngine;
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
begin
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEEngineCx := nil;
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
  SMEWizardDlg := TSMEWizardDlg.Create(Self);
  try
    SMEWizardDlg.ColumnSource := csDataSet;
    SMEWizardDlg.OnGetCellParams := Options.SMEWizardDlgGetCellParams;
    SMEWizardDlg.OnBeforeExecute := Options.SMEWizardDlgOnBeforeExecute;
    SMEWizardDlg.OnAfterExecute := Options.OnAfterExecuteExport;
    SMEWizardDlg.DataSet := DataSource.DataSet;
    SMEWizardDlg.Title := Options.Title;
    SMEWizardDlg.KeyGenerator := Options.Title;
    SMEWizardDlg.WizardStyle := smewiz.wsWindows2000;
    if (Options.DefaultOptionsDirectory <> '') and DirectoryExists(Options.DefaultOptionsDirectory) then
      SMEWizardDlg.SpecificationDir := ExcludeTrailingPathDelimiter(Options.DefaultOptionsDirectory)
    else
      SMEWizardDlg.SpecificationDir := GetCurrentDir;
    if DataComponent is TCustomDBGrid then
    begin
      SMEWizardDlg.DBGrid := TCustomControl(DataComponent);
      SMEWizardDlg.ColumnSource := csDBGrid;
    end
    {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    else
      if (DataComponent is TcxGrid) and (TcxGrid(DataComponent).FocusedView is TcxCustomGridTableView) then
      begin
        SMEEnginecx := TSMEcxCustomGridTableViewDataEngine.Create(Self);
        SMEEngineCx.cxCustomGridTableView := TcxCustomGridTableView(TcxGrid(DataComponent).FocusedView);
        SMEWizardDlg.DataEngine := SMEEngineCx;
        SMEWizardDlg.ColumnSource := csDataEngine;
      end
      else
        if DataComponent is TcxCustomGridTableView then
        begin
          SMEEnginecx := TSMEcxCustomGridTableViewDataEngine.Create(Self);
          SMEEngineCx.cxCustomGridTableView := TcxCustomGridTableView(DataComponent);
          SMEWizardDlg.DataEngine := SMEEngineCx;
          SMEWizardDlg.ColumnSource := csDataEngine;
        end
    {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
        else
        begin
          SMEWizardDlg.DataSet := DataSet;
          SMEWizardDlg.ColumnSource := csDataSet;
        end;

    SMEWizardDlg.Formats := Options.Formats;
    SMEWizardDlg.Options := Options.Options;
    SMEWizardDlg.HelpContext := Options.HelpContext;
    if FileExists(SMEWizardDlg.SpecificationDir + cLastExport) then
      SMEWizardDlg.LoadSpecification(SMEWizardDlg.SpecificationDir + cLastExport);
    SMEWizardDlg.Execute;
    SMEWizardDlg.SaveSpecification('Last Export', SMEWizardDlg.SpecificationDir + cLastExport, False);
  finally
    {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    FreeAndNil(SMEEngineCx);
    {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXGRID}
    FreeAndNil(SMEWizardDlg);
  end;
end;

{$ENDIF USE_3RDPARTY_SMEXPORT}

{$IFDEF USE_3RDPARTY_SMIMPORT}

//=== { TJvDatabaseSMImportOptions } =========================================

constructor TJvDatabaseSMImportOptions.Create;
var
  Fmt: TTableTypeImport;
  Option: TSMIOption;
begin
  inherited Create;
  FFormats := [];
  for Fmt := Low(Fmt) to High(Fmt) do
    FFormats := FFormats + [Fmt];
  FOptions := [];
  for Option := Low(Option) to High(Option) do
    FOptions := FOptions + [Option];
end;

//=== { TJvDatabaseSMImportAction } ==========================================

constructor TJvDatabaseSMImportAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := TJvDatabaseSMImportOptions.Create;
end;

destructor TJvDatabaseSMImportAction.Destroy;
begin
  FOptions.Free;
  inherited Destroy;
end;

procedure TJvDatabaseSMImportAction.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  ImportData;
end;

procedure TJvDatabaseSMImportAction.ImportData;
var
  SMIWizardDlg: TSMIWizardDlg;
begin
  SMIWizardDlg := TSMIWizardDlg.Create(Self);
  try
    //    SMIWizardDlg.OnGetSpecifications := Options.SMIWizardDlgGetSpecifications;
    if (Options.DefaultOptionsDirectory <> '') and DirectoryExists(Options.DefaultOptionsDirectory) then
      SMIWizardDlg.SpecificationDir := ExcludeTrailingPathDelimiter(Options.DefaultOptionsDirectory)
    else
      SMIWizardDlg.SpecificationDir := GetCurrentDir;
    SMIWizardDlg.DataSet := DataSource.DataSet;
    SMIWizardDlg.Title := Options.Title;
    SMIWizardDlg.Formats := Options.Formats;
    SMIWizardDlg.HelpContext := Options.HelpContext;
    SMIWizardDlg.WizardStyle := Options.WizardStyle;
    SMIWizardDlg.Options := Options.Options;
    //    IF FileExists (Options.DefaultOptionsDirectory+'\Last Import.SMI') THEN
    //      SMIWizardDlg.LoadSpecification(Options.DefaultOptionsDirectory+'\Last Import.SMI');
    SMIWizardDlg.Execute;
    SMIWizardDlg.SaveSpecification('Last Import', SMIWizardDlg.SpecificationDir + '\Last Import.SMI', False);
  finally
    FreeAndNil(SMIWizardDlg);
  end;
end;

{$ENDIF USE_3RDPARTY_SMIMPORT}

//=== { TJvDatabaseModifyAllAction } =========================================

constructor TJvDatabaseModifyAllAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabledOnlyIfSelectedRows := True;
end;

procedure TJvDatabaseModifyAllAction.ExecuteTarget(Target: TObject);
begin
  ModifyAll;
end;

procedure TJvDatabaseModifyAllAction.ModifyAll;
var
  JvParameterList: TJvParameterList;
  Parameter: TJvBaseParameter;
  I: Integer;
  Field: TField;
  FieldName: string;
  ChangeTo: string;
  ClearField: Boolean;
  OnlyIfNull: Boolean;
begin
  if not Assigned(DatabaseControlEngine) then
    Exit;
  JvParameterList := TJvParameterList.Create(Self);
  try
    JvParameterList.Messages.Caption := SModifyAllCaption;
    JvParameterList.Messages.OkButton := SModifyAllOkButton;
    Parameter := TJvBaseParameter(TJvComboBoxParameter.Create(JvParameterList));
    with TJvComboBoxParameter(Parameter) do
    begin
      LabelArrangeMode := lamAbove;
      SearchName := 'ModifyField';
      Caption := SModifyAllModifyField;
      Width := 330;
      for I := 0 to EngineFieldCount - 1 do
      begin
        Field := DatabaseControlEngine.FieldById(DataComponent, I);
        if Assigned(Field) then
          if not DatabaseControlEngine.IsFieldReadOnly(DataComponent,Field.FieldName) and
            DatabaseControlEngine.IsFieldVisible(DataComponent,Field.FieldName) then
            ItemList.Add(Field.FieldName);
        if Assigned(DatabaseControlEngine.SelectedField(DataComponent)) then
          ItemIndex := ItemList.IndexOf(DatabaseControlEngine.SelectedField(DataComponent).FieldName);
        if (ItemIndex < 0) or (ItemIndex >= ItemList.Count) then
          ItemIndex := 0;
      end;
    end;
    JvParameterList.AddParameter(Parameter);
    Parameter := TJvCheckBoxParameter.Create(JvParameterList);
    with TJvCheckBoxParameter(Parameter) do
    begin
      SearchName := 'ClearFieldValues';
      Caption := SModifyAllClearFieldValues;
      Width := 150;
    end;
    JvParameterList.AddParameter(Parameter);
    Parameter := TJvEditParameter.Create(JvParameterList);
    with TJvEditParameter(Parameter) do
    begin
      SearchName := 'ChangeTo';
      Caption := SModifyAllChangeTo;
      Width := 330;
      LabelArrangeMode := lamAbove;
      DisableReasons.AddReason('ClearFieldValues', True);
    end;
    JvParameterList.AddParameter(Parameter);
    Parameter := TJvCheckBoxParameter.Create(JvParameterList);
    with TJvCheckBoxParameter(Parameter) do
    begin
      SearchName := 'OnlyIfNull';
      Caption := SModifyAllOnlyIfNull;
      Width := 150;
      DisableReasons.AddReason('ClearFieldValues', True);
    end;
    JvParameterList.AddParameter(Parameter);
    JvParameterList.MaxWidth := 360;
    if JvParameterList.ShowParameterDialog then
    begin
      FieldName := JvParameterList.ParameterByName('ModifyField').AsString;
      ClearField := JvParameterList.ParameterByName('ClearFieldValues').AsBoolean;
      OnlyIfNull := JvParameterList.ParameterByName('OnlyIfNull').AsBoolean;
      ChangeTo := JvParameterList.ParameterByName('ChangeTo').AsString;
      Field := DatabaseControlEngine.FieldByName(DataComponent, FieldName);
      if Assigned(Field) then
      try
        DatabaseControlEngine.DisableControls(DataComponent);
        for I := 0 to DatabaseControlEngine.SelectedRowsCount(DataComponent) - 1 do
          if DatabaseControlEngine.GotoSelectedRow(DataComponent,I) then
          begin
            try
              if (ClearField and not Field.IsNull) or
                not (OnlyIfNull and not Field.IsNull) then
              begin
                DatabaseControlEngine.Dataset(DataComponent).Edit;
                if ClearField then
                  Field.Clear
                else
                  Field.AsString := ChangeTo;
                if Assigned(DatabaseControlEngine.Dataset(DataComponent)) then
                  DatabaseControlEngine.Dataset(DataComponent).Post;
              end;
            except
              on E: Exception do
              begin
                if Assigned(DatabaseControlEngine.Dataset(DataComponent)) then
                  DatabaseControlEngine.Dataset(DataComponent).Cancel;
                JvDSADialogs.MessageDlg(E.Message, mtError, [mbOK], 0);
              end;
            end;
          end;
      finally
        DatabaseControlEngine.EnableControls(DataComponent);
      end;
    end;
  finally
    FreeAndNil(JvParameterList);
  end;
end;

procedure TJvDatabaseModifyAllAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and not EngineControlsDisabled and
    EngineIsActive and EngineCanUpdate and not EngineEditModeActive and
    (not EnabledOnlyIfSelectedRows or (EngineSelectedRowsCount > 1)));
end;

//=== { TJvDatabaseShowSQLStatementAction } ==================================

constructor TJvDatabaseShowSQLStatementAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWordWrap := True;
end;

procedure TJvDatabaseShowSQLStatementAction.ExecuteTarget(Target: TObject);
begin
  ShowSQLStatement;
end;

procedure TJvDatabaseShowSQLStatementAction.ShowSQLStatement;
var
  ParameterList: TJvParameterList;
  Parameter: TJvBaseParameter;
begin
  if not Assigned(DatasetEngine) then
    Exit;
  ParameterList := TJvParameterList.Create(Self);
  try
    Parameter := TJvBaseParameter(TJvMemoParameter.Create(ParameterList));
    with TJvMemoParameter(Parameter) do
    begin
      SearchName := 'SQLStatement';
      ScrollBars := ssBoth;
      TJvMemoParameter(Parameter).WordWrap := Self.WordWrap;
      ReadOnly := True;
      //Caption := '&SQL Statement';
      AsString := DatasetEngine.GetSQL(DataSet);
      Width := 500;
      Height := 350;
    end;
    ParameterList.AddParameter(Parameter);
    ParameterList.ArrangeSettings.WrapControls := True;
    ParameterList.ArrangeSettings.MaxWidth := 650;
    ParameterList.Messages.Caption := SShowSQLStatementCaption;
    ParameterList.Messages.OkButton := SSQLStatementClipboardButton;
    if ParameterList.ShowParameterDialog then
      ClipBoard.AsText := Parameter.AsString;
  finally
    FreeAndNil(ParameterList);
  end;
end;

procedure TJvDatabaseShowSQLStatementAction.UpdateTarget(Target: TObject);
begin
  SetEnabled(Assigned(DataSet) and Assigned(DatasetEngine) and DatasetEngine.SupportsGetSQL(DataComponent));
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}

finalization
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.

