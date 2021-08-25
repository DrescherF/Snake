object FormSettings: TFormSettings
  Left = 0
  Top = 0
  Caption = 'FormSettings'
  ClientHeight = 637
  ClientWidth = 611
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelHeadlineSettings: TLabel
    Left = 184
    Top = 8
    Width = 105
    Height = 13
    Caption = 'LabelHeadlineSettings'
  end
  object PanelSpielfeldGroesseSettings: TPanel
    Left = 40
    Top = 57
    Width = 400
    Height = 200
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object LabelSpielfeldGroesse: TLabel
      Left = 0
      Top = 0
      Width = 400
      Height = 25
      Align = alTop
      AutoSize = False
      Caption = 'Spielfeld Gr'#246#223'e:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PanelColCount: TPanel
      Left = 0
      Top = 40
      Width = 400
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 20
      object LabelColCount: TLabel
        Left = 256
        Top = 13
        Width = 144
        Height = 67
        Align = alRight
        AutoSize = False
        Caption = 'LabelColCount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LabelTrackbarColCount: TLabel
        Left = 0
        Top = 0
        Width = 400
        Height = 13
        Align = alTop
        AutoSize = False
        Caption = 'Breite:'
        ExplicitTop = -6
      end
      object TrackBarColCount: TTrackBar
        Left = 0
        Top = 13
        Width = 233
        Height = 67
        Align = alLeft
        Max = 9
        Position = 5
        TabOrder = 0
        ExplicitTop = 19
      end
    end
    object PanelPaneRowCount: TPanel
      Left = 0
      Top = 120
      Width = 400
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 100
      object LabelTrackbarRowCount: TLabel
        Left = 0
        Top = 0
        Width = 400
        Height = 13
        Align = alTop
        Caption = 'H'#246'he:'
        ExplicitWidth = 29
      end
      object LabelRowCount: TLabel
        Left = 256
        Top = 13
        Width = 144
        Height = 67
        Align = alRight
        AutoSize = False
        Caption = 'LabelRowCount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitHeight = 80
      end
      object TrackBarRowCount: TTrackBar
        Left = 0
        Top = 13
        Width = 233
        Height = 67
        Align = alLeft
        Max = 9
        Position = 5
        TabOrder = 0
      end
    end
  end
  object PanelStartWerte: TPanel
    Left = 40
    Top = 283
    Width = 400
    Height = 200
    BevelOuter = bvNone
    TabOrder = 1
    object LabelStartWerte: TLabel
      Left = 0
      Top = 0
      Width = 400
      Height = 25
      Align = alTop
      AutoSize = False
      Caption = 'Start Werte:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PanelTailLength: TPanel
      Left = 0
      Top = 120
      Width = 400
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      Caption = ''
      TabOrder = 1
      ExplicitTop = 260
      object LabelTrackBarTailLength: TLabel
        Left = 0
        Top = 0
        Width = 400
        Height = 13
        Align = alTop
        AutoSize = False
        Caption = 'Schlangenl'#228'nge zum Start'
        ExplicitLeft = 40
        ExplicitTop = 67
        ExplicitWidth = 31
      end
      object LabelTailLength: TLabel
        Left = 256
        Top = 13
        Width = 144
        Height = 67
        Align = alRight
        AutoSize = False
        Caption = 'LabelTailLength'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object TrackBarTailLength: TTrackBar
        Left = 0
        Top = 13
        Width = 233
        Height = 67
        Align = alLeft
        Max = 9
        Position = 4
        TabOrder = 0
      end
    end
    object PanelInitialGameSpeed: TPanel
      Left = 0
      Top = 40
      Width = 400
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 180
      object LabelTrackbarInitialGameSpeed: TLabel
        Left = 0
        Top = 0
        Width = 400
        Height = 13
        Align = alTop
        AutoSize = False
        Caption = 'Startgeschwindigkeit:'
        ExplicitTop = -6
      end
      object LabelInitialGamesSpeed: TLabel
        Left = 256
        Top = 13
        Width = 144
        Height = 67
        Align = alRight
        AutoSize = False
        Caption = 'LabelInitialGamesSpeed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object TrackBarInitialGameSpeed: TTrackBar
        Left = 0
        Top = 13
        Width = 233
        Height = 67
        Align = alLeft
        Max = 9
        Position = 4
        TabOrder = 0
      end
    end
  end
  object ButtonSettingsUebernehmen: TButton
    Left = 40
    Top = 509
    Width = 180
    Height = 40
    Caption = 'ButtonSettingsUebernehmen'
    TabOrder = 2
    OnClick = ButtonSettingsUebernehmenClick
  end
  object ButtonCancel: TButton
    Left = 260
    Top = 509
    Width = 180
    Height = 40
    Caption = 'ButtonCancel'
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
end
