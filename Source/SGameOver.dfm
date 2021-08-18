object FormGameOver: TFormGameOver
  Left = 0
  Top = 0
  Caption = 'FormGameOver'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelGameOver: TLabel
    Left = 264
    Top = 112
    Width = 54
    Height = 13
    Caption = 'Game Over'
  end
  object BackToMain: TButton
    Left = 296
    Top = 200
    Width = 75
    Height = 25
    Caption = 'BackToMain'
    TabOrder = 0
    OnClick = BackToMainClick
  end
end
