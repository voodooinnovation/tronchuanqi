{===============================================================================
  RzDBCmbo Unit

  Raize Components - Component Source Unit

  Copyright � 1995-2007 by Raize Software, Inc.  All Rights Reserved.


  Components
  ------------------------------------------------------------------------------
  TRzDBComboBox
    Data-Aware TRzComboBox

  TRzDBLookupComboBox
    Descendant of TDBLookupComboBox--adds support for Custom Framing, AllowNull,
    etc.


  Modification History
  ------------------------------------------------------------------------------
  4.3    (13 Sep 2007)
    * Added AutoDropDown property to TRzDBLookupComboBox.
  ------------------------------------------------------------------------------
  4.1    (15 Dec 2006)
    * Added ClearItemsValues and InsertItemValue methods to TRzDBComboBox.
  ------------------------------------------------------------------------------
  4.0.3  (05 Apr 2006)
    * Fixed problem where a user could not type in non-numeric characters when a
      TRzDBComboBox was connected to an Integer database field *and* the Values
      list contains integers, but the Items list contains strings.
    * When pressing the Delete within a TRzDBLookupComboBox that is NOT
      connected to a DataSource, the ClearKeyValue method is called.
    * Reworked the way keys are handled by the TRzDBComboBox. The TDBComboBox
      control does not check if accelerator characters are pressed. The same was
      true for the TRzDBComboBox control, which resulted in the connected
      dataset being placed into edit mode if an accelerator key combination
      (i.e. Alt+<key>) was invoke while the combo box had the focus.
  ------------------------------------------------------------------------------
  4.0.2  (13 Jan 2006)
    * Surfaced ReadOnlyColorOnFocus in TRzDBComboBox.
    * Added ReadOnlyColorOnFocus property to TRzDBLookupComboBox. This
      property determines if the ReadOnlyColor or FocusColor is used to color
      the control when the control has the focus and has its ReadOnly property
      set to True. By default, a focused control will use the FocusColor even
      if the control is read-only. Setting ReadOnlyColorOnFocus to True will
      cause a focused read-only control to be colored using ReadOnlyColor.
  ------------------------------------------------------------------------------
  4.0.1  (07 Jan 2006)
    * Changed the preference order between FocusColor and ReadOnlyColor
      properties in TRzDBLookupComboBox. In the previous ordering, a ReadOnly
      control would be displayed in ReadOnlyColor even when the control had the
      focus. Now, a ReadOnly control that has the input focus is displayed in
      FocusColor.
  ------------------------------------------------------------------------------
  4.0    (23 Dec 2005)
    * Fixed custom framing display problem that would occur in TRzDBComboBox
      when FrameVisible was set to True and changes were made to control's
      appearance within calls to LockWindowUpdate.
    * Fixed problem where combo box text would not get updated if the when the
      dataset would change and the Value property was the same.
    * Fixed problem where the TRzComboBox.OnMatch event would occur as the user
      typed more of the item's text even though the ItemIndex did not change.
    * Eliminated inconsistencies in the way the Escape key was being handled
      in the data-aware TRzDBComboBox versus the non-data-aware TRzComboBox and
      between the csDropDown and csDropDownList styles.  Now, if the list is
      dropped down, the Escape key will close the list. If the list is not
      dropped, then pressing Escape in the TRzDBComboBox will reset the data
      value and not select the first item in the list.
    * Added check in TRzDBComboBox to prevent the OnChange event from firing
      when the combo box is updated as a result of changing to a new record
      in a dataset.  The OnChange event is only fired when the user changes the
      selection in the combo box.
    * Redesigned OnMouseEnter and OnMouseLeave events in TRzDBLookupComboBox to
      account for changes introduced in Borland Developer Studio 2006.
    * Fixed BiDi issues in TRzDBLookupComboBox.
    * The drop down arrow in TRzDBLookupComboBox now appears disabled when the
      control is disabled or the control is not connected to a lookup source.
    * Added ReadOnlyColor property to TRzDBComboBox and TRzDBLookupComboBox.
      This color property is used to change the color of the control when the
      ReadOnly property is set to True.
    * When the ReadOnly property is set to True in a TRzDBLookupComboBox, the
      drop down button is hidden.
    * Added new FrameControllerNotifications property to TRzDBComboBox and
      TRzDBLookupComboBox.
      The FrameControllerNotifications set property defines which
      TRzFrameController properties will be handled by the control.
      By default all TRzFrameController properties will be handled.
  ------------------------------------------------------------------------------
  3.1    (04 Aug 2005)
    * Added the new Values property to TRzDBComboBox, which operates in much the
      same way the Values property of the TRzDBRadioGroup. That is, each string
      in the Values list is related to the string in the Items list at the same
      index.  However, when the user selects a particular items from the
      dropdown list (which displays the Items), the corresponding item from the
      Values list is stored in the database field.  If the Values list is not
      used, the selected string from the Items list is stored in the database.
    * Added TRzDBComboBox.Value property, which provides easy access to the
      selected "value" from the Values list that corresponds to the ItemIndex.
    * Added the TRzDBComboBox.AddItemValue method, which makes it easy to
      add an item and corresponding value to the Items and Values lists,
      respectively.
  ------------------------------------------------------------------------------
  3.0.13 (15 May 2005)
    * Surfaced inherited Align property in TRzDBLookupComboBox.
  ------------------------------------------------------------------------------
  3.0.11 (12 Dec 2004)
    * Surfaced inherited KeepSearchCase property in TRzDBComboBox.
    * Fixed issue where drop-down button of TRzDBLookupComboBox would get
      displayed on the wrong side of the control in certain circumstances while
      running under RTL locales.
  ------------------------------------------------------------------------------
  3.0.3  (21 Jan 2003)
    * Added StoreColor and StoreFocusColor methods so that if control is
      disabled at design-time the Color and FocusColor properties are not
      streamed with the disabled color value.
  ------------------------------------------------------------------------------
  3.0    (20 Dec 2002)
    * Added following methods to TRzDBLookupComboBox: GetListValue, GetKeyValue,
      InitKeyValue, ClearKeyValue. (Enhancements to TRzDBLookupComboBox provided 
      courtesy of Jeroen Pluimers.)

    * Renamed FrameFlat property to FrameHotTrack.
    * Renamed FrameFocusStyle property to FrameHotStyle.
    * Removed FrameFlatStyle property.
    * Added FocusColor and DisabledColor properties.
    * Added FramingPreference property.
===============================================================================}

{$I RzComps.inc}

unit RzDBCmbo;

interface

uses
  {$IFDEF USE_CS}
  CodeSiteLogging,
  {$ENDIF}
  SysUtils,
  Messages,
  Windows,
  Classes,
  Graphics,
  Forms,
  Controls,
  StdCtrls,
  ExtCtrls,
  RzCmboBx,
  DBCtrls,
  DB,
  {$IFDEF VCL60_OR_HIGHER}
  VDBConsts,
  Variants,
  {$ELSE}
  DBConsts,
  {$ENDIF}
  RzCommon;

