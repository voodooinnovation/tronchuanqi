{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvBaseDBLogonDialog.pas, released on 2006-07-21

The Initial Developer of the Original Code is Jens Fudickar
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvBaseDBLogonDialog.pas 11209 2007-03-13 22:57:45Z jfudickar $

unit JvBaseDBLogonDialog;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes, Forms, Controls, Menus,
  JvBaseDlg, JvAppStorage, JvDynControlEngine, JvDynControlEngineIntf,
  JvPropertyStore, JvBaseDBDialog, JvBaseDBPasswordDialog;

type
  TJvLogonDialogFillListEvent = procedure(List: TStringList) of object;
  TJvLogonDialogEncryptDecryptEvent = procedure(var Password: string) of object;
  TJvLogonDialogBaseSessionEvent = function(Session: TComponent): Boolean of object;

  TJvDBLogonDialogActivePage = (ldapConnectList, ldapUserTree, ldapDatabaseTree, ldapGroupTree);

  TJvBaseDBLogonDialogOptions = class(TPersistent)
  private
    FAddConnectionsToDatabaseComboBox: Boolean;
    FAllowNullPasswords: Boolean;
    FAllowPasswordChange: Boolean;
    FDatabasenameCaseSensitive: Boolean;
    FPasswordChar: char;
    FPasswordDialogOptions: TJvBaseDBPasswordDialogOptions;
    FUsernameCaseSensitive: Boolean;
    FSaveLastConnect: Boolean;
    FSavePasswords: Boolean;
    FSetLastConnectToTop: Boolean;
    FShowColors: Boolean;
    FShowConnectGroup: Boolean;
    FShowConnectionsExport: Boolean;
    FShowSavePasswords: Boolean;
    FShowShortcuts: Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property AllowPasswordChange: Boolean read FAllowPasswordChange write FAllowPasswordChange;
    property PasswordDialogOptions: TJvBaseDBPasswordDialogOptions read FPasswordDialogOptions;
  published
    //1 Add each database from the connection list to the database combobox
    property AddConnectionsToDatabaseComboBox: Boolean read
      FAddConnectionsToDatabaseComboBox write FAddConnectionsToDatabaseComboBox
      default True;
    property AllowNullPasswords: Boolean read FAllowNullPasswords write
      FAllowNullPasswords default False;
    //1 Group the Databasename casesensitive in the Databasename tree list
    property DatabasenameCaseSensitive: Boolean read FDatabasenameCaseSensitive
      write FDatabasenameCaseSensitive default False;
    property PasswordChar: char read FPasswordChar write FPasswordChar default '*';
    //1 Group the username casesensitive in the username tree list
    property UsernameCaseSensitive: Boolean read FUsernameCaseSensitive write
      FUsernameCaseSensitive default False;
    property SaveLastConnect: Boolean read FSaveLastConnect write FSaveLastConnect default True;
    property SavePasswords: Boolean read FSavePasswords write FSavePasswords default True;
    property SetLastConnectToTop: Boolean read FSetLastConnectToTop write
      FSetLastConnectToTop default True;
//    property ShowColors: Boolean read FShowColors write FShowColors default False;
    property ShowConnectGroup: Boolean read FShowConnectGroup write
      FShowConnectGroup default True;
    property ShowConnectionsExport: Boolean read FShowConnectionsExport write
      FShowConnectionsExport default True;
    property ShowSavePasswords: Boolean read FShowSavePasswords write
      FShowSavePasswords default False;
    property ShowShortcuts: Boolean read FShowShortcuts write FShowShortcuts
      default True;
  end;

  TJvBaseDBOracleLogonDialogOptions = class(TJvBaseDBLogonDialogOptions)
  private
    FShowConnectAs: Boolean;
  public
    constructor Create; override;
  published
    property ShowConnectAs: Boolean read FShowConnectAs write FShowConnectAs default True;
  end;

  TJvBaseDBLogonDialogOptionsClass = class of TJvBaseDBLogonDialogOptions;

  TJvBaseConnectionInfo = class(TJvCustomPropertyStore)
  private
    FDatabase: string;
    FGroup: string;
    FPassword: string;
    FSavePassword: Boolean;
    FShortCut: Integer;
    FUsername: string;
    function GetShortCutText: string;
    procedure SetGroup(const Value: string);
    procedure SetSavePassword(const Value: Boolean);
    procedure SetShortCutText(const Value: string);
  protected
    procedure SetDatabase(Value: string);
    procedure SetUsername(Value: string);
  public
    destructor Destroy; override;
    function ConnectString(ShowShortCut, ShowConnectGroup: Boolean): string; virtual;
    function UserDatabaseString: string;
    property SavePassword: Boolean read FSavePassword write SetSavePassword;
    property ShortCut: Integer read FShortCut write FShortCut;
  published
    property Database: string read FDatabase write SetDatabase;
    property Group: string read FGroup write SetGroup;
    property Password: string read FPassword write FPassword;
    property ShortCutText: string read GetShortCutText write SetShortCutText;
    property Username: string read FUsername write SetUsername;
  end;

  TJvBaseOracleConnectionInfo = class(TJvBaseConnectionInfo)
  private
    FConnectAs: string;
    procedure SetConnectAs(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function ConnectString(ShowShortCut, ShowConnectGroup: Boolean): string; override;
  published
    property ConnectAs: string read FConnectAs write SetConnectAs;
  end;

  TJvLogonDialogConnectionInfoEvent = procedure(ConnectionInfo: TJvBaseConnectionInfo) of object;

  TJvBaseConnectionListClass = class of TJvBaseConnectionList;

  TJvBaseConnectionList = class(TJvCustomPropertyListStore)
  private
    FActivePage: TJvDBLogonDialogActivePage;
    FGroupByDatabase: Boolean;
    FGroupByUser: Boolean;
    FLastConnect: TJvBaseConnectionInfo;
    FSavePasswords: Boolean;
    procedure SetLastConnect(const Value: TJvBaseConnectionInfo);
    procedure SetSavePasswords(const Value: Boolean);
  protected
    procedure CopyContents(iConnectionList: TJvBaseConnectionList; iClearBefore: Boolean);
    function CreateObject: TObject; override;
    function GetConnection(I: Longint): TJvBaseConnectionInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddConnection(ConnectionInfo: TJvBaseConnectionInfo);
    function CreateConnection: TJvBaseConnectionInfo;
    function IndexOfNames(const Username, Database: string): Integer;
    property Connection[I: Longint]: TJvBaseConnectionInfo read GetConnection;
  published
    //1 Stores the data of the last connection
    property LastConnect: TJvBaseConnectionInfo read FLastConnect write SetLastConnect;
    property ActivePage: TJvDBLogonDialogActivePage read FActivePage write FActivePage;
    property GroupByDatabase: Boolean read FGroupByDatabase write FGroupByDatabase;
    property GroupByUser: Boolean read FGroupByUser write FGroupByUser;
    property SavePasswords: Boolean read FSavePasswords write SetSavePasswords;
  end;

  TJvBaseOracleConnectionList = class(TJvBaseConnectionList)
  protected
    function CreateObject: TObject; override;
  end;

  TJvBaseDBLogonDialog = class(TJvBaseDBDialog)
  private
    AddToListBtn: TWinControl;
    CancelBtn: TWinControl;
    ConnectBtn: TWinControl;
    AdditionalBtn: TWinControl;
    AdditionalPopupMenu: TPopupMenu;
    ConnectGroupComboBox: TWinControl;
    ConnectListListBox: TWinControl;
    DatabaseComboBox: TWinControl;
    DatabaseTreeView: TWinControl;
    FConnectionList: TJvBaseConnectionList;
    FGroupByDatabase: Boolean;
    fGroupByUser: Boolean;
    FOnDecryptPassword: TJvLogonDialogEncryptDecryptEvent;
    FOnEncryptPassword: TJvLogonDialogEncryptDecryptEvent;
    FOnFillDatabaseList: TJvLogonDialogFillListEvent;
    FOnFillShortcutList: TJvLogonDialogFillListEvent;
    FOnSessionConnect: TJvLogonDialogBaseSessionEvent;
    FOptions: TJvBaseDBLogonDialogOptions;
    GetFromListBtn: TWinControl;
    GroupByDatabaseCheckBox: TWinControl;
    GroupByUserCheckBox: TWinControl;
    GroupTreeView: TWinControl;
    IConnectGroupComboBoxData: IJvDynControlData;
    IConnectionListPageControlTab: IJvDynControlTabControl;
    IConnectListListBoxData: IJvDynControlData;
    IConnectListListBoxItems: IJvDynControlItems;
    IDatabaseComboBoxData: IJvDynControlData;
    IDatabaseTreeView: IJvDynControlTreeView;
    IGroupByDatabaseCheckBox: IJvDynControlCheckBox;
    IGroupByUserCheckBox: IJvDynControlCheckBox;
    IGroupTreeView: IJvDynControlTreeView;
    IPasswordEditData: IJvDynControlData;
    ISavePasswordsCheckBox: IJvDynControlCheckBox;
    IShortCutComboBoxData: IJvDynControlData;
    IUserNameEditData: IJvDynControlData;
    IUserTreeView: IJvDynControlTreeView;
    PasswordEdit: TWinControl;
    RemoveFromListBtn: TWinControl;
    SavePasswordsCheckBox: TWinControl;
    ShortCutComboBox: TWinControl;
    ConnectPanel: TWinControl;
    ShortCutPanel: TWinControl;
    UserNameEdit: TWinControl;
    UserTreeView: TWinControl;
    ConnectGroupPanel: TWinControl;
    FBeforeTransferConnectionInfoToSessionData: TJvLogonDialogConnectionInfoEvent;
    FAfterTransferSessionDataToConnectionInfo: TJvLogonDialogConnectionInfoEvent;
    procedure AddToListBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure AdditionalBtnClick(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure ConnectionListPageControlChange(Sender: TObject);
    procedure ConnectListListBoxClick(Sender: TObject);
    procedure ConnectListListBoxDblClick(Sender: TObject);
    procedure FillGroupTreeView;
    procedure CreateUserTreeView;
    procedure DatabaseComboBoxChange(Sender: TObject);
    function DecryptPassword(const Value: string): string;
    function EncryptPassword(const Value: string): string;
    procedure FillAllConnectionLists;
    procedure FillConnectGroupComboBox;
    procedure FillConnectionList;
    procedure FillDatabaseComboBox;
    procedure FillDatabaseTreeView;
    procedure FillShortCutList(Items: TStringList);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    function GetActivePage: TJvDBLogonDialogActivePage;
    function GetCurrentDialogConnectionInfo: TJvBaseConnectionInfo;
    function GetDialogDatabase: string;
    function GetDialogPassword: string;
    function GetDialogUserName: string;
    procedure GetFromListBtnClick(Sender: TObject);
    procedure GroupByDatabaseCheckBoxClick(Sender: TObject);
    procedure GroupByUserCheckBoxClick(Sender: TObject);
    procedure LoadSettings;
    procedure PasswordDialog_BeforeTransferPasswordToSession(var Password: string);
    procedure PasswordDialog_AfterTransferPasswordFromSession(var Password: string);
    procedure PasswordEditChange(Sender: TObject);
    procedure RemoveFromListBtnClick(Sender: TObject);
    procedure SetActivePage(const Value: TJvDBLogonDialogActivePage);
    procedure SetButtonState;
    procedure SetConnectBtnEnabled;
    procedure SetConnectionToTop(Username, Database: string);
    procedure SetDialogDatabase(const Value: string);
    procedure SetDialogPassword(const Value: string);
    procedure SetDialogUserName(const Value: string);
    procedure SetOptions(const Value: TJvBaseDBLogonDialogOptions);
    procedure StoreSettings;
  protected
    procedure ActivateDatabaseControl;
    procedure ActivatePasswordControl;
    function CalculatePanelHeight(LastControl: TWinControl): Integer;
    function ChangePassword: Boolean;
    procedure ClearControlInterfaceObjects; virtual;
    procedure ClearFormControls; virtual;
    procedure ConnectSession; virtual;
    procedure ConnectToSession;
    procedure CreateAdditionalConnectDialogControls(AOwner: TComponent;
      AParentControl: TWinControl); virtual;
    procedure CreateFormControls(AForm: TForm); override;
    function CreatePasswordChangeDialog: TJvBaseDBPasswordDialog; virtual;
    procedure DoSessionConnect;
    procedure FillAdditionalPopupMenuEntries(APopupMenu: TPopupMenu); virtual;
    procedure FillDatabaseComboBoxDefaultValues(Items: TStrings); virtual;
    { Retrieve the class that holds the storage options and format settings. }
    class function GetDBLogonConnectionListClass: TJvBaseConnectionListClass; virtual;
    { Retrieve the class that holds the storage options and format settings. }
    class function GetDBLogonDialogOptionsClass: TJvBaseDBLogonDialogOptionsClass; virtual;
    function GetGroupByDatabase: Boolean;
    function GetGroupByUser: Boolean;
    procedure OnExportConnectionList(Sender: TObject);
    procedure OnImportConnectionList(Sender: TObject);
    procedure ResizeFormControls; virtual;
    function SavePasswords: Boolean;
    procedure SetAppStorage(Value: TJvCustomAppStorage); override;
    procedure SetAppStoragePath(Value: string); override;
    procedure SetGroupByDatabase(Value: Boolean);
    procedure SetGroupByUser(Value: Boolean);
    procedure SetSession(const Value: TComponent); override;
    procedure TransferConnectionInfoFromDialog(ConnectionInfo: TJvBaseConnectionInfo); virtual;
    procedure TransferConnectionInfoToDialog(ConnectionInfo: TJvBaseConnectionInfo); virtual;
    procedure TransferSessionDataFromDialog;
    procedure TransferSessionDataFromConnectionInfo(ConnectionInfo: TJvBaseConnectionInfo); virtual;
    procedure TransferSessionDataToDialog;
    procedure TransferSessionDataToConnectionInfo(ConnectionInfo: TJvBaseConnectionInfo); virtual;
    property ActivePage: TJvDBLogonDialogActivePage read GetActivePage write SetActivePage;
    property ConnectionList: TJvBaseConnectionList read FConnectionList;
    property CurrentDialogConnectionInfo: TJvBaseConnectionInfo read GetCurrentDialogConnectionInfo;
    property DialogDatabase: string read GetDialogDatabase write SetDialogDatabase;
    property DialogPassword: string read GetDialogPassword write SetDialogPassword;
    property DialogUserName: string read GetDialogUserName write SetDialogUserName;
    property GroupByDatabase: Boolean read GetGroupByDatabase write SetGroupByDatabase;
    property GroupByUser: Boolean read GetGroupByUser write SetGroupByUser;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AppStorage;
    property AppStoragePath;
    property Options: TJvBaseDBLogonDialogOptions read FOptions write SetOptions;
    //1 This Event gives you the possibility to modify the connection data before it is transfered to the current session
    property BeforeTransferConnectionInfoToSessionData:
      TJvLogonDialogConnectionInfoEvent read
      FBeforeTransferConnectionInfoToSessionData write
      FBeforeTransferConnectionInfoToSessionData;
    //1 This events gives you the possibility to modify the connection data after receiving the data from the current session
    property AfterTransferSessionDataToConnectionInfo: TJvLogonDialogConnectionInfoEvent read
      FAfterTransferSessionDataToConnectionInfo write FAfterTransferSessionDataToConnectionInfo;
    property OnDecryptPassword: TJvLogonDialogEncryptDecryptEvent read FOnDecryptPassword write FOnDecryptPassword;
    property OnEncryptPassword: TJvLogonDialogEncryptDecryptEvent read FOnEncryptPassword write FOnEncryptPassword;
    //1 Event for filling the database list
    property OnFillDatabaseList: TJvLogonDialogFillListEvent read FOnFillDatabaseList write FOnFillDatabaseList;
    //1 Event for customizing the shortcut list
    property OnFillShortcutList: TJvLogonDialogFillListEvent read FOnFillShortcutList write FOnFillShortcutList;
    property OnSessionConnect: TJvLogonDialogBaseSessionEvent read FOnSessionConnect write FOnSessionConnect;
  end;

  TJvBaseDBOracleLogonDialog = class(TJvBaseDBLogonDialog)
  private
    ConnectAsComboBox: TWinControl;
    ConnectAsPanel: TWinControl;
    IConnectAsComboBoxData: IJvDynControlData;
    function GetDialogConnectAs: string;
    function GetOptions: TJvBaseDBOracleLogonDialogOptions;
    procedure SetDialogConnectAs(const Value: string);
    procedure SetOptions(const Value: TJvBaseDBOracleLogonDialogOptions);
  protected
    procedure ClearFormControls; override;
    procedure CreateAdditionalConnectDialogControls(AOwner: TComponent;
      AParentControl: TWinControl); override;
    procedure CreateFormControls(AForm: TForm); override;
    { Retrieve the class that holds the storage options and format settings. }
    class function GetDBLogonConnectionListClass: TJvBaseConnectionListClass; override;
    { Retrieve the class that holds the storage options and format settings. }
    class function GetDBLogonDialogOptionsClass: TJvBaseDBLogonDialogOptionsClass; override;
    procedure ResizeFormControls; override;
    procedure TransferConnectionInfoFromDialog(ConnectionInfo: TJvBaseConnectionInfo); override;
    procedure TransferConnectionInfoToDialog(ConnectionInfo: TJvBaseConnectionInfo); override;
    property DialogConnectAs: string read GetDialogConnectAs write SetDialogConnectAs;
  public
    procedure ClearControlInterfaceObjects; override;
  published
    property Options: TJvBaseDBOracleLogonDialogOptions read GetOptions write SetOptions;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvBaseDBLogonDialog.pas $';
    Revision: '$Revision: 11209 $';
    Date: '$Date: 2007-03-13 15:57:45 -0700 (Tue, 13 Mar 2007) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  Windows, SysUtils,
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  ExtCtrls, ComCtrls, StdCtrls, Dialogs,
  JvAppIniStorage, JvAppXMLStorage, JvDSADialogs, JvResources;

//=== { TJvBaseDBLogonDialog } ===============================================

constructor TJvBaseDBLogonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := GetDBLogonDialogOptionsClass.Create;
  FConnectionList := GetDBLogonConnectionListClass.Create(Self);
end;

destructor TJvBaseDBLogonDialog.Destroy;
begin
  FreeAndNil(FConnectionList);
  FreeAndNil(FOptions);
  inherited Destroy;
end;

procedure TJvBaseDBLogonDialog.ActivateDatabaseControl;
begin
  if Assigned(DatabaseComboBox) and Assigned(DBDialog) then
    DBDialog.ActiveControl := DatabaseComboBox;
end;

procedure TJvBaseDBLogonDialog.ActivatePasswordControl;
begin
  if Assigned(DatabaseComboBox) and Assigned(DBDialog) then
    DBDialog.ActiveControl := PasswordEdit;
end;

procedure TJvBaseDBLogonDialog.AddToListBtnClick(Sender: TObject);
var
  ConnectionInfo: TJvBaseConnectionInfo;
begin
  ConnectionInfo := ConnectionList.CreateConnection;
  TransferConnectionInfoFromDialog(ConnectionInfo);
  ConnectionList.AddConnection(ConnectionInfo);
  FillAllConnectionLists;
end;

function TJvBaseDBLogonDialog.CalculatePanelHeight(LastControl: TWinControl):
  Integer;
begin
  if Assigned(LastControl) then
    Result := LastControl.Top + LastControl.Height + 2
  else
    Result := 20;
end;

procedure TJvBaseDBLogonDialog.CancelBtnClick(Sender: TObject);
begin
  DBDialog.ModalResult := mrCancel;
end;

procedure TJvBaseDBLogonDialog.AdditionalBtnClick(Sender: TObject);
var
  P: TPoint;
begin
  with AdditionalBtn do
    P := Parent.ClientToScreen(Point(Left + Width, Top));
  AdditionalPopupMenu.Popup(P.X, P.Y);
end;

function TJvBaseDBLogonDialog.ChangePassword: Boolean;
var
  PasswordDialog: TJvBaseDBPasswordDialog;
begin
  Result := False;
  if not Options.AllowPasswordChange then
    Exit;
  PasswordDialog := TJvBaseDBPasswordDialog(CreatePasswordChangeDialog);
  if Assigned(PasswordDialog) then
  try
    PasswordDialog.Session := Session;
    PasswordDialog.AfterTransferPasswordFromSession := PasswordDialog_AfterTransferPasswordFromSession;
    PasswordDialog.BeforeTransferPasswordToSession := PasswordDialog_BeforeTransferPasswordToSession;
    PasswordDialog.Options := Options.PasswordDialogOptions;
    Result := PasswordDialog.Execute;
  finally
    PasswordDialog.Free;
  end;
end;

procedure TJvBaseDBLogonDialog.ClearFormControls;
begin
  IUserNameEditData.ControlValue := '';
  IPasswordEditData.ControlValue := '';
  IDatabaseComboBoxData.ControlValue := '';
  IConnectGroupComboBoxData.ControlValue := '';
  IShortCutComboBoxData.ControlValue := '';
end;

procedure TJvBaseDBLogonDialog.ClearControlInterfaceObjects;
begin
  IConnectGroupComboBoxData := nil;
  IConnectionListPageControlTab := nil;
  IConnectListListBoxData := nil;
  IConnectListListBoxItems := nil;
  IDatabaseComboBoxData := nil;
  IDatabaseTreeView := nil;
  IGroupByDatabaseCheckBox := nil;
  IGroupByUserCheckBox := nil;
  IGroupTreeView := nil;
  IPasswordEditData := nil;
  ISavePasswordsCheckBox := nil;
  IShortCutComboBoxData := nil;
  IUserNameEditData := nil;
  IUserTreeView := nil;
end;

procedure TJvBaseDBLogonDialog.ConnectBtnClick(Sender: TObject);
begin
  if not ConnectBtn.Enabled then
    Exit;
  ConnectToSession;
end;

procedure TJvBaseDBLogonDialog.ConnectionListPageControlChange(Sender: TObject);
begin
  SetButtonState;
end;

procedure TJvBaseDBLogonDialog.ConnectListListBoxClick(Sender: TObject);
begin
  SetButtonState;
end;

procedure TJvBaseDBLogonDialog.ConnectListListBoxDblClick(Sender: TObject);
begin
  if Assigned(CurrentDialogConnectionInfo) then
  begin
    TransferConnectionInfoToDialog(CurrentDialogConnectionInfo);
    ConnectToSession;
  end;
end;

procedure TJvBaseDBLogonDialog.ConnectSession;
begin
end;

procedure TJvBaseDBLogonDialog.ConnectToSession;
begin
  SetConnectBtnEnabled;
  if ConnectBtn.Enabled then
    DoSessionConnect
  else
    if DialogPassword = '' then
      PasswordEdit.SetFocus;
end;

procedure TJvBaseDBLogonDialog.CreateAdditionalConnectDialogControls(AOwner: TComponent;
  AParentControl: TWinControl);
begin
end;

procedure TJvBaseDBLogonDialog.CreateFormControls(AForm: TForm);
var
  ButtonPanel, MainPanel, LeftPanel, ListPanel, ListBtnPanel, GroupListPanel: TWinControl;
  ConnectionListPageControl: TWinControl;
  Items: TStringList;
  ITabControl: IJvDynControlTabControl;
  IDynControl: IJvDynControl;
  IDynControlDblClick: IJvDynControlDblClick;
  IDynControlTreeView: IJvDynControlTreeView;
  IDynControlReadOnly: IJvDynControlReadOnly;
  IDynControlPageControl: IJvDynControlPageControl;
  IDynControlBevelBorder: IJvDynControlBevelBorder;
  IDynControlEdit: IJvDynControlEdit;
  LabelControl: TControl;
  IDynControlLabel: IJvDynControlLabel;
  ConnectListLabel: TWinControl;
begin
  with AForm do
  begin
    Name := 'DBDialog';
    Left := 472;
    Top := 229;
    BorderIcons := [biSystemMenu, biMinimize, biMaximize, biHelp];
    BorderStyle := bsDialog;
    Caption := RsLogonToDatabase;
    ClientHeight := 387;
    ClientWidth := 590;
    Position := poScreenCenter;
    KeyPreview := True;
    OnClose := FormClose;
    OnKeyDown := FormKeyDown;
    OnShow := FormShow;
  end;

  ButtonPanel := DynControlEngine.CreatePanelControl(AForm, AForm, 'ButtonPanel', '', alBottom);
  ConnectBtn := DynControlEngine.CreateButton(AForm, ButtonPanel, 'ConnectBtn',
    RsBtnConnect, '', ConnectBtnClick, True, False);
  with ConnectBtn do
  begin
    Left := 60;
    Top := 11;
    Width := 90;
    Height := 25;
  end;
  CancelBtn := DynControlEngine.CreateButton(AForm, ButtonPanel, 'CancelBtn',
    RsButtonCancelCaption, '', CancelBtnClick, False, True);
  with CancelBtn do
  begin
    Left := 460;
    Top := 11;
    Width := 90;
    Height := 25;
    //    Anchors := [akTop, akRight];
    //    Kind := bkCancel;
  end;

  AdditionalBtn := DynControlEngine.CreateButton(AForm, ButtonPanel, 'AdditionalBtn',
    RsBtnAdditional, '', AdditionalBtnClick, False, False);
  with AdditionalBtn do
  begin
    Left := 460;
    Top := 11;
    Width := 100;
    Height := 25;
    //    Anchors := [akTop, akRight];
    //    Kind := bkCancel;
  end;

  AdditionalPopupMenu := TPopupMenu.Create(AForm);
  FillAdditionalPopupMenuEntries(AdditionalPopupMenu);

  AdditionalBtn.Visible := AdditionalPopupMenu.Items.Count > 0;

  MainPanel := DynControlEngine.CreatePanelControl(AForm, AForm, 'MainPanel', '', alClient);
  with MainPanel do
  begin
    TabOrder := 0;
    if Supports(MainPanel, IJvDynControlBevelBorder, IDynControlBevelBorder) then
      IDynControlBevelBorder.ControlSetBorderWidth(5);
    if Supports(MainPanel, IJvDynControlBevelBorder, IDynControlBevelBorder) then
      IDynControlBevelBorder.ControlSetBevelOuter(bvNone);
  end;
  ListPanel := DynControlEngine.CreatePanelControl(AForm, MainPanel, 'ListPanel', '', alClient);
  with ListPanel do
  begin
    Anchors := [akTop, akRight, akBottom];
    if Supports(ListPanel, IJvDynControlBevelBorder, IDynControlBevelBorder) then
      IDynControlBevelBorder.ControlSetBevelOuter(bvNone);
    TabOrder := 1;
  end;

  ConnectListLabel := DynControlEngine.CreateStaticTextControl(AForm, ListPanel, 'ConnectListLabel',
    'Connection List');
  with ConnectListLabel do
  begin
    Align := alTop;
    Height := 18;
  end;

  ListBtnPanel := DynControlEngine.CreatePanelControl(AForm, MainPanel, 'ListBtnPanel', '', alLeft);
  with ListBtnPanel do
  begin
    Width := 32;
  end;

  AddToListBtn := DynControlEngine.CreateButton(AForm, ListBtnPanel, 'AddToListBtn',
    '>', RsBtnHintAddDefinitionToList, AddToListBtnClick, False, False);
  with AddToListBtn do
  begin
    Left := 4;
    Top := 45;
    Width := 23;
    Height := 22;
    //  Glyph := // please assign
    //    NumGlyphs := 2;
  end;
  GetFromListBtn := DynControlEngine.CreateButton(AForm, ListBtnPanel, 'GetFromListBtn',
    '<', RsBtnHintSelectDefinitionFromList, GetFromListBtnClick, False, False);
  with GetFromListBtn do
  begin
    Left := 4;
    Top := 85;
    Width := 23;
    Height := 22;
    //  Glyph := // please assign
    //    NumGlyphs := 2;
  end;
  RemoveFromListBtn := DynControlEngine.CreateButton(AForm, ListBtnPanel, 'RemoveFromListBtn',
    'X', RsBtnHintDeleteDefinitionFromList, RemoveFromListBtnClick, False, False);
  with RemoveFromListBtn do
  begin
    Left := 4;
    Top := 125;
    Width := 23;
    Height := 22;
    //  Glyph := // please assign
  end;

  Items := tStringList.Create;
  try
    Items.Add(RsPageDefaultList);
    Items.Add(RsPageByUser);
    Items.Add(RsPageByDatabase);
    Items.Add(RsPageByGroup);
    ConnectionListPageControl := DynControlEngine.CreatePageControlControl(AForm, ListPanel,
      'ConnectionListPageControl', Items);
  finally
    Items.Free;
  end;
  with ConnectionListPageControl do
  begin
    Align := alClient;
    Supports(ConnectionListPageControl, IJvDynControlTabControl, IConnectionListPageControlTab);
    if Supports(ConnectionListPageControl, IJvDynControlTabControl, ITabControl) then
    begin
      ITabControl.ControlSetOnChangeTab(ConnectionListPageControlChange);
      ITabControl.ControlSetMultiLine(True);
      ITabControl.ControlTabIndex := 2;
    end;
  end;

  ConnectListListBox := DynControlEngine.CreateListBoxControl(AForm, AForm, 'ConnectListListBox', nil);
  with ConnectListListBox do
  begin
    Align := alClient;
    if Supports(ConnectionListPageControl, IJvDynControlPageControl, IDynControlPageControl) then
      Parent := IDynControlPageControl.ControlGetPage(RsPageDefaultList);

    Supports(ConnectListListBox, IJvDynControlItems, IConnectListListBoxItems);
    Supports(ConnectListListBox, IJvDynControlData, IConnectListListBoxData);
    if Supports(ConnectListListBox, IJvDynControl, IDynControl) then
      IDynControl.ControlSetOnClick(ConnectListListBoxClick);
    if Supports(ConnectListListBox, IJvDynControlDblClick, IDynControlDblClick) then
      IDynControlDblClick.ControlSetOnDblClick(ConnectListListBoxDblClick);
  end;

  UserTreeView := DynControlEngine.CreateTreeViewControl(AForm, AForm, 'UserTreeView');
  with UserTreeView do
  begin
    Align := alClient;
    if Supports(ConnectionListPageControl, IJvDynControlPageControl, IDynControlPageControl) then
      Parent := IDynControlPageControl.ControlGetPage(RsPageByUser);
    if Supports(UserTreeView, IJvDynControl, IDynControl) then
      IDynControl.ControlSetOnClick(ConnectListListBoxClick);
    if Supports(UserTreeView, IJvDynControlDblClick, IDynControlDblClick) then
      IDynControlDblClick.ControlSetOnDblClick(ConnectListListBoxDblClick);
    if Supports(UserTreeView, IJvDynControlTreeView, IUserTreeView) then
      IUserTreeView.ControlSetSortType(stText);
    if Supports(UserTreeView, IJvDynControlReadOnly, IDynControlReadOnly) then
      IDynControlReadOnly.ControlSetReadOnly(True);
  end;
  DatabaseTreeView := DynControlEngine.CreateTreeViewControl(AForm, AForm, 'DatabaseTreeView');
  with DatabaseTreeView do
  begin
    Align := alClient;
    if Supports(ConnectionListPageControl, IJvDynControlPageControl, IDynControlPageControl) then
      Parent := IDynControlPageControl.ControlGetPage(RsPageByDatabase);
    if Supports(DatabaseTreeView, IJvDynControl, IDynControl) then
      IDynControl.ControlSetOnClick(ConnectListListBoxClick);
    if Supports(DatabaseTreeView, IJvDynControlDblClick, IDynControlDblClick) then
      IDynControlDblClick.ControlSetOnDblClick(ConnectListListBoxDblClick);
    if Supports(DatabaseTreeView, IJvDynControlTreeView, IDatabaseTreeView) then
      IDatabaseTreeView.ControlSetSortType(stText);
    if Supports(DatabaseTreeView, IJvDynControlReadOnly, IDynControlReadOnly) then
      IDynControlReadOnly.ControlSetReadOnly(True);
  end;

  if Options.ShowConnectGroup then
  begin
    GroupTreeView := DynControlEngine.CreateTreeViewControl(AForm, AForm, 'GroupTreeView');
    with GroupTreeView do
    begin
      Align := alClient;
      if Supports(ConnectionListPageControl, IJvDynControlPageControl, IDynControlPageControl) then
        Parent := IDynControlPageControl.ControlGetPage(RsPageByGroup);
      if Supports(GroupTreeView, IJvDynControl, IDynControl) then
        IDynControl.ControlSetOnClick(ConnectListListBoxClick);
      if Supports(GroupTreeView, IJvDynControlDblClick, IDynControlDblClick) then
        IDynControlDblClick.ControlSetOnDblClick(ConnectListListBoxDblClick);
      if Supports(GroupTreeView, IJvDynControlTreeView, IGroupTreeView) then
        IGroupTreeView.ControlSetSortType(stText);
      if Supports(GroupTreeView, IJvDynControlReadOnly, IDynControlReadOnly) then
        IDynControlReadOnly.ControlSetReadOnly(True);
    end;
    GroupListPanel := DynControlEngine.CreatePanelControl(AForm, AForm, 'GroupListPanel', '', alBottom);
    with GroupListPanel do
    begin
      if Supports(ConnectionListPageControl, IJvDynControlPageControl, IDynControlPageControl) then
        Parent := IDynControlPageControl.ControlGetPage(RsPageByGroup);
      Height := 25;
      Align := alBottom;
      if Supports(GroupListPanel, IJvDynControlBevelBorder, IDynControlBevelBorder) then
        IDynControlBevelBorder.ControlSetBevelOuter(bvNone);
    end;
    GroupByDatabaseCheckBox := DynControlEngine.CreateCheckboxControl(AForm, GroupListPanel, 'GroupByDatabaseCheckBox',
      RsCheckBoxGroupByDatabase);
    with GroupByDatabaseCheckBox do
    begin
      Left := 0;
      Top := 5;
      Width := 116;
      Height := 17;
      TabOrder := 0;
      if Supports(GroupByDatabaseCheckBox, IJvDynControl, IDynControl) then
        IDynControl.ControlSetOnClick(GroupByDatabaseCheckBoxClick);
      Supports(GroupByDatabaseCheckBox, IJvDynControlCheckBox, IGroupByDatabaseCheckBox);
    end;
    GroupByUserCheckBox := DynControlEngine.CreateCheckboxControl(AForm, GroupListPanel, 'GroupByUserCheckBox',
      RsCheckBoxGroupByUser);
    with GroupByUserCheckBox do
    begin
      Left := 125;
      Top := 5;
      Width := 97;
      Height := 17;
      if Supports(GroupByUserCheckBox, IJvDynControl, IDynControl) then
        IDynControl.ControlSetOnClick(GroupByUserCheckBoxClick);
      Supports(GroupByUserCheckBox, IJvDynControlCheckBox, IGroupByUserCheckBox);
    end;
  end;

  SavePasswordsCheckBox := DynControlEngine.CreateCheckboxControl(AForm, ListPanel, 'SavePasswordsCheckBox',
    RsCheckboxSavePasswords);
  with SavePasswordsCheckBox do
  begin
    //    Checked := True;
    //    State := cbChecked;
    //    OnClick := SavePasswordsCheckBoxClick;
    Align := alBottom;
  end;
  Supports(SavePasswordsCheckBox, IJvDynControlCheckBox, ISavePasswordsCheckBox);
  SavePasswordsCheckBox.Visible := Options.ShowSavePasswords;

  LeftPanel := DynControlEngine.CreatePanelControl(AForm, MainPanel, 'LeftPanel', '', alLeft);
  with LeftPanel do
  begin
    Width := 216;
    if Supports(LeftPanel, IJvDynControlBevelBorder, IDynControlBevelBorder) then
      IDynControlBevelBorder.ControlSetBevelOuter(bvNone);
    TabOrder := 0;
  end;

  ConnectPanel := DynControlEngine.CreatePanelControl(AForm, LeftPanel, 'ConnectPanel', '', alTop);
  with ConnectPanel do
  begin
    Height := 126;
  end;
  LabelControl := DynControlEngine.CreateLabelControl(AForm, ConnectPanel, 'UserNameLabel', RsUsername, nil);
  with LabelControl do
  begin
    Align := alTop;
  end;
  UsernameEdit := DynControlEngine.CreateEditControl(AForm, ConnectPanel, 'UserNameEdit');
  with UsernameEdit do
  begin
    Align := alTop;
    TabOrder := 0;
    Supports(UsernameEdit, IJvDynControlData, IUsernameEditData);
    IUsernameEditData.ControlSetOnChange(PasswordEditChange);
    IUsernameEditData.ControlValue := '';
  end;
  if Supports(LabelControl, IJvDynControlLabel, IDynControlLabel) then
    IDynControlLabel.ControlSetFocusControl(UserNameEdit);
  LabelControl := DynControlEngine.CreateLabelControl(AForm, ConnectPanel, 'PasswordEditLabel', RsPassword,
    PasswordEdit);
  with LabelControl do
  begin
    Align := alTop;
  end;
  PasswordEdit := DynControlEngine.CreateEditControl(AForm, ConnectPanel, 'PasswordEdit');
  with PasswordEdit do
  begin
    Align := alTop;
    TabOrder := 1;
    if Supports(PasswordEdit, IJvDynControlEdit, IDynControlEdit) then
      IDynControlEdit.ControlSetPasswordChar('*');
    Supports(PasswordEdit, IJvDynControlData, IPasswordEditData);
    IPasswordEditData.ControlSetOnChange(PasswordEditChange);
    IPasswordEditData.ControlValue := '';
  end;
  if Supports(LabelControl, IJvDynControlLabel, IDynControlLabel) then
    IDynControlLabel.ControlSetFocusControl(PasswordEdit);
  LabelControl := DynControlEngine.CreateLabelControl(AForm, ConnectPanel, 'DatabaseLabel', RsDatabase, nil);
  with LabelControl do
  begin
    Align := alTop;
  end;
  DatabaseComboBox := DynControlEngine.CreateComboBoxControl(AForm, ConnectPanel, 'DatabaseComboBox', nil);
  with DatabaseComboBox do
  begin
    Align := alTop;
    Top := LabelControl.Top + 1;
    TabOrder := 2;
    Supports(DatabaseComboBox, IJvDynControlData, IDatabaseComboBoxData);
    IDatabaseComboBoxData.ControlSetOnChange(DatabaseComboBoxChange);
    if Supports(DatabaseComboBox, IJvDynControl, IDynControl) then
      IDynControl.ControlSetOnClick(DatabaseComboBoxChange);
    IDatabaseComboBoxData.ControlValue := '';
  end;
  if Supports(LabelControl, IJvDynControlLabel, IDynControlLabel) then
    IDynControlLabel.ControlSetFocusControl(DatabaseComboBox);

  ShortCutPanel := DynControlEngine.CreatePanelControl(AForm, LeftPanel, 'ShortCutPanel', '', alTop);
  with ShortCutPanel do
  begin
    Align := alTop;
  end;
  LabelControl := DynControlEngine.CreateLabelControl(AForm, ShortCutPanel, 'ShortCutLabel', RsShortcut, nil);
  with LabelControl do
  begin
    Align := alTop;
  end;
  Items := tStringList.Create;
  try
    FillShortCutList(Items);

    ShortCutComboBox := DynControlEngine.CreateComboBoxControl(AForm, ShortCutPanel, 'ShortCutComboBox', Items);
    Supports(ShortCutComboBox, IJvDynControlData, IShortCutComboBoxData);
    with ShortCutComboBox do
    begin
      Align := alTop;
    end;
  finally
    Items.Free;
  end;
  if Supports(LabelControl, IJvDynControlLabel, IDynControlLabel) then
    IDynControlLabel.ControlSetFocusControl(ShortCutComboBox);
  ShortCutPanel.Visible := Options.ShowShortcuts;

  ConnectGroupPanel := DynControlEngine.CreatePanelControl(AForm, LeftPanel, 'ConnectGroupPanel', '', alTop);
  with ConnectGroupPanel do
  begin
    Align := alTop;
  end;
  LabelControl := DynControlEngine.CreateLabelControl(AForm, ConnectGroupPanel, 'ConnectGroupLabel', 'Connect &Group',
    nil);
  with LabelControl do
  begin
    Align := alTop;
  end;
  Items := tStringList.Create;
  try
    ConnectGroupComboBox := DynControlEngine.CreateComboBoxControl(AForm, ConnectGroupPanel, 'ConnectGroupComboBox',
      Items);
    Supports(ConnectGroupComboBox, IJvDynControlData, IConnectGroupComboBoxData);
    with ConnectGroupComboBox do
    begin
      Align := alTop;
    end;
  finally
    Items.Free;
  end;
  if Supports(LabelControl, IJvDynControlLabel, IDynControlLabel) then
    IDynControlLabel.ControlSetFocusControl(ConnectGroupComboBox);
  ConnectGroupPanel.Visible := Options.ShowConnectGroup;

  CreateAdditionalConnectDialogControls(AForm, LeftPanel);
end;

function TJvBaseDBLogonDialog.CreatePasswordChangeDialog: TJvBaseDBPasswordDialog;
begin
  Result := nil;
end;

procedure TJvBaseDBLogonDialog.FillGroupTreeView;
var
  i, j, k, g: Integer;
  Items: TTreeNodes;
  Node: TTreeNode;
  Node2: TTreeNode;
  Found: Boolean;
  s: string;
  gr: string;
  GroupList: TStringList;
  Connection: TJvBaseConnectionInfo;
begin
  if not Assigned(IGroupTreeView) then
    Exit;
  Items := IGroupTreeView.ControlItems;
  Items.Clear;
  for i := 0 to ConnectionList.Count - 1 do
  begin
    Connection := ConnectionList.Connection[i];
    GroupList := TStringList.Create;
    try
      GroupList.CommaText := Connection.Group;
      if GroupList.CommaText = '' then
        GroupList.CommaText := RsGroupNameUndefined;

      for g := 0 to GroupList.Count - 1 do
      begin
        Gr := GroupList[g];
        if gr = '' then
          continue;
        s := Connection.ConnectString(Options.ShowShortcuts, False);

        Found := False;
        for j := 0 to Items.Count - 1 do
          if Items[j].Level = 0 then
          begin
            Node := Items[j];
            if Node.Text = Gr then
              if GroupByDatabase then
              begin
                for k := 0 to Node.Count - 1 do
                begin
                  Node2 := Node.Item[k];
                  if Node2.Text = Connection.Database then
                  begin
                    Node := Items.AddChild(Node2, s);
                    Node.Data := Connection;
                    Found := True;
                    break;
                  end;
                end;
                if not Found then
                begin
                  Node := Items.AddChild(Node, Connection.Database);
                  Node := Items.AddChild(Node, s);
                  Node.Data := Connection;
                  Found := True;
                end;
                Break;
              end
              else
                if GroupByUser then
                begin
                  for k := 0 to Node.Count - 1 do
                  begin
                    Node2 := Node.Item[k];
                    if Node2.Text = Connection.Username then
                    begin
                      Node := Items.AddChild(Node2, s);
                      Node.Data := Connection;
                      Found := True;
                      break;
                    end;
                  end;
                  if not Found then
                  begin
                    Node := Items.AddChild(Node, Connection.Username);
                    Node := Items.AddChild(Node, s);
                    //Node.SelectedIndex := i;
                    Node.Data := Connection;
                    Found := True;
                  end;
                  Break;
                end
                else
                begin
                  Node := Items.AddChild(Node, s);
                  Node.Data := Connection;
                  Found := True;
                  break;
                end; {*** IF Node.Text = UpperCase(Databases[i]) THEN ***}
          end; {*** IF Items[i].Level = 0 THEN ***}
        if not Found then
        begin
          Node := Items.AddChild(nil, Gr);
          if GroupByDataBase then
            Node := Items.AddChild(Node, Connection.Database)
          else
            if GroupByUser then
              Node := Items.AddChild(Node, Connection.Username);
          Node := Items.AddChild(Node, s);
          Node.Data := Connection;
        end;
      end;
    finally
      GroupList.Free;
    end;
  end;
  IGroupTreeView.ControlSortItems;
end;

procedure TJvBaseDBLogonDialog.CreateUserTreeView;
var
  i, j: Integer;
  Node: TTreeNode;
  Found: Boolean;
  s: string;
  Connection: TJvBaseConnectionInfo;
  Items: TTreeNodes;
begin
  Items := IUserTreeView.ControlItems;
  Items.Clear;
  for i := 0 to ConnectionList.Count - 1 do
  begin
    Connection := ConnectionList.Connection[i];
    s := Connection.ConnectString(Options.ShowShortCuts, Options.ShowConnectGroup);
    Found := False;
    for j := 0 to Items.Count - 1 do
      if Items[j].Level = 0 then
      begin
        Node := Items[j];
        if Node.Text = Connection.Username then
        begin
          Node := Items.AddChild(Node, s);
          Node.Data := Connection;
          Found := True;
          break;
        end;
      end;
    if not Found then
    begin
      Node := Items.AddChild(nil, Connection.Username);
      Node := Items.AddChild(Node, s);
      Node.Data := Connection;
    end;
  end;
  IUserTreeView.ControlSortItems;
end;

procedure TJvBaseDBLogonDialog.DatabaseComboBoxChange(Sender: TObject);
begin
  SetConnectBtnEnabled;
end;

function TJvBaseDBLogonDialog.DecryptPassword(const Value: string): string;
begin
  try
    Result := Value;
    if Assigned(FOnDecryptPassword) then
      FOnDecryptPassword(Result);
  except
    Result := '';
  end;
end;

procedure TJvBaseDBLogonDialog.DoSessionConnect;
begin
  if Options.SetLastConnectToTop then
    SetConnectionToTop(DialogUserName, DialogDatabase);
  TransferSessionDataFromDialog;
  if Assigned(OnSessionConnect) then
    OnSessionConnect(Session)
  else
    ConnectSession;
  if SessionIsConnected then
    DBDialog.ModalResult := mrok;
end;

function TJvBaseDBLogonDialog.EncryptPassword(const Value: string): string;
begin
  try
    Result := Value;
    if Assigned(FOnEncryptPassword) then
      FOnEncryptPassword(Result);
  except
    Result := '';
  end;
end;

procedure TJvBaseDBLogonDialog.FillAdditionalPopupMenuEntries(APopupMenu: TPopupMenu);
var
  MenuItem: TMenuItem;
begin
  if Options.ShowConnectionsExport then
  begin
    MenuItem := TMenuItem.Create(APopupMenu.Owner);
    MenuItem.Caption := RSExportConnectionList;
    MenuItem.OnClick := OnExportConnectionList;
    APopupMenu.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(APopupMenu.Owner);
    MenuItem.Caption := RSImportConnectionList;
    MenuItem.OnClick := OnImportConnectionList;
    APopupMenu.Items.Add(MenuItem);
  end;
end;

procedure TJvBaseDBLogonDialog.FillAllConnectionLists;
begin
  FillConnectionList;
  FillDatabaseTreeView;
  FillGroupTreeView;
  FillConnectGroupComboBox;
  FillDatabaseComboBox;
  CreateUserTreeView;
  SetButtonState;
end;

procedure TJvBaseDBLogonDialog.FillConnectGroupComboBox;
var
  i: Integer;
  Connection: TJvBaseConnectionInfo;
  Items: TStringList;
  IDynControlItems: IJvDynControlItems;
begin
  if Supports(ConnectGroupComboBox, IJvDynControlItems, IDynControlItems) then
  begin
    Items := TStringList.Create;
    try
      Items.Sorted := True;
      for i := 0 to ConnectionList.Count - 1 do
      begin
        Connection := ConnectionList.Connection[i];
        if Connection.Group <> '' then
          if Items.IndexOf(Connection.Group) < 0 then
            Items.Add(Connection.Group);
      end;
      IDynControlItems.ControlItems.Assign(Items);
    finally
      Items.Free;
    end;
  end;
end;

procedure TJvBaseDBLogonDialog.FillConnectionList;
var
  i: Integer;
  Connection: TJvBaseConnectionInfo;
  Items: TStrings;
begin
  if Assigned(IConnectListListBoxItems) then
  begin
    Items := IConnectListListBoxItems.ControlItems;
    Items.Clear;
    for i := 0 to ConnectionList.Count - 1 do
    begin
      Connection := ConnectionList.Connection[i];
      Items.AddObject(Connection.ConnectString(Options.ShowShortCuts, Options.ShowConnectGroup), Connection);
    end;
  end;
end;

procedure TJvBaseDBLogonDialog.FillDatabaseComboBox;
var
  i: Integer;
  Connection: TJvBaseConnectionInfo;
  Items: TStringList;
  IDynControlItems: IJvDynControlItems;
begin
  if Supports(DatabaseComboBox, IJvDynControlItems, IDynControlItems) then
  begin
    Items := TStringList.Create;
    try
      Items.Sorted := True;
      FillDatabaseComboBoxDefaultValues (Items);
      if Assigned(FOnFillDatabaseList) then
        FOnFillDatabaseList(Items);
      if Options.AddConnectionsToDatabaseComboBox then
        for i := 0 to ConnectionList.Count - 1 do
        begin
          Connection := ConnectionList.Connection[i];
          if Connection.Database <> '' then
            if Items.IndexOf(Connection.Database) < 0 then
              Items.Add(Connection.Database);
        end;
      IDynControlItems.ControlItems.Assign(Items);
    finally
      Items.Free;
    end;
  end;
end;

procedure TJvBaseDBLogonDialog.FillDatabaseComboBoxDefaultValues(Items: TStrings);
begin
end;

procedure TJvBaseDBLogonDialog.FillDatabaseTreeView;
var
  i, j: Integer;
  Node: TTreeNode;
  Found: Boolean;
  s: string;
  Connection: TJvBaseConnectionInfo;
  Items: TTreeNodes;
begin
  Items := IDatabaseTreeView.ControlItems;
  Items.Clear;
  for i := 0 to ConnectionList.Count - 1 do
  begin
    Connection := ConnectionList.Connection[i];
    s := Connection.ConnectString(Options.ShowShortCuts, Options.ShowConnectGroup);
    Found := False;
    for j := 0 to Items.Count - 1 do
      if Items[j].Level = 0 then
      begin
        Node := Items[j];
        if Node.Text = Connection.Database then
        begin
          Node := Items.AddChild(Node, s);
          Node.Data := Connection;
          Found := True;
          break;
        end;
      end;
    if not Found then
    begin
      Node := Items.AddChild(nil, Connection.Database);
      Node := Items.AddChild(Node, s);
      Node.Data := Connection;
    end;
  end;
  IDatabaseTreeView.ControlSortItems;
end;

procedure TJvBaseDBLogonDialog.FillShortCutList(Items: TStringList);
var
  I: Integer;
begin
  Items.Add('');
  for I := 1 to 10 do
    Items.Add(ShortCutToText(ShortCut($30 + Ord('0') + (I mod 10), [ssCtrl])));
  for I := 1 to 10 do
    Items.Add(ShortCutToText(ShortCut($30 + Ord('0') + (I mod 10), [ssCtrl, ssShift])));
  for I := 1 to 10 do
    Items.Add(ShortCutToText(ShortCut($30 + Ord('0') + (I mod 10), [ssAlt, ssShift])));
  for I := 1 to 10 do
    Items.Add(ShortCutToText(ShortCut($30 + Ord('0') + (I mod 10), [ssAlt, ssCtrl])));
  for I := 1 to 10 do
    Items.Add(ShortCutToText(ShortCut($30 + Ord('0') + (I mod 10), [ssAlt, ssCtrl, ssShift])));
end;

procedure TJvBaseDBLogonDialog.FormClose(Sender: TObject; var Action:TCloseAction);
begin
  if DBDialog.ModalResult = mrOk then
  begin
    if Options.SaveLastConnect then
      TransferConnectionInfoFromDialog(ConnectionList.LastConnect);
    StoreSettings;
  end;
  ClearControlInterfaceObjects;
  Action := caFree;
end;

procedure TJvBaseDBLogonDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
  Connection: TJvBaseConnectionInfo;
  sKey: Word;
  sShift: TShiftState;
begin
  for i := 0 to ConnectionList.Count - 1 do
  begin
    ShortCutToKey(ConnectionList.Connection[i].Shortcut, sKey, sShift);
    if (sKey = Key) and (sShift = Shift) then
    begin
      Connection := ConnectionList.Connection[i];
      TransferConnectionInfoToDialog(Connection);
      ConnectToSession;
      Exit;
    end;
  end;
end;

procedure TJvBaseDBLogonDialog.FormShow(Sender: TObject);
begin
  LoadSettings;
  ResizeFormControls;
  ClearFormControls;
  FillAllConnectionLists;
  TransferSessionDataToDialog;
  if (DialogUserName = '') and Options.SaveLastConnect then
    TransferConnectionInfoToDialog(ConnectionList.LastConnect);
end;

function TJvBaseDBLogonDialog.GetActivePage: TJvDBLogonDialogActivePage;
begin
  if IConnectionListPageControlTab.ControlTabIndex = 1 then
    Result := ldapUserTree
  else
    if IConnectionListPageControlTab.ControlTabIndex = 2 then
      Result := ldapDatabaseTree
    else
      if IConnectionListPageControlTab.ControlTabIndex = 3 then
        Result := ldapGroupTree
      else
        Result := ldapConnectList;
end;

function TJvBaseDBLogonDialog.GetCurrentDialogConnectionInfo: TJvBaseConnectionInfo;
begin
  Result := nil;
  case ActivePage of
    ldapUserTree:
      if Assigned(IUserTreeView.ControlGetSelected) and
        (IUserTreeView.ControlGetSelected.Level > 0) then
        Result := IUserTreeView.ControlGetSelected.Data;
    ldapDatabaseTree:
      if Assigned(IDatabaseTreeView.ControlGetSelected) and
        (IDatabaseTreeView.ControlGetSelected.Level > 0) then
        Result := IDatabaseTreeView.ControlGetSelected.Data;
    ldapGroupTree:
      if Assigned(IGroupTreeView) and
        Assigned(IGroupTreeView.ControlGetSelected) and
        (IGroupTreeView.ControlGetSelected.Level > 0) then
        Result := IGroupTreeView.ControlGetSelected.Data;
    ldapConnectList:
      if (IConnectListListBoxItems.ControlItems.Count > 0) and
        (IConnectListListBoxData.ControlValue >= 0) and
        (IConnectListListBoxData.ControlValue <= IConnectListListBoxItems.ControlItems.Count - 1) then
        Result :=
          TJvBaseConnectionInfo(IConnectListListBoxItems.ControlItems.Objects[IConnectListListBoxData.ControlValue]);
  end;
end;

class function TJvBaseDBLogonDialog.GetDBLogonConnectionListClass: TJvBaseConnectionListClass;
begin
  Result := TJvBaseConnectionList;
end;

class function TJvBaseDBLogonDialog.GetDBLogonDialogOptionsClass: TJvBaseDBLogonDialogOptionsClass;
begin
  Result := TJvBaseDBLogonDialogOptions;
end;

function TJvBaseDBLogonDialog.GetDialogDatabase: string;
begin
  if Assigned(IDatabaseComboBoxData) then
    Result := IDatabaseComboBoxData.ControlValue
  else
    Result := '';
end;

function TJvBaseDBLogonDialog.GetDialogPassword: string;
begin
  if Assigned(IPasswordEditData) then
    Result := IPasswordEditData.ControlValue
  else
    Result := '';
end;

function TJvBaseDBLogonDialog.GetDialogUserName: string;
begin
  if Assigned(IUserNameEditData) then
    Result := IUserNameEditData.ControlValue
  else
    Result := '';
end;

procedure TJvBaseDBLogonDialog.GetFromListBtnClick(Sender: TObject);
begin
  TransferConnectionInfoToDialog(CurrentDialogConnectionInfo);
end;

function TJvBaseDBLogonDialog.GetGroupByDatabase: Boolean;
begin
  Result := FGroupByDatabase;
end;

function TJvBaseDBLogonDialog.GetGroupByUser: Boolean;
begin
  Result := fGroupByUser;
end;

procedure TJvBaseDBLogonDialog.GroupByDatabaseCheckBoxClick(Sender: TObject);
begin
  if Assigned(IGroupByDatabaseCheckBox) then
    //GroupByDatabase := not GroupByDatabase;
    GroupByDatabase := IGroupByDatabaseCheckBox.ControlState = cbChecked;
end;

procedure TJvBaseDBLogonDialog.GroupByUserCheckBoxClick(Sender: TObject);
begin
  if Assigned(IGroupByUserCheckBox) then
    //GroupByUser := not GroupByUser;
    GroupByUser := IGroupByUserCheckBox.ControlState = cbChecked;
end;

procedure TJvBaseDBLogonDialog.LoadSettings;
begin
  ConnectionList.SavePasswords := SavePasswords;
  ConnectionList.LoadProperties;
  if Options.ShowSavePasswords then
    if ConnectionList.SavePasswords then
      ISavePasswordsCheckBox.ControlState := cbChecked
    else
      ISavePasswordsCheckBox.ControlState := cbUnChecked;
  if Assigned(IGroupByDatabaseCheckBox) then
    if ConnectionList.GroupByDatabase then
      IGroupByDatabaseCheckBox.ControlState := cbChecked
    else
      IGroupByDatabaseCheckBox.ControlState := cbUnChecked;
  if Assigned(IGroupByUserCheckBox) then
    if ConnectionList.GroupByUser then
      IGroupByUserCheckBox.ControlState := cbChecked
    else
      IGroupByUserCheckBox.ControlState := cbUnChecked;
  ActivePage := ConnectionList.ActivePage;
end;

procedure TJvBaseDBLogonDialog.OnExportConnectionList(Sender: TObject);
var
  Savedialog: TSaveDialog;
  TmpAppStorage: TJvCustomAppMemoryFileStorage;
  FileName: string;
  Extention: string;
  TmpConnectionList: TJvBaseConnectionList;
begin
  TmpAppStorage := nil;
  Savedialog := TSaveDialog.Create(Self);
  TmpConnectionList := GetDBLogonConnectionListClass.Create(Self);
  try
    TmpConnectionList.CopyContents(ConnectionList, True);
    with SaveDialog do
    begin
      Filter := RsConnectionListExportImportFilter;
      Name := 'SaveDialog';
      DefaultExt := 'xml';
      Options := [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing];
    end;
    if Savedialog.Execute then
    begin
      FileName := SaveDialog.FileName;
      Extention := ExtractFileExt(Filename);
      if UpperCase(extention) = '.INI' then
      begin
        TmpAppStorage := TJvAppIniFileStorage.Create(Self);
        //        TJvAppIniFileStorage(TmpAppStorage).Section := 'Export/Import';
      end
      else
      begin
        TmpAppStorage := TJvAppXMLFileStorage.Create(Self);
        TJvAppXMLFileStorage(TMPAppStorage).StorageOptions.WhiteSpaceReplacement := '_';
      end;
      TmpAppStorage.FileName := Filename;
      TmpAppStorage.Location := flCustom;
      TmpConnectionList.AppStorage := TmpAppStorage;
      TmpConnectionList.AppStoragePath := ConnectionList.AppStoragePath;
      TmpConnectionList.SavePasswords := False;
      TmpConnectionList.StoreProperties;
      TmpAppStorage.Flush;
    end;
  finally
    if Assigned(TmpAppStorage) then
      FreeAndNil(TmpAppStorage);
    FreeAndNil(SaveDialog);
    FreeAndNIl(TmpConnectionList);
  end;
end;

procedure TJvBaseDBLogonDialog.OnImportConnectionList(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  TmpAppStorage: TJvCustomAppMemoryFileStorage;
  FileName: string;
  Extention: string;
  TmpConnectionList: TJvBaseConnectionList;
  ClearBefore: Boolean;
  Buttons: array[0..2] of string;
  Results: array[0..2] of Integer;
begin
  TmpAppStorage := nil;
  OpenDialog := TOpenDialog.Create(Self);
  TmpConnectionList := GetDBLogonConnectionListClass.Create(Self);
  try
    with OpenDialog do
    begin
      Filter := RsConnectionListExportImportFilter;
      Name := 'OpenDialog';
      DefaultExt := 'xml';
      Options := [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    end;
    if OpenDialog.Execute then
    begin
      FileName := OpenDialog.FileName;
      Extention := ExtractFileExt(Filename);
      if UpperCase(extention) = '.INI' then
      begin
        TmpAppStorage := TJvAppIniFileStorage.Create(Self);
      end
      else
      begin
        TmpAppStorage := TJvAppXMLFileStorage.Create(Self);
        TJvAppXMLFileStorage(TMPAppStorage).StorageOptions.WhiteSpaceReplacement := '_';
      end;
      TmpAppStorage.FileName := Filename;
      TmpAppStorage.Location := flCustom;
      TmpConnectionList.AppStorage := TmpAppStorage;
      TmpConnectionList.AppStoragePath := ConnectionList.AppStoragePath;
      TmpConnectionList.LoadProperties;
      if TmpConnectionList.Count <= 0 then
      begin
        JVDsaDialogs.MessageDlg(RsNoConnectionEntriesFound, mtError, [mbok], 0, dckScreen,
          0, mbDefault, mbDefault, mbDefault, DynControlEngine);
        exit;
      end;
      ClearBefore := True;
      if ConnectionList.Count > 0 then
      begin
        Buttons[0] := RsConnectionListImportAppend;
        Buttons[1] := RsConnectionListImportOverwrite;
        Buttons[2] := RsButtonCancelCaption;
        Results[0] := Integer(mrYes);
        Results[1] := Integer(mrNo);
        Results[2] := Integer(mrCancel);
        case JVDsaDialogs.MessageDlgEx(RsConnectionListImportAppendOverwriteExistingEntries,
          mtConfirmation, Buttons, Results, 0, dckScreen, 0,
          0, 2, -1, DynControlEngine) of
          mrYes:
            ClearBefore := False;
          mrNo:
            ClearBefore := True;
        else
          Exit;
        end;
      end;
      ConnectionList.CopyContents(TmpConnectionList, ClearBefore);
      FillAllConnectionLists
    end;
  finally
    if Assigned(TmpAppStorage) then
      FreeAndNil(TmpAppStorage);
    FreeAndNil(OpenDialog);
    FreeAndNIl(TmpConnectionList);
  end;
end;

procedure TJvBaseDBLogonDialog.PasswordDialog_BeforeTransferPasswordToSession(var Password: string);
var
  Connection: TJvBaseConnectionInfo;
begin
  Connection := TJvBaseConnectionInfo.Create(nil);
  try
    Connection.Password := Password;
    if Assigned(BeforeTransferConnectionInfoToSessionData) then
      BeforeTransferConnectionInfoToSessionData(Connection);
    Password := Connection.Password;
  finally
    Connection.Free;
  end;
end;

procedure TJvBaseDBLogonDialog.PasswordDialog_AfterTransferPasswordFromSession(var Password: string);
var
  Connection: TJvBaseConnectionInfo;
begin
  Connection := TJvBaseConnectionInfo.Create(nil);
  try
    Connection.Password := Password;
    if Assigned(AfterTransferSessionDataToConnectionInfo) then
      AfterTransferSessionDataToConnectionInfo(Connection);
    Password := Connection.Password;
  finally
    Connection.Free;
  end;
end;

procedure TJvBaseDBLogonDialog.PasswordEditChange(Sender: TObject);
begin
  SetConnectBtnEnabled;
end;

procedure TJvBaseDBLogonDialog.RemoveFromListBtnClick(Sender: TObject);
var
  Index: Integer;
  Connection: TJvBaseConnectionInfo;
begin
  Connection := CurrentDialogConnectionInfo;
  if Assigned(Connection) then
  begin
    Index := ConnectionList.Items.IndexOfObject(Connection);
    if (Index >= 0) and
      (Index < ConnectionList.Count) then
    begin
      ConnectionList.Items.delete(Index);
      FillAllConnectionLists;
    end;
  end;
end;

procedure TJvBaseDBLogonDialog.ResizeFormControls;
begin
  ConnectPanel.Height := CalculatePanelHeight(DatabaseComboBox);
  ConnectGroupPanel.Height := CalculatePanelHeight(ConnectGroupComboBox);
  ShortCutPanel.Height := CalculatePanelHeight(ShortCutComboBox);
  CancelBtn.Left := DBDialog.ClientWidth - CancelBtn.Width - 5;
  ConnectBtn.Left := CancelBtn.Left - ConnectBtn.Width - 5;
  AdditionalBtn.Left := 5;
end;

function TJvBaseDBLogonDialog.SavePasswords: Boolean;
begin
  if not Options.SavePasswords then
    Result := False
  else
    if Options.ShowSavePasswords then
      Result := ISavePasswordsCheckBox.ControlState = cbChecked
    else
      Result := True;
end;

procedure TJvBaseDBLogonDialog.SetActivePage(const Value: TJvDBLogonDialogActivePage);
begin
  case Value of
    ldapUserTree:
      IConnectionListPageControlTab.ControlTabIndex := 1;
    ldapDatabaseTree:
      IConnectionListPageControlTab.ControlTabIndex := 2;
    ldapGroupTree:
      IConnectionListPageControlTab.ControlTabIndex := 3;
  else
    IConnectionListPageControlTab.ControlTabIndex := 0;
  end;
end;

procedure TJvBaseDBLogonDialog.SetAppStorage(Value: TJvCustomAppStorage);
begin
  if Value <> AppStorage then
    ConnectionList.AppStorage := Value;
  inherited SetAppStorage(Value);
end;

procedure TJvBaseDBLogonDialog.SetAppStoragePath(Value: string);
begin
  if Value <> AppStoragePath then
    ConnectionList.AppStoragePath := Value;
  inherited SetAppStoragePath(Value);
end;

procedure TJvBaseDBLogonDialog.SetButtonState;
begin
  if not Assigned(DBDialog) then
    Exit;
  GetFromListBtn.Enabled := Assigned(CurrentDialogConnectionInfo);
  RemoveFromListBtn.Enabled := GetFromListBtn.Enabled;
end;

procedure TJvBaseDBLogonDialog.SetConnectBtnEnabled;
begin
  if Options.AllowNullPasswords then
    ConnectBtn.Enabled := (DialogUserName <> '') and (DialogDatabase <> '')
  else
    ConnectBtn.Enabled := (DialogUserName <> '') and (DialogPassword <> '') and (DialogDatabase <> '');
  AddToListBtn.Enabled := ConnectBtn.Enabled;
end;

procedure TJvBaseDBLogonDialog.SetConnectionToTop(Username, Database: string);
var
  p: Integer;
begin
  p := Connectionlist.IndexOfNames(Username, Database);
  if p >= 0 then
    ConnectionList.Items.Move(p, 0);
end;

procedure TJvBaseDBLogonDialog.SetDialogDatabase(const Value: string);
begin
  if Assigned(IDatabaseComboBoxData) then
    IDatabaseComboBoxData.ControlValue := Value;
end;

procedure TJvBaseDBLogonDialog.SetDialogPassword(const Value: string);
begin
  if Assigned(IPasswordEditData) then
    IPasswordEditData.ControlValue := Value;
end;

procedure TJvBaseDBLogonDialog.SetDialogUserName(const Value: string);
begin
  if Assigned(IUserNameEditData) then
    IUserNameEditData.ControlValue := Value;
end;

procedure TJvBaseDBLogonDialog.SetGroupByDatabase(Value: Boolean);
var
  Change: Boolean;
begin
  Change := Value <> FGroupByDatabase;
  if Change then
  begin
    if Assigned(IGroupByDatabaseCheckBox) then
      if Value then
        IGroupByDatabaseCheckBox.ControlSetState(cbChecked)
      else
        IGroupByDatabaseCheckBox.ControlSetState(cbUnChecked);
    if Assigned(IGroupByUserCheckBox) then
      if Value and GroupByUser then
        IGroupByUserCheckBox.ControlSetState(cbUnChecked);
  end;
  FGroupByDatabase := Value;
  if Change then
    FillGroupTreeView;
end;

procedure TJvBaseDBLogonDialog.SetGroupByUser(Value: Boolean);
var
  Change: Boolean;
begin
  Change := Value <> fGroupByUser;
  if Change then
  begin
    if Assigned(IGroupByUserCheckBox) then
      if Value then
        IGroupByUserCheckBox.ControlSetState(cbChecked)
      else
        IGroupByUserCheckBox.ControlSetState(cbUnChecked);
    if Assigned(IGroupByDatabaseCheckBox) then
      if Value and GroupByDatabase then
        IGroupByDatabaseCheckBox.ControlSetState(cbUnChecked);
  end;
  fGroupByUser := Value;
  if Change then
    FillGroupTreeView;
end;

procedure TJvBaseDBLogonDialog.SetOptions(const Value: TJvBaseDBLogonDialogOptions);
begin
  FOptions.Assign(Value);
end;

procedure TJvBaseDBLogonDialog.SetSession(const Value: TComponent);
begin
  inherited SetSession(Value);
  TransferSessionDataToDialog;
end;

procedure TJvBaseDBLogonDialog.StoreSettings;
begin
  ConnectionList.GroupByDatabase := Assigned(IGroupByDatabaseCheckBox) and
    (IGroupByDatabaseCheckBox.ControlState = cbChecked);
  ConnectionList.GroupByUser := Assigned(IGroupByUserCheckBox) and
    (IGroupByUserCheckBox.ControlState = cbChecked);
  ConnectionList.ActivePage := ActivePage;
  ConnectionList.SavePasswords := SavePasswords;
  ConnectionList.StoreProperties;
end;

procedure TJvBaseDBLogonDialog.TransferConnectionInfoFromDialog(ConnectionInfo: TJvBaseConnectionInfo);
begin
  if Assigned(ConnectionInfo) and Assigned(DBDialog) then
  begin
    if Options.UsernameCaseSensitive then
      ConnectionInfo.Username := IUserNameEditData.ControlValue
    else
      ConnectionInfo.Username := UpperCase(IUserNameEditData.ControlValue);
    ConnectionInfo.Password := EncryptPassword(IPasswordEditData.ControlValue);
    if Options.DatabasenameCaseSensitive then
      ConnectionInfo.Database := IDatabaseComboBoxData.ControlValue
    else
      ConnectionInfo.Database := UpperCase(IDatabaseComboBoxData.ControlValue);
    if Options.ShowConnectGroup then
      ConnectionInfo.Group := IConnectGroupComboBoxData.ControlValue;
    if Options.ShowShortcuts then
      ConnectionInfo.ShortCutText := IShortCutComboBoxData.ControlValue;
  end;
end;

procedure TJvBaseDBLogonDialog.TransferConnectionInfoToDialog(ConnectionInfo: TJvBaseConnectionInfo);
begin
  if Assigned(ConnectionInfo) and Assigned(DBDialog) then
  begin
    DialogUserName := ConnectionInfo.Username;
    if SavePasswords then
      DialogPassword := DecryptPassword(ConnectionInfo.Password);
    DialogDatabase := ConnectionInfo.Database;
    if Options.ShowConnectGroup and Assigned(IConnectGroupComboBoxData) then
      IConnectGroupComboBoxData.ControlValue := ConnectionInfo.Group;
    if Options.ShowShortcuts and Assigned(IShortCutComboBoxData) then
      IShortCutComboBoxData.ControlValue := ConnectionInfo.ShortCutText;
    if ConnectionInfo.Username = '' then
      UserNameEdit.SetFocus
    else
      if ConnectionInfo.Password = '' then
        PasswordEdit.SetFocus
      else
        if ConnectionInfo.Database = '' then
          DatabaseComboBox.SetFocus;
  end;
end;

procedure TJvBaseDBLogonDialog.TransferSessionDataFromDialog;
var
  tmpConnectionInfo: TJvBaseConnectionInfo;
begin
  if not Assigned(DBDialog) then
    Exit;
  tmpConnectionInfo := ConnectionList.CreateConnection;
  try
    TransferConnectionInfoFromDialog(tmpConnectionInfo);
    tmpConnectionInfo.Password := DecryptPassword(tmpConnectionInfo.Password);
    if Assigned(BeforeTransferConnectionInfoToSessionData) then
      BeforeTransferConnectionInfoToSessionData(tmpConnectionInfo);
    TransferSessionDataFromConnectionInfo(tmpConnectionInfo);
  finally
    tmpConnectionInfo.Free;
  end;
end;

procedure TJvBaseDBLogonDialog.TransferSessionDataFromConnectionInfo(ConnectionInfo: TJvBaseConnectionInfo);
begin
end;

procedure TJvBaseDBLogonDialog.TransferSessionDataToDialog;
var
  tmpConnectionInfo: TJvBaseConnectionInfo;
begin
  if not Assigned(DBDialog) then
    Exit;
  tmpConnectionInfo := ConnectionList.CreateConnection;
  try
    TransferSessionDataToConnectionInfo(tmpConnectionInfo);
    tmpConnectionInfo.Password := EncryptPassword(tmpConnectionInfo.Password);
    if Assigned(AfterTransferSessionDataToConnectionInfo) then
      AfterTransferSessionDataToConnectionInfo(tmpConnectionInfo);
    TransferConnectionInfoToDialog(tmpConnectionInfo);
  finally
    tmpConnectionInfo.Free;
  end;
end;

procedure TJvBaseDBLogonDialog.TransferSessionDataToConnectionInfo(ConnectionInfo: TJvBaseConnectionInfo);
begin
end;

//=== { TJvBaseDBLogonDialogOptions } ========================================

constructor TJvBaseDBLogonDialogOptions.Create;
begin
  inherited Create;
  FShowShortcuts := True;
  FShowConnectionsExport := True;
  FSavePasswords := True;
  FShowColors := False;
  FAddConnectionsToDatabaseComboBox := True;
  FAllowNullPasswords := False;
  FSaveLastConnect := True;
  FSetLastConnectToTop := True;
  FShowConnectGroup := True;
  FShowSavePasswords := False;
  FUsernameCaseSensitive := False;
  FDatabasenameCaseSensitive := False;
  FPasswordChar := '*';
  FAllowPasswordChange := False;
  FPasswordDialogOptions := TJvBaseDBPasswordDialogOptions.Create;
end;

destructor TJvBaseDBLogonDialogOptions.Destroy;
begin
  FreeAndNil(FPasswordDialogOptions);
  inherited Destroy;
end;

//=== { TJvBaseDBOracleLogonDialogOptions } ==================================

constructor TJvBaseDBOracleLogonDialogOptions.Create;
begin
  inherited Create;
  FShowConnectAs := True;
end;

procedure TJvBaseDBOracleLogonDialog.ClearControlInterfaceObjects;
begin
  inherited ClearControlInterfaceObjects;
  IConnectAsComboBoxData := nil;
end;

procedure TJvBaseDBOracleLogonDialog.ClearFormControls;
begin
  inherited ClearFormControls;
  IConnectAsComboBoxData.ControlValue := 'NORMAL';
end;

procedure TJvBaseDBOracleLogonDialog.CreateAdditionalConnectDialogControls(AOwner: TComponent;
  AParentControl: TWinControl);
var
  Items: TStringList;
  LabelControl: TControl;
  IDynControlLabel: IJvDynControlLabel;
begin
  ConnectAsPanel := DynControlEngine.CreatePanelControl(AOwner, AParentControl, 'ConnectAsPanel', '', alTop);
  with ConnectAsPanel do
  begin
    Align := alTop;
  end;
  LabelControl := DynControlEngine.CreateLabelControl(AOwner, ConnectAsPanel, 'ConnectAsLabel', RsConnectAs, nil);
  with LabelControl do
  begin
    Align := alTop;
  end;
  Items := tStringList.Create;
  try
    Items.Add('NORMAL');
    Items.Add('SYSDBA');
    Items.Add('SYSOPER');
    ConnectAsComboBox := DynControlEngine.CreateComboBoxControl(AOwner, ConnectAsPanel, 'ConnectAsComboBox', Items);
    Supports(ConnectAsComboBox, IJvDynControlData, IConnectAsComboBoxData);
    with ConnectAsComboBox do
    begin
      Align := alTop;
    end;
  finally
    Items.Free;
  end;
  if Supports(LabelControl, IJvDynControlLabel, IDynControlLabel) then
    IDynControlLabel.ControlSetFocusControl(ConnectAsComboBox);
  ConnectAsPanel.Visible := Options.ShowConnectAs;
end;

procedure TJvBaseDBOracleLogonDialog.CreateFormControls(AForm: TForm);
begin
  inherited CreateFormControls(AForm);
end;

class function TJvBaseDBOracleLogonDialog.GetDBLogonConnectionListClass: TJvBaseConnectionListClass;
begin
  Result := TJvBaseOracleConnectionList;
end;

class function TJvBaseDBOracleLogonDialog.GetDBLogonDialogOptionsClass: TJvBaseDBLogonDialogOptionsClass;
begin
  Result := TJvBaseDBOracleLogonDialogOptions;
end;

function TJvBaseDBOracleLogonDialog.GetDialogConnectAs: string;
begin
  if Assigned(IConnectAsComboBoxData) then
    Result := UpperCase(IConnectAsComboBoxData.ControlValue)
  else
    Result := '';
end;

function TJvBaseDBOracleLogonDialog.GetOptions: TJvBaseDBOracleLogonDialogOptions;
begin
  Result := TJvBaseDBOracleLogonDialogOptions(inherited Options);
end;

procedure TJvBaseDBOracleLogonDialog.ResizeFormControls;
begin
  inherited ResizeFormControls;
  ConnectAsPanel.Height := CalculatePanelHeight(ConnectAsComboBox);
end;

procedure TJvBaseDBOracleLogonDialog.SetDialogConnectAs(const Value: string);
begin
  if Assigned(IConnectAsComboBoxData) then
    IConnectAsComboBoxData.ControlValue := Value;
end;

procedure TJvBaseDBOracleLogonDialog.SetOptions(const Value: TJvBaseDBOracleLogonDialogOptions);
begin
  (inherited Options).Assign(Value);
end;

procedure TJvBaseDBOracleLogonDialog.TransferConnectionInfoFromDialog(ConnectionInfo: TJvBaseConnectionInfo);
begin
  inherited TransferConnectionInfoFromDialog(ConnectionInfo);
  if Assigned(ConnectionInfo) then
  begin
    if Options.ShowConnectAs then
      TJvBaseOracleConnectionInfo(ConnectionInfo).ConnectAs := IConnectAsComboBoxData.ControlValue;
  end;
end;

procedure TJvBaseDBOracleLogonDialog.TransferConnectionInfoToDialog(ConnectionInfo: TJvBaseConnectionInfo);
begin
  inherited TransferConnectionInfoToDialog(ConnectionInfo);
  if Assigned(ConnectionInfo) then
  begin
    if Options.ShowConnectAs then
      IConnectAsComboBoxData.ControlValue := TJvBaseOracleConnectionInfo(ConnectionInfo).ConnectAs;
  end;
end;

//=== { TJvBaseConnectionInfo } ==============================================

destructor TJvBaseConnectionInfo.Destroy;
begin
  inherited Destroy;
end;

function TJvBaseConnectionInfo.ConnectString(ShowShortCut, ShowConnectGroup: Boolean): string;
begin
  if Password <> '' then
    Result := Username + '/*****@' + Database
  else
    Result := Username + '@' + Database;
  if ShowShortCut then
    if ShortCutText <> '' then
      Result := Result + ' (' + ShortCutText + ')';
  if ShowConnectGroup then
    if Group <> '' then
      Result := Result + ' - ' + Group;
end;

function TJvBaseConnectionInfo.GetShortCutText: string;
begin
  Result := ShortCutToText(ShortCut);
end;

procedure TJvBaseConnectionInfo.SetDatabase(Value: string);
begin
  FDatabase := Trim(Value);
end;

procedure TJvBaseConnectionInfo.SetGroup(const Value: string);
begin
  FGroup := Trim(Value);
end;

procedure TJvBaseConnectionInfo.SetSavePassword(const Value: Boolean);
const
  cPassword = 'Password';
begin
  FSavePassword := Value;
  if Value then
  begin
    if IgnoreProperties.IndexOf(cPassword) >= 0 then
      IgnoreProperties.Delete(IgnoreProperties.IndexOf(cPassword))
  end
  else
    if IgnoreProperties.IndexOf(cPassword) < 0 then
      IgnoreProperties.Add(cPassword);
end;

procedure TJvBaseConnectionInfo.SetShortCutText(const Value: string);
begin
  try
    ShortCut := TextToShortCut(Value);
  except
    ShortCut := 0;
  end;
end;

procedure TJvBaseConnectionInfo.SetUsername(Value: string);
begin
  fUserName := Trim(Value);
end;

function TJvBaseConnectionInfo.UserDatabaseString: string;
begin
  Result := Username + '@' + Database;
end;

//=== { TJvBaseOracleConnectionInfo } ========================================

constructor TJvBaseOracleConnectionInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConnectAs := 'NORMAL';
end;

function TJvBaseOracleConnectionInfo.ConnectString(ShowShortCut, ShowConnectGroup: Boolean): string;
begin
  if Password <> '' then
    Result := Username + '/*****@' + Database
  else
    Result := Username + '@' + Database;
  if ShowShortCut then
    if ShortCutText <> '' then
      Result := Result + ' (' + ShortCutText + ')';
  if ConnectAs <> 'NORMAL' then
    Result := Result + ' [' + ConnectAs + ']';
  if ShowConnectGroup then
    if Group <> '' then
      Result := Result + ' - ' + Group;
end;

procedure TJvBaseOracleConnectionInfo.SetConnectAs(const Value: string);
begin
  FConnectAs := Trim(UpperCase(Value));
end;

//=== { TJvBaseConnectionList } ==============================================

constructor TJvBaseConnectionList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLastConnect := TJvBaseConnectionInfo(CreateObject);
  ItemName := RsConnectionListItemName;
end;

destructor TJvBaseConnectionList.Destroy;
begin
  FreeAndNil(FLastConnect);
  inherited Destroy;
end;

procedure TJvBaseConnectionList.AddConnection(ConnectionInfo: TJvBaseConnectionInfo);
var
  p, p2, i: Integer;
begin
  p := Items.IndexOf(ConnectionInfo.UserDatabaseString);
  while p <> -1 do
  begin
    Items.Delete(p);
    p := Items.IndexOf(ConnectionInfo.UserDatabaseString);
  end;
  p2 := Items.AddObject(ConnectionInfo.UserDatabaseString, ConnectionInfo);
  if ConnectionInfo.ShortCut > 0 then
    for i := 0 to Count - 1 do
      if i <> p2 then
        if Connection[i].ShortCut = ConnectionInfo.ShortCut then
          Connection[i].ShortCut := 0;
  Items.Move(p2, 0);
end;

procedure TJvBaseConnectionList.CopyContents(iConnectionList: TJvBaseConnectionList; iClearBefore: Boolean);
var
  i: Integer;
  Connection: TJvBaseConnectionInfo;
begin
  if iClearBefore then
    Clear;
  if not Assigned(iConnectionList) then
    Exit;
  for i := 0 to iConnectionList.Items.Count - 1 do
  begin
    Connection := CreateConnection;
    Connection.Assign(iConnectionList.Connection[i]);
    AddConnection(Connection);
  end;
end;

function TJvBaseConnectionList.CreateConnection: TJvBaseConnectionInfo;
begin
  Result := TJvBaseConnectionInfo(CreateObject);
end;

function TJvBaseConnectionList.CreateObject: TObject;
begin
  Result := TJvBaseConnectionInfo.Create(Self);
end;

function TJvBaseConnectionList.GetConnection(I: Longint): TJvBaseConnectionInfo;
begin
  if (i >= 0) and (i < Count) then
    Result := TJvBaseConnectionInfo(Objects[i])
  else
    Result := nil;
end;

function TJvBaseConnectionList.IndexOfNames(const Username, Database: string): Integer;
var
  Connection: TJvBaseConnectionInfo;
begin
  Connection := TJvBaseConnectionInfo.Create(nil);
  try
    Connection.Username := Username;
    Connection.Database := Database;
    Result := Items.IndexOf(Connection.UserDatabaseString);
  finally
    Connection.Free;
  end;
end;

procedure TJvBaseConnectionList.SetLastConnect(const Value: TJvBaseConnectionInfo);
begin
  FLastConnect := Value;
end;

procedure TJvBaseConnectionList.SetSavePasswords(const Value: Boolean);
var
  i: Integer;
begin
  FSavePasswords := Value;
  for i := 0 to Count - 1 do
    Connection[i].SavePassword := Value;
end;

function TJvBaseOracleConnectionList.CreateObject: TObject;
begin
  Result := TJvBaseOracleConnectionInfo.Create(Self);
  TJvBaseOracleConnectionInfo(Result).SavePassword := SavePasswords;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

