object frmTeamCityMonitor: TfrmTeamCityMonitor
  Left = 134
  Top = 182
  Width = 1143
  Height = 412
  Caption = 'TeamCity Monitor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 185
    Top = 41
    Width = 2
    Height = 333
    Cursor = crHSplit
    OnMoved = SplitterMoved
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1127
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1127
      41)
    object lblurl: TLabel
      Left = 16
      Top = 13
      Width = 82
      Height = 13
      Caption = 'Teamcity Server:'
    end
    object lblPort: TLabel
      Left = 905
      Top = 13
      Width = 24
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Port:'
    end
    object edUrl: TEdit
      Left = 104
      Top = 11
      Width = 778
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'cltd-spf-teamcity.cochlear.com'
    end
    object btnScan: TButton
      Left = 1033
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Scan'
      TabOrder = 1
      OnClick = btnScanClick
    end
    object sePort: TSpinEdit
      Left = 945
      Top = 10
      Width = 73
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 8111
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 41
    Width = 185
    Height = 333
    Align = alLeft
    Constraints.MinWidth = 185
    TabOrder = 1
    object chklbScan: TCheckListBox
      Left = 1
      Top = 1
      Width = 183
      Height = 292
      OnClickCheck = chklbScanClickCheck
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
    object pnlMonitorBtn: TPanel
      Left = 1
      Top = 293
      Width = 183
      Height = 39
      Align = alBottom
      Caption = 'pnlMonitorBtn'
      TabOrder = 1
      object btnMonitor: TButton
        Left = -1
        Top = -2
        Width = 185
        Height = 41
        Caption = 'Monitor'
        TabOrder = 0
        OnClick = btnMonitorClick
      end
    end
  end
  object StringGrid: TStringGrid
    Left = 187
    Top = 41
    Width = 940
    Height = 333
    Align = alClient
    ColCount = 6
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving]
    TabOrder = 2
  end
  object Timer: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerTimer
    Left = 8
    Top = 48
  end
end