type
  TRzDBComboBox = class;

  {=============================================================================
    TRzPaintComboBox is a simple panel descendant that knows how to look like a
    TRzDBComboBox component. This is necessary for the TRzDBComboBox component
    to appear correctly when used in a TDBCtrlGrid. The problem is that the
    TDBCtrlGrid uses a technique that relies on the control being replicated
    painting itself using a shared device context. Since the standard combo box
    control does not do this, the TRzPaintComboBox component is used for
    replicated instances of a TRzDBComboBox.
  =============================================================================}

  TRzPaintComboBox = class( TCustomPanel )
  private
    FComboBox: TRzDBComboBox;
  protected
    procedure Paint; override;
  public
    constructor Create( AOwner: TComponent ); override;
  end;


  {=====================================}
  {== TRzDBComboBox Class Declaration ==}
  {=====================================}

  TRzDBComboBox = class( TRzCustomComboBox )
  private
    FAboutInfo: TRzAboutInfo;
    FDataLink: TFieldDataLink;
    FPaintControl: TRzPaintComboBox;
    FValue: string;
    FValues: TStrings;
    FInSetValue: Boolean;
    FInDataChange: Boolean;
    FForceSetValue: Boolean;

    { Internal Event Handlers }
    procedure DataChange( Sender: TObject );
    procedure EditingChange( Sender: TObject );
    procedure UpdateData( Sender: TObject );
    procedure ValuesChangedHandler( Sender: TObject );

    { Message Handling Methods }
    procedure CMEnter( var Msg: TCMEnter ); message cm_Enter;
    procedure CMExit( var Msg: TCMExit ); message cm_Exit;
    procedure CMGetDataLink( var Msg: TMessage ); message cm_GetDataLink;
    procedure WMPaint( var Msg: TWMPaint ); message wm_Paint;
    procedure WMChar( var Msg: TWMChar ); message wm_Char;
  protected
    procedure CreateWnd; override;
    procedure Notification( AComponent: TComponent; Operation: TOperation ); override;
    procedure ComboWndProc( var Msg: TMessage; ComboWnd: HWnd; ComboProc: Pointer ); override;
    procedure WndProc( var Msg: TMessage ); override;
    procedure Loaded; override;

    { Event Dispatch Methods }
    procedure Change; override;
    procedure Click; override;
    procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
    procedure KeyPress( var Key: Char ); override;
    function DoMouseWheelDown( Shift: TShiftState; MousePos: TPoint ): Boolean; override;
    function DoMouseWheelUp( Shift: TShiftState; MousePos: TPoint ): Boolean; override;

    { Property Access Methods }
    function GetComboText: string; virtual;
    procedure SetComboText( const Value: string ); virtual;
    function GetDataField: string; virtual;
    procedure SetDataField( const Value: string ); virtual;
    function GetDataSource: TDataSource; virtual;
    procedure SetDataSource( Value: TDataSource ); virtual;
    procedure SetEditReadOnly; virtual;
    function GetField: TField; virtual;
    {$IFDEF VCL60_OR_HIGHER}
    procedure SetItems( const Value: TStrings ); override;
    {$ELSE}
    procedure SetItems( const Value: TStrings ); virtual;
    {$ENDIF}
    function GetReadOnly: Boolean; virtual;
    procedure SetReadOnly (Value: Boolean ); override;
    procedure SetStyle( Value: TComboboxStyle ); override;
    function GetItemValue( Index: Integer ): string; virtual;
    function GetValue: string; virtual;
    procedure SetValue( const Value: string ); virtual;
    procedure SetValues( Value: TStrings ); virtual;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;

    procedure ClearItemsValues;
    procedure AddItemValue( const Item, Value: string );
    procedure InsertItemValue( Index: Integer; const Item, Value: string );

    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;

    property Field: TField
      read GetField;

    property Value: string
      read GetValue
      write SetValue;

    property Text;
  published
    property About: TRzAboutInfo
      read FAboutInfo
      write FAboutInfo
      stored False;

    property DataField: string
      read GetDataField
      write SetDataField;

    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;

    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;

    { Inherited Properties and Events }
    property Style;                           { Must be published before Items }
    property Align;
    property AllowEdit;
    property Anchors;
    property AutoComplete;
    {$IFDEF VCL60_OR_HIGHER}
    property AutoDropDown;
    {$ENDIF}
    property BeepOnInvalidKey;
    property BiDiMode;
    {$IFDEF VCL60_OR_HIGHER}
    property CharCase;
    {$ENDIF}
    property Color;
    property Constraints;
    property Ctl3D;
    property DisabledColor;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property FlatButtonColor;
    property FlatButtons;
    property Font;
    property FocusColor;
    property FrameColor;
    property FrameControllerNotifications;
    property FrameController;
    property FrameHotColor;
    property FrameHotTrack;
    property FrameHotStyle;
    property FrameSides;
    property FrameStyle;
    property FrameVisible;
    property FramingPreference;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property KeepSearchCase;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnlyColor;
    property ReadOnlyColorOnFocus;
    property ShowHint;
    property Sorted;
    property TabOnEnter;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMatch;
    property OnMeasureItem;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnNotInList;
    {$IFDEF VCL60_OR_HIGHER}
    property OnSelect;
    {$ENDIF}
    property OnStartDock;
    property OnStartDrag;

    property Items       { Must be published after OnMeasureItem }
      write SetItems;

    property Values: TStrings
      read FValues
      write SetValues;
  end;


  {===========================================}
  {== TRzDBLookupComboBox Class Declaration ==}
  {===========================================}

  TRzDBLookupComboBox = class( TDBLookupComboBox )
  private
    FAboutInfo: TRzAboutInfo;
    FAllowNull: Boolean;
    FAutoDropDown: Boolean;
    FTextAlignment: TAlignment;
    FButtonWidth: Integer;
    FCanvas: TCanvas;
    FFlatButtonColor: TColor;
    FFlatButtons: Boolean;
    FUpdatingColor: Boolean;
    FDisabledColor: TColor;
    FReadOnlyColor: TColor;
    FReadOnlyColorOnFocus: Boolean;
    FFocusColor: TColor;
    FNormalColor: TColor;
    FFrameColor: TColor;
    FFrameController: TRzFrameController;
    FFrameControllerNotifications: TRzFrameControllerNotifications;
    FFrameHotColor: TColor;
    FFrameHotTrack: Boolean;
    FFrameHotStyle: TFrameStyle;
    FFrameSides: TSides;
    FFrameStyle: TFrameStyle;
    FFrameVisible: Boolean;
    FFramingPreference: TFramingPreference;
    FTabOnEnter: Boolean;
    {$IFNDEF VCL100_OR_HIGHER}
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    {$ENDIF}

    procedure ReadOldFrameFlatProp( Reader: TReader );
    procedure ReadOldFrameFocusStyleProp( Reader: TReader );

    { Message Handling Methods }
    procedure CMColorChanged( var Msg: TMessage ); message cm_ColorChanged;
    procedure CMEnabledChanged( var Msg: TMessage ); message cm_EnabledChanged;
    procedure WMPaint( var Msg: TWMPaint ); message wm_Paint;
    procedure CMEnter( var Msg: TCMEnter ); message cm_Enter;
    procedure CMExit( var Msg: TCMExit ); message cm_Exit;
    procedure CMMouseEnter( var Msg: TMessage ); message cm_MouseEnter;
    procedure CMMouseLeave( var Msg: TMessage ); message cm_MouseLeave;
    procedure WMSize( var Msg: TWMSize ); message wm_Size;
  protected
    FInControl: Boolean;
    FOverControl: Boolean;

    procedure CreateParams( var Params: TCreateParams ); override;
    procedure DefineProperties( Filer: TFiler ); override;
    procedure Loaded; override;

    procedure Paint; override;
    procedure KeyValueChanged; override;

    procedure Notification( AComponent: TComponent; Operation: TOperation ); override;

    function GetClientRect: TRect; override;
    function GetBorderSize: Integer; override;
    procedure UpdateColors; virtual;
    procedure UpdateFrame( ViaMouse, InFocus: Boolean ); virtual;

    function SupportThemesInternally: Boolean;

    { Event Dispatch Methods }
    procedure KeyPress( var Key: Char ); override;
    procedure KeyDown( var Key: Word; Shift: TShiftState ); override;

    { Property Access Methods }
    procedure SetFlatButtonColor( Value: TColor ); virtual;
    procedure SetFlatButtons( Value: Boolean ); virtual;
    function StoreColor: Boolean;
    function StoreFocusColor: Boolean;
    function StoreDisabledColor: Boolean;
    function StoreReadOnlyColor: Boolean;
    function StoreReadOnlyColorOnFocus: Boolean;
    function StoreParentColor: Boolean;
    function StoreFlatButtonColor: Boolean;
    function StoreFlatButtons: Boolean;
    function StoreFrameColor: Boolean;
    function StoreFrameHotColor: Boolean;
    function StoreFrameHotTrack: Boolean;
    function StoreFrameHotStyle: Boolean;
    function StoreFrameSides: Boolean;
    function StoreFrameStyle: Boolean;
    function StoreFrameVisible: Boolean;
    function StoreFramingPreference: Boolean;
    procedure SetDisabledColor( Value: TColor ); virtual;
    procedure SetFocusColor( Value: TColor ); virtual;
    procedure SetFrameColor( Value: TColor ); virtual;
    procedure SetFrameController( Value: TRzFrameController ); virtual;
    procedure SetFrameHotColor( Value: TColor ); virtual;
    procedure SetFrameHotTrack( Value: Boolean ); virtual;
    procedure SetFrameHotStyle( Value: TFrameStyle ); virtual;
    procedure SetFrameSides( Value: TSides ); virtual;
    procedure SetFrameStyle( Value: TFrameStyle ); virtual;
    procedure SetFrameVisible( Value: Boolean ); virtual;
    procedure SetFramingPreference( Value: TFramingPreference ); virtual;
    function GetReadOnly: Boolean;
    procedure SetReadOnly( Value: Boolean );
    procedure SetReadOnlyColor( Value: TColor ); virtual;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;

    function UseThemes: Boolean; virtual;

    function GetListValue: string;
    function GetKeyValue: string;
    procedure InitKeyValue;
    procedure ClearKeyValue;
  published
    property About: TRzAboutInfo
      read FAboutInfo
      write FAboutInfo
      stored False;

    property AllowNull: Boolean
      read FAllowNull
      write FAllowNull
      default False;

    property AutoDropDown: Boolean
      read FAutoDropDown
      write FAutoDropDown
      default False;

    property Color
      stored StoreColor
      default clWindow;

    property FlatButtonColor: TColor
      read FFlatButtonColor
      write SetFlatButtonColor
      stored StoreFlatButtonColor
      default clBtnFace;

    property FlatButtons: Boolean
      read FFlatButtons
      write SetFlatButtons
      stored StoreFlatButtons
      default False;

    property DisabledColor: TColor
      read FDisabledColor
      write SetDisabledColor
      stored StoreDisabledColor
      default clBtnFace;

    property FocusColor: TColor
      read FFocusColor
      write SetFocusColor
      stored StoreFocusColor
      default clWindow;

    property FrameColor: TColor
      read FFrameColor
      write SetFrameColor
      stored StoreFrameColor
      default clBtnShadow;

    property FrameControllerNotifications: TRzFrameControllerNotifications
      read FFrameControllerNotifications
      write FFrameControllerNotifications
      default fccAll;

    property FrameController: TRzFrameController
      read FFrameController
      write SetFrameController;

    property FrameHotColor: TColor
      read FFrameHotColor
      write SetFrameHotColor
      stored StoreFrameHotColor
      default clBtnShadow;

    property FrameHotStyle: TFrameStyle
      read FFrameHotStyle
      write SetFrameHotStyle
      stored StoreFrameHotStyle
      default fsFlatBold;

    property FrameHotTrack: Boolean
      read FFrameHotTrack
      write SetFrameHotTrack
      stored StoreFrameHotTrack
      default False;

    property FrameSides: TSides
      read FFrameSides
      write SetFrameSides
      stored StoreFrameSides
      default sdAllSides;

    property FrameStyle: TFrameStyle
      read FFrameStyle
      write SetFrameStyle
      stored StoreFrameStyle
      default fsFlat;

    property FrameVisible: Boolean
      read FFrameVisible
      write SetFrameVisible
      stored StoreFrameVisible
      default False;

    property FramingPreference: TFramingPreference
      read FFramingPreference
      write SetFramingPreference
      stored StoreFramingPreference
      default fpXPThemes;

    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;

    property ReadOnlyColor: TColor
      read FReadOnlyColor
      write SetReadOnlyColor
      stored StoreReadOnlyColor
      default clInfoBk;

    property ReadOnlyColorOnFocus: Boolean
      read FReadOnlyColorOnFocus
      write FReadOnlyColorOnFocus
      stored StoreReadOnlyColorOnFocus
      default False;

    property TabOnEnter: Boolean
      read FTabOnEnter
      write FTabOnEnter
      default False;

    {$IFNDEF VCL100_OR_HIGHER}
    property OnMouseEnter: TNotifyEvent
      read FOnMouseEnter
      write FOnMouseEnter;

    property OnMouseLeave: TNotifyEvent
      read FOnMouseLeave
      write FOnMouseLeave;
    {$ENDIF}

    { Inherited Properties & Events }
    property Align;
  end;



