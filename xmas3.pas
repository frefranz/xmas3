program xmas;

{ 16.11.89: Angepasst an TURBO 4, delays wegen 80386 CPU eingebaut    }
{ 17.12.91: Farbe ins Bild gebracht                                   }
{ 19.12.92: Bei Abbruch durch Tastendruck Zeichen aus Puffer entfernt }


uses dos,crt;

var screen:  array[1..79,1..23] of boolean;
    flocken: array[1..2,1..23] of integer;
    dummy: char;

procedure init;
var i,j,k,l: integer;
begin
  clrscr;
  randomize;
  for i:=1 to 79 do begin
    for j:=1 to 23 do begin
      screen[i,j]:=true;
    end;
  end;
  for i:=1 to 23 do begin
      repeat
      begin
        k:=random(78)+1; l:=random(78)+1;
      end
      until (k-l)*(k-l)<>1;
      flocken[1,i]:=k; flocken[2,i]:=l;
  end;
end;{init}

procedure plot(x,y: integer);
begin
  screen[x,y]:=false;
  gotoxy(x,y);
  delay(2);
end;

procedure row(x,y,w:integer);
var i: integer;
begin
  for i:=-w to w do
  begin
    plot(x+i,y); write('X');
  end;
end;{row}

procedure tree;
var x,y,w,i,j: integer;
begin
  textcolor(green);
  x:=50; y:=4; w:=0;
  for i:=1 to 6 do
  begin
    if i=1 then  begin
                   row(x,y,w); y:=y+1; w:=w+1;
                   row(x,y,w); y:=y+1; w:=w+1;
                   row(x,y,w); y:=y+1; w:=w+1;
                  end
           else  begin
                   row(x,y,w); y:=y+1; w:=w+2;
                   plot(x+w,y-1);
                   textcolor(lightred);
                   write('i');
                   textcolor(green);
                   plot(x-w,y-1);
                   textcolor(lightred);
                   write('i');
                   textcolor(green);
                   row(x,y,w); y:=y+1; row(x,y,w); y:=y+1; w:=w+1;
                 end
  end;
  textcolor(brown);
  for i:=0 to 1 do
   begin
     for j:=-1 to 1 do
     begin
       plot(x+j,y+i); write('H');
     end;
   end;

  for i:=1 to 78 do begin plot(i,24); write('-'); end;
  normvideo;
end;{tree}

procedure text;
var i,j,k: integer;
begin
  j:=5; for i:=10 to 24 do screen[i,j]:=false;
  j:=6; for i:=10 to 29 do screen[i,j]:=false;
  textcolor(yellow);
  gotoxy(10,5); write('MERRY CHRISTMAS');
  gotoxy(10,6); write('AND A HAPPY NEW YEAR');
  normvideo;
end;

procedure plots(x,y,i: integer);
var z: integer;
begin
  delay(10);
  z:=y+1; if z>23 then z:=1;
  if screen[flocken[x,z],i]=true
     then begin gotoxy(flocken[x,z],i); write(' '); end;
  if screen[flocken[x,y],i]=true
     then begin gotoxy(flocken[x,y],i); write('*'); end;
  if keypressed then begin clrscr; dummy:=readkey; halt end;
end;

procedure schnee;
var   y,i,j,k: integer;
begin
  textcolor(white);
  y:=0;
  while true do
  begin
    for i:=1 to 23 do
    begin
      for j:=1 to 2 do
      begin
        k:=y+i; if k>23 then k:=k-23;
        plots(j,k,i);
      end;
    end;
    y:=y-1; if y<0 then y:=22;
  end;{while}
  normvideo;
end;{schnee}

begin
  init;
  tree;
  text;
  schnee;
end.
