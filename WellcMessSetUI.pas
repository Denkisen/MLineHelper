unit WellcMessSetUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.ExtCtrls,IniFiles;

type
  TForm7 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDTable1: TFDTable;
    DBGrid1: TDBGrid;
    FDQuery1id: TFDAutoIncField;
    FDQuery1Title: TWideMemoField;
    FDQuery1Message: TWideMemoField;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FDQuery1TitleGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FDQuery1MessageGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
  //procedure loadC;
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses Main;

procedure TForm7.Button1Click(Sender: TObject);
begin
  FDTable1.Insert;
   if (LabeledEdit1.Text <> '') and (LabeledEdit2.Text <> '') then
      begin
      FDTable1.FieldByName('Title').AsString :=  LabeledEdit1.Text;
      FDTable1.FieldByName('Message').AsString := LabeledEdit2.Text;
      FDTable1.Post;
       FDQuery1.Active := false;
        FDQuery1.Active := true;
      end;
end;

procedure TForm7.Button2Click(Sender: TObject);
var
tmp : string;
begin
tmp := 'DELETE FROM '+FDTable1.TableName+' WHERE '+DBGrid1.SelectedField.FieldName+'="'+DBGrid1.SelectedField.AsString+'";';
Form1.FDConnection1.ExecSQL(tmp);
 FDQuery1.Active := false;
   FDQuery1.Active := true;
end;

procedure TForm7.FDQuery1MessageGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
      Text := Sender.AsString;
end;

procedure TForm7.FDQuery1TitleGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
     Text := Sender.AsString;
end;

procedure TForm7.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
  if RadioButton1.Checked = true then
    ini.WriteInteger('WelcomeMessage','Type',1);
    if RadioButton2.Checked = true then
    ini.WriteInteger('WelcomeMessage','Type',2);
    ini.WriteString('WelcomeMessage','Title',Edit1.Text);
    ini.WriteString('WelcomeMessage','Message',Edit2.Text);
  ini.Free;
end;
 {
procedure TForm7.loadC;
var
ini : TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0)) + 'Settings.ini');
   case ini.ReadInteger('WelcomeMessage','Type',2) of
   1 :
   begin
        Form7.RadioButton1.Checked := true;
        Form7.Edit1.Enabled := false;
        Form7.Edit2.Enabled := false;
   end;
   2 :
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
    Form7.Edit1.Text :=ini.ReadString('WelcomeMessage','Title','Welcome');
    Form7.Edit2.Text := ini.ReadString('WelcomeMessage','Message','Hello!');
  ini.Free;

       Form7.FDQuery1.Open('select * from  Wellcomes;');
     Form7.FDTable1.Open('Wellcomes');
     Form7.FDTable1.Active := true;
end; }

procedure TForm7.RadioButton1Click(Sender: TObject);
begin
 Edit1.Enabled :=   RadioButton2.Checked;
 Edit2.Enabled :=   RadioButton2.Checked;
end;

procedure TForm7.RadioButton2Click(Sender: TObject);
begin
 Edit1.Enabled :=   RadioButton2.Checked;
 Edit2.Enabled :=   RadioButton2.Checked;
end;

end.
