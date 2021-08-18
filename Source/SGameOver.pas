unit SGameOver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SMain;

type
  TFormGameOver = class(TForm)
    LabelGameOver: TLabel;
    BackToMain: TButton;
    procedure BackToMainClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormGameOver: TFormGameOver;

implementation

{$R *.dfm}

procedure TFormGameOver.BackToMainClick(Sender: TObject);
begin
  Close;
  FormSMain.Show;
end;

end.
