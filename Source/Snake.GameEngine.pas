unit Snake.GameEngine;

interface

uses
  Snake.Types, Snake.settings, Snake.Snake, Winapi.Windows, Vcl.ExtCtrls,
  System.Classes, System.Types, Snake.Food;

type
  TGameEngine = class

  private
    FSpielfeld: Array of Array of Boolean;
    FSnake: TSnake;
    FGameOver: Boolean;
    FFood: TFood;
    FColCount, FRowCount: Integer;
    FTimer: TTimer;
    FOnProcess: TNotifyEvent;
    FOnGameOver: TNotifyEvent;
    FScore: Integer;
    function GetValue(ACol, ARow: Integer): Boolean;
    /// <summary>Schaut ob das Feld leer ist</summary>
    function FieldEmpty(ACol, ARow: Integer): Boolean;
    procedure SetValue(ACol, ARow: Integer; const Value: Boolean);
    procedure DoProcess(Sender: TObject);
    procedure SetGameOver(const Value: Boolean);
    function GetED: TEntityDirection;
    procedure SetED(const Value: TEntityDirection);
    /// <summary> Erstellt Schlange an zufaelligen Punkt, der frei ist</summary>
    procedure SpawnSnake(var ASnake: TSnake);
    /// <summary> Spielfeld wird erzeugt </summary>
    procedure InitializeField();
  public

    constructor Create(AColCount, ARowCount: Integer);
    destructor Destroy(); Override;
    procedure SnakeMove();
    procedure PlaceFood();
    /// <summary>Überträgt die übergebene Richtung direkt an die Snake</summary>
    procedure Input(const Direction: TEntityDirection);
    { Properties }
    property Cells[ACol, ARow: Integer]: Boolean read GetValue write SetValue;
    property Snake: TSnake read FSnake;
    property Food: TFood read FFood;
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    property OnGameOver: TNotifyEvent read FOnGameOver write FOnGameOver;
    property GameOver: Boolean read FGameOver write SetGameOver;
    property Score: Integer read FScore;

  end;

implementation

uses
  System.SysUtils;

constructor TGameEngine.Create(AColCount, ARowCount: Integer);

begin
  FColCount := AColCount;
  FRowCount := ARowCount;
  InitializeField();
  SpawnSnake(FSnake);
  // Food auf Nullpointer setzen
  FFood := nil;

  // Timer wird erzeugt und Tick Geschwindigkeit initalisiert
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 360 div settings.InitialGameSpeed;
  FTimer.OnTimer := DoProcess;
end;

destructor TGameEngine.Destroy;
begin
  FreeAndNil(FTimer);
  FreeAndNil(FFood);
  FreeAndNil(FSnake);
  inherited;
end;

procedure TGameEngine.DoProcess(Sender: TObject);
begin
  SnakeMove;
  If (Assigned(FOnProcess)) then
    FOnProcess(self);
end;

function TGameEngine.FieldEmpty(ACol, ARow: Integer): Boolean;
begin
  result := not Cells[ACol, ARow];
  if not result then
    exit;
  result := not FSnake.Intersects(Point(ACol, ARow));
end;

function TGameEngine.GetED: TEntityDirection;
begin
  result := FSnake.Direction;
end;

function TGameEngine.GetValue(ACol, ARow: Integer): Boolean;
begin
  result := FSpielfeld[ACol, ARow];
end;

procedure TGameEngine.InitializeField;
var
  i, j, k: Integer;
begin
  // Größe der Arrays initialisieren
  SetLength(FSpielfeld, FColCount);
  for i := 0 to FColCount - 1 do
  begin
    SetLength(FSpielfeld[i], FRowCount);
  end;

  // Raender befuellen (als Wand für die Spielwelt)
  for k := 0 to FColCount - 1 do
  begin
    for j := 0 to FRowCount - 1 do
    begin
      if (k = 0) or (k = FColCount - 1) or (j = 0) or (j = FRowCount - 1) then
      begin
        Cells[k, j] := true;
      end;
    end;
  end;
end;

procedure TGameEngine.Input(const Direction: TEntityDirection);
begin
  FSnake.Direction := Direction;
end;

procedure TGameEngine.PlaceFood;
var
  i, j: Integer;
begin
  i := Random(FColCount - 1);
  j := Random(FRowCount - 1);

  if FieldEmpty(i, j) then
  begin
    FreeAndNil(FFood);
    FFood := TFood.Create(i, j);
  end
  else
  begin
    PlaceFood;
  end;
end;

procedure TGameEngine.SetED(const Value: TEntityDirection);
begin
  FSnake.Direction := Value;
end;

procedure TGameEngine.SetGameOver(const Value: Boolean);
begin
  if FGameOver = Value then
    exit;
  FTimer.Enabled := not Value;
  FGameOver := Value;
  if FGameOver and Assigned(FOnGameOver) then
    FOnGameOver(self);
end;

procedure TGameEngine.SetValue(ACol, ARow: Integer; const Value: Boolean);
begin

  FSpielfeld[ACol, ARow] := Value;

end;

procedure TGameEngine.SnakeMove;
var
  i: Integer;

begin

  FSnake.Move;
  // Ueberprueft ob Schlangenkopf mit Wand kollidiert
  GameOver := (Cells[FSnake.X, FSnake.Y]);

  // Ueberprueft ob Schlangenkopf mit eigenem Scweif kollidiert
  GameOver := GameOver or Snake.IntersectsWithTail(FSnake.Position);

  // Ueberprueft ob Schlangenkopf auf Futter liegt
  if FFood.Position = FSnake.Position then
  begin
    //Schlange waechst
    FSnake.Grow(1);
    //Score erhoehen
    inc(FScore);
    // platziert neues Futter
    PlaceFood;
  end;
end;

procedure TGameEngine.SpawnSnake(var ASnake: TSnake);
var
  X, Y: Integer;
const
  SPACING: Integer = 3;
begin
  X := Random(FColCount - SPACING * 2) + SPACING;
  Y := Random(FRowCount - SPACING * 2) + SPACING;
  // Todo fuer spaeter: Ueberpruefen ob Ort schon belegt
  ASnake := TSnake.Create(X, Y);
end;

end.
