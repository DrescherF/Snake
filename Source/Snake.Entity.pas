unit Snake.Entity;

interface

uses
  Winapi.Windows, Snake.Types;

type
  TEntity = class abstract

  protected
    FPosition: TPoint;
    FDirection: TEntityDirection;
    function GetX: Integer;
    function GetY: Integer;
    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
    procedure SetDirection(const Value: TEntityDirection); virtual;


  public
    constructor Create(AX, AY: Integer); virtual;
    function Intersects(Coord: TPoint): Boolean; virtual;
    property Position: TPoint read FPosition;
    property Direction: TEntityDirection read FDirection write SetDirection;
    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;

  end;

implementation

{ TEntity }

constructor TEntity.Create(AX, AY: Integer);
begin
  X := AX;
  Y := AY
end;

function TEntity.GetX: Integer;
begin
  result:= FPosition.X;
end;

function TEntity.GetY: Integer;
begin
  result:= FPosition.Y;
end;

function TEntity.Intersects(Coord: TPoint): Boolean;
begin
  result:= Coord = FPosition;
end;

procedure TEntity.SetDirection(const Value: TEntityDirection);
begin
  FDirection := Value;
end;

procedure TEntity.SetX(const Value: Integer);
begin
  FPosition.X := Value;
end;


procedure TEntity.SetY(const Value: Integer);
begin
  FPosition.Y := Value;
end;

end.
