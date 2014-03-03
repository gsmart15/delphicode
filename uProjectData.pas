unit uProjectData;

interface

uses
  uUpdateListObserverInterface, Classes, uLoadDataInterface, xmldom, XMLIntf, 
  msxmldom, XMLDoc, IdGlobal, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, SysUtils;

type
  TProjectData = class(TComponent, ISubject, ILoadXMLData)
  private
    FDoc: IXMLDocument;
    FIdHTTP: TIdHTTP;
    FObserverList: TList;
    FProjectList: TStringList;
    FHTTPURL: String;
    procedure SaveDataToInputXML;
  protected
    function GetXMLText : String; 
  public
    FCheckLBItems: TStrings;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;
    procedure SetProjectInformation;
    procedure RegisterObserver(aObserver: IUpdateListObserver);
    procedure RemoveObserver(aObserver: IUpdateListObserver);
    procedure NotifyObservers;
    procedure LoadDataFromInputXML; virtual;
    function LoadDataViaHTTP: String; virtual;
    procedure DoAfterXMLDataScan;
    property ProjectList : TStringList read FProjectList write FProjectList;
    property Doc: IXMLDocument read FDoc;
    property HTTPURL : String read FHTTPURL write FHTTPURL;
  end;

implementation

uses
  uProjectConstants, uBehaviorInterfaces;

{ TProjectData }

constructor TProjectData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FObserverList := TList.Create;
  FProjectList := TStringList.Create;
  FDoc         := LoadXMLDocument(rsXMLPath);
  FIdHTTP      := TIdHTTP.Create(AOwner);
end;

destructor TProjectData.Destroy;
begin
  FreeAndNil(FProjectList);
  FreeAndNil(FObserverList);
  FreeAndNil(FIdHTTP);
  inherited;
end;

function TProjectData.GetXMLText : String;
begin
  Result := FDoc.XML.Text;
end;

procedure TProjectData.LoadDataFromInputXML;
begin
  FDoc.LoadFromXML(GetXMLText);
end;

procedure TProjectData.NotifyObservers;
var
  Observer: IUpdateListObserver;
  i : Integer;
begin
  for i := 0 to (FObserverList.Count - 1) do
  begin
    Observer := IUpdateListObserver(FObserverList.Items[i]); 
    if Assigned(Observer) then
      Observer.UpdateCheckListBox(FProjectList);
  end;    
end;

procedure TProjectData.RegisterObserver(aObserver: IUpdateListObserver);
begin
  FObserverList.Add(Pointer(aObserver));
end;

procedure TProjectData.RemoveObserver(aObserver: IUpdateListObserver);
begin
  FObserverList.Remove(Pointer(aObserver));
end;

procedure TProjectData.SetProjectInformation;
var
  Node: IXMlNode;
begin
  Node := FDoc.DocumentElement.ChildNodes.First;
  while Assigned(node) do
  begin
    FProjectList.Add(Node.Attributes[LIST_OF_XML_FIELD_NAMES[xfnName]]);
    Node := Node.NextSibling;
  end;
  DoAfterXMLDataScan;
end;

procedure TProjectData.DoAfterXMLDataScan;
begin
  NotifyObservers;
end;

function TProjectData.LoadDataViaHTTP: String;
begin
  Result := FIdHTTP.Get(FHTTPURL);
  if Result <> EmptyStr then
  begin
    FDoc.XML.Text := Result;
    SaveDataToInputXML;  
  end;  
end;

procedure TProjectData.SaveDataToInputXML;
begin
  if not FDoc.Active then
    FDoc.Active := True;
  FDoc.SaveToFile(rsXMLPath);
end;

end.
 
