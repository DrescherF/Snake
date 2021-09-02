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

  private
    /// <summary> Ini File in welcher die Einstellungen gespeichert werden</summary>
    FIni: TInifile;
    /// <summary> Anzahl der Spalten und Reihen des Spielfeldes</summary>
    FColCount, FRowCount: Integer;
    /// <summary> Geschwindigkeit des Timers, nach welchem sich die Bewegung der Schlange richtet</summary>
    FInitialGameSpeed: Integer;
    /// <summary> Setz Laenge von FTail</summary>
    FInitialTailLength: Integer;
    /// <summary> Speichert eingegeben Name waerend Spiel-Laufzeit</summary>
    FPlayerName: String;
    /// <summary> Hoehe und Breite der einzelnen Felder</summary>
    FCellSize: Integer;

    /// <summary> Setter fuer FColCount</summary>
    procedure SetColCount(const Value: Integer);
    /// <summary> Setter fuer FRowCount</summary>
    procedure SetRowCount(const Value: Integer);
    /// <summary> Setter fuer FInitialGameSpeed</summary>
    procedure SetInitialGameSpeed(const Value: Integer);
    ////// <summary> Setter fuer FInitialTailLenngth</summary>
    procedure SetInitialTailLength(const Value: Integer);
    /// <summary> Setter fuer FPlayerName</summary>
    procedure SetPlayerName(const Value: String);
  public
    destructor Destroy(); Override;

    /// <summary> Standartwert fuer Spaltenanzahl, wird verwendet, wenn nichts anderes angegeben</summary>
    const DEFAULT_COLCOUNT = 72;
    /// <summary> Standartwert fuer Reihenanzahl, wird verwendet, wenn nichts anderes angegeben</summary>
    const DEFAULT_ROWCOUNT = 36;
    /// <summary> Standartwert fuer Spielgeschwindigkeit, wird verwendet, wenn nichts anderes angegeben</summary>
    const DEFAULT_GAMESPEED = 4;
    /// <summary> Standartwert fuer FInitialTailLength wird verwendet, wenn nichts anderes angegeben</summary>
    const DEFAULT_TAILLENGHT = 3;
    /// <summary> Standartwert fuer FCellSize, wird verwendet, wenn nichts anderes angegeben</summary>
    const DEFAULT_CELLSIZE = 20;

    /// <summary> Lardt alle Einstellungen aus der Ini Datei</summary>
    procedure Refresh();

    /// <summary>Entkapselt FColCount mit SetcolCount</summary>
    property ColCount: Integer read FColCount write SetColCount;
    /// <summary> Entkapselt FRowCount mit SetRowCount</summary>
    property RowCount: Integer read FRowCount write SetRowCount;
    /// <summary> Entkapselt FIntitialGameSpeed mit SetInitialGameSpeed</summary>
    property InitialGameSpeed: Integer read FInitialGameSpeed write SetInitialGameSpeed;
    /// <summary> Entkapselt FInitialTailLength mit SetInitialTailLength</summary>
    property InitialTailLenght: Integer read FInitialTailLength write SetInitialTailLength;
    /// <summary> Entkapselt FPlayerName mit </summary>
    property PlayerName: String read FPlayerName write SetPlayerName;
    /// <summary> Entkapselt Lesezugriff von FCellSize</summary>
    property CellSize: Integer read FCellSize;

    /// <summary> Es existiert immer nur ein Objekt der Klasse TSettings, ersetzt Create</summary>
    class function GetInstance(): TSettings;
    /// <summary> FreeAndNil der Settings Instanz</summary>
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

  FPlayerName         := FIni.ReadString('Spieler', 'LastPlayerName', '');

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

procedure TSettings.SetPlayerName(const Value: String);
begin
  FPlayerName := Value;
  FIni.WriteString('Spieler', 'LastPlayerName', Value);
end;

procedure TSettings.SetRowCount(const Value: Integer);
begin
  FRowCount := Value;
  Fini.WriteInteger('SpielfeldGroesse', 'RowCount', Value);
end;

end.
