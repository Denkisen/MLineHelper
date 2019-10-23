unit MLineRadioSetUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Tlhelp32, Vcl.StdCtrls, IniFiles,
  Vcl.Mask, Vcl.ExtCtrls,ShellApi;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    CheckBox6: TCheckBox;
    Label1: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Timer5: TTimer;
    ComboBox1: TComboBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
  //procedure loadC;
    { Public declarations }
  end;

var
  Form3: TForm3;
   procstring,procstring2 : string;
   autostop : array of integer;

   vollvl : array of integer;
      cursongtitle : string;
        voli : integer;
implementation

{$R *.dfm}

uses MessUI, Clientcom;

function IsRunning(sName: string): boolean;
var
  han: THandle;
  ProcStruct: PROCESSENTRY32;
  sID: string;
begin
  Result := false;
  han := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  if han = 0 then
    exit;
  ProcStruct.dwSize := sizeof(PROCESSENTRY32);
  if Process32First(han, ProcStruct) then
  begin
    repeat
      sID := ExtractFileName(ProcStruct.szExeFile);
      if uppercase(copy(sID, 1, length(sName))) = uppercase(sName) then
      begin
        Result := true;
        Break;
      end;
    until not Process32Next(han, ProcStruct);
  end;
  CloseHandle(han);
end;


procedure TForm3.Button1Click(Sender: TObject);
   var
tmp : string;
i : integer;
begin
Timer2.Enabled := False;
tmp := Edit1.Text;
  procstring := '';
if tmp.Chars[tmp.Length-1] = ',' then
begin
  for I := 0 to tmp.Length-2 do
    procstring := procstring + tmp.Chars[i];
    Edit1.Text :=  procstring;
end
else
procstring := Edit1.Text;
SetLength(autostop,0);
Timer2.Enabled := true;
end;

procedure TForm3.Button2Click(Sender: TObject);
   var
tmp : string;
i : integer;
begin
Timer4.Enabled := False;
tmp := Edit3.Text;
  procstring := '';
if tmp.Chars[tmp.Length-1] = ',' then
begin
  for I := 0 to tmp.Length-2 do
    procstring2 := procstring2 + tmp.Chars[i];
    Edit3.Text :=  procstring2;
end
  else
procstring2 := Edit3.Text;
voli := strtoint(Combobox1.Text);
SetLength(vollvl,0);
Timer4.Enabled := true;
end;

procedure TForm3.CheckBox1Click(Sender: TObject);
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
     ini.WriteBool('MLineRadio','Run',CheckBox1.Checked);
      if ini.ReadBool('MLineRadio','Run',false)= true then
 begin
   if (not IsRunning('MLine Radio.exe')) and (fileexists(ini.ReadString('MLineRadio','FilePath','')) = true) then
   ShellExecute(Application.Handle, nil, PWideChar(ini.ReadString('MLineRadio','FilePath','')), nil, nil, SW_RESTORE);

 end;
     ini.Free;
    // Timer3.Enabled := CheckBox1.Checked;
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
      ini.WriteBool('MLineRadio','LastRadioPlay',CheckBox2.Checked);
       if IsRunning('MLine Radio.exe') = true then
    begin
      if(IsServRunning = 0) and (Playing <> 0) then
        begin
        SetPlay;
        end;
    end;
     ini.Free;

end;

procedure TForm3.CheckBox4Click(Sender: TObject);
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
      ini.WriteBool('MLineRadio','Songtitle',CheckBox4.Checked);
     ini.Free;
    Timer1.Enabled := CheckBox4.Checked;
end;

procedure TForm3.CheckBox5Click(Sender: TObject);
var
 ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
ini.WriteBool('MLineRadio','Presstop',CheckBox5.Checked);
Edit1.Enabled := CheckBox5.Checked;
Button1.Enabled :=  CheckBox5.Checked;
SetLength(autostop,0);
  Timer2.Enabled := CheckBox5.Checked ;


  ini.Free;
end;

procedure TForm3.CheckBox6Click(Sender: TObject);
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
     ini.WriteBool('MLineRadio','SetVol',CheckBox6.Checked);
     Edit3.Enabled := CheckBox6.Checked;
     Combobox1.Enabled := CheckBox6.Checked;
Button2.Enabled :=  CheckBox6.Checked;
SetLength(vollvl,0);
timer4.Enabled := checkbox6.Checked;
     ini.Free;

end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
     ini.WriteBool('MLineRadio','Run',CheckBox1.Checked);
     ini.WriteBool('MLineRadio','LastRadioPlay',CheckBox2.Checked);
     ini.WriteBool('MLineRadio','Songtitle',CheckBox4.Checked);
     ini.WriteBool('MLineRadio','Presstop',CheckBox5.Checked);
     ini.WriteBool('MLineRadio','SetVol',CheckBox6.Checked);
     ini.WriteString('MLineRadio','StopPrograms',Edit1.Text);
     ini.WriteString('MLineRadio','VolPrograms',Edit3.Text);
         ini.WriteString('MLineRadio','VolLevel',Combobox1.Text);
  ini.Free;
