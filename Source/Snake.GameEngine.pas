unit Snake.GameEngine;

interface

type
  TGameEngine = class

  private
    FSpielfeld: Array of Array of Integer;
    FColCount, FRowCount: Integer;
    function GetValue(ACol, ARow: Integer): Integer;
    procedure SetValue(ACol, ARow: Integer; const Value: Integer);

  public
    constructor Create(AColCount, ARowCount: Integer);
    property Cells[ACol, ARow: Integer]: Integer read GetValue write SetValue;
    procedure Snake();
    procedure SnakeMoveRight();
    procedure SnakeMoveDown();
    procedure SnakeMoveLeft();
    procedure SnakeMoveUp();

  var
    SnakeX: Integer;
    SnakeY: Integer;
    SnakeLives: Boolean;

  end;

implementation

constructor TGameEngine.Create(AColCount, ARowCount: Integer);
var
  i, j, k: Integer;

begin
  FColCount := AColCount;
  FRowCount := ARowCount;

  // Gr��e der Arrays initialisieren
  SetLength(FSpielfeld, FColCount);
  for i := 0 to FColCount - 1 do
  begin
    SetLength(FSpielfeld[i], FRowCount);
  end;

  // Raender befuellen (als Wand f�r die Spielwelt
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

function TGameEngine.GetValue(ACol, ARow: Integer): Integer;
begin
  result := FSpielfeld[ACol, ARow];
end;

procedure TGameEngine.SetValue(ACol, ARow: Integer; const Value: Integer);
begin

  FSpielfeld[ACol, ARow] := Value;

end;

procedure TGameEngine.Snake;
var
  i, j: Integer;

begin
  i := SnakeX;
  j := SnakeY;

  Cells[i, j] := 1;

end;

procedure TGameEngine.SnakeMoveDown;
begin
  if (Cells[SnakeX, SnakeY + 1] = 1) then
  begin
    SnakeLives := false;
  end
  else
  begin
    Cells[SnakeX, SnakeY] := 0;
    inc(SnakeY);
    Cells[SnakeX, SnakeY] := 1;
  end;
end;

procedure TGameEngine.SnakeMoveLeft;
begin
  if (Cells[SnakeX - 1, SnakeY] = 1) then
  begin
    SnakeLives := false;
  end
  else
  begin
    Cells[SnakeX, SnakeY] := 0;
    dec(SnakeX);
    Cells[SnakeX, SnakeY] := 1;
  end;
end;

procedure TGameEngine.SnakeMoveRight();
begin
  if (Cells[SnakeX + 1, SnakeY] = 1) then
  begin
    SnakeLives := false;
  end
  else
  begin
    Cells[SnakeX, SnakeY] := 0;
    inc(SnakeX);
    Cells[SnakeX, SnakeY] := 1;
  end;
end;

procedure TGameEngine.SnakeMoveUp;
begin
  if (Cells[SnakeX , SnakeY - 1] = 1) then
  begin
    SnakeLives := false;
  end
  else
  begin
    Cells[SnakeX, SnakeY] := 0;
    dec(SnakeY);
    Cells[SnakeX, SnakeY] := 1;
  end;
end;

end.
