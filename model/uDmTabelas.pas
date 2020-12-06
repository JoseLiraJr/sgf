unit uDmTabelas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDmPrincipal;

type
  TdmTabelas = class(TDataModule)
    qryFuncionario: TFDQuery;
    dsFuncionario: TDataSource;
    qryFuncionarioID: TFDAutoIncField;
    qryFuncionarioNOME: TStringField;
    qryFuncionarioCPF: TStringField;
    qryFuncionarioSEXO: TStringField;
    qryFuncionarioLOGRADOURO: TStringField;
    qryFuncionarioNUMERO: TStringField;
    qryFuncionarioBAIRRO: TStringField;
    qryFuncionarioCIDADE: TStringField;
    qryFuncionarioUF: TStringField;
    qryFuncionarioCEP: TStringField;
    qryFuncionarioTELEFONE: TStringField;
    qryFuncionarioEMAIL: TStringField;
    qryFuncionarioDT_ADMISSAO: TDateField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmTabelas: TdmTabelas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmTabelas.DataModuleCreate(Sender: TObject);
begin
  qryFuncionario.Connection := TdmPrincipal.GetConnection.Conexao;
end;

end.
