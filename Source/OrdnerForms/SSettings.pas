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
    ButtonStandartWerte: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSettingsUebernehmenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBoxSpielfeldChange(Sender: TObject);
    procedure TrackBarInitialGameSpeedChange(Sender: TObject);
    procedure TrackBarTailLengthChange(Sender: TObject);
    procedure ButtonStandartWerteClick(Sender: TObject);
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
begin


  settings.ColCount := round(NumberBoxColCount.Value);
  Settings.RowCount := round(NumberBoxRowCount.Value);

  Settings.InitialGameSpeed := TrackBarInitialGameSpeed.Position;
  Settings.InitialTailLenght := TrackBarTailLength.Position;

  Close;
end;

procedure TFormSettings.ButtonStandartWerteClick(Sender: TObject);
begin
  ComboBoxSpielfeld.ItemIndex := 2;
  NumberBoxColCount.Value := Settings.DEFAULT_COLCOUNT;
  NumberBoxRowCount.Value := Settings.DEFAULT_ROWCOUNT;

  TrackBarInitialGameSpeed.Position := Settings.DEFAULT_GAMESPEED;
  TrackBarTailLength.Position := Settings.DEFAULT_TAILLENGHT;
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
begin
  NumberBoxColCount.Value := Settings.ColCount;
  NumberBoxRowCount.Value := Settings.RowCount;

  TrackBarInitialGameSpeed.Position := Settings.InitialGameSpeed;
  TrackBarTailLength.Position := Settings.InitialTailLenght;
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
