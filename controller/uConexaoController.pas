unit uConexaoController;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  TConexaoController = class
    localAplicacao : string;
  public
    criouDados : Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure createData;
  end;

implementation

uses
  uDmPrincipal;

{ TConexaoController }

constructor TConexaoController.Create;
begin
  inherited Create;
end;

procedure TConexaoController.createData;
var
  query : TFDQuery;
begin
  query := TFDQuery.Create(nil);
  try
    try
      query.Connection := TdmPrincipal.GetConnection.Conexao;

      //Criando a Tabela Funcionario
      query.SQL.Clear;
      query.SQL.Add('CREATE TABLE IF NOT EXISTS FUNCIONARIO ( ');
      query.SQL.Add('ID INTEGER PRIMARY KEY AUTOINCREMENT, ');
      query.SQL.Add('NOME VARCHAR(150) NOT NULL, ');
      query.SQL.Add('CPF VARCHAR(11) NOT NULL, ');
      query.SQL.Add('SEXO CHAR(1) NOT NULL CHECK (SEXO IN (''M'',''F'')), ');
      query.SQL.Add('LOGRADOURO VARCHAR(150), ');
      query.SQL.Add('NUMERO VARCHAR(10), ');
      query.SQL.Add('BAIRRO VARCHAR(70), ');
      query.SQL.Add('CIDADE VARCHAR(70), ');
      query.SQL.Add('UF CHAR(2), ');
      query.SQL.Add('CEP VARCHAR(8), ');
      query.SQL.Add('TELEFONE VARCHAR(12), ');
      query.SQL.Add('EMAIL VARCHAR(100), ');
      query.SQL.Add('DT_ADMISSAO DATE )');
      query.ExecSQL;
      criouDados := True;
    except
      on e : Exception do
       begin
         criouDados := False;
         raise Exception.Create('Erro ao criar as tabelas do Sistema!' + sLineBreak +
                                'Descrição do Erro: ' + e.Message);
       end;
    end;
  finally
    query.Free;
  end;
end;

destructor TConexaoController.Destroy;
begin
  inherited Destroy;
end;

end.
