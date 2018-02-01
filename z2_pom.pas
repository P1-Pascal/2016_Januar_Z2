program z2_pom;

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
  end;

  dat = file of clan;

var
  n, i: integer;
  id: integer;
  s: string;
  izlaz: dat;
  person: clan;

begin

  assign(izlaz, 'pozajmice.dat');
  rewrite(izlaz);

  write('Unesite broj clanova: ');
  readln(n);

  for i:=1 to n do
  begin
    readln(id);
    person.id:=id;
    readln(s);
    person.ime:=s;
    readln(s);
    person.knjiga:=s;

    write(izlaz, person);
  end;

  close(izlaz);

end.

