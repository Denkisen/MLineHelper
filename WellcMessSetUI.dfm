object Form7: TForm7
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Wellcome Mess Settings'
  ClientHeight = 386
  ClientWidth = 564
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
    Width = 564
    Height = 105
    Align = alTop
    Caption = 'Message Settings'
    TabOrder = 0
    object Label1: TLabel
      Left = 262
      Top = 21
      Width = 20
      Height = 15
      Caption = 'Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 392
      Top = 21
      Width = 45
      Height = 15
      Caption = 'Message'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object RadioButton1: TRadioButton
      Left = 24
      Top = 72
      Width = 209
      Height = 17
      Caption = 'Random from database'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 24
      Top = 40
      Width = 225
      Height = 26
      Caption = 'Static Welcome message'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton2Click
    end
    object Edit1: TEdit
      Left = 255
      Top = 39
      Width = 121
      Height = 33
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 382
      Top = 39
      Width = 171
      Height = 33
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 105
    Width = 564
    Height = 281
    Align = alClient
    Caption = 'Table Settings'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 27
      Width = 560
      Height = 174
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
          Width = 41
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Title'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Message'
          Width = 305
          Visible = True
        end>
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 232
      Width = 161
      Height = 33
      EditLabel.Width = 34
      EditLabel.Height = 25
      EditLabel.Caption = 'Title'
      TabOrder = 1
    end
    object LabeledEdit2: TLabeledEdit
      Left = 185
      Top = 232
      Width = 240
      Height = 33
      EditLabel.Width = 70
      EditLabel.Height = 25
      EditLabel.Caption = 'Message'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 447
      Top = 232
      Width = 42
      Height = 33
      Caption = 'Add'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 495
      Top = 232
      Width = 42
      Height = 33
      Caption = 'Del'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object FDQuery1: TFDQuery
    Connection = Form1.FDConnection1
    SQL.Strings = (
      'select * from Wellcomes')
    Left = 304
    Top = 145
    object FDQuery1id: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Title: TWideMemoField
      FieldName = 'Title'
      Origin = 'Title'
      Required = True
      OnGetText = FDQuery1TitleGetText
      BlobType = ftWideMemo
    end
    object FDQuery1Message: TWideMemoField
      FieldName = 'Message'
      Origin = 'Message'
      Required = True
      OnGetText = FDQuery1MessageGetText
      BlobType = ftWideMemo
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 320
    Top = 201
  end
  object FDTable1: TFDTable
    Connection = Form1.FDConnection1
    Left = 352
    Top = 145
  end
end
