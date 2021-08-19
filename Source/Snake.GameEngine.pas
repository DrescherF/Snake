unit Snake.GameEngine;

interface

uses
  Snake.Types, Snake.settings, Snake.Snake;

type
  TGameEngine = class

  private
    FSpielfeld: Array of Array of Integer;
    FSnake: TSnake;
    FColCount, FRowCount: Integer;
    function GetValue(ACol, ARow: Integer): Integer;
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

  end;

implementation

uses
  System.SysUtils;

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

  if Cells[i, j] = 0 then
  begin
    Cells[i, j] := 1;
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


end;

end.
