unit SGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Snake.GameEngine, Snake.Settings, SGameOver;

type
  TFormSGame = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Spielfeld: TStringGrid;
    TimerTick: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure TimerTickTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);

  private
    FGameEngine: TGameEngine;
    procedure FillStringGrid();

  var
    Direction: Integer;
  public

  end;

var
  FormSGame: TFormSGame;

implementation

{$R *.dfm}
{ TFormSGame }

procedure TFormSGame.FillStringGrid;
var
  i, j: Integer;

begin
  for i := 0 to Spielfeld.ColCount - 1 do
  begin
    for j := 0 to Spielfeld.RowCount - 1 do
    begin
      case (FGameEngine.Cells[i, j]) of
        1:Spielfeld.Cells[i, j] := 'X';
        2:Spielfeld.Cells[i, j]:= 'O';
        0:Spielfeld.Cells[i, j] := '';
      end;
    end;
  end;
end;

procedure TFormSGame.FormDestroy(Sender: TObject);
begin
  FGameEngine.Free;
end;

procedure TFormSGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_RIGHT then
  begin
    Direction := 0;
  end
  else if Key = VK_DOWN then
  begin
    Direction := 1;
  end
  else if Key = VK_LEFT then
  begin
    Direction := 2;
  end
  else if Key = VK_UP then
  begin
    Direction := 3;
  end;
end;

procedure TFormSGame.FormShow(Sender: TObject);
begin
  Spielfeld.ColCount := Settings.ColCount;
  Spielfeld.RowCount := Settings.RowCount;

  FGameEngine := TGameEngine.Create(Settings.ColCount, Settings.RowCount);

  FGameEngine.SnakeX := Settings.StartX;
  FGameEngine.SnakeY := Settings.StartY;
  FGameEngine.SnakeLives := true;
  FGameEngine.Snake();

  FillStringGrid();

  TimerTick.Enabled := true;
end;

procedure TFormSGame.TimerTickTimer(Sender: TObject);
var
  modalResult: Integer;
begin
  if FGameEngine.SnakeLives then
  begin
    case Direction of
      0:
        FGameEngine.SnakeMoveRight();
      1:
        FGameEngine.SnakeMoveDown();
      2:
        FGameEngine.SnakeMoveLeft();
      3:
        FGameEngine.SnakeMoveUp();
    end;
    FillStringGrid();
  end
  else
  begin
    TimerTick.Enabled := false;
    Close;
    modalResult := FormGameOver.ShowModal;
  end;
end;

end.