implementation

uses
  {$IFDEF VCL70_OR_HIGHER}
  Themes,
  UxTheme,
  {$ELSE}
  RzThemeSrv,
  RzUxTheme,
  RzTmSchema,
  {$ENDIF}
  TypInfo;

  
{==============================}
{== TRzPaintComboBox Methods ==}
{==============================}


constructor TRzPaintComboBox.Create( AOwner: TComponent );
begin
  inherited;
  FComboBox := TRzDBComboBox( AOwner );
  Alignment := taLeftJustify;
  BevelOuter := bvNone;
end;

procedure TRzPaintComboBox.Paint;
var
  EditRect, BtnRect: TRect;
  X, Y, LeftOffset, TopOffset: Integer;
  FrameColor: TColor;
  FrameSides: TSides;
  FrameStyle: TFrameStyle;
  FrameVisible: Boolean;
  UseThemes: Boolean;
begin
  inherited;
  EditRect := ClientRect;
  Canvas.Brush.Color := FComboBox.Color;
  Canvas.FillRect( EditRect );

  FrameColor := FComboBox.FrameColor;
  FrameSides := FComboBox.FrameSides;
  FrameStyle := FComboBox.FrameStyle;
  FrameVisible := FComboBox.FrameVisible;
  UseThemes := FComboBox.UseThemes;

  InflateRect( EditRect, -2, -2 );
  Dec( EditRect.Right, GetSystemMetrics( sm_CxVScroll ) );

  BtnRect := Rect( Width - GetSystemMetrics( sm_CxVScroll ) - 2, 2, Width - 2, Height - 2 );

  Canvas.Brush.Color := FComboBox.Color;
  Canvas.FillRect( BtnRect );
  Canvas.Pen.Color := FComboBox.Color;
  Canvas.Brush.Color := clBlack;
  X := BtnRect.Left + GetSystemMetrics( sm_CxVScroll ) div 2;
  Y := BtnRect.Top + Height div 2;
  Canvas.Polygon( [ Point( X, Y ), Point( X - 5, Y - 5 ), Point( X + 5, Y - 5 ) ] );
  Canvas.Brush.Color := FComboBox.Color;

  if FrameVisible and not UseThemes then
  begin
    if Color = clWindow then
    begin
      if FrameStyle = fsFlat then
        DrawSides( Canvas, ClientRect, FrameColor, FrameColor, FrameSides )
      else if FrameStyle = fsFlatBold then
        DrawBevel( Canvas, ClientRect, FrameColor, FrameColor, 2, FrameSides )
      else
        DrawBorderSides( Canvas, ClientRect, FrameStyle, FrameSides );
    end
    else
    begin
      if FrameStyle = fsFlat then
        DrawSides( Canvas, ClientRect, FrameColor, FrameColor, FrameSides )
      else if FrameStyle = fsFlatBold then
        DrawBevel( Canvas, ClientRect, FrameColor, FrameColor, 2, FrameSides )
      else
        DrawColorBorderSides( Canvas, ClientRect, FComboBox.Color, FrameStyle, FrameSides );
    end;


    if FComboBox.FlatButtons then
      DrawBevel( Canvas, BtnRect, FComboBox.Color, FComboBox.Color, 2, sdAllSides );
  end
  else
    DrawCtl3DBorder( Canvas, ClientRect, True );

  { Draw Text }
  if FComboBox.Style = csDropDown then
  begin
    LeftOffset := 3;
    TopOffset := ( Height - Canvas.TextHeight( 'Yy' ) ) div 2 - 1;
  end
  else
  begin
    LeftOffset := 4;
    TopOffset := ( Height - Canvas.TextHeight( 'Yy' ) ) div 2;
  end;
  Canvas.TextRect( EditRect, LeftOffset, TopOffset, Caption );
