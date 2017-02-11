unit JSONPropStorage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, JSONConf;

type
{ TCustomJSONPropStorage }
  TCustomJSONPropStorage = class(TFormPropertyStorage)
  private
    FCount : Integer;
    FReadOnly : Boolean;
    FJSONFileName: string;
    FRootObjectPath: string;
    FJSONConf: TJSONConfig;
  protected
    function GetJSONFileName: string; virtual;
    function RootSection: string; override;
    function FixPath(const APath: String): String; virtual;

    property JSONConf: TJSONConfig read FJSONConf;
  public
    procedure StorageNeeded(ReadOnly: Boolean); override;
    procedure FreeStorage; override;
    function  DoReadString(const Section, Ident, Default: string): string; override;
    procedure DoWriteString(const Section, Ident, Value: string); override;
    procedure DoEraseSections(const ARootObjectPath : string);override;
  public
    property JSONFileName: string read FJSONFileName write FJSONFileName;
    property RootObjectPath: string read FRootObjectPath write FRootObjectPatht;
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

function TCustomJSONPropStorage.GetJSONFileName: string;
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

function TCustomJSONPropStorage.RootSection: string;
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
end;

procedure TCustomJSONPropStorage.StorageNeeded(ReadOnly: Boolean);
begin
  if (FJSONConf=nil) and not (csDesigning in ComponentState) then
  begin
    FJSONConf := TJSONConfig.Create(nil);
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
  Default: string): string;
begin
  Result := FJSONConf.GetValue(FixPath(Section)+'/'+Ident, Default);
end;

procedure TCustomJSONPropStorage.DoWriteString(const Section, Ident,
  Value: string);
begin
  FJSONConf.SetValue(FixPath(Section)+'/'+Ident, Value);
end;

procedure TCustomJSONPropStorage.DoEraseSections(const ARootObjectPath: string);
begin
  FJSONConf.DeletePath(FixPath(ARootObjectPath));
end;

end.
