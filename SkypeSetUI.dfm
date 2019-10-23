object Form5: TForm5
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Skype'
  ClientHeight = 412
  ClientWidth = 502
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 502
    Height = 412
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Auto answer'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 122
        Width = 494
        Height = 245
        Align = alTop
        Caption = 'Answer template'
        TabOrder = 0
        object Label2: TLabel
          Left = 16
          Top = 175
          Width = 72
          Height = 25
          Caption = 'Question'
        end
        object Label3: TLabel
          Left = 176
          Top = 175
          Width = 58
          Height = 25
          Caption = 'Answer'
        end
        object DBGrid1: TDBGrid
          Left = 2
          Top = 27
          Width = 490
          Height = 142
          Align = alTop
          DataSource = DataSource1
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -19
          TitleFont.Name = 'Segoe UI Light'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Width = 38
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Question'
              Width = 162
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Answer'
              Width = 234
              Visible = True
            end>
        end
        object Edit2: TEdit
          Left = 3
          Top = 200
          Width = 167
          Height = 33
          TabOrder = 1
        end
        object Edit3: TEdit
          Left = 176
          Top = 200
          Width = 161
          Height = 33
          TabOrder = 2
        end
        object Button1: TButton
          Left = 359
          Top = 200
          Width = 42
          Height = 33
          Caption = 'Add'
          TabOrder = 3
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 407
          Top = 200
          Width = 37
          Height = 33
          Caption = 'Del'
          TabOrder = 4
          OnClick = Button2Click
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 494
        Height = 122
        Align = alTop
        Caption = 'Auto Answer'
        TabOrder = 1
        object Edit1: TEdit
          Left = 231
          Top = 25
          Width = 197
          Height = 33
          TabOrder = 0
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 33
          Width = 209
          Height = 17
          Caption = 'Universal Auto Answer :'
          TabOrder = 1
          OnClick = CheckBox1Click
        end
        object CheckBox2: TCheckBox
          Left = 16
          Top = 56
          Width = 137
          Height = 25
          Caption = 'Use template'
          TabOrder = 2
          OnClick = CheckBox2Click
        end
        object CheckBox3: TCheckBox
          Left = 16
          Top = 82
          Width = 177
          Height = 29
          Caption = 'Auto answer to call'
          TabOrder = 3
          OnClick = CheckBox3Click
        end
        object Edit4: TEdit
          Left = 231
          Top = 80
          Width = 197
          Height = 33
          Enabled = False
          TabOrder = 4
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Auto'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 494
        Height = 105
        Align = alTop
        Caption = 'Auto Mute'
        TabOrder = 0
        object CheckBox4: TCheckBox
          Left = 16
          Top = 24
          Width = 241
          Height = 25
          Caption = 'Auto Mute if process open'
          TabOrder = 0
          OnClick = CheckBox4Click
        end
        object Edit5: TEdit
          Left = 247
          Top = 20
          Width = 186
          Height = 33
          TabOrder = 1
        end
        object Button3: TButton
          Left = 439
          Top = 20
          Width = 42
          Height = 33
          Caption = 'Set'
          TabOrder = 2
          OnClick = Button3Click
        end
        object CheckBox6: TCheckBox
          Left = 17
          Top = 61
          Width = 200
          Height = 25
          Caption = 'Send to Skype if mute'
          TabOrder = 3
          OnClick = CheckBox6Click
        end
        object Edit6: TEdit
          Left = 223
          Top = 59
          Width = 210
          Height = 33
          TabOrder = 4
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 105
        Width = 494
        Height = 105
        Align = alTop
        Caption = 'MLine Radio'
        TabOrder = 1
        object CheckBox5: TCheckBox
          Left = 17
          Top = 36
          Width = 225
          Height = 25
          Caption = 'Set volume level if answer'
          TabOrder = 0
          OnClick = CheckBox5Click
        end
        object ComboBox1: TComboBox
          Left = 247
          Top = 32
          Width = 66
          Height = 33
          TabOrder = 1
          Text = '5'
          Items.Strings = (
            '5'
            '10'
            '20'
            '25'
            '35'
            '40'
            '55'
            '65'
            '75'
            '100')
        end
        object Button4: TButton
          Left = 319
          Top = 32
          Width = 42
          Height = 33
          Caption = 'Set'
          TabOrder = 2
          OnClick = Button4Click
        end
      end
    end
  end
  object FDQuery1: TFDQuery
    IndexFieldNames = 'id'
    Connection = Form1.FDConnection1
    SQL.Strings = (
      'select * from Frases;')
    Left = 304
    Top = 120
    object FDQuery1id: TIntegerField
      FieldName = 'id'
    end
    object FDQuery1Answer: TWideMemoField
      FieldName = 'Answer'
      OnGetText = FDQuery1AnswerGetText
      BlobType = ftWideMemo
    end
    object FDQuery1Question: TWideMemoField
      FieldName = 'Question'
      OnGetText = FDQuery1QuestionGetText
      BlobType = ftWideMemo
    end
  end
  object FDTable1: TFDTable
    Connection = Form1.FDConnection1
    Left = 344
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 384
    Top = 120
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 316
    Top = 52
  end
  object Timer3: TTimer
    Interval = 5000
    OnTimer = Timer3Timer
    Left = 444
    Top = 332
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 356
    Top = 52
  end
  object Timer4: TTimer
    Enabled = False
    Interval = 2500
    OnTimer = Timer4Timer
    Left = 372
    Top = 172
  end
  object Timer5: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer5Timer
    Left = 164
    Top = 116
  end
  object Timer6: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer6Timer
    Left = 268
    Top = 316
  end
  object Timer7: TTimer
    Enabled = False
    Interval = 2500
    OnTimer = Timer7Timer
    Left = 396
    Top = 356
  end
end
