unit SettingsUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtDlgs, IniFiles, Registry, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components,Tlhelp32, ShellApi;

type
  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button3: TButton;
    CheckBox3: TCheckBox;
    Button2: TButton;
    BindingsList1: TBindingsList;
    LinkControlToPropertyEnabled: TLinkControlToProperty;
    CheckBox4: TCheckBox;
    Button4: TButton;
    LinkControlToPropertyEnabled2: TLinkControlToProperty;
    CheckBox5: TCheckBox;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    TrackBar2: TTrackBar;
    Label4: TLabel;
    TrackBar3: TTrackBar;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    TrackBar4: TTrackBar;
    Label6: TLabel;
    TrackBar5: TTrackBar;
    Label7: TLabel;
    TrackBar6: TTrackBar;
    Label8: TLabel;
    TrackBar7: TTrackBar;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    CheckBox6: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
  private
    { Private declarations }
  public
 // procedure loadC;
  function IsRunning(sName: string): boolean;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses FactSetUI, Main, SkypeSetUI, WellcMessSetUI, MLineRadioSetUI, Clientcom;



 function TForm2.IsRunning(sName: string): boolean;
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


procedure TForm2.Button1Click(Sender: TObject);
var
 ini : TIniFile;
 reg : TRegistry ;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');

     reg:= TRegistry.Create;
reg.RootKey:=HKEY_LOCAL_MACHINE;
if CheckBox1.Checked = true then
  begin
if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true) then
    begin
reg.WriteString(Form1.Caption , ExtractFilePath(Application.ExeName)+Form1.Caption +'.exe');
reg.CloseKey;
ini.WriteBool('General','Auto',true);
reg.Free;
    end;
  end
  else
    begin
     if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
      begin
      if reg.ValueExists(Form1.Caption) then
      reg.DeleteValue(Form1.Caption);
      reg.CloseKey;
      ini.WriteBool('General','Auto',false);
      reg.Free;
      end;
    end;


if RadioButton1.Checked then
begin
ini.WriteInteger('Helper','Type',1);
end;
if RadioButton2.Checked then
begin
ini.WriteInteger('Helper','Type',2);
end;
      if RadioButton3.Checked then
      begin
      ini.WriteInteger('Helper','Type',3);
      end;

      ini.WriteBool('General','Skype',CheckBox2.Checked);
       ini.WriteBool('General','Wellcome',CheckBox3.Checked);
       ini.WriteBool('General','Facts',checkBox4.Checked);
       ini.WriteBool('General','MLineRadio',CheckBox5.Checked);
       ini.WriteInteger('Sound','Welcome',Form2.TrackBar2.Position);
       ini.WriteInteger('Sound','Facts',Form2.TrackBar3.Position);
       ini.WriteInteger('Sound','Eventbefore',Form2.TrackBar4.Position);
       ini.WriteInteger('Sound','Eventattime',Form2.TrackBar5.Position);
       ini.WriteInteger('Sound','Eventlater',Form2.TrackBar6.Position);
       ini.WriteInteger('Sound','Error',Form2.TrackBar7.Position);
       ini.WriteBool('Sound','Enable',checkbox6.Checked);
      ini.Free;
      Form2.Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
Form7.Show;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
Form5.ShowModal;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
Form8.Show;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
Form3.Show;
end;

procedure TForm2.CheckBox2Click(Sender: TObject);
begin
 Form1.Sendfileto1.Visible := CheckBox2.Checked;
end;

procedure TForm2.CheckBox5Click(Sender: TObject);
var
 ini : TIniFile;
 tmp : string;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
