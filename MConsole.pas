unit MConsole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,ShellApi,Tlhelp32,
  Vcl.ExtCtrls, IniFiles;

type
  TForm10 = class(TForm)
    RichEdit1: TRichEdit;
    Edit1: TEdit;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
  private

  protected
  procedure WndProc(var Msg: TMessage); override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;
  hist : TStringList;
  currposhist : integer;
  script : TStringList;
  working : boolean;
        MWM_LBUTTONDOWN : Cardinal;
  MWM_LBUTTONUP :Cardinal;
  MWM_MBUTTONDOWN :Cardinal;
  MWM_MBUTTONUP :Cardinal;
  MWM_RBUTTONDOWN :Cardinal;
  MWM_RBUTTONUP :Cardinal;
  MWM_MOUSEWHEEL :Cardinal;
  MWM_MOUSEMOVE :Cardinal;
  MWM_LBUTTONDBLCLK :Cardinal;
  clicklog : TStringList;
  filepath : string;
  clo : boolean;
  namespace : integer;
implementation

{$R *.dfm}

uses FactSetUI, Main, MessUI, MLineRadioSetUI, SettingsUI, SkFriendListUI,
  SkypeSetUI, WellcMessSetUI, Loader;

  function StartMouseHook(State: Boolean; Wnd: HWND): Boolean; stdcall; external 'SysMGH.dll';
function StopMouseHook(): Boolean; stdcall; external   'SysMGH.dll';

procedure TForm10.WndProc(var Msg: TMessage);
begin
  inherited;
  if (Msg.Msg = MWM_LBUTTONDBLCLK) then
  begin
          if clicklog <> nil then
       begin
         clicklog.Add('[MWM_LBUTTONDBLCLK] '+inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.y));
         richedit1.Lines.Add('[MWM_LBUTTONDBLCLK] '+inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.y));
       end;
  end;
  if (Msg.Msg = MWM_LBUTTONDOWN) then
  begin
      if clicklog <> nil then
       begin
         clicklog.Add('[MWM_LBUTTONDOWN] '+inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.y));
         richedit1.Lines.Add('[MWM_LBUTTONDOWN] '+inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.y));
       end;
  end;
  if (Msg.Msg = MWM_MBUTTONDOWN) then
  begin

  end;
  if (Msg.Msg = MWM_RBUTTONDOWN) then
  begin
               if clicklog <> nil then
       begin
         clicklog.Add('[MWM_RBUTTONDOWN] '+inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.y));
         richedit1.Lines.Add('[MWM_RBUTTONDOWN] '+inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.y));
       end;
  end;
  if (Msg.Msg = MWM_MOUSEMOVE) then
  begin

  end;
end;

procedure RunDosInMemo(CmdLine: string; AMemo: TRichEdit);
const
  ReadBuffer = 2400;
var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: PAnsichar;
  BytesRead: DWord;
  Apprunning: DWord;
begin
  Screen.Cursor := CrHourGlass;
  Form10.Edit1.Enabled := false;
  with Security do
  begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := true;
    lpsecuritydescriptor := nil;
  end;
  if Createpipe(ReadPipe, WritePipe,
    @Security, 0) then
  begin
    Buffer := AllocMem(ReadBuffer + 1);
    FillChar(Start, Sizeof(Start), #0);
    start.cb := SizeOf(start);
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES +
      STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil,
      PChar(CmdLine),
      @Security,
      @Security,
      true,
      NORMAL_PRIORITY_CLASS,
      nil,
      nil,
      start,
      ProcessInfo) then
    begin
      repeat
        Apprunning := WaitForSingleObject
          (ProcessInfo.hProcess, 100);
        ReadFile(ReadPipe, Buffer[0],
          ReadBuffer, BytesRead, nil);
        Buffer[BytesRead] := #0;
        OemToAnsi(Buffer, Buffer);
        AMemo.Text := AMemo.text + string(Buffer);

        Application.ProcessMessages;
      until (Apprunning <> WAIT_TIMEOUT);
    end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
  Form10.Edit1.Enabled := true;
  Screen.Cursor := CrDefault;
end;





procedure DeleteDirectory(const Name: string);
var
  F: TSearchRec;
