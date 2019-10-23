unit SkypeSetUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs,SKYPE4COMLib_TLB, Vcl.OleCtrls,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids, IniFiles, Vcl.ComCtrls, Tlhelp32,
  Vcl.ExtCtrls, Vcl.Forms;

  type
  SkCall = Record
    status : string;
    ind : integer;
  End;

type
  TForm5 = class(TForm)
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    DataSource1: TDataSource;
    FDQuery1Answer: TWideMemoField;
    FDQuery1Question: TWideMemoField;
    FDQuery1id: TIntegerField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit4: TEdit;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    CheckBox4: TCheckBox;
    Edit5: TEdit;
    Timer1: TTimer;
    Button3: TButton;
    Timer3: TTimer;
    Timer2: TTimer;
    GroupBox4: TGroupBox;
    CheckBox5: TCheckBox;
    ComboBox1: TComboBox;
    Button4: TButton;
    Timer4: TTimer;
    Timer5: TTimer;
    Timer6: TTimer;
    Timer7: TTimer;
    CheckBox6: TCheckBox;
    Edit6: TEdit;
     procedure SkypeOnMessageStatus(Sender : TObject; const pMessage : IChatMessage; Status: TOleEnum);
    procedure FDQuery1QuestionGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FDQuery1AnswerGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SkypeOnCallStatus(Sender : TObject; const pCall : ICall; Status: TOleEnum);
    procedure CheckBox3Click(Sender: TObject);
    procedure SkypeOnGroupUsers(Sender : TObject;const pGroup : IGroup;const  pUsers: IUserCollection);
    procedure CheckBox4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SendFile(user : string);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    function IsRunning(sName: string): boolean;
    procedure Timer7Timer(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
  private

    { Private declarations }
  public
   // procedure loadC;
    { Public declarations }
  end;

var
  Form5: TForm5;
   Skype:TSkype;
   user : string;
   procstring : string;
   automute : array of integer;
   voll : integer;
  st : array [1..6] of string;
implementation

{$R *.dfm}

uses  SettingsUI, Main, MLineRadioSetUI, MessUI,Clientcom, SkFriendListUI;



procedure TForm5.SendFile(user : string);
begin
 if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
 begin
    Skype.Client.OpenFileTransferDialog(user,'D:\');
 end;
end;



function TForm5.IsRunning(sName: string): boolean;
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


procedure TForm5.SkypeOnGroupUsers(Sender : TObject; const pGroup : IGroup; const pUsers: IUserCollection);
begin
// if CheckBox3.Checked = true then
 //   begin
 //   pGroup.Decline;
 //  pGroup.Share(Edit4.Text);
 //   end;
 //  ShowMessage(pgroup.DisplayName+' 55');
end;

procedure TForm5.SkypeOnCallStatus(Sender : TObject; const pCall : ICall; Status: TOleEnum);
begin
//Calls.Add(pCall);
//Skype.ca
//Timer4.Enabled := true;
    //ShowMessage(Skype.Convert.CallStatusToText(pCall.Status));
end;

 procedure TForm5.SkypeOnMessageStatus(Sender : TObject; const pMessage : IChatMessage; Status: TOleEnum);
var
i : integer;
 begin
   FDTable1.First;
    user := pMessage.Sender.Handle;
    if (CheckBox2.Checked = true) and (Skype.Convert.ChatMessageStatusToText(Status)= 'Received') then
        begin
            for I := 0 to FDTable1.RecordCount-1 do
            begin
              if pMessage.Body = FDTable1.FieldByName('Question').AsString then
                begin
                  Skype.SendMessage(pMessage.Sender.Handle,'('+Form2.Edit1.Text+') '+FDTable1.FieldByName('Answer').AsString)  ;
                    //break;
                       FDTable1.First;
                          pMessage.Seen := True;
                        exit;
                  end;
                  FDTable1.Next;
              end;
            if (CheckBox1.Checked = true) and (Edit1.Text <> '') then
              begin
               Skype.SendMessage(pMessage.Sender.Handle,'('+Form2.Edit1.Text+') '+Edit1.Text)  ;
                pMessage.Seen := True;
                exit;
              end;
        end;
            if (CheckBox2.Checked = false) and (CheckBox1.Checked = true) and (Edit1.Text <> '') and (Skype.Convert.ChatMessageStatusToText(Status)= 'Received') then
             begin
                Skype.SendMessage(pMessage.Sender.Handle,'('+Form2.Edit1.Text+') '+Edit1.text);
                 pMessage.Seen := True;
                 exit;
             end;

end;

procedure TForm5.Timer1Timer(Sender: TObject);
var
list : TStringList;
tmp1 : string;
i,j,c : integer;
begin
      Timer1.Enabled := false;
      list := TStringList.Create;
      j := 0;
      if CheckBox4.Checked = true then
      begin
      if Skype <> nil then
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
                         SetLength(automute,list.Count);
                      for I := 0 to list.Count-1 do
                        begin
                           if (IsRunning(list[i]) = true) and (automute[i] = 0) then
                            begin
                            if(checkbox6.Checked = true) and (edit6.Text <> '') then
                              begin
                                 for c := 1 to skype.ActiveCalls.Count do
                                   begin
                                     if skype.Convert.CallStatusToText(skype.ActiveCalls.Item[c].Status) = 'Call in Progress' then
                                        begin
                                          if skype.ActiveCalls.Item[c].ConferenceId <>0 then
                                          begin

                                          end
                                          else
                                          begin
                                          Form4.SendMess('p('+Skype.ActiveCalls.Item[c].PartnerHandle+','+Edit6.Text+')');
                                          end;
                                        end;
                                   end;
                              end;
                              Skype.Mute := true;
                             automute[i] := 1;
                             Timer2.Enabled := true;
                            end;
                        end; //list parse
                    end //edit has ','
                    else
                    begin
                    SetLength(automute,1);
                    if (IsRunning(procstring) = true) and (automute[0] = 0) then
                    begin
                    if(checkbox6.Checked = true) and (edit6.Text <> '') then
                              begin
                                 for c := 1 to skype.ActiveCalls.Count do
                                   begin
                                     if skype.Convert.CallStatusToText(skype.ActiveCalls.Item[c].Status) = 'Call in Progress' then
                                        begin
                                          if skype.ActiveCalls.Item[c].ConferenceId <>0 then
                                          begin

                                          end
                                          else
                                          begin
                                            Form4.SendMess('p('+Skype.ActiveCalls.Item[c].PartnerHandle+','+Edit6.Text+')');
                                          end;
                                        end;
                                   end;
                              end;
                       Skype.Mute := true;
                       automute[0] := 1;
                       Timer2.Enabled := true;
                       list.free;
                       exit;
                    end;
                    end;  //edit has no ','

              end;//edit <> ''

        end;
      end; //checkbox = true
   if checkbox4.Checked = true then
    Timer1.Enabled := true;
      list.free;
end;

procedure TForm5.Timer2Timer(Sender: TObject);
var
list : TStringList;
tmp1 : string;
i,j : integer;
begin
Timer2.Enabled := false;
    list := TStringList.Create;

    j := 0;
    if CheckBox4.Checked = true then
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
                         SetLength(automute,list.Count);
                      for I := 0 to list.Count-1 do
                        begin
                           if (IsRunning(list[i]) = false) and (automute[i] = 1) then
                            begin
                              //Skype.Mute := true;
                             automute[i] := 0;
                              Timer1.Enabled :=  true;
                            end;
                        end; //list parse
                    end //edit has ','
                    else
                    begin
                    SetLength(automute,1);
                    if (IsRunning(procstring) = false) and (automute[0] = 1) then
                    begin
                       //Skype.Mute := true;
                       automute[0] := 0;
                       Timer1.Enabled := true;
                       list.free;
                       exit;
                    end;
                    end;  //edit has no ','

              end;//edit <> ''

end;
Timer2.Enabled := true;
list.free;
end;

procedure TForm5.Timer3Timer(Sender: TObject);
var
 ini : TIniFile;
begin

Timer3.Enabled := false;

if Form2.checkBox2.Checked = false then
begin
  if Skype <>nil then
  skype.Free;

 Timer3.Enabled := true  ;
 Exit;
end;
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');

    if (ini.ReadBool('General','Skype',false) = true) or (Form2.CheckBox2.Checked = true) then
  begin
    Skype:=SKYPE4COMLib_TLB.TSkype.Create(Self);
      if Skype.Client.IsRunning = true then
    begin
        Skype.Attach(6,false);
        Skype.OnMessageStatus := SkypeOnMessagestatus;
      //  Skype.OnCallStatus :=  SkypeOnCallStatus;
       //Skype.OnGroupUsers := SkypeOnGroupUsers;
      if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
      begin
              if Form1.FDConnection1.Connected = true then
        begin
  
          Timer6.Enabled := true;
          Form1.Sendfileto1.Enabled := true;
           //Timer4.Enabled := true;
          end;
          timer7.Enabled := true;
      Timer3.Enabled := false;
      ini.Free;
      Exit;
      end;
      end;

      Timer3.Enabled := true;
  end;
ini.Free;
end;

procedure TForm5.Timer4Timer(Sender: TObject);
var
//list : TStringList;
  tmp : string;
i : integer;
begin
//list := TStringList.Create;
//if Fileexists('log1.txt') then
//list.LoadFromFile('log1.txt');
   //CallStatus;
   Timer4.Enabled := false;
 //list := TStringList.Create;
 // list.LoadFromFile('log.txt');
 if checkbox5.Checked = false then
    exit;
  if Skype <> nil then
     begin
      if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
        begin
        if IsServRunning = 0 then
           begin
            for i:=1 to Skype.ActiveCalls.Count do
              begin
                if st[i] = '' then
                  begin
                    st[i] := Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status);
              //     list.Add(Skype.ActiveCalls.Item[i].PartnerHandle + ' : '+ st[i]) ;

                      if (CheckBox5.Checked = true) and (Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status)= 'Call in Progress') then
                          begin
                              if IsServRunning = 0 then
                              SetVolumeLv(voll);

                          end;
                      end;
                 //list.Add(Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status));
                    tmp := Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status);
                    if st[i] <> Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status) then
                      begin
           //            list.Add(Skype.ActiveCalls.Item[i].PartnerHandle + ' : '+ st[i]) ;
                          st[i] := Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status);
                        if (CheckBox5.Checked = true) and (Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status)= 'Call in Progress') then
                          begin                //// set volume
                       if IsServRunning = 0 then
                              SetVolumeLv(voll);

                          end;
                      end;
              end;

           end;
               if Skype.ActiveCalls.Count < 6 then
                    begin
                      for i := Skype.ActiveCalls.Count+1 to 6 do
                        begin
                          st[i] := '';
                        end;
                    end;
             end;
        end;

    // list.SaveToFile('Log1.txt');
    // list.Free;
    //  list.SaveToFile('log.txt');
    //  list.Free;
    if checkbox5.Checked = true then
      Timer4.Enabled  := true;

