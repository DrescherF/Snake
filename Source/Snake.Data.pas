unit Snake.Data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDataModuleSnake = class(TDataModule)
    ClientDataSetHighScores: TClientDataSet;
    DataSourceHighScores: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure AddHighScore(Name: String; HighScore: Integer);
    { Public-Deklarationen }
  end;

var
  DataModuleSnake: TDataModuleSnake;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TDataModuleSnake.AddHighScore(Name: String; HighScore: Integer);
begin
  ClientDataSetHighScores.Append;
  ClientDataSetHighScores.FieldByName('Name').AsString := Name;
  ClientDataSetHighScores.FieldByName('Score').AsInteger := HighScore;
  ClientDataSetHighScores.FieldByName('Date').AsDateTime := Now;
  ClientDataSetHighScores.Post;
end;

procedure TDataModuleSnake.DataModuleCreate(Sender: TObject);
begin
  ClientDataSetHighScores.FileName := ExtractFilePath(ParamStr(0)) + 'HighScores.xml';

  if not FileExists(ClientDataSetHighScores.FileName)  then
  begin
    ClientDataSetHighScores.CreateDataSet;
  end
  else
  begin
    ClientDataSetHighScores.LoadFromFile()
  end;
end;

procedure TDataModuleSnake.DataModuleDestroy(Sender: TObject);
begin
  ClientDataSetHighScores.SaveToFile();
end;

end.
