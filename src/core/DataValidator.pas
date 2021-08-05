{
  *************************************
  Created by Danilo Lucas
  Github - https://github.com/dliocode
  *************************************
}

unit DataValidator;

interface

uses
  DataValidator.Intf, DataValidator.Context.Intf, DataValidator.Result.Intf,
  DataValidator.Types, DataValidator.Schema, DataValidator.Value, DataValidator.JSON,
  System.JSON;

type
  TDataValidatorLocaleLanguage = DataValidator.Types.TDataValidatorLocaleLanguage;

  IDataValidatorSchema = DataValidator.Intf.IDataValidatorSchema;
  IDataValidatorValue = DataValidator.Intf.IDataValidatorValue;
  IDataValidatorJSON = DataValidator.Intf.IDataValidatorJSON;

  IDataValidatorValueResult = DataValidator.Intf.IDataValidatorValueResult;
  IDataValidatorJSONResult = DataValidator.Intf.IDataValidatorJSONResult;

  IDataValidatorResult = DataValidator.Result.Intf.IDataValidatorResult;
  IDataValidatorSchemaContext = DataValidator.Context.Intf.IDataValidatorSchemaContext;

  TDataValidator = class
  private
  public
    class function Schema: IDataValidatorSchema;
    class function Values: IDataValidatorValue;
    class function JSON(const AJSON: TJSONObject): IDataValidatorJSON; overload;
    class function JSON(const AJSON: TJSONArray): IDataValidatorJSON; overload;
  end;

implementation

{ TDataValidator }

class function TDataValidator.Schema: IDataValidatorSchema;
begin
  Result := TDataValidatorSchema.Create();
end;

class function TDataValidator.Values: IDataValidatorValue;
begin
  Result := TDataValidatorValue.Create();
end;

class function TDataValidator.JSON(const AJSON: TJSONObject): IDataValidatorJSON;
begin
  Result := TDataValidatorJSON.Create(AJSON);
end;

class function TDataValidator.JSON(const AJSON: TJSONArray): IDataValidatorJSON;
begin
  Result := TDataValidatorJSON.Create(AJSON);
end;

end.
