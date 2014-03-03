unit uUpdateListObserverInterface;

interface

uses
  Classes;

type

  IUpdateListObserver = interface
  ['{56056643-4EF8-42CF-8300-BE775C9DE515}']
    procedure UpdateCheckListBox(const Values: TStrings);
  end;

  IDisplay = interface
  ['{B4BA606A-3A00-418A-BF08-D8E4CBCEDA4B}']
    procedure InitializeDisplayGrid;
    procedure DisplayData;
  end;

  ISubject = interface
  ['{2DCD8EFF-BA86-48DD-B852-B1ADF3C7CAE8}']
    procedure RegisterObserver(aObserver: IUpdateListObserver);
    procedure RemoveObserver(aObserver: IUpdateListObserver);
    procedure NotifyObservers;
  end;
  
implementation

end.
