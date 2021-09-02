unit SGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Snake.GameEngine, Snake.Settings, SGameOver, Snake.Types, Snake.Data;

type
  TFormSGame = class(TForm)
    /// <summary> Szene fuer </summary>
    ImageScene: TImage;
    /// <summary> liest Pfeiltasten ein und ruft passend FGameEngine.Input auf / Schliesst Programm aus ESC</summary>
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    /// <summary> Erstellt Form nach groesse / laesst Peilefeld malen und Platziert Schlange sowie Food</summary>
    procedure FormShow(Sender: TObject);
    /// <summary> Schliesst BitmMap, befreit GameEngine, Schliesst Form</summary>
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    /// <summary> liest WASD ein und ruft passend FGameEngine.Input auf</summary>
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    FGameEngine: TGameEngine;
    FBitmapBackground: TBitmap;
    /// <summary> Zeichnet Rechteck an eine Bestimme Koordinate</summary>
    procedure FillTile(Canvas: TCanvas; X, Y: Integer; Offset: Integer = 0);
    //procedure FillEyes(Canvas: TCanvas; X, Y: Integer;
    /// <summary> wenn ausgeloest -> DrawScene()</summary>
    procedure GameEngineOnProcess(Sender: TObject);
    /// <summary> Beschreibt Datenbank, Oeffnet FormGameOver</summary>
    procedure GameEngineOnGameOver(Sender: TObject);
    /// <summary> Malt das Spielfeld</summary>
    procedure DrawBackground;
    /// <summary> Malt die Entitys</summary>
    procedure DrawScene;

  const
    CL_TAIL_GRADIENT: LongInt = $AA6666;

  const
    CL_TAIL: LongInt = $FFAAAA;

  const
    OFFSET_Top: Integer = 100;
  public

  end;

var
  FormSGame: TFormSGame;

implementation

{$R *.dfm}

uses
  Math, Snake.Snake;
{ TFormSGame }

procedure TFormSGame.DrawBackground;
var
  i, j: Integer;
begin
  // evtl. bestehenden Background wieder freigeben
  FreeAndNil(FBitmapBackground);
  // Neues BackgroundImage erzeugen
  FBitmapBackground := TBitmap.Create();
  // Groesse vom Image dem Spielfeld anpassen
  FBitmapBackground.Width := Settings.ColCount * Settings.CellSize;
  FBitmapBackground.Height := Settings.RowCount * Settings.CellSize;

  // Zeichnen
  with FBitmapBackground.Canvas do
  begin
    brush.Color := clblack;
    fillrect(rect(0, 0, Width, Height));
    // Waende zeichnen
    brush.Color := clgray;
    for i := 0 to Settings.ColCount - 1 do
    begin
      for j := 0 to Settings.RowCount - 1 do
        if FGameEngine.Cells[i, j] then
        begin
          FillTile(FBitmapBackground.Canvas, i, j);
        end;
    end;
  end;
end;

procedure TFormSGame.DrawScene;
var
  i: Integer;
  rTail, gTail, bTail: Byte;
  rBack, gBack, bBack: Byte;

const
  SPACING_Top : Integer = 20;
  SPACING_Left: Integer = 20;
 
