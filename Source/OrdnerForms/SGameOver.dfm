object FormGameOver: TFormGameOver
  Left = 0
  Top = 0
  Caption = 'FormGameOver'
  ClientHeight = 470
  ClientWidth = 745
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LabelGameOver: TLabel
    Left = 168
    Top = 112
    Width = 417
    Height = 57
    AutoSize = False
    Caption = 'G A M E   O V E R'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -53
    Font.Name = 'Small Fonts'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BackToMain: TButton
    Left = 272
    Top = 295
    Width = 200
    Height = 50
    Caption = 'Back to Main Menu'
    TabOrder = 0
    OnClick = BackToMainClick
  end
end
