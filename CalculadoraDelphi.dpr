program CalculadoraDelphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormPrincipal in 'src\FormPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
