unit lfm_lowstock;

{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  u_basereport;
const
  cLowStockName = 'Low on stock listing';
type
  { TfrmLowStock }
  TfrmLowStock = class(TForm)
    btnFinished: TButton;
    ListBox1: TListBox;
    procedure btnFinishedClick(Sender: TObject);
  private
  public
  end;
  { TLowStockListingReport }
  TLowStockListingReport = class(TBaseReport)
  private
    fLowStockForm: TfrmLowStock;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ShowReport; override;
  end;

var
  frmLowStock: TfrmLowStock;

implementation
uses u_factory; { for registering our report }
{$R *.lfm}

{ TLowStockListingReport }
constructor TLowStockListingReport.Create;
begin
  fLowStockForm:= TfrmLowStock.Create(nil);
  fLowStockForm.OnClose:= @FormClose; { eventhandler inherited from basereport }
end;

destructor TLowStockListingReport.Destroy;
begin
  fLowStockForm.Free;
  inherited Destroy;
end;

procedure TLowStockListingReport.ShowReport;
begin
  fLowStockForm.ShowModal;
end;

{ TfrmLowStock }
procedure TfrmLowStock.btnFinishedClick(Sender: TObject);
begin
  Close;
end;

initialization
  ReportFactory.RegisterReport(cLowStockName,TLowStockListingReport);
end.

