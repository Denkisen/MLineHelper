unit Loader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, IniFiles, Dialogs, Vcl.Imaging.pngimage, Vcl.Forms, ShellApi;

type
  TLoader = Class
  public
    function Loadall: boolean;
    function Loadallex: boolean;
  End;

implementation

uses Clientcom, FactSetUI, Main, MessUI, MLineRadioSetUI, SettingsUI,
  SkypeSetUI, WellcMessSetUI;

function TLoader.Loadall: boolean;
begin
  /// / Main form ///////////////////////////
 // Form1.LoadC;
  /// ///////////////////////////////////////
  //Form2.LoadC;
  /// ///////////////////////////////////////
  //Form4.LoadC;
  /// ///////////////////////////////////////
  //form5.LoadC;
  /// ///////////////////////////////////////
  //Form7.LoadC;
  /// ///////////////////////////////////////
  //form8.LoadC;
  /// ///////////////////////////////////////
  //form3.LoadC;
  /// ///////////////////////////////////////
  result := true;
end;

procedure tableinfoinit;
begin
  tabl[0].name := 'Events';
  tabl[1].name := 'Factsru';
  tabl[2].name := 'Factsen';
  tabl[3].name := 'Frases';
  tabl[4].name := 'Wellcomes';
  tabl[5].name := 'vvv';
  tabl[6].name := 'vvv';
  tabl[7].name := 'vvv';
  tabl[8].name := 'vvv';
  tabl[9].name := 'vvv';
  tabl[0].fields := 'id,Data,Time,Event';
  tabl[1].fields := 'id,Fact';
  tabl[2].fields := 'id,Fact';
  tabl[3].fields := 'id,Question,Answer';
  tabl[4].fields := 'id,Title,Message';
  tabl[5].fields := '';
  tabl[6].fields := '';
  tabl[7].fields := '';
  tabl[8].fields := '';
  tabl[9].fields := '';
end;

