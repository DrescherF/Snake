object FormScoreBoard: TFormScoreBoard
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Snake Game Leaderboard'
  ClientHeight = 639
  ClientWidth = 391
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelBanner: TLabel
    Left = 32
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
    Left = 88
    Top = 120
    Width = 193
    Height = 489
    BevelOuter = bvNone
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = -312
    Top = 632
    Width = 320
    Height = 120
    Enabled = False
    Options = [dgTitles, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
