unit SGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Snake.GameEngine, Snake.Settings, SGameOver, Snake.Types;

type
  TFormSGame = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Spielfeld: TStringGrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    FGameEngine: TGameEngine;
    procedure FillStringGrid();
    procedure GameEngineOnProcess(Sender: TObject);
    procedure GameEngineOnGameOver(Sender: TObject);

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
  Spielfeld.Cells[FGameEngine.Snake.X, FGameEngine.Snake.Y] := 'O';
end;

procedure TFormSGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //TimerTick.Enabled := false;
  FGameEngine.Free;
end;

procedure TFormSGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Pfeiltasten einlesen
  case Key of
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
  Spielfeld.ColCount := Settings.ColCount;
  Spielfeld.RowCount := Settings.RowCount;

  FGameEngine := TGameEngine.Create(Settings.ColCount, Settings.RowCount);
  FGameEngine.OnProcess := GameEngineOnProcess;

  FGameEngine.OnGameOver := GameEngineOnGameOver;

  FGameEngine.PlaceFood();

  FillStringGrid();

  //TimerTick.Enabled := true;
end;

procedure TFormSGame.GameEngineOnGameOver(Sender: TObject);
begin
//GameOver anzeigen und SGame mot ModalReasult schliessen
  modalResult := FormGameOver.ShowModal;
end;

procedure TFormSGame.GameEngineOnProcess(Sender: TObject);
begin
  FillStringGrid();
end;

end.

