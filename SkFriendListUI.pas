unit SkFriendListUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Tlhelp32;

type
  TForm9 = class(TForm)
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;
  userslist : TStringList;
  loadedf : integer;

  ///////////////////////
  ///  0- default
  ///  1- send file
  ///  2- send message
  dotype : integer = 0;
  mess : string;
  ///////////////////////

implementation

{$R *.dfm}

uses Main, SkypeSetUI, MessUI;

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


procedure TForm9.FormCreate(Sender: TObject);
begin
//Timer1.Enabled := true;
  Left:= Screen.WorkAreaWidth-Width;
  Top:= Screen.WorkAreaHeight-Height;
  userslist := TStringList.Create;

end;

procedure TForm9.FormShow(Sender: TObject);
var
i : integer;
begin
if Skype <> nil then
    begin
       if Skype.Client.IsRunning = true then
      begin
      if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
        begin
      userslist.Clear;
      ListBox1.Clear;
          for i := 1 to Skype.Friends.Count do
            begin
            if Skype.Friends.Item[i].FullName <> '' then
            begin
            userslist.Add(Skype.Friends.Item[i].Handle);
              ListBox1.Items.Add(Skype.Friends.Item[i].FullName) ;
            end
              else
              begin
                userslist.Add(Skype.Friends.Item[i].Handle);
               ListBox1.Items.Add(Skype.Friends.Item[i].Handle) ;
              end;
            end;
        end;

      end;
    end;
   SetForegroundWindow(Form9.Handle);
end;

procedure TForm9.ListBox1DblClick(Sender: TObject);
begin
case dotype of
  1 :  Form5.SendFile(userslist.Strings[ListBox1.ItemIndex]);
  2 :  Form4.SendMess('pp('+userslist.Strings[ListBox1.ItemIndex]+','+mess+')');
end;
    dotype := 0;
    mess := '';
  Form9.Close;
end;



end.
