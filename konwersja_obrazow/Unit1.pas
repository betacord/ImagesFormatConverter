unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, System.Threading,
  Vcl.ComCtrls, Vcl.Menus, System.IOUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    FileOpenDialog1: TFileOpenDialog;
    Button2: TButton;
    CheckListBox1: TCheckListBox;
    Button3: TButton;
    FileOpenDialog2: TFileOpenDialog;
    Edit2: TEdit;
    Button4: TButton;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    Button5: TButton;
    ProgressBar1: TProgressBar;
    FileOpenDialog3: TFileOpenDialog;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Pomoc1: TMenuItem;
    Koniec1: TMenuItem;
    Button6: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    StatusBar1: TStatusBar;
    DodajFolder1: TMenuItem;
    Dodajpliki1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure CheckListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Koniec1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
  private
    { Private declarations }
    a_Pliki: TStringList;
    a_Sciezka: String;
    a_Wyjscie: String;

    procedure dodajPlikDoListyBox(const nazwa: String);
    procedure dodajPlikDoListy(const nazwa: String);
    procedure pobierzPlikiZFolderu(const sciezka: String);

    procedure dokonajKonwersji;

    procedure ustawPrzyciskiWStanPoczatkowy;
    procedure ustawPrzyciskiDoKonwersji;
  public
    { Public declarations }
  end;

const
  CheckListBoxHints: array[0..3] of string = ('first hint', 'second hint', 'third hint', 'fourth hint');

var
  Form1: TForm1;
  prevIndex: integer = -1;

implementation

{$R *.dfm}

uses
  UPliki, Unit2;

procedure TForm1.pobierzPlikiZFolderu(const sciezka: string);
var
  listaPlikow: TStringList;
  i: Integer;
begin
  listaPlikow := TStringList.Create;
  try
    listaPlikow := TPliki.dajListePlikowZFolderu(sciezka);
    if listaPlikow.Count = 0 then
    begin
      ShowMessage('W wybranym folderze nie znaleziono obrazów');
      a_Sciezka := '';
      edit1.Text := '';
      exit;
    end;
    for I := 0 to listaPlikow.Count - 1 do
    begin
      dodajPlikDoListyBox(listaPlikow[i]);
      dodajPlikDoListy(listaPlikow[i]);
    end;
    ustawPrzyciskiDoKonwersji;
  finally
    listaPlikow.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  FileOpenDialog3.Execute;
  if FileOpenDialog3.Files.Count = 0 then
    exit;
  for I := 0 to FileOpenDialog3.Files.Count - 1 do
  begin
    if CheckListBox1.Items.IndexOf(FileOpenDialog3.Files[i]) = -1 then
      dodajPlikDoListyBox(ExtractFileName(FileOpenDialog3.Files[i]));
    if a_Pliki.IndexOf(FileOpenDialog3.Files[i]) = -1 then
      a_Pliki.Add(FileOpenDialog3.Files[i])
    else
      ShowMessage('Plik nie zosta³ dodany, gdy¿ znajduje siê ju¿ na liœcie');
  end;
  CheckListBox1.CheckAll(cbChecked, false, true);
  ustawPrzyciskiDoKonwersji;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  form2.ustawObraz(a_Pliki[CheckListBox1.ItemIndex]);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FileOpenDialog2.Execute;
  if FileOpenDialog2.FileName = '' then
    exit;
  a_Wyjscie := FileOpenDialog2.FileName;
  edit2.Text := a_Wyjscie;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  dokonajKonwersji;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  CheckListBox1.Clear;
  a_Pliki.Clear;
  ustawPrzyciskiWStanPoczatkowy;
end;

procedure TForm1.CheckListBox1Click(Sender: TObject);
begin
  if CheckListBox1.ItemIndex <> -1 then
    Button3.Enabled := true;
end;

procedure TForm1.CheckListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  index: integer;
begin
  index := CheckListBox1.ItemAtPos(point(X, Y), true);
  if index <> -1 then
    CheckListBox1.Hint := a_Pliki[index]
  else
    CheckListBox1.Hint := '';
  if index <> prevIndex then
    Application.CancelHint;
  prevIndex := index;
