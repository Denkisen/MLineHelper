unit FactSetUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtDlgs, IniFiles, Vcl.ExtCtrls;

type
  TForm8 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    FDQuery1id: TFDAutoIncField;
    FDQuery1Fact: TWideMemoField;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    ProgressBar1: TProgressBar;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label2: TLabel;
    RadioButton2: TRadioButton;
    ProgressBar2: TProgressBar;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit2: TEdit;
    Label3: TLabel;
    DataSource2: TDataSource;
    FDQuery2: TFDQuery;
    FDTable2: TFDTable;
    FDQuery2id: TFDAutoIncField;
    FDQuery2Fact: TWideMemoField;
    OpenTextFileDialog2: TOpenTextFileDialog;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    Button7: TButton;
    procedure FDQuery1FactGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FDQuery2FactGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
 // procedure loadC;
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses Main, SettingsUI;

procedure TForm8.Button1Click(Sender: TObject);
var
tmp : string;
j, ji : integer;
begin
   if (Edit1.Text <> '')  then
      begin
      tmp := Edit1.Text;
      if tmp.Length-1 <= 40 then
                begin
                FDTable1.Insert;
                FDTable1.FieldByName('Fact').AsString :=  tmp;
                FDTable1.Post;
                end;
             if tmp.Length-1 > 45 then
               begin
                 j := 45;
                 while j < tmp.Length-1 do
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
                  FDTable1.Insert;
                  FDTable1.FieldByName('Fact').AsString :=  tmp;
                  FDTable1.Post;
               end;
               end;
               FDQuery1.Active := false;
        FDQuery1.Active := true;
end;

procedure TForm8.Button2Click(Sender: TObject);
var
tmp : string;
begin
tmp := 'DELETE FROM '+FDTable1.TableName+' WHERE '+DBGrid1.SelectedField.FieldName+'="'+DBGrid1.SelectedField.AsString+'";';
Form1.FDConnection1.ExecSQL(tmp);
 FDQuery1.Active := false;
   FDQuery1.Active := true;

end;

procedure TForm8.Button3Click(Sender: TObject);
var
list : TStringList;
tmp : string;
i,j,ji : integer;
begin
   if OpenTextFileDialog1.Execute then
      begin
      list := TStringList.Create;
      list.LoadFromFile(OpenTextFileDialog1.FileName);
      ProgressBar1.Max :=  list.Count-1;
      ProgressBar1.Position := 0;
        for I := 0 to list.Count-1 do
          begin
             if list[i].Length-1 <= 40 then
                begin
                FDTable1.Insert;
                FDTable1.FieldByName('Fact').AsString :=  list[i];
                FDTable1.Post;
                end;
             if list[i].Length-1 > 45 then
               begin
                 j := 45;
                 tmp := list[i];
                 while j < list[i].Length-1 do
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
                  FDTable1.Insert;
                  FDTable1.FieldByName('Fact').AsString :=  tmp;
                  FDTable1.Post;


               end;
              ProgressBar1.Position := ProgressBar1.Position +1;
          end;
         list.Free;
      end;
       FDQuery1.Active := false;
   FDQuery1.Active := true;

   ProgressBar1.Position := 0;
end;

procedure TForm8.Button4Click(Sender: TObject);
var
list : TStringList;
tmp : string;
i,j,ji : integer;
begin
   if OpenTextFileDialog2.Execute then
      begin
      list := TStringList.Create;
      list.LoadFromFile(OpenTextFileDialog2.FileName);
      ProgressBar2.Max :=  list.Count-1;
      ProgressBar2.Position := 0;
        for I := 0 to list.Count-1 do
          begin
             if list[i].Length-1 <= 40 then
              begin
                FDTable2.Insert;
                FDTable2.FieldByName('Fact').AsString :=  list[i];
                FDTable2.Post;
              end;
             if list[i].Length-1 > 45 then
               begin
                 j := 45;
                 tmp := list[i];
                 while j < list[i].Length-1 do
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
                  FDTable2.Insert;
                  FDTable2.FieldByName('Fact').AsString :=  tmp;
                  FDTable2.Post;


               end;
              ProgressBar2.Position := ProgressBar1.Position +1;
          end;
           list.Free;
      end;
       FDQuery2.Active := false;
   FDQuery2.Active := true;
   ProgressBar2.Position := 0;

