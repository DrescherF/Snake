unit SDialogNameEingeben;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormSDialogNameEingeben = class(TForm)

    /// <summary> Edit zum Namen Eingeben, der im Spiel Angezeigt wird und der mit dem Score gespeicher wird</summary>
    EditNameEingeben: TEdit;
    /// <summary> ButtonSpielStartClick</summary>
    ButtonSpielStart: TButton;
    /// <summary> Ueberschrift der Form</summary>
    LabelBanner: TLabel;

    /// <summary> ruft FormSGame auf</summary>
    procedure ButtonSpielStartClick(Sender: TObject);
    /// <summary> Erstellt Form. Gibt letzten PlayerName in EditNameEingeben an</summary>
    procedure FormShow(Sender: TObject);
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
