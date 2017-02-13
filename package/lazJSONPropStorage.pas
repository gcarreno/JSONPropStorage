{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazJSONPropStorage;

interface

uses
  JSONPropStorage, Register_TJSONPropStorage, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Register_TJSONPropStorage', @Register_TJSONPropStorage.Register
    );
end;

initialization
  RegisterPackage('lazJSONPropStorage', @Register);
end.
