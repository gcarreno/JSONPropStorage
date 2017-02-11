{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit JSONPropStorage;

interface

uses
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('JSONPropStorage', @JSONPropStorage.Register);
end;

initialization
  RegisterPackage('JSONPropStorage', @Register);
end.
