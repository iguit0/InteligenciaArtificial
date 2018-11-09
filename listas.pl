/* Faça os seguintes predicados (funções) em Prolog que sejam capazes de trabalhar com listas:
• Retorne o último elemento de uma lista
• Indique que dois elementos são consecutivos
• Retorne o número de elementos de uma lista
• Insira um elemento em qualquer posição da lista
• Retire todas as ocorrências de um elemento em uma lista
• Indique se a lista possui tamanho par ou ímpar
• Inverta os elementos de uma lista
• Indique se uma lista é subconjunto de outra */

% Retorne o último elemento de uma lista
mostrar_ultimo([X], [X]).
mostrar_ultimo([Cab|Resto], R) :- mostrar_ultimo(Resto, R).

% Indique que dois elementos são consecutivos
consecutivos([L],N).
consecutivos([C|L],N) :- consecutivos(L,A), ( N == A -> ).

% Retorne o número de elementos de uma lista
no_elem([],0).
no_elem([Elem|Cauda],N) :- no_elem(Cauda,N1), N is N1+1.

% Insira um elemento em qualquer posição da lista
insereN(X,1,L,[X|L]).
insereN(X,N,[C|L],[C|R]):-N1 is N-1, insereN(X,N1,L,R).

% Retire todas as ocorrências de um elemento em uma lista
remove_x(_,[],[]).
remove_x(X,[X|T], L)      :- remove_x(X,T,L).
remove_x(X,[C|T], [C|T1]) :- X \= C, remove_x(X,T,T1).

% Indique se a lista possui tamanho par ou ímpar
par([]).
par([_,_|T]) :- par(T).
impar([_|T]) :- par(T).

% Inverta os elementos de uma lista
add(X,L,[X|L]).
last(X,[X]).
last(X,[_|R]):- last(X, R).
del_ultimo([_], []) :- !.
del_ultimo([H|T], [H| Tf]) :- del_ultimo(T,Tf).
lshift([], []).
lshift(L,Lf) :- last(X,L), del_ultimo(L,L3), add(X,L3,Lf), !.
inverso([], []). inverso([H|T], Lf) :- last(X, Lf), X = H, del_ultimo(Lf,L3), inverso(T, L3), !.

% Indique se uma lista é subconjunto de outra
% ...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verificar se um elemento pertence alguma lista
pertence(Elem,[Elem|_ ]).
pertence(Elem,[ _| Cauda]) :- pertence(Elem,Cauda).

% Insere um elemento no início de uma lista
insere_primeiro(X,Y,[X|Y]).
insere_primeiro(X,[Cab|Resto],[X|[Cab|Resto]]).

% Retirar Elemento
retirar_elemento(Elem,[Elem|Cauda],Cauda).
retirar_elemento(Elem,[Cab|Cauda],[Cab|Resultado]) :- retirar_elemento(Elem,Cauda,Resultado).

concatena([ ],L,L).
concatena([Cab|Cauda],L2,[Cab|Resultado]) :- concatena(Cauda,L2,Resultado).

inserir_final([], Y, [Y]).         % Se a lista estava vazia, o resultado é [Y]
inserir_final([I|R], Y, [I|R1]) :- % Senão, o primeiro elemento é igual, e o resto é obtido
    inserir_final(R, Y, R1).       % Inserindo o elemento Y no final do antigo resto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%