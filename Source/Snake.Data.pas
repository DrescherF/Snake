unit Snake.Data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDataModuleSnake = class(TDataModule)
    /// <summary> Speichert Nr. Name Score und Datum jedes abgeschlossenen Spiels</summary>
    ClientDataSetHighScores: TClientDataSet;
    DataSourceHighScores: TDataSource;

    /// <summary> Erstellt ein Data Module</summary>
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    /// <summary> Fuegt einen Datensatz zum ClientDataSetHighScores hinzu</summary>
    procedure AddHighScore(Name: String; HighScore: Integer);
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
