unit Snake.Types;

interface

type
  TEntityDirection = (edNone, edRight, edDown, edLeft, edUp);

type
  /// <summary>Erweitert TEntityDirection um Hilfsfunktionen</summary>
  TEntityDirectionHelper = record helper for TEntityDirection
    /// <summary>Liefert die entgegengesetzte TEntityDirection zurück</summary>
    function Invert: TEntityDirection;
  end;

implementation

uses
  Winapi.Windows;

{ TEntityDirectionHelper }

function TEntityDirectionHelper.Invert: TEntityDirection;
begin
  case Self of
    edRight:
      result := edLeft;
    edDown:
      result := edUp;
    edLeft:
      result := edRight;
    edUp:
      result := edDown;
    else
      result := edNone;
  end;
end;

end.
