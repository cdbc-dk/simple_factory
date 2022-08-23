unit lfm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  u_basereport,
  u_factory;

type
  { TfrmMain }
  TfrmMain = class(TForm)
    btnGenerate: TButton;
    btnClose: TButton;
    cbxNames: TComboBox;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbxNamesChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  ReportFactory.GetRegisteredReports(cbxNames.Items);
  cbxNames.Caption:= 'Reports:';
  Timer1.Enabled:= false;
end;

procedure TfrmMain.btnGenerateClick(Sender: TObject);
begin
  if cbxNames.ItemIndex = -1 then exit;
  with ReportFactory.CreateReport(cbxNames.Items[cbxNames.ItemIndex]) do begin
    ShowReport;
    Free;
  end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.cbxNamesChange(Sender: TObject);
begin
  Caption:= cbxNames.Items[cbxNames.ItemIndex];
end;

end.

