unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TDArrayOfInteger = array of array of Integer;

  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SetSizeTable(Rows, Collumns : integer);  
    //procedure SetSizeForm(Rows, Collumns : integer);
    procedure FillArr(Rows, Collumns: integer; var ArrNum : TDArrayOfInteger); 
    procedure FillArrNN(NN: integer; var ArrNum : TDArrayOfInteger);
    procedure FillTable(ArrNum : TDArrayOfInteger);     
    procedure Find(ArrNum : TDArrayOfInteger);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SetSizeTable(Rows, Collumns : integer);
const
  MaxColumns: integer = 6;
  MaxRows: integer = 5;
  BorderWidth: integer = 2;
  ScrollWidth: integer = 17;
begin
  if Rows <= MaxRows then
    Stringgrid1.Height := Stringgrid1.DefaultRowHeight * ( Rows + 1 ) + Stringgrid1.GridLineWidth * Rows + BorderWidth * 2
  else                                  
    Stringgrid1.Height := Stringgrid1.DefaultRowHeight * ( MaxRows + 1 ) + Stringgrid1.GridLineWidth * MaxRows + BorderWidth * 2;

  if Collumns <= MaxColumns then
    Stringgrid1.Width := Stringgrid1.DefaultColWidth * ( Collumns + 1 ) + Stringgrid1.GridLineWidth * Collumns + BorderWidth * 2
  else
    Stringgrid1.Width := Stringgrid1.DefaultColWidth * ( MaxColumns + 1 ) + Stringgrid1.GridLineWidth * MaxColumns + BorderWidth * 2;

  if not(Collumns <= MaxColumns) then
    Stringgrid1.Height := Stringgrid1.Height + ScrollWidth; 
  if not(Rows <= MaxRows) then
    Stringgrid1.Width := Stringgrid1.Width + ScrollWidth;

  if Form1.ClientWidth < Stringgrid1.width + Stringgrid1.Left then
    Form1.ClientWidth := Stringgrid1.width + 2 * Stringgrid1.Left;

  stringgrid1.ColCount := Collumns + 1;
  stringgrid1.RowCount := Rows + 1;

  Label3.Top := stringgrid1.Top + stringgrid1.Height + 8
end;

procedure TForm1.FillArr(Rows, Collumns: integer;
  var ArrNum: TDArrayOfInteger);
var
  i, j: integer;
begin
  Randomize;
  setLength(ArrNum, Rows);
  for i := 0 to Rows - 1 do
  begin
    setLength(ArrNum[i], Collumns);
    for j := 0 to Collumns - 1 do
      ArrNum[i, j] := round(sin(random(100)) * 100)
  end
end;   

procedure TForm1.FillArrNN(NN: integer; var ArrNum: TDArrayOfInteger);
var
  i, j: integer;
begin 
  Randomize;
  setLength(ArrNum, NN);
  for i := 0 to NN - 1 do
  begin
    setLength(ArrNum[i], NN);
    for j := 0 to NN - 1 do
      if j >= i then ArrNum[i, j] := i + 1
      else ArrNum[i, j] := 0
  end
end;

procedure TForm1.FillTable(ArrNum: TDArrayOfInteger);
var
  i, j: integer;
begin
  with stringgrid1 do
  begin
    i := 0;
    for j := 1 to RowCount - 1 do
      cells[i, j]:=inttostr(j);
    j := 0;
    for i := 1 to ColCount - 1 do
      cells[i, j]:=inttostr(i);

    for i := 1 to RowCount - 1 do
      for j := 1 to ColCount - 1 do
      begin
        cells[j, i] := inttostr(ArrNum[i - 1, j - 1])
      end
  end
end;   

procedure TForm1.Find(ArrNum: TDArrayOfInteger);
var
  Row, Collumn, MaxNum, MaxNumFirstOrder, Temp, I: integer;
  IsPositive : Boolean;
  Text : string;
  ArrPositivRows: array of integer;
begin
  MaxNum := 0;
  for Row := 0 to Length(ArrNum) - 1 do
  begin
    MaxNumFirstOrder := 0;
    IsPositive := True;
    
    for Collumn := 0 to Length(ArrNum[Row]) - 1 do
    begin
      if IsPositive then
      begin
        Temp := ArrNum[Row][Collumn];
        if Temp >= 0 then
          if MaxNumFirstOrder < Temp then
            MaxNumFirstOrder := Temp
          else
            IsPositive := False
      end
    end;

    if IsPositive then
    begin
      if MaxNumFirstOrder > MaxNum then MaxNum := MaxNumFirstOrder;
      SetLength(ArrPositivRows, Length(ArrPositivRows) + 1);
      ArrPositivRows[Length(ArrPositivRows) - 1] := Row + 1
    end
  end;

  if Length(ArrPositivRows) > 0 then
  begin
    Text := 'Номера строк в которых все числа положительные: ';
    for I := 0 to Length(ArrPositivRows) - 1 do
      if I <> Length(ArrPositivRows) - 1 then
        Text := Text + IntToStr(ArrPositivRows[I]) + ', '
      else
        Text := Text + IntToStr(ArrPositivRows[I]) + #13 + #10 + 'В этих сроках наибольшим числом является число: ' + IntToStr(MaxNum)
  end
  else
    Text := 'Строк где все числа положительные - нет!';

  Label3.Width := Form1.ClientWidth - 2 * Label3.Left;
  Label3.Caption := Text;   
  Form1.ClientHeight := Label3.Height + Label3.Top + Label3.Left
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  UCollumns, URows: integer;
  ArrRandNum: TDArrayOfInteger;
begin
  if not(CheckBox1.checked) then
  begin
    URows := strtoint(Edit1.Text);
    UCollumns := strtoint(Edit2.Text);
    FillArr(URows, UCollumns, ArrRandNum)
  end
  else
  begin
    URows := strtoint(Edit1.Text);
    UCollumns := URows;
    FillArrNN(URows, ArrRandNum)
  end;
  SetSizeTable(URows, UCollumns);
  FillTable(ArrRandNum);
  if not(CheckBox1.checked) then
    Find(ArrRandNum)
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Edit2.Enabled := not (Sender as TCheckBox).Checked;
  if Edit2.Enabled then
  begin
    Edit2.Text := 'Введите количество столбцов массива';
    Edit1.Text := 'Введите количество строк массива';
    Label3.Top := Label3.Top + 7;
    Label3.AutoSize := True
  end
  else
  begin
    Edit2.Text := ''; 
    Edit1.Text := 'Введите количество строк и столбцов массива';  
    Label3.Top := Label3.Top - 7;
    Label3.AutoSize := false;
    Label3.Height := 0;
    Form1.ClientHeight := Stringgrid1.Height + Stringgrid1.Top + 7
  end
end;

end.

procedure kryakrya(MASSIV : array of integer);
