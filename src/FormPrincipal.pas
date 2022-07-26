unit FormPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia, Skia.FMX, Winapi.Windows,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  System.StrUtils;

type
  TFrmPrincipal = class(TForm)
    Background: TSkAnimatedImage;
    Componentes: TLayout;
    ValorNovo: TSkLabel;
    Btn1: TImage;
    Btn2: TImage;
    Btn3: TImage;
    Btn4: TImage;
    Btn5: TImage;
    Btn6: TImage;
    Btn7: TImage;
    Btn8: TImage;
    Btn9: TImage;
    BtnMultiplicar: TImage;
    BtnDiminuir: TImage;
    BtnSomar: TImage;
    BtnResultado: TImage;
    BtnDividir: TImage;
    BtnApagar: TImage;
    BtnNegativo: TImage;
    Btn0: TImage;
    BtnVirgula: TImage;
    BtnLimpar: TImage;
    ValorAnterior: TSkLabel;
    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure BtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure InserirValorNovoClick(Sender: TObject);
    procedure BtnApagarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnNegativoClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnResultadoClick(Sender: TObject);
  private
    procedure Rotacionar(Botao: TButton; Angulo : Integer);
    function  PegarBotaoPeloHint(Hint : string) : TButton;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  valor1: string;
  valor2: string;
  operacao: string;

implementation

{$R *.fmx}

procedure TFrmPrincipal.InserirValorNovoClick(Sender: TObject);
begin
  if (ValorNovo.Text = '0') and (TButton(Sender).Hint = ',') then
    ValorNovo.Text := '0' + TButton(Sender).Hint
  else if (pos(',', ValorNovo.Text) > 0) and (TButton(Sender).Hint = ',') then
    ValorNovo.Text := ValorNovo.Text
  else if ValorNovo.Text = '0' then
    ValorNovo.Text := TButton(Sender).Hint
  else
    ValorNovo.Text := ValorNovo.Text + TButton(Sender).Hint

end;

function TFrmPrincipal.PegarBotaoPeloHint(Hint: string): TButton;
begin
  for var I : Integer := 0 to FrmPrincipal.ComponentCount-1 do
    if FrmPrincipal.Components[I] is TImage then
    begin
       if TImage(FrmPrincipal.Components[I]).Hint = Hint then
       begin
         Result := TButton(FrmPrincipal.Components[I]);
         Break;
       end;
    end;


end;

procedure TFrmPrincipal.BtnApagarClick(Sender: TObject);
var
  tamanho: integer;
begin
  tamanho := length(ValorNovo.Text);
  if tamanho = 1 then
    ValorNovo.Text := '0'
  else
    ValorNovo.Text := copy(ValorNovo.Text, 1, tamanho - 1);
end;

procedure TFrmPrincipal.BtnLimparClick(Sender: TObject);
begin
  ValorAnterior.Text := '';
  ValorNovo.Text := '0';
  valor1 := '';
  valor2 := '';
  operacao := '';
end;

procedure TFrmPrincipal.Rotacionar(Botao: TButton; Angulo : Integer);
begin
  Botao.RotationAngle := Angulo;
end;

procedure TFrmPrincipal.BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Rotacionar(TButton(Sender), 10);
end;


procedure TFrmPrincipal.BtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Rotacionar(TButton(Sender), 0);
end;

procedure TFrmPrincipal.BtnNegativoClick(Sender: TObject);
var
  tamanho: integer;
begin
  if LeftStr(ValorNovo.Text, 1) = '-' then
  begin
    tamanho := Length(ValorNovo.Text);
    ValorNovo.Text := Copy(ValorNovo.Text, 2, tamanho)
  end
  else if ValorNovo.Text <> '0' then
    ValorNovo.Text := '-' + ValorNovo.Text;

end;

procedure TFrmPrincipal.BtnResultadoClick(Sender: TObject);
var
  numero1: real;
  numero2: real;
  calculo: real;
  divisao: real;
  resultado: string;
begin

  numero1 := StrToFloat(valor1);
  numero2 := StrToFloat(ValorNovo.Text);

  case operacao[1] of
    '+' :
      begin
        calculo := numero1 + numero2;
        ValorAnterior.Text := '';
        ValorNovo.Text := FloatToStr(calculo);
      end;
    '-' :
      begin
        calculo := numero1 - numero2;
        ValorAnterior.Text := '';
        ValorNovo.Text := FloatToStr(calculo);
      end;
    '*' :
      begin
        calculo := numero1 * numero2;
        ValorAnterior.Text := '';
        ValorNovo.Text := FloatToStr(calculo);
      end;
    '�' :
      begin
        divisao := numero1 / numero2;
        ValorAnterior.Text := '';
        ValorNovo.Text := FloatToStr(divisao);
      end;
  end;
end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

  if Key = $08 then
  begin
    BtnApagarClick(nil);
    Rotacionar(PegarBotaoPeloHint('Apagar'), 10);
  end;

  if Key = $1B then
  begin
    BtnLimparClick(nil);
    Rotacionar(PegarBotaoPeloHint('Limpar'), 10)
  end;

  if Key = $0D then
  begin
    if ValorAnterior.Text = '' then
      ValorNovo.Text := '0'
    else
      BtnResultadoClick(nil);
      Rotacionar(PegarBotaoPeloHint('='), 10)
  end;

  if KeyChar in ['0'..'9'] then
  begin
    InserirValorNovoClick(PegarBotaoPeloHint(KeyChar));
    Rotacionar(PegarBotaoPeloHint(KeyChar), 10);
  end;

  if KeyChar = ',' then
  begin
    InserirValorNovoClick(PegarBotaoPeloHint(KeyChar));
    Rotacionar(PegarBotaoPeloHint(KeyChar), 10);
  end;

  if KeyChar = '/' then
  begin
    if ValorNovo.Text <> '0' then
    begin
      Rotacionar(PegarBotaoPeloHint('�'), 10);
      valor1 := ValorNovo.Text;
      operacao := '�';
      ValorAnterior.Text := valor1 + ' ' + operacao;
      ValorNovo.Text := '0';
    end
    else
      Rotacionar(PegarBotaoPeloHint('�'), 10);
      ValorNovo.Text := '0';
  end;

  if KeyChar in ['-', '+', '*'] then
  begin
    if ValorNovo.Text <> '0' then
    begin
      Rotacionar(PegarBotaoPeloHint(KeyChar), 10);
      valor1 := ValorNovo.Text;
      operacao := keyChar;
      ValorAnterior.Text := valor1 + ' ' + operacao;
      ValorNovo.Text := '0';
    end
    else
      Rotacionar(PegarBotaoPeloHint(KeyChar), 10);
      ValorNovo.Text := '0';
  end;
end;

procedure TFrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = $08 then
    Rotacionar(PegarBotaoPeloHint('Apagar'), 0);

  if Key = $1B then
    Rotacionar(PegarBotaoPeloHint('Limpar'), 0);

  if Key = $0D then
    Rotacionar(PegarBotaoPeloHint('='), 0);

  if KeyChar in ['0'..'9', ','] then
  begin
    Rotacionar(PegarBotaoPeloHint(KeyChar), 0);
  end;

  if KeyChar = '/' then
    Rotacionar(PegarBotaoPeloHint('�'), 0);

  if KeyChar in ['-', '+', '*'] then
    Rotacionar(PegarBotaoPeloHint(KeyChar), 0);
end;

end.

