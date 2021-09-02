unit Snake.Entity;

interface

uses
  Winapi.Windows, Snake.Types;

type
  TEntity = class abstract

  protected
    /// <summary> Position der Entity</summary>
    FPosition: TPoint;
    /// <summary> Blickrichtung der Entity</summary>
    FDirection: TEntityDirection;
    /// <summary> Getter fuer X Koordinate der Position der Entity </summary>
    function GetX: Integer;
    /// <summary> Getter fuer Y Koordinate der Position der Entity </summary>
    function GetY: Integer;
    /// <summary> Setter fuer X Koordinate der Position der Entity </summary>
    procedure SetX(const Value: Integer);
    /// <summary> Setter fuer Y Koordinate der Position der Entity</summary>
    procedure SetY(const Value: Integer);
    /// <summary> Setter fuer entityDirection </summary>
    procedure SetDirection(const Value: TEntityDirection); virtual;

  public
    /// <param name="AX"> X Koordinate fuer Entity Position </param>
    /// <param name="AY"> X Koordinate fuer Entity Position </param>
    constructor Create(AX, AY: Integer); virtual;
    /// <summary> Ueberprueft ob der mitgegebene Punkt gleich der Postion der Entity ist </summary>
    function Intersects(Coord: TPoint): Boolean; virtual;
    /// <summary> Property mit der die Position der Entity ausgelesen werden kann </summary>
    property Position: TPoint read FPosition;
    /// <summary> Entkapselt FDirection ueber SetDirection</summary>
    property Direction: TEntityDirection read FDirection write SetDirection;
    /// <summary>Entkapselt Entity Parameter mit GetX und SetX</summary>
    property X: Integer read GetX write SetX;
    /// <summary>Entkapselt Entity Parameter mit GetY und SetY</summary>
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