begin
  if FindFirst(Name + '\*', faAnyFile, F) = 0 then
  begin
    try
      repeat
        if (F.Attr and faDirectory <> 0) then
        begin
          if (F.Name <> '.') and (F.Name <> '..') then
          begin
            DeleteDirectory(Name + '\' + F.Name);
          end;
        end else
        begin
          DeleteFile(Name + '\' + F.Name);
        end;
      until FindNext(F) <> 0;
      RemoveDir(Name);
    finally
      FindClose(F);
    end;
  end;
end;

  function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

  procedure ShowHelp;
  begin
     Form10.RichEdit1.Lines.Add('=============================================');
     form10.RichEdit1.Lines.Add('[Namespaces]');
     form10.RichEdit1.Lines.Add('Main - Main unit  /done/');
     form10.RichEdit1.Lines.Add('System - universal commands /done/');
     form10.RichEdit1.Lines.Add('Skype - Skype settings unit /in process/');
     form10.RichEdit1.Lines.Add('Settings - Global settings unit');
     form10.RichEdit1.Lines.Add('Message - Message IU unit');
     form10.RichEdit1.Lines.Add('Radio - MLineRadio settings unit');
     form10.RichEdit1.Lines.Add('Welcome - Welcome message settings unit');
     form10.RichEdit1.Lines.Add('Facts - Facts settings unit');
     form10.RichEdit1.Lines.Add('Cmd - Windows command console');
     form10.RichEdit1.Lines.Add('Use "Namespace"."Method(Params)" constructions to get methods from Namwspace.');
     form10.RichEdit1.Lines.Add('=============================================');
  end;

  procedure ShowConsHelp;
  begin
   Form10.RichEdit1.Lines.Add('=============================================');
   Form10.RichEdit1.Lines.Add('[System]');
   Form10.RichEdit1.Lines.Add('Help - guide for current namespace');
   Form10.RichEdit1.Lines.Add('Close - Close Console window');
   Form10.RichEdit1.Lines.Add('Clear - Clear history');
   Form10.RichEdit1.Lines.Add('Console - start system command console');
   Form10.RichEdit1.Lines.Add('Clearcmdbuff - clear command buffer');
   Form10.RichEdit1.Lines.Add('Open(filepath) - start\open file');
   Form10.RichEdit1.Lines.Add('Openurl(URL) - Open URL in default browser');
   Form10.RichEdit1.Lines.Add('Savehistorylog(filepath) - save history to file');
   Form10.RichEdit1.Lines.Add('IsRunning(full process name) - check if process running');
   Form10.RichEdit1.Lines.Add('Terminate(full process name) - Terminate process');
    Form10.RichEdit1.Lines.Add('Wait(milliseconds) - Stop script or console for "XX" milliseconds');
   Form10.RichEdit1.Lines.Add('Script(filepath) - do commands from file');
   Form10.RichEdit1.Lines.Add('Mouselog(on\off) - start log mouse clicks');
   Form10.RichEdit1.Lines.Add('Mouselog(on\off,filepath) - start log mouse clicks and write to file');
   Form10.RichEdit1.Lines.Add('Createdir(directorypath) - force create directory');
   Form10.RichEdit1.Lines.Add('Removedir(directorypath) - remove directory with files');
   Form10.RichEdit1.Lines.Add('LClick(X,Y) - Left mouse click at pos');
   Form10.RichEdit1.Lines.Add('RClick(X,Y) - Right mouse click at pos');
   Form10.RichEdit1.Lines.Add('Rename(oldfilepath,new) - rename file');
   Form10.RichEdit1.Lines.Add('Delete(filepath) - delete file');
   Form10.RichEdit1.Lines.Add('Copy(oldfilepath,newfilepath) - copy file from old directory to new(rename available)');
    Form10.RichEdit1.Lines.Add('Move(oldfilepath,newfilepath) - move file from old directort to new(rename available)');
     Form10.RichEdit1.Lines.Add('Compare(firstfilepath,secondfilepath,outputfile) - compare two files for the same'+
     ' strings and put data to "outputfile"(strings should have same format.)');
    Form10.RichEdit1.Lines.Add('Combine(firstfilepath,secondfilepath,outputfile) - combine two files in one');
   Form10.RichEdit1.Lines.Add('=============================================');
  end;

  procedure ConsoleProc(com : string );
  var
  par1,par2,par3,cmnd,tmp : string;
  list1,list2 : TStringList;
   i,l,j : integer;
   ins : boolean;
  begin
  working := true;
   if pos('(',com) <> 0 then
   begin
       cmnd := copy(com,1,pos('(',com)-1);
        tmp := copy(com,pos('(',com)+1,com.Length-pos('(',com)-1);
           par1 := '';
            par2 := '';
            par3 := '';
        if pos(',',tmp) = 0 then
        begin
          par1 := tmp;
        end;
        if pos(',',tmp) <> 0 then
        begin
          par1 := copy(tmp,1,pos(',',tmp)-1);
          par2 := copy(tmp,pos(',',tmp)+1,tmp.Length);
          if pos(',',par2) <> 0 then
          begin
            par3 := copy(par2,pos(',',par2)+1,par2.Length);
            par2  := copy(par2,1,pos(',',par2)-1);
          end;
        end;
      if (par1 <> '') and (par2 ='') and (par3 = '') then  ///one param
         begin
            if cmnd = 'open' then
            begin
            if fileexists(par1) = true then
               ShellExecute(0, nil,PWideChar(par1), nil, nil, SW_RESTORE)
               else
               form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.open(param)", file does not exist.');
               Working := false;
               Exit;
            end;
            if cmnd = 'openurl' then
            begin
            if (pos('http://',par1)<> 0) or (pos('https://',par1)<> 0) then
               ShellExecute(0, nil,PWideChar(par1), nil, nil, SW_RESTORE)
               else
               form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.openurl(param)", Incorrect URL.');
               Working := false;
               Exit;
            end;
            if cmnd = 'savehistorylog' then
            begin
            if not directoryexists(extractfilepath(par1)) then
                   forcedirectories(extractfilepath(par1));
                   list1 := TStringList.Create;
                   list1.AddStrings(form10.RichEdit1.Lines);
                   list1.SaveToFile(par1);
                   list1.Free;
               form10.RichEdit1.Lines.Add('<Save done. File "'+par1+'" has been created.');
               Working := false;
               Exit;
            end;

            if cmnd = 'isrunning' then
            begin
                if pos('.exe',par1) <> 0 then
                 begin
                    if form5.IsRunning(par1) = true then
                      form10.RichEdit1.Lines.Add('<Process "par1" is running.')
                    else
                      form10.RichEdit1.Lines.Add('<Process "par1" is not running.');
                 end
                 else
                  form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.isrunning(param)", param is not (*).exe file.');
                  Working := false;
                  Exit;
            end;
            if cmnd = 'terminate' then
              begin
                if pos('.exe',par1) <> 0 then
                 begin
                    if form5.IsRunning(par1) = true then
                      begin
                       KillTask(par1);
                      end
                      else
                      form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.terminate(param)", process is not running.');
                 end
              else
                form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.terminate(param)", param is not (*).exe file.');
                Working := false;
                Exit;
              end;
             if cmnd = 'script' then
               begin
               if fileexists(par1) = true then
                   begin
                    script := TStringList.Create;
                    script.LoadFromFile(par1);
                    form10.Timer1.Enabled := true;
                   end
                   else
                    form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.script(param)", file does not exist.');
                    Working := false;
                    Exit;
               end;
               if cmnd = 'wait' then
               begin
               if integer.TryParse(par1,i) = true then
                   begin
                     i := 0;
                     while i < strtoint(par1) do
                     begin
                       form10.Edit1.Enabled := false;
                       Application.ProcessMessages;
                       sleep(10);
                       inc(i,10);
                     end;
                   end
                   else
                    form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.script(param)", file does not exist.');
                    Working := false;
                    Exit;
               end;
               if cmnd = 'createdir' then
               begin
               if not directoryexists(par1) then
                   begin
                   if  forcedirectories(par1) = true then
                     form10.RichEdit1.Lines.Add('<Directory has been created.')
                     else
                     form10.RichEdit1.Lines.Add('<Error at "System.createdir('+par1+')" Cannot create directory.')
                   end
                   else
                    form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.createdir('+par1+')" Directory already exist.') ;
                working := false;
                exit;
               end;
                  if cmnd = 'removedir' then
               begin
               if directoryexists(par1) then
                   begin
                    DeleteDirectory(par1);
                     form10.RichEdit1.Lines.Add('<Directory has been removed.')
                   end
                   else
                    form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.removedir('+par1+')" Directory not exist.') ;
                working := false;
                exit;
               end;
               if cmnd = 'mouselog' then
               begin
                 if par1 = 'on' then
                 begin
                   StartMouseHook(true,form10.Handle);
                 end
                 else
                 begin
                 StartMouseHook(false,form10.Handle);
                 if clicklog <> nil then
                     begin
                      clicklog.SaveToFile(filepath);
                      clicklog.Free;
                     end;
                    filepath := '';
                 end;
                 working := false;
                exit;
               end;
         end;
        if (par1 <> '') and (par2 <>'') and (par3 = '') then ///two params
        begin
          if cmnd = 'lclick' then
          begin
                SetCursorPos(strtoint(par1), strtoint(par2));
                mouse_event(MOUSEEVENTF_LEFTDOWN,MOUSEEVENTF_ABSOLUTE,MOUSEEVENTF_ABSOLUTE,0,0);
                mouse_event(MOUSEEVENTF_LEFTUP,MOUSEEVENTF_ABSOLUTE,MOUSEEVENTF_ABSOLUTE,0,0);
                working := false;
                exit;
          end;
          if cmnd = 'rclick' then
          begin
                SetCursorPos(strtoint(par1), strtoint(par2));
                mouse_event(MOUSEEVENTF_RIGHTDOWN,MOUSEEVENTF_ABSOLUTE,MOUSEEVENTF_ABSOLUTE,0,0);
                mouse_event(MOUSEEVENTF_RIGHTUP,MOUSEEVENTF_ABSOLUTE,MOUSEEVENTF_ABSOLUTE,0,0);
                working := false;
                exit;
          end;
          if cmnd = 'mouselog' then
               begin

                 if par1 = 'on' then
                 begin
                   clicklog := TStringList.Create;
                    if fileexists(par2) = true then
                        begin
                          clicklog.LoadFromFile(par2);
                          clicklog.Add(FormatDateTime('dd\mm\yy', Date())+' =======================================');
                        end;

                  filepath := par2;
                   StartMouseHook(true,form10.Handle);
                 end
                 else
                 begin
                 StartMouseHook(false,form10.Handle);
                 if clicklog <> nil then
                     begin
                    clicklog.SaveToFile(filepath);
                    clicklog.Free;
                     end;

                    filepath := '';
                 end;
                          working := false;
                exit;
               end;
               if cmnd = 'rename' then
              begin
               if fileexists(par1) then
                   begin
                   if  RenameFile(par1,par2) = false then
                     form10.RichEdit1.Lines.Add('<Error at "System.rename('+par1+','+par2+')" Cannot rename file.')
                     else
                     form10.RichEdit1.Lines.Add('<File has been renamed.')
                   end
                   else
                   form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.rename('+par1+')" File does not exist.');
                working := false;
                exit;
              end;
              if cmnd = 'delete' then
              begin
               if fileexists(par1) then
                   begin
                   if  DeleteFile(par1) = false then
                     form10.RichEdit1.Lines.Add('<Error at "System.delete('+par1+','+par2+')" Cannot delete file.')
                     else
                     form10.RichEdit1.Lines.Add('<File has been deleted.')
                   end
                   else
                   form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.delete('+par1+')" File does not exist.');
                working := false;
                exit;
              end;
              if cmnd = 'copy' then
              begin
               if fileexists(par1) then
                   begin
                   if not directoryexists(extractfilepath(par2)) then
                   forcedirectories(extractfilepath(par2));
                   if  CopyFile(PChar(par1),PChar(par2),true) = false then
                     form10.RichEdit1.Lines.Add('<Error at "System.copy('+par1+','+par2+')" Cannot copy file.')
                     else
                     form10.RichEdit1.Lines.Add('<Copy done..')
                   end
                   else
                   form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.copy('+par1+')" File does not exist.');
                working := false;
                exit;
              end;
              if cmnd = 'move' then
              begin
               if fileexists(par1) then
                   begin
                   if not directoryexists(extractfilepath(par2)) then
                   forcedirectories(extractfilepath(par2));
                   if  MoveFile(PChar(par1),PChar(par2)) = false then
                     form10.RichEdit1.Lines.Add('<Error at "System.move('+par1+','+par2+')" Cannot move file.')
                     else
                     form10.RichEdit1.Lines.Add('<Move done..')
                   end
                   else
                   form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.move('+par1+')" File does not exist.');
                working := false;
                exit;
              end;
        end;
        if (par1 <> '') and (par2 <>'') and (par3 <> '') then ///three params
         begin
            if cmnd = 'compare' then
              begin
               if fileexists(par1) then
                   begin
                    if fileexists(par2) then
                    begin
                    form10.Edit1.Enabled := false;
                      if not directoryexists(extractfilepath(par3)) then
                        forcedirectories(extractfilepath(par3));
                        list1 := TStringList.Create;
                        list2 := TStringList.Create;
                        list1.LoadFromFile(par1);
                        list2.LoadFromFile(par2);
                        list1.AddStrings(list2);
                        list2.Clear;
                         ins := false;
                         i := 0;
                      for l := 0 to list1.Count-1 do
                        begin
                        if list2.Count <> 0 then
                          begin
                          for j := 0 to list2.Count-1 do
                            begin
                               if list1[l] = list2[j] then
                               begin
                                 ins := true;
                                 inc(i);
                                 break;
                               end;
                               ins := false;
                            end;
                          end
                          else
                          begin
                           ins := false;
                          end;
                            if ins = false then
                            begin
                              list2.Add(list1[l]);
                              ins := true;
                            end;
                        end;
                          list2.SaveToFile(par3);
                        list1.Free;
                        list2.Free;
                        form10.Edit1.Enabled := true;
                       form10.RichEdit1.Lines.Add('<Compare done. File "'+par3+'" created. Copies '+inttostr(i)+' found.');
                    end
                    else
                    form10.RichEdit1.Lines.Add('<Incorrect patameter in "System.compare('+par1+','+par2+')" Second file does not exist.');
                   end
                   else
                    form10.RichEdit1.Lines.Add('<Incorrect patameter in "System.compare('+par1+','+par2+')" First file does not exist.');
                working := false;
                exit;
              end;
              if cmnd = 'combine' then
              begin
               if fileexists(par1) then
                   begin
                       if fileexists(par2) then
                    begin
                    form10.Edit1.Enabled := false;
                        if not directoryexists(extractfilepath(par3)) then
                        forcedirectories(extractfilepath(par3));
                        list1 := TStringList.Create;
                        list2 := TStringList.Create;
                        list1.LoadFromFile(par1);
                        list2.LoadFromFile(par2);
                         list1.AddStrings(list2);
                         list1.SaveToFile(par3);
                         form10.Edit1.Enabled := true;
                         form10.RichEdit1.Lines.Add('<Combine done. File "'+par3+'" has been created.');
                        list1.Free;
                        list2.Free;
                    end
                    else
                      form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.combine('+par1+','+par2+','+par3+')" Second file does not exist.');
                   end
                   else
                   form10.RichEdit1.Lines.Add('<Incorrect parameter in "System.combine('+par1+','+par2+','+par3+')" First file does not exist.');
                working := false;
                exit;
              end;

         end;
   end
   else
   begin
     if com = 'help' then
     begin
        ShowConsHelp;
        Working := false;
        Exit;
     end;
          if com = 'clear' then
     begin
     Form10.RichEdit1.Clear;
     Working := false;
     Exit;
     end;
          if com = 'clearcmdbuff' then
     begin
     hist.Clear;
     currposhist := 0;
     Working := false;
     Exit;
     end;
          if com = 'console' then
     begin
     ShellExecute(0, nil,'cmd.exe', nil, nil, SW_RESTORE);
     Working := false;
     Exit;
     end;
          if com = 'close' then
      begin
      Form10.Hide;
      clo := true;
      Working := false;
      Exit;
      end;


   end;

    Form10.RichEdit1.Lines.Add('<Incorrect method "'+com+'" in System namespace.');

  end;

  procedure ShowMainHelp;
  begin
   Form10.RichEdit1.Lines.Add('=============================================');
   Form10.RichEdit1.Lines.Add('[Main]');
     Form10.RichEdit1.Lines.Add('Help - guide for current namespace');
     Form10.RichEdit1.Lines.Add('Close - close MLineHelper');
     Form10.RichEdit1.Lines.Add('Hide - hide main window');
     Form10.RichEdit1.Lines.Add('Show - show main window');
     Form10.RichEdit1.Lines.Add('Update - update database');
     Form10.RichEdit1.Lines.Add('Showtables - show names of all tables');
     Form10.RichEdit1.Lines.Add('Add(date\command,time,event) - add record to Event table with params');
     Form10.RichEdit1.Lines.Add('Randfromdb(table,textfield) - random from "db" and return value from "textfield"');
     Form10.RichEdit1.Lines.Add('Randfromdb(table,titlefield,textfield) - random from "db" and return value from "titlefield" and "textfield"');
     Form10.RichEdit1.Lines.Add('Dbcount(table) - return count of records in "table"');
   Form10.RichEdit1.Lines.Add('=============================================');
  end;

    procedure MainProc(com : string );
  var
  par1,par2,par3,cmnd,tmp, tmp1: string;
  i : integer;
  begin
  working := true;
   if pos('(',com) <> 0 then
   begin
       cmnd := copy(com,1,pos('(',com)-1);
        tmp := copy(com,pos('(',com)+1,com.Length-pos('(',com)-1);
           par1 := '';
            par2 := '';
            par3 := '';
        if pos(',',tmp) = 0 then
        begin
          par1 := tmp;
        end;
        if pos(',',tmp) <> 0 then
        begin
          par1 := copy(tmp,1,pos(',',tmp)-1);
          par2 := copy(tmp,pos(',',tmp)+1,tmp.Length);
          if pos(',',par2) <> 0 then
          begin
            par3 := copy(par2,pos(',',par2)+1,par2.Length);
            par2  := copy(par2,1,pos(',',par2)-1);
          end;
        end;
              if (par1 <> '') and (par2 ='') and (par3 = '') then  ///one param
         begin
                  if cmnd = 'dbcount' then
                    begin
                         for i := 0 to 9 do
                           begin
                             if (string(tabl[i].name).ToLower = par1) and (tabl[i].name <> 'vvv') then
                              begin
                                  Form1.FDQuery2.Active := false;
                                    Form1.FDQuery2.SQL.Clear;
                                  Form1.FDQuery2.SQL.Add('select count (*) from '+par1+';');
                                    Form1.FDQuery2.Active := true;
                                  Form10.RichEdit1.Lines.Add('<"'+par1+'" table contain '+Form1.FDQuery2.Fields[0].AsString+' records.');
                                  Working := false;
                                  Exit;
                              end;
                           end;
                          Form10.RichEdit1.Lines.Add('<Incorrect parameter in "Main.dbcount('+par1+')" Table not exist.');
                        Working := false;
                      Exit;
                    end;



         end;
                       if (par1 <> '') and (par2 <>'') and (par3 = '') then  ///two param
         begin
             if cmnd = 'randfromdb' then
                    begin
                         for i := 0 to 9 do
                           begin
                             if (string(tabl[i].name).ToLower = par1) and (tabl[i].name <> 'vvv') then
                              begin
                                  if pos(par2,string(tabl[i].fields).ToLower) <> 0 then
                                   begin
                                   Form10.RichEdit1.Lines.Add('<');
                                   Form10.RichEdit1.Lines.Add(form1.Randfromdb(par1,'',par2));
                                   Form10.RichEdit1.Lines.Add('<');
                                  Working := false;
                                  Exit;
                                   end;
                              end;
                           end;
                          Form10.RichEdit1.Lines.Add('<Incorrect parameter in "Main.randfromdb('+par1+','+par2+')" Incorrect params.');
                        Working := false;
                      Exit;
                    end;
         end;
                 if (par1 <> '') and (par2 <>'') and (par3 <> '') then ///three params
         begin
                      if cmnd = 'add' then
                    begin
                           Form1.FDTableEvents.Insert;
                          if (par1 <> '') and (par1 <> '') and (par1 <>'') then
                           begin
                                Form1.FDTableEvents.FieldByName('Data').AsString := par1;
                                  Form1.FDTableEvents.FieldByName('Event').AsString := par3;
                                Form1.FDTableEvents.FieldByName('Time').AsString := par2;
                                  Form1.FDTableEvents.Post;
                                Form1.FDQuery1.Active := false;
                                  Form1.FDQuery1.Active := true;
                                Form10.RichEdit1.Lines.Add('<Record has been added.');
                               Form1.CheckBase;
                            end
                            else
                            Form10.RichEdit1.Lines.Add('<Incorrect parameter in "Main.add('+par1+','+par2+','+par3+')" Incorrect params.');
                    Working := false;
                    Exit;
                    end;
                                 if cmnd = 'randfromdb' then
                    begin
                         for i := 0 to 9 do
                           begin
                             if (string(tabl[i].name).ToLower = par1) and (tabl[i].name <> 'vvv') then
                              begin
                                  if (pos(par2,string(tabl[i].fields).ToLower) <> 0) and (pos(par3,string(tabl[i].fields).ToLower) <> 0) then
                                   begin
                                   Form10.RichEdit1.Lines.Add('<');
                                   tmp1 := form1.Randfromdb(par1,par2,par3);
                                    Form10.RichEdit1.Lines.Add(copy(tmp1,1,pos('&&&',tmp1)-1));
                                    Form10.RichEdit1.Lines.Add(copy(tmp1,pos('&&&',tmp1)+3,tmp1.Length-pos('&&&',tmp1)+3));
                                   Form10.RichEdit1.Lines.Add('<');
                                  Working := false;
                                  Exit;
                                   end;
                              end;
                           end;
                          Form10.RichEdit1.Lines.Add('<Incorrect parameter in "Main.randfromdb('+par1+','+par2+','+par3+')" Incorrect params.');
                        Working := false;
                      Exit;
                    end;
         end;

   end
   else
   begin
      if com = 'close' then
      begin
      Form10.Hide;
      clo := true;
      Working := false;
      Form1.Close;
      Exit;
      end;
           if com = 'help' then
     begin
        ShowMainHelp;
        Working := false;
        Exit;
     end;
            if com = 'hide' then
     begin
          ShowWindow(Form1.Handle, SW_HIDE);
        Working := false;
        Exit;
     end;
     if com = 'show' then
     begin
        ShowWindow(Form1.Handle, SW_RESTORE);
       SetForegroundWindow(Form1.Handle);
        Working := false;
        Exit;
     end;
          if com = 'update' then
     begin
        form1.CheckBase;
        Form10.RichEdit1.Lines.Add('<Event database has been reloaded.');
        Working := false;
        Exit;
     end;
               if com = 'showtables' then
     begin
        Form10.RichEdit1.Lines.Add('<Tables from Events.db');
        for I := 0 to 9 do
          begin
            if tabl[i].name <> 'vvv' then
             Form10.RichEdit1.Lines.Add(tabl[i].name);
          end;
        Form10.RichEdit1.Lines.Add('<Done.');
        Working := false;
        Exit;
     end;
   end;


    Form10.RichEdit1.Lines.Add('<Incorrect method "'+com+'" in Main namespace.');
  end;

    procedure ShowSkypeHelp;
  begin
   Form10.RichEdit1.Lines.Add('=============================================');
   Form10.RichEdit1.Lines.Add('[Skype]');
     Form10.RichEdit1.Lines.Add('Help - guide for current namespace');  //+
     Form10.RichEdit1.Lines.Add('Close - hide Skype settings window');  //+
     Form10.RichEdit1.Lines.Add('Show - show Skype settings window');  //+
     Form10.RichEdit1.Lines.Add('Mute - mute in Skype');
     Form10.RichEdit1.Lines.Add('Finish - finish current call');
     Form10.RichEdit1.Lines.Add('Showautomutestatus - show auto mute list and status');//+
     Form10.RichEdit1.Lines.Add('Uniautoans(on/off,phrase) - enable universal answer to skype message and set phrase');  //+
     Form10.RichEdit1.Lines.Add('Uniautoans(on/off) - enable universal answer to skype message'); //+
     Form10.RichEdit1.Lines.Add('Autoanstocall(on/off,phrase) - enable auto answer to call in skype and set phrase'); //+
     Form10.RichEdit1.Lines.Add('Muteifrunning(on/off,process name) - enable auto mute skype if process running and add process to list');
     Form10.RichEdit1.Lines.Add('Muteifrunning(on/off) - enable auto mute skype if process running');
     Form10.RichEdit1.Lines.Add('Sendmesifmute(on/off,phrase) - enable send message if skype has been muted and set phrase');
     Form10.RichEdit1.Lines.Add('Sendmesifmute(on/off) - enable send message if skype has been muted');
     Form10.RichEdit1.Lines.Add('Setvolifanswer(on/off,level) - enable set volume level if answer to call and set level');
     Form10.RichEdit1.Lines.Add('Setvolifanswer(on/off) - enable set volume level if answer to call');
     Form10.RichEdit1.Lines.Add('Callto(NIK Skype) - call to somebody');
     Form10.RichEdit1.Lines.Add('Autoanstocall(on/off) - enable auto answer to call in skype');  //+
     Form10.RichEdit1.Lines.Add('Template(on/off) - enable template usage'); //+
     Form10.RichEdit1.Lines.Add('Automute(on/off) - enable auto mute');  //+
     Form10.RichEdit1.Lines.Add('Addproctoautomute(process name) - add process name to auto mute list'); //+
     Form10.RichEdit1.Lines.Add('Delprocfromautomute(process name) - delete process name from auto mute list if it exist'); //+
     Form10.RichEdit1.Lines.Add('Add(question,answer) - add record to the table');//+
   Form10.RichEdit1.Lines.Add('=============================================');
  end;

  procedure SkypeProc(com : string );
  var
  par1,par2,par3,cmnd,tmp ,tmp1: string;

 ini : TIniFile;
  begin
  working := true;
   if pos('(',com) <> 0 then
   begin
       cmnd := copy(com,1,pos('(',com)-1);
        tmp := copy(com,pos('(',com)+1,com.Length-pos('(',com)-1);
           par1 := '';
            par2 := '';
            par3 := '';
        if pos(',',tmp) = 0 then
        begin
          par1 := tmp;
        end;
        if pos(',',tmp) <> 0 then
        begin
          par1 := copy(tmp,1,pos(',',tmp)-1);
          par2 := copy(tmp,pos(',',tmp)+1,tmp.Length);
          if pos(',',par2) <> 0 then
          begin
            par3 := copy(par2,pos(',',par2)+1,par2.Length);
            par2  := copy(par2,1,pos(',',par2)-1);
          end;
          end;
          if (par1 <> '') and (par2 ='') and (par3 = '') then  ///one param
         begin
                if cmnd = 'template' then
                    begin
                       if par1 = 'on' then
                       begin
                         Form5.CheckBox2.Checked := true;
                         Form10.RichEdit1.Lines.Add('<Use template state : ON.');
                       end
                       else
                       begin
                       Form5.CheckBox2.Checked := false;
                       Form10.RichEdit1.Lines.Add('<Use template state : OFF.');
                       end;
                       ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
                        ini.WriteBool('Skype','template',Form2.CheckBox2.Checked);
                        ini.Free;
                        Working := false;
                      Exit;
                    end;

                    if cmnd = 'automute' then
                    begin
                       if par1 = 'on' then
                       begin
                         Form5.CheckBox4.Checked := true;
                         Form10.RichEdit1.Lines.Add('<Use automute state : ON.');
                       end
                       else
                       begin
                       Form5.CheckBox4.Checked := false;
                       Form10.RichEdit1.Lines.Add('<Use automute state : OFF.');
                       end;
                     ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
                      ini.WriteBool('Skype','Automute',Form5.CheckBox4.Checked);
                        Form5.Edit5.Enabled := Form5.CheckBox4.Checked;
                          Form5.Button3.Enabled :=  Form5.CheckBox4.Checked;
                        SetLength(automute,0);
                      Form5.Timer1.Enabled := Form5.CheckBox4.Checked;
                      ini.Free;
                      Working := false;
                      Exit;
                    end;

                        if cmnd = 'addproctoautomute' then
                    begin
                    if Form5.Edit5.Text <> '' then
                      Form5.Edit5.Text := Form5.Edit5.Text +','+ par1
                      else
                       Form5.Edit5.Text := par1;
                       Form5.Button3.Click;
                       Form10.RichEdit1.Lines.Add('<"'+par1+'" added to automute list.');
                       Working := false;
                      Exit;
                    end;
                                if cmnd = 'delprocfromautomute' then
                    begin
                    if Form5.Edit5.Text <> '' then
                     begin
                       if pos(par1,Form5.Edit5.Text)  <> 0 then
                        begin
                          tmp1 := Form5.Edit5.Text;
                          if pos(par1,tmp1) = 1 then
                          begin
                            tmp1 := copy(tmp1,par1.Length,tmp1.Length - par1.Length);
                          end
                          else
                          begin
                          tmp1 := copy(tmp1,1,pos(par1,tmp1)-2) +
                          copy(tmp1,pos(par1,tmp1)+par1.Length,tmp1.Length-pos(par1,tmp1)+par1.Length) ;
                          end;
                          Form5.Edit5.Text := tmp1;
                        end
                        else
                         Form10.RichEdit1.Lines.Add('<Incorrect paremeter in "Skype.delprocfromautomute('+par1+')" Process name not found in automute list.');
                     end
                     else
                       Form10.RichEdit1.Lines.Add('<Error at "Skype.delprocfromautomute('+par1+')" Automute list is empty.');

                       Working := false;
                      Exit;
                    end;
                    if cmnd = 'uniautoans' then
            begin
                                     if form5.Edit1.Text = '' then
                      Form10.RichEdit1.Lines.Add('<Warning! Answer string is empty.');
                   if par1 = 'on' then
                       begin
                         Form5.CheckBox1.Checked := true;
                         Form10.RichEdit1.Lines.Add('<Use universal answer to skype message state : ON.');
                       end
                       else
                       begin
                       Form5.CheckBox1.Checked := false;
                       Form10.RichEdit1.Lines.Add('<Use universal answer to skype message state : OFF.');
                       end;
                  Working := false;
               Exit;
            end ;
                           if cmnd = 'autoanstocall' then
            begin
                      if form5.Edit4.Text = '' then
                      Form10.RichEdit1.Lines.Add('<Warning! Answer string is empty.');
                   if par1 = 'on' then
                       begin
                         Form5.CheckBox3.Checked := true;
                         Form10.RichEdit1.Lines.Add('<Use automute state : ON.');
                       end
                       else
                       begin
                       Form5.CheckBox3.Checked := false;
                       Form10.RichEdit1.Lines.Add('<Use automute state : OFF.');
                       end;
                       Form5.Edit4.Enabled := Form5.CheckBox3.Checked;
                    Form1.Autoanswer1.Checked := Form5.CheckBox3.Checked;
                    Form5.Timer5.Enabled := Form5.checkbox3.Checked;
                  Working := false;
               Exit;
            end ;
         end;
         if (par1 <> '') and (par2 <>'') and (par3 = '') then  ///two param
          begin
          if cmnd = 'add' then
            begin
            try
                  Form5.FDTable1.Insert;

                  Form5.FDTable1.FieldByName('Question').AsString :=  par1;
                  Form5.FDTable1.FieldByName('Answer').AsString := par2;
                  Form5.FDTable1.Post;
                  Form5.FDQuery1.Active := false;
                  Form5.FDQuery1.Active := true;

               Form10.RichEdit1.Lines.Add('<Record has been added.');
               Working := false;
               Exit;
            except
              Form10.RichEdit1.Lines.Add('<Error at "Skype.add('+par1+','+par2+')" Unexpected error.');
              Working := false;
               Exit;
            end;
            end;
            if cmnd = 'uniautoans' then
            begin

                 form5.Edit1.Text := par2;
                   if par1 = 'on' then
                       begin
                         Form5.CheckBox1.Checked := true;
                         Form10.RichEdit1.Lines.Add('<Use universal answer to skype message state : ON.');
                       end
                       else
                       begin
                       Form5.CheckBox1.Checked := false;
                       Form10.RichEdit1.Lines.Add('<Use universal answer to skype message state : OFF.');
                       end;
                 ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
              ini.WriteBool('Skype','Autoanswer',Form5.CheckBox1.Checked);
              Form5.Edit1.Enabled := Form5.CheckBox1.Checked;
                ini.Free;
                  Working := false;
               Exit;
            end ;
              if cmnd = 'autoanstocall' then
            begin
                   form5.Edit4.Text := par2;
                   if par1 = 'on' then
                       begin
                         Form5.CheckBox3.Checked := true;
                         Form10.RichEdit1.Lines.Add('<Use automute state : ON.');
                       end
                       else
                       begin
                       Form5.CheckBox3.Checked := false;
                       Form10.RichEdit1.Lines.Add('<Use automute state : OFF.');
                       end;
                       Form5.Edit4.Enabled := Form5.CheckBox3.Checked;
                    Form1.Autoanswer1.Checked := Form5.CheckBox3.Checked;
                    Form5.Timer5.Enabled := Form5.checkbox3.Checked;
                  Working := false;
               Exit;
            end ;
          end;


          end
         else
          begin
          if com = 'showautomutestatus' then
     begin
          if Form5.CheckBox4.Checked = true then
         Form10.RichEdit1.Lines.Add('<Use automute state : ON.')
         else
          Form10.RichEdit1.Lines.Add('<Use automute state : OFF.');
          Form10.RichEdit1.Lines.Add('<Automute list : '+procstring+'.');
        Working := false;
        Exit;
     end;
           if com = 'help' then
     begin
        ShowSkypeHelp;
        Working := false;
        Exit;
     end;
            if com = 'close' then
     begin
          Form5.Close;
        Working := false;
        Exit;
     end;
     if com = 'show' then
     begin
        Form5.Show;
       SetForegroundWindow(Form5.Handle);
        Working := false;
        Exit;
     end;

          end;






      Form10.RichEdit1.Lines.Add('<Incorrect method "'+com+'" in Skype namespace.');
  end;

  procedure comexe(comd : string) ;
  var
     tmp : string;
     inwork : boolean;
  begin
      tmp := string(comd).ToLower;
       form10.RichEdit1.Lines.Add('>'+tmp);
       inwork := false;
/////////////////////////////////////////////
if pos('system',tmp) = 1 then
begin
  if pos('.',tmp) <> 0 then
  ConsoleProc(copy(tmp,8,Length(tmp)-7))
  else
  begin
  namespace := 1;
  form10.RichEdit1.Lines.Add('<System namespace is chosen');
  end;
  inwork := true;
end;
if pos('main',tmp) = 1 then
begin
  if pos('.',tmp) <> 0 then
MainProc(copy(tmp,6,Length(tmp)-5))
  else
  begin
  namespace := 2;
  form10.RichEdit1.Lines.Add('<Main namespace is chosen');
  end;
   inwork := true;
end;
if pos('skype',tmp) = 1 then
begin
       if pos('.',tmp) <> 0 then
SkypeProc(copy(tmp,7,Length(tmp)-6))
  else
  begin
  namespace := 3;
  form10.RichEdit1.Lines.Add('<Skype namespace is chosen');
  end;
    inwork := true;
end;
if pos('radio',tmp) = 1 then
begin
        if pos('.',tmp) <> 0 then
//////
  else
  begin
  namespace := 4;
  form10.RichEdit1.Lines.Add('<Radio namespace is chosen');
  end;
    inwork := true;
end;
if pos('welcome',tmp) = 1 then
begin
            if pos('.',tmp) <> 0 then
//////
  else
  begin
  namespace := 5;
  form10.RichEdit1.Lines.Add('<Welcome namespace is chosen');
  end;
    inwork := true;
end;
if pos('facts',tmp) = 1 then
begin
        if pos('.',tmp) <> 0 then
//////
  else
  begin
  namespace := 6;
  form10.RichEdit1.Lines.Add('<Facts namespace is chosen');
  end;
    inwork := true;
end;
if pos('settings',tmp) = 1 then
begin
        if pos('.',tmp) <> 0 then
//////
  else
  begin
  namespace := 7;
  form10.RichEdit1.Lines.Add('<Settings namespace is chosen');
  end;
    inwork := true;
end;
if pos('message',tmp) = 1 then
begin
        if pos('.',tmp) <> 0 then
//////
  else
  begin
  namespace := 8;
  form10.RichEdit1.Lines.Add('<Message namespace is chosen');
  end;
    inwork := true;
end;
if pos('cmd',tmp) = 1 then
begin
        if pos('.',tmp) <> 0 then
//////
  else
  begin
  namespace := 9;
  form10.RichEdit1.Lines.Add('<Cmd namespace is chosen');
  end;
    inwork := true;
end;
if (tmp = 'help') or (tmp = '?') then
begin
ShowHelp;
inwork := true;
end;

   if inwork = false then
    begin
   case namespace of
     1 : //system
     begin
        ConsoleProc(tmp);
     end;
     2 : //main
     begin
       MainProc(tmp);
     end;
     3 :  //skype
     begin
       SkypeProc(tmp);
     end;
     9 : //cmd
     begin
        RunDosInMemo(tmp, Form10.RichEdit1) ;
     end;
   end;
    end;

          hist.Add(form10.Edit1.Text);
             currposhist  := hist.Count;
          form10.Edit1.text := '';
          if Form10.Showing = true then
          form10.Edit1.SetFocus;


  end;

procedure TForm10.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

      if Key = VK_Return then
begin
if Edit1.Text <> '' then
    begin
        comexe(string(Edit1.Text).ToLower);
    end;

end;

  if Key = VK_UP then
  begin
   if currposhist = 0 then
        currposhist := 1;
     if (currposhist > 0) and (currposhist <= hist.Count) then
     begin
     if currposhist = hist.Count then
     begin
       dec(currposhist) ;
       dec(currposhist) ;
     end
     else
     dec(currposhist) ;
       if currposhist < 0 then
          currposhist := 0;

       if currposhist >= 0 then
      edit1.Text := hist[currposhist];

     end;
      edit1.SelStart := Length(edit1.Text)+1;
  end;
   if Key = VK_Down then
  begin
  if currposhist <0 then
     currposhist := 0;
     if (currposhist >= 0) and (currposhist <= hist.Count) then
     begin
        if currposhist < hist.Count then
      inc(currposhist) ;
      if currposhist <> hist.Count then
       edit1.Text := hist[currposhist]
       else
        edit1.Text := hist[currposhist-1];

     end;
     if hist.Count = 1 then
     begin
       edit1.Text := hist[0];
     end;

     edit1.SelStart := Length(edit1.Text)+1;
  end;
end;

procedure TForm10.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then Key := #0;
end;

procedure TForm10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if clicklog <> nil then
begin
clicklog.SaveToFile(filepath);
clicklog.Free;
end;

hist.Free;
end;

procedure TForm10.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
canclose := clo;
Form10.Hide;
 clo := true;
end;

procedure TForm10.FormCreate(Sender: TObject);
var
llod : TLoader;
begin
 llod := TLoader.Create;
 llod.Loadallex;
 llod.Free;
hist := TStringList.Create;
currposhist := 0;
working := false;
namespace := 1;
clo := true;

end;

procedure TForm10.FormShow(Sender: TObject);
begin
Edit1.SetFocus;
clo := false;
end;

procedure TForm10.RichEdit1Change(Sender: TObject);
begin
if form10.Showing = true then
begin
   RichEdit1.SetFocus;
RichEdit1.SelStart := RichEdit1.GetTextLen;
RichEdit1.Perform(EM_SCROLLCARET, 0, 0);
end;
end;

procedure TForm10.Timer1Timer(Sender: TObject);
var
i : integer;
begin
Timer1.Enabled := false;
   for I := 0 to script.Count-1 do
   begin
   while working = true do
   begin
     Application.ProcessMessages;
     Sleep(10);
   end;
    script[i] := Script[i].ToLower;
   if pos('console.script',script[i]) <>0 then
   begin
        richedit1.Lines.Add('<Detected command "console.script" and skipped.');
        continue;
   end;
       if pos('script',script[i]) = 1 then
       begin
       richedit1.Lines.Add('<Detected command "console.script" and skipped.');
        continue;
       end;

     Edit1.Text := script[i];
      comexe(string(edit1.Text).ToLower);
   end;
   richedit1.Lines.Add('<Process done.');
script.Free;
end;

initialization
  MWM_LBUTTONDOWN := RegisterWindowMessage('MWM_LBUTTONDOWN');
  MWM_LBUTTONUP := RegisterWindowMessage('MWM_LBUTTONUP');
  MWM_MBUTTONDOWN := RegisterWindowMessage('MWM_MBUTTONDOWN');
  MWM_MBUTTONUP := RegisterWindowMessage('MWM_MBUTTONUP');
  MWM_RBUTTONDOWN := RegisterWindowMessage('MWM_RBUTTONDOWN');
  MWM_RBUTTONUP := RegisterWindowMessage('MWM_RBUTTONUP');
  MWM_MOUSEWHEEL := RegisterWindowMessage('MWM_MOUSEWHEEL');
  MWM_MOUSEMOVE := RegisterWindowMessage('MWM_MOUSEMOVE');
  MWM_LBUTTONDBLCLK := RegisterWindowMessage('MWM_LBUTTONDBLCLK');

end.
