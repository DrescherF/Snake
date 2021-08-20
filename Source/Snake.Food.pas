unit Snake.Food;

interface

uses
  Snake.Entity;

type
  TFood = class(TEntity)

  private
    FIcon: String;
    procedure RandomIcon;

  const
    ICONS: Array of String = ['🍕', '🍔', '🍟', '🌭', '🥓', '🍖', '🍫', '🍭',
      '🧀', '🥐', '🍙'];

  public
    constructor Create(AX, AY: Integer); Override;
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
