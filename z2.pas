program z2(input, output, ulaz);

type
  clan = record
    id: integer;
    ime: string[30];
    knjiga: string[40];
  end;

  pok = ^elem;
  elem = record
    osoba: record
      c: clan;
      brKnjiga: integer;
    end;
    next: pok;
  end;

  dat = file of clan;

var
  ulaz: dat;
  lista: pok;

function nadji(lista: pok; n: integer): boolean;
var
  b: boolean;
begin
  b:=false;
  while(lista<>nil) do
  begin
    if (lista^.osoba.c.id=n) then
    begin
      inc(lista^.osoba.brKnjiga);
      b:=true;
    end;
    lista:=lista^.next;
  end;
  nadji:=b;
end;

procedure ucitajListu(var lista: pok; var ulaz: dat);
var
  novi, posl: pok;
begin
  lista:=nil;
  posl:=nil;
  while not eof(ulaz) do
  begin
    new(novi);
    read(ulaz, novi^.osoba.c);
    if not nadji(lista, novi^.osoba.c.id) then
      begin
        novi^.osoba.brKnjiga:=1;
        novi^.next:=nil;

        if (lista=nil) then
          lista:=novi
        else
          posl^.next:=novi;

        posl:=novi;
      end;
  end;

end;

procedure ispisiListu(lista: pok);
begin
  while (lista<>nil) do
  begin
    writeln('Clan:');
    writeln('  ID: ', lista^.osoba.c.id);
    writeln('  Ime: ', lista^.osoba.c.ime);
    writeln('  Broj pozajmica: ', lista^.osoba.brKnjiga);

    lista:=lista^.next;
  end;
end;

procedure ispisiMax(var lista: pok);
var
  tek: pok;
  max: integer;
begin
  tek:=lista;
  max:=lista^.osoba.brKnjiga;
  while tek<>nil do
  begin
    if (tek^.osoba.brKnjiga>max) then
      max:=tek^.osoba.brKnjiga;
    tek:=tek^.next;
  end;

  tek:=lista;
  while tek<>nil do
  begin
    if (tek^.osoba.brKnjiga=max) then
      writeln(tek^.osoba.c.id, ' ', tek^.osoba.c.ime);
    tek:=tek^.next;
  end;
end;

procedure brisiLstu(var lista: pok);
var
  stari: pok;
begin
  stari:=lista;
  while stari<>nil do
  begin
    lista:=lista^.next;
    dispose(stari);
    stari:=lista;
  end;
end;

begin

  assign(ulaz, 'pozajmice.dat');
  reset(ulaz);

  ucitajListu(lista, ulaz);

  ispisiMax(lista);

  brisiLstu(lista);

  close(ulaz);

  readln();
end.

