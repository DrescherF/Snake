unit SHighScores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Snake.Data,
  Vcl.ExtCtrls;

type
  THackedDBGrid = class(TDBGrid)
  private
    procedure UpdateScrollBar; override;
  end;

type
  TFormScoreBoard = class(TForm)
    LabelBanner: TLabel;
    PanelGrid: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FHackeDBGrid: THackedDBGrid;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormScoreBoard: TFormScoreBoard;

implementation

{$R *.dfm}

procedure TFormScoreBoard.FormCreate(Sender: TObject);
begin
  FHackeDBGrid := THackedDBGrid.Create(PanelGrid);
  FHackeDBGrid.Parent := PanelGrid;

  FHackeDBGrid.Align := AlClient;
  FHackeDBGrid.DataSource := DataModuleSnake.DataSourceHighScores;

end;

procedure TFormScoreBoard.FormShow(Sender: TObject);
begin

end;


{ THackedDBGrid }

procedure THackedDBGrid.UpdateScrollBar;
begin
  // Nothing to do here...
end;

end.
