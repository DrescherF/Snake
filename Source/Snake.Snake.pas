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
    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
    property Direction: TEntityDirection read FDirection write SetDirection;
    property Tail: TList<TPoint> read FTail;
  end;

implementation

uses
  System.SysUtils, Snake.settings;

{ TSnake }

constructor TSnake.Create(AX, AY: Integer);
var
  l: Integer;
begin
  X := AX;
  Y := AY;
  FTail := TList<TPoint>.Create;
  // 2 Segmente hinzufuegen
  for l := 0 to settings.TailLength - 1 do
    FTail.Add(FPosition);
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
