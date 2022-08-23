object NRDialog: TNRDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Correct NR'
  ClientHeight = 152
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    260
    152)
  PixelsPerInch = 96
  TextHeight = 12
  object OKBtn: TButton
    Left = 106
    Top = 124
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 124
    ExplicitTop = 71
  end
  object CancelBtn: TButton
    Left = 182
    Top = 124
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 200
    ExplicitTop = 71
  end
  object checkAutoAddPowerCode: TCheckBox
    Left = 8
    Top = 99
    Width = 173
    Height = 13
    Caption = 'Add power code automatically'
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 81
    Caption = 'New Sent NR'
    TabOrder = 0
    object Label2: TLabel
      Left = 17
      Top = 50
      Width = 95
      Height = 12
      Caption = '2400MHz or higher'
    end
    object Label1: TLabel
      Left = 17
      Top = 24
      Width = 85
      Height = 12
      Caption = '1200MHz or less'
    end
    object editSentNR: TEdit
      Left = 126
      Top = 21
      Width = 87
      Height = 20
      TabOrder = 0
    end
    object editSentNR2: TEdit
      Left = 126
      Top = 47
      Width = 87
      Height = 20
      TabOrder = 1
    end
  end
end
