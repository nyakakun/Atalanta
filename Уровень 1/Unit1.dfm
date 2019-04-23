object Form1: TForm1
  Left = 527
  Top = 284
  BorderStyle = bsToolWindow
  ClientHeight = 213
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    474
    213)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 375
    Top = 30
    Width = 95
    Height = 26
    Alignment = taCenter
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1084#1072#1089#1089#1080#1074#13#10#1087#1086' '#1089#1087#1077#1094'. '#1087#1088#1072#1074#1080#1083#1091
  end
  object Label3: TLabel
    Left = 7
    Top = 193
    Width = 3
    Height = 13
    WordWrap = True
  end
  object StringGrid1: TStringGrid
    Left = 7
    Top = 67
    Width = 306
    Height = 120
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 7
    Top = 15
    Width = 287
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082' '#1084#1072#1089#1089#1080#1074#1072
  end
  object Edit2: TEdit
    Left = 7
    Top = 37
    Width = 287
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1086#1083#1073#1094#1086#1074' '#1084#1072#1089#1089#1080#1074#1072
  end
  object Button1: TButton
    Left = 300
    Top = 15
    Width = 68
    Height = 45
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 414
    Top = 15
    Width = 16
    Height = 18
    Anchors = [akTop, akRight]
    TabOrder = 4
    OnClick = CheckBox1Click
  end
end
