link(p0, p1, 5).
link(p1, p2, 2).
link(p1, p3, 4).
link(p2, p1, 2).
link(p2, p3, 6).

minpath(X, Y, Limit) :-
	findapath(X, Y, Weight, Path, []),
	Weight < Limit,
	!,
	fail.

findapath(X, Y, W, [X,Y], _, _) :- link(X, Y, W).
findapath(X, Y, W, [X|P], V, Limit) :- \+ member(X, V),
                                 link(X, Z, W1),
                                 findapath(Z, Y, W2, P, [X|V], Limit), 
                                 W is W1 + W2,
                                 Limit < W,
                                 !,
                                 fail.