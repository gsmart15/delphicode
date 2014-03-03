unit uLoadDataInterface;

interface

uses
  Classes;
  
type

  ILoadXMLData = interface
  ['{42998BFF-C6E7-4345-8C9E-9E4FF1741F7F}']
    function GetXMLText : String;
    procedure LoadDataFromInputXML;
    function LoadDataViaHTTP: String;
    procedure SaveDataToInputXML;
  end;

implementation

end.
