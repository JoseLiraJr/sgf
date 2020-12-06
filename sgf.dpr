program sgf;

uses
  Vcl.Forms,
  uPrincipal in 'view\uPrincipal.pas' {frmPrincipal},
  uSobre in 'view\uSobre.pas' {frmSobre},
  uBase in 'repository\uBase.pas' {frmBase},
  uVisualControl in 'utils\uVisualControl.pas',
  uCadFuncionario in 'view\uCadFuncionario.pas' {frmCadFuncionario},
  uDmPrincipal in 'model\uDmPrincipal.pas' {dmPrincipal: TDataModule},
  uConexaoController in 'controller\uConexaoController.pas',
  uDmTabelas in 'model\uDmTabelas.pas' {dmTabelas: TDataModule},
  uFuncionarioController in 'controller\uFuncionarioController.pas',
  uFuncionario in 'model\uFuncionario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SGF - Sistema de Gerenciamento de Funcionários';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
