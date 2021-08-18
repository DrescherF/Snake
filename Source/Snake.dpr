program Snake;

uses
  Vcl.Forms,
  SMain in 'SMain.pas' {FormSMain},
  SDialogNameEingeben in 'SDialogNameEingeben.pas' {FormSDialogNameEingeben},
  SGame in 'SGame.pas' {FormSGame},
  Snake.GameEngine in 'Snake.GameEngine.pas',
  Snake.settings in 'Snake.settings.pas',
  SGameOver in 'SGameOver.pas' {FormGameOver};

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
