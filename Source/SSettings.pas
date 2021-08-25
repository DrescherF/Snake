unit SSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TFormSettings = class(TForm)
    TrackBarColCount: TTrackBar;
    TrackBarRowCount: TTrackBar;
    TrackBarInitialGameSpeed: TTrackBar;
    TrackBarTailLength: TTrackBar;
    LabelHeadlineSettings: TLabel;
    LabelTrackbarColCount: TLabel;
    LabelTrackbarRowCount: TLabel;
    LabelTrackBarTailLength: TLabel;
    LabelInitialGamesSpeed: TLabel;
    LabelColCount: TLabel;
    LabelRowCount: TLabel;
    LabelStartWerte: TLabel;
    LabelTrackbarInitialGameSpeed: TLabel;
    PanelSpielfeldGroesseSettings: TPanel;
    PanelColCount: TPanel;
    PanelPaneRowCount: TPanel;
    LabelSpielfeldGroesse: TLabel;
    PanelStartWerte: TPanel;
    PanelInitialGameSpeed: TPanel;
    PanelTailLength: TPanel;
    LabelTailLength: TLabel;
    ButtonSettingsUebernehmen: TButton;
    ButtonCancel: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSettingsUebernehmenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormSettings: TFormSettings;

implementation

uses
  Snake.settings;

{$R *.dfm}

procedure TFormSettings.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSettings.ButtonSettingsUebernehmenClick(Sender: TObject);
var
  variable: Integer;
begin
  variable := TrackBarColCount.Position;
  settings.ini.WriteInteger('SpielfeldGroesse', 'ColCount', variable);

  variable := TrackBarRowCount.Position;
  settings.ini.WriteInteger('SpielfeldGroesse', 'RowCount', variable);

  variable := TrackBarInitialGameSpeed.Position + 1;
  settings.ini.WriteInteger('StartWerte', 'InitialGamespeed', variable);

  variable := TrackBarTailLength.Position + 1;
  settings.ini.WriteInteger('StartWerte', 'TailLength', variable);

  settings.Refresh;
  Close;
end;

procedure TFormSettings.FormShow(Sender: TObject);
var
  variable: Integer;
begin
  variable := settings.ini.ReadInteger('SpielfeldGroesse', 'ColCount', 4);
  TrackBarColCount.Position := variable;

  variable := settings.ini.ReadInteger('SpielfeldGroesse', 'RowCount', 4);
  TrackBarColCount.Position := variable;

  variable := settings.ini.ReadInteger('StartWerte', 'InitialGamespeed', 4);
  TrackBarInitialGameSpeed.Position := variable + 1;

  variable := settings.ini.ReadInteger('StartWerte', 'TailLength', 3);
  TrackBarTailLength.Position := variable + 1;
end;

end.