end; {= TRzPaintComboBox.Paint; =}


{&RT}
{===========================}
{== TRzDBComboBox Methods ==}
{===========================}

constructor TRzDBComboBox.Create( AOwner: TComponent );
begin
  inherited;
  ControlStyle := ControlStyle + [ csReplicatable, csSetCaption ];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;

  FPaintControl := TRzPaintComboBox.Create( Self );
  FPaintControl.Parent := Self;
  FPaintControl.Visible := False;

  FValues := TStringList.Create;
  TStringList( FValues ).OnChange := ValuesChangedHandler;
  {&RCI}
end;


destructor TRzDBComboBox.Destroy;
begin
  FPaintControl.Free;
  FPaintControl := nil;  
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited;
end;


procedure TRzDBComboBox.Loaded;
begin
  inherited;
  if ( csDesigning in ComponentState ) then
    DataChange( Self );
end;


procedure TRzDBComboBox.Notification( AComponent: TComponent; Operation: TOperation );
begin
  inherited;
  if ( Operation = opRemove ) and ( FDataLink <> nil ) and ( AComponent = DataSource ) then
    DataSource := nil;
end;


procedure TRzDBComboBox.CreateWnd;
begin
  inherited;
  {&RV}
  SetEditReadOnly;
end;


procedure TRzDBComboBox.ClearItemsValues;
begin
  Items.Clear;
  Values.Clear;
end;


procedure TRzDBComboBox.AddItemValue( const Item, Value: string );
begin
  Items.Add( Item );
  Values.Add( Value );
end;


procedure TRzDBComboBox.InsertItemValue( Index: Integer; const Item, Value: string );
begin
  Items.Insert( Index, Item );
  Values.Insert( Index, Value );
end;


procedure TRzDBComboBox.DataChange( Sender: TObject );
begin
  if not ( Style = csSimple ) and DroppedDown then
    Exit;

  if FDataLink.Field <> nil then
  begin
    FInDataChange := True;
    try
      Value := FDataLink.Field.Text;
      if ItemIndex = -1 then
        SetComboText( FDataLink.Field.Text );
    finally
      FInDataChange := False;
    end;
  end
  else
  begin
    if csDesigning in ComponentState then
      SetComboText( Name )
    else
    begin
      SetComboText( '' );
      Value := '';
    end;
  end;
end;


procedure TRzDBComboBox.UpdateData( Sender: TObject );
begin
  if FDataLink.Field <> nil then
    FDataLink.Field.Text := Value;
end;


procedure TRzDBComboBox.ValuesChangedHandler( Sender: TObject );
begin
  FForceSetValue := True;
  try
    DataChange( Self );
  finally
    FForceSetValue := False;
  end;
end;


procedure TRzDBComboBox.SetComboText( const Value: string );
var
  I: Integer;
  Redraw: Boolean;
begin
  if Value <> GetComboText then
  begin
    if Style <> csDropDown then
    begin
      Redraw := ( Style <> csSimple ) and HandleAllocated;
      if Redraw then
        SendMessage( Handle, wm_SetRedraw, 0, 0 );
      try
        if Value = '' then
          I := -1
        else
          I := Items.IndexOf( Value );
        ItemIndex := I;
      finally
        if Redraw then
        begin
          SendMessage( Handle, wm_SetRedraw, 1, 0 );
          Invalidate;
        end;
      end;

      if I >= 0 then
        Exit;
    end;
    if Style in [ csDropDown, csSimple ] then
      Text := Value;
  end;
end;


function TRzDBComboBox.GetComboText: string;
var
  I: Integer;
begin
  if Style in [ csDropDown, csSimple ] then
    Result := Text
  else
  begin
    I := ItemIndex;
    if I < 0 then
      Result := ''
    else
      Result := Items[ I ];
  end;
end;


function TRzDBComboBox.GetItemValue( Index: Integer ): string;
begin
  if ( Index < FValues.Count ) and ( FValues[ Index ] <> '' ) then
    Result := FValues[ Index ]
  else if Index < Items.Count then
    Result := Items[ Index ]
  else
    Result := '';
end;


function TRzDBComboBox.GetValue: string;
var
  I: Integer;
  S: string;
begin
  if Style in [ csDropDown, csSimple ] then
  begin
    S := Text;
    if S = '' then
      I := -1
    else
      I := Items.IndexOf( S );
  end
  else
    I := ItemIndex;

  if ( I < 0 ) or ( I > ( Values.Count - 1 ) ) then
    Result := Text
  else
    Result := Values[ I ];
end;


procedure TRzDBComboBox.SetValue( const Value: string );
var
  I, Index: Integer;
begin
  if ( FValue <> Value ) or FForceSetValue then
  begin
    FInSetValue := True;
    try
      Index := -1;
      for I := 0 to Items.Count - 1 do
      begin
        if Value = GetItemValue( I ) then
        begin
          Index := I;
          Break;
        end;
      end;
      ItemIndex := Index;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    if not FInDataChange and FDataLink.Editing then
      FDataLink.Modified;
  end;
end;


procedure TRzDBComboBox.Change;
begin
  if not FInSetValue and not FForceSetValue then
  begin
    inherited;
    if ItemIndex >= 0 then
      Value := GetItemValue( ItemIndex );
    if FDataLink.Editing then
      FDataLink.Modified;
  end;

end;


procedure TRzDBComboBox.Click;
begin
  if not FInSetValue then
  begin
    inherited;
    if ItemIndex >= 0 then
      Value := GetItemValue( ItemIndex );
    if FDataLink.Editing then
      FDataLink.Modified;
  end;
end;


function TRzDBComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;


procedure TRzDBComboBox.SetDataSource( Value: TDataSource );
begin
  if not ( FDataLink.DataSourceFixed and ( csLoading in ComponentState ) ) then
  begin
    FDataLink.DataSource := Value;
    if Value <> nil then
      Value.FreeNotification( Self );
  end;
end;


function TRzDBComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;


procedure TRzDBComboBox.SetDataField( const Value: string );
begin
  FDataLink.FieldName := Value;
end;


function TRzDBComboBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;


procedure TRzDBComboBox.SetReadOnly( Value: Boolean );
begin
  inherited;
  FDataLink.ReadOnly := Value;
end;


function TRzDBComboBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;


procedure TRzDBComboBox.KeyDown( var Key: Word; Shift: TShiftState );
begin
  inherited;
  if Key in [ vk_Back, vk_Delete, vk_Escape, vk_Up, vk_Down, 32..255 ] then
  begin
    if not ( ssAlt in Shift ) then
    begin
      // If the Alt key is pressed, then an accelerator character is being
      // invoked.  In this case, it is not necessary to put the dataset into
      // edit mode.
      if not FDataLink.Edit and ( Key in [ vk_Up, vk_Down ] ) then
        Key := 0;
    end;

    if not ( Style in [ csDropDown, csSimple ] ) then
    begin
      // If Style in csDropDownList or one of the owner draw styles
      case Key of
        vk_Delete:
        begin
          Text := ''; // Clear out field
          Key := 0;
        end;

        vk_Escape:
        begin
          FDataLink.Reset;
          SelectAll;
        end;
      end;
    end;
  end;
end;


