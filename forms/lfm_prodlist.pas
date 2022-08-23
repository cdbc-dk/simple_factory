unit lfm_prodlist;

{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  u_basereport;
const
  cProdListName = 'Product listing';
type
  { TfrmProductList }
  TfrmProductList = class(TForm)
    btnDone: TButton;
    Label1: TLabel;
    procedure btnDoneClick(Sender: TObject);
  private
  public
  end;
  { TProductListingReport }
  TProductListingReport = class(TBaseReport)
  private
    fProdListForm: TfrmProductList;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ShowReport; override;
  end;

var frmProductList: TfrmProductList;

implementation
uses u_factory; { for registering our report }
{$R *.lfm}

{ TProductListingReport }
constructor TProductListingReport.Create;
begin
  fProdListForm:= TfrmProductList.Create(nil); //bm
  fProdListForm.OnClose:= @FormClose; { eventhandler inherited from basereport }
end;

destructor TProductListingReport.Destroy;
begin
  fProdListForm.Free;
  inherited Destroy;
end;

procedure TProductListingReport.ShowReport;
begin
  fProdListForm.ShowModal;
end;

{ TfrmProductList }
procedure TfrmProductList.btnDoneClick(Sender: TObject);
begin
  Close;
end;

initialization
//  frmProductList:= nil;
  ReportFactory.RegisterReport(cProdListName,TProductListingReport);
finalization
//  if assigned(frmProductList) then FreeAndNil(frmProductList);
end.

