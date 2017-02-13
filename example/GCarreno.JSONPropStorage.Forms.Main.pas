unit GCarreno.JSONPropStorage.Forms.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, PairSplitter,
  StdCtrls, ExtCtrls, JSONPropStorage;

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
    procedure btnReloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmMain.btnReloadClick(Sender: TObject);
begin
  memConfig.Lines.LoadFromFile(confFileName);
end;

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

end.

