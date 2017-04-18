object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Image Converter'
  ClientHeight = 469
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 424
    Width = 449
    Height = 17
    TabOrder = 0
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 0
    Width = 449
    Height = 89
    Caption = 'Dodaj pliki'
    TabOrder = 1
    object Edit1: TEdit
      Left = 16
      Top = 24
      Width = 417
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 16
      Top = 51
      Width = 201
      Height = 25
      Caption = 'Dodaj folder'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 240
      Top = 51
      Width = 193
      Height = 25
      Caption = 'Dodaj pliki'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 102
    Width = 217
    Height = 316
    Caption = 'Lista plik'#243'w'
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      Left = 16
      Top = 20
      Width = 185
      Height = 223
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CheckListBox1Click
      OnMouseMove = CheckListBox1MouseMove
    end
    object Button3: TButton
      Left = 16
      Top = 249
      Width = 185
      Height = 25
      Caption = 'Podgl'#261'd obrazu'
      Enabled = False
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button6: TButton
      Left = 16
      Top = 282
      Width = 185
      Height = 25
      Caption = 'Wyczy'#347#263' list'#281' plik'#243'w'
      Enabled = False
      TabOrder = 2
      OnClick = Button6Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 231
    Top = 102
    Width = 226
    Height = 316
    Caption = 'Konwersja'
    TabOrder = 3
    object GroupBox1: TGroupBox
      Left = 11
      Top = 20
      Width = 198
      Height = 85
      Caption = 'Nazwy plik'#243'w'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 39
        Width = 96
        Height = 13
        Caption = 'Prefiks nazw plik'#243'w:'
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 16
        Width = 129
        Height = 17
        Caption = 'Zachowaj nazwy plik'#243'w'
        Enabled = False
        TabOrder = 0
      end
      object Edit3: TEdit
        Left = 16
        Top = 51
        Width = 161
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = 'prefix'
      end
    end
    object RadioGroup1: TRadioGroup
      Left = 11
      Top = 111
      Width = 198
      Height = 78
      Caption = 'Format wyj'#347'ciowy'
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'BMP'
        'JPG'
        'PNG')
      TabOrder = 1
    end
    object GroupBox5: TGroupBox
      Left = 11
      Top = 195
      Width = 198
      Height = 81
      Caption = 'Folder wyj'#347'ciowy'
      TabOrder = 2
      object Edit2: TEdit
        Left = 16
        Top = 20
        Width = 169
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object Button4: TButton
        Left = 16
        Top = 47
        Width = 169
        Height = 25
        Caption = 'Wybierz folder'
        Enabled = False
        TabOrder = 1
        OnClick = Button4Click
      end
    end
    object Button5: TButton
      Left = 11
      Top = 282
      Width = 198
      Height = 25
      Caption = 'Konwertuj'
      Enabled = False
      TabOrder = 3
      OnClick = Button5Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 450
    Width = 464
    Height = 19
    Panels = <
      item
        Text = #169' Tomasz Krzywicki'
        Width = 50
      end>
    ExplicitLeft = 440
    ExplicitTop = 456
    ExplicitWidth = 0
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Title = 'Dodaj folder'
    Left = 392
    Top = 80
  end
  object FileOpenDialog2: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Title = 'Dodaj pliki'
    Left = 416
    Top = 184
  end
  object FileOpenDialog3: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'JPG'
        FileMask = '*.jpg'
      end
      item
        DisplayName = 'PNG'
        FileMask = '*.png'
      end
      item
        DisplayName = 'BMP'
        FileMask = '*.bmp'
      end>
    Options = [fdoAllowMultiSelect]
    Title = 'Wybierz folder wyj'#347'ciowy'
    Left = 328
    Top = 128
  end
  object MainMenu1: TMainMenu
    Left = 408
    Top = 128
    object Plik1: TMenuItem
      Caption = 'Plik'
      object DodajFolder1: TMenuItem
        Caption = 'Dodaj Folder'
      end
      object Dodajpliki1: TMenuItem
        Caption = 'Dodaj pliki'
      end
      object Koniec1: TMenuItem
        Caption = 'Koniec'
        OnClick = Koniec1Click
      end
    end
    object Pomoc1: TMenuItem
      Caption = 'Pomoc'
    end
  end
end
