unit SSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.NumberBox;

type
  TFormSettings = class(TForm)
    /// <summary> Ueberschrift der Form</summary>
    LabelHeadlineSettings: TLabel;
    /// <summary> Ueberschrift Bereich Startwerte</summary>
    LabelStartWerte: TLabel;
    /// <summary> Bereich Startwerte</summary>
    PanelStartWerte: TPanel;

    /// <summary> Einsellung Spielgeschwindigkeit</summary>
    TrackBarInitialGameSpeed: TTrackBar;
    LabelInitialGamesSpeed: TLabel;
    PanelInitialGameSpeed: TPanel;
    LabelTrackbarInitialGameSpeed: TLabel;

    /// <summary> Einstellung Schweiflaenge zu Beginn des Spiels</summary>
    TrackBarTailLength: TTrackBar;
    LabelTailLength: TLabel;
    PanelTailLength: TPanel;
    LabelTrackBarTailLength: TLabel;

    /// <summary> Einstellung Spielfeldgroesse (Hoehe und Breite)</summary>
    LabelSpielfeldGroesse: TLabel;
    PanelSpielfeldGroesseSettings: TPanel;
    NumberBoxColCount: TNumberBox;
    NumberBoxRowCount: TNumberBox;
    ComboBoxSpielfeld: TComboBox;

    /// <summary> ButtonSettingsUebernehmenClick</summary>
    ButtonSettingsUebernehmen: TButton;
    /// <summary> ButtonCancelClick</summary>
    ButtonCancel: TButton;
    /// <summary> ButtonStandartWerteClick</summary>
    ButtonStandartWerte: TButton;

    /// <summary> Schliesst die Form ohne die Eintellungen zu Uebernehmen</summary>
    procedure ButtonCancelClick(Sender: TObject);
    /// <summary> Schliesst die Form und speichert die Einstellungen, sodass sie beim naechsten Spielstart angewandt werden</summary>
    procedure ButtonSettingsUebernehmenClick(Sender: TObject);
    /// <summary> Stellt Einstellungen in Labels und Trackbars ein, wenn bereits vorhanden</summary>
    procedure FormShow(Sender: TObject);
    /// <summary> Combobox fuer Auswahl verschiedener Vorgegebener Spielfeldgroessen</summary>
    procedure ComboBoxSpielfeldChange(Sender: TObject);
    /// <summary> Zwischen 10 verschiedenen Spielgeschwindigkeiten zu waehlen</summary>
    procedure TrackBarInitialGameSpeedChange(Sender: TObject);
    /// <summary> Laenge der Schlange zu beginn des Spiels zwischen 1 und 10 zu bestimmen</summary>
    procedure TrackBarTailLengthChange(Sender: TObject);
    /// <summary> Voreingestellte Standartwerte einstellen (wird noch nicht gespeichert)</summary>
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
