unit SHighScores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Snake.Data,
  Vcl.ExtCtrls;

type
  THackedDBGrid = class(TDBGrid)
  protected
    procedure UpdateScrollBar; override;
  end;

type
  TFormScoreBoard = class(TForm)
    LabelBanner: TLabel;
    PanelGrid: TPanel;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    FHackeDBGrid: THackedDBGrid;
    procedure HagridDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
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
  FHackeDBGrid.Enabled := False;

  FHackeDBGrid.Options := [dgTitles,dgColumnResize,dgTabs,dgConfirmDelete,dgCancelOnExit];

  FHackeDBGrid.Columns[0].Visible := false;
  FHackeDBGrid.Columns[3].Visible := false;

  FHackeDBGrid.OnDrawDataCell := HagridDrawDataCell;
end;

procedure TFormScoreBoard.HagridDrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
begin
  FHackeDBGrid.Canvas.Brush.Color := clblack;
  FHackeDBGrid.Canvas.Font.Color := clWhite;
  FHackeDBGrid.DefaultDrawDataCell(Rect, Field, State);
end;

{ THackedDBGrid }

procedure THackedDBGrid.UpdateScrollBar;
begin
  // Nothing to do here...
end;

end.
