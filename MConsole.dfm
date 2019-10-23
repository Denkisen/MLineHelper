object Form10: TForm10
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Console'
  ClientHeight = 351
  ClientWidth = 728
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 25
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 728
    Height = 318
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    Lines.Strings = (
      'MLineHelper debug console v.1.0.0'
      'MLine program product. All rights are protected.'
      'Type "help" or "?" for Help.'
      '><><><><><><><><><><><><><><><>'
      '<System namespace is chosen')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    Zoom = 100
    OnChange = RichEdit1Change
  end
  object Edit1: TEdit
    Left = 0
    Top = 318
    Width = 728
    Height = 33
    Align = alBottom
    TabOrder = 1
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 640
    Top = 240
  end
end