end;

procedure TForm5.Timer5Timer(Sender: TObject);
   var
i : integer;
begin
   //CallStatus;
   Timer5.Enabled := false;
    if checkbox3.Checked = false then
    exit;
 //list := TStringList.Create;
 // list.LoadFromFile('log.txt');
  if Skype <> nil then
     begin
      if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
        begin
            for i:=1 to Skype.ActiveCalls.Count do
              begin
                if st[i] = '' then
                  begin
                    st[i] := Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status);
              //     list.Add(Skype.ActiveCalls.Item[i].PartnerHandle + ' : '+ st[i]) ;
                      if (CheckBox3.Checked = true) and (Skype.Convert.CallStatusToText(Skype.ActiveCalls.Item[i].Status)= 'Calling') then
                      begin
                      Form4.SendMess('p('+Skype.ActiveCalls.Item[i].PartnerHandle+','+Edit4.Text+')');
                        Skype.ActiveCalls.Item[i].Finish;
                           break;
                        //Skype.SendMessage(Skype.ActiveCalls.Item[i].PartnerHandle,Edit4.Text);
                      end;
                      end;
              end;
               end;
               if Skype.ActiveCalls.Count < 6 then
                    begin
                      for i := Skype.ActiveCalls.Count+1 to 6 do
                        begin
                          st[i] := '';
                        end;
                    end;

        end;


    //  list.SaveToFile('log.txt');
    //  list.Free;
    if checkbox3.Checked = true then
      Timer5.Enabled  := true;


