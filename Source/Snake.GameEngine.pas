unit Snake.GameEngine;

interface

uses
  Snake.Types, Snake.settings, Snake.Snake, Winapi.Windows, Vcl.ExtCtrls,
  System.Classes, System.Types, Snake.Food;

type
  TGameEngine = class

  private
    FSpielfeld: Array of Array of Boolean;
    /// <summary> Objekt FSnake vom Type TSnake(TEntity) </summary>
    FSnake: TSnake;
    /// <summary> Boolean Wert GameOver. Wenn true, dann SGame beenden und SGameOverStarten</summary>
    FGameOver: Boolean;
    /// <summary> Objekt FFood vom Type TFood(TEntity)</summary>
    FFood: TFood;
    /// <summary> Anzahl Spalten und Reihen Spielfeld</summary>
    FColCount, FRowCount: Integer;
    /// <summary> Timer nach dessen Tick Geschwindigkeit sich die Bewegung auf dem Spielfeld richtet</summary>
    FTimer: TTimer;
    /// <summary> NotifyEvent, dass TFormSGame.GameEngineOnProcess ausloest </summary>
    FOnProcess: TNotifyEvent;
    /// <summary> NotifyEvent, dass TFormSGame.GameEngineOnGameOver ausloest</summary>
    FOnGameOver: TNotifyEvent;
    /// <summary> Variable fuer den Score des aktuellen Spiels</summary>
    FScore: Integer;

    /// <summary> Gibt Wert von FSpielfeld wieder bei den angegebenen x und y Wertes </summary>
    function GetValue(ACol, ARow: Integer): Boolean;
    /// <summary> Schaut ob das Feld leer ist</summary>
    function FieldEmpty(ACol, ARow: Integer): Boolean;

    /// <summary> Setzt Wert von FSpielfeld bei den angegebenen x und y Wertes</summary>
    procedure SetValue(ACol, ARow: Integer; const Value: Boolean);
    /// <summary> Bewegt Schlange und loest FOnProcess aus</summary>
    procedure DoProcess(Sender: TObject);
    /// <summary> Setzt das spiel GameOver bei entsprechendem FGameOver Wert</summary>
    procedure SetGameOver(const Value: Boolean);
    /// <summary> Erstellt Schlange an zufaelligen Punkt, der frei ist</summary>
    procedure SpawnSnake(var ASnake: TSnake);
    /// <summary> Spielfeld wird erzeugt </summary>
    procedure InitializeField();
  public
    constructor Create(AColCount, ARowCount: Integer);
    destructor Destroy(); Override;
    /// <summary> laesst Schlange bewegen und auf Kolliedierungen pruefen</summary>
    procedure SnakeMove();
    /// <summary> Spawned Food an einer zufaelligen freien Koordinate</summary>
    procedure PlaceFood();
    /// <summary> �bertr�gt die �bergebene Richtung direkt an die Snake</summary>
    procedure Input(const Direction: TEntityDirection);
    { Properties }
    /// <summary> Entkapselt Felder des FSpielfeld</summary>
    property Cells[ACol, ARow: Integer]: Boolean read GetValue write SetValue;
    /// <summary> Oeffentlicher Lesezugriff auf FSnake</summary>
    property Snake: TSnake read FSnake;
    /// <summary> Oeffentlicher Lesezugriff auf FFood</summary>
    property Food: TFood read FFood;
    /// <summary> Entkapselt FOnProcess</summary>
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    /// <summary> Entkapselt FOnGameOver</summary>
    property OnGameOver: TNotifyEvent read FOnGameOver write FOnGameOver;
    /// <summary> Entkapselt FGamerOver und setzt Setter</summary>
    property GameOver: Boolean read FGameOver write SetGameOver;
    /// <summary> Oeffentlicher Lesezugriff auf FScore</summary>
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

function TGameEngine.GetValue(ACol, ARow: Integer): Boolean;
begin
  result := FSpielfeld[ACol, ARow];
end;

procedure TGameEngine.InitializeField;
var
  i, j, k: Integer;
begin
  // Gr��e der Arrays initialisieren
  SetLength(FSpielfeld, FColCount);
  for i := 0 to FColCount - 1 do
  begin
    SetLength(FSpielfeld[i], FRowCount);
  end;

  // Raender befuellen (als Wand f�r die Spielwelt)
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
