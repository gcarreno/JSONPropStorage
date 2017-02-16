unit GCarreno.JSONPropStorage.Forms.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, PairSplitter,
  StdCtrls, ExtCtrls, JSONPropStorage, PropertyStorage;

{ TfrmMain }

type
  TfrmMain = class(TForm)
    btnReload: TButton;
    JSONPropStorage1: TJSONPropStorage;
    lblTitleConfig: TLabel;
    lblTitleLog: TLabel;
    lblConfFileName: TLabel;
    memLog: TMemo;
    memConfig: TMemo;
    panButtons: TPanel;
    panTitleLog: TPanel;
    psMain: TPairSplitter;
    pssContent: TPairSplitterSide;
    pssLog: TPairSplitterSide;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure btnReloadClick(Sender: TObject);
    procedure JSONPropStorage1RestoreProperties(Sender: TObject);
    procedure JSONPropStorage1RestoringProperties(Sender: TObject);
    procedure JSONPropStorage1SaveProperties(Sender: TObject);
    procedure JSONPropStorage1SavingProperties(Sender: TObject);
  private
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

var
  confFileName: String;

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  memLog.Lines.Add('Assigning config file:');
  confFileName := ChangeFileExt(GetAppConfigFile(False), '.json');
  memLog.Lines.Add(#9+confFileName);
  memLog.Lines.Add('Setting label');
  lblConfFileName.Caption := 'Filename: '+confFileName;
  memLog.Lines.Add('Setting filename on JSONPropSTorage');
  JSONPropStorage1.JSONFileName := confFileName;
  memLog.Lines.Add('Setting RootObjectPath on JSONPropSTorage');
  JSONPropStorage1.RootObjectPath := 'application';
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmMain.btnReloadClick(Sender: TObject);
var
  oValue: TStoredValue;
  index: Integer;
begin
  memLog.Lines.Add('Loading: '+confFileName);
  memConfig.Lines.LoadFromFile(confFileName);
  memLog.Lines.Add('Listing Stored Values.');
  memConfig.Lines.Add('Stored Values:');
  for index := 0 to JSONPropStorage1.StoredValues.Count - 1 do
  begin
    memConfig.Lines.Add(
      'Name: '+
      JSONPropStorage1.StoredValues[index].Name+
      '='+
      JSONPropStorage1.StoredValues[index].Value);
  end;
end;

procedure TfrmMain.JSONPropStorage1RestoreProperties(Sender: TObject);
begin
  if Assigned(memLog) then
  begin
    memLog.Lines.Add('Event: OnRestoreProperties');
    memLog.Lines.Add(#9'Class Name: '+Sender.ClassName);
  end;
end;

procedure TfrmMain.JSONPropStorage1RestoringProperties(Sender: TObject);
begin
  if Assigned(memLog) then
  begin
    memLog.Lines.Add('Event: OnRestoringProperties');
    memLog.Lines.Add(#9'Class Name: '+Sender.ClassName);
  end;
end;

procedure TfrmMain.JSONPropStorage1SaveProperties(Sender: TObject);
begin
  if Assigned(memLog) then
    memLog.Lines.Add('Event: OnSaveProperties');
end;

procedure TfrmMain.JSONPropStorage1SavingProperties(Sender: TObject);
begin
  if Assigned(memLog) then
    memLog.Lines.Add('Event: OnSavingProperties');
end;

end.

