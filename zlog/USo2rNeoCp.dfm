object formSo2rNeoCp: TformSo2rNeoCp
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'SO2R Neo Control Panel'
  ClientHeight = 77
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object groupAfControl: TGroupBox
    Left = 163
    Top = 4
    Width = 315
    Height = 69
    Caption = 'AF'#12502#12524#12531#12489
    TabOrder = 0
    object buttonAfBlend: TSpeedButton
      Left = 12
      Top = 15
      Width = 65
      Height = 45
      AllowAllUp = True
      GroupIndex = 3
      Caption = 'AF Blend'
      OnClick = buttonAfBlendClick
    end
    object buttonPer100: TSpeedButton
      Tag = 100
      Left = 263
      Top = 10
      Width = 45
      Height = 18
      Caption = '100%'
      OnClick = buttonPerNClick
    end
    object buttonPer0: TSpeedButton
      Left = 263
      Top = 47
      Width = 45
      Height = 17
      Caption = '0%'
      OnClick = buttonPerNClick
    end
    object buttonPer50: TSpeedButton
      Tag = 50
      Left = 263
      Top = 29
      Width = 45
      Height = 17
      Caption = '50%'
      OnClick = buttonPerNClick
    end
    object trackBlendRatio: TTrackBar
      Left = 83
      Top = 24
      Width = 174
      Height = 25
      Max = 100
      PageSize = 5
      Frequency = 5
      Position = 50
      TabOrder = 0
      OnChange = trackBlendRatioChange
    end
  end
  object groupRxSelect: TGroupBox
    Left = 4
    Top = 4
    Width = 153
    Height = 69
    Caption = 'RX'
    TabOrder = 1
    object buttonRig1: TSpeedButton
      Left = 8
      Top = 15
      Width = 45
      Height = 45
      GroupIndex = 1
      Down = True
      Caption = 'RIG1'
      OnClick = buttonRigClick
    end
    object buttonRig2: TSpeedButton
      Left = 52
      Top = 15
      Width = 45
      Height = 45
      GroupIndex = 1
      Caption = 'RIG2'
      OnClick = buttonRigClick
    end
    object buttonRigBoth: TSpeedButton
      Left = 96
      Top = 15
      Width = 45
      Height = 45
      GroupIndex = 1
      Caption = 'Both'
      OnClick = buttonRigClick
    end
  end
  object ActionList1: TActionList
    Left = 256
    Top = 56
    object actionSo2rNeoSelRx1: TAction
      Caption = 'actionSo2rNeoSelRx1'
      OnExecute = actionSo2rNeoSelRx1Execute
    end
    object actionSo2rNeoSelRx2: TAction
      Caption = 'actionSo2rNeoSelRx2'
      OnExecute = actionSo2rNeoSelRx2Execute
    end
    object actionSo2rNeoSelRxBoth: TAction
      Caption = 'actionSo2rNeoSelRxBoth'
      OnExecute = actionSo2rNeoSelRxBothExecute
    end
  end
end