function TLoader.Loadallex: boolean;
var
  i: integer;
  ini: TIniFile;
  tmp: string;
  Pict: TPNGImage;
  dllok: boolean;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
  tableinfoinit;
  if not FileExists(extractfilepath(paramstr(0)) +'DataS.dll') then
  begin
    ShowMessage('DataS.dll not found!');
    Application.Terminate;
  end;
     if not FileExists(extractfilepath(paramstr(0)) +'Events.db') then
  begin
    ShowMessage('Events.db not found!');
    Application.Terminate;
  end;

  /// ///////////////////////////////variables
  starttimeh := strtoint(FormatDateTime('hh', Time()));
  starttimem := strtoint(copy(FormatDateTime('hh:mm', Time()),
    pos(':', FormatDateTime('hh:mm', Time())) + 1, FormatDateTime('hh:mm',
    Time()).Length));
  Form4.TransparentColorValue := clWhite;
  Form4.transparentcolor := true;
  Form4.Color := clWhite;
  cursongtitle := '';
  /// ///////////////////////////////ini load
  Form2.Edit1.Text := ini.ReadString('Helper', 'Name', 'Kuroneko');
  Form2.CheckBox2.Checked := ini.ReadBool('General', 'Skype', false);
  Form1.Sendfileto1.Visible := ini.ReadBool('General', 'Skype', false);
  Form2.CheckBox1.Checked := ini.ReadBool('General', 'Auto', false);
  Form2.CheckBox3.Checked := ini.ReadBool('General', 'Wellcome', true);
  Form2.Button2.Enabled := ini.ReadBool('General', 'Wellcome', true);
  Form2.CheckBox4.Checked := ini.ReadBool('General', 'Facts', false);
  Form2.Button4.Enabled := ini.ReadBool('General', 'Facts', false);
  Form2.CheckBox5.Checked := ini.ReadBool('General', 'MLineRadio', false);
  Form2.TrackBar2.Position := ini.ReadInteger('Sound', 'Welcome', 75);
  Form2.TrackBar3.Position := ini.ReadInteger('Sound', 'Facts', 75);
  Form2.TrackBar4.Position := ini.ReadInteger('Sound', 'Eventbefore', 75);
  Form2.TrackBar5.Position := ini.ReadInteger('Sound', 'Eventattime', 75);
  Form2.TrackBar6.Position := ini.ReadInteger('Sound', 'Eventlater', 75);
  Form2.TrackBar7.Position := ini.ReadInteger('Sound', 'Error', 75);
  Form2.checkbox6.Checked := ini.ReadBool('Sound', 'Enable', true);
  form5.CheckBox1.Checked := ini.ReadBool('Skype', 'Autoanswer', false);
  form5.Edit1.Enabled := ini.ReadBool('Skype', 'Autoanswer', false);
  form5.CheckBox2.Checked := ini.ReadBool('Skype', 'template', false);
  form5.Edit1.Text := ini.ReadString('Skype', 'Autotext', '');
  form5.Edit4.Text := ini.ReadString('Skype', 'Autocalltext', '');
  form5.edit6.Text := ini.ReadString('Skype', 'ifmutestr', '');
  form5.Edit5.Enabled := ini.ReadBool('Skype', 'Automute', false);
  form5.Button3.Enabled := ini.ReadBool('Skype', 'Automute', false);
  form5.CheckBox4.Checked := ini.ReadBool('Skype', 'Automute', false);
  form5.Edit5.Text := ini.ReadString('Skype', 'Automuteproc', '');
  procstring := ini.ReadString('Skype', 'Automuteproc', '');
  form5.checkbox6.Checked := ini.ReadBool('Skype', 'sendifmute', false);
  form5.edit6.Enabled := ini.ReadBool('Skype', 'sendifmute', false);
  voll := ini.ReadInteger('Skype', 'VolAnswer', 5);
  form5.CheckBox5.Checked := ini.ReadBool('Skype', 'VolAnswerEn', false);
  Form7.Edit1.Text := ini.ReadString('WelcomeMessage', 'Title', 'Welcome');
  Form7.Edit2.Text := ini.ReadString('WelcomeMessage', 'Message', 'Hello!');
  form8.CheckBox1.Checked := ini.ReadBool('Facts', 'Stopif', false);
  form8.edit3.Text := ini.ReadString('Facts', 'Stopiftext', '');
  form3.CheckBox1.Checked := ini.ReadBool('MLineRadio', 'Run', false);
  form3.CheckBox2.Checked := ini.ReadBool('MLineRadio', 'LastRadioPlay', false);
  form3.CheckBox4.Checked := ini.ReadBool('MLineRadio', 'Songtitle', false);
  form3.CheckBox5.Checked := ini.ReadBool('MLineRadio', 'Presstop', false);
  form3.checkbox6.Checked := ini.ReadBool('MLineRadio', 'SetVol', false);
  form3.Edit1.Text := ini.ReadString('MLineRadio', 'StopPrograms', '');
  procstring := ini.ReadString('MLineRadio', 'StopPrograms', '');
  form3.edit3.Text := ini.ReadString('MLineRadio', 'VolPrograms', '');
  procstring2 := ini.ReadString('MLineRadio', 'VolPrograms', '');
  form3.Combobox1.Text := ini.ReadString('MLineRadio', 'VolLevel', '55');
  voli := ini.ReadInteger('MLineRadio', 'VolLevel', 55);
  tmp := ini.ReadString('General', 'Randstr', '');
  SetLength(Randfr, 7);


  form8.Combobox1.Text := ini.ReadString('Facts', 'Language', 'Russian');
  case ini.ReadInteger('Facts', 'Time', 0) of
    0:
      form8.RadioButton2.Checked := true;
    // 1 :  RadioButton1.Checked := true;
    2:
      form8.RadioButton2.Checked := true;
  else
    form8.RadioButton2.Checked := true;
  end;

  case ini.ReadInteger('WelcomeMessage', 'Type', 2) of
    1:
      begin
        Form7.RadioButton1.Checked := true;
        Form7.Edit1.Enabled := false;
        Form7.Edit2.Enabled := false;
      end;
    2:
      begin
        Form7.RadioButton2.Checked := true;
        Form7.Edit1.Enabled := true;
        Form7.Edit2.Enabled := true;
      end;
  else
    begin
      Form7.RadioButton2.Checked := true;
      Form7.Edit1.Enabled := true;
      Form7.Edit2.Enabled := true;
    end;
  end;
  if ini.ReadBool('MLineRadio', 'Run', false) = true then
  begin
    if (not Form2.IsRunning('MLine Radio.exe')) and
      (FileExists(ini.ReadString('MLineRadio', 'FilePath', '')) = true) then
      ShellExecute(Form1.Handle, nil, PWideChar(ini.ReadString('MLineRadio',
        'FilePath', '')), nil, nil, SW_Hide);
  end;
  if Form2.CheckBox5.Checked = true then
  begin
    if FileExists(ini.ReadString('MLineRadio', 'FilePath', '')) = true then
      LoadToWork(ini.ReadString('MLineRadio', 'FilePath', ''))
    else
    begin
      if Form2.OpenDialog1.Execute = true then
      begin
        ini.WriteString('MLineRadio', 'FilePath', Form2.OpenDialog1.FileName);
        LoadToWork(ini.ReadString('MLineRadio', 'FilePath', ''));
      end;
    end;
  end;
  Form2.Button5.Enabled := ini.ReadBool('General', 'MLineRadio', false);
  case ini.ReadInteger('Helper', 'Type', 0) of
    0:
      begin
        Form2.RadioButton1.Checked := true;
        if Form2.RadioButton1.Checked = true then
        begin
          if pos('-', Form2.Edit1.Text) = 0 then
            Form2.Edit1.Text := Form2.Edit1.Text + '-Chan'
          else
          begin
            Form2.Edit1.Text := copy(Form2.Edit1.Text, 1,
              pos('-', Form2.Edit1.Text) - 1);
            Form2.Edit1.Text := Form2.Edit1.Text + '-Chan';
          end;
        end;
      end;
    1:
      begin
        Form2.RadioButton1.Checked := true;
        if Form2.RadioButton1.Checked = true then
        begin
          if pos('-', Form2.Edit1.Text) = 0 then
            Form2.Edit1.Text := Form2.Edit1.Text + '-Chan'
          else
          begin
            Form2.Edit1.Text := copy(Form2.Edit1.Text, 1,
              pos('-', Form2.Edit1.Text) - 1);
            Form2.Edit1.Text := Form2.Edit1.Text + '-Chan';
          end;
        end;
      end;
    2:
      begin
        Form2.RadioButton2.Checked := true;
        if Form2.RadioButton2.Checked = true then
        begin
          if pos('-', Form2.Edit1.Text) = 0 then
            Form2.Edit1.Text := Form2.Edit1.Text + '-Kun'
          else
          begin
            Form2.Edit1.Text := copy(Form2.Edit1.Text, 1,
              pos('-', Form2.Edit1.Text) - 1);
            Form2.Edit1.Text := Form2.Edit1.Text + '-Kun';
          end;
        end;
      end;
    3:
      begin
        Form2.RadioButton3.Checked := true;
        if Form2.RadioButton3.Checked = true then
        begin
          if pos('-', Form2.Edit1.Text) = 0 then
            Form2.Edit1.Text := Form2.Edit1.Text
          else
          begin
            Form2.Edit1.Text := copy(Form2.Edit1.Text, 1,
              pos('-', Form2.Edit1.Text) - 1);
            Form2.Edit1.Text := Form2.Edit1.Text;
          end;
        end;
      end
  else
    begin
      Form2.RadioButton1.Checked := true;
      if Form2.RadioButton1.Checked = true then
      begin
        if pos('-', Form2.Edit1.Text) = 0 then
          Form2.Edit1.Text := Form2.Edit1.Text + '-Chan'
        else
        begin
          Form2.Edit1.Text := copy(Form2.Edit1.Text, 1,
            pos('-', Form2.Edit1.Text) - 1);
          Form2.Edit1.Text := Form2.Edit1.Text + '-Chan';
        end;
      end;
    end;
  end;

  if (ini.ReadInteger('Helper', 'Type', 0) = 1) or
    (ini.ReadInteger('Helper', 'Type', 0) = 0) then
  begin
    if FileExists(extractfilepath(paramstr(0)) +'Resources\ChanLook_1.png') then
      Form4.Image1.Picture.LoadFromFile(extractfilepath(paramstr(0)) +'Resources\ChanLook_1.png')
    else
    begin
      dllok := Form4.LoadResDLL;
      if dllok = true then
      begin
        Pict := TPNGImage.Create;
        Pict.LoadFromResourceName(resdll, 'Chan_2');
        Form4.Image1.Picture.Graphic := Pict;
        Pict.Free;
      end;
      Form4.FreeResDLL;
    end;
  end;
  if ini.ReadInteger('Helper', 'Type', 0) = 2 then
  begin
    if FileExists(extractfilepath(paramstr(0)) +'Resources\KunLook_1.png') then
      Form4.Image1.Picture.LoadFromFile(extractfilepath(paramstr(0)) +'Resources\KunLook_1.png')
    else
    begin
      dllok := Form4.LoadResDLL;
      if dllok = true then
      begin
        Pict := TPNGImage.Create;
        Pict.LoadFromResourceName(resdll, 'Kun_1');
        Form4.Image1.Picture.Graphic := Pict;
        Pict.Free;
      end;
      Form4.FreeResDLL;
    end;
  end;
  Form4.Height := Form4.Image1.Height;
  Form4.Width := Form4.Image1.Width;
  Form4.Left := Screen.WorkAreaWidth;
  Form4.Top := Screen.WorkAreaHeight - Form4.Height;

  form5.Combobox1.Text := inttostr(voll);
  Form2.Label2.Caption := ':' + inttostr(Form2.TrackBar2.Position) + '%';
  Form2.Label9.Caption := ':' + inttostr(Form2.TrackBar3.Position) + '%';
  Form2.Label10.Caption := ':' + inttostr(Form2.TrackBar7.Position) + '%';
  Form2.Label11.Caption := ':' + inttostr(Form2.TrackBar4.Position) + '%';
  Form2.Label13.Caption := ':' + inttostr(Form2.TrackBar6.Position) + '%';
  Form2.Label12.Caption := ':' + inttostr(Form2.TrackBar5.Position) + '%';
  form8.edit3.Enabled := form8.CheckBox1.Checked;
  form8.Button7.Enabled := form8.CheckBox1.Checked;
  form3.Edit1.Enabled := form3.CheckBox5.Checked;
  form3.Button1.Enabled := form3.CheckBox5.Checked;
  form3.edit3.Enabled := form3.checkbox6.Checked;
  form3.Combobox1.Enabled := form3.checkbox6.Checked;
  form3.Button2.Enabled := form3.checkbox6.Checked;
  Form1.ComboBox1.Text := FormatDateTime('dd.mm.yyyy', Date());
  Form1.MaskEdit1.Text := FormatDateTime('hh:mm', Time()) ;

     /// ///////////////////////////tables

  if pos(',', tmp) <> 0 then
  begin
    for i := 0 to 6 do
    begin

      Randfr[i].value := strtoint(copy(tmp, 1, pos(',', tmp) - 1));
      Randfr[i].check := false;
      tmp := copy(tmp, pos(',', tmp) + 1, tmp.Length);
    end;
  end
  else
  begin
    for i := 0 to 6 do
    begin
      Randfr[i].value := 0;
      Randfr[i].check := false;
    end;
  end;
  randcount := 0;
    Form1.FDConnection1.Params.Database := extractfilepath(paramstr(0))+'Events.db';
    Form1.FDConnection1.Connected := true;
  if Form1.FDConnection1.Connected then
  begin

    Form1.FDQuery1.Open('select * from  Events;');
    Form1.FDTableEvents.Open('Events');
    Form1.FDTableEvents.Active := true;

    Form1.CheckBase;
    Form1.StringGridBindSourceDB1.EditorMode := true;
    Form1.StringGridBindSourceDB1.DefaultColWidth := 70;
    Form1.StringGridBindSourceDB1.DefaultRowHeight := 25;
    Form1.StringGridBindSourceDB1.ColWidths[0] := 30;
    Form1.StringGridBindSourceDB1.ColWidths[1] := 100;
    Form1.StringGridBindSourceDB1.ColWidths[2] := 85;
    Form1.StringGridBindSourceDB1.ColWidths[3] := 210;
    Form7.FDQuery1.Open('select * from  Wellcomes;');
    Form7.FDTable1.Open('Wellcomes');
    Form7.FDTable1.Active := true;
    form8.FDQuery1.Open('select * from  Factsru;');
    form8.FDTable1.Open('Factsru');
    form8.FDTable1.Active := true;

    form8.FDQuery2.Open('select * from Factsen;');
    form8.FDTable2.Open('Factsen');
    form8.FDTable2.Active := true;

            Form5.FDQuery1.Open('select * from  Frases;');
          Form5.FDTable1.Open('Frases');
          Form5.FDTable1.Active := true;
  end;

  /// //////////////////////////////////not extra timers
  Form4.Timer1.Enabled := true;
  Form4.Timer4.Enabled := true;
  if form5.CheckBox4.Checked = true then
    form5.Timer1.Enabled := true;
  form5.Timer4.Enabled := form5.CheckBox5.Checked;
  form3.Timer1.Enabled := form3.CheckBox4.Checked;
  form3.Timer2.Enabled := form3.CheckBox5.Checked;
  form3.Timer4.Enabled := form3.checkbox6.Checked;
  ini.Free;
end;

begin

end.
