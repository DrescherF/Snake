object FormScoreBoard: TFormScoreBoard
  Left = 0
  Top = 0
  Caption = 'FormScoreBoard'
  ClientHeight = 638
  ClientWidth = 635
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelBanner: TLabel
    Left = 152
    Top = 31
    Width = 313
    Height = 64
    AutoSize = False
    Caption = 'Leaderboard'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -53
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object PanelGrid: TPanel
    Left = 104
    Top = 112
    Width = 377
    Height = 353
    BevelOuter = bvNone
    TabOrder = 0
  end
end
