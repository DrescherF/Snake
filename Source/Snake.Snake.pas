unit Snake.Snake;

interface

uses
  Winapi.Windows, Snake.Types, System.Generics.Collections, Snake.Entity;

type
  TSnake = class(TEntity)

  private
    FTail: TList<TPoint>;
    FLastDirection: TEntityDirection;

  protected
    ///<summary> Richtung kann hier (nicht um 180Grad) geaendert werden </summary>
    procedure SetDirection(const Value: TEntityDirection); Override;

  public
    constructor Create(AX, AY: Integer); Override;
    destructor Destroy(); Override;
    procedure Move();
    ///<summary> Schlange waechst beim Essen </summary>
    procedure Grow(Value: Integer);
    ///<summary> Schaut ob der Punkt auf der Schlange liegt </summary>
    function Intersects(Coord: TPoint): Boolean; Override;
    ///<summary> Schaut ob der Punkt auf dem Schweif liegt </summary>
    function IntersectsWithTail(Coord: TPoint): Boolean;
    property Tail: TList<TPoint> read FTail;
  end;

implementation


uses
  System.SysUtils, Snake.settings;

{ TSnake }

constructor TSnake.Create(AX, AY: Integer);
begin
  inherited Create(AX, AY);

  FTail := TList<TPoint>.Create;
  // 2 Segmente hinzufuegen
  Grow(Settings.TailLength);
end;

destructor TSnake.Destroy;
begin
  FreeAndNil(FTail);
  inherited;
end;

procedure TSnake.Grow(Value: Integer);
var
  l: Integer;
begin
  for l := 0 to Value - 1 do
    FTail.Add(FPosition);
end;

function TSnake.Intersects(Coord: TPoint): Boolean;
begin
  result := inherited;
  if result then
    exit;
  result := IntersectsWithTail(Coord);
end;

function TSnake.IntersectsWithTail(Coord: TPoint): Boolean;
var
  i: Integer;
begin
  result := false;
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
  case FLastDirection of
    edRight:
      if Value <> edLeft then
        FDirection := Value;
    edDown:
      if Value <> edUp then
        FDirection := Value;
    edLeft:
      if Value <> edRight then
        FDirection := Value;
    edUp:
      if Value <> edDown then
        FDirection := Value;
  end;
  FlastDirection := FDirection;
end;

end.
