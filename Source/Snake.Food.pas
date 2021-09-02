unit Snake.Food;

interface

uses
  Snake.Entity;

type
  TFood = class(TEntity)

  private
    FIcon: String;
    /// <summary> Setzt ein Zufaelliges Icon fuer die Food Entity</summary>
    procedure RandomIcon;

  const
    ICONS: Array of String = ['🍕', '🍔', '🍟', '🌭', '🥓', '🍖', '🍫', '🍭',
      '🧀', '🥐', '🍙'];

  public
    /// <summary> Ergaenst Konstruktor von TEntity um RandomIcon()</summary>
    constructor Create(AX, AY: Integer); Override;
    /// <summary> Entkapselt Lesezugriff von FIcon</summary>
    property Icon: String read FIcon;
  end;

implementation

procedure TFood.RandomIcon;
begin
   FIcon := ICONS[Random(length(ICONS))];
end;

constructor TFood.Create(AX: Integer; AY: Integer);
begin
  inherited Create(AX, AY);
  RandomIcon();
end;
end.
