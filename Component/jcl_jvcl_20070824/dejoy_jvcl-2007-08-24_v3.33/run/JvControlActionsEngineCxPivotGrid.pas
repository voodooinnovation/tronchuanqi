{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBActionsEngineControlCxGrid.Pas, released on 2004-12-30.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBActionsEngineControlCxGrid.pas 11059 2006-11-29 17:12:58Z marquardt $

unit JvControlActionsEngineCxPivotGrid;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Forms, Controls, Classes, DB,
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  cxCustomPivotGrid,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  JvControlActionsEngine;

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
type
  TJvControlActioncxPivotGridEngine = class(TJvControlActionEngine)
  private
  protected
    procedure ExportGrid(aGrid: TcxCustomPivotGrid);
    function GetPivotGrid(AActionComponent: TComponent): TcxCustomPivotGrid;
    function GetSupportedOperations: TJvControlActionOperations; override;
  public
    function ExecuteOperation(const aOperation: TJvControlActionOperation; const
        aActionControl: TControl): Boolean; override;
    function SupportsComponent(aActionComponent: TComponent): Boolean; override;
  end;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvDBActionsEngineControlCxGrid.pas $';
    Revision: '$Revision: 11059 $';
    Date: '$Date: 2006-11-29 18:12:58 +0100 (Mi, 29 Nov 2006) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  cxExportPivotGridLink,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  SysUtils, Dialogs;

//=== { TJvDatabaseActionDevExpCxGridControlEngine } =========================

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}

function TJvControlActioncxPivotGridEngine.ExecuteOperation(const aOperation:
    TJvControlActionOperation; const aActionControl: TControl): Boolean;

var
  PivotGrid : TcxCustomPivotGrid;
  i : Integer;
begin
  Result := false;
  PivotGrid := GetPivotGrid(aActionControl);
  if Assigned(PivotGrid) then
    Case aOperation of
      caoCollapse :
        for I := 0 to PivotGrid.Groups.Count - 1 do
          PivotGrid.Groups[i].FullCollapse;
      caoExpand :
        for I := 0 to PivotGrid.Groups.Count - 1 do
          PivotGrid.Groups[i].FullExpand;
      caoOptimizeColumns :
        PivotGrid.ApplyBestFit;
      caoExport :
        ExportGrid (PivotGrid);
    End;
end;

procedure TJvControlActioncxPivotGridEngine.ExportGrid(aGrid:
    TcxCustomPivotGrid);
var
  SaveDialog: TSaveDialog;
begin
  if not Assigned(aGrid) then
    Exit;
  SaveDialog := TSaveDialog.Create(Self);
  try
    with SaveDialog do
    begin
      Name    := 'SaveDialog';
      DefaultExt := 'XLS';
      Filter  := 'MS-Excel-Files (*.XLS)|*.XLS|XML-Files (*.XML)|*.HTM|HTML-Files (*.HTM)|*.HTM|Text-Files (*.TXT)|*.TXT|All Files (*.*)|*.*';
      Options := [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist];
    end;
    if SaveDialog.Execute then
      if SaveDialog.FileName <> '' then
      begin
        if (Pos('.XLS', UpperCase(SaveDialog.FileName)) = Length(SaveDialog.FileName) - 3) then
          cxExportPivotGridToExcel(SaveDialog.FileName, aGrid)
        else if (Pos('.XML', UpperCase(SaveDialog.FileName)) = Length(SaveDialog.FileName) - 3) then
          cxExportPivotGridToXML(SaveDialog.FileName, aGrid)
        else if ((Pos('.HTM', UpperCase(SaveDialog.FileName)) = Length(SaveDialog.FileName) - 3) or
          (Pos('.HTML', UpperCase(SaveDialog.FileName)) = Length(SaveDialog.FileName) - 4)) then
          cxExportPivotGridToHTML(SaveDialog.FileName, aGrid)
        else
          cxExportPivotGridToText(SaveDialog.FileName, aGrid);
      end;
  finally
    SaveDialog.Free;
  end;
end;

function TJvControlActioncxPivotGridEngine.GetPivotGrid(AActionComponent:
    TComponent): TcxCustomPivotGrid;
begin
  if Assigned(AActionComponent) then
    if AActionComponent is TcxCustomPivotGrid then
      Result := TcxCustomPivotGrid(AActionComponent)
    else
      Result := nil
  else
    Result := nil;
end;

function TJvControlActioncxPivotGridEngine.GetSupportedOperations:
    TJvControlActionOperations;
begin
  Result := [{caoCollapse, caoExpand, }caoOptimizeColumns, caoExport];
end;

function TJvControlActioncxPivotGridEngine.SupportsComponent(aActionComponent:
    TComponent): Boolean;
begin
  Result := Assigned(GetPivotGrid(AActionComponent));
end;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}

procedure InitActionEngineList;
begin
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  RegisterControlActionEngine(TJvControlActioncxPivotGridEngine);
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
end;


initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  InitActionEngineList;

finalization
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.

