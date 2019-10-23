object Form9: TForm9
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Choose friend'
  ClientHeight = 354
  ClientWidth = 199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ScreenSnap = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 25
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 199
    Height = 354
    Align = alClient
    ItemHeight = 25
    TabOrder = 0
    OnDblClick = ListBox1DblClick
  end
end
