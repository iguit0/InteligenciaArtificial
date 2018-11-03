homem(lucio).
progenitor(lucio,igor).
progenitor(lucio,gustavo).
mulher(angelica).
progenitor(angelica,igor).
progenitor(angelica,gustavo).

homem(igor).
homem(gustavo).

homem(wilson).
mulher(clarinda).
progenitor(wilson,lucio).
progenitor(clarinda,lucio).

pai(X,Y) :- homem(X), progenitor(X,Y).
mae(X,Y) :- mulher(X), progenitor(X,Y).
filho(X,Y) :- homem(X), progenitor(Y,X).
irmao(A,B) :- homem(A), progenitor(C,A), progenitor(C,B), A \== B.
irma(A,B) :- mulher(A), progenitor(C,A), progenitor(C,B), A \== B.
abuelo(X,Y) :- homem(X), progenitor(X,Z), progenitor(Z,Y).
abuela(X,Y) :- mulher(X), progenitor(X,Z), progenitor(Z,Y).
