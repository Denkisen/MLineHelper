unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,  Vcl.Grids, Vcl.DBGrids,
   Vcl.ExtCtrls, Vcl.Menus,IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.Bind.Controls, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Vcl.Buttons,
  Vcl.Bind.Navigator, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FireDAC.Comp.UI, Vcl.Mask, System.Actions, Vcl.ActnList;

  type
  HintSet = record
    id : integer;
    Data : string;
    Time : string;
    Event : string;
    Rel : integer; //0-not show//1-one hour before//2-late//3-at time showed
  end;

  type
  Randone = record
     value : integer;
     check : boolean;
  end;
  type
  tablinfo = record
    name :  string;
    fields : string;
  end;



type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Setings1: TMenuItem;
    Timer1: TTimer;
    Close1: TMenuItem;
    Autoanswer1: TMenuItem;
    Button3: TButton;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    BindSourceDB1: TBindSourceDB;
    FDQuery1: TFDQuery;
    StringGridBindSourceDB1: TStringGrid;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    BindSourceEvents: TBindSourceDB;
    FDTableEvents: TFDTable;
    LabeledEditEvent: TLabeledEdit;
    FDQuery2: TFDQuery;
    ComboBox1: TComboBox;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    Label2: TLabel;
    Sendfileto1: TMenuItem;
    Timer2: TTimer;
    Console1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnGetMemoText(Sender: TField; var aText: string;
  DisplayText: Boolean);
    procedure TrayIcon1Click(Sender: TObject);
    procedure Minimaze(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure CheckBase();
    procedure Setings1Click(Sender: TObject);
    procedure FDQuery1AfterPost(DataSet: TDataSet);
    procedure Autoanswer1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function Randfromdb(db : string;titlefild : string;textfield : string) : string;
    procedure Sendfileto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer2Timer(Sender: TObject);
    procedure Console1Click(Sender: TObject);
  private
    { Private declarations }
  public
 // procedure LoadC;
    { Public declarations }
  end;

var
  Form1: TForm1;
    Hints: array of HintSet;
     Randfr : array of Randone;
     Randcount : integer = 0;
     tabl : array [0..10] of tablinfo;
     tmpleft : integer;
implementation

{$R *.dfm}

uses ComHelpUI, MessUI, SettingsUI,
  SkFriendListUI, SkypeSetUI, Clientcom, MConsole;


function TForm1.Randfromdb(db : string;titlefild : string;textfield : string) : string;
var
i,ran,coun : integer;
good : boolean ;
begin

   if Form1.FDConnection1.Connected = true then
     begin
     Randomize;
     FDQuery2.Active := false;
           Form1.FDQuery2.SQL.Clear;
          Form1.FDQuery2.SQL.Add('select count (*) from '+db+';');
          FDQuery2.Active := true;
          coun := strtoint(Form1.FDQuery2.Fields[0].AsString);
          FDQuery2.Active := false;
          Form1.FDQuery2.SQL.Clear;
          Form1.FDQuery2.SQL.Text := 'select * from '+ db+';' ;
           FDQuery2.Active := true;
         if (textfield <> '') and (titlefild <> '') then
            begin
            if coun >1 then
             begin
               FDQuery2.First;
              ran := Random(coun);
              if coun >9 then
              begin
              good := false;
              if randcount = 6 then
                randcount := 0;
                while True do
                  begin
                  for i := 0 to 6 do
                      begin
                        if Randfr[i].value = ran then
                           Randfr[i].check := false
                           else
                            Randfr[i].check := true;
                      end;
                    for I := 0 to 6 do
                      begin
                        if Randfr[i].check = false then
                        begin
                        good := false;
                             break;
                        end
                        else
                         good := true;
                      end;
                      Randomize;
                      if good = true then
                            break
                            else
                          ran := Random(coun);

                  end;
                  Randfr[randcount].value := ran;
                  inc(randcount);

              end;
              for I := 0 to ran-1 do
                FDQuery2.Next;
                result := FDQuery2.FieldByName(titlefild).AsString + '&&&' +
                FDQuery2.FieldByName(textfield).AsString ;
                FDQuery2.First;
             end
             else
              result := 'Wellcome!!!&&&OOpps!' ;
            end;

            if (textfield <> '') and (titlefild = '') then
              begin
                    if coun >1 then
                begin
                  FDQuery2.First;
                  ran := Random(coun);
                  if coun >9 then
                    begin
                    good := false;
                if randcount = 6 then
                randcount := 0;
                  while True do
                  begin
                      for i := 0 to 6 do
                        begin
                        if Randfr[i].value = ran then
                           Randfr[i].check := false
                           else
                            Randfr[i].check := true;
                        end;
                    for I := 0 to 6 do
                      begin
                        if Randfr[i].check = false then
                        begin
                        good := false;
                             break;
                        end
                        else
                         good := true;
                      end;
                      Randomize;
                      if good = true then
                            break
                            else
                          ran := Random(coun);

                  end;
                  Randfr[randcount].value := ran;
                  inc(randcount);
                    end;
                  for I := 0 to ran-1 do
                    FDQuery2.Next;
                    result := FDQuery2.FieldByName(textfield).AsString ;
                    FDQuery2.First;
                end
                else
              result := 'Oppss...' ;
              end;

     end;
end;


procedure TForm1.CheckBase();
var
i : integer;
coun : integer;
 begin
 if Form1.FDConnection1.Connected = true then
     begin
          FDQuery1.Active := false;
           Form1.FDQuery1.SQL.Clear;
          Form1.FDQuery1.SQL.Add('select count (*) from Events;');
          FDQuery1.Active := true;
          coun := strtoint(Form1.FDQuery1.Fields[0].AsString);
          FDQuery1.Active := false;
          Form1.FDQuery1.SQL.Clear;
          FDQuery1.Open('select * from  Events;');
          FDQuery1.Active := true;

        FDQuery1.First;
        SetLength(Hints, 0);
        SetLength(Hints, coun);
    for I := 0 to coun-1 do
        begin
          Hints[i].Data := FDQuery1.FieldByName('Data').AsString;
          Hints[i].Time := FDQuery1.FieldByName('Time').AsString;
          Hints[i].Event := FDQuery1.FieldByName('Event').AsString;
          Hints[i].id := FDQuery1.FieldByName('id').AsInteger;
          Hints[i].Rel := 0;
            FDQuery1.Next;
        end;
            FDQuery1.First;
                StringGridBindSourceDB1.ColWidths[0] := 30;
                StringGridBindSourceDB1.ColWidths[1] := 100;
                StringGridBindSourceDB1.ColWidths[2] := 85;
                StringGridBindSourceDB1.ColWidths[3] := 210;
      end;
 end;

procedure TForm1.Minimaze(Sender: TObject);
begin
    Form1.TrayIcon1.Visible := true;
end;


procedure TForm1.OnGetMemoText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  if DisplayText then
    aText := Sender.AsString;
end;

procedure TForm1.Sendfileto1Click(Sender: TObject);
begin
dotype := 2;
Form9.Show;
end;

procedure TForm1.Setings1Click(Sender: TObject);
begin
Form2.ShowModal;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled := false;
    Form1.TrayIcon1.Visible := true;
  ShowWindow(Form1.Handle, SW_HIDE);
  Sleep(200);
  Left := tmpleft;
   Timer2.Enabled := true;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
tmp : Eventst;
begin
Timer2.Enabled:= false;
    if IsServRunning = 0 then
    begin
      if (FDConnection1.Connected = true) and (FDTableEvents.Active = true) then
         begin
           tmp := GetEvent;
                 Form1.FDTableEvents.Insert;
              if (tmp.Data <> '') and (tmp.Time <> '') and (tmp.Event <>'') then
            begin
              Form1.FDTableEvents.FieldByName('Data').AsString := tmp.Data;
              Form1.FDTableEvents.FieldByName('Event').AsString := tmp.Event;
              Form1.FDTableEvents.FieldByName('Time').AsString := tmp.Time;
              Form1.FDTableEvents.Post;
              Form1.FDQuery1.Active := false;
              Form1.FDQuery1.Active := true;
              Form1.CheckBase;
                StringGridBindSourceDB1.ColWidths[0] := 30;
                  StringGridBindSourceDB1.ColWidths[1] := 100;
                    StringGridBindSourceDB1.ColWidths[2] := 85;
                      StringGridBindSourceDB1.ColWidths[3] := 210;
            end;
              

         end;
    end;
Timer2.Enabled := true;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
if IsWindowVisible(Form1.Handle) = false then
begin
         ShowWindow(Form1.Handle, SW_RESTORE);
       SetForegroundWindow(Form1.Handle);
end
         else
         ShowWindow(Form1.Handle, SW_HIDE);

end;

procedure TForm1.Autoanswer1Click(Sender: TObject);
begin
if Autoanswer1.Checked = true then
begin
    Form5.CheckBox3.Checked := false ;
   Form5.Edit4.Enabled:= false;
   Autoanswer1.Checked := false  ;
end
   else
   begin
   Form5.CheckBox3.Checked := true ;
   Form5.Edit4.Enabled:= true;
   Form5.Show;
   Autoanswer1.Checked := true;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
tmp : string;
ind : integer;
begin
ind := pos(#$D#$A,StringGridBindSourceDB1.Rows[StringGridBindSourceDB1.Row].Text)-1 ;
tmp := 'DELETE FROM '+FDTableEvents.TableName+' WHERE id'+'="'+copy(StringGridBindSourceDB1.Rows[StringGridBindSourceDB1.Row].Text,1,ind)+'";';
Form1.FDConnection1.ExecSQL(tmp);

 FDQuery1.Active := false;
   FDQuery1.Active := true;
   Form1.CheckBase;
   StringGridBindSourceDB1.ColWidths[0] := 30;
 StringGridBindSourceDB1.ColWidths[1] := 100;
 StringGridBindSourceDB1.ColWidths[2] := 85;
 StringGridBindSourceDB1.ColWidths[3] := 210;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin

     Form1.FDTableEvents.Insert;
   if (ComboBox1.Text <> '') and (LabeledEditEvent.Text <> '') and (MaskEdit1.Text <>'') then
      begin
     Form1.FDTableEvents.FieldByName('Data').AsString := ComboBox1.Text;
     Form1.FDTableEvents.FieldByName('Event').AsString := LabeledEditEvent.Text;
       Form1.FDTableEvents.FieldByName('Time').AsString := MaskEdit1.Text;
     Form1.FDTableEvents.Post;
  Form1.FDQuery1.Active := false;
   Form1.FDQuery1.Active := true;
    Form1.CheckBase;
      end;

      StringGridBindSourceDB1.ColWidths[0] := 30;
 StringGridBindSourceDB1.ColWidths[1] := 100;
 StringGridBindSourceDB1.ColWidths[2] := 85;
 StringGridBindSourceDB1.ColWidths[3] := 210;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Form6.Show;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Console1Click(Sender: TObject);
begin
FOrm10.Show;
end;

procedure TForm1.FDQuery1AfterPost(DataSet: TDataSet);
begin
     CheckBase;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
userslist.Clear;      //form9
    userslist.Free;   //form9
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
ini : TIniFile;
tmp : string;
i : integer;
begin

    ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
        tmp :=  inttostr(Randfr[0].value);
       for i := 1 to 6 do
         begin
           tmp := tmp + ',' + inttostr(Randfr[i].value);
         end;
         tmp := tmp +',';
         ini.WriteString('General','Randstr',tmp);
    StopWorking(false);
    ini.Free;
end;
{
procedure TForm1.LoadC;
var
i : integer;
ini : TIniFile;
tmp : string;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
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

  if not FileExists('DataS.dll') then
  begin
    ShowMessage('DataS.dll not found!');
     Application.Terminate;
  end;

       ComboBox1.Text := FormatDateTime('dd.mm.yyyy', Date());
MaskEdit1.Text := FormatDateTime('hh:mm', Time()) ;
   Form1.FDConnection1.Params.Database := extractfilepath(paramstr(0))+'Events.db';
FDConnection1.Connected := true;
  tmp := ini.ReadString('General','Randstr','');
  SetLength(Randfr,7);
  if pos(',',tmp) <> 0 then
    begin
        for I := 0 to 6 do
            begin

              Randfr[i].value := strtoint(copy(tmp,1, pos(',',tmp)-1));
              Randfr[i].check := false;
                tmp := copy(tmp,pos(',',tmp)+1,tmp.Length);
            end;
    end
    else
    begin
      for I := 0 to 6 do
            begin
      Randfr[i].value := 0;
      Randfr[i].check := false;
            end;
    end;
 randcount := 0;
if Form1.FDConnection1.Connected then
begin


  FDQuery1.Open('select * from  Events;');
     FDTableEvents.Open('Events');
     FDTableEvents.Active := true;

  CheckBase;
       StringGridBindSourceDB1.EditorMode := true;
StringGridBindSourceDB1.DefaultColWidth := 70;
StringGridBindSourceDB1.DefaultRowHeight := 25;
StringGridBindSourceDB1.ColWidths[0] := 30;
 StringGridBindSourceDB1.ColWidths[1] := 100;
 StringGridBindSourceDB1.ColWidths[2] := 85;
 StringGridBindSourceDB1.ColWidths[3] := 210;
end;

ini.Free;
end;      }

procedure TForm1.FormCreate(Sender: TObject);
begin
tmpleft := left;
Left := Screen.Width;
   Timer1.Enabled := true;
end;

end.