procedure TRzDBComboBox.KeyPress( var Key: Char );
begin
  inherited;

  if FValues.Count = 0 then
  begin
    if ( Key in [ #32..#255 ] ) and ( FDataLink.Field <> nil ) and
       not FDataLink.Field.IsValidChar( Key ) then
    begin
      InvalidKeyPressed;
      Key := #0;
    end;
  end;

  case Key of
    ^H, ^V, ^X, #32..#255:
    begin
      FDataLink.Edit;
    end;

    #27:
    begin
      if DroppedDown then
        DroppedDown := False
      else
      begin
        FDataLink.Reset;
        SelectAll;
      end;
    end;
  end;
end;


procedure TRzDBComboBox.EditingChange( Sender: TObject );
begin
  SetEditReadOnly;
end;


procedure TRzDBComboBox.SetEditReadOnly;
var
  H: HWnd;
begin
  H := EditHandle;
  if ( Style in [ csDropDown, csSimple ] ) and HandleAllocated then
    SendMessage( H, em_SetReadOnly, Ord( not FDataLink.Editing ), 0 );
end;


procedure TRzDBComboBox.WndProc( var Msg: TMessage );
begin
  if not ( csDesigning in ComponentState ) then
  begin
    case Msg.Msg of
      wm_Command:
      begin
        if TWMCommand( Msg ).NotifyCode = cbn_SelChange then
        begin
          if not FDataLink.Edit then
          begin
            if Style <> csSimple then
              PostMessage( Handle, cb_ShowDropDown, 0, 0 );
            Exit;
          end;
        end;
      end;

      cb_ShowDropDown:
      begin
        if Msg.WParam <> 0 then
          FDataLink.Edit
        else
          if not FDataLink.Editing then
            DataChange( Self ); {Restore text}
      end;

      wm_Create, wm_WindowPosChanged, cm_FontChanged:
        if FPaintControl <> nil then
          FPaintControl.DestroyHandle;

      wm_Char:
      begin
        // Style is csDropDownList:
        // If the user presses the Escape key and the dropdown list is not
        // down, then we need to block the message from getting handled by
        // the non-data-aware version, which will set the ItemIndex to 0 when
        // the Escape key is pressed.  For data-aware version, we need to only
        // reset the datalink, which is handled in the KeyDown method.
        //
        // 4.2.1 Note - The TRzComboBox no longer sets the ItemIndex to 0 in
        // this situation, but we'll keep the code below because it is still
        // valid.
        if ( TWMKey( Msg ).CharCode = vk_Escape ) and not DroppedDown then
          Exit;
      end;
    end;
  end;
  inherited;
end;


{= ComboWndProc has keyboard actions when Style is csSimple or csDropDown =}

procedure TRzDBComboBox.ComboWndProc( var Msg: TMessage; ComboWnd: HWnd; ComboProc: Pointer );
var
  H: HWnd;
begin
  H := EditHandle;

  case Msg.Msg of
    wm_Char:
    begin
      case Msg.WParam of
        vk_Escape:
        begin
          DoKeyPress( TWMKey( Msg ) );
          Exit;
        end;
      end;
    end; { wm_Char }
  end;

  if not ( csDesigning in ComponentState ) then
  begin
    case Msg.Msg of
      wm_LButtonDown:
        if ( Style = csSimple ) and ( ComboWnd <> H ) then
          if not FDataLink.Edit then
            Exit;
    end;
  end;
  inherited;
end;


{= wm_Char is generated only when ComboBox has csDropDownList style =}

procedure TRzDBComboBox.WMChar( var Msg: TWMChar );
begin
  if Msg.CharCode <> vk_Escape then
    inherited;
end;


procedure TRzDBComboBox.CMEnter( var Msg: TCMEnter );
begin
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    SendMessage( EditHandle, em_SetReadOnly, Ord( False ), 0 );
end;


procedure TRzDBComboBox.CMExit( var Msg: TCMExit );
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;


procedure TRzDBComboBox.WMPaint( var Msg: TWMPaint );
var
  S: string;
begin
  if csPaintCopy in ControlState then
  begin
    if Field <> nil then
      S := Field.Text
    else
      S := '';

    FPaintControl.SetBounds( BoundsRect.Left, BoundsRect.Top,
                             BoundsRect.Right - BoundsRect.Left,
                             BoundsRect.Bottom - BoundsRect.Top );
    if Field <> nil then
      FPaintControl.Alignment := Field.Alignment;

    SendMessage( FPaintControl.Handle, wm_SetText, 0, Longint( PChar( S ) ) );
    SendMessage( FPaintControl.Handle, wm_Paint, WParam( Msg.DC ), 0 );
  end
  else
  begin
    FPaintControl.SetBounds( 0, 0, 0, 0 );
    inherited;
  end;
end;


procedure TRzDBComboBox.SetItems( const Value: TStrings );
begin
  Items.Assign( Value );
  DataChange( Self );
end;


procedure TRzDBComboBox.SetValues( Value: TStrings );
begin
  FValues.Assign( Value );
  DataChange( Self );
end;


procedure TRzDBCombobox.SetStyle( Value: TComboboxStyle );
begin
  if ( Value = csSimple ) and Assigned( FDatalink ) and FDatalink.DatasourceFixed then
  begin
    DatabaseError( SNotReplicatable );
  end;
  inherited;
end;


procedure TRzDBCombobox.CMGetDatalink( var Msg: TMessage );
begin
  Msg.Result := Integer( FDataLink );
end;


function TRzDBComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment( Self, Field );
end;


function TRzDBComboBox.ExecuteAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited ExecuteAction( Action ) or ( FDataLink <> nil ) and FDataLink.ExecuteAction( Action );
end;

function TRzDBComboBox.UpdateAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited UpdateAction( Action ) or ( FDataLink <> nil ) and FDataLink.UpdateAction( Action );
end;


function TRzDBComboBox.DoMouseWheelDown( Shift: TShiftState; MousePos: TPoint ): Boolean;
begin
  if not DroppedDown then
  begin
    if FDataLink.Edit then
      Result := inherited DoMouseWheelDown( Shift, MousePos )
    else
      Result := False;
  end
  else
    Result := inherited DoMouseWheelDown( Shift, MousePos );
end;


function TRzDBComboBox.DoMouseWheelUp( Shift: TShiftState; MousePos: TPoint ): Boolean;
begin
  if not DroppedDown then
  begin
    if FDataLink.Edit then
      Result := inherited DoMouseWheelUp( Shift, MousePos )
    else
      Result := False;
  end
  else
    Result := inherited DoMouseWheelUp( Shift, MousePos );
end;


{=================================}
{== TRzDBLookupComboBox Methods ==}
{=================================}

constructor TRzDBLookupComboBox.Create( AOwner: TComponent );
begin
  inherited;

  FCanvas := TControlCanvas.Create;
  TControlCanvas( FCanvas ).Control := Self;

  FAutoDropDown := False;
  FAllowNull := False;
  FButtonWidth := GetSystemMetrics( sm_CxVScroll );

  FFlatButtonColor := clBtnFace;
  FFlatButtons := False;
  FDisabledColor := clBtnFace;
  FReadOnlyColor := clInfoBk;
  FFocusColor := clWindow;
  FNormalColor := clWindow;
  FFrameColor := clBtnShadow;
  FFrameController := nil;
  FFrameControllerNotifications := fccAll;
  FFrameHotColor := clBtnShadow;
  FFrameHotTrack := False;
  FFrameHotStyle := fsFlatBold;
  FFrameSides := sdAllSides;
  FFrameStyle := fsFlat;
  FFrameVisible := False;
  FFramingPreference := fpXPThemes;
  FTabOnEnter := False;
  {&RCI}
end;


destructor TRzDBLookupComboBox.Destroy;
begin
  if FFrameController <> nil then
    FFrameController.RemoveControl( Self );
  FCanvas.Free;
  inherited;
end;


procedure TRzDBLookupComboBox.CreateParams( var Params: TCreateParams );
var
  MinHeight: Integer;
begin
  inherited;

  if ( FFrameVisible and not UseThemes ) or SupportThemesInternally then
  begin
    if Ctl3D then
      Params.ExStyle := Params.ExStyle and not WS_EX_CLIENTEDGE
    else
      Params.Style := Params.Style and not WS_BORDER;

    MinHeight := GetMinFontHeight( Font ) + 6;
    if Params.Height < MinHeight then
      Params.Height := MinHeight;
  end;
  {&RV}
end;


procedure TRzDBLookupComboBox.DefineProperties( Filer: TFiler );
begin
  inherited;
  // Handle the fact that the FrameFlat and FrameFocusStyle properties were renamed to
  // FrameHotStyle and FrameHotStyle respectively in version 3.
  Filer.DefineProperty( 'FrameFlat', ReadOldFrameFlatProp, nil, False );
  Filer.DefineProperty( 'FrameFocusStyle', ReadOldFrameFocusStyleProp, nil, False );

  // Handle the fact that the FrameFlatStyle was published in version 2.x
  Filer.DefineProperty( 'FrameFlatStyle', TRzOldPropReader.ReadOldEnumProp, nil, False );
end;


procedure TRzDBLookupComboBox.ReadOldFrameFlatProp( Reader: TReader );
begin
  FFrameHotTrack := Reader.ReadBoolean;
  if FFrameHotTrack then
  begin
    // If the FrameFlat property is stored, then init the FrameHotStyle property and the FrameStyle property.
    // These may be overridden when the rest of the stream is read in. However, we need to re-init them here
    // because the default values of fsStatus and fsLowered have changed in RC3.
    FFrameStyle := fsStatus;
    FFrameHotStyle := fsLowered;
  end;
end;


procedure TRzDBLookupComboBox.ReadOldFrameFocusStyleProp( Reader: TReader );
begin
  FFrameHotStyle := TFrameStyle( GetEnumValue( TypeInfo( TFrameStyle ), Reader.ReadIdent ) );
end;


procedure TRzDBLookupComboBox.Loaded;
begin
  inherited;
  UpdateColors;
  UpdateFrame( False, False );
end;


procedure TRzDBLookupComboBox.Notification( AComponent: TComponent; Operation: TOperation );
begin
  inherited;
  if ( Operation = opRemove ) and ( AComponent = FFrameController ) then
    FFrameController := nil;
end;


procedure TRzDBLookupComboBox.KeyPress( var Key: Char );
begin
  if FTabOnEnter and ( Ord( Key ) = vk_Return ) and not ListVisible then
  begin
    Key := #0;
    PostMessage( Handle, wm_KeyDown, vk_Tab, 0 );
  end
  else
  begin
    inherited;

    // Implement AutoDropDown functionality
    case Ord( Key ) of
      vk_Escape, vk_Back:
        ;
      vk_Tab:
        if FAutoDropDown and ListVisible then
          CloseUp( False );
      else
        if FAutoDropDown and not ListVisible then
          DropDown;
    end;
  end;
end;


procedure TRzDBLookupComboBox.KeyDown( var Key: Word; Shift: TShiftState );
var
  DataLink: TDataLink;
begin
  inherited;
  if FAllowNull and ( Key = vk_Delete ) then
  begin
    if DataSource <> nil then
    begin
      { Since we don't have direct access to datalink in ancestor control,
        send the cm_GetDataLink message to get a reference to it. }
      DataLink := TDataLink( Perform( cm_GetDataLink, 0, 0 ) );
      if ( DataLink <> nil ) and ( DataLink.Edit ) then
        Field.Clear;
    end
    else
      ClearKeyValue;
  end;
end;


procedure TRzDBLookupComboBox.KeyValueChanged;
begin
  inherited;

  { Need to override this method because TDBLookupComboBox does not
    provide access to the FAlignment variable.  Therefore, we have
    to record changes to the alignment ourselves. }

  if ( KeyField = '' ) and ( Field <> nil ) then   // Same as  if FLookupMode then
    FTextAlignment := Field.Alignment
  else if ListActive and LocateKey then
    FTextAlignment := TField( ListFields[ ListFieldIndex ] ).Alignment
  else
    FTextAlignment := taLeftJustify;
end;


procedure TRzDBLookupComboBox.Paint;
var
  W, X, TextOffset: Integer;
  S: string;
  AAlignment: TAlignment;
  Selected: Boolean;
  R: TRect;
begin
  // This method does essentially the same thing as the inherited Paint method
  // does except that it changes the X offset value from 2 to 3. However,
  // additional changes are needed because of private fields in the
  // ancestor class.

  if ( FFrameVisible and not UseThemes ) or SupportThemesInternally then
  begin
    Canvas.Font := Font;
    Canvas.Brush.Color := Color;
    if Enabled then
      Canvas.Font.Color := Font.Color
    else
      Canvas.Font.Color := clBtnShadow;
    Selected := HasFocus and not ListVisible and not ( csPaintCopy in ControlState );
    if Selected then
    begin
      Canvas.Font.Color := clHighlightText;
      Canvas.Brush.Color := clHighlight;
    end;
    if ( csPaintCopy in ControlState ) and ( Field <> nil ) and ( Field.Lookup ) then
    begin
      S := Field.DisplayText;
      AAlignment := Field.Alignment;
    end else
    begin
      if ( csDesigning in ComponentState ) and ( Field = nil ) then
        S := Name
      else
        S := Text;
      AAlignment := FTextAlignment;  { Use our FTextAlignment instead of FAlignment }
    end;
    // Alignment does NOT depend on data field, it depends on the list field
    if ListActive and DBUseRightToLeftAlignment( Self, TField( ListFields[ ListFieldIndex ] ) ) then
      ChangeBiDiModeAlignment( AAlignment );
    W := ClientWidth - FButtonWidth;

    X := 3;    { Changed this line from 2 to 3 }

    case AAlignment of
      taRightJustify:
        X := W - Canvas.TextWidth( S ) - 3;

      taCenter:
        X := ( W - Canvas.TextWidth( S ) ) div 2;
    end;
    SetRect( R, 1, 1, W - 1, ClientHeight - 1 );
    // Button placement does NOT depend or data/list field, it only depends on BiDiMode
    if ( SysLocale.MiddleEast ) and ( BiDiMode = bdRightToLeft ) then
    begin
      Inc( X, FButtonWidth );
      Inc( R.Left, FButtonWidth );
      R.Right := ClientWidth;
    end;
    if SysLocale.MiddleEast then
      TControlCanvas( Canvas ).UpdateTextFlags;

    TextOffset := ( ( R.Bottom - R.Top ) - Canvas.TextHeight( 'Yy' ) ) div 2;
    Canvas.TextRect( R, X, R.Top + TextOffset, S );

    Inc( R.Top, 2 );
    Inc( R.Left, 2 );
    if Selected then
      Canvas.DrawFocusRect( R );
  end
  else
    inherited;
end; {= TRzDBLookupComboBox.Paint =}


procedure TRzDBLookupComboBox.SetFlatButtonColor( Value: TColor );
begin
  if FFlatButtonColor <> Value then
  begin
    FFlatButtonColor := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFlatButtons( Value: Boolean );
begin
  if FFlatButtons <> Value then
  begin
    FFlatButtons := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.CMColorChanged( var Msg: TMessage );
begin
  inherited;
  if not FUpdatingColor then
  begin
    if FFocusColor = FNormalColor then
      FFocusColor := Color;
    FNormalColor := Color;
  end;
end;


function TRzDBLookupComboBox.StoreColor: Boolean;
begin
  Result := ( ( FFrameController = nil ) or
              ( ( FFrameController <> nil ) and
                not ( fcpColor in FFrameControllerNotifications ) ) )
            and
            Enabled;
end;


function TRzDBLookupComboBox.StoreFocusColor: Boolean;
begin
  Result := ( ( FFrameController = nil ) or
              ( ( FFrameController <> nil ) and
                not ( fcpFocusColor in FFrameControllerNotifications ) ) )
            and
            ( ColorToRGB( FFocusColor ) <> ColorToRGB( Color ) );
end;


function TRzDBLookupComboBox.StoreDisabledColor: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpDisabledColor in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreReadOnlyColor: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpReadOnlyColor in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreReadOnlyColorOnFocus: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpReadOnlyColorOnFocus in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreParentColor: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpParentColor in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFlatButtonColor: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFlatButtonColor in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFlatButtons: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFlatButtons in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameColor: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameColor in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameHotColor: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameHotColor in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameHotTrack: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameHotTrack in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameHotStyle: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameHotStyle in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameSides: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameSides in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameStyle: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameStyle in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFrameVisible: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFrameVisible in FFrameControllerNotifications ) );
end;


