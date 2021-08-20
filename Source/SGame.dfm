object FormSGame: TFormSGame
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'FormSGame'
  ClientHeight = 861
  ClientWidth = 1584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 280
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 648
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 960
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 1600
    Height = 800
    Caption = 'Panel1'
    TabOrder = 0
    object Spielfeld: TStringGrid
      Left = 1
      Top = 1
      Width = 1598
      Height = 798
      Align = alClient
      DefaultColWidth = 20
      DefaultRowHeight = 20
      Enabled = False
      FixedCols = 0
      FixedRows = 0
      TabOrder = 0
    end
  end
end
