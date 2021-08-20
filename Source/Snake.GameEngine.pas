unit Snake.GameEngine;

interface

uses
  Snake.Types, Snake.settings, Snake.Snake, Winapi.Windows, Vcl.ExtCtrls,
  System.Classes, System.Types, Snake.Food;

type
  TGameEngine = class

  private
    FSpielfeld: Array of Array of Integer;
    FSnake: TSnake;
    FGameOver: Boolean;
    FFood: TFood;
    FColCount, FRowCount: Integer;
    FTimer: TTimer;
    FOnProcess: TNotifyEvent;
    FOnGameOver: TNotifyEvent;
    function GetValue(ACol, ARow: Integer): Integer;
    /// <summary>Schaut ob das Feld leer ist</summary>
    function FieldEmpty(ACol, ARow: Integer): Boolean;
    procedure SetValue(ACol, ARow: Integer; const Value: Integer);
    procedure DoProcess(Sender: TObject);
    procedure SetGameOver(const Value: Boolean);
  public
    ED: Snake.Types.TEntityDirection;
    constructor Create(AColCount, ARowCount: Integer);
    destructor Destroy(); Override;
    property Cells[ACol, ARow: Integer]: Integer read GetValue write SetValue;
    procedure SnakeMove();
    procedure PlaceFood();
    property Snake: TSnake read FSnake;
    property Food: TFood read FFood;
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    property OnGameOver: TNotifyEvent read FOnGameOver write FOnGameOver;
    property GameOver: Boolean read FGameOver write SetGameOver;

  end;

implementation

uses
  System.SysUtils;

constructor TGameEngine.Create(AColCount, ARowCount: Integer);

var
  i, j, k: Integer;

begin
  FSnake := TSnake.Create(settings.StartX, settings.StartY);

  // Food auf Nullpointer setzen
  FFood := nil;

  // Timer wird erzeugt und Tick Geschwindigkeit initalisiert
  FTimer := TTimer.Create(nil);
  FTimer.Interval := settings.InitialGameSpeed;
  FTimer.OnTimer := DoProcess;

  FColCount := AColCount;
  FRowCount := ARowCount;

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
        Cells[k, j] := 1;
      end;
    end;
  end;

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
  result := Cells[ACol, ARow] = 0;
  if not result then
    exit;
  result := not FSnake.Intersects(Point(ACol, ARow));
end;

function TGameEngine.GetValue(ACol, ARow: Integer): Integer;
begin
  result := FSpielfeld[ACol, ARow];
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

procedure TGameEngine.SetGameOver(const Value: Boolean);
begin
  if FGameOver = Value then
    exit;
  FTimer.Enabled := not Value;
  FGameOver := Value;
  if FGameOver and Assigned(FOnGameOver) then
    FOnGameOver(self);
end;

procedure TGameEngine.SetValue(ACol, ARow: Integer; const Value: Integer);
begin

  FSpielfeld[ACol, ARow] := Value;

end;

procedure TGameEngine.SnakeMove;

begin

  FSnake.Direction := ED;
  FSnake.Move;
  GameOver := not(Cells[FSnake.X, FSnake.Y] = 0);
  if FFood.Position = FSnake.Position then
  begin
    FSnake.Grow(1);
    PlaceFood;
  end;
end;

end.
