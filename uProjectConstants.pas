unit uProjectConstants;

interface

type
  TXMLFldNames   = (xfnLastBuildStatus,
                    xfnLastBuildLabel,
                    xfnactivity,
                    xfnName,
                    xfnLastBuildTime,
                    xfnwebUrl);     

const

  LIST_OF_COLUMNS         : Array[TXMLFldNames] of String =
    (
      'Status',
      'Label',
      'Activity',
      'Name',
      'Time',
      'URL'
    );

  LIST_OF_XML_FIELD_NAMES : Array[TXMLFldNames] of String =
    (
      'lastBuildStatus',
      'lastBuildLabel',
      'activity',
      'name',
      'lastBuildTime',
      'webUrl'
    );

  MIN_SG_COL_COUNT     = Low(TXMLFldNames);
  MAX_SG_COL_COUNT     = High(TXMLFldNames);

  MIN_SG_COL_COUNT_INT = Integer(MIN_SG_COL_COUNT);
  MAX_SG_COL_COUNT_INT = Integer(MAX_SG_COL_COUNT);
  
  SG_COL_WIDTH_NAME    = 450;
  SG_COL_WIDTH_TIME    = 180;
  TIMER_INTERVAL       = 60000;
  
resourcestring
  rsProjects = 'http://%s:%d/app/rest/cctray/projects.xml';
  rsXMLPath  = '../testdata/test.xml';
  
    
implementation

end.
