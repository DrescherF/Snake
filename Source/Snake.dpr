program Snake;

uses
  Vcl.Forms,
  SMain in 'SMain.pas' {FormSMain},
  SDialogNameEingeben in 'SDialogNameEingeben.pas' {FormSDialogNameEingeben},
  SGame in 'SGame.pas' {FormSGame},
  Snake.GameEngine in 'Snake.GameEngine.pas',
  Snake.settings in 'Snake.settings.pas',
  SGameOver in 'SGameOver.pas' {FormGameOver},
  Snake.Types in 'Snake.Types.pas',
  Snake.Snake in 'Snake.Snake.pas',
  Snake.Entity in 'Snake.Entity.pas',
  Snake.Food in 'Snake.Food.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSMain, FormSMain);
  Application.CreateForm(TFormSDialogNameEingeben, FormSDialogNameEingeben);
  Application.CreateForm(TFormSGame, FormSGame);
  Application.CreateForm(TFormGameOver, FormGameOver);
  Application.Run;
end.
