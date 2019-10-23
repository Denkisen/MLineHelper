unit MessUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, ShellApi, IniFiles,DateUtils,bass,Types;

type
  TForm4 = class(TForm)
    BalloonHint1: TBalloonHint;
    Timer1: TTimer;
    Image1: TImage;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
  private

  protected
 procedure CreateParams(var Params:TCreateParams);override;
    { Private declarations }
  public
  procedure ShowH(hintText : string ; hintTitle : string; Point : TRect);
  procedure ShowMess(mess : string; title : string; soundtype : string; vol : integer);
  Procedure Everyweek(com : string;timeto : string; nu : integer; wav : string);
  procedure SendMess(com : string);
  procedure OpenFl(com : string);
  procedure OpenHttp(com : string);
  procedure Everymonth(com : string;timeto : string;nu : integer; wav : string);
  procedure Everyyear(com : string; timeto : string; nu : integer; wav : string);
  function LoadResDLL : boolean;
  function FreeResDLL : boolean;
 // procedure loadC;
    { Public declarations }
  end;

var
  Form4: TForm4;
    wellc : boolean;
 // loadf : integer;
     starttimeh,starttimem : integer;
     privtimeh,pritimem : integer;
     chan : hstream;
     resdll : THandle;

implementation

{$R *.dfm}

uses Main, SkypeSetUI, SettingsUI;


function TForm4.LoadResDLL : boolean;
begin
try
  if resdll <> 0 then
  FreeLibrary(resdll);
  resdll :=  LoadLibrary(PWideChar(extractfilepath(paramstr(0)) +'DataS.Dll'));
  if resdll <> 0 then
     result := true
     else
     result := false;
except
 result := false;
end;
end;

function TForm4.FreeResDLL : boolean;
begin
try
  if resdll <> 0 then
  begin
     FreeLibrary(resdll);
     result := true;
  end
  else
  result := false;
except
  result := false;
end;
end;

procedure Tform4.CreateParams;
begin
 inherited;
 Params.WndParent:= Form1.Handle ;
end;

function Getsound(soundtype : string) : string;
begin

   if (form2.RadioButton1.Checked = true) or (form2.RadioButton3.Checked = true) then
      begin
          if soundtype = 'no_sound' then
            begin
              if FileExists(extractfilepath(paramstr(0)) +'Resources\no_sound.wav') = true then
                result :=  extractfilepath(paramstr(0)) + 'Resources\no_sound.wav'
                else
                  begin
                    result := 'no_sound_wav';
                  end;
                    exit;
            end;

            if soundtype = 'Welcome' then
                begin
                  if FileExists(extractfilepath(paramstr(0)) +'Resources\Chan_Welcome.wav') = true then
                    result :=  extractfilepath(paramstr(0)) + 'Resources\Chan_Welcome.wav'
                      else
                        begin
                        result := 'Chan_Wel_wav';
                        end;
                        exit;
                end;

          if soundtype = 'Mess' then
            begin
              if FileExists(extractfilepath(paramstr(0)) +'Resources\Chan_Mess_1.wav') = true then
                result :=  extractfilepath(paramstr(0)) + 'Resources\Chan_Mess_1.wav'
                else
                  begin
                    result := 'Chan_Mess1_wav';
                  end;
                exit;
            end;

          if soundtype = 'Fact' then
              begin
                if FileExists(extractfilepath(paramstr(0)) +'Resources\Chan_Fact.wav') = true then
                  result :=  extractfilepath(paramstr(0)) + 'Resources\Chan_Fact.wav'
                  else
                    begin
                    result := 'Chan_Fact_wav';
                    end;
                      exit;
              end;

          if soundtype = 'Error' then
              begin
                if FileExists(extractfilepath(paramstr(0)) +'Resources\Chan_Error.wav') = true then
                 result :=  extractfilepath(paramstr(0)) + 'Resources\Chan_Error.wav'
                  else
                    begin
                      result := 'Chan_Error_wav';
                    end;
                      exit;
              end;
           result := 'Chan_Error_wav';
      end;
         if form2.RadioButton2.Checked = true then
      begin
              if soundtype = 'no_sound' then
            begin
              if FileExists(extractfilepath(paramstr(0)) +'Resources\no_sound.wav') = true then
                result :=  extractfilepath(paramstr(0)) + 'Resources\no_sound.wav'
                else
                  begin
                    result := 'no_sound_wav';
                  end;
                    exit;
            end;

           if soundtype = 'Mess' then
              begin
                if FileExists(extractfilepath(paramstr(0)) +'Resources\Kun_Mess_1.wav') = true then
                result :=  extractfilepath(paramstr(0)) + 'Resources\Kun_Mess_1.wav'
                  else
                    begin
                      result := 'Kun_Mess1_wav';
                    end;
                      exit;
              end;
         result := 'Chan_Error_wav';
      end;

result := 'Chan_Error_wav';
end;

