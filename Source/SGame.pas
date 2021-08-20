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
    procedure FillStringGrid();
    procedure GameEngineOnProcess(Sender: TObject);
    procedure GameEngineOnGameOver(Sender: TObject);
    procedure DrawBackground;
    procedure DrawScene;

  public

  end;

var
  FormSGame: TFormSGame;

implementation

{$R *.dfm}
{ TFormSGame }

procedure TFormSGame.DrawBackground;
var
  i, j: Integer;
begin
  with ImageBackground.Canvas do
  begin
    brush.Color := clwhite;
    fillrect(rect(0, 0, width, height));
    //waende zeichnen
    brush.Color := clblack;
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
begin
  with ImageScene.Canvas do
    begin
      //clear
      brush.Color := clFuchsia;
      fillrect(rect(0, 0, width, height));

      Pen.Color := clblack;
      brush.Color := clwhite;
      Font.Size := 13;
      TextOut(FGameEngine.Food.X * Settings.CellSize, FGameEngine.Food.Y * Settings.CellSize, FGameEngine.Food.Icon);


      //Schlangenkopf zeichnen
      brush.Color:= clred;
      FillTile(ImageScene.Canvas, FGameEngine.Snake.X, FGameEngine.Snake.Y);
    end;
end;

procedure TFormSGame.FillStringGrid;
var
  i, j: Integer;

begin {
    for i := 0 to Spielfeld.ColCount - 1 do
    begin
    for j := 0 to Spielfeld.RowCount - 1 do
    begin
    case (FGameEngine.Cells[i, j]) of
    0:
    Spielfeld.Cells[i, j] := '';
    1:
    Spielfeld.Cells[i, j] := 'F';
    2:
    Spielfeld.Cells[i, j] := 'X';
    else
    begin
    Spielfeld.Cells[i, j] := 'X';
    end;
    end;
    end;
    end;
    // essen auf das SpringGrid malen
    Spielfeld.Cells[FGameEngine.Food.X, FGameEngine.Food.Y] := FGameEngine.Food.Icon;
    // Tail auf das SpringGrid malen
    for i := 0 to FGameEngine.Snake.Tail.Count - 1 do
    begin
    Spielfeld.Cells[FGameEngine.Snake.Tail[i].X,
    FGameEngine.Snake.Tail[i].Y] := '+';
    end;
    // Schlangenkopf auf das StringGrid malen
    Spielfeld.Cells[FGameEngine.Snake.X, FGameEngine.Snake.Y] := 'O'; }
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
      FGameEngine.ED := edRight;
    VK_DOWN:
      FGameEngine.ED := edDown;
    VK_LEFT:
      FGameEngine.ED := edLeft;
    VK_UP:
      FGameEngine.ED := edUp;
  end;

end;

procedure TFormSGame.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    'd':
      FGameEngine.ED := edRight;
    's':
      FGameEngine.ED := edDown;
    'a':
      FGameEngine.ED := edLeft;
    'w':
      FGameEngine.ED := edUp;
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
