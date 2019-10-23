object Form6: TForm6
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Command Help'
  ClientHeight = 287
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 416
    Height = 287
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    Lines.Strings = (
      'Event:'
      'Commands type :'
      '---------------------------'
      '%command(atrib);command(atrib);'
      '---------------------------'
      'Open(full_file_path);  //Example : Open(c:\test.txt);'
      'Http(URL); //Example : Http(http://example.com/);'
      
        'SendMess(Skype_login,message); //Example : SendMess(jonn124,Hell' +
        'o!);'
      'Randomtext;  //Just show you "Randomtext".'
      '---------------------------'
      'Date:'
      'Commands type:'
      '---------------------------'
      '%command(atrib);'
      'Everyday();'
      'Everyweek(day_as_string); //Example : Everyweek(Monday);'
      'Everymonth(day_as_num); //Example : Everymonth(12);'
      'Everyyear(month,day); //Example : Everyyear(04,21);')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    Zoom = 100
  end
end