end;

procedure TForm1.dodajPlikDoListyBox(const nazwa: string);
begin
  if CheckListBox1.Items.IndexOf(nazwa) = -1 then
    CheckListBox1.Items.Add(nazwa);
end;

procedure TForm1.dodajPlikDoListy(const nazwa: string);
begin
  if a_Pliki.IndexOf(a_Sciezka + '\' + nazwa) = -1 then
    a_Pliki.Add(a_Sciezka + '\' + nazwa);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  a_Pliki := TStringList.Create;
  FormatSettings.TimeSeparator := '_';
  FormatSettings.DateSeparator := '_';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  a_Pliki.Free;
end;

procedure TForm1.Koniec1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.dokonajKonwersji;
var
  aTask: ITask;
  ext: String;
  prefix: String;
  zapis: String;
  rozszerzenie: String;
  czas: String;
begin
  case RadioGroup1.ItemIndex of
    0: rozszerzenie := '.bmp';
    1: rozszerzenie := '.jpg';
    2: rozszerzenie := '.png';
  end;
  ProgressBar1.Min := 0;
  ProgressBar1.Max := a_Pliki.Count - 1;
  ProgressBar1.Position := 0;
  prefix := Edit3.Text;
  aTask := TTask.Create (procedure ()
   var
    i: integer;
   begin
      for I := 0 to a_Pliki.Count - 1 do
      begin
        if CheckListBox1.Checked[i] = false then
          continue;
        zapis := a_Wyjscie + '\' + prefix + '_' + DateToStr(now) + TimeToStr(now) +
          '_' + IntToStr(i) + rozszerzenie;
        if CheckBox1.Checked then
          zapis := a_Wyjscie + '\' + TPath.GetFileNameWithoutExtension(a_Pliki[i]) +
            rozszerzenie;
        ext := ExtractFileExt(a_Pliki[i]);
        if ext = '.jpg' then
        begin
          TPliki.przekonwertujJpeg(a_Pliki[i], zapis, 0);
        end;
        if ext = '.png' then
        begin
          TPliki.przekonwertujPng(a_Pliki[i], zapis, 1);
        end;
        if ext = '.bmp' then
        begin
          TPliki.przekonwertujBitmape(a_Pliki[i], zapis, 2);
        end;

        TThread.Synchronize(nil,procedure
        begin
          ProgressBar1.Position := ProgressBar1.Position + 1;
        end);
      end;
   end);
 aTask.Start;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    FileOpenDialog1.Execute;
    if FileOpenDialog1.FileName = '' then
      exit;
    a_Sciezka := FileOpenDialog1.FileName;
    Edit1.Text := a_Sciezka;
    Edit1.SelStart := Length(Edit1.Text);
    pobierzPlikiZFolderu(a_Sciezka);
    CheckListBox1.CheckAll(cbChecked, false, true);
  except
    on E: Exception do
    begin
      ShowMessage('Wyst¹pi³ nieoczekiwany b³¹d: ' + E.message);
    end;
  end;
end;

procedure TForm1.ustawPrzyciskiWStanPoczatkowy;
begin
  button1.Enabled := true;
  button2.Enabled := true;
  button3.Enabled := false;
  button6.Enabled := false;
  button4.Enabled := false;
  button5.Enabled := false;
  CheckListBox1.Enabled := false;
  checkbox1.Enabled := false;
  edit3.Text := 'prefix';
  CheckListBox1.ItemIndex := 0;
  CheckListBox1.Enabled := false;
  RadioGroup1.Enabled := false;
  edit2.Text := '';
  edit1.Text := '';
end;

procedure TForm1.ustawPrzyciskiDoKonwersji;
begin
  button1.Enabled := true;
  button2.Enabled := true;
  button6.Enabled := true;
  button4.Enabled := true;
  button5.Enabled := true;
  CheckBox1.Enabled := true;
  CheckListBox1.Enabled := true;
  edit3.Enabled := true;
  RadioGroup1.Enabled := true;
end;

end.
