unit Register_TJSONPropStorage;

{$mode objfpc}{$H+}

interface
uses
  Classes,
  SysUtils,
  {LResources,  To be used when Icon is done}
  JSONPropStorage;

Procedure Register;

implementation

Procedure Register;
begin
  {.$I tjsonpropstorage_icon.lrs}   // [optional] if you have a custom component icon [as generate by "lazres.exe"]
  RegisterComponents('Misc', [TJSONPropStorage]);
end;

end.
