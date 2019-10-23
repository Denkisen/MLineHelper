object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 280
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 470
    Height = 241
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Options'
      object CheckBox1: TCheckBox
        Left = 16
        Top = 16
        Width = 209
        Height = 26
        Caption = 'Autorun with Windows'
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 16
        Top = 48
        Width = 105
        Height = 25
        Caption = 'Skype Api'
        TabOrder = 1
        OnClick = CheckBox2Click
      end
      object Button3: TButton
        Left = 207
        Top = 44
        Width = 82
        Height = 29
        Caption = 'Settings'
        TabOrder = 2
        OnClick = Button3Click
      end
      object CheckBox3: TCheckBox
        Left = 16
        Top = 116
        Width = 185
        Height = 25
        Caption = 'Wellcome message'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object Button2: TButton
        Left = 207
        Top = 114
        Width = 82
        Height = 29
        Caption = 'Settings'
        TabOrder = 4
        OnClick = Button2Click
      end
      object CheckBox4: TCheckBox
        Left = 16
        Top = 151
        Width = 137
        Height = 25
        Caption = 'Random facts'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object Button4: TButton
        Left = 207
        Top = 149
        Width = 82
        Height = 29
        Caption = 'Settings'
        TabOrder = 6
        OnClick = Button4Click
      end
      object CheckBox5: TCheckBox
        Left = 16
        Top = 81
        Width = 161
        Height = 25
        Caption = 'MLine Radio Api'
        TabOrder = 7
        OnClick = CheckBox5Click
      end
      object Button5: TButton
        Left = 207
        Top = 79
        Width = 82
        Height = 29
        Caption = 'Settings'
        TabOrder = 8
        OnClick = Button5Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Helper'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 77
        Width = 113
        Height = 25
        Caption = 'Helper name :'
      end
      object Edit1: TEdit
        Left = 192
        Top = 74
        Width = 198
        Height = 33
        TabOrder = 0
        Text = 'Kuroneko'
      end
      object RadioGroup1: TRadioGroup
        Left = 3
        Top = 3
        Width = 417
        Height = 65
        Caption = 'Helper type'
        TabOrder = 1
      end
      object RadioButton1: TRadioButton
        Left = 24
        Top = 40
        Width = 74
        Height = 17
        Caption = 'Chan'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 104
        Top = 40
        Width = 65
        Height = 17
        Caption = 'Kun'
        TabOrder = 3
        OnClick = RadioButton2Click
      end
      object RadioButton3: TRadioButton
        Left = 175
        Top = 35
        Width = 122
        Height = 28
        Caption = 'Your fantasy'
        TabOrder = 4
        OnClick = RadioButton3Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Sound'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 161
        Height = 201
        Align = alLeft
        Caption = 'Messages volume'
        TabOrder = 0
        object Label3: TLabel
          Left = 15
          Top = 24
          Width = 62
          Height = 21
          Caption = 'Welcome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 15
          Top = 56
          Width = 33
          Height = 21
          Caption = 'Facts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 15
          Top = 88
          Width = 32
          Height = 21
          Caption = 'Error'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 104
          Top = 28
          Width = 16
          Height = 17
          Caption = 'vol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 104
          Top = 60
          Width = 16
          Height = 17
          Caption = 'vol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 104
          Top = 92
          Width = 16
          Height = 17
          Caption = 'vol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object TrackBar2: TTrackBar
          Left = 3
          Top = 45
          Width = 135
          Height = 17
          Max = 100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ThumbLength = 10
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar2Change
        end
        object TrackBar3: TTrackBar
          Left = 3
          Top = 77
          Width = 135
          Height = 17
          Max = 100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          ThumbLength = 10
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar3Change
        end
        object TrackBar7: TTrackBar
          Left = 3
          Top = 109
          Width = 135
          Height = 17
          Max = 100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          ThumbLength = 10
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar7Change
        end
      end
      object GroupBox2: TGroupBox
        Left = 161
        Top = 0
        Width = 160
        Height = 201
        Align = alLeft
        Caption = 'Events'
        TabOrder = 1
        object Label5: TLabel
          Left = 18
          Top = 24
          Width = 84
          Height = 21
          Caption = 'Before event'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 18
          Top = 56
          Width = 48
          Height = 21
          Caption = 'At time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 18
          Top = 88
          Width = 66
          Height = 21
          Caption = 'Later a bit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 108
          Top = 28
          Width = 16
          Height = 17
          Caption = 'vol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 107
          Top = 60
          Width = 16
          Height = 17
          Caption = 'vol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 107
          Top = 92
          Width = 16
          Height = 17
          Caption = 'vol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
        object TrackBar4: TTrackBar
          Left = 6
          Top = 45
          Width = 135
          Height = 17
          Max = 100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ThumbLength = 10
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar4Change
        end
        object TrackBar5: TTrackBar
          Left = 6
          Top = 77
          Width = 135
          Height = 17
          Max = 100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          ThumbLength = 10
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar5Change
        end
        object TrackBar6: TTrackBar
          Left = 6
          Top = 109
          Width = 135
          Height = 17
          Max = 100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          ThumbLength = 10
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar6Change
        end
      end
      object CheckBox6: TCheckBox
        Left = 327
        Top = 26
        Width = 132
        Height = 17
        Caption = 'Enable sound'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object Button1: TButton
    Left = 373
    Top = 247
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = Button1Click
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 412
    Top = 5
    object LinkControlToPropertyEnabled: TLinkControlToProperty
      Category = 'Quick Bindings'
      Control = CheckBox3
      Track = True
      Component = Button2
      ComponentProperty = 'Enabled'
    end
    object LinkControlToPropertyEnabled2: TLinkControlToProperty
      Category = 'Quick Bindings'
      Control = CheckBox4
      Track = True
      Component = Button4
      ComponentProperty = 'Enabled'
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'exe(*.exe)|*.exe'
    Left = 364
    Top = 124
  end
end
