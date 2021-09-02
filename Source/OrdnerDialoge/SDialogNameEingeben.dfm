object FormSDialogNameEingeben: TFormSDialogNameEingeben
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Snake Game Name Eintragen'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelBanner: TLabel
    Left = 120
    Top = 64
    Width = 321
    Height = 65
    AutoSize = False
    Caption = 'Type in Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -53
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object EditNameEingeben: TEdit
    Left = 120
    Top = 149
    Width = 225
    Height = 21
    MaxLength = 10
    TabOrder = 0
    TextHint = 'Name Eingeben'
  end
  object ButtonSpielStart: TButton
    Left = 359
    Top = 147
    Width = 82
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = ButtonSpielStartClick
  end
end
