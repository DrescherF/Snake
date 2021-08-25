unit SMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridHS, Vcl.StdCtrls, Snake.settings, Snake.GameEngine,
  Vcl.ExtCtrls, SSettings;

type
  TFormSMain = class(TForm)
    ButtonStart: TButton;
    ButtonHighScores: TButton;
    ButtonClose: TButton;
    Panel1: TPanel;
    ButtonSettings: TButton;
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonSettingsClick(Sender: TObject);
  private
    FGameEngine: TGameEngine;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormSMain: TFormSMain;

implementation

{$R *.DFM}

uses
  SDialogNameEingeben, SGame;

procedure TFormSMain.ButtonSettingsClick(Sender: TObject);
var
  modalResult: Integer;
begin
  modalResult := FormSettings.ShowModal;
end;

procedure TFormSMain.ButtonStartClick(Sender: TObject);
var
  modalResult: Integer;
begin
  modalResult := FormSGame.ShowModal;
end;

procedure TFormSMain.FormDestroy(Sender: TObject);
begin
  TSettings.ReleaseInstance();
  FGameEngine.Free;
end;

procedure TFormSMain.ButtonCloseClick(Sender: TObject);
begin
  Close();
end;

end.
