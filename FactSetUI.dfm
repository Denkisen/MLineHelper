object Form8: TForm8
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Facts Settings'
  ClientHeight = 424
  ClientWidth = 477
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
    Top = 111
    Width = 477
    Height = 314
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Russian'
      object Label1: TLabel
        Left = 6
        Top = 233
        Width = 41
        Height = 25
        Caption = 'Fact :'
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 469
        Height = 193
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
            Width = 34
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Fact'
            Width = 374
            Visible = True
          end>
      end
      object Edit1: TEdit
        Left = 53
        Top = 231
        Width = 305
        Height = 33
        TabOrder = 1
      end
      object Button1: TButton
        Left = 364
        Top = 231
        Width = 45
        Height = 33
        Caption = 'Add'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 415
        Top = 231
        Width = 45
        Height = 33
        Caption = 'Del'
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 328
        Top = 200
        Width = 132
        Height = 25
        Caption = 'Add from file'
        TabOrder = 4
        OnClick = Button3Click
      end
      object ProgressBar1: TProgressBar
        Left = 6
        Top = 199
        Width = 316
        Height = 26
        TabOrder = 5
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'English'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = 233
        Width = 41
        Height = 25
        Caption = 'Fact :'
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 469
        Height = 193
        Align = alTop
        DataSource = DataSource2
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
            Width = 44
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Fact'
            Width = 374
            Visible = True
          end>
      end
      object ProgressBar2: TProgressBar
        Left = 6
        Top = 199
        Width = 316
        Height = 26
        TabOrder = 1
      end
      object Button4: TButton
        Left = 328
        Top = 200
        Width = 132
        Height = 25
        Caption = 'Add from file'
        TabOrder = 2
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 364
        Top = 231
        Width = 45
        Height = 33
        Caption = 'Add'
        TabOrder = 3
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 415
        Top = 231
        Width = 45
        Height = 33
        Caption = 'Del'
        TabOrder = 4
        OnClick = Button6Click
      end
      object Edit2: TEdit
        Left = 53
        Top = 231
        Width = 305
        Height = 33
        TabOrder = 5
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 477
    Height = 111
    Align = alTop
    Caption = 'Settings'
    TabOrder = 1
    object Label2: TLabel
      Left = 10
      Top = 32
      Width = 88
      Height = 25
      Caption = 'Language :'
    end
    object ComboBox1: TComboBox
      Left = 104
      Top = 29
      Width = 145
      Height = 33
      TabOrder = 0
      Text = 'Russian'
      Items.Strings = (
        'Russian'
        'English')
    end
    object RadioButton2: TRadioButton
      Left = 276
      Top = 29
      Width = 113
      Height = 23
      Caption = 'Every hour'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object CheckBox1: TCheckBox
      Left = 7
      Top = 68
      Width = 198
      Height = 29
      Caption = 'Don'#39't show if running'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object Edit3: TEdit
      Left = 211
      Top = 68
      Width = 209
      Height = 33
      TabOrder = 3
    end
    object Button7: TButton
      Left = 422
      Top = 68
      Width = 38
      Height = 33
      Caption = 'Set'
      TabOrder = 4
      OnClick = Button7Click
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 212
    Top = 128
  end
  object FDQuery1: TFDQuery
    Connection = Form1.FDConnection1
    SQL.Strings = (
      'select * from Factsru')
    Left = 260
    Top = 128
    object FDQuery1id: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Fact: TWideMemoField
      FieldName = 'Fact'
      Origin = 'Fact'
      Required = True
      OnGetText = FDQuery1FactGetText
      BlobType = ftWideMemo
    end
  end
  object FDTable1: TFDTable
    Connection = Form1.FDConnection1
    Left = 308
    Top = 128
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Filter = 'txt(*.txt)|*.txt'
    Left = 428
    Top = 188
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 276
    Top = 181
  end
  object FDQuery2: TFDQuery
    Connection = Form1.FDConnection1
    SQL.Strings = (
      'select * from Factsen')
    Left = 236
    Top = 181
    object FDQuery2id: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery2Fact: TWideMemoField
      FieldName = 'Fact'
      Origin = 'Fact'
      Required = True
      OnGetText = FDQuery2FactGetText
      BlobType = ftWideMemo
    end
  end
  object FDTable2: TFDTable
    Connection = Form1.FDConnection1
    Left = 316
    Top = 181
  end
  object OpenTextFileDialog2: TOpenTextFileDialog
    Filter = 'txt(*.txt)|*.txt'
    Left = 412
    Top = 212
  end
end
