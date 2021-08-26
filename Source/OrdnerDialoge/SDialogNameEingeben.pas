unit SDialogNameEingeben;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormSDialogNameEingeben = class(TForm)
    EditNameEingeben: TEdit;
    ButtonSpielStart: TButton;
    LabelBanner: TLabel;
    procedure ButtonSpielStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormSDialogNameEingeben: TFormSDialogNameEingeben;

implementation

uses
  SGame, Snake.settings;

{$R *.dfm}

procedure TFormSDialogNameEingeben.ButtonSpielStartClick(Sender: TObject);
begin
  if (trim(EditNameEingeben.Text) <> '') then
  begin
    settings.PlayerName := EditNameEingeben.Text;
    Close;
    FormSGame.ShowModal;
  end;
end;

procedure TFormSDialogNameEingeben.FormShow(Sender: TObject);
begin
  EditNameEingeben.Text := settings.PlayerName;
end;

end.
