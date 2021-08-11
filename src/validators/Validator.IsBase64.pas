{
  *************************************
  Created by Danilo Lucas
  Github - https://github.com/dliocode
  *************************************
}

unit Validator.IsBase64;

interface

uses
  DataValidator.ItemBase,
  System.SysUtils, System.RegularExpressions, System.NetEncoding;

type
  TValidatorIsBase64 = class(TDataValidatorItemBase, IDataValidatorItem)
  private
  public
    function Checked: IDataValidatorResult;
    constructor Create(const AMessage: string; const AExecute: TDataValidatorInformationExecute = nil);
  end;

implementation

{ TValidatorIsBase64 }

constructor TValidatorIsBase64.Create(const AMessage: string; const AExecute: TDataValidatorInformationExecute = nil);
begin
  FMessage := AMessage;
  FExecute := AExecute;
end;

function TValidatorIsBase64.Checked: IDataValidatorResult;
var
  LValue: string;
  R: Boolean;
begin
  LValue := GetValueAsString;
  R := False;

  if not Trim(LValue).IsEmpty then
  begin
    R := TRegEx.IsMatch(LValue, '^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$');

    if not R then
      try
        LValue := TNetEncoding.Base64.Decode(LValue);
        R := True;
      except
      end;
  end;

  if FIsNot then
    R := not R;

  Result := TDataValidatorResult.Create(R, TDataValidatorInformation.Create(LValue, FMessage, FExecute));
end;

end.
