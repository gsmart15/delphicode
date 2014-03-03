unit MainForm;

interface

{$DEFINE DEMO_MODE}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, CheckLst, Spin, ExtCtrls, Grids,
  uBehaviorInterfaces, uProjectData, uDataDisplay;

type
  TfrmTeamCityMonitor = class(TForm)
    pnlTop: TPanel;
    edUrl: TEdit;
    btnScan: TButton;
    lblurl: TLabel;
    sePort: TSpinEdit;
    lblPort: TLabel;
    pnlLeft: TPanel;
    chklbScan: TCheckListBox;
    StringGrid: TStringGrid;
    Timer: TTimer;
    pnlMonitorBtn: TPanel;
    btnMonitor: TButton;
    Splitter: TSplitter;
    procedure btnScanClick(Sender: TObject);
    procedure btnMonitorClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chklbScanClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SplitterMoved(Sender: TObject);
  private
    FProjectData: TProjectData;
    FProjectDataDisplay : TSelectedProjectsDisplay;
    procedure CleanUpAssignedObjects;
  public
    { Public declarations }
  end;

var
  frmTeamCityMonitor : TfrmTeamCityMonitor;
  
implementation

uses
  uProjectConstants;

{$R *.dfm}

procedure TfrmTeamCityMonitor.btnScanClick(Sender: TObject);
begin
  CleanUpAssignedObjects;
  FProjectData := TProjectData.Create(nil);
  FProjectDataDisplay  := TSelectedProjectsDisplay.Create(FProjectData);
  with FProjectData do
  begin
    FCheckLBItems := chklbScan.Items;
    {$IFDEF DEMO_MODE}
    LoadDataFromInputXML;
    {$ELSE}
    HTTPURL := Format(rsProjects, [edUrl.Text, sePort.Value]);
    LoadDataViaHTTP;
    {$ENDIF}
    SetProjectInformation;
  end;  
end;

procedure TfrmTeamCityMonitor.btnMonitorClick(Sender: TObject);
begin
  TimerTimer(Sender);
  Timer.Enabled := True;
end;

procedure TfrmTeamCityMonitor.TimerTimer(Sender: TObject);
begin
  with FProjectDataDisplay do
  begin
    InitializeDisplayGrid;
    DisplayData;
  end;
end;

procedure TfrmTeamCityMonitor.FormCreate(Sender: TObject);
begin
  inherited;
  Timer.Interval := TIMER_INTERVAL;
  pnlLeft.Constraints.MaxWidth := ClientWidth div 2;
end;

procedure TfrmTeamCityMonitor.chklbScanClickCheck(Sender: TObject);
begin
  FProjectDataDisplay.DoOnProjectItemChange(chklbScan.Items.Strings[chklbScan.ItemIndex]);
end;

procedure TfrmTeamCityMonitor.FormDestroy(Sender: TObject);
begin
  if Assigned(FProjectDataDisplay) then
    FreeAndNil(FProjectDataDisplay);
  inherited;
end;

procedure TfrmTeamCityMonitor.SplitterMoved(Sender: TObject);
begin
  btnMonitor.Width := Splitter.Left-1;
end;

procedure TfrmTeamCityMonitor.CleanUpAssignedObjects;
begin
  if Assigned(FProjectDataDisplay) then
    FreeAndNil(FProjectDataDisplay);   
  if Assigned(FProjectData) then  
    FProjectData := nil;
end;

end.
