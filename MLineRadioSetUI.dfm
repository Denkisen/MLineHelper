object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'MLine Radio Api'
  ClientHeight = 280
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 25
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 444
    Height = 121
    Align = alTop
    Caption = 'Settings'
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 16
      Top = 24
      Width = 169
      Height = 25
      Caption = 'Run if not running'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 55
      Width = 273
      Height = 26
      Caption = 'Auto play the last Radio station'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 87
      Width = 193
      Height = 25
      Caption = 'Show the songs title'
      TabOrder = 2
      OnClick = CheckBox4Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 121
    Width = 444
    Height = 153
    Align = alTop
    Caption = 'Do if other program running'
    TabOrder = 1
    object Label1: TLabel
      Left = 230
      Top = 67
      Width = 15
      Height = 25
      Caption = '%'
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 32
      Width = 113
      Height = 25
      Caption = 'Press Stop'
      TabOrder = 0
      OnClick = CheckBox5Click
    end
    object Edit1: TEdit
      Left = 135
      Top = 24
      Width = 257
      Height = 33
      TabOrder = 1
    end
    object CheckBox6: TCheckBox
      Left = 16
      Top = 67
      Width = 153
      Height = 26
      Caption = 'Set volume level'
      TabOrder = 2
      OnClick = CheckBox6Click
    end
    object Edit3: TEdit
      Left = 251
      Top = 63
      Width = 141
      Height = 33
      TabOrder = 3
    end
    object Button1: TButton
      Left = 398
      Top = 24
      Width = 33
      Height = 33
      Caption = 'Set'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 398
      Top = 63
      Width = 33
      Height = 34
      Caption = 'Set'
      TabOrder = 5
      OnClick = Button2Click
    end
    object ComboBox1: TComboBox
      Left = 175
      Top = 63
      Width = 49
      Height = 33
      TabOrder = 6
      Text = '55'
      Items.Strings = (
        '10'
        '15'
        '20'
        '30'
        '45'
        '55'
        '65'
        '70'
        '80'
        '95')
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'exe(*.exe)|*.exe'
    Left = 376
    Top = 88
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 176
    Top = 88
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 248
    Top = 145
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 7000
    OnTimer = Timer3Timer
    Left = 280
    Top = 145
  end
  object Timer4: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer4Timer
    Left = 248
    Top = 193
  end
  object Timer5: TTimer
    Enabled = False
    Interval = 7000
    OnTimer = Timer5Timer
    Left = 280
    Top = 193
  end
end