end;

procedure TForm5.Timer6Timer(Sender: TObject);
var
tmp : string;
begin
timer6.Enabled := false;
  tmp := GetSkypeMess;
  if IsServRunning = 0 then
     begin
       if Skype <> nil then
           begin
             if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
                 begin
                   if tmp <> '' then
                        begin
                            dotype := 2;
                            mess := tmp;
                            Form9.Show;
                        end;
                 end;
           end;
     end;
timer6.Enabled := true;
end;

procedure TForm5.Timer7Timer(Sender: TObject);
begin
Timer7.Enabled := false;
if Skype <> nil then
    begin
    if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) <> 'Success' then
      begin
         if Skype.Client.IsRunning = true then
          begin
            Skype.Attach(6,false);
          end;
      end;
    end;
    timer7.Enabled := true;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
   Form5.FDTable1.Insert;
   if (Form5.Edit2.Text <> '') and (Form5.Edit3.Text <> '') then
      begin
     Form5.FDTable1.FieldByName('Question').AsString :=  Form5.Edit2.Text;
     Form5.FDTable1.FieldByName('Answer').AsString := Form5.Edit3.Text;
     Form5.FDTable1.Post;
  Form5.FDQuery1.Active := false;
   Form5.FDQuery1.Active := true;
      end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
tmp : string;
begin
tmp := 'DELETE FROM '+FDTable1.TableName+' WHERE '+DBGrid1.SelectedField.FieldName+'="'+DBGrid1.SelectedField.AsString+'";';
Form1.FDConnection1.ExecSQL(tmp);
 FDQuery1.Active := false;
   FDQuery1.Active := true;
