{
  ********************************************************************************

  Github - https://github.com/dliocode/datavalidator

  ********************************************************************************

  MIT License

  Copyright (c) 2021 Danilo Lucas

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  ********************************************************************************
}

unit DataValidator.Types;

interface

uses
  System.JSON;

type
  TDataValidatorMessage = record
    Title: string;
    Message: string;
    Detail: string;
    Status: string;
  end;

  TDataValidatorLocaleLanguage = (tl_en_US, tl_de_DE, tl_fr_FR, tl_it_IT, tl_es_ES, tl_ru_RU, tl_pt_BR);

  TDataValidatorCustomResult = reference to function: Boolean;
  TDataValidatorCustomSanitizer = reference to function(const AValue: string): string;

  TDataValidatorCustomValue = reference to function(const AValue: string): Boolean;
  TDataValidatorCustomValueMessage = reference to function(const AValue: string; var AMessage: string): Boolean;
  TDataValidatorCustomMessage = reference to function(const AValue: string; var AMessage: TDataValidatorMessage): Boolean;

  TDataValidatorCustomJSONValue = reference to function(const AValue: TJSONValue): Boolean;
  TDataValidatorCustomJSONValueMessage = reference to function(const AValue: TJSONValue; var AMessage: string): Boolean;
  TDataValidatorCustomJSONMessage = reference to function(const AValue: TJSONValue; var AMessage: TDataValidatorMessage): Boolean;

  TDataValidatorInformationExecute = reference to procedure;
  TDataValidatorWithMessage = reference to procedure(var AMessage: TDataValidatorMessage);

implementation

end.
