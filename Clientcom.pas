unit Clientcom;

interface

uses IniFiles,Windows, Messages, SysUtils, Variants, Classes,ShellApi;


type
Eventst = record
  Data : string;
  Time : string;
  Event : string
end;

function StopWorking(deltemp : boolean) : integer;
 function LoadToWork(workplace : string) : integer;
  function GetCurrentSongTitle : string;
 function Playing : integer;
  function SetStop : integer;
   function SetVolumeLv(value : integer) : integer;
    function SetPlay : integer;
    function IsServRunning : integer;
    function GetEvent : Eventst;
    function GetSkypeMess : string;


var
working : boolean = false;
//client : boolean = false;
workplace : string;
iniserv,iniclient : TIniFile;

implementation

 /////////////////////////////////////////////////


/// 0 - good
/// 1 - can't create dir
/// 2 - can't create file
/////////////////////////////////////////////////

function LoadToWork(workplace : string) : integer;
 begin
    if DirectoryExists(extractfilepath(workplace)+'Comun') = false then
    begin
        if not ForceDirectories(extractfilepath(workplace)+'Comun') then
        begin
        result := 1;
        exit;
        end;
    end;
    workplace :=extractfilepath(workplace)+'Comun';
    iniserv := TIniFile.Create(workplace + '\serv.ini');
    iniclient := TIniFile.Create(workplace + '\client.ini');
    if (iniserv = nil) or (iniclient = nil) then
    begin
      result := 2;
      exit;
    end;
    iniclient.WriteBool('Client','Working',true);
    working := true;
    result := 0;
 end;

  /////////////////////////////////////////////////
/// 0 - good
/// 1 - can't delete files
/////////////////////////////////////////////////
 function StopWorking(deltemp : boolean) : integer;
 begin
    if (iniclient <> nil) or  (working = true) then
     begin
      iniclient.WriteBool('Client','Working',false);
      freeandnil(iniclient);
     end;
        if deltemp = true then
         begin
            if not (DeleteFile(workplace + '\client.ini'))
          or not (DeleteFile(workplace + '\client.ini')) then
            result := 1;
         end;

    working := false;
    result := 0;
 end;

 function GetCurrentSongTitle : string;
 begin
  if working = false then
     begin
       result := '';
       exit;
     end;
   if iniserv = nil then
   begin
     result := '';
     exit;
   end
   else
   begin
         result := iniserv.ReadString('Server','TitleSong','');
   end;
 end;

 function Playing : integer;
 begin
       if working = false then
     begin
       result := -1;
       exit;
     end;
   if iniserv = nil then
   begin
     result := 1;
     exit;
   end
   else
   begin
  if iniserv.ReadBool('Server','Playing',false) = true then
         result := 0
         else
         result := 2;
   end;
 end;

  function SetPlay : integer;
  begin
  if working = false then
     begin
       result := -1;
       exit;
     end;
   if iniclient = nil then
   begin
     result := 1;
     exit;
   end
   else
   begin
     iniclient.WriteInteger('Client','Play',99);
     result := 0;
   end;
  end;

    function SetStop : integer;
  begin
  if working = false then
     begin
       result := -1;
       exit;
     end;
   if iniclient = nil then
   begin
     result := 1;
     exit;
   end
   else
   begin
     iniclient.WriteInteger('Client','Stop',99);
     result := 0;
   end;
  end;

  function SetVolumeLv(value : integer) : integer;
  begin
      if working = false then
     begin
       result := -1;
       exit;
     end;
        if iniclient = nil then
   begin
     result := 1;
     exit;
   end
   else
   begin
     iniclient.WriteInteger('Client','Vol',value);
     result := 0;
   end;
  end;

  function IsServRunning : integer;
  begin
         if working = false then
     begin
       result := -1;
       exit;
     end;
  if iniserv = nil then
   begin
     result := 1;
     exit;
   end
   else
   begin
    if iniserv.ReadBool('Server','Working',false) = true then
     result := 0
     else
     result := 2;
   end;
  end;


  function GetEvent : Eventst;
   begin
    if working = false then
     begin
       result.Data := '';
       result.Time := '';
       result.Event := '';
       exit;
     end;
       if iniserv = nil then
   begin
       result.Data := '';
       result.Time := '';
       result.Event :='';
       exit;
   end
       else
   begin
    if iniserv.ReadBool('Server','Working',false) = true then
    begin
        result.Data := iniserv.ReadString('Eventadd','Data','');
       result.Time := iniserv.ReadString('Eventadd','Time','');
       result.Event := iniserv.ReadString('Eventadd','Event','');
       iniserv.WriteString('Eventadd','Data','');
       iniserv.WriteString('Eventadd','Time','');
       iniserv.WriteString('Eventadd','Event','');
    end
     else
     begin
        result.Data := '';
       result.Time := '';
       result.Event :='';
     end;
   end;
   end;


   function GetSkypeMess : string;
   begin
         if working = false then
     begin
        result := '';
       exit;
     end;
      if iniserv = nil then
   begin
       result := '';
       exit;
   end
       else
   begin
      result := iniserv.ReadString('Server','SkypeMess','');
        iniserv.WriteString('Server','SkypeMess','');
   end;

   end;


end.
