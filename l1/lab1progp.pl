history(
b(
  l(yeast),
  b(
    b(
      l(fly),
      l(mosquito)
     ),
    b(
      l(frog),
      b(
        l(chicken),
        b(
          l(mouse),
          b(
            l(human),
            l(chimp)
           )
         )
       )
     )
   )
 )).

tree1(l(enkelt)).
tree2(b(l(1),l(2))).
tree3(b(l(1),b(l(2),l(3)))).
tree4(b(b(l(1),l(2)), b(l(3), l(4)))).
tree5(b(l(1), b(l(2), b(l(3),b(l(4),l(5)))))).
tree6(b(b(l(1), b(l(2), b(l(3),b(l(4), l(5))))),
        b(l(6), b(l(7), b(l(8),b(l(9), l(10))))))).


writetree(T) :- writetree(T, 0).
writetree(l(X), N) :-
        indent(N),
        write(X).
writetree(b(X,Y), N) :-
        indent(N),
        write('('), nl,
        Next is N + 2,
        writetree(X, Next),
        write(', '), nl,
        writetree(Y, Next), nl,
        indent(N),
        write(')').

count_leaves(l(_), 1).
count_leaves(b(X, Y), N) :-
        count_leaves(X, L),
        count_leaves(Y, R),
        N is L + R.

leaves(l(X), [X]).
leaves(b(X, Y), L) :-
        leaves(X, V),
        leaves(Y, H),
        append(V, H, L).        

build_tree(L, T) :- leaves(T, L).

height(l(_),1).

height(b(S,T),H):- height(S,H1), 
                        height(T,H2), 
                        H is 1 + max(H1,H2).


balanced(l(_)).
%balanced(b(X,Y)):- height(X,H), height(Y,H).

balanced(b(X,Y)):- height(X,H1), height(Y,H2), ((H1 is H2+1); (H2 is H1+1)), balanced(X), balanced(Y).

indent(0).
indent(N) :- N>0, write(' '), Next is N-1, indent(Next).

increment(N) :- N>0, Next is N-1, increment(Next).