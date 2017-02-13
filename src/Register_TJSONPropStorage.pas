{
  JSONPropStorage component.

  Copyright 2017 Gustavo Carreno <guscarreno@gmail.com>

  This component is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
}
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
