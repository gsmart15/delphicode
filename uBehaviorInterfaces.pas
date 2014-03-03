unit uBehaviorInterfaces;

interface

uses
  Classes, uUpdateListObserverInterface, uProjectData, IdGlobal;

type

  TBaseProjectsDataDisplay = class(TComponent, IUpdateListObserver)
  
  protected
    FSubject: TProjectData;
    procedure UpdateCheckListBox(const Values: TStrings); virtual; abstract;
  public  
    procedure DisplayData; virtual; abstract;
    procedure InitializeDisplayGrid; virtual; abstract;
  end;

  
  TProjectsDataDisplay = class(TBaseProjectsDataDisplay)
  protected
    procedure UpdateCheckListBox(const Values: TStrings); override;
  public
    constructor Create(aProjectData: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  MainForm, uProjectConstants;

{ TProjectsDataDisplay }

constructor TProjectsDataDisplay.Create(aProjectData: TComponent);
begin
  inherited Create(frmTeamCityMonitor);
  FSubject := TProjectData(aProjectData);
  FSubject.RegisterObserver(Self);
end;

destructor TProjectsDataDisplay.Destroy;
begin
  if Assigned(FSubject) then
    FreeAndNil(FSubject);
  inherited;
end;

procedure TProjectsDataDisplay.UpdateCheckListBox(const Values: TStrings);
begin
  inherited;
  FSubject.FCheckLBItems.AddStrings(Values);
end;

end.
 
