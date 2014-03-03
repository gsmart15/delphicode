unit uDataDisplay;

interface

uses
  Classes, CheckLst, IdGlobal, uProjectData, XMLIntf, XMLDoc, uBehaviorInterfaces,
  uUpdateListObserverInterface;

type

  TSelectedProjectsDisplay = class(TProjectsDataDisplay, IDisplay)
  private
    FProjectItemsList: TStringList; 
    FDoc: IXMLDocument;
    function FindProjectNode(const NodeIdx: Integer): IXMLNode;
  protected
    procedure UpdateCheckListBox(const Values: TStrings); override;
  public
    constructor Create(aProjectData: TComponent); override;
    destructor Destroy; override;
    procedure DisplayData; override;
    procedure InitializeDisplayGrid; override;
    procedure DoOnProjectItemChange(const Value: string);
    property ProjectItemsList: TStringList read FProjectItemsList write FProjectItemsList;  
  end;

implementation

uses
  MainForm, uProjectConstants;

{ TSelectedProjectsDisplay }

constructor TSelectedProjectsDisplay.Create(aProjectData: TComponent);
begin
  inherited;
  FProjectItemsList := TStringList.Create;  
  FDoc              := FSubject.Doc;
end;

destructor TSelectedProjectsDisplay.Destroy;
begin
  FreeAndNil(FProjectItemsList);
  inherited;
end;

procedure TSelectedProjectsDisplay.DisplayData;
var
  I, Count : Integer;
  lstrProjName: String;
  Node: IXmlNode;
begin
  inherited;
  Count := 1;
  for I := 0 to Pred(ProjectItemsList.Count) do
  begin
    with frmTeamCityMonitor.StringGrid , Node do
    begin
      lstrProjName := FProjectItemsList.Strings[I];                   
      Cells[Ord(xfnName), Count] := lstrProjName;
      Node := FindProjectNode(FProjectItemsList.IndexOf(lstrProjName));
      Cells[Ord(xfnLastBuildStatus), Count] := Attributes[LIST_OF_XML_FIELD_NAMES[xfnLastBuildStatus]];
      Cells[Ord(xfnLastBuildLabel) , Count] := Attributes[LIST_OF_XML_FIELD_NAMES[xfnLastBuildLabel]];
      Cells[Ord(xfnactivity)       , Count] := Attributes[LIST_OF_XML_FIELD_NAMES[xfnactivity]];
      Cells[Ord(xfnLastBuildTime)  , Count] := Attributes[LIST_OF_XML_FIELD_NAMES[xfnLastBuildTime]];
      Cells[Ord(xfnwebUrl)         , Count] := Attributes[LIST_OF_XML_FIELD_NAMES[xfnwebUrl]];
    end;  
    Inc(Count);
  end;
end;

procedure TSelectedProjectsDisplay.DoOnProjectItemChange(const  Value: string);
var
  Idx: Integer;
begin
  Idx := FProjectItemsList.IndexOf(Value);
  if (Idx = -1) then
    FProjectItemsList.Add(Value)
  else
    FProjectItemsList.Delete(Idx);
end;

function TSelectedProjectsDisplay.FindProjectNode(const NodeIdx: Integer): IXMLNode;
begin
  Result := FDoc.DocumentElement.ChildNodes.Get(NodeIdx);
end;

procedure TSelectedProjectsDisplay.InitializeDisplayGrid;
var
  Cntr :Integer;
begin
  inherited;
  with frmTeamCityMonitor.StringGrid do
  begin
    RowCount := ProjectItemsList.Count + 1;
    ColCount := MAX_SG_COL_COUNT_INT + 1;
    for Cntr := MIN_SG_COL_COUNT_INT to MAX_SG_COL_COUNT_INT do
    begin
      Cells[Cntr, 0] := LIST_OF_COLUMNS[TXMLFldNames(Cntr)];
      if Cntr = Ord(xfnName) then
        ColWidths[Cntr] := SG_COL_WIDTH_NAME;
      if Cntr = Ord(xfnLastBuildTime) then
        ColWidths[Cntr] := SG_COL_WIDTH_TIME;
    end;  
  end;
end;

procedure TSelectedProjectsDisplay.UpdateCheckListBox(const Values: TStrings);
begin
  FSubject.FCheckLBItems.Clear;
  inherited;
end;

end.
