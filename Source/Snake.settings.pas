unit Snake.settings;

interface

uses
  IniFiles;

type
 /// <summary> Einstellungen für das Spiel (z.B. groesse des Spielfeldes) </summary>
  TSettings = class

  strict private
    class var FInstance: TSettings;
    constructor Create(); reintroduce;
    destructor Destroy(); Override;

  private

  public
    procedure Refresh();

  var
    ColCount, RowCount: Integer;
    StartX, StartY: Integer;
    CellSize: Integer;
    TailLength: Integer;
    InitialGameSpeed: Integer;
    Ini: TInifile;
    class function GetInstance(): TSettings;
    class procedure ReleaseInstance();

  end;

function settings(): TSettings;

implementation

uses
  System.SysUtils;

function settings(): TSettings;
begin
  result := TSettings.GetInstance;
end;

{ TSettings }

constructor TSettings.Create;
var
  filename: String;
begin
  filename := ExtractFilePath(ParamStr(0)) + 'settings.ini';
  Ini := TInifile.Create(filename);

  Refresh;

  CellSize := 20;
end;

destructor TSettings.Destroy;
begin
  Ini.Free;
  inherited;
end;

class function TSettings.GetInstance: TSettings;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TSettings.Create();
  end;
  result := FInstance;
end;

procedure TSettings.Refresh;
begin
  ColCount := (Ini.ReadInteger('SpielfeldGroesse', 'ColCount', 72));
  RowCount := (Ini.ReadInteger('SpielfeldGroesse', 'RowCount', 36));

  InitialGameSpeed := 360 div (Ini.ReadInteger('StartWerte',
    'InitialGameSpeed', 4));
  TailLength := Ini.ReadInteger('StartWerte', 'TailLength', 3);

  StartX := Random(ColCount - 14) + 7;
  StartY := Random(RowCount - 8) + 4;
end;

class procedure TSettings.ReleaseInstance;
begin
  FreeAndNil(FInstance);
end;

end.
