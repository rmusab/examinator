unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, StdCtrls, RzLstBox, RzButton, RzCmboBx,
  RzLabel, RzShellDialogs, Menus, RzStatus, ImgList;

type
  TForm1 = class(TForm)
    Less_List: TRzListBox;
    Panel: TRzPanel;
    btnStart: TRzBitBtn;
    btnPath: TRzBitBtn;
    btnQuit: TRzBitBtn;
    GroupBox: TRzGroupBox;
    Number: TRzComboBox;
    RzSelectFolderDialog1: TRzSelectFolderDialog;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Path_Status: TRzStatusPane;
    procedure btnQuitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Less_ListClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
Uses DataMod, TestForm, About;

{$R *.dfm}

procedure TForm1.btnQuitClick(Sender: TObject);
begin
  Close;  
end;

procedure TForm1.FormShow(Sender: TObject);
var
  F: TSearchRec;
  Path: string;
  Attr: Integer;
begin
  {������ ��� ����� � �������� ���������� � ���������� .abs}
  Path := ExtractFilePath(Application.ExeName)+'Lessons\*.abs';
  Attr := faAnyFile;
  FindFirst(Path, Attr, F);
  {���� ���� �� ���� ���� ������, �� ���������� �����}
  if F.name <> '' then
  begin
    Less_List.Items.Add(F.name); {���������� � TListBox ����� ���������� �����}
    while FindNext(F) = 0 do
      Less_List.Items.Add(F.name);
  end;
  FindClose(F);
  Path_Status.Caption := ExtractFilePath(Application.ExeName)+'Lessons\';
end;

procedure TForm1.Less_ListClick(Sender: TObject);
var i:integer;
begin
  with DataModule1 do begin
  ABSDatabase1.DatabaseFileName :=
  Path_Status.Caption+Less_List.Items.Strings[Less_List.ItemIndex];
  ABSDatabase1.Connected := true;
  ABSTable1.Active := true;
  end;
  btnStart.Enabled := true;
  Number.Clear;
  for i:=1 to DataModule1.ABSTable1.RecordCount do
  Number.Items.Add(IntToStr(i));
  if DataModule1.ABSTable1.RecordCount >= 25 then
    Number.ItemIndex := 24 else
      Number.ItemIndex := DataModule1.ABSTable1.RecordCount-1;
end;

procedure TForm1.btnPathClick(Sender: TObject);
var
  F: TSearchRec;
  Path: string;
  Attr: Integer;
begin
  if RzSelectFolderDialog1.Execute then begin
    Less_List.Clear;
    DataModule1.ABSTable1.Active := false;
    DataModule1.ABSDatabase1.Connected := false;
    btnStart.Enabled := false;
    Number.Clear;
    {������ ��� ����� � �������� ���������� � ���������� .abs}
    Path := RzSelectFolderDialog1.SelectedPathName+'\*.abs';
    Attr := faAnyFile;
    FindFirst(Path, Attr, F);
    {���� ���� �� ���� ���� ������, �� ���������� �����}
    if F.name <> '' then
    begin
      Less_List.Items.Add(F.name); {���������� � TListBox ����� ���������� �����}
      while FindNext(F) = 0 do
        Less_List.Items.Add(F.name);
    end;
    FindClose(F);
    Path_Status.Caption := RzSelectFolderDialog1.SelectedPathName+'\';
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  Form2.Start;
  Form2.ShowModal;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  btnPath.Click;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Form4.ShowModal;
end;

end.
