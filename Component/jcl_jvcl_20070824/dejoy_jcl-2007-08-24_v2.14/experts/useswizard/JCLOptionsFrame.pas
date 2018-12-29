{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclOptionsFrame.pas.                                                        }
{                                                                                                  }
{ The Initial Developer of the Original Code is TOndrej (tondrej att t-online dott de).            }
{ Portions created by TOndrej are Copyright (C) of TOndrej.                                        }
{                                                                                                  }
{ Contributors:                                                                                    }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Unit owner: Robert Marquardt                                                                     }
{ Last modified: $Date: 2006-05-29 15:02:45 -0700 (Mon, 29 May 2006) $                                                      }
{                                                                                                  }
{**************************************************************************************************}

unit JclOptionsFrame;

{$I jcl.inc}
{$I windowsonly.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TFrameJclOptions = class(TFrame)
    ButtonIniFile: TButton;
    CheckBoxWizardActive: TCheckBox;
    CheckBoxWizardConfirm: TCheckBox;
    EditIniFile: TEdit;
    LabelIniFile: TLabel;
    OpenDialog: TOpenDialog;
    procedure ButtonIniFileClick(Sender: TObject);
  private
    function GetActive: Boolean;
    function GetConfigFileName: TFileName;
    function GetConfirmChanges: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetConfigFileName(const Value: TFileName);
    procedure SetConfirmChanges(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property Active: Boolean read GetActive write SetActive;
    property ConfirmChanges: Boolean read GetConfirmChanges write SetConfirmChanges;
    property ConfigFileName: TFileName read GetConfigFileName write SetConfigFileName;
  end;

implementation

uses
  ToolsAPI,
  JclRegistry, JclUsesWizard,
  JclOtaConsts, JclOtaResources, JclOtaUtils;

{$R *.dfm}

constructor TFrameJclOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OpenDialog.Filter := RsUsesOpenFilters;
  OpenDialog.Title := RsUsesOpenTitle;
  LabelIniFile.Caption := RsUsesConfigurationFile;
  CheckBoxWizardActive.Caption := RsUsesActive;
  CheckBoxWizardConfirm.Caption := RsUsesConfirm;
end;

function TFrameJclOptions.GetActive: Boolean;
begin
  Result := CheckBoxWizardActive.Checked;
end;

function TFrameJclOptions.GetConfigFileName: TFileName;
begin
  Result := EditIniFile.Text;
end;

function TFrameJclOptions.GetConfirmChanges: Boolean;
begin
  Result := CheckBoxWizardConfirm.Checked;
end;

procedure TFrameJclOptions.SetActive(const Value: Boolean);
begin
  CheckBoxWizardActive.Checked := True;
end;

procedure TFrameJclOptions.SetConfigFileName(const Value: TFileName);
begin
  EditIniFile.Text := Value;
end;

procedure TFrameJclOptions.SetConfirmChanges(const Value: Boolean);
begin
  CheckBoxWizardConfirm.Checked := Value;
end;

procedure TFrameJclOptions.ButtonIniFileClick(Sender: TObject);
begin
  try
    with OpenDialog do
    begin
      InitialDir := ExtractFilePath(EditIniFile.Text);
      FileName := EditIniFile.Text;
      if Execute then
        EditIniFile.Text := FileName;
    end;
  except
    on ExceptionObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptionObj);
      raise;
    end;
  end;
end;

end.
