{******************************************************************

                       JEDI-VCL Demo

 Copyright (C) 2002 Project JEDI

 Original author:

 Contributor(s):

 You may retrieve the latest version of this file at the JEDI-JVCL
 home page, located at http://jvcl.sourceforge.net

 The contents of this file are used with permission, subject to
 the Mozilla Public License Version 1.1 (the "License"); you may
 not use this file except in compliance with the License. You may
 obtain a copy of the License at
 http://www.mozilla.org/MPL/MPL-1_1Final.html

 Software distributed under the License is distributed on an
 "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 implied. See the License for the specific language governing
 rights and limitations under the License.

******************************************************************}

unit InspectorSimpleExampleMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs, JvBaseDlg, JvJVCLAboutForm,
  JvBackgrounds, JvExControls, JvInspector;

type
  TAControl = class(TComponent)
  private
    FLines: TStrings;
  protected
    procedure SetLines(Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
   published
    property Lines: TStrings read FLines write SetLines;
  end;
  TBControl = class(TAControl)
  published
    property Lines;
  end;
  TSimpleMainForm = class(TForm)
    JvInspector1: TJvInspector;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure JvInspector1AfterDataCreate(Sender: TObject;
      Data: TJvCustomInspectorData);
    procedure JvInspector1BeforeSelection(Sender: TObject;
      NewItem: TJvCustomInspectorItem; var Allow: Boolean);
  private
  public
  end;

var
  SimpleMainForm: TSimpleMainForm;

implementation

{$R *.dfm}

constructor TAControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLines := TStringList.Create;
end;

destructor TAControl.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

procedure TAControl.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;


procedure TSimpleMainForm.FormShow(Sender: TObject);
var
  BControl:TAControl;
begin
  JvInspector1.Clear;
  //JvInspector1.AddComponent(Self, 'A Form Inspecting Itself', False);
  JvInspector1.AddComponent(Memo1, 'TMemo', False);
  BControl:=TAControl.Create(nil);
  JvInspector1.AddComponent(BControl, 'BControl', False);
end;

procedure TSimpleMainForm.JvInspector1AfterDataCreate(Sender: TObject;
  Data: TJvCustomInspectorData);
begin
  //Memo1.Lines.Add( Data.Name );
end;

procedure TSimpleMainForm.JvInspector1BeforeSelection(Sender: TObject;
  NewItem: TJvCustomInspectorItem; var Allow: Boolean);
begin
  //  Allow:=False;
end;

end.

