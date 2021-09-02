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
    /// <summary> Entfernt die Scroll Bar aus dem DBGrid</summary>
    procedure UpdateScrollBar; override;
  end;

type
  TFormScoreBoard = class(TForm)

    /// <summary> Ueberschrift der Form</summary>
    LabelBanner: TLabel;
    /// <summary> Bereich fuer FHackeDBGrid</summary>
    PanelGrid: TPanel;
    /// <summary> Referenz DBGrid fuer die Einstellungen des FHackeDBGrid</summary>
    DBGrid1: TDBGrid;
    /// <summary> Eintellunen duer das HackeDBGrid hier</summary>
    procedure FormCreate(Sender: TObject);
  private
    FHackeDBGrid: THackedDBGrid;
    /// <summary> HackeDBGrid bekommt Dark Mode</summary>
    procedure HagridDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
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
  Self.ScrollBars := ssNone;
end;

end.
