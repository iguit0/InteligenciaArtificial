/* Faça os seguintes predicados (funções) em Prolog que sejam capazes de trabalhar com listas:
• Retorne o último elemento de uma lista
• Indique que dois elementos são consecutivos
• Retorne o número de elementos de uma lista
• Insira um elemento em qualquer posição da lista
• Retire todas as ocorrências de um elemento em uma lista
• Indique se a lista possui tamanho par ou ímpar
• Inverta os elementos de uma lista
• Indique se uma lista é subconjunto de outra */

pertence(Elem,[Elem|_ ]).
pertence(Elem,[ _| Cauda]) :- pertence(Elem,Cauda).

insere_primeiro(X,Y,[X|Y]).
insere_primeiro(X,[Cab|Resto],[X|[Cab|Resto]]).

% Insere um elemento no início de uma lista
insereInicio(H, L, [H|L]):- !.

inserePrimeira(X,L,[X|L]).

insere(X,L, [X|L]).

% numero de elementos de uma lista
no_elem([],0).
no_elem([Elem|Cauda],N) :- no_elem(Cauda,N1), N is N1+1.

retirar_elemento(Elem,[Elem|Cauda],Cauda).
retirar_elemento(Elem,[Cabeça|Cauda],[Cabeça|Resultado]) :- retirar_elemento(Elem,Cauda,Resultado).

concatena([ ],L,L).
concatena([Cab|Cauda],L2,[Cab|Resultado]) :- concatena(Cauda,L2,Resultado).



mostrar_ultimo([X], [X]).
mostrar_ultimo([Cab|Resto], R) :- mostrar_ultimo(Resto, R).

inserir_final([], Y, [Y]).         % Se a lista estava vazia, o resultado é [Y]
inserir_final([I|R], Y, [I|R1]) :- % Senão, o primeiro elemento é igual, e o resto é obtido
    inserir_final(R, Y, R1).       % Inserindo o elemento Y no final do antigo resto


% Verificar se dois elementos sao consecutivos em uma lista.
consecutivos([L],N).
consecutivos([C|L],N) :- consecutivos(L,A), ( N == A -> ).