end;
{
procedure TForm3.loadC;
var
ini : TIniFile;
begin
   ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
     Form3.CheckBox1.Checked   :=   ini.ReadBool('MLineRadio','Run',false);
    Form3.CheckBox2.Checked :=  ini.ReadBool('MLineRadio','LastRadioPlay',false);
    Form3.CheckBox4.Checked :=  ini.ReadBool('MLineRadio','Songtitle',false);
    Form3.Timer1.Enabled := Form3.CheckBox4.Checked;
    Form3.CheckBox5.Checked :=  ini.ReadBool('MLineRadio','Presstop',false);
    Form3.Timer2.Enabled := Form3.CheckBox5.Checked ;
    Form3.CheckBox6.Checked := ini.ReadBool('MLineRadio','SetVol',false);
    Form3.timer4.Enabled := Form3.checkbox6.Checked;
    Form3.Edit1.Text :=  ini.ReadString('MLineRadio','StopPrograms','');
    procstring :=  ini.ReadString('MLineRadio','StopPrograms','');
    Form3.Edit3.Text :=  ini.ReadString('MLineRadio','VolPrograms','');
    procstring2 := ini.ReadString('MLineRadio','VolPrograms','');
    Form3.Combobox1.Text  := ini.ReadString('MLineRadio','VolLevel','55');
    voli := ini.ReadInteger('MLineRadio','VolLevel',55);
    cursongtitle := '';
    Form3.Edit1.Enabled := Form3.CheckBox5.Checked;
Form3.Button1.Enabled :=  Form3.CheckBox5.Checked;


          Form3.Edit3.Enabled := Form3.CheckBox6.Checked;
     Form3.Combobox1.Enabled := Form3.CheckBox6.Checked;
Form3.Button2.Enabled :=  Form3.CheckBox6.Checked;
    // Timer3.Enabled := true;
  ini.free;
end;  }

