unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i:Int64;

const
  BorderClock : Integer = 10;

implementation

{$R *.dfm}

procedure DrawLine(Bitmap : TBitmap; Angle : Double; Length, SizeClock, BorderClock : Integer; Color: TColor);
var TempColorBrush : TColor;
    xpos, ypos : Integer;
begin
  TempColorBrush := Bitmap.Canvas.Pen.Color;
  Bitmap.Canvas.Pen.Color := Color;
  Bitmap.Canvas.MoveTo(SizeClock + BorderClock, SizeClock + BorderClock);
  xpos := Trunc(Length * Cos(Angle-PI/2)) + SizeClock + BorderClock;
  ypos := Trunc(Length * Sin(Angle-PI/2)) + SizeClock + BorderClock;
  Bitmap.Canvas.LineTo(xpos, ypos);
  Bitmap.Canvas.Pen.Color := TempColorBrush;
end;


procedure DrawArrow(Bitmap: TBitmap; SizeClock, BorderClock : Integer);
var
  Hour, Min, Sec, MSec : Word;
begin
  DecodeTime(Now, Hour, Min, Sec, MSec);
  DrawLine(bitmap, (Sec * 1000 + MSec)*2*Pi/60000, SizeClock - 15, SizeClock, BorderClock, clBlack);
  DrawLine(bitmap, (Min * 60 + Sec)*2*Pi/3600, Trunc(SizeClock * 0.7), SizeClock, BorderClock, clRed);
  DrawLine(bitmap, (Hour * 60 + Min)*2*Pi/720, Trunc(SizeClock * 0.5), SizeClock, BorderClock, clLime);
end;

procedure DrawDial(Bitmap : TBitmap; SizeClock, BorderClock : Integer);
var Arrow: Integer;
begin
  Bitmap.Canvas.Ellipse(0 + BorderClock, 0 + BorderClock, SizeClock *2 + BorderClock, SizeClock *2 + BorderClock);
  for Arrow := 1 to 60 do
    DrawLine(Bitmap, Arrow * Pi / 30, SizeClock, SizeClock, BorderClock, clBlack);
  Bitmap.Canvas.Pen.Color := clWhite;
  Bitmap.Canvas.Ellipse(0 + BorderClock + 10, 0 + BorderClock + 10, SizeClock *2 + BorderClock - 10, SizeClock *2 + BorderClock - 10);
  for Arrow := 1 to 12 do
    DrawLine(Bitmap, Arrow * Pi / 6, SizeClock, SizeClock, BorderClock, clBlack);
  Bitmap.Canvas.Pen.Color := clBlack;
  Bitmap.Canvas.Ellipse(0 + BorderClock + 20, 0 + BorderClock + 20, SizeClock *2 + BorderClock - 20, SizeClock *2 + BorderClock - 20);
end;



procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $f012, 0);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var Bitmap : TBitmap;
    SizeClock : Integer;
begin
  Bitmap := TBitmap.Create;
  Bitmap.Height := ClientHeight;
  Bitmap.Width := ClientWidth;
  SizeClock := Round(ClientWidth / 2) - BorderClock;
  DrawDial(Bitmap, SizeClock, BorderClock);
  DrawArrow(Bitmap, SizeClock, BorderClock);
  Canvas.Draw(0,0,Bitmap);
end;



end.

