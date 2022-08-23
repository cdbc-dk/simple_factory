unit lfm_discprod;

{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  u_basereport;
const
  cDiscontinuedProdctsName = 'Discontinued products listing';
type
  { TfrmDiscProd }
  TfrmDiscProd = class(TForm)
    btnClose: TButton;
    GroupBox1: TGroupBox;
    procedure btnCloseClick(Sender: TObject);
  private
  public
  end;
  { TDiscontinuedProductsReport }
  TDiscontinuedProductsReport = class(TBaseReport)
  private
    fDiscProdForm: TfrmDiscProd;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ShowReport; override;
  end;

var
  frmDiscProd: TfrmDiscProd;

implementation
uses u_factory; { for registering our report }
{$R *.lfm}

{ TDiscontinuedProductsReport }
constructor TDiscontinuedProductsReport.Create;
begin
  fDiscProdForm:= TfrmDiscProd.Create(nil);
  fDiscProdForm.OnClose:= @FormClose; { eventhandler inherited from basereport }
end;

destructor TDiscontinuedProductsReport.Destroy;
begin
  fDiscProdForm.Free;
  inherited Destroy;
end;

procedure TDiscontinuedProductsReport.ShowReport;
begin
  fDiscProdForm.ShowModal;
end;

{ TfrmDiscProd }
procedure TfrmDiscProd.btnCloseClick(Sender: TObject);
begin
  Close;
end;

initialization
  ReportFactory.RegisterReport(cDiscontinuedProdctsName,TDiscontinuedProductsReport);
end.

