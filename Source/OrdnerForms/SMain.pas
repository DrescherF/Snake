unit SMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridHS, Vcl.StdCtrls, Snake.settings, Snake.GameEngine,
  Vcl.ExtCtrls, SSettings, SHighScores;

type
  TFormSMain = class(TForm)
    /// <summary> ButtonStartClick</summary>
    ButtonStart: TButton;
    /// <summary> ButtonHighScoresClick</summary>
    ButtonHighScores: TButton;
    /// <summary> Beendet bei Click das Programm</summary>
    ButtonClose: TButton;
    /// <summary> Bereich fuer Buttons</summary>
    Panel1: TPanel;
    /// <summary> ruft bei Click FormSettings auf</summary>
    ButtonSettings: TButton;
    /// <summary> Ueberschrift 'Snake Game'</summary>
    LabelBanner: TLabel;


    procedure FormDestroy(Sender: TObject);
    /// <summary> ruft FormSDialogNameEingeben auf</summary>
    procedure ButtonStartClick(Sender: TObject);
    /// <summary> Beendet das Programm</summary>
    procedure ButtonCloseClick(Sender: TObject);
    /// <summary> ruft FormSettings auf</summary>
    procedure ButtonSettingsClick(Sender: TObject);
    /// <summary> ruft FormScoreBoard auf</summary>
    procedure ButtonHighScoresClick(Sender: TObject);
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
  SDialogNameEingeben;

procedure TFormSMain.ButtonHighScoresClick(Sender: TObject);
begin
  FormScoreBoard.Show;
end;

procedure TFormSMain.ButtonSettingsClick(Sender: TObject);
begin
  FormSettings.ShowModal;
end;

procedure TFormSMain.ButtonStartClick(Sender: TObject);
begin
  FormSDialogNameEingeben.ShowModal;
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