if CheckBox5.Checked = true then
    begin
    if ini.ReadString('MLineRadio','FilePath','') <>'' then
         begin
           if FileExists(ini.ReadString('MLineRadio','FilePath','')) = true then
              begin
                 if ini.ReadBool('MLineRadio','Run',false) = true then
                     begin
                       if IsRunning('MLine Radio.exe') = false then
                       //   ShellExecute(Handle, 'open', PChar(ini.ReadString('MLineRadio','FilePath','')), nil, nil, SW_Hide);
                     end;
                     ini.WriteBool('General','MLineRadio',CheckBox5.Checked);
                     tmp := ini.ReadString('MLineRadio','FilePath','') ;
                     Loadtowork(tmp);
              end
              else
              begin
                 if OpenDialog1.Execute = true then
                 begin
                   ini.WriteString('MLineRadio','FilePath',OpenDialog1.FileName);
                     if FileExists(ini.ReadString('MLineRadio','FilePath','')) = true then
                      begin
                          if ini.ReadBool('MLineRadio','Run',false) = true then
                            begin
                            if IsRunning('MLine Radio.exe') = false then
                             // ShellExecute(Handle, 'open', PChar(ini.ReadString('MLineRadio','FilePath','')), nil, nil, SW_Hide);
                            end;
                             ini.WriteBool('General','MLineRadio',CheckBox5.Checked);
                             tmp := ini.ReadString('MLineRadio','FilePath','') ;
                              Loadtowork(tmp);
                      end;
                 end;
              end;
          end
          else
          begin
            if OpenDialog1.Execute = true then
                 begin
                   ini.WriteString('MLineRadio','FilePath',OpenDialog1.FileName);
                     if FileExists(ini.ReadString('MLineRadio','FilePath','')) = true then
                      begin
                          if ini.ReadBool('MLineRadio','Run',false) = true then
                            begin
                            if IsRunning('MLine Radio.exe') = false then
                            //  ShellExecute(Handle, 'open', PChar(ini.ReadString('MLineRadio','FilePath','')), nil, nil, SW_Hide);
                            end;
                            tmp := ini.ReadString('MLineRadio','FilePath','') ;
                            Loadtowork(tmp);
                      end;
                 end;
          end;
    end
    else
    StopWorking(false);

    tmp := '';
    freeandnil(ini);
    // ini.Free;
     Button5.Enabled := CheckBox5.Checked;

end;
{
procedure TForm2.loadC;
var
 ini : TIniFile;
begin
    ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
    Form2.CheckBox2.Checked := ini.ReadBool('General','Skype',false);
    Form1.Sendfileto1.Visible := ini.ReadBool('General','Skype',false);
Edit1.Text := ini.ReadString('Helper','Name','Kuroneko')  ;
 Form2.CheckBox1.Checked := ini.ReadBool('General','Auto',false);
 Form2.CheckBox3.Checked := ini.ReadBool('General','Wellcome',true);
 Form2.Button2.Enabled := ini.ReadBool('General','Wellcome',true);
   Form2.CheckBox4.Checked := ini.ReadBool('General','Facts',false);
 Form2.Button4.Enabled := ini.ReadBool('General','Facts',false);
 Form2.CheckBox5.Checked := ini.ReadBool('General','MLineRadio',false);
   Form2.TrackBar2.Position  := ini.ReadInteger('Sound','Welcome',75);
    Form2.TrackBar3.Position  := ini.ReadInteger('Sound','Facts',75);
     Form2.TrackBar4.Position  := ini.ReadInteger('Sound','Eventbefore',75);
      Form2.TrackBar5.Position  := ini.ReadInteger('Sound','Eventattime',75);
       Form2.TrackBar6.Position  := ini.ReadInteger('Sound','Eventlater',75);
       Form2.TrackBar7.Position := ini.ReadInteger('Sound','Error',75);
       Form2.Label2.Caption :=':'+ inttostr(Form2.TrackBar2.Position)+'%';
        Form2.Label9.Caption :=':'+ inttostr(Form2.TrackBar3.Position)+'%';
         Form2.Label10.Caption := ':'+ inttostr(Form2.TrackBar7.Position)+'%';
         Form2.Label11.Caption := ':' + inttostr(Form2.TrackBar4.Position) + '%';
         Form2.Label13.Caption :=':'+ inttostr(Form2.TrackBar6.Position)+ '%';
         Form2.Label12.Caption :=':' + inttostr(Form2.TrackBar5.Position)+ '%';
         Form2.checkbox6.Checked :=  ini.ReadBool('Sound','Enable',true);
 if ini.ReadBool('MLineRadio','Run',false)= true then
 begin
   if (not Form2.IsRunning('MLine Radio.exe')) and (fileexists(ini.ReadString('MLineRadio','FilePath','')) = true) then
   ShellExecute(Form1.Handle, nil, PWideChar(ini.ReadString('MLineRadio','FilePath','')), nil, nil, SW_Hide);

 end;

 if Form2.checkBox5.Checked = true then
    begin
    if fileexists(ini.ReadString('MLineRadio','FilePath','')) = true then
       LoadToWork(ini.ReadString('MLineRadio','FilePath',''))
       else
        begin
          if Form2.OpenDialog1.Execute = true then
                 begin
                   ini.WriteString('MLineRadio','FilePath',Form2.OpenDialog1.FileName);
                     LoadToWork(ini.ReadString('MLineRadio','FilePath',''));
                  end;
        end;
    end;

 Form2.Button5.Enabled := ini.ReadBool('General','MLineRadio',false);
case ini.ReadInteger('Helper','Type',0) of
     0 :
     begin
     Form2.RadioButton1.Checked := true;
     if Form2.RadioButton1.Checked = true then
    begin
      if pos('-',Form2.Edit1.Text) =0 then
       Form2.Edit1.Text := Edit1.Text +'-Chan'
       else
       begin
       Form2.Edit1.Text := copy(Form2.Edit1.Text,1,pos('-',Form2.Edit1.Text)-1);
        Form2.Edit1.Text := Form2.Edit1.Text +'-Chan';
       end;
    end;
     end;
     1 :
     begin
     Form2.RadioButton1.Checked := true;
          if Form2.RadioButton1.Checked = true then
    begin
      if pos('-',Form2.Edit1.Text) =0 then
       Form2.Edit1.Text := Form2.Edit1.Text +'-Chan'
       else
       begin
       Form2.Edit1.Text := copy(Form2.Edit1.Text,1,pos('-',Form2.Edit1.Text)-1);
        Form2.Edit1.Text := Form2.Edit1.Text +'-Chan';
       end;
    end;
     end;
     2 : begin
      Form2.RadioButton2.Checked := true;
           if Form2.RadioButton2.Checked = true then
    begin
      if pos('-',Form2.Edit1.Text) =0 then
       Form2.Edit1.Text := Form2.Edit1.Text +'-Kun'
       else
       begin
       Form2.Edit1.Text := copy(Form2.Edit1.Text,1,pos('-',Form2.Edit1.Text)-1);
        Form2.Edit1.Text := Form2.Edit1.Text +'-Kun';
       end;
    end;
     end;
     3 : begin
      Form2.RadioButton3.Checked := true;
           if Form2.RadioButton3.Checked = true then
    begin
      if pos('-',Form2.Edit1.Text) =0 then
       Form2.Edit1.Text := Form2.Edit1.Text
       else
       begin
       Form2.Edit1.Text := copy(Form2.Edit1.Text,1,pos('-',Form2.Edit1.Text)-1);
        Form2.Edit1.Text := Form2.Edit1.Text;
       end;
    end;
     end
      else
      begin
      Form2.RadioButton1.Checked := true;
           if Form2.RadioButton1.Checked = true then
    begin
      if pos('-',Form2.Edit1.Text) =0 then
       Form2.Edit1.Text := Form2.Edit1.Text +'-Chan'
       else
       begin
       Form2.Edit1.Text := copy(Form2.Edit1.Text,1,pos('-',Form2.Edit1.Text)-1);
        Form2.Edit1.Text := Form2.Edit1.Text +'-Chan';
       end;
    end;
      end;
end;

   ini.Free;
end; }

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
    if RadioButton1.Checked = true then
    begin
      if pos('-',Edit1.Text) =0 then
       Edit1.Text := Edit1.Text +'-Chan'
       else
       begin
       Edit1.Text := copy(Edit1.Text,1,pos('-',Edit1.Text)-1);
        Edit1.Text := Edit1.Text +'-Chan';
       end;
    end;

