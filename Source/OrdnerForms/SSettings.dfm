object FormSettings: TFormSettings
  Left = 0
  Top = 0
  Caption = 'FormSettings'
  ClientHeight = 658
  ClientWidth = 479
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
    Left = 128
    Top = 8
    Width = 217
    Height = 66
    Align = alCustom
    AutoSize = False
    Caption = 'Settings'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -53
    Font.Name = 'Small Fonts'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PanelSpielfeldGroesseSettings: TPanel
    Left = 40
    Top = 104
    Width = 400
    Height = 49
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
      Caption = 'Level Size:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Small Fonts'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object NumberBoxColCount: TNumberBox
      Left = 238
      Top = 25
      Width = 81
      Height = 24
      Align = alRight
      Enabled = False
      MinValue = 24.000000000000000000
      MaxValue = 96.000000000000000000
      TabOrder = 0
      Value = 24.000000000000000000
      ExplicitHeight = 21
    end
    object NumberBoxRowCount: TNumberBox
      Left = 319
      Top = 25
      Width = 81
      Height = 24
      Align = alRight
      Enabled = False
      MinValue = 12.000000000000000000
      MaxValue = 48.000000000000000000
      TabOrder = 1
      Value = 12.000000000000000000
      ExplicitLeft = 280
      ExplicitTop = 38
      ExplicitHeight = 21
    end
    object ComboBoxSpielfeld: TComboBox
      Left = 0
      Top = 25
      Width = 137
      Height = 21
      Align = alLeft
      Style = csDropDownList
      TabOrder = 2
      OnChange = ComboBoxSpielfeldChange
      Items.Strings = (
        'Klein'
        'Mittel '
        'Gro'#223
        'Riesig'
        'Benutzerdefiniert')
    end
  end
  object PanelStartWerte: TPanel
    Left = 40
    Top = 176
    Width = 400
    Height = 201
    BevelOuter = bvNone
    TabOrder = 1
    object LabelStartWerte: TLabel
      Left = 0
      Top = 0
      Width = 400
      Height = 25
      Align = alTop
      AutoSize = False
      Caption = 'Difficulty:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Small Fonts'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PanelTailLength: TPanel
      Left = 0
      Top = 121
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
        Caption = 'Snake Length at Start:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Small Fonts'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 6
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
        Min = 1
        Position = 4
        TabOrder = 0
        OnChange = TrackBarTailLengthChange
      end
    end
    object PanelInitialGameSpeed: TPanel
      Left = 0
      Top = 41
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
        Caption = 'Speed at Start:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Small Fonts'
        Font.Style = []
        ParentFont = False
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
        Min = 1
        Position = 4
        TabOrder = 0
        OnChange = TrackBarInitialGameSpeedChange
      end
    end
  end
  object ButtonSettingsUebernehmen: TButton
    Left = 40
    Top = 565
    Width = 180
    Height = 40
    Caption = 'Confirm Settings'
    TabOrder = 2
    OnClick = ButtonSettingsUebernehmenClick
  end
  object ButtonCancel: TButton
    Left = 260
    Top = 565
    Width = 180
    Height = 40
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
end
