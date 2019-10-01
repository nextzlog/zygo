object Options: TOptions
  Left = 532
  Top = 236
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 325
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TLabel
    Left = 256
    Top = 172
    Width = 37
    Height = 13
    Caption = 'City($Q)'
  end
  object Label33: TLabel
    Left = 40
    Top = 112
    Width = 30
    Height = 13
    Caption = 'Z-Link'
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 358
    Height = 288
    ActivePage = TabSheet5
    Align = alClient
    TabOrder = 0
    object PrefTabSheet: TTabSheet
      Caption = 'Preferences'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label40: TLabel
        Left = 184
        Top = 104
        Width = 54
        Height = 13
        Caption = 'Save every'
      end
      object Label41: TLabel
        Left = 290
        Top = 104
        Width = 28
        Height = 13
        Caption = 'QSOs'
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 0
        Width = 169
        Height = 153
        Caption = 'Active bands'
        TabOrder = 0
        object act19: TCheckBox
          Left = 8
          Top = 16
          Width = 73
          Height = 17
          Caption = '1.9 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object act35: TCheckBox
          Left = 8
          Top = 32
          Width = 73
          Height = 17
          Caption = '3.5 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object act7: TCheckBox
          Left = 8
          Top = 48
          Width = 80
          Height = 17
          Caption = '7 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object act14: TCheckBox
          Left = 8
          Top = 80
          Width = 80
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object act21: TCheckBox
          Left = 8
          Top = 112
          Width = 65
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object act28: TCheckBox
          Left = 74
          Top = 16
          Width = 80
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object act50: TCheckBox
          Left = 74
          Top = 32
          Width = 80
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object act144: TCheckBox
          Left = 74
          Top = 48
          Width = 80
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object act430: TCheckBox
          Left = 74
          Top = 64
          Width = 80
          Height = 17
          Caption = '430 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
        object act1200: TCheckBox
          Left = 74
          Top = 80
          Width = 80
          Height = 17
          Caption = '1200 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
        object act2400: TCheckBox
          Left = 74
          Top = 96
          Width = 80
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 13
        end
        object act5600: TCheckBox
          Left = 74
          Top = 112
          Width = 80
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object act10g: TCheckBox
          Left = 74
          Top = 128
          Width = 80
          Height = 17
          Caption = '10 GHz && up'
          Checked = True
          State = cbChecked
          TabOrder = 15
        end
        object act24: TCheckBox
          Left = 8
          Top = 128
          Width = 65
          Height = 17
          Caption = '24 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object act18: TCheckBox
          Left = 8
          Top = 96
          Width = 65
          Height = 17
          Caption = '18 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object act10: TCheckBox
          Left = 8
          Top = 64
          Width = 65
          Height = 17
          Caption = '10 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 208
        Width = 337
        Height = 41
        Caption = 'Back up path'
        TabOrder = 1
        object Button4: TButton
          Left = 8
          Top = 16
          Width = 65
          Height = 19
          Caption = 'Browse...'
          TabOrder = 0
          OnClick = BrowsePathClick
        end
        object BackUpPathEdit: TEdit
          Left = 80
          Top = 16
          Width = 249
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 1
          Text = 'BackUpPathEdit'
        end
      end
      object AllowDupeCheckBox: TCheckBox
        Left = 184
        Top = 56
        Width = 113
        Height = 17
        Caption = 'Allow to log dupes'
        TabOrder = 5
      end
      object SaveEvery: TSpinEdit
        Left = 248
        Top = 100
        Width = 38
        Height = 22
        AutoSize = False
        MaxValue = 99
        MinValue = 1
        TabOrder = 8
        Value = 3
      end
      object cbCountDown: TCheckBox
        Left = 184
        Top = 8
        Width = 121
        Height = 17
        Caption = '10 min count down'
        TabOrder = 2
        OnClick = cbCountDownClick
      end
      object cbDispExchange: TCheckBox
        Left = 8
        Top = 179
        Width = 193
        Height = 17
        Caption = 'Display exchange on other bands'
        TabOrder = 6
      end
      object cbJMode: TCheckBox
        Left = 184
        Top = 40
        Width = 97
        Height = 17
        Caption = 'J-mode'
        TabOrder = 4
      end
      object cbSaveWhenNoCW: TCheckBox
        Left = 184
        Top = 72
        Width = 161
        Height = 17
        Caption = 'Save when not sending CW'
        TabOrder = 7
      end
      object cbQSYCount: TCheckBox
        Left = 184
        Top = 24
        Width = 121
        Height = 17
        Caption = 'QSY count / hr'
        TabOrder = 3
        OnClick = cbQSYCountClick
      end
      object cbAutoEnterSuper: TCheckBox
        Left = 8
        Top = 160
        Width = 260
        Height = 17
        Caption = 'Automatically enter exchange from SuperCheck'
        TabOrder = 9
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Categories'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label14: TLabel
        Left = 248
        Top = 92
        Width = 71
        Height = 13
        Caption = 'Prov/State($V)'
      end
      object Label18: TLabel
        Left = 248
        Top = 116
        Width = 37
        Height = 13
        Caption = 'City($Q)'
      end
      object Label19: TLabel
        Left = 248
        Top = 188
        Width = 22
        Height = 13
        Caption = 'Sent'
      end
      object Label34: TLabel
        Left = 248
        Top = 140
        Width = 62
        Height = 13
        Caption = 'CQ Zone($Z)'
      end
      object Label35: TLabel
        Left = 248
        Top = 164
        Width = 61
        Height = 13
        Caption = 'ITU Zone($I)'
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 137
        Height = 233
        Caption = 'Operator'
        TabOrder = 0
        object Label36: TLabel
          Left = 8
          Top = 155
          Width = 41
          Height = 13
          Caption = 'Operator'
        end
        object Label37: TLabel
          Left = 75
          Top = 155
          Width = 54
          Height = 13
          Caption = 'Power/Age'
        end
        object SingleOpRadioBtn: TRadioButton
          Left = 16
          Top = 16
          Width = 113
          Height = 17
          Caption = 'Single-Op'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = SingleOpRadioBtnClick
        end
        object MultiOpRadioBtn: TRadioButton
          Left = 16
          Top = 32
          Width = 113
          Height = 17
          Caption = 'Multi-Op'
          TabOrder = 1
          TabStop = True
          OnClick = MultiOpRadioBtnClick
        end
        object OpEdit: TEdit
          Left = 8
          Top = 168
          Width = 65
          Height = 20
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#12468#12471#12483#12463
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 2
          OnEnter = OpEditEnter
          OnExit = OpEditExit
          OnKeyDown = OpEditKeyDown
        end
        object Add: TButton
          Left = 8
          Top = 200
          Width = 57
          Height = 25
          Caption = 'Add'
          TabOrder = 4
          OnClick = AddClick
        end
        object Delete: TButton
          Left = 72
          Top = 200
          Width = 57
          Height = 25
          Caption = 'Delete'
          TabOrder = 5
          OnClick = DeleteClick
        end
        object OpPowerEdit: TEdit
          Left = 76
          Top = 168
          Width = 52
          Height = 20
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#12468#12471#12483#12463
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 3
          OnEnter = OpEditEnter
          OnExit = OpEditExit
          OnKeyDown = OpEditKeyDown
        end
      end
      object BandGroup: TRadioGroup
        Left = 148
        Top = 0
        Width = 89
        Height = 233
        ItemIndex = 0
        Items.Strings = (
          'All band'
          '1.9 MHz'
          '3.5 MHz'
          '7 MHz'
          '14 MHz'
          '21 MHz'
          '28 MHz'
          '50 MHz'
          '144 MHz'
          '430 MHz'
          '1200 MHz'
          '2400 MHz'
          '5600 MHz')
        TabOrder = 2
        TabStop = True
        Visible = False
      end
      object OpListBox: TListBox
        Left = 8
        Top = 56
        Width = 121
        Height = 97
        TabStop = False
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#12468#12471#12483#12463
        Font.Style = []
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        ItemHeight = 12
        ParentFont = False
        TabOrder = 1
      end
      object ModeGroup: TRadioGroup
        Left = 248
        Top = 0
        Width = 97
        Height = 81
        Caption = 'Mode'
        ItemIndex = 0
        Items.Strings = (
          'Phone/CW'
          'CW'
          'Phone'
          'Other')
        TabOrder = 3
        TabStop = True
        Visible = False
      end
      object ProvEdit: TEdit
        Left = 320
        Top = 88
        Width = 25
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        TabOrder = 4
      end
      object CItyEdit: TEdit
        Left = 296
        Top = 112
        Width = 49
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        TabOrder = 5
      end
      object SentEdit: TEdit
        Left = 288
        Top = 184
        Width = 57
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        TabOrder = 8
      end
      object CQZoneEdit: TEdit
        Left = 320
        Top = 136
        Width = 25
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        MaxLength = 3
        TabOrder = 6
        Text = '25'
      end
      object IARUZoneEdit: TEdit
        Left = 320
        Top = 160
        Width = 25
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        MaxLength = 3
        TabOrder = 7
        Text = '45'
      end
      object cbMultiStn: TCheckBox
        Left = 248
        Top = 216
        Width = 97
        Height = 17
        Caption = 'Multi station'
        Enabled = False
        TabOrder = 9
      end
    end
    object CWTabSheet: TTabSheet
      Caption = 'CW/RTTY'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label11: TLabel
        Left = 240
        Top = 0
        Width = 31
        Height = 13
        Caption = 'Speed'
      end
      object SpeedLabel: TLabel
        Left = 312
        Top = 16
        Width = 37
        Height = 13
        Caption = '25 wpm'
      end
      object Label13: TLabel
        Left = 240
        Top = 40
        Width = 34
        Height = 13
        Caption = 'Weight'
      end
      object WeightLabel: TLabel
        Left = 312
        Top = 56
        Width = 23
        Height = 13
        Caption = '50 %'
      end
      object Label15: TLabel
        Left = 262
        Top = 185
        Width = 37
        Height = 13
        Caption = 'CQ max'
      end
      object Label16: TLabel
        Left = 225
        Top = 158
        Width = 74
        Height = 13
        Caption = 'Tone Pitch (Hz)'
      end
      object Label17: TLabel
        Left = 188
        Top = 234
        Width = 111
        Height = 13
        Caption = 'CQ repeat interval (sec)'
      end
      object Label12: TLabel
        Left = 213
        Top = 210
        Width = 86
        Height = 13
        Caption = 'Abbreviation (019)'
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 4
        Width = 193
        Height = 225
        Caption = 'Messages'
        TabOrder = 2
        object Label1: TLabel
          Left = 8
          Top = 34
          Width = 12
          Height = 13
          Caption = 'F1'
        end
        object Label2: TLabel
          Left = 8
          Top = 52
          Width = 12
          Height = 13
          Caption = 'F2'
        end
        object Label3: TLabel
          Left = 8
          Top = 70
          Width = 12
          Height = 13
          Caption = 'F3'
        end
        object Label4: TLabel
          Left = 8
          Top = 88
          Width = 12
          Height = 13
          Caption = 'F4'
        end
        object Label5: TLabel
          Left = 8
          Top = 105
          Width = 12
          Height = 13
          Caption = 'F5'
        end
        object Label6: TLabel
          Left = 8
          Top = 123
          Width = 12
          Height = 13
          Caption = 'F6'
        end
        object Label7: TLabel
          Left = 8
          Top = 141
          Width = 12
          Height = 13
          Caption = 'F7'
        end
        object Label8: TLabel
          Left = 8
          Top = 159
          Width = 12
          Height = 13
          Caption = 'F8'
        end
        object Label9: TLabel
          Left = 8
          Top = 184
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label10: TLabel
          Left = 8
          Top = 202
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object Edit2: TEdit
          Tag = 2
          Left = 32
          Top = 50
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 1
          OnChange = Edit1Change
        end
        object Edit3: TEdit
          Tag = 3
          Left = 32
          Top = 67
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 2
          OnChange = Edit1Change
        end
        object Edit4: TEdit
          Tag = 4
          Left = 32
          Top = 85
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 3
          OnChange = Edit1Change
        end
        object Edit5: TEdit
          Tag = 5
          Left = 32
          Top = 103
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 4
          OnChange = Edit1Change
        end
        object Edit6: TEdit
          Tag = 6
          Left = 32
          Top = 121
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 5
          OnChange = Edit1Change
        end
        object Edit7: TEdit
          Tag = 7
          Left = 32
          Top = 139
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 6
          OnChange = Edit1Change
        end
        object Edit9: TEdit
          Left = 32
          Top = 182
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 8
        end
        object Edit8: TEdit
          Tag = 8
          Left = 32
          Top = 157
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 7
          OnChange = Edit1Change
        end
        object Edit10: TEdit
          Left = 32
          Top = 200
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          ParentFont = False
          TabOrder = 9
        end
        object Edit1: TEdit
          Tag = 1
          Left = 32
          Top = 32
          Width = 153
          Height = 17
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          MaxLength = 255
          ParentFont = False
          TabOrder = 0
          OnChange = Edit1Change
        end
      end
      object SpeedBar: TTrackBar
        Left = 203
        Top = 16
        Width = 105
        Height = 17
        Max = 60
        Frequency = 10
        TabOrder = 3
        OnChange = SpeedBarChange
      end
      object WeightBar: TTrackBar
        Left = 203
        Top = 56
        Width = 105
        Height = 17
        Max = 100
        Frequency = 10
        TabOrder = 4
        OnChange = WeightBarChange
      end
      object CQmaxSpinEdit: TSpinEdit
        Left = 304
        Top = 180
        Width = 46
        Height = 22
        MaxValue = 999
        MinValue = 0
        TabOrder = 10
        Value = 15
      end
      object ToneSpinEdit: TSpinEdit
        Left = 304
        Top = 153
        Width = 46
        Height = 22
        Increment = 10
        MaxValue = 2500
        MinValue = 100
        TabOrder = 9
        Value = 100
      end
      object SideToneCheck: TCheckBox
        Left = 208
        Top = 117
        Width = 97
        Height = 17
        Caption = 'Side tone'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object PaddleCheck: TCheckBox
        Left = 208
        Top = 99
        Width = 97
        Height = 17
        Caption = 'Paddle reverse'
        TabOrder = 6
      end
      object CQRepEdit: TEdit
        Left = 304
        Top = 230
        Width = 41
        Height = 21
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        TabOrder = 12
        Text = '2.0'
        OnKeyPress = CQRepEditKeyPress
      end
      object FIFOCheck: TCheckBox
        Left = 208
        Top = 136
        Width = 97
        Height = 17
        Caption = 'Que messages'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object PaddleEnabledCheck: TCheckBox
        Left = 208
        Top = 80
        Width = 97
        Height = 17
        Caption = 'Paddle enabled'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object AbbrevEdit: TEdit
        Left = 304
        Top = 206
        Width = 41
        Height = 21
        CharCase = ecUpperCase
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        MaxLength = 3
        TabOrder = 11
        Text = 'OAN'
      end
      object rbBankA: TRadioButton
        Tag = 1
        Left = 40
        Top = 18
        Width = 57
        Height = 17
        Caption = 'CW A'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = CWBankClick
      end
      object rbBankB: TRadioButton
        Tag = 2
        Left = 88
        Top = 18
        Width = 49
        Height = 17
        Caption = 'CW B'
        TabOrder = 1
        TabStop = True
        OnClick = CWBankClick
      end
      object rbRTTY: TRadioButton
        Tag = 3
        Left = 140
        Top = 18
        Width = 49
        Height = 17
        Caption = 'RTTY'
        TabOrder = 13
        TabStop = True
        OnClick = CWBankClick
      end
      object cbCQSP: TCheckBox
        Left = 8
        Top = 234
        Width = 161
        Height = 17
        Hint = 
          'This option will switch the CW message sent when TAB or ; key is' +
          ' pressed to that in the current message bank. '
        Caption = 'Switch TAB/; with CW bank'
        TabOrder = 14
      end
    end
    object VoiceTabSheet: TTabSheet
      Caption = 'Voice'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox4: TGroupBox
        Left = 8
        Top = 8
        Width = 193
        Height = 230
        Caption = 'Messages'
        TabOrder = 0
        object Label20: TLabel
          Left = 8
          Top = 34
          Width = 12
          Height = 13
          Caption = 'F1'
        end
        object Label21: TLabel
          Left = 8
          Top = 52
          Width = 12
          Height = 13
          Caption = 'F2'
        end
        object Label22: TLabel
          Left = 8
          Top = 70
          Width = 12
          Height = 13
          Caption = 'F3'
        end
        object Label23: TLabel
          Left = 8
          Top = 88
          Width = 12
          Height = 13
          Caption = 'F4'
        end
        object Label24: TLabel
          Left = 8
          Top = 105
          Width = 12
          Height = 13
          Caption = 'F5'
        end
        object Label25: TLabel
          Left = 8
          Top = 123
          Width = 12
          Height = 13
          Caption = 'F6'
        end
        object Label26: TLabel
          Left = 8
          Top = 141
          Width = 12
          Height = 13
          Caption = 'F7'
        end
        object Label27: TLabel
          Left = 8
          Top = 159
          Width = 12
          Height = 13
          Caption = 'F8'
        end
        object Label28: TLabel
          Left = 8
          Top = 184
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label29: TLabel
          Left = 8
          Top = 202
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object memo: TLabel
          Left = 48
          Top = 16
          Width = 28
          Height = 13
          Caption = 'memo'
        end
        object vEdit2: TEdit
          Tag = 2
          Left = 32
          Top = 50
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 2
          Text = 'vEdit2'
        end
        object vEdit3: TEdit
          Tag = 3
          Left = 32
          Top = 67
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 4
          Text = 'vEdit3'
        end
        object vEdit4: TEdit
          Tag = 4
          Left = 32
          Top = 85
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 6
          Text = 'vEdit4'
        end
        object vEdit5: TEdit
          Tag = 5
          Left = 32
          Top = 103
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 8
          Text = 'vEdit5'
        end
        object vEdit6: TEdit
          Tag = 6
          Left = 32
          Top = 121
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 10
          Text = 'vEdit6'
        end
        object vEdit7: TEdit
          Tag = 7
          Left = 32
          Top = 139
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 12
          Text = 'vEdit7'
        end
        object vEdit9: TEdit
          Tag = 9
          Left = 32
          Top = 182
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 16
          Text = 'vEdit9'
        end
        object vEdit8: TEdit
          Tag = 8
          Left = 32
          Top = 157
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 14
          Text = 'vEdit8'
        end
        object vEdit10: TEdit
          Tag = 10
          Left = 32
          Top = 200
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 18
          Text = 'vEdit10'
        end
        object vEdit1: TEdit
          Tag = 1
          Left = 32
          Top = 32
          Width = 70
          Height = 17
          AutoSize = False
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          MaxLength = 255
          TabOrder = 0
          Text = 'vEdit1'
        end
        object vButton1: TButton
          Tag = 1
          Left = 104
          Top = 32
          Width = 81
          Height = 17
          Caption = 'vButton1'
          TabOrder = 1
          OnClick = vButtonClick
        end
        object vButton2: TButton
          Tag = 2
          Left = 104
          Top = 50
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 3
          OnClick = vButtonClick
        end
        object vButton3: TButton
          Tag = 3
          Left = 104
          Top = 68
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 5
          OnClick = vButtonClick
        end
        object vButton4: TButton
          Tag = 4
          Left = 104
          Top = 86
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 7
          OnClick = vButtonClick
        end
        object vButton5: TButton
          Tag = 5
          Left = 104
          Top = 103
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 9
          OnClick = vButtonClick
        end
        object vButton6: TButton
          Tag = 6
          Left = 104
          Top = 121
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 11
          OnClick = vButtonClick
        end
        object vButton7: TButton
          Tag = 7
          Left = 104
          Top = 139
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 13
          OnClick = vButtonClick
        end
        object vButton8: TButton
          Tag = 8
          Left = 104
          Top = 157
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 15
          OnClick = vButtonClick
        end
        object vButton9: TButton
          Tag = 9
          Left = 104
          Top = 182
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 17
          OnClick = vButtonClick
        end
        object vButton10: TButton
          Tag = 10
          Left = 104
          Top = 200
          Width = 81
          Height = 17
          Caption = 'Button4'
          TabOrder = 19
          OnClick = vButtonClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Hardware'
      object GroupBox6: TGroupBox
        Left = 8
        Top = 0
        Width = 337
        Height = 193
        Caption = 'Ports'
        TabOrder = 0
        object Label30: TLabel
          Left = 8
          Top = 32
          Width = 66
          Height = 13
          Caption = 'PacketCluster'
        end
        object Port: TLabel
          Left = 112
          Top = 14
          Width = 19
          Height = 13
          Caption = 'Port'
        end
        object Label32: TLabel
          Left = 8
          Top = 56
          Width = 80
          Height = 13
          Caption = 'Z-Link (Z-Server)'
        end
        object Label42: TLabel
          Left = 8
          Top = 80
          Width = 25
          Height = 13
          Caption = 'Rig 1'
        end
        object Label43: TLabel
          Left = 156
          Top = 80
          Width = 16
          Height = 13
          Caption = 'Rig'
        end
        object Label31: TLabel
          Left = 8
          Top = 104
          Width = 25
          Height = 13
          Caption = 'Rig 2'
        end
        object Label44: TLabel
          Left = 156
          Top = 104
          Width = 16
          Height = 13
          Caption = 'Rig'
        end
        object Label54: TLabel
          Left = 170
          Top = 136
          Width = 75
          Height = 13
          Caption = 'ICOM baud rate'
        end
        object ClusterCombo: TComboBox
          Left = 96
          Top = 28
          Width = 73
          Height = 21
          Style = csDropDownList
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 0
          OnChange = ClusterComboChange
          Items.Strings = (
            'None'
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6'
            'TELNET')
        end
        object PCsetButton: TButton
          Left = 179
          Top = 28
          Width = 102
          Height = 21
          Caption = 'COM port settings'
          Default = True
          ModalResult = 1
          TabOrder = 1
          OnClick = PCsetButtonClick
        end
        object ZLinkCombo: TComboBox
          Left = 96
          Top = 52
          Width = 73
          Height = 21
          Style = csDropDownList
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 2
          OnChange = ZLinkComboChange
          Items.Strings = (
            'None'
            'TELNET')
        end
        object buttonZLinkSettings: TButton
          Left = 179
          Top = 52
          Width = 102
          Height = 21
          Caption = 'TELNET settings'
          Default = True
          ModalResult = 1
          TabOrder = 3
          OnClick = buttonZLinkSettingsClick
        end
        object gbCWPort: TGroupBox
          Left = 8
          Top = 125
          Width = 129
          Height = 62
          Caption = 'CW/PTT port'
          TabOrder = 10
          object radioCwCom1: TRadioButton
            Left = 72
            Top = 13
            Width = 50
            Height = 17
            Caption = 'COM1'
            TabOrder = 1
          end
          object radioCwCom2: TRadioButton
            Left = 72
            Top = 28
            Width = 50
            Height = 17
            Caption = 'COM2'
            TabOrder = 2
          end
          object radioCwUsb: TRadioButton
            Left = 72
            Top = 43
            Width = 50
            Height = 17
            Caption = 'USB'
            TabOrder = 3
          end
          object radioCwNone: TRadioButton
            Left = 3
            Top = 13
            Width = 50
            Height = 17
            Caption = 'None'
            TabOrder = 0
          end
        end
        object Rig1PortCombo: TComboBox
          Left = 80
          Top = 76
          Width = 73
          Height = 21
          Style = csDropDownList
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 4
          Items.Strings = (
            'None'
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6')
        end
        object Rig1Combo: TComboBox
          Left = 176
          Top = 76
          Width = 105
          Height = 21
          Style = csDropDownList
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 5
          OnChange = Rig1ComboChange
        end
        object Rig2PortCombo: TComboBox
          Left = 80
          Top = 100
          Width = 73
          Height = 21
          Style = csDropDownList
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 7
          Items.Strings = (
            'None'
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6')
        end
        object Rig2Combo: TComboBox
          Left = 176
          Top = 100
          Width = 105
          Height = 21
          Style = csDropDownList
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 8
          OnChange = Rig2ComboChange
        end
        object cbTransverter1: TCheckBox
          Tag = 101
          Left = 288
          Top = 78
          Width = 41
          Height = 17
          Hint = 'Check here if you are using a transverter'
          Caption = 'XVT'
          TabOrder = 6
          OnClick = cbTransverter1Click
        end
        object cbTransverter2: TCheckBox
          Tag = 102
          Left = 288
          Top = 100
          Width = 41
          Height = 17
          Hint = 'Check here if you are using a transverter'
          Caption = 'XVT'
          TabOrder = 9
          OnClick = cbTransverter1Click
        end
        object cbIcomBaudRate: TComboBox
          Left = 252
          Top = 132
          Width = 73
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 11
          Text = '1200'
          Items.Strings = (
            '300'
            '1200'
            '2400'
            '4800'
            '9600')
        end
      end
      object GroupBox7: TGroupBox
        Left = 16
        Top = 195
        Width = 313
        Height = 62
        Caption = 'CW PTT control'
        TabOrder = 1
        object Label38: TLabel
          Left = 8
          Top = 38
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object Label39: TLabel
          Left = 128
          Top = 38
          Width = 130
          Height = 13
          Caption = 'After TX paddle/keybd (ms)'
        end
        object PTTEnabledCheckBox: TCheckBox
          Left = 8
          Top = 14
          Width = 129
          Height = 17
          Caption = 'Enable PTT control'
          TabOrder = 0
          OnClick = PTTEnabledCheckBoxClick
        end
        object BeforeEdit: TEdit
          Left = 80
          Top = 35
          Width = 40
          Height = 21
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 1
          Text = 'CWPortEdit'
        end
        object AfterEdit: TEdit
          Left = 264
          Top = 35
          Width = 40
          Height = 21
          ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
          TabOrder = 2
          Text = 'CWPortEdit'
        end
      end
    end
    object tbRigControl: TTabSheet
      Caption = 'Rig control'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label45: TLabel
        Left = 8
        Top = 138
        Width = 111
        Height = 13
        Caption = 'Send current freq every'
      end
      object Label46: TLabel
        Left = 184
        Top = 138
        Width = 19
        Height = 13
        Caption = 'min.'
      end
      object Button1: TButton
        Left = 240
        Top = 200
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 0
        Visible = False
      end
      object cbRITClear: TCheckBox
        Left = 112
        Top = 12
        Width = 161
        Height = 17
        Caption = 'Clear RIT after each QSO'
        TabOrder = 2
      end
      object rgBandData: TRadioGroup
        Left = 8
        Top = 8
        Width = 97
        Height = 81
        Caption = 'Band data (LPT)'
        ItemIndex = 1
        Items.Strings = (
          'None'
          'Radio 1'
          'Radio 2'
          'Active band')
        TabOrder = 1
        TabStop = True
      end
      object cbDontAllowSameBand: TCheckBox
        Left = 112
        Top = 36
        Width = 233
        Height = 17
        Caption = 'Do not allow two rigs to be on same band'
        TabOrder = 3
      end
      object SendFreqEdit: TEdit
        Left = 136
        Top = 134
        Width = 41
        Height = 21
        Hint = 'Only when using Z-Server network'
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        TabOrder = 5
        Text = '1.0'
        OnKeyPress = CQRepEditKeyPress
      end
      object cbRecordRigFreq: TCheckBox
        Left = 112
        Top = 61
        Width = 185
        Height = 17
        Caption = 'Record rig frequency in memo'
        TabOrder = 4
      end
      object cbAFSK: TCheckBox
        Left = 112
        Top = 86
        Width = 153
        Height = 17
        Caption = 'Use AFSK mode for RTTY'
        TabOrder = 6
        Visible = False
      end
      object cbAutoBandMap: TCheckBox
        Left = 112
        Top = 112
        Width = 209
        Height = 17
        Caption = 'Automatically create band scope'
        TabOrder = 7
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Path'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label50: TLabel
        Left = 16
        Top = 18
        Width = 48
        Height = 13
        Caption = 'CFG/DAT'
      end
      object Label51: TLabel
        Left = 16
        Top = 42
        Width = 23
        Height = 13
        Caption = 'Logs'
      end
      object edCFGDATPath: TEdit
        Left = 88
        Top = 16
        Width = 185
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        ParentFont = False
        TabOrder = 0
        Text = 'BackUpPathEdit'
      end
      object btnBrowseCFGDATPath: TButton
        Tag = 10
        Left = 280
        Top = 16
        Width = 65
        Height = 19
        Caption = 'Browse...'
        TabOrder = 1
        OnClick = BrowsePathClick
      end
      object edLogsPath: TEdit
        Tag = 20
        Left = 88
        Top = 40
        Width = 185
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
        ParentFont = False
        TabOrder = 2
        Text = 'BackUpPathEdit'
      end
      object btnBrowseLogsPath: TButton
        Tag = 20
        Left = 280
        Top = 40
        Width = 65
        Height = 19
        Caption = 'Browse...'
        TabOrder = 3
        OnClick = BrowsePathClick
      end
    end
    object tbMisc: TTabSheet
      Caption = 'Misc'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label47: TLabel
        Left = 16
        Top = 88
        Width = 117
        Height = 13
        Caption = 'Max super check search'
      end
      object Label48: TLabel
        Left = 16
        Top = 113
        Width = 138
        Height = 13
        Caption = 'Delete band scope data after'
      end
      object Label49: TLabel
        Left = 216
        Top = 113
        Width = 16
        Height = 13
        Caption = 'min'
      end
      object Label52: TLabel
        Left = 16
        Top = 140
        Width = 102
        Height = 13
        Caption = 'Delete spot data after'
      end
      object Label53: TLabel
        Left = 216
        Top = 137
        Width = 16
        Height = 13
        Caption = 'min'
      end
      object rgSearchAfter: TRadioGroup
        Left = 16
        Top = 8
        Width = 105
        Height = 73
        Caption = 'Start search after'
        ItemIndex = 0
        Items.Strings = (
          'one char'
          'two char'
          'three char')
        TabOrder = 0
        TabStop = True
      end
      object spMaxSuperHit: TSpinEdit
        Left = 160
        Top = 86
        Width = 49
        Height = 22
        MaxValue = 99999
        MinValue = 0
        TabOrder = 1
        Value = 1
      end
      object spBSExpire: TSpinEdit
        Left = 160
        Top = 110
        Width = 49
        Height = 22
        AutoSize = False
        MaxValue = 99999
        MinValue = 1
        TabOrder = 2
        Value = 60
      end
      object cbUpdateThread: TCheckBox
        Left = 16
        Top = 232
        Width = 161
        Height = 17
        Caption = 'Update using a thread'
        TabOrder = 3
      end
      object spSpotExpire: TSpinEdit
        Left = 160
        Top = 134
        Width = 49
        Height = 22
        AutoSize = False
        MaxValue = 99999
        MinValue = 1
        TabOrder = 4
        Value = 60
      end
      object cbDisplayDatePartialCheck: TCheckBox
        Left = 16
        Top = 163
        Width = 169
        Height = 17
        Caption = 'Display date in partial check'
        TabOrder = 5
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 358
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object OKButton: TButton
      Left = 71
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object Button2: TButton
      Left = 151
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 231
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'wav files|*.wav'
    Left = 316
    Top = 296
  end
  object OpenDialog1: TOpenDialog
    Left = 300
    Top = 40
  end
end