object FormSGame: TFormSGame
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Snake Game'
  ClientHeight = 662
  ClientWidth = 1069
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ImageScene: TImage
    Left = 0
    Top = 0
    Width = 1069
    Height = 662
    Align = alClient
    Transparent = True
    ExplicitLeft = 584
    ExplicitTop = 400
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
end
