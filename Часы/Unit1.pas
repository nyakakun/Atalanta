unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
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
  IntToWeek : array[1..7] of string = ( 'бя',
                                        'ом',
                                        'бр',
                                        'яп',
                                        'вр',
                                        'ор',
                                        'яа' );

implementation

{$R *.dfm}

procedure ClearBitmap(Bitmap : TBitmap; ColorClear : TColor);
var TempColorBrush, TempColorPen : TColor;
begin
  TempColorBrush := Bitmap.Canvas.Brush.Color;
  TempColorPen := Bitmap.Canvas.Pen.Color;

  //Bitmap.FreeImage;
  Bitmap.Canvas.Brush.Color := ColorClear;
  Bitmap.Canvas.Pen.Color := ColorClear;
  Form1.Caption := ColorToString(ColorClear);
  Bitmap.Canvas.Rectangle(0, 0, Bitmap.Width, Bitmap.Height);

  Bitmap.Canvas.Brush.Color := TempColorBrush;
  Bitmap.Canvas.Pen.Color := TempColorPen;
end;

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
  Hour, Min, Sec, MSec, Year, Month, Day : Word;
  PosYD, PosYW : Integer;
  PosXD, PosXW : Integer;
  DayWeek, DayFormatter : string;
  ThisDate : TDateTime;
const
  SizeText: Integer = 14;
  PaddingDate: Integer = 10;
  Separator: string = '/';
begin
  ThisDate := Now;
  DecodeTime(ThisDate, Hour, Min, Sec, MSec);
  DecodeDate(ThisDate, Year, Month, Day);
  DayWeek := IntToWeek[DayOfWeek(ThisDate)];
  DayFormatter := Format('%.2d%s%.2d', [Day, Separator, Month]);

  bitmap.Canvas.Font.Size := SizeText;

  PosYD := BorderClock + SizeClock - Round(Bitmap.Canvas.TextWidth(DayFormatter)/2);
  PosYW := BorderClock + SizeClock - Round(Bitmap.Canvas.TextWidth(DayWeek)/2);

  bitmap.Canvas.TextOut(PosYD, BorderClock + SizeClock + PaddingDate, DayFormatter);
  bitmap.Canvas.TextOut(PosYW, BorderClock + SizeClock + PaddingDate * 2 + SizeText, DayWeek);

  //Form1.Label1.Caption := IntToStr(Hour) + #10 + IntToStr(Min) + #10 + IntToStr(Sec) + #10 + IntToStr(MSec);
  DrawLine(bitmap, (Sec * 1000 + MSec)*2*Pi/60000, SizeClock - 15, SizeClock, BorderClock, clBlack);
  DrawLine(bitmap, (Min * 60 + Sec)*2*Pi/3600, Trunc(SizeClock * 0.7), SizeClock, BorderClock, clRed);
  DrawLine(bitmap, (Hour * 60 + Min)*2*Pi/720, Trunc(SizeClock * 0.5), SizeClock, BorderClock, clLime);
end;

procedure DrawDial(Bitmap : TBitmap; SizeClock, BorderClock : Integer);
var Arrow: Integer;
    TempPenColor : TColor;
begin
  Bitmap.Canvas.Ellipse(0 + BorderClock, 0 + BorderClock, SizeClock *2 + BorderClock, SizeClock *2 + BorderClock);
  for Arrow := 1 to 60 do
    DrawLine(Bitmap, Arrow * Pi / 30, SizeClock, SizeClock, BorderClock, clBlack);
  TempPenColor := Bitmap.Canvas.Pen.Color;
  Bitmap.Canvas.Pen.Color := Bitmap.Canvas.Brush.Color;
  Bitmap.Canvas.Ellipse(0 + BorderClock + 10, 0 + BorderClock + 10, SizeClock *2 + BorderClock - 10, SizeClock *2 + BorderClock - 10);
  for Arrow := 1 to 12 do
    DrawLine(Bitmap, Arrow * Pi / 6, SizeClock, SizeClock, BorderClock, clBlack);
  Bitmap.Canvas.Pen.Color := TempPenColor;
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
  Bitmap.TransparentColor := TransparentColorValue;
  Bitmap.Transparent := True;
  Bitmap.Height := ClientHeight;
  Bitmap.Width := ClientWidth;
  Bitmap.Canvas.Brush.Color := clWhite;
  SizeClock := Round(ClientWidth / 2) - BorderClock; 
  ClearBitmap(Bitmap, TransparentColorValue);
  DrawDial(Bitmap, SizeClock, BorderClock);
  DrawArrow(Bitmap, SizeClock, BorderClock);
  Canvas.Draw(0,0,Bitmap);
  //Bitmap.Free;
end;



procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 27 then Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if ClientWidth > ClientHeight then
    ClientHeight := ClientWidth
  else if ClientHeight > ClientWidth then
    ClientWidth := ClientHeight;
end;

end.

