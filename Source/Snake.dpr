program Snake;

uses
  Vcl.Forms,
  SMain in 'OrdnerForms\SMain.pas' {FormSMain},
  SDialogNameEingeben in 'OrdnerDialoge\SDialogNameEingeben.pas' {FormSDialogNameEingeben},
  SGame in 'OrdnerForms\SGame.pas' {FormSGame},
  Snake.GameEngine in 'Snake.GameEngine.pas',
  Snake.settings in 'Snake.settings.pas',
  SGameOver in 'OrdnerForms\SGameOver.pas' {FormGameOver},
  Snake.Types in 'Snake.Types.pas',
  Snake.Snake in 'Snake.Snake.pas',
  Snake.Entity in 'Snake.Entity.pas',
  Snake.Food in 'Snake.Food.pas',
  SSettings in 'OrdnerForms\SSettings.pas' {FormSettings},
  SHighScores in 'OrdnerForms\SHighScores.pas' {FormScoreBoard},
  Snake.Data in 'Snake.Data.pas' {DataModuleSnake: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleSnake, DataModuleSnake);
  Application.CreateForm(TFormSMain, FormSMain);
  Application.CreateForm(TFormSDialogNameEingeben, FormSDialogNameEingeben);
  Application.CreateForm(TFormSGame, FormSGame);
  Application.CreateForm(TFormGameOver, FormGameOver);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TFormScoreBoard, FormScoreBoard);
  Application.Run;
end.
