unit UPliki;

interface

uses
  System.Classes, System.SysUtils, jpeg, pngimage, Vcl.Graphics;

type
  TPliki = class
    class function dajListePlikowZFolderu(const sciezka: String): TStringList;
    class procedure przekonwertujBitmape(const sciezka, zapis: String; const format: Byte);
    class procedure przekonwertujJpeg(const sciezka, zapis: String; const format: Byte);
    class procedure przekonwertujPng(const sciezka, zapis: String; const format: Byte);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

class function TPliki.dajListePlikowZFolderu(const sciezka: String): TStringList;
var
  listaPlikow: TStringList;
  SR: TSearchRec;
begin
  listaPlikow := TStringList.Create;
  try
    if (FindFirst(sciezka + '\' + '*.*', faAnyFile, SR) = 0) then
    begin
      repeat
        if (ExtractFileExt(sr.Name) = '.jpg')
        or (ExtractFileExt(sr.Name) = '.png')
        or (ExtractFileExt(sr.Name) = '.bmp') then
          listaPlikow.Add(SR.Name);
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
    Result := listaPlikow;
  except
    on E: Exception do
    begin
      raise;
    end;
  end;
end;

class procedure TPliki.przekonwertujBitmape(const sciezka, zapis: String; const format: Byte);
var
  jpeg: TJpegImage;
  bmp: TBitmap;
  png: TPngImage;
begin
  if format = 0 then
  begin
    jpeg := TJpegImage.Create;
    bmp := TBitmap.Create;
    try
      try
        bmp.LoadFromFile(sciezka);
        jpeg.Assign(bmp);
        jpeg.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      jpeg.Free;
      bmp.Free;
    end;
  end;

  if format = 1 then
  begin
    png := TPngImage.Create;
    bmp := TBitmap.Create;
    try
      try
        bmp.LoadFromFile(sciezka);
        png.Assign(bmp);
        png.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      png.Free;
      bmp.Free;
    end;
  end;

  if format = 2 then
  begin
    bmp := TBitmap.Create;
    try
      try
        bmp.LoadFromFile(sciezka);
        bmp.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      bmp.Free;
    end;
  end;
end;

class procedure TPliki.przekonwertujJpeg(const sciezka, zapis: String; const format: Byte);
var
  jpeg: TJpegImage;
  bmp: TBitmap;
  png: TPngImage;
begin
  if format = 0 then
  begin
    jpeg := TJPEGImage.Create;
    try
      try
        jpeg.LoadFromFile(sciezka);
        jpeg.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      jpeg.Free;
    end;
  end;

  if format = 1 then
  begin
    jpeg := TJpegImage.Create;
    png := TPngImage.Create;
    try
      try
        jpeg.LoadFromFile(sciezka);
        png.Assign(bmp);
        png.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      jpeg.Free;
      png.Free;
    end;
  end;
  
  if format = 2 then
  begin
    jpeg := TJpegImage.Create;
    bmp := TBitmap.Create;
    try
      try
        jpeg.LoadFromFile(sciezka);
        bmp.Assign(jpeg);
        bmp.SaveToFile(zapis);
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      jpeg.Free;
      bmp.Free;
    end;
  end;
end;

class procedure TPliki.przekonwertujPng(const sciezka, zapis: String; const format: Byte);
var
  jpeg: TJpegImage;
  bmp: TBitmap;
  png: TPngImage;
begin
  if format = 0 then
  begin
    jpeg := TJPEGImage.Create;
    png := TPngImage.Create;
    try
      try
        jpeg.LoadFromFile(sciezka);
        png.Assign(jpeg);
        png.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      jpeg.Free;
      png.Free;
    end;
  end;
  
  if format = 1 then
  begin
    png := TPngImage.Create;
    try
      try
        png.LoadFromFile(sciezka);
        png.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      png.Free;
    end;
  end;

  if format = 2 then
  begin
    bmp := TBitmap.Create;
    png := TPngImage.Create;
    try
      try
        png.LoadFromFile(sciezka);
        bmp.Assign(jpeg);
        bmp.SaveToFile(zapis);
        exit;
      except
        on E: Exception do
        begin
          raise;
        end;
      end;
    finally
      bmp.Free;
      png.Free;
    end;
  end;
end;

end.
