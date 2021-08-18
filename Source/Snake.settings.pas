unit Snake.settings;

interface

type
  TSettings = class

  strict private
    class var FInstance: TSettings;
    constructor Create(); reintroduce;
  private
  public
  /// <summary> Einstellungen für das Spiel (z.B. groesse des Spielfeldes) </summary>
    ColCount, RowCount, StartX, StartY: Integer;
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
begin
  ColCount := 64;
  RowCount := 36;
  StartX := 10;
  StartY := 10;
end;

class function TSettings.GetInstance: TSettings;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TSettings.Create();
  end;
  result := FInstance;
end;

class procedure TSettings.ReleaseInstance;
begin
  FreeAndNil(FInstance);
end;

end.
