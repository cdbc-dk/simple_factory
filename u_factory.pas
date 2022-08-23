
{*******************************************************************************
*        Unit name : u_factory.pas                                             *
*        Copyright : (C)cdbc.dk 2022                                           *
*        Programmer: Benny Christensen                                         *
*        Created   : 2022.08.22 /bc my first stab at creating a simple factory *
*        Updated   : 2022.08.23 /bc hmm... factory is working, but forms not?  *
*                                   i'm wondering what the hell is wrong?!?    *
*                    2022.08.23 /bc got it, forgot to make tbasereport.create  *
*                                   virtual and override it in descendants.    *
*                                                                              *
*                                                                              *
*                                                                              *
*                                                                              *
*                                                                              *
*                                                                              *
********************************************************************************
*        Purpose:                                                              *
*        A learning project, to study how the factory pattern work in real     *
*        life situations. Maybe find uses for it in my own projects.           *
*                                                                              *
*                                                                              *
*                                                                              *
*                                                                              *
*        TODO:                                                                 *
********************************************************************************
*        License:                                                              *
*        "Beer License" - If you meet me one day, you'll buy me a beer :-)     *
*        I'm NOT liable for anything! Use at your own risk!!!                  *
*******************************************************************************}

unit u_factory;
{$mode objfpc}{$H+}
{.$define debug}
interface
uses
  Classes, SysUtils, u_basereport;

type
  { TReportFactory ~ our report factory }
  TReportFactory = class(TObject)
  private
    fMappings: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterReport(const aName: string;const aReportClass: TReportClass);
    function CreateReport(const aName: string): TBaseReport;
    procedure GetRegisteredReports(aList: TStrings);
  end;
  
function ReportFactory: TReportFactory; { global singleton }

implementation

type
  { TReportMapping ~ maps the correlation between name & class }
  TReportMapping = class(TObject)
  private
    fName: string;
    fReportClass: TReportClass;
  public
    constructor CreateEx(const aName: string;const aReportClass: TReportClass);
    property Name: string read fName;
    property ReportClass: TReportClass read fReportClass;
  end;

var
  Singleton: TReportFactory;

function ReportFactory: TReportFactory; { singleton }
begin
  if not assigned(Singleton) then Singleton:= TReportFactory.Create;
  Result:= Singleton;
end; { gets released on progam end }

{ TReportFactory }
constructor TReportFactory.Create;
begin
  inherited;
  fMappings:= TStringList.Create;
end;

destructor TReportFactory.Destroy;
begin
  FreeAndNil(fMappings);
  inherited Destroy;
end;

procedure TReportFactory.RegisterReport(const aName: string;const aReportClass: TReportClass);
var
  I: integer;
  lMapping: TReportMapping;
begin
  I:= fMappings.IndexOf(UpperCase(aName));
  if I <> -1 then raise Exception.Create('Registering a duplicate report name <' + aName + '>')
  else begin
    lMapping:= TReportMapping.CreateEx(aName,aReportClass);
    fMappings.AddObject(UpperCase(aName),lMapping);
  end;
end;

function TReportFactory.CreateReport(const aName: string): TBaseReport;
var
  Idx: integer;
  lRptClass: TReportClass;
begin
  Idx:= fmappings.IndexOf(UpperCase(aName));
  if Idx = -1 then raise Exception.Create('No report was registered by the name <' + aName + '>')
  else begin
    lRptClass:= TReportMapping(fMappings.Objects[Idx]).ReportClass;
    Result:= lRptClass.Create;
  end;
end;

procedure TReportFactory.GetRegisteredReports(aList: TStrings);
var
  I: integer;
begin
  aList.Clear;
  for I:= 0 to fMappings.Count - 1 do alist.Add(TReportMapping(fMappings.Objects[I]).Name);
end;

{ TReportMapping }
constructor TReportMapping.CreateEx(const aName: string;const aReportClass: TReportClass);
begin
  Create; // don't call inherited Create!
  fName:= aName;
  fReportClass:= aReportClass;
end;

initialization
  Singleton:= nil; // testing
//  Singleton:= TReportFactory.Create; // testing

finalization 
  FreeAndNil(Singleton);
  
end.

