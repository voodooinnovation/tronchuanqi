{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBActionsEngineControlCxPivotGrid.Pas, released on 2004-12-30.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBActionsEngineControlCxPivotGrid.pas 11059 2006-11-29 17:12:58Z marquardt $

unit JvDBActionsEngineControlCxPivotGrid;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Forms, Controls, Classes, DB,
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  cxDBPivotGrid, cxDBData,
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  JvDBActionsEngine;

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
type
  TJvDatabaseActionDevExpCxPivotGridControlEngine = class(TJvDatabaseActionBaseControlEngine)
  private
    function DBDataController(AActionComponent: TComponent): TcxDBDataController;
  protected
    function PivotGrid(AActionComponent: TComponent): TcxCustomDBPivotGrid;
  public
    constructor Create(AOwner: TComponent); override;
    function CanInsert(aActionComponent: TComponent): Boolean; override;
    function CanUpdate(aActionComponent: TComponent): Boolean; override;
    function CanDelete(aActionComponent: TComponent): Boolean; override;
    function CanNavigate(aActionComponent: TComponent): Boolean; override;
    function DataSource(AActionComponent: TComponent): TDataSource; override;
    function SupportsComponent(AActionComponent: TComponent): Boolean; override;
  end;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net:443/svnroot/jvcl/trunk/jvcl/run/JvDBActionsEngineControlCxPivotGrid.pas $';
    Revision: '$Revision: 11059 $';
    Date: '$Date: 2006-11-29 18:12:58 +0100 (Mi, 29 Nov 2006) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  SysUtils;

//=== { TJvDatabaseActionDevExpCxPivotGridControlEngine } =========================

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}

constructor TJvDatabaseActionDevExpCxPivotGridControlEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'TJvDatabaseActionDevExpCxPivotGridControlEngine';
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.PivotGrid(
    AActionComponent: TComponent): TcxCustomDBPivotGrid;
begin
  if Assigned(AActionComponent) then
    if AActionComponent is TcxCustomDBPivotGrid then
      Result := TcxCustomDBPivotGrid(AActionComponent)
    else
      Result := nil
  else
    Result := nil;
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.DataSource(
    AActionComponent: TComponent): TDataSource;
begin
  if Assigned(DBDataController(AActionComponent)) then
    Result := DBDataController(AActionComponent).DataSource
  else
    Result := inherited DataSource(AActionComponent)
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.SupportsComponent(
    AActionComponent: TComponent): Boolean;
begin
  Result := Assigned(PivotGrid(AActionComponent));
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.CanInsert(aActionComponent:
    TComponent): Boolean;
begin
  Result := False;
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.CanUpdate(aActionComponent:
    TComponent): Boolean;
begin
  Result := False;
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.CanDelete(aActionComponent:
    TComponent): Boolean;
begin
  Result := False;
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.CanNavigate(
    aActionComponent: TComponent): Boolean;
begin
  Result := False;
end;

function TJvDatabaseActionDevExpCxPivotGridControlEngine.DBDataController(
    AActionComponent: TComponent): TcxDBDataController;

begin
  if Assigned(PivotGrid(aActionComponent)) and (PivotGrid(aActionComponent).DataController is TcxDBDataController) then
    Result := TcxDBDataController(PivotGrid(aActionComponent).DataController)
  else
    Result := nil;
end;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}

procedure InitActionEngineList;
begin
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXPIVOTGRID}
  RegisterDatabaseActionEngine(TJvDatabaseActionDevExpCxPivotGridControlEngine);
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