function TRzDBLookupComboBox.StoreFramingPreference: Boolean;
begin
  Result := ( FFrameController = nil ) or
            ( ( FFrameController <> nil ) and
              not ( fcpFramingPreference in FFrameControllerNotifications ) );
end;


procedure TRzDBLookupComboBox.SetDisabledColor( Value: TColor );
begin
  FDisabledColor := Value;
  if not Enabled then
    UpdateColors;
end;


procedure TRzDBLookupComboBox.SetFocusColor( Value: TColor );
begin
  FFocusColor := Value;
  if Focused then
    UpdateColors;
end;


procedure TRzDBLookupComboBox.SetFrameColor( Value: TColor );
begin
  if FFrameColor <> Value then
  begin
    FFrameColor := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFrameController( Value: TRzFrameController );
begin
  if FFrameController <> nil then
    FFrameController.RemoveControl( Self );
  FFrameController := Value;
  if Value <> nil then
  begin
    Value.AddControl( Self );
    Value.FreeNotification( Self );
  end;
end;


procedure TRzDBLookupComboBox.SetFrameHotColor( Value: TColor );
begin
  if FFrameHotColor <> Value then
  begin
    FFrameHotColor := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFrameHotTrack( Value: Boolean );
begin
  if FFrameHotTrack <> Value then
  begin
    FFrameHotTrack := Value;
    if FFrameHotTrack then
    begin
      FrameVisible := True;
      if not ( csLoading in ComponentState ) then
        FFrameSides := sdAllSides;
    end;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFrameHotStyle( Value: TFrameStyle );