end;

procedure TForm8.Button5Click(Sender: TObject);
var
tmp : string;
j, ji : integer;
begin
   if (Edit2.Text <> '')  then
      begin
      tmp := Edit2.Text;
      if tmp.Length-1 <= 40 then
                begin
                FDTable2.Insert;
                FDTable2.FieldByName('Fact').AsString :=  tmp;
                FDTable2.Post;
                end;
             if tmp.Length-1 > 45 then
               begin
                 j := 45;
                 while j < tmp.Length-1 do
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
                  FDTable2.Insert;
                  FDTable2.FieldByName('Fact').AsString :=  tmp;
                  FDTable2.Post;
               end;
               end;
       FDQuery2.Active := false;
        FDQuery2.Active := true;

end;

procedure TForm8.Button6Click(Sender: TObject);
var
tmp : string;
begin
tmp := 'DELETE FROM '+FDTable2.TableName+' WHERE '+DBGrid2.SelectedField.FieldName+'="'+DBGrid2.SelectedField.AsString+'";';
Form1.FDConnection1.ExecSQL(tmp);
 FDQuery2.Active := false;
   FDQuery2.Active := true;

end;

procedure TForm8.Button7Click(Sender: TObject);
var
ini : TIniFile;
begin
   ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
   ini.WriteString('Facts','Stopiftext',Edit3.Text);
    ini.Free;
end;

procedure TForm8.CheckBox1Click(Sender: TObject);
var
ini : TIniFile;
begin
   ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
   Edit3.Enabled := checkbox1.Checked;
   Button7.Enabled := checkbox1.Checked;
   ini.WriteBool('Facts','Stopif',checkbox1.Checked);
    ini.Free;
end;

procedure TForm8.FDQuery1FactGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
       Text := Sender.AsString;
end;

procedure TForm8.FDQuery2FactGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
Text := Sender.AsString;
end;

procedure TForm8.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
ini : TIniFile;
begin
ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
ini.WriteString('Facts','Language',ComboBox1.Text);
//if RadioButton1.Checked = true then
  //  ini.WriteInteger('Facts','Time',1);
  if RadioButton2.Checked = true then
    ini.WriteInteger('Facts','Time',2);
    ini.WriteBool('Facts','Stopif',checkbox1.Checked);
    ini.WriteString('Facts','Stopiftext',Edit3.Text);
    ini.Free;
end;
{
procedure TForm8.loadC;
var
ini : TIniFile;
begin
   ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
   if Form1.FDConnection1.Connected then
    begin

      FDQuery1.Open('select * from  Factsru;');
     FDTable1.Open('Factsru');
     FDTable1.Active := true;


       FDQuery2.Open('select * from Factsen;');
     FDTable2.Open('Factsen');
     FDTable2.Active := true;

    end;

    Form8.ComboBox1.Text := ini.ReadString('Facts','Language','Russian') ;
    case ini.ReadInteger('Facts','Time',0) of
       0 : Form8.RadioButton2.Checked := true;
       //1 :  RadioButton1.Checked := true;
       2 : Form8.RadioButton2.Checked := true;
       else
       Form8.RadioButton2.Checked := true;
    end;
    Form8.checkbox1.Checked := ini.ReadBool('Facts','Stopif',false);
    Form8.edit3.Text := ini.ReadString('Facts','Stopiftext','');
    Form8.Edit3.Enabled := checkbox1.Checked;
    Form8.Button7.Enabled := checkbox1.Checked;
    ini.Free;
end; }

end.
