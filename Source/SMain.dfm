object FormSMain: TFormSMain
  Left = 0
  Top = 0
  ActiveControl = ButtonStart
  Caption = 'FormSMain'
  ClientHeight = 486
  ClientWidth = 384
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 88
    Top = 43
    Width = 200
    Height = 400
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object ButtonClose: TButton
      Left = 0
      Top = 350
      Width = 200
      Height = 50
      Align = alBottom
      Caption = 'ButtonClose'
      TabOrder = 3
      OnClick = ButtonCloseClick
    end
    object ButtonHighScores: TButton
      Left = 0
      Top = 50
      Width = 200
      Height = 50
      Align = alTop
      Caption = 'ButtonHighScores'
      TabOrder = 1
    end
    object ButtonStart: TButton
      Left = 0
      Top = 0
      Width = 200
      Height = 50
      Align = alTop
      Caption = 'ButtonStart'
      TabOrder = 0
      OnClick = ButtonStartClick
    end
    object ButtonSettings: TButton
      Left = 0
      Top = 300
      Width = 200
      Height = 50
      Align = alBottom
      Caption = 'ButtonSettings'
      TabOrder = 2
      OnClick = ButtonSettingsClick
    end
  end
end
