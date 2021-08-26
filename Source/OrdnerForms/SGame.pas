unit SGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Snake.GameEngine, Snake.Settings, SGameOver, Snake.Types;

type
  TFormSGame = class(TForm)
    ImageBackground: TImage;
    ImageScene: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    FGameEngine: TGameEngine;
    procedure FillTile(Canvas: TCanvas; X, Y: Integer);
    procedure FillEyes(Canvas: TCanvas; X, Y: Integer; Direction: TEntityDirection);
    procedure GameEngineOnProcess(Sender: TObject);
    procedure GameEngineOnGameOver(Sender: TObject);
    procedure DrawBackground;
    procedure DrawScene;
    const CL_TAIL_GRADIENT: LongInt = $AA6666;
    const CL_TAIL: LongInt = $FFAAAA;
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
  with ImageBackground.Canvas do
  begin
    brush.Color := clblack;
    fillrect(rect(0, 0, width, height));
    // waende zeichnen
    brush.Color := clgray;
    for i := 0 to Settings.ColCount - 1 do
    begin
      for j := 0 to Settings.RowCount - 1 do
        if FGameEngine.Cells[i, j] then
        begin
          FillTile(ImageBackground.Canvas, i, j);
        end;
    end;
  end;
end;

procedure TFormSGame.DrawScene;
var
  i: Integer;
  rTail, gTail, bTail: Byte;
  rBack, gBack, bBack: Byte;
begin
  with ImageScene.Canvas do
  begin
    // clear
    brush.Color := clFuchsia;
    fillrect(rect(0, 0, width, height));

    // Food zeichnen
    Pen.Color := clgray;
    Font.Color := clyellow;
    brush.Color := clblack;
    Font.Size := 13;
    TextOut(FGameEngine.Food.X * Settings.CellSize,
      FGameEngine.Food.Y * Settings.CellSize, FGameEngine.Food.Icon);

    // Schlangenschweif zeichnen

    rTail := CL_TAIL;
    gTail := CL_TAIL shr 8;
    bTail := CL_TAIL shr 16;

    rBack := CL_TAIL_GRADIENT;
    gBack := CL_TAIL_GRADIENT shr 8;
    bBack := CL_TAIL_GRADIENT shr 16;

    for i := 0 to FGameEngine.Snake.Tail.Count - 1 do
    begin
      Brush.Color := RGB(
        rTail - trunc((rTail - rBack) / FGameEngine.Snake.Tail.Count * i),
        gTail - trunc((gTail - gBack) / FGameEngine.Snake.Tail.Count * i),
        bTail - trunc((bTail - bBack) / FGameEngine.Snake.Tail.Count * i)
      );
      FillTile(ImageScene.Canvas, FGameEngine.Snake.Tail[i].X,
        FGameEngine.Snake.Tail[i].Y);
    end;
    
    // Schlangenkopf zeichnen
    brush.Color := cllime;
    FillTile(ImageScene.Canvas, FGameEngine.Snake.X, FGameEngine.Snake.Y);

    // Schlangenaugen zeichnen

  end;
end;


procedure TFormSGame.FillTile(Canvas: TCanvas; X, Y: Integer);
begin
  Canvas.fillrect(rect(X * Settings.CellSize, Y * Settings.CellSize,
    (X + 1) * Settings.CellSize, (Y + 1) * Settings.CellSize));
end;

procedure TFormSGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // TimerTick.Enabled := false;
  FGameEngine.Free;
end;

procedure TFormSGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Pfeiltasten einlesen
  case Key of
    VK_ESCAPE:
      Close; // Todo Menue Form aufrufen
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

  width := Settings.ColCount * Settings.CellSize;
  height := Settings.RowCount * Settings.CellSize;

  FGameEngine := TGameEngine.Create(Settings.ColCount, Settings.RowCount);
  DrawBackground;
  FGameEngine.OnProcess := GameEngineOnProcess;

  FGameEngine.OnGameOver := GameEngineOnGameOver;

  FGameEngine.PlaceFood();
end;

procedure TFormSGame.GameEngineOnGameOver(Sender: TObject);
begin
  // GameOver anzeigen und SGame mot ModalReasult schliessen
  modalResult := FormGameOver.ShowModal;
end;

procedure TFormSGame.GameEngineOnProcess(Sender: TObject);
begin
  DrawScene();
end;

end.
