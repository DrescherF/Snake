unit Snake.GameEngine;

interface

uses
  Snake.Types, Snake.settings, Snake.Snake, Winapi.Windows;

type
  TGameEngine = class

  private
    FSpielfeld: Array of Array of Integer;
    FSnake: TSnake;
    FFood: TPoint;
    FColCount, FRowCount: Integer;
    function GetValue(ACol, ARow: Integer): Integer;
    /// <summary>Schaut ob das Feld leer ist</summary>
    function FieldEmpty(ACol, ARow: Integer): Boolean;
    procedure SetValue(ACol, ARow: Integer; const Value: Integer);

  public
    SnakeLives: Boolean;
    ED: Snake.Types.TEntityDirection;
    constructor Create(AColCount, ARowCount: Integer);
    destructor Destroy(); Override;
    property Cells[ACol, ARow: Integer]: Integer read GetValue write SetValue;
    procedure SnakeMove();
    procedure PlaceFood();
    property Snake: TSnake read FSnake;
    property Food: TPoint read FFood;

  end;

implementation

uses
  System.SysUtils, System.Classes;

constructor TGameEngine.Create(AColCount, ARowCount: Integer);

var
  i, j, k: Integer;

begin
  FSnake := TSnake.Create(settings.StartX, settings.StartY);
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
  FreeAndNil(FSnake);
  inherited;
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
    FFood := Point(i, j);
  end
  else
  begin
    PlaceFood;
  end;
end;

procedure TGameEngine.SetValue(ACol, ARow: Integer; const Value: Integer);
begin

  FSpielfeld[ACol, ARow] := Value;

end;

procedure TGameEngine.SnakeMove;

begin

  FSnake.Direction := ED;
  FSnake.Move;
  SnakeLives := Cells[FSnake.X, FSnake.Y] = 0;
  if FFood = FSnake.Position then
  begin
    FSnake.Grow(1);
    PlaceFood;
  end;
end;

end.
