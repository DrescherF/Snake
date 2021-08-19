unit Snake.Snake;

interface

uses
  Winapi.Windows, Snake.Types, System.Generics.Collections;

type
  TSnake = class

  private
    FPosition: TPoint;
    FDirection: TEntityDirection;
    FTail: TList<TPoint>;
    function GetX: Integer;
    function GetY: Integer;
    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
    procedure SetDirection(const Value: TEntityDirection);

  public

    constructor Create(AX, AY: Integer);
    destructor Destroy(); Override;
    procedure Move();
    ///<summary> Schlange waechst beim Essen </summary>
    procedure Grow(Value: Integer);
    ///<summary> Schaut ob der Punkt auf der Schlange liegt </summary>
    function Intersects(Coord: TPoint): Boolean;
    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
    property Position: TPoint read FPosition;
    property Direction: TEntityDirection read FDirection write SetDirection;
    property Tail: TList<TPoint> read FTail;
  end;

implementation

uses
  System.SysUtils, Snake.settings;

{ TSnake }

constructor TSnake.Create(AX, AY: Integer);
begin
  X := AX;
  Y := AY;
  FTail := TList<TPoint>.Create;
  // 2 Segmente hinzufuegen
  Grow(Settings.TailLength);
end;

destructor TSnake.Destroy;
begin
  FreeAndNil(FTail);
  inherited;
end;

function TSnake.GetX: Integer;
begin
  result := FPosition.X;
end;

function TSnake.GetY: Integer;
begin
  result := FPosition.Y;
end;

procedure TSnake.Grow(Value: Integer);
var
  l: Integer;
begin
  for l := 0 to Value - 1 do
    FTail.Add(FPosition);
end;

function TSnake.Intersects(Coord: TPoint): Boolean;
var
  i: Integer;
begin
  result:= Coord = FPosition;
  if result then
    exit;
  for i := 0 to FTail.Count - 1 do
  begin
    if FTail[i] = Coord then
      exit(true);
  end;

end;

procedure TSnake.Move;
begin
  // Postition des Kopfes zum Tail hinzufuegen
  FTail.Insert(0, FPosition);
  // Letztes Tail Element Löschen
  FTail.Delete(FTail.Count - 1);
  // Position Kopf bewegen
  case FDirection of
    edRight:
      X := X + 1;
    edDown:
      Y := Y + 1;
    edLeft:
      X := X - 1;
    edUp:
      Y := Y - 1;
  end;
end;

procedure TSnake.SetDirection(const Value: TEntityDirection);
begin
  // Todo: schlange darf die Richtung nicht in die entgegengesetzte aendern
  FDirection := Value;
end;

procedure TSnake.SetX(const Value: Integer);
begin
  FPosition.X := Value;
end;

procedure TSnake.SetY(const Value: Integer);
begin
  FPosition.Y := Value;
end;

end.
