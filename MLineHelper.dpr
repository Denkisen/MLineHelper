// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program MLineHelper;









uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  SettingsUI in 'SettingsUI.pas' {Form2},
  Vcl.Themes,
  Vcl.Styles,
  MessUI in 'MessUI.pas' {Form4},
  SkypeSetUI in 'SkypeSetUI.pas' {Form5},
  ComHelpUI in 'ComHelpUI.pas' {Form6},
  WellcMessSetUI in 'WellcMessSetUI.pas' {Form7},
  FactSetUI in 'FactSetUI.pas' {Form8},
  SkFriendListUI in 'SkFriendListUI.pas' {Form9},
  MLineRadioSetUI in 'MLineRadioSetUI.pas' {Form3},
  Clientcom in 'Clientcom.pas',
  MConsole in 'MConsole.pas' {Form10},
  Loader in 'Loader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
