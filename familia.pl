/* Considere o predicado progenitor(A, B), que representa que A é progenitor (i.e.,
pai ou mãe) de B. Além disso, considere também os predicados mulher(A) e
homem(B) para indicar o gênero da pessoa. Faça um conjunto de regras que modelem
as relações familiares entre:
• pai, mãe
• filho, filha
• avô, avó
• irmão, irmã
• tio, tia
• primo, prima
• sobrinho, sobrinha

Em seguida, crie fatos com seus familiares e utilize o Prolog para fazer consultas
sobre as relações criadas. Dentre elas:
• Quem é pai, mãe, tio, tia?
• Qual a relação deles com você?
• Quais as relações entre eles? */

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