begin
  if FFrameHotStyle <> Value then
  begin
    FFrameHotStyle := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFrameSides( Value: TSides );
begin
  if FFrameSides <> Value then
  begin
    FFrameSides := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFrameStyle( Value: TFrameStyle );
begin
  if FFrameStyle <> Value then
  begin
    FFrameStyle := Value;
    Invalidate;
  end;
end;


procedure TRzDBLookupComboBox.SetFrameVisible( Value: Boolean );
begin
  if FFrameVisible <> Value then
  begin
    FFrameVisible := Value;
    ParentCtl3D := not FFrameVisible or UseThemes;
    Ctl3D := not FFrameVisible or UseThemes;
    { Must recreate window so window style can be changed }
    RecreateWnd;
  end;
end;


procedure TRzDBLookupComboBox.SetFramingPreference( Value: TFramingPreference );
begin
  if FFramingPreference <> Value then
  begin
    FFramingPreference := Value;
    if FFramingPreference = fpCustomFraming then
      RecreateWnd;
  end;
end;


function TRzDBLookupComboBox.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;


procedure TRzDBLookupComboBox.SetReadOnly( Value: Boolean );
begin
  if ReadOnly <> Value then
  begin
    inherited ReadOnly := Value;
    UpdateColors;
  end;
end;


procedure TRzDBLookupComboBox.SetReadOnlyColor( Value: TColor );
begin
  FReadOnlyColor := Value;
  if ReadOnly then
    UpdateColors;
end;


function TRzDBLookupComboBox.SupportThemesInternally: Boolean;
begin
  {$IFDEF VCL70_OR_HIGHER}
  Result := False;
  {$ELSE}
  Result := ThemeServices.ThemesEnabled;
  {$ENDIF}
end;


function TRzDBLookupComboBox.UseThemes: Boolean;
begin
  Result := ( FFramingPreference = fpXPThemes ) and ThemeServices.ThemesEnabled;
end;


function TRzDBLookupComboBox.GetBorderSize: Integer;
begin
  if ( FFrameVisible and not UseThemes ) or SupportThemesInternally then
    Result := 4
  else
    Result := inherited GetBorderSize;
end;


function TRzDBLookupComboBox.GetClientRect: TRect;
begin
  Result := inherited GetClientRect;
  // Shrink the client rect so the combo box appears in the same position that it would if the control had a border
  if ( FFrameVisible and not UseThemes ) or SupportThemesInternally then
    InflateRect( Result, -2, -2 );
end;


procedure TRzDBLookupComboBox.CMEnabledChanged( var Msg: TMessage );
begin
  inherited;
  UpdateColors;
end;


procedure TRzDBLookupComboBox.WMPaint( var Msg: TWMPaint );
var
  R, BtnRect, TempRect, InsideRect: TRect;
  C: TColor;
  Offset: Integer;
  ElementDetails: TThemedElementDetails;
  Flags: Cardinal;
begin
  inherited;

  // If control is being replicated then use Msg.DC to draw on
  if ( csPaintCopy in ControlState ) and ( Msg.DC <> 0 ) then
    FCanvas.Handle := Msg.DC;

  try
    if FFrameVisible and not UseThemes then
    begin
      R := ClientRect;
      InflateRect( R, 2, 2 );                              // Account for GetClientRect shrinking

      DrawBevel( FCanvas, R, Color, Color, 3, sdAllSides );
    end
    else if SupportThemesInternally then
    begin
      R := ClientRect;
      InflateRect( R, 2, 2 );                              // Account for GetClientRect shrinking 

      C := GetXPThemeColor( xptcEditBorder );
      R := DrawSides( FCanvas, R, C, C, sdAllSides );
      DrawBox( FCanvas, R, Color );
    end;

    if SupportThemesInternally then
      Offset := 0
    else if UseThemes then
      Offset := 1
    else if FFrameVisible then
      Offset := 0
    else
      Offset := 2;
    if not (( SysLocale.MiddleEast ) and ( BiDiMode = bdRightToLeft )) then
      BtnRect := Rect( Width - GetSystemMetrics( sm_CxVScroll ) - 2 - Offset, 2 - Offset, Width - 2 - Offset, Height - 2 - Offset )
    else
      BtnRect := Rect( -2 + Offset, 2 - Offset, GetSystemMetrics( sm_CxVScroll ) + 2 - Offset, Height - 2 - Offset );
    if UseThemes and not SupportThemesInternally then
      Dec( BtnRect.Top, 2 );


    // Paint inside box of pixels that do not get painted by the
    // inherited control.
    InsideRect := ClientRect;
    if not (( SysLocale.MiddleEast ) and ( BiDiMode = bdRightToLeft )) then
      InsideRect.Right := BtnRect.Left
    else
      InsideRect.Left := BtnRect.Right;

    if ReadOnly then
    begin
      FCanvas.Brush.Color := Color;
      FCanvas.FillRect( BtnRect );
    end;
    DrawBox( FCanvas, InsideRect, Color );

    if not ReadOnly then
    begin
      if FFlatButtons then
      begin
        if not ( FInControl or FOverControl ) then
        begin
          // Erase Button Border
          FCanvas.Brush.Color := Color;
          FCanvas.FillRect( BtnRect );

          if ThemeServices.ThemesEnabled then
            DrawDropDownArrow( FCanvas, BtnRect, uiWindowsXP, False, Enabled and ListActive )
          else
            DrawDropDownArrow( FCanvas, BtnRect, uiWindows95, False, Enabled and ListActive );
        end
        else
        begin
          // Erase Button Border
          if ThemeServices.ThemesEnabled then
          begin
            if ListVisible then
              ElementDetails := ThemeServices.GetElementDetails( tcDropDownButtonPressed )
            else
              ElementDetails := ThemeServices.GetElementDetails( tcDropDownButtonHot );

            ThemeServices.DrawElement( FCanvas.Handle, ElementDetails, BtnRect );
          end
          else // No Themes
          begin
            FCanvas.Brush.Color := FFlatButtonColor;

            if FFlatButtonColor = clBtnFace then
            begin
              if ListVisible then
                TempRect := DrawBevel( FCanvas, BtnRect, clBtnShadow, clBtnHighlight, 1, sdAllSides )
              else
                TempRect := DrawBevel( FCanvas, BtnRect, clBtnHighlight, clBtnShadow, 1, sdAllSides );
            end
            else
            begin
              if ListVisible then
                TempRect := DrawColorBorder( FCanvas, BtnRect, FFlatButtonColor, fsStatus )
              else
                TempRect := DrawColorBorder( FCanvas, BtnRect, FFlatButtonColor, fsPopup );
            end;

            FCanvas.FillRect( TempRect );
            DrawDropDownArrow( FCanvas, TempRect, uiWindows95, ListVisible, Enabled and ListActive );
          end;
        end;
      end
      else // No FlatButtons
      begin
        if ThemeServices.ThemesEnabled then
        begin
          if not Enabled or not ListActive then
            ElementDetails := ThemeServices.GetElementDetails( tcDropDownButtonDisabled )
          else if ListVisible then
            ElementDetails := ThemeServices.GetElementDetails( tcDropDownButtonPressed )
          else if FInControl or FOverControl then
            ElementDetails := ThemeServices.GetElementDetails( tcDropDownButtonHot )
          else
            ElementDetails := ThemeServices.GetElementDetails( tcDropDownButtonNormal );

          ThemeServices.DrawElement( FCanvas.Handle, ElementDetails, BtnRect );
        end
        else
        begin
          if ListVisible then
            Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED
          else if ListActive and Enabled then
            Flags := DFCS_SCROLLCOMBOBOX
          else
            Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE;
          DrawFrameControl( FCanvas.Handle, BtnRect, DFC_SCROLL, Flags );
        end;
      end;
    end;

    if FFrameVisible and not UseThemes then
    begin
      if FFrameHotTrack and ( FInControl or FOverControl ) then
      begin
        if FFrameHotStyle = fsFlat then
          DrawSides( FCanvas, R, FFrameHotColor, FFrameHotColor, FFrameSides )
        else if FFrameHotStyle = fsFlatBold then
          DrawBevel( FCanvas, R, FFrameHotColor, FFrameHotColor, 2, FFrameSides )
        else if Color = clWindow then
          DrawBorderSides( FCanvas, R, FFrameHotStyle, FFrameSides )
        else
          DrawColorBorderSides( FCanvas, R, Color, FFrameHotStyle, FFrameSides );
      end
      else
      begin
        if FFrameStyle = fsFlat then
          DrawSides( FCanvas, R, FFrameColor, FFrameColor, FFrameSides )
        else if FFrameStyle = fsFlatBold then
          DrawBevel( FCanvas, R, FFrameColor, FFrameColor, 2, FFrameSides )
        else if Color = clWindow then
          DrawBorderSides( FCanvas, R, FFrameStyle, FFrameSides )
        else
          DrawColorBorderSides( FCanvas, R, Color, FFrameStyle, FFrameSides );
      end;
    end;
  finally
    if ( csPaintCopy in ControlState ) and ( Msg.DC <> 0 ) then
      FCanvas.Handle := 0;
  end;
