dansk(N) --> en2ni(N).
dansk(N) --> ti2nitten(N).
dansk(N) --> en2ni(X), [og], tyve2halvfems(Y), {N is X+Y}.
dansk(N) --> tyve2halvfems(N).

en2ni(N) --> [en], {N is 1}.
en2ni(N) --> [to], {N is 2}.
en2ni(N) --> [tre], {N is 3}.
en2ni(N) --> [fire], {N is 4}.
en2ni(N) --> [fem], {N is 5}.
en2ni(N) --> [seks], {N is 6}.
en2ni(N) --> [syv], {N is 7}.
en2ni(N) --> [otte], {N is 8}.
en2ni(N) --> [ni], {N is 9}.

ti2nitten(N) -->  [ti], {N is 10}.
ti2nitten(N) -->  [ellve], {N is 11}.
ti2nitten(N) -->  [tolv], {N is 12}.
ti2nitten(N) -->  [tretten], {N is 13}.
ti2nitten(N) -->  [fjorten], {N is 14}.
ti2nitten(N) -->  [femten], {N is 15}.
ti2nitten(N) -->  [seksten], {N is 16}.
ti2nitten(N) -->  [sytten], {N is 17}.
ti2nitten(N) -->  [atten], {N is 18}.
ti2nitten(N) -->  [nitten], {N is 19}.
ti2nitten(N) -->  [hundrede], {N is 100}.

tyve2halvfems(N) --> [tyve], {N is 20}.
tyve2halvfems(N) --> [tredive], {N is 30}.
tyve2halvfems(N) --> [fyrre], {N is 40}.
tyve2halvfems(N) --> [fyrretyve], {N is 40}.
tyve2halvfems(N) --> halv(A), mult(B), emfas, {N is A+B}.

halv(N) --> [halv], {N is -10}.
halv(N) --> [], {N is 0}.

mult(N) --> [tres], {N is 60}.
mult(N) --> [firs], {N is 80}.
mult(N) --> [fjerds], {N is 80}.
mult(N) --> [fems], {N is 100}.

emfas --> [sindstyve].
emfas --> [].

test([]).
test([X|Xs], N) :-
	dansk(N, X, []),
	write(X '=' N), nl,
	M is N+1,
	test(Xs, M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


numbers([

[en],
[to],
[tre],
[fire],
[fem],
[seks],
[syv],
[otte],
[ni],
[ti],
[ellve],
[tolv],
[tretten],
[fjorten],
[femten],
[seksten],
[sytten],
[atten],
[nitten],
[tyve],
[en,og,tyve],
[to,og,tyve],
[tre,og,tyve],
[fire,og,tyve],
[fem,og,tyve],
[seks,og,tyve],
[syv,og,tyve],
[otte,og,tyve],
[ni,og,tyve],
[tredive],
[en,og,tredive],
[to,og,tredive],
[tre,og,tredive],
[fire,og,tredive],
[fem,og,tredive],
[seks,og,tredive],
[syv,og,tredive],
[otte,og,tredive],
[ni,og,tredive],
[fyrre],
[en,og,fyrre],
[to,og,fyrre],
[tre,og,fyrre],
[fire,og,fyrre],
[fem,og,fyrre],
[seks,og,fyrre],
[syv,og,fyrre],
[otte,og,fyrre],
[ni,og,fyrre],
[halv,tres],
[en,og,halv,tres],
[to,og,halv,tres],
[tre,og,halv,tres],
[fire,og,halv,tres],
[fem,og,halv,tres],
[seks,og,halv,tres],
[syv,og,halv,tres],
[otte,og,halv,tres],
[ni,og,halv,tres],
[tres],
[en,og,tres],
[to,og,tres],
[tre,og,tres],
[fire,og,tres],
[fem,og,tres],
[seks,og,tres],
[syv,og,tres],
[otte,og,tres],
[ni,og,tres],
[halv,fjerds],
[en,og,halv,fjerds],
[to,og,halv,fjerds],
[tre,og,halv,fjerds],
[fire,og,halv,fjerds],
[fem,og,halv,fjerds],
[seks,og,halv,fjerds],
[syv,og,halv,fjerds],
[otte,og,halv,fjerds],
[ni,og,halv,fjerds],
[firs],
[en,og,firs],
[to,og,firs],
[tre,og,firs],
[fire,og,firs],
[fem,og,firs],
[seks,og,firs],
[syv,og,firs],
[otte,og,firs],
[ni,og,firs],
[halv,fems],
[en,og,halv,fems],
[to,og,halv,fems],
[tre,og,halv,fems],
[fire,og,halv,fems],
[fem,og,halv,fems],
[seks,og,halv,fems],
[syv,og,halv,fems],
[otte,og,halv,fems],
[ni,og,halv,fems],
[hundrede]

]).
