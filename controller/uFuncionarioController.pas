unit uFuncionarioController;

interface

uses
  System.SysUtils, Data.DB, uFuncionario, FireDAC.Comp.Client, FireDAC.DApt,
  uDmPrincipal;

type
  TFuncionarioController = class
  private
    funcionario : TFuncionario;
    function GetFuncionario(nome, cpf : string) : Integer;
  public
    function Save(dtSource : TDataSource) : Integer;
    procedure Open(dtSource : TDataSource);
    procedure Insert(dtSource : TDataSource);
    procedure Edit(dtSource : TDataSource);
    function Delete(dtSource : TDataSource) : Boolean;
    procedure Filter(dtSource : TDataSource; tpPesquisa : Integer; valor : string); overload;
    procedure Cancel(dtSource : TDataSource);

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TFuncionarioController }

procedure TFuncionarioController.Cancel(dtSource: TDataSource);
begin
  if not(funcionario.Cancel(dtSource)) then
    raise Exception.Create('Erro ao tentar cancelar a opera��o!');
end;

constructor TFuncionarioController.Create;
begin
  funcionario := TFuncionario.Create;
  inherited Create;
end;

function TFuncionarioController.Delete(dtSource: TDataSource): Boolean;
begin
  if (dtSource.DataSet.RecordCount <= 0) then
    raise Exception.Create('A tabela est� vazia!');

  Result:= funcionario.Delete(dtSource);
  if not(Result) then
   raise Exception.Create('Erro ao tentar excluir o resgistro');
end;

destructor TFuncionarioController.Destroy;
begin
  funcionario.Free;
  inherited Destroy;
end;

procedure TFuncionarioController.Edit(dtSource: TDataSource);
begin
  if not(funcionario.Edit(dtSource)) then
   raise Exception.Create('Erro ao tentar colocar a tabela de cadastro de funcion�rios em modo de edi��o!');
end;

procedure TFuncionarioController.Filter(dtSource: TDataSource;
  tpPesquisa: Integer; valor: string);
var
  vlrInt : Integer;
begin
  if (valor = '') then
   raise Exception.Create('Valor da pesquisa est� vazio!');

  if (tpPesquisa = 0) then
   begin
    try
      vlrInt := StrToInt(valor);
    except
      vlrInt := 0;
    end;

    if not(funcionario.Filter(dtSource, vlrInt)) then
      raise Exception.Create('Erro ao ralizar a pesquisa');
   end
  else
  if (tpPesquisa = 1) then
   begin
     if not(funcionario.Filter(dtSource, valor)) then
       raise Exception.Create('Erro ao ralizar a pesquisa');
   end;
end;

function TFuncionarioController.GetFuncionario(nome, cpf : string): Integer;
var
  query : TFDQuery;
begin
  query := TFDQuery.Create(nil);
  try
    query.Connection := TdmPrincipal.GetConnection.Conexao;

    query.Open('SELECT * FROM FUNCIONARIO WHERE NOME = ' + QuotedStr(nome) +
                  ' AND CPF = ' + QuotedStr(cpf));
    Result := query.RecordCount;
  finally
    query.Free;
  end;
end;

procedure TFuncionarioController.Insert(dtSource: TDataSource);
begin
  if not(funcionario.Insert(dtSource)) then
   raise Exception.Create('Erro ao tentar colocar a tabela de cadastro de funcion�rios em modo de inser��o!');
end;

procedure TFuncionarioController.Open(dtSource: TDataSource);
begin
  if not(funcionario.Open(dtSource)) then
   raise Exception.Create('Erro ao abrir a tabela de cadastro de funcion�rios!');
end;

function TFuncionarioController.Save(dtSource: TDataSource): Integer;
begin
  //Valida��es do Objeto na camada de controle
  if not(Assigned(dtSource)) then
    raise Exception.Create('A tabela n�o est� criada em mem�ria!');

  if (dtSource.DataSet.FieldByName('NOME').AsString = '') then
    raise Exception.Create('Informe um nome para o funcion�rio, antes de continuar!');

  if (dtSource.DataSet.FieldByName('SEXO').AsString = '') then
    raise Exception.Create('Informe o sexo do funcion�rio, antes de continuar!');

  if (dtSource.DataSet.FieldByName('CPF').AsString = '') then
    raise Exception.Create('Informe o CPF do funcion�rio, antes de continuar!');

  if (dtSource.DataSet.FieldByName('DT_ADMISSAO').AsString = '') then
    raise Exception.Create('Informe a data de admiss�o do funcion�rio, antes de continuar!');

  if (dtSource.DataSet.State = dsInsert) and (GetFuncionario(dtSource.DataSet.FieldByName('NOME').AsString,
      dtSource.DataSet.FieldByName('CPF').AsString) > 0) then
     raise Exception.Create('J� existe um funcion�rio cadastrado com o mesmo nome e CPF!');

  Result := funcionario.Save(dtSource);
  if (Result <= 0) then
   raise Exception.Create('Erro ao tentar salvar um registro na tabela de cadastro de funcion�rios');
end;

end.
