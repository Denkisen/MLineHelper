object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'MLineHelper'
  ClientHeight = 260
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object Label1: TLabel
    Left = 12
    Top = 187
    Width = 47
    Height = 25
    Caption = 'Date :'
  end
  object Label2: TLabel
    Left = 219
    Top = 184
    Width = 49
    Height = 25
    Caption = 'Time :'
  end
  object Button1: TButton
    Left = 361
    Top = 228
    Width = 75
    Height = 25
    Caption = 'Del'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 361
    Top = 201
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 361
    Top = 174
    Width = 25
    Height = 25
    Hint = 'Command Help'
    Caption = '?'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = Button3Click
  end
  object StringGridBindSourceDB1: TStringGrid
    Left = 0
    Top = 0
    Width = 449
    Height = 169
    Align = alTop
    ColCount = 1
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
    TabOrder = 3
    ColWidths = (
      51)
  end
  object LabeledEditEvent: TLabeledEdit
    Left = 65
    Top = 220
    Width = 290
    Height = 33
    EditLabel.Width = 54
    EditLabel.Height = 25
    EditLabel.Caption = 'Event :'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object ComboBox1: TComboBox
    Left = 65
    Top = 181
    Width = 145
    Height = 33
    TabOrder = 5
    Items.Strings = (
      '%Everyday();'
      '%Everyweek(Monday);'
      '%Everymonth(15);'
      '%Everyyear(05,15);')
  end
  object MaskEdit1: TMaskEdit
    Left = 272
    Top = 181
    Width = 83
    Height = 33
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 6
    Text = '  :  '
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnClick = TrayIcon1Click
    Left = 728
    Top = 224
  end
  object PopupMenu1: TPopupMenu
    Left = 680
    Top = 216
    object Sendfileto1: TMenuItem
      Caption = 'Send file to...'
      Enabled = False
      OnClick = Sendfileto1Click
    end
    object Autoanswer1: TMenuItem
      Caption = 'AutoAnswerCall'
      OnClick = Autoanswer1Click
    end
    object Console1: TMenuItem
      Caption = 'Console'
      OnClick = Console1Click
    end
    object Setings1: TMenuItem
      Caption = 'Settings'
      OnClick = Setings1Click
    end
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 688
    Top = 176
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Delphi\MLineHelper\Win32\Debug\Events.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 544
    Top = 184
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 648
    Top = 256
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 616
    Top = 256
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDQuery1
    ScopeMappings = <>
    Left = 560
    Top = 256
  end
  object FDQuery1: TFDQuery
    AfterPost = FDQuery1AfterPost
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Events')
    Left = 584
    Top = 184
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 484
    Top = 261
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = StringGridBindSourceDB1
      Columns = <>
    end
  end
  object BindSourceEvents: TBindSourceDB
    DataSet = FDTableEvents
    ScopeMappings = <>
    Left = 536
    Top = 256
  end
  object FDTableEvents: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evLiveWindowParanoic]
    FetchOptions.LiveWindowParanoic = True
    UpdateOptions.UpdateTableName = 'Events'
    TableName = 'Events'
    Left = 624
    Top = 184
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 584
    Top = 232
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 400
    Top = 8
  end
end