end; {= TRzDBLookupComboBox.WMPaint =}


procedure TRzDBLookupComboBox.UpdateColors;
begin
  if csLoading in ComponentState then
    Exit;

  FUpdatingColor := True;
  try
    if not Enabled then
      Color := FDisabledColor
    else if Focused then
    begin
      if ReadOnly and FReadOnlyColorOnFocus then
        Color := FReadOnlyColor
      else
        Color := FFocusColor;
    end
    else if ReadOnly then
      Color := FReadOnlyColor
    else
      Color := FNormalColor;
  finally
    FUpdatingColor := False;
  end;
end;


procedure TRzDBLookupComboBox.UpdateFrame( ViaMouse, InFocus: Boolean );
var
  PaintIt: Boolean;
  R: TRect;
begin
  if ViaMouse then
    FOverControl := InFocus
  else
    FInControl := InFocus;

  PaintIt := FFlatButtons or FFrameHotTrack;

  if PaintIt then
  begin
    R := ClientRect;
    if not FFrameHotTrack then
      R.Left := R.Right - GetSystemMetrics( sm_CxVScroll ) - 2;
    RedrawWindow( Handle, @R, 0, rdw_Invalidate or rdw_NoErase );
  end;

  UpdateColors;
end;


procedure TRzDBLookupComboBox.CMEnter( var Msg: TCMEnter );
begin
  inherited;
  UpdateFrame( False, True );
end;


procedure TRzDBLookupComboBox.CMExit( var Msg: TCMExit );
begin
  inherited;
  UpdateFrame( False, False );
end;


procedure TRzDBLookupComboBox.CMMouseEnter( var Msg: TMessage );
begin
  {$IFDEF VCL70_OR_HIGHER}
  if csDesigning in ComponentState then
    Exit;
  {$ENDIF}

  inherited;
  {$IFNDEF VCL100_OR_HIGHER}
  // Manually generate OnMouseEnter event for Delphi 2005 and earlier
  if Assigned( FOnMouseEnter ) then
    FOnMouseEnter( Self );
  {$ENDIF}

  UpdateFrame( True, True );
end;


procedure TRzDBLookupComboBox.CMMouseLeave( var Msg: TMessage );
begin
  inherited;
  {$IFNDEF VCL100_OR_HIGHER}
  // Manually generate OnMouseLeave event for Delphi 2005 and earlier
  if Assigned( FOnMouseLeave ) then
    FOnMouseLeave( Self );
  {$ENDIF}

  UpdateFrame( True, False );
end;


procedure TRzDBLookupComboBox.WMSize( var Msg: TWMSize );
begin
  inherited;
  if ( FFrameVisible and not UseThemes ) or SupportThemesInternally then
    Invalidate;
end;


function TRzDBLookupComboBox.GetListValue: string;
begin
  // Get the value from the ListField field from a TDBLookupComboBox. This is the value displayed in the
  // drop-down box of the currently selected field

  Result := '';
  if Assigned( ListSource ) and Assigned( ListSource.DataSet ) and ListSource.DataSet.Active and ( ListField <> '' ) then
  begin
    Result := ListSource.DataSet.FieldByName( ListField ).AsString;
  end;
end;


function TRzDBLookupComboBox.GetKeyValue: string;
begin
  // Get the value from the KeyField field from a TDBLookupComboBox. This is the value displayed in the drop-down
  // box of the currently selected field

  Result := '';
  if Assigned( ListSource ) and Assigned( ListSource.DataSet ) and ListSource.DataSet.Active and ( KeyField <> '' ) then
  begin
    Result := ListSource.DataSet.FieldByName( KeyField ).AsString;
  end;
end;


procedure TRzDBLookupComboBox.InitKeyValue;
var
  TempKeyField: TField;
begin
  // When you use a TDBLookupComboBox with only the ListSource assigned (and no
  // DataSource assigned), then by default, a TDBLookupComboBox starts 'empty',
  // even though there is a value selected in the DataSet behind the ListSource.
  // This procedure forces a value in the 'edit' portion of the TDBLookupComboBox.

  if Assigned( ListSource ) and Assigned( ListSource.DataSet ) and ListSource.DataSet.Active then
  begin
    TempKeyField := ListSource.DataSet.FieldByName( KeyField );
    KeyValue := TempKeyField.Value;
  end;
end;


procedure TRzDBLookupComboBox.ClearKeyValue;
begin
  // When you use a TDBLookupComboBox with only the ListSource assigned (and no DataSource assigned), then by default,
  // a TDBLookupComboBox starts 'empty', even though there is a value selected in the DataSet behind the ListSource.
  // This procedure forces an EMPTY value in the 'edit' portion of the TDBLookupComboBox, so you can use it to undo
  // the work of InitKeyValue.

  if Assigned( ListSource ) and Assigned( ListSource.DataSet ) and ListSource.DataSet.Active then
  begin
    KeyValue := Null;
  end;
end;


{&RUIF}
end.