end;

procedure TForm5.Button3Click(Sender: TObject);
var
tmp : string;
i : integer;
begin
Timer1.Enabled := False;
tmp := Edit5.Text;
  procstring := '';
if tmp.Chars[tmp.Length-1] = ',' then
begin
  for I := 0 to tmp.Length-2 do
    procstring := procstring + tmp.Chars[i];
    Edit5.Text :=  procstring;
end
else
procstring := Edit5.Text;
SetLength(automute,0);
if checkbox4.Checked = true then
Timer1.Enabled := true
else
 Timer1.Enabled := false;
end;

procedure TForm5.Button4Click(Sender: TObject);
var
  ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
voll := strtoint(Combobox1.Text);
  ini.WriteInteger('Skype','VolAnswer',voll);
  ini.Free;
end;

procedure TForm5.CheckBox1Click(Sender: TObject);
var
 ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
  ini.WriteBool('Skype','Autoanswer',CheckBox1.Checked);
  Edit1.Enabled := CheckBox1.Checked;
  ini.Free;
end;

procedure TForm5.CheckBox2Click(Sender: TObject);
var
 ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
ini.WriteBool('Skype','template',CheckBox2.Checked);
   ini.Free;
end;

procedure TForm5.CheckBox3Click(Sender: TObject);
begin
    Edit4.Enabled := CheckBox3.Checked;
      Form1.Autoanswer1.Checked := CheckBox3.Checked;
      Timer5.Enabled := checkbox3.Checked;
end;

procedure TForm5.CheckBox4Click(Sender: TObject);
var
 ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
ini.WriteBool('Skype','Automute',CheckBox4.Checked);
Edit5.Enabled := CheckBox4.Checked;
Button3.Enabled :=  CheckBox4.Checked;
SetLength(automute,0);
Timer1.Enabled := CheckBox4.Checked;
  ini.Free;
end;

procedure TForm5.CheckBox5Click(Sender: TObject);
begin
  ComboBox1.Enabled := CheckBox5.Checked;
Button4.Enabled :=  CheckBox5.Checked;
Timer4.Enabled :=  CheckBox5.Checked;
end;

procedure TForm5.CheckBox6Click(Sender: TObject);
var
 ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
ini.WriteBool('Skype','sendifmute',CheckBox6.Checked);
Edit6.Enabled := CheckBox6.Checked;

  ini.Free;
end;

procedure TForm5.FDQuery1AnswerGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
     Text := Sender.AsString;
end;

procedure TForm5.FDQuery1QuestionGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
   Text := Sender.AsString;
end;

procedure TForm5.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
    ini.WriteString('Skype','Autotext',Edit1.Text);
    ini.WriteString('Skype','Autocalltext',Edit4.Text);
    ini.WriteString('Skype','Automuteproc',Edit5.Text);
    ini.WriteInteger('Skype','VolAnswer',voll);
    ini.WriteBool('Skype','VolAnswerEn',CheckBox5.Checked);
    ini.WriteString('Skype','ifmutestr',edit6.text);
    ini.Free;
end;
{
procedure TForm5.loadC;
var
 ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
Form5.CheckBox1.Checked := ini.ReadBool('Skype','Autoanswer',false) ;
Form5.Edit1.Enabled :=    ini.ReadBool('Skype','Autoanswer',false) ;
Form5.CheckBox2.Checked := ini.ReadBool('Skype','template',false);


 Form5.Edit1.Text := ini.ReadString('Skype','Autotext','')  ;
 Form5.Edit4.Text := ini.ReadString('Skype','Autocalltext','')  ;
 Form5.edit6.text := ini.ReadString('Skype','ifmutestr','');
 Form5.Edit5.Enabled := ini.ReadBool('Skype','Automute',false);
 Form5.Button3.Enabled := ini.ReadBool('Skype','Automute',false);
 Form5.Edit5.Text := ini.ReadString('Skype','Automuteproc','');
  procstring :=  ini.ReadString('Skype','Automuteproc','');
   Form5.CheckBox4.Checked := ini.ReadBool('Skype','Automute',false);
  Form5.CheckBox6.Checked := ini.ReadBool('Skype','sendifmute',false);
  Form5.edit6.Enabled :=  ini.ReadBool('Skype','sendifmute',false);
if Form5.CheckBox4.Checked = true then
    Form5.Timer1.Enabled := true;
   voll := ini.ReadInteger('Skype','VolAnswer',5);
   Form5.ComboBox1.Text := inttostr(voll);
   Form5.CheckBox5.Checked := ini.ReadBool('Skype','VolAnswerEn',false);
      Form5.Timer4.Enabled :=  CheckBox5.Checked;

  ini.Free;
end;}


end.