procedure TForm3.Timer1Timer(Sender: TObject);
var
tmp,tmptitle : string;
j,ji : integer;
begin
timer1.Enabled := false;
  if checkbox4.Checked = true then
  begin
    if IsServRunning = 0 then
      begin
       tmptitle :=GetCurrentSongTitle;
         if (tmptitle <> cursongtitle) and (tmptitle <>'') then
           begin
           ///////////////////////////////////////////////////
           if tmptitle.Length-1 <= 40 then
                begin
                  Form4.ShowMess(tmptitle,'MLine Radio','no_sound',-1);
                end;
             if tmptitle.Length-1 > 45 then
               begin
                 j := 45;
                 tmp := tmptitle;
                 while j < tmptitle.Length-1 do
                    begin

                    if j < tmp.Length-1 then
                      begin
                        ji := j;
                          while tmp.Chars[ji] <> ' ' do
                            ji := ji+1;
                          Insert(#13#10,tmp,ji+1);
                        j := ji;
                      end;
                       j := j + 45;
                    end;
                  Form4.ShowMess(tmp,'MLine Radio','no_sound',-1);
               end;
           ////////////////////////////////////////////////////

             cursongtitle :=  tmptitle;
           end;
      end;
     timer1.Enabled := true;
  end;
end;

procedure TForm3.Timer2Timer(Sender: TObject);
var
list : TStringList;
tmp1 : string;
i,j : integer;
begin
      Timer2.Enabled := false;
      list := TStringList.Create;
      j := 0;
      if CheckBox5.Checked = true then
      begin
          if procstring <> '' then
              begin
                if pos(',',procstring) <>0 then
                    begin
                  for I := 0 to procstring.Length do
                     begin
                     tmp1 := '';

                       while (procstring.Chars[j] <> ',') and (procstring.Chars[j] <> #0) do
                           begin
                            tmp1 := tmp1 +  procstring.Chars[j];
                            j:= j +1;
                            end;
                            list.Add(tmp1);
                           if procstring.Chars[j] = #0 then
                              break;
                           j:= j +1;

                          tmp1 := '';

                      end;  //tmp parse
                         SetLength(autostop,list.Count);
                      for I := 0 to list.Count-1 do
                        begin
                           if (IsRunning(list[i]) = true) and (autostop[i] = 0) then
                            begin
                             SetStop;
                             autostop[i] := 1;
                             Timer3.Enabled := true;
                            end;
                        end; //list parse
                    end //edit has ','
                    else
                    begin
                    SetLength(autostop,1);
                    if (IsRunning(procstring) = true) and (autostop[0] = 0) then
                    begin
                     SetStop;
                       autostop[0] := 1;
                       Timer3.Enabled := true;
                       list.free;
                       exit;
                    end;
                    end;  //edit has no ','

              end;//edit <> ''


      end; //checkbox = true
      if checkbox5.Checked = true then
    Timer2.Enabled := true;
      list.free;

end;

procedure TForm3.Timer3Timer(Sender: TObject);
var
list : TStringList;
tmp1 : string;
i,j : integer;
begin
Timer3.Enabled := false;
    list := TStringList.Create;

    j := 0;
    if CheckBox5.Checked = true then
      begin
          if procstring <> '' then
              begin
                if pos(',',procstring) <>0 then
                    begin
                  for I := 0 to procstring.Length do
                     begin
                     tmp1 := '';

                       while (procstring.Chars[j] <> ',') and (procstring.Chars[j] <> #0) do
                           begin
                            tmp1 := tmp1 +  procstring.Chars[j];
                            j:= j +1;
                           end;
                            list.Add(tmp1);
                           if procstring.Chars[j] = #0 then
                              break;
                           j:= j +1;

                          tmp1 := '';

                      end;  //tmp parse
                         SetLength(autostop,list.Count);
                      for I := 0 to list.Count-1 do
                        begin
                           if (IsRunning(list[i]) = false) and (autostop[i] = 1) then
                            begin
                              //Skype.Mute := true;
                             autostop[i] := 0;
                              Timer2.Enabled :=  true;
                            end;
                        end; //list parse
                    end //edit has ','
                    else
                    begin
                    SetLength(autostop,1);
                    if (IsRunning(procstring) = false) and (autostop[0] = 1) then
                    begin
                       //Skype.Mute := true;
                       autostop[0] := 0;
                       Timer2.Enabled := true;
                       list.free;
                       exit;
                    end;
                    end;  //edit has no ','

              end;//edit <> ''

end;
Timer3.Enabled := true;
list.free;

end;

procedure TForm3.Timer4Timer(Sender: TObject);
var
list : TStringList;
tmp1 : string;
i,j : integer;
begin
      Timer4.Enabled := false;
      list := TStringList.Create;
      j := 0;
      if CheckBox6.Checked = true then
      begin
          if procstring2 <> '' then
              begin
                if pos(',',procstring2) <>0 then
                    begin
                  for I := 0 to procstring2.Length do
                     begin
                     tmp1 := '';

                       while (procstring2.Chars[j] <> ',') and (procstring2.Chars[j] <> #0) do
                           begin
                            tmp1 := tmp1 +  procstring2.Chars[j];
                            j:= j +1;
                            end;
                            list.Add(tmp1);
                           if procstring2.Chars[j] = #0 then
                              break;
                           j:= j +1;

                          tmp1 := '';

                      end;  //tmp parse
                         SetLength(vollvl,list.Count);
                      for I := 0 to list.Count-1 do
                        begin
                           if (IsRunning(list[i]) = true) and (vollvl[i] = 0) then
                            begin
                           //  SetStop;
                           SetVolumeLv(voli);
                             vollvl[i] := 1;
                             Timer5.Enabled := true;
                            end;
                        end; //list parse
                    end //edit has ','
                    else
                    begin
                    SetLength(vollvl,1);
                    if (IsRunning(procstring2) = true) and (vollvl[0] = 0) then
                    begin
                    // SetStop;
                    SetVolumeLv(voli);
                       vollvl[0] := 1;
                       Timer5.Enabled := true;
                       list.free;
                       exit;
                    end;
                    end;  //edit has no ','

              end;//edit <> ''


      end; //checkbox = true
     if checkbox6.Checked = true then
    Timer4.Enabled := true;
      list.free;

end;

procedure TForm3.Timer5Timer(Sender: TObject);
var
list : TStringList;
tmp1 : string;
i,j : integer;
begin
Timer5.Enabled := false;
    list := TStringList.Create;

    j := 0;
    if CheckBox6.Checked = true then
      begin
          if procstring2 <> '' then
              begin
                if pos(',',procstring2) <>0 then
                    begin
                  for I := 0 to procstring2.Length do
                     begin
                     tmp1 := '';

                       while (procstring2.Chars[j] <> ',') and (procstring2.Chars[j] <> #0) do
                           begin
                            tmp1 := tmp1 +  procstring2.Chars[j];
                            j:= j +1;
                           end;
                            list.Add(tmp1);
                           if procstring2.Chars[j] = #0 then
                              break;
                           j:= j +1;

                          tmp1 := '';

                      end;  //tmp parse
                         SetLength(vollvl,list.Count);
                      for I := 0 to list.Count-1 do
                        begin
                           if (IsRunning(list[i]) = false) and (vollvl[i] = 1) then
                            begin
                              //Skype.Mute := true;
                             vollvl[i] := 0;
                              Timer4.Enabled :=  true;
                            end;
                        end; //list parse
                    end //edit has ','
                    else
                    begin
                    SetLength(autostop,1);
                    if (IsRunning(procstring2) = false) and (vollvl[0] = 1) then
                    begin
                       //Skype.Mute := true;
                       vollvl[0] := 0;
                       Timer4.Enabled := true;
                       list.free;
                       exit;
                    end;
                    end;  //edit has no ','

              end;//edit <> ''

end;
Timer5.Enabled := true;
list.free;


end;

end.
