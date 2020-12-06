unit uVisualControl;

interface

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.Controls, Vcl.ComCtrls, System.Classes,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.DateUtils;

function CharNumbers(Key : Char) : Boolean;
procedure ClearEdit(edt : TEdit);
procedure EnableControls(control : TwinControl; enable : Boolean);
function ValidaData(Data : string): Boolean;
function CharData(Key : Char) : Boolean;
function dayOfWeek : string;
function dataExtenso : string;

implementation

function CharNumbers(Key : Char) : Boolean;
begin
  //Limitando a escrita de caracteres.
  Result := True;
  if not(CharInSet(Key,['0'..'9',#8])) then
   Result := False;
end;

procedure ClearEdit(edt : TEdit);
begin
  //Limpando um Edit
  edt.Clear;
end;

procedure EnableControls(control : TwinControl; enable : Boolean);
var
  i : integer;
begin
 //Habilitando e desabilitando controles
 for i := 0 to control.ControlCount - 1 do
   begin
     if (control.Controls[i] is TEdit) then
      (control.Controls[i] as TEdit).Enabled := enable;
     if (control.Controls[i] is TDBLookupComboBox) then
      (control.Controls[i] as TDBLookupComboBox).Enabled := enable;
     if (control.Controls[i] is TSpeedButton) then
      (control.Controls[i] as TSpeedButton).Enabled := enable;
     if (control.Controls[i] is TBitBtn) then
      (control.Controls[i] as TBitBtn).Enabled := enable;
     if (control.Controls[i] is TDateTimePicker) then
      (control.Controls[i] as TDateTimePicker).Enabled := enable;
   end;
end;

function ValidaData(Data : string): Boolean;
var
  s: string;
  i: Integer;
begin
  Result := True;
  //Validando a data digitada
  for i := 1 to Length(Data) do
   begin
     if Data[i] in ['0'..'9', '/'] then
      s := s + Data[i];
   end;

  try
    StrToDate(s);
  except
    Result := False;
  end;
end;

function CharData(Key : Char) : Boolean;
begin
  //Limitando a escrita de caracteres.
  Result := True;
  if not(CharInSet(Key,['0'..'9','/',#8])) then
   Result := False;
end;

function dayOfWeek : string;
begin
  case DayOfTheWeek(now) of
    1 : Result := 'Segunda';
    2 : Result := 'Terça';
    3 : Result := 'Quarta';
    4 : Result := 'Quinta';
    5 : Result := 'Sexta';
    6 : Result := 'Sábado';
    7 : Result := 'Domingo';
  end;
end;

function dataExtenso : string;
var
  mes : string;
begin
  case MonthOfTheYear(now) of
    1  : mes := 'Janeiro';
    2  : mes := 'Fevereiro';
    3  : mes := 'Março';
    4  : mes := 'Abril';
    5  : mes := 'Maio';
    6  : mes := 'Junho';
    7  : mes := 'Julho';
    8  : mes := 'Agosto';
    9  : mes := 'Setembro';
    10 : mes := 'Outubro';
    11 : mes := 'Novembro';
    12 : mes := 'Dezembro';
  end;

  Result := FormatDateTime('dd', now) + ' de ' + mes + ' de ' + FormatDateTime('yyyy', now);
end;

end.
