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

unit Sanitizer.HTML.Decode;

interface

uses
  DataValidator.ItemBase.Sanitizer,
  System.NetEncoding;

type
  TSanitizerHTMLDecode = class(TDataValidatorItemBaseSanitizer)
  private
  public
    function Sanitize: TValue; override;
  end;

implementation

{ TSanitizerHTMLDecode }

function TSanitizerHTMLDecode.Sanitize: TValue;
var
  LValue: string;
  LValueDecode: string;
begin
  LValue := GetValueAsString;

  try
    LValueDecode := THTMLEncoding.HTML.Decode(LValue);
  except
    LValueDecode := LValue;
  end;

  SetValueAdapter(LValueDecode);

  Result := FValue;
end;

end.
