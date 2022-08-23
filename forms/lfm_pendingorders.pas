unit lfm_pendingorders;

{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  u_basereport;
const
  cPendingOrdersName = 'Pending orders listing';
type
  { TfrmPendingOrders }
  TfrmPendingOrders = class(TForm)
    btnBye: TButton;
    Panel1: TPanel;
    procedure btnByeClick(Sender: TObject);
  private
  public
  end;
  { TPendingOrdersReport }
  TPendingOrdersReport = class(TBaseReport)
  private
    fPendingOrdersForm: TfrmPendingOrders;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ShowReport; override;
  end;

var
  frmPendingOrders: TfrmPendingOrders;

implementation
uses u_factory; { for registering our report }
{$R *.lfm}

{ TPendingOrdersReport }
constructor TPendingOrdersReport.Create;
begin
  fPendingOrdersForm:= TfrmPendingOrders.Create(nil);
  fPendingOrdersForm.OnClose:= @FormClose; { eventhandler inherited from basereport }
end;

destructor TPendingOrdersReport.Destroy;
begin
  fPendingOrdersForm.Free;
  inherited Destroy;
end;

procedure TPendingOrdersReport.ShowReport;
begin
  fPendingOrdersForm.ShowModal;
end;

{ TfrmPendingOrders }
procedure TfrmPendingOrders.btnByeClick(Sender: TObject);
begin
  Close;
end;

initialization
  ReportFactory.RegisterReport(cPendingOrdersName,TPendingOrdersReport);
end.

