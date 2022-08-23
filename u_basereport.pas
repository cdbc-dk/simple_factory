unit u_basereport;
{$mode objfpc}{$H+}
{.$define debug}
interface
uses
  Classes, SysUtils, Forms{, Dialogs};

const
  cBaseName = 'Base report';

type
  TBaseForm = class(TForm);
  { TBaseReport ~ inherit from this }
  TBaseReport = class(TObject)
  protected
    fForm: TBaseForm;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure ShowReport; virtual;
  end;
  { our base report creating classtype }
  TReportClass = class of TBaseReport;

implementation
uses u_factory; { for registering our report }

{ TBaseReport }
constructor TBaseReport.Create;
begin
  inherited Create;
  fForm:= TBaseForm.CreateNew(nil);
  fForm.Top:= 200;
  fForm.Left:= 200;
  fForm.Caption:= cBaseName;
  fForm.OnClose:= @FormClose;
end;

procedure TBaseReport.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
end;

destructor TBaseReport.Destroy;
begin
  fForm.Free;
  inherited Destroy;
end;

procedure TBaseReport.ShowReport;
begin
  fForm.ShowModal;
end;

initialization
  u_factory.ReportFactory.RegisterReport(cBaseName,TBaseReport);

finalization 
//  FreeAndNil(__Example);
  
end.