begin
  with ImageScene.Canvas do
  begin
    // clear
    brush.Color := clblack;
    fillrect(rect(0, 0, Width, Height));

    // Hintergrund zeichnen
    Draw(0, OFFSET_Top, FBitmapBackground);

    // Food zeichnen
    Pen.Color := clgray;
    Font.Color := clyellow;
    brush.Color := clblack;
    Font.Size := 13;
    TextOut(FGameEngine.Food.X * Settings.CellSize,
      FGameEngine.Food.Y * Settings.CellSize + OFFSET_Top,
      FGameEngine.Food.Icon);

    // Schlangenschweif zeichnen
    rTail := CL_TAIL;
    gTail := CL_TAIL shr 8;
    bTail := CL_TAIL shr 16;

    rBack := CL_TAIL_GRADIENT;
    gBack := CL_TAIL_GRADIENT shr 8;
    bBack := CL_TAIL_GRADIENT shr 16;

    for i := 0 to FGameEngine.Snake.Tail.Count - 1 do
    begin
      brush.Color :=
        RGB(rTail - trunc((rTail - rBack) / FGameEngine.Snake.Tail.Count * i),
        gTail - trunc((gTail - gBack) / FGameEngine.Snake.Tail.Count * i),
        bTail - trunc((bTail - bBack) / FGameEngine.Snake.Tail.Count * i));
      FillTile(ImageScene.Canvas, FGameEngine.Snake.Tail[i].X,
        FGameEngine.Snake.Tail[i].Y, OFFSET_Top);
    end;

    // Schlangenkopf zeichnen
    brush.Color := cllime;
    FillTile(ImageScene.Canvas, FGameEngine.Snake.X, FGameEngine.Snake.Y,
      OFFSET_Top);

    // Schlangenaugen zeichnen
    brush.Color := clwhite;
    // ToDo // Noch voellig kaputt
    // FillEyes(ImageScene.Canvas, FGameEngine.Snake.X, FGameEngine.Snake.Y, FGameEngine.ED);
    { case FGameEngine.ED of
      edRight:
      ;
      edDown:
      ;
      edLeft:
      ;
      edUp:
      ;
      end; }

    //OFFSET_Top zeichnen
    Font.Size := 40;
    Font.Color := clwhite;
    brush.Color := clbackground;
    Font.Name := 'Small Fonts';

    TextOut(SPACING_Left, SPACING_Top, Settings.PlayerName);
    TextOut(2 * SPACING_Left + TextWidth(Settings.PlayerName), SPACING_Top,
      'Score: ' + IntToStr(FGameEngine.Score));
  end;
end;

// ToDo // Noch voellig kaputt
{procedure TFormSGame.FillEyes(Canvas: TCanvas; X, Y: Integer;
  Direction: TEntityDirection);
begin
  case Direction of
    edRight:
      Canvas.fillrect(rect(X + (X div X) * Settings.CellSize,
        Y * Settings.CellSize, (X + (2 * (X div X))) * Settings.CellSize,
        (Y + (Y div Y)) * Settings.CellSize));
    edDown:
      ;
    edLeft:
      ;
    edUp:
      ;
  end;
end; }

procedure TFormSGame.FillTile(Canvas: TCanvas; X, Y: Integer;
  Offset: Integer = 0);
begin
  Canvas.fillrect(rect(X * Settings.CellSize, Y * Settings.CellSize + Offset,
    (X + 1) * Settings.CellSize, (Y + 1) * Settings.CellSize + Offset));
end;

procedure TFormSGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FBitmapBackground);
  FGameEngine.Free;
end;

procedure TFormSGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      Close; // Todo Menue Form aufrufen
    // Pfeiltasten einlesen
    VK_RIGHT:
      FGameEngine.Input(edRight);
    VK_DOWN:
      FGameEngine.Input(edDown);
    VK_LEFT:
      FGameEngine.Input(edLeft);
    VK_UP:
      FGameEngine.Input(edUp);
  end;

end;

procedure TFormSGame.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    'd':
      FGameEngine.Input(edRight);
    's':
      FGameEngine.Input(edDown);
    'a':
      FGameEngine.Input(edLeft);
    'w':
      FGameEngine.Input(edUp);
  end;
end;

procedure TFormSGame.FormShow(Sender: TObject);
begin
  Width := Settings.ColCount * Settings.CellSize;
  Height := (Settings.RowCount * Settings.CellSize) + OFFSET_Top;

  FGameEngine := TGameEngine.Create(Settings.ColCount, Settings.RowCount);
  FGameEngine.OnProcess := GameEngineOnProcess;
  FGameEngine.OnGameOver := GameEngineOnGameOver;
  FGameEngine.PlaceFood();

  DrawBackground;
end;

procedure TFormSGame.GameEngineOnGameOver(Sender: TObject);
begin
  //Datenbank HighScores beschreiben
  DataModuleSnake.AddHighScore(Settings.PlayerName, FGameEngine.Score);
  // GameOver anzeigen und SGame mit ModalReasult schliessen
  modalResult := FormGameOver.ShowModal;
end;

procedure TFormSGame.GameEngineOnProcess(Sender: TObject);
begin
  DrawScene();
end;

end.
