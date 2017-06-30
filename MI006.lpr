program MI006;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Windows, sysutils, crt;


var
  i:integer;
  Bufor: array of char;
  TestString:string;

function LoadFile(fn:string):boolean;
 var
  plik:TFileStream;
begin
  Plik:=TFileStream.Create(fn, fmOpenRead);
  SetLength(Bufor,plik.Size);
  if plik.Size>0 then Plik.Read(Bufor[0],length(bufor));
  Plik.Free;
end;

{$ifdef WINDOWS}
procedure WriteLnCon(s:string);
var
  bw:dword;
begin
  WriteConsole(GetStdHandle(STD_OUTPUT_HANDLE),@s[1],length(s),bw,nil);
end;
{$else}
procedure WriteLnUTF8(s:string);
begin
  writeln(s);
end;
{$endif}

Procedure MainScreen;
begin
 clrscr;
 writeln('MI6 - Mission Imposible' );
 for i:=0 to 25 do write('='); writeln;

end;


//===-=-===-===-=-=-// MAIN // =--=-=-----=----=
begin
  // Ustawiam standardową stronę kodową
  SetConsoleOutputCP(DefaultSystemCodePage);
  SetTextCodepage(Output, DefaultSystemCodePage);
  // Ekran główny
  Mainscreen;
  // Ustawiam stronę kodową na IBM EBCDIC Multilingual/ROECE (Latin 2);
  // IBM EBCDIC Multilingual Latin 2
  SetConsoleOutputCP(870);
  SetTextCodepage(Output, 870);
  //Wczytuje plik z danymi z misji do bufora
  LoadFile('.\Misja06.dat');

  SetString(TestString,@bufor[0],length(bufor));

  // wyswietlam rozwiazanie zadania za pomoca funkcji "WriteConsole",
  // bo standardowa nie działa po zmianie kodowania
  WriteLnCon(TestString);
  writeln;

  readkey;

  SetConsoleOutputCP(DefaultSystemCodePage);
  SetTextCodepage(Output, DefaultSystemCodePage);
end.