end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
     if RadioButton2.Checked = true then
    begin
      if pos('-',Edit1.Text) =0 then
       Edit1.Text := Edit1.Text +'-Kun'
       else
       begin
       Edit1.Text := copy(Edit1.Text,1,pos('-',Edit1.Text)-1);
        Edit1.Text := Edit1.Text +'-Kun';
       end;
    end;
end;

procedure TForm2.RadioButton3Click(Sender: TObject);
begin
      if RadioButton3.Checked = true then
    begin
      if pos('-',Edit1.Text) =0 then
       Edit1.Text := Edit1.Text
       else
       begin
       Edit1.Text := copy(Edit1.Text,1,pos('-',Edit1.Text)-1);
       end;
    end;
end;

procedure TForm2.TrackBar2Change(Sender: TObject);
begin
Label2.Caption :=':'+ inttostr(TrackBar2.Position)+'%';
end;

procedure TForm2.TrackBar3Change(Sender: TObject);
begin
   Label9.Caption :=':'+ inttostr(TrackBar3.Position)+'%';
end;

procedure TForm2.TrackBar4Change(Sender: TObject);
begin
   Label11.Caption := ':' + inttostr(TrackBar4.Position) + '%';
end;

procedure TForm2.TrackBar5Change(Sender: TObject);
begin
    Label12.Caption :=':' + inttostr(TrackBar5.Position)+ '%';
end;

procedure TForm2.TrackBar6Change(Sender: TObject);
begin
    Label13.Caption :=':'+ inttostr(TrackBar6.Position)+ '%';
end;

procedure TForm2.TrackBar7Change(Sender: TObject);
begin
  Label10.Caption := ':'+ inttostr(TrackBar7.Position)+'%';
end;

end.
