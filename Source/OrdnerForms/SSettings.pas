unit SSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.NumberBox;

type
  TFormSettings = class(TForm)
    TrackBarInitialGameSpeed: TTrackBar;
    TrackBarTailLength: TTrackBar;
    LabelHeadlineSettings: TLabel;
    LabelTrackBarTailLength: TLabel;
    LabelInitialGamesSpeed: TLabel;
    LabelStartWerte: TLabel;
    LabelTrackbarInitialGameSpeed: TLabel;
    PanelSpielfeldGroesseSettings: TPanel;
    LabelSpielfeldGroesse: TLabel;
    PanelStartWerte: TPanel;
    PanelInitialGameSpeed: TPanel;
    PanelTailLength: TPanel;
    LabelTailLength: TLabel;
    ButtonSettingsUebernehmen: TButton;
    ButtonCancel: TButton;
    ComboBoxSpielfeld: TComboBox;
    NumberBoxColCount: TNumberBox;
    NumberBoxRowCount: TNumberBox;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSettingsUebernehmenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBoxSpielfeldChange(Sender: TObject);
    procedure TrackBarInitialGameSpeedChange(Sender: TObject);
    procedure TrackBarTailLengthChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormSettings: TFormSettings;

implementation

uses
  Snake.settings, System.SysUtils;

{$R *.dfm}

procedure TFormSettings.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSettings.ButtonSettingsUebernehmenClick(Sender: TObject);
var
  variable: Integer;
begin
  { variable := TrackBarColCount.Position;
    settings.ini.WriteInteger('SpielfeldGroesse', 'ColCount', variable);

    variable := TrackBarRowCount.Position;
    settings.ini.WriteInteger('SpielfeldGroesse', 'RowCount', variable); }

  settings.ini.WriteInteger('SpielfeldGroesse', 'ColCount', round(NumberBoxColCount.Value));
  settings.ini.WriteInteger('SpielfeldGroesse', 'RowCount', round(NumberBoxRowCount.Value));

  variable := TrackBarInitialGameSpeed.Position;
  settings.ini.WriteInteger('StartWerte', 'InitialGamespeed', variable);

  variable := TrackBarTailLength.Position;
  settings.ini.WriteInteger('StartWerte', 'TailLength', variable);

  settings.Refresh;
  Close;
end;

procedure TFormSettings.ComboBoxSpielfeldChange(Sender: TObject);
begin
  if (ComboBoxSpielfeld.ItemIndex < 4) then
  begin
    NumberBoxColCount.Value := 24 * (ComboBoxSpielfeld.ItemIndex + 1);
    NumberBoxRowCount.Value := 12 * (ComboBoxSpielfeld.ItemIndex + 1);
  end;
  NumberBoxColCount.Enabled := ComboBoxSpielfeld.ItemIndex = 4;
  NumberBoxRowCount.Enabled := NumberBoxColCount.Enabled;

end;

procedure TFormSettings.FormShow(Sender: TObject);
var
  variable: Integer;
begin
  variable := settings.ini.ReadInteger('SpielfeldGroesse', 'ColCount', 4);
  NumberBoxColCount.Value := variable;

  variable := settings.ini.ReadInteger('SpielfeldGroesse', 'RowCount', 4);
  NumberBoxRowCount.Value := variable;

  variable := settings.ini.ReadInteger('StartWerte', 'InitialGamespeed', 4);
  TrackBarInitialGameSpeed.Position := variable;

  variable := settings.ini.ReadInteger('StartWerte', 'TailLength', 3);
  TrackBarTailLength.Position := variable;
end;

procedure TFormSettings.TrackBarInitialGameSpeedChange(Sender: TObject);
begin
  LabelInitialGamesSpeed.Caption := IntToStr(TrackBarInitialGameSpeed.Position);
end;

procedure TFormSettings.TrackBarTailLengthChange(Sender: TObject);
begin
  LabelTailLength.Caption := IntToStr(TrackBarTailLength.Position);
end;

end.
