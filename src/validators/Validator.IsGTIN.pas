{
  *************************************
  Created by Danilo Lucas
  Github - https://github.com/dliocode
  *************************************
}

unit Validator.IsGTIN; // GTIN (Global Trade Item Number)

interface

uses
  DataValidator.ItemBase,
  System.SysUtils, System.RegularExpressions;

type
  TTypeGTIN = (tgAll, tg8, tg12, tg13, tg14);

  TValidatorIsGTIN = class(TDataValidatorItemBase, IDataValidatorItem)
  private
    FType: TTypeGTIN;
    function GetPattern: string;
    function CalculateCheckDigit(const AValue: string): Integer;
  public
    function Checked: IDataValidatorResult;
    constructor Create(const AGTINType: TTypeGTIN; const AMessage: string; const AExecute: TDataValidatorInformationExecute = nil);
  end;

implementation

{ TValidatorIsGTIN }

constructor TValidatorIsGTIN.Create(const AGTINType: TTypeGTIN; const AMessage: string; const AExecute: TDataValidatorInformationExecute = nil);
begin
  FType := AGTINType;
  FMessage := AMessage;
  FExecute := AExecute;
end;

function TValidatorIsGTIN.Checked: IDataValidatorResult;
var
  LValue: string;
  R: Boolean;
  LDigit: Integer;
begin
  LValue := GetValueAsString;
  R := False;

  if not Trim(LValue).IsEmpty then
    if TRegEx.IsMatch(LValue, GetPattern) then
    begin
      LDigit := CalculateCheckDigit(LValue);
      R := LDigit = StrToInt(LValue[Length(LValue)]);
    end;

  if FIsNot then
    R := not R;

  Result := TDataValidatorResult.Create(R, TDataValidatorInformation.Create(LValue, FMessage, FExecute));
end;

function TValidatorIsGTIN.GetPattern: string;
begin
  case FType of
    tgAll:
      Result := '^(\d{8}|\d{12,14})$';
    tg8:
      Result := '^\d{8}$';
    tg12:
      Result := '^\d{12}$';
    tg13:
      Result := '^\d{13}$';
    tg14:
      Result := '^\d{14}$';
  end;
end;

function TValidatorIsGTIN.CalculateCheckDigit(const AValue: string): Integer;
var
  I: Integer;
  LSum: Integer;
  LBase10: Integer;
begin
  // https://en.wikipedia.org/wiki/International_Article_Number#Calculation_of_checksum_digit

  LSum := 0;

  for I := 1 to Pred(Length(AValue)) do
    if Length(AValue) = 13 then
    begin
      if Odd(I) then
        LSum := LSum + StrToInt(AValue[I])
      else
        LSum := LSum + (StrToInt(AValue[I]) * 3);
    end
    else
    begin
      if Odd(I) then
        LSum := LSum + StrToInt(AValue[I]) * 3
      else
        LSum := LSum + StrToInt(AValue[I]);
    end;

  LBase10 := LSum;

  if not(LBase10 mod 10 = 0) then
    while not(LBase10 mod 10 = 0) do
      LBase10 := LBase10 + 1;

  Result := LBase10 - LSum;
end;

end.