procedure TForm4.Everyyear(com : string; timeto : string; nu : integer; wav : string);
var
    tmp, dtmp,ytmp,Day : string;
    h,m,ll,mtmp,htmp,j,ii,jj,mon : integer;
    list : TStringList;
begin
    list := TStringList.Create;
       mon := MonthOfTheYear(date);
       Day := FormatDateTime('dd', date());
    h := strtoint(FormatDateTime('hh', Time()));
    m := strtoint(copy(FormatDateTime('hh:mm', Time()),pos(':',FormatDateTime('hh:mm', Time()))+1,FormatDateTime('hh:mm', Time()).Length));
  if (pos(':',timeto)<>0) then
      begin
        htmp := strtoint(copy(timeto,1,pos(':',timeto)-1));
        mtmp  := strtoint(copy(timeto,pos(':',timeto)+1,timeto.Length) );
      end
        else
      begin
        htmp := 12;
        mtmp := 0;
      end;
         for ll := pos('(',com) to pos(',',com)-1 do
          begin
          if com.Chars[ll] <> ',' then
            dtmp := dtmp + com.Chars[ll];
          end;
                 for ll := pos(',',com) to pos(')',com)-1 do
          begin
          if com.Chars[ll] <> ')' then
            ytmp := ytmp + com.Chars[ll];
          end;

    if (mon = strtoint(dtmp)) and (ytmp = Day) then
      begin
          if (h = htmp - 1) and (Hints[nu].Event.Chars[0] <> '%') then
                 begin
                     if Hints[nu].Rel = 0 then
                  begin
                    Form4.ShowMess(Hints[nu].Event,'Today at '+Hints[nu].Time,wav,Form2.TrackBar4.Position);
                    Hints[nu].Rel := 1;
                  end;
                 end;

              if (h = htmp) and (m = mtmp) then
                begin
                if (Hints[nu].Rel = 0) or (Hints[nu].Rel = 1) or (Hints[nu].Rel = 2) then
                  begin
                    if Hints[nu].Event.Chars[0] <> '%' then
                    begin
                      Form4.ShowMess(Hints[nu].Event,'Now!',wav,Form2.TrackBar5.Position);
                      Hints[nu].Rel := 3;
                    end
                    else//non command event
                    begin
                      list.Clear;
                      j :=1;
                      for ii := 1 to Hints[nu].Event.Length-1 do
                      begin
                        tmp := '';
                        while (Hints[nu].Event.Chars[j] <> ';') and (Hints[nu].Event.Chars[j] <> #0)  do
                          begin
                            tmp := tmp + Hints[nu].Event.Chars[j];
                            j := j+1;
                          end;
                        if Hints[nu].Event.Chars[j] = #0 then
                          break;
                        list.Add(tmp);
                        j := j+1;
                      end;  //if command in line
                      for jj := 0 to list.Count-1 do
                      begin
                        com :='';
                        ////////////////////////////////
                        for ii := 0 to list[jj].Length-1 do
                          begin
                            if list[jj].Chars[ii] <> '(' then
                              com := com + list[jj].Chars[ii]
                            else
                            break;
                          end;
                          if com = 'Open' then
                          begin
                            Form4.OpenFL(list[jj]);
                            Continue;
                          end;
                          if com = 'Http' then
                          begin
                            Form4.OpenHttp(list[jj]);
                            Continue;
                          end;
                          if com = 'SendMess' then
                          begin
                            Form4.SendMess(list[jj]);
                            Continue;
                          end;


                          ShowMess(com,'Now!',wav,Form2.TrackBar5.Position);

                      end;  //  ///////////////////////////commands
                        Hints[nu].Rel := 3;
                    end; //command event
                  end;

                end;

              if (h = htmp) and (Hints[nu].Event.Chars[0] <> '%') then
              begin
              if (Hints[nu].Rel = 0) or (Hints[nu].Rel = 1) then
                begin
                  if m < mtmp then
                    Form4.ShowMess(Hints[nu].Event,inttostr(mtmp-m)+' minutes for Event!!!',wav,Form2.TrackBar4.Position)
                    else
                    Form4.ShowMess(Hints[nu].Event,'You are late! Hurry UP!!!',wav,Form2.TrackBar6.Position);
                    Hints[nu].Rel := 2;
                end;
              end;

      end;
    list.Free;
end;

procedure TForm4.Everymonth(com : string;timeto : string;nu : integer; wav : string);
var
  tmp, dtmp,Day : string;
    h,m,ll,mtmp,htmp,j,ii,jj : integer;
    list : TStringList;
begin
 // mon := MonthOfTheYear(date);
  list := TStringList.Create;
  Day := FormatDateTime('dd', date());
  h := strtoint(FormatDateTime('hh', Time()));
  m := strtoint(copy(FormatDateTime('hh:mm', Time()),pos(':',FormatDateTime('hh:mm', Time()))+1,FormatDateTime('hh:mm', Time()).Length));
  if (pos(':',timeto)<>0) then
      begin
        htmp := strtoint(copy(timeto,1,pos(':',timeto)-1));
        mtmp  := strtoint(copy(timeto,pos(':',timeto)+1,timeto.Length) );
      end
        else
      begin
        htmp := 12;
        mtmp := 0;
      end;
         for ll := pos('(',com) to pos(')',com)-1 do
          begin
          if com.Chars[ll] <> ')' then
            dtmp := dtmp + com.Chars[ll];
          end;
       if dtmp = Day then
       begin
          if (h = htmp - 1) and (Hints[nu].Event.Chars[0] <> '%') then
                 begin
                     if Hints[nu].Rel = 0 then
                  begin
                    Form4.ShowMess(Hints[nu].Event,'Today at '+Hints[nu].Time,wav,Form2.TrackBar4.Position);
                    Hints[nu].Rel := 1;
                  end;
                 end;

              if (h = htmp) and (m = mtmp) then
                begin
                if (Hints[nu].Rel = 0) or (Hints[nu].Rel = 1) or (Hints[nu].Rel = 2) then
                  begin
                    if Hints[nu].Event.Chars[0] <> '%' then
                    begin
                      Form4.ShowMess(Hints[nu].Event,'Now!',wav,Form2.TrackBar5.Position);
                      Hints[nu].Rel := 3;
                    end
                    else//non command event
                    begin
                      list.Clear;
                      j :=1;
                      for ii := 1 to Hints[nu].Event.Length-1 do
                      begin
                        tmp := '';
                        while (Hints[nu].Event.Chars[j] <> ';') and (Hints[nu].Event.Chars[j] <> #0)  do
                          begin
                            tmp := tmp + Hints[nu].Event.Chars[j];
                            j := j+1;
                          end;
                        if Hints[nu].Event.Chars[j] = #0 then
                          break;
                        list.Add(tmp);
                        j := j+1;
                      end;  //if command in line
                      for jj := 0 to list.Count-1 do
                      begin
                        com :='';
                        ////////////////////////////////
                        for ii := 0 to list[jj].Length-1 do
                          begin
                            if list[jj].Chars[ii] <> '(' then
                              com := com + list[jj].Chars[ii]
                            else
                            break;
                          end;
                          if com = 'Open' then
                          begin
                            Form4.OpenFL(list[jj]);
                            Continue;
                          end;
                          if com = 'Http' then
                          begin
                            Form4.OpenHttp(list[jj]);
                            Continue;
                          end;
                          if com = 'SendMess' then
                          begin
                            Form4.SendMess(list[jj]);
                            Continue;
                          end;


                          ShowMess(com,'Now!',wav,Form2.TrackBar5.Position);

                      end;  //  ///////////////////////////commands
                        Hints[nu].Rel := 3;
                    end; //command event
                  end;

                end;

              if (h = htmp) and (Hints[nu].Event.Chars[0] <> '%') then
              begin
              if (Hints[nu].Rel = 0) or (Hints[nu].Rel = 1) then
                begin
                  if m < mtmp then
                    Form4.ShowMess(Hints[nu].Event,inttostr(mtmp-m)+' minutes for Event!!!',wav,Form2.TrackBar4.Position)
                    else
                    Form4.ShowMess(Hints[nu].Event,'You are late! Hurry UP!!!',wav,Form2.TrackBar6.Position);
                    Hints[nu].Rel := 2;
                end;
              end;



       end;
       list.Free;
end;

Procedure TForm4.Everyweek(com : string;timeto : string; nu : integer; wav : string);
var
dtmp,tmp : string;
h,m,Day1,Day2,ll,mtmp,htmp,j,ii,jj : integer;
days : array [1..7] of string;
list : TStringList;
begin
days[1] := 'Sunday';
days[2] := 'Monday';
days[3] := 'Tuesday';
days[4] := 'Wednesday';
days[5] := 'Thursday';
days[6] := 'Friday';
days[7] := 'Saturday';
 list := TStringList.Create;
 dtmp := '';
 Day1 := DayOfWeek(date);
 Day2 := 1;
 h := strtoint(FormatDateTime('hh', Time()));
      m := strtoint(copy(FormatDateTime('hh:mm', Time()),pos(':',FormatDateTime('hh:mm', Time()))+1,FormatDateTime('hh:mm', Time()).Length));
     if (pos(':',timeto)<>0) then
      begin
        htmp := strtoint(copy(timeto,1,pos(':',timeto)-1));
        mtmp  := strtoint(copy(timeto,pos(':',timeto)+1,timeto.Length) );
      end
        else
      begin
        htmp := 12;
        mtmp := 0;
      end;
      for ll := pos('(',com) to pos(')',com)-1 do
          begin
          if com.Chars[ll] <> ')' then
            dtmp := dtmp + com.Chars[ll];
          end;
       for ll := 1 to 7 do
        begin
          if days[ll] = dtmp then
          Day2 := ll;
        end;

   if Day1 = Day2 then
     begin
               if (h = htmp - 1) and (Hints[nu].Event.Chars[0] <> '%') then
                 begin
                     if Hints[nu].Rel = 0 then
                  begin
                    Form4.ShowMess(Hints[nu].Event,'Today at '+Hints[nu].Time,wav,Form2.TrackBar4.Position);
                    Hints[nu].Rel := 1;
                  end;
                 end;

              if (h = htmp) and (m = mtmp) then
                begin
                if (Hints[nu].Rel = 0) or (Hints[nu].Rel = 1) or (Hints[nu].Rel = 2) then
                  begin
                    if Hints[nu].Event.Chars[0] <> '%' then
                    begin
                      Form4.ShowMess(Hints[nu].Event,'Now!',wav,Form2.TrackBar5.Position);
                      Hints[nu].Rel := 3;
                    end
                    else//non command event
                    begin
                      list.Clear;
                      j :=1;
                      for ii := 1 to Hints[nu].Event.Length-1 do
                      begin
                        tmp := '';
                        while (Hints[nu].Event.Chars[j] <> ';') and (Hints[nu].Event.Chars[j] <> #0)  do
                          begin
                            tmp := tmp + Hints[nu].Event.Chars[j];
                            j := j+1;
                          end;
                        if Hints[nu].Event.Chars[j] = #0 then
                          break;
                        list.Add(tmp);
                        j := j+1;
                      end;  //if command in line
                      for jj := 0 to list.Count-1 do
                      begin
                        com :='';
                        ////////////////////////////////
                        for ii := 0 to list[jj].Length-1 do
                          begin
                            if list[jj].Chars[ii] <> '(' then
                              com := com + list[jj].Chars[ii]
                            else
                            break;
                          end;
                          if com = 'Open' then
                          begin
                            Form4.OpenFL(list[jj]);
                            Continue;
                          end;
                          if com = 'Http' then
                          begin
                            Form4.OpenHttp(list[jj]);
                            Continue;
                          end;
                          if com = 'SendMess' then
                          begin
                            Form4.SendMess(list[jj]);
                            Continue;
                          end;


                          ShowMess(com,'Now!',wav,Form2.TrackBar5.Position);

                      end;  //  ///////////////////////////commands
                        Hints[nu].Rel := 3;
                    end; //command event
                  end;

                end;

              if (h = htmp) and (Hints[nu].Event.Chars[0] <> '%') then
              begin
              if (Hints[nu].Rel = 0) or (Hints[nu].Rel = 1) then
                begin
                  if m < mtmp then
                    Form4.ShowMess(Hints[nu].Event,inttostr(mtmp-m)+' minutes for Event!!!',wav,Form2.TrackBar4.Position)
                    else
                    Form4.ShowMess(Hints[nu].Event,'You are late! Hurry UP!!!',wav,Form2.TrackBar6.Position);
                    Hints[nu].Rel := 2;
                end;
              end;
           end;

   list.Free;
end;


procedure TForm4.SendMess(com : string);
var
i : integer;
tmp : string;
who : string;
mess : string;
begin
tmp := '';
who := '';
mess := '';
  for I := pos('(',com) to com.Length-2 do
    begin
        tmp := tmp + com.Chars[i]
    end;
    for I := 0 to tmp.Length-1 do
      begin
        if tmp.Chars[i] <> ',' then
          who := who + tmp.Chars[i]
          else
          break;
      end;
        for I := pos(',',tmp) to tmp.Length-1 do
    begin
   // if tmp.Chars[i] <> ')' then
        mess := mess + tmp.Chars[i]
        //else
       // break;
    end;

   if Skype.Convert.AttachmentStatusToText(Skype.AttachmentStatus) = 'Success' then
   Skype.SendMessage(who,'('+Form2.Edit1.Text+') '+mess);
end;

procedure TForm4.OpenFl(com : string);
var
i : integer;
tmp : string;
begin
tmp := '';
  for I := pos('(',com) to com.Length-1 do
    begin
    if com.Chars[i] <> ')' then
        tmp := tmp + com.Chars[i]
        else
        break;
    end;
   if FileExists(tmp) then
      ShellExecute(Form4.Handle, nil, PChar(tmp), nil, nil, SW_RESTORE);
end;

procedure TForm4.OpenHttp(com : string);
var
i : integer;
tmp : string;
begin
tmp := '';
  for I := pos('(',com) to com.Length-1 do
    begin
    if com.Chars[i] <> ')' then
        tmp := tmp + com.Chars[i]
        else
        break;
    end;
  ShellExecute(0, 'open', PChar(tmp), nil, nil, SW_SHOW);

end;


procedure TForm4.ShowMess(mess : string; title : string ; soundtype : string; vol : integer);
var
 Point1,Point2 : TPoint;
 Rec : TRect;
  Wav : TResourceStream;
  wavtmp : string;
  si : integer;
  dllok : boolean;
begin
   while (Timer3.Enabled = true)  do
                begin
                  Application.ProcessMessages;
                  Sleep(10);
                end;
                BASS_StreamFree(chan);
                Form1.Button1.Enabled := false;
                form4.FreeResDLL;
dllok := Form4.LoadResDLL;
if dllok = true then
Wav := TResourceStream.Create(resdll,'Chan_Wel_wav','WAVE');
  chan := 0;
 wavtmp := Getsound(soundtype);
     if wavtmp = 'Chan_Error_wav' then
       vol := Form2.TrackBar7.Position;
   if pos('\',wavtmp) = 0 then
   begin
   if dllok = true then
      begin
      if wav <> nil then
        Wav.Free;
        Wav := TResourceStream.Create(resdll,wavtmp,'WAVE') ;
        chan := BASS_StreamCreateFile(true,wav.Memory,0,wav.Size,0) ;
      end;
   end
   else
  chan := BASS_StreamCreateFile(false,pAnsiChar(AnsiString(wavtmp)),0,0,0) ;
 // ShowMessage(inttostr(BASS_ErrorGetCode()));

 if vol <> -1 then
   BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, vol / 100)
   else
    BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, 1);


 if Pos(#13#10,mess) <> 0 then
     begin
      si := Pos(#13#10,mess) *4;
      mess := mess + #13+#13;
     end
     else
     si := mess.Length*3;




   /////////////////////////////////////////
                Form4.Show;
               // SetForegroundWindow(Form4.Handle);
                while Left > Screen.WorkAreaWidth - Width do
                 begin
                   Sleep(2);
                   Left := Left - width div 23;
                   Form4.Repaint;
                 end;

                 Rec := TRect.Create(Point1.Create(Screen.WorkAreaWidth-(Width),Screen.WorkAreaHeight),Point2.Create(Screen.WorkAreaWidth-(Width*2)-si,Screen.WorkAreaHeight-Height div 4));
            if form2.CheckBox6.Checked = true then
              begin
               BASS_ChannelPlay(chan,true);
               end;
                ShowH(mess,title,Rec);
                Timer3.Enabled := true;
                Timer2.Enabled := true;
      if dllok = true then
     Wav.Free;

end;


procedure TForm4.ShowH(hintText : string ; hintTitle : string; Point : TRect);
begin
 Form4.BalloonHint1.HideHint;
  Application.ProcessMessages;
Form4.BalloonHint1.Title := hinttitle;
Form4.BalloonHint1.Description := hinttext;
Form4.BalloonHint1.ShowHint(Point);
end;
 {
procedure TForm4.loadC;
var
Pict : TPNGImage;
 ini : TIniFile;
 dllok : boolean;
  begin
    ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
  starttimeh := strtoint(FormatDateTime('hh', Time()));
  starttimem := strtoint(copy(FormatDateTime('hh:mm', Time()),pos(':',FormatDateTime('hh:mm', Time()))+1,FormatDateTime('hh:mm', Time()).Length));
 Form4.TransparentColorValue := clWhite;
  Form4.transparentcolor := true;
  Form4.Color := clWhite;
          if (ini.ReadInteger('Helper','Type',0) = 1) or (ini.ReadInteger('Helper','Type',0) = 0) then
                begin
                 if FileExists('Resources\ChanLook_1.png')  then
                 Image1.Picture.LoadFromFile('Resources\ChanLook_1.png')
                    else
                    begin
                    dllok := form4.LoadResDLL;
                    if dllok = true then
                       begin
                    Pict := TPNGImage.Create;
                    Pict.LoadFromResourceName(resdll,'Chan_2');
                    Image1.Picture.Graphic :=Pict;
                    Pict.Free;
                       end;
                       form4.FreeResDLL;
                    end;
                end;
                if ini.ReadInteger('Helper','Type',0) = 2 then
                begin
                     if FileExists('Resources\KunLook_1.png')  then
                 Image1.Picture.LoadFromFile('Resources\KunLook_1.png')
                else
                begin
                      dllok := form4.LoadResDLL;
                    if dllok = true then
                       begin
                  Pict := TPNGImage.Create;
                  Pict.LoadFromResourceName(resdll,'Kun_1');
                  Image1.Picture.Graphic :=Pict;
                  Pict.Free;
                       end;
                       form4.FreeResDLL;
                end;
                end;

        Form4.Height :=  Form4.Image1.Height;
        Form4.Width := Form4.Image1.Width;
  Form4.Left:= Screen.WorkAreaWidth;
  Form4.Top:= Screen.WorkAreaHeight-Form4.Height;
  Form4.Timer1.Enabled := true;

       Form4.Timer4.Enabled := true;
    ini.Free;
  end; }

procedure TForm4.FormCreate(Sender: TObject);
begin
      BASS_Init(-1, 44100, 0, Handle, nil);
    //SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TForm4.Image1Click(Sender: TObject);
begin
     BalloonHint1.HideHint;
Timer3.Enabled := False;

              while Left +30 > Screen.WorkAreaWidth - Width do
                 begin
                   Sleep(2);
                   Left := Left - Width div 23;
                   Form4.Repaint;
                 end;
               Sleep(50);
            while Left < Screen.WorkAreaWidth do
                 begin
                   Sleep(2);
                   Left := Left + width div 23;
                   Form4.Repaint;
                 end;
Form4.Hide;
Form1.Button1.Enabled := true;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
var
 Day,tmp,com,well: string;
 h,htmp,m,mtmp,j : integer;
 list : TStringList;
 i,ii,jj : integer;
 Point1,Point2 : TPoint;
 Rec : TRect;
  Wav : string;
  Ini : TIniFile;
begin

 Timer1.Enabled := false;
 ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
 ///////////////////////////////////////////wellcome
 if ini.ReadBool('General','Wellcome',true) = false then
     wellc := true;
 if (wellc = false) then
   begin
      if ini.ReadInteger('WelcomeMessage','Type',2) = 2 then
      begin
                 while (Timer3.Enabled = true)  do
                begin
                  Application.ProcessMessages;
                  Sleep(10);
                end;
         Form4.ShowMess(ini.ReadString('WelcomeMessage','Message','Hello!'),
         ini.ReadString('WelcomeMessage','Title','Welcome'),'Welcome',Form2.TrackBar2.Position);
      end;
      if ini.ReadInteger('WelcomeMessage','Type',2) = 1 then
      begin
      well := Form1.Randfromdb('Wellcomes','Title','Message')  ;
         while (Timer3.Enabled = true)  do
                begin
                  Application.ProcessMessages;
                  Sleep(10);
                end;
      Form4.ShowMess(copy(well,pos('&&&',well)+3,well.Length),copy(well,1,pos('&&&',well)),'Welcome',Form2.TrackBar2.Position);
       end;
      wellc := true;
      Timer4.Enabled := ini.ReadBool('General','Facts',false);
   end;
   //////////////////////////////////////////
      Day := FormatDateTime('dd.mm.yyy', date());
      list := TStringList.Create;

      Wav := 'Mess' ;

  for I := 0 to Length(Hints)-1 do
    begin
    //////////////////////////////////////////////////time set up
      h := strtoint(FormatDateTime('hh', Time()));
      m := strtoint(copy(FormatDateTime('hh:mm', Time()),pos(':',FormatDateTime('hh:mm', Time()))+1,FormatDateTime('hh:mm', Time()).Length));
      if (pos(':',Hints[i].Time)<>0) then
      begin
        htmp := strtoint(copy(Hints[i].Time,1,pos(':',Hints[i].Time)-1));
        mtmp  := strtoint(copy(Hints[i].Time,pos(':',Hints[i].Time)+1,Hints[i].Time.Length) );
      end
        else
      begin
        htmp := 12;
        mtmp := 0;
      end;
    ////////////////////////////////////////////////////
    ///  ////////////////////////////////////////////////uncommand data check
     if Hints[i].Data.Chars[0] <> '%' then
      begin
           if (Day = Hints[i].Data) and (h = htmp - 1) and (Hints[i].Event.Chars[0] <> '%')  then
        begin
        if Hints[i].Rel = 0 then
              begin
                Form4.ShowMess(Hints[i].Event,'Today at '+Hints[i].Time,wav,Form2.TrackBar4.Position);
                 Hints[i].Rel := 1;
              end;
        end; //check

         if (Day = Hints[i].Data) and (h = htmp) and (m = mtmp) then
        begin
        if (Hints[i].Rel = 0) or (Hints[i].Rel = 1) or (Hints[i].Rel = 2) then
           begin
              while Timer3.Enabled = true do
                begin
                Application.ProcessMessages;
                  Sleep(10);
                end;  //w8
    /////////////////////////////////////////////////////////////////
            if Hints[i].Event.Chars[0] <> '%' then
              begin
               Form4.ShowMess(Hints[i].Event,'Now!',wav,Form2.TrackBar5.Position);
               Hints[i].Rel := 3;
               end
                else//non command event
              begin
                list.Clear;
                j :=1;
                for ii := 1 to Hints[i].Event.Length-1 do
                  begin
                    tmp := '';
                    while (Hints[i].Event.Chars[j] <> ';') and (Hints[i].Event.Chars[j] <> #0)  do
                      begin
                      tmp := tmp + Hints[i].Event.Chars[j];
                      j := j+1;
                      end;
                    if Hints[i].Event.Chars[j] = #0 then
                      break;
                   list.Add(tmp);
                   j := j+1;
                  end;  //if command in line
                      for jj := 0 to list.Count-1 do
                begin
                  com :='';
                  ////////////////////////////////
                   for ii := 0 to list[jj].Length-1 do
                      begin
                       if list[jj].Chars[ii] <> '(' then
                        com := com + list[jj].Chars[ii]
                        else
                        break;
                      end;
                  if com = 'Open' then
                   begin
                    OpenFL(list[jj]);
                    Continue;
                   end;
                  if com = 'Http' then
                    begin
                    OpenHttp(list[jj]);
                    Continue;
                    end;
                  if com = 'SendMess' then
                   begin
                    SendMess(list[jj]);
                    Continue;
                   end;
                        ShowMess(com,'Now!','Mess',Form2.TrackBar5.Position);

                end;  //  ///////////////////////////commands
                  Hints[i].Rel := 3;
              end; //command event
          /////////////////////////////////////////////
           end;
        end;//check


        if (Day = Hints[i].Data) and (h = htmp) and (Hints[i].Event.Chars[0] <> '%') then
        begin
        if (Hints[i].Rel = 0) or (Hints[i].Rel = 1) then
           begin

              if m < mtmp then
              Form4.ShowMess(Hints[i].Event,inttostr(mtmp-m)+' minutes for Event!!!',wav,Form2.TrackBar4.Position)
            else
               Form4.ShowMess(Hints[i].Event,'You are late! Hurry UP!!!',wav,Form2.TrackBar6.Position);
            Hints[i].Rel := 2;
           end;
        end;//check
        if (CompareDateTime(StrToDate(Day),StrToDate(Hints[i].Data))= 1 or 0) and (h+1 >= htmp) and (Hints[i].Event.Chars[0] <> '%') then
        begin
           tmp := 'DELETE FROM '+Form1.FDTableEvents.TableName+' WHERE id'+'="'+inttostr(Hints[i].id)+'";';
            Form1.FDConnection1.ExecSQL(tmp);
            Form1.FDQuery1.Active := false;
            Form1.FDQuery1.Active := true;
            Form1.CheckBase;
            Form1.StringGridBindSourceDB1.ColWidths[0] := 30;
            Form1.StringGridBindSourceDB1.ColWidths[1] := 100;
            Form1.StringGridBindSourceDB1.ColWidths[2] := 85;
            Form1.StringGridBindSourceDB1.ColWidths[3] := 210;
        end;
      //////////////////////////////////////////////////////////////////////uncommand data check
      end
      else
      begin
      tmp := '';
       for jj := 1 to Hints[i].Data.Length-1 do
         begin
         if Hints[i].Data.Chars[jj] <> ';' then
            tmp := tmp + Hints[i].Data.Chars[jj];
         end;
         com := '';
        for jj := 0 to tmp.Length-1 do
          begin
          if tmp.Chars[jj] <> '(' then
            com := com + tmp.Chars[jj]
            else
            break;
          end;

          if com = 'Everyday' then
           begin
               if (h = htmp - 1) and (Hints[i].Event.Chars[0] <> '%') then
                 begin
                     if Hints[i].Rel = 0 then
                  begin
                    Form4.ShowMess(Hints[i].Event,'Today at '+Hints[i].Time,wav,Form2.TrackBar4.Position);
                    Hints[i].Rel := 1;
                  end;
                 end;

              if (h = htmp) and (m = mtmp) then
                begin
                if (Hints[i].Rel = 0) or (Hints[i].Rel = 1) or (Hints[i].Rel = 2) then
                  begin
                    if Hints[i].Event.Chars[0] <> '%' then
                    begin
                      Form4.ShowMess(Hints[i].Event,'Now!',wav,Form2.TrackBar5.Position);
                      Hints[i].Rel := 3;
                    end
                    else//non command event
                    begin
                      list.Clear;
                      j :=1;
                      for ii := 1 to Hints[i].Event.Length-1 do
                      begin
                        tmp := '';
                        while (Hints[i].Event.Chars[j] <> ';') and (Hints[i].Event.Chars[j] <> #0)  do
                          begin
                            tmp := tmp + Hints[i].Event.Chars[j];
                            j := j+1;
                          end;
                        if Hints[i].Event.Chars[j] = #0 then
                          break;
                        list.Add(tmp);
                        j := j+1;
                      end;  //if command in line
                      for jj := 0 to list.Count-1 do
                      begin
                        com :='';
                        ////////////////////////////////
                        for ii := 0 to list[jj].Length-1 do
                          begin
                            if list[jj].Chars[ii] <> '(' then
                              com := com + list[jj].Chars[ii]
                            else
                            break;
                          end;
                          if com = 'Open' then
                          begin
                            OpenFL(list[jj]);
                            Continue;
                          end;
                          if com = 'Http' then
                          begin
                            OpenHttp(list[jj]);
                            Continue;
                          end;
                          if com = 'SendMess' then
                          begin
                            SendMess(list[jj]);
                            Continue;
                          end;

                          ShowMess(com,'Now!','Mess',Form2.TrackBar5.Position);


                      end;  //  ///////////////////////////commands
                        Hints[i].Rel := 3;
                    end; //command event
                  end;

                end;

              if (h = htmp) and (Hints[i].Event.Chars[0] <> '%') then
              begin
              if (Hints[i].Rel = 0) or (Hints[i].Rel = 1) then
                begin
                  if m < mtmp then
                    Form4.ShowMess(Hints[i].Event,inttostr(mtmp-m)+' minutes for Event!!!',wav,Form2.TrackBar4.Position)
                    else
                    Form4.ShowMess(Hints[i].Event,'You are late! Hurry UP!!!',wav,Form2.TrackBar6.Position);
                    Hints[i].Rel := 2;
                end;
              end;
           end; ////everyday

           if com = 'Everyweek' then
               Everyweek(tmp,Hints[i].Time,i,wav);
             if com = 'Everymonth' then
                Form4.Everymonth(tmp,Hints[i].Time,i,wav);
                if com = 'Everyyear' then
                  Form4.Everyyear(tmp,Hints[i].Time,i,wav);
      end;
    end;
  ini.Free;
  list.Free;
Timer1.Enabled := true;
end;

procedure TForm4.Timer2Timer(Sender: TObject);
begin
 Timer3.Enabled := false;
Timer2.Enabled := false;
Image1.OnClick(self);
end;

procedure TForm4.Timer3Timer(Sender: TObject);

begin
Timer3.Enabled := false;

    SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    Timer3.Enabled := true;
end;

procedure TForm4.Timer4Timer(Sender: TObject);
var
 ini : TIniFile;
 tmp,langt,stopifstr,tmp1 : string;
 curh,curm,i,j : integer;
 list : TStringList;
 good : boolean;
begin

Timer4.Enabled := false;

if Form2.CheckBox4.Checked = false then
  begin
  Timer4.Enabled := true;
    exit;
  end;
  list := TStringList.Create;
  j := 0;
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
curh := strtoint(FormatDateTime('hh', Time()));
  curm := strtoint(copy(FormatDateTime('hh:mm', Time()),pos(':',FormatDateTime('hh:mm', Time()))+1,FormatDateTime('hh:mm', Time()).Length));
if ini.ReadString('Facts','Language','Russian') = 'Russian' then
   langt := 'Factsru';
 if ini.ReadString('Facts','Language','Russian') = 'English' then
   langt := 'Factsen';
      if (ini.ReadInteger('Facts','Time',0) = 0) or (ini.ReadInteger('Facts','Time',0) = 2) or (ini.ReadInteger('Facts','Time',0) = 1)  then
    begin
       if (curh = starttimeh+1) and (curm = starttimem)  then
          begin
          if ini.ReadBool('Facts','Stopif',false) = false then
              begin
                tmp := Form1.Randfromdb(langt,'','Fact');
                while (Timer2.Enabled = true)  do
                  begin
                  Application.ProcessMessages;
                  Sleep(10);
                  end;
                ShowMess(tmp,'Do you know?','Fact',Form2.TrackBar3.Position);
              starttimeh := starttimeh +1;
              end;
          if (ini.ReadBool('Facts','Stopif',false)) and (ini.ReadString('Facts','Stopiftext','') <> '') then
               begin
                stopifstr := ini.ReadString('Facts','Stopiftext','');
                if pos(',',stopifstr) =0 then
                begin
                    if Form5.IsRunning(stopifstr) = false then
                        begin
                           tmp := Form1.Randfromdb(langt,'','Fact');
                            while (Timer2.Enabled = true)  do
                              begin
                              Application.ProcessMessages;
                                Sleep(10);
                              end;
                              ShowMess(tmp,'Do you know?','Fact',Form2.TrackBar3.Position);
                              starttimeh := starttimeh +1;
                        end;
                end
                else
                begin
                   for I := 0 to stopifstr.Length do
                     begin
                     tmp1 := '';
                       while (stopifstr.Chars[j] <> ',') and (stopifstr.Chars[j] <> #0) do
                           begin
                            tmp1 := tmp1 +  stopifstr.Chars[j];
                            j:= j +1;
                            end;
                            list.Add(tmp1);
                           if stopifstr.Chars[j] = #0 then
                              break;
                           j:= j +1;
                          tmp1 := '';
                      end;
                      good := false;
                     for I := 0 to list.Count-1 do
                       begin
                         if Form5.IsRunning(list[i]) = true then
                         begin
                           good := false;
                           break;
                         end
                         else
                         good := true;
                       end;
                       if good = true then
                         begin
                          tmp := Form1.Randfromdb(langt,'','Fact');
                            while (Timer2.Enabled = true)  do
                              begin
                              Application.ProcessMessages;
                                Sleep(10);
                              end;
                              ShowMess(tmp,'Do you know?','Fact',Form2.TrackBar3.Position);
                              starttimeh := starttimeh +1;
                         end;
                end;
               end;

          end;

    end;


    list.Free;
   ini.Free;
Timer4.Enabled := true;
end;

end.
