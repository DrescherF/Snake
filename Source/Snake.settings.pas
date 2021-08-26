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
    FIni: TInifile;
    FColCount, FRowCount: Integer;
    FInitialGameSpeed: Integer;
    FInitialTailLength: Integer;
    FCellSize: Integer;
    procedure SetColCount(const Value: Integer);
    procedure SetRowCount(const Value: Integer);
    procedure SetInitialGameSpeed(const Value: Integer);
    procedure SetInitialTailLength(const Value: Integer);
  public
    const DEFAULT_COLCOUNT = 72;
    const DEFAULT_ROWCOUNT = 36;
    const DEFAULT_GAMESPEED = 4;
    const DEFAULT_TAILLENGHT = 3;
    const DEFAULT_CELLSIZE = 20;
    /// <summary>Lädt alle Einstellungen aus der Ini Datei</summary>
    procedure Refresh();

    property ColCount: Integer read FColCount write SetColCount;
    property RowCount: Integer read FRowCount write SetRowCount;
    property InitialGameSpeed: Integer read FInitialGameSpeed write SetInitialGameSpeed;
    property InitialTailLenght: Integer read FInitialTailLength write SetInitialTailLength;
    property CellSize: Integer read FCellSize;

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
  FIni := TInifile.Create(filename);

  Refresh;
end;

destructor TSettings.Destroy;
begin
  FIni.Free;
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

class procedure TSettings.ReleaseInstance;
begin
  FreeAndNil(FInstance);
end;

procedure TSettings.Refresh;
begin
  FColCount           := FIni.ReadInteger('SpielfeldGroesse', 'ColCount', DEFAULT_COLCOUNT);
  FRowCount           := FIni.ReadInteger('SpielfeldGroesse', 'RowCount', DEFAULT_ROWCOUNT);
  FInitialGameSpeed   := FIni.ReadInteger('StartWerte', 'InitialGameSpeed', DEFAULT_GAMESPEED);
  FInitialTailLength  := FIni.ReadInteger('StartWerte', 'TailLength', DEFAULT_TAILLENGHT);

  FCellSize           := DEFAULT_CELLSIZE;
end;

procedure TSettings.SetColCount(const Value: Integer);
begin
  FColCount := Value;
  Fini.WriteInteger('SpielfeldGroesse', 'ColCount', Value);
end;

procedure TSettings.SetInitialGameSpeed(const Value: Integer);
begin
  FInitialGameSpeed := Value;
  Fini.WriteInteger('StartWerte', 'InitialGamespeed', Value);
end;

procedure TSettings.SetInitialTailLength(const Value: Integer);
begin
  FInitialTailLength := Value;
  FIni.WriteInteger('StartWerte', 'TailLength', Value);
end;

procedure TSettings.SetRowCount(const Value: Integer);
begin
  FRowCount := Value;
  Fini.WriteInteger('SpielfeldGroesse', 'RowCount', Value);
end;

end.
