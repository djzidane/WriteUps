program MI006;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Windows, sysutils, crt;

const datafile='.\Misja06.dat';

var
  i:integer;
  Bufor: array of char;
  TestString:string;

// Funkcja wczytuje plik z danymi do bufora
function LoadFile(fn:string):boolean;
   var
    plik:TFileStream;
 begin
    if not fileexists(fn) then
    begin
      WriteLn('ERROR: Nie znalazlem plku z danymi ',datafile);
      exit
    end
     else
      begin
       Plik:=TFileStream.Create(fn, fmOpenRead);
       SetLength(Bufor,plik.Size);
       if plik.Size>0 then Plik.Read(Bufor[0],length(bufor));
       Plik.Free;
      end;
end;

// Procedura która zastepuje standardowe w FP write(), bo standardowa nie działa
{$ifdef WINDOWS}
procedure WriteLnCon(s:string);
var
  bw:dword;
begin
  WriteConsole(GetStdHandle(STD_OUTPUT_HANDLE),@s[1],length(s),bw,nil);
end;
{$else}
procedure WriteLnCon(s:string);
begin
  writeln(s);
end;
{$endif}

Procedure MainScreen;
begin
 clrscr;

 writeln(' _  _  __  ___  |');
 writeln('( \/ )(  )/ __) | Gynvael Coldvind Livestream - Misja 06 ');
 writeln('/ \/ \ )((  _ \ | MI6 - Mission Imposible solved');
 writeln('\_)(_/(__)\___/ |');

 for i:=0 to 58 do write('='); writeln;

end;


//===-=-===-===-=-=-// MAIN // =--=-=-----=----=
begin

  // Ustawiam standardową stronę kodową
  SetConsoleOutputCP(DefaultSystemCodePage);
  SetTextCodepage(Output, DefaultSystemCodePage);

  // Ekran główny [Tak by bylo troche ładniej]
  Mainscreen;

  // Ustawiam stronę kodową na IBM EBCDIC Multilingual/ROECE (Latin 2);
  // IBM EBCDIC Multilingual Latin 2
  SetConsoleOutputCP(870);
  SetTextCodepage(Output, 870);

  //Wczytuje plik z danymi z misji do bufora
  LoadFile(datafile);

  //zcastowanie Bufora na string
  SetString(TestString,@bufor[0],length(bufor));

  // wyswietlam rozwiazanie zadania za pomoca funkcji "WriteConsole",
  // bo standardowa nie działa po zmianie kodowania
  Writeln;
  textcolor(15);

  //wypisanie flagi po zmianie strony kodowej
  if TestString<>''
   then
    begin
     Writeln('FLAGA TO:');
     WriteLnCon(TestString);
     writeln;
    end;

  // czekanie na wcisniecie dowolnego klawisza oraz
  // owrót do ustawień standardowych strony kodowej i wyjscie z aplikacji.
  readkey;
  textcolor(7);

  SetConsoleOutputCP(DefaultSystemCodePage);
  SetTextCodepage(Output, DefaultSystemCodePage);
end.

