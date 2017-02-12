unit JSONPropStorage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, JSONConf, LazUTF8;

type
{ TCustomJSONPropStorage }
  TCustomJSONPropStorage = class(TFormPropertyStorage)
  private
    FCount : Integer;
    FJSONFileName: string;
    FRootObjectPath: String;
    FJSONConf: TJSONConfig;
  protected
    function GetJSONFileName: String; virtual;
    function RootSection: String; override;
    function FixPath(const APath: String): String; virtual;

    property JSONConf: TJSONConfig read FJSONConf;
  public
    procedure StorageNeeded(ReadOnly: Boolean); override;
    procedure FreeStorage; override;
    function  DoReadString(const Section, Ident, Default: String): String; override;
    procedure DoWriteString(const Section, Ident, Value: String); override;
    procedure DoEraseSections(const ARootObjectPath : String);override;
  public
    property JSONFileName: String read FJSONFileName write FJSONFileName;
    property RootObjectPath: String read FRootObjectPath write FRootObjectPath;
  end;

{ TJSONPropStorage }
  TJSONPropStorage = class(TCustomJSONPropStorage)
  published
    Property StoredValues;
    property JSONFileName;
    property Active;
    property OnSavingProperties;
    property OnSaveProperties;
    property OnRestoringProperties;
    property OnRestoreProperties;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Misc',[TJSONPropStorage]);
end;

{ TCustomJSONPropStorage }

function TCustomJSONPropStorage.GetJSONFileName: String;
begin
  If (FJSONFileName<>'') then
    Result:=FJSONFileName
  else if csDesigning in ComponentState then
    raise Exception.Create('TCustomJSONPropStorage.GetJSONFileName: missing Filename')
  else
{$ifdef unix}
    Result:=IncludeTrailingPathDelimiter(GetEnvironmentVariableUTF8('HOME'))
            +'.'+ExtractFileName(Application.ExeName);

{$else}
    Result:=ChangeFileExt(Application.ExeName,'.json');
{$endif}
end;

function TCustomJSONPropStorage.RootSection: String;
begin
  if (FRootObjectPath<>'') then
    Result := FRootObjectPath
  else
    Result := inherited RootSection;
  Result := FixPath(Result);
end;

function TCustomJSONPropStorage.FixPath(const APath: String): String;
begin
  Result:=StringReplace(APath,'.','/',[rfReplaceAll]);
  Result:=StringReplace(APath,'_','/',[rfReplaceAll]);
end;

procedure TCustomJSONPropStorage.StorageNeeded(ReadOnly: Boolean);
begin
  if (FJSONConf=nil) and not (csDesigning in ComponentState) then
  begin
    FJSONConf := TJSONConfig.Create(nil);
    FJSONConf.Formatted := True;
    FJSONConf.Filename := GetJSONFileName;
  end;
  Inc(FCount);
end;

procedure TCustomJSONPropStorage.FreeStorage;
begin
  Dec(FCount);
  if (FCount<=0) then
  begin
    FCount:=0;
    FreeAndNil(FJSONConf);
  end;
end;

function TCustomJSONPropStorage.DoReadString(const Section, Ident,
  Default: String): String;
begin
  Result := FJSONConf.GetValue(FixPath(Section)+'/'+FixPath(Ident), Default);
end;

procedure TCustomJSONPropStorage.DoWriteString(const Section, Ident,
  Value: String);
begin
  FJSONConf.SetValue(FixPath(Section)+'/'+FixPath(Ident), Value);
end;

procedure TCustomJSONPropStorage.DoEraseSections(const ARootObjectPath: String);
begin
  FJSONConf.DeletePath(FixPath(ARootObjectPath));
end;

end.
