unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, jpeg, pngimage;

type
  TForm2 = class(TForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ustawObraz(const sciezka: String);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ustawObraz(const sciezka: string);
begin
  WindowState := wsMaximized;
  Show;
  image1.Picture.LoadFromFile(sciezka);
end;

end.
