object Form1: TForm1
  Left = 635
  Top = 225
  BorderStyle = bsNone
  ClientHeight = 420
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 104
    Top = 96
  end
end
