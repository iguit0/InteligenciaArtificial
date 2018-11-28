%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UNIVERSIDADE FEDERAL DE VICOSA - CAMPUS RIO PARANAIBA
% DESENVOLVIDO PELOS ALUNOS: IGOR LUCIO & GABRIEL ALVES
% POKEMON - BUSCA NO ESPACO DE ESTADOS
% AJUDE ASH A ENCONTRAR A INSIGNIA
% https://github.com/iguit0/Inteligencia-Artificial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%[ Funções de Lista ]%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verificar se elemento pertence a uma lista
on(E, [E|_]).
on(E, [_|T]):- on(E, T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Insere no inicio
ins(E, [], [E]):- !.
ins(E, List, [E|List]):- !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inverter lista
inv([],[]).
inv([E|C], Linv):-
	inv(C,C_Inv),
	join(C_Inv,[E], Linv).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Concatena duas listas (junta duas listas)
join([],L,L).
join([H|T],L2,[H|T2]) :- join(T,L2,T2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%[ Movimenta o agente pelo cenário ]%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Regras de sucessao de estados (movimentacao)
%direita
s([X,Y], [X,Yout]):- Y<4, Yout is Y + 1.
%esquerda
s([X,Y], [X,Yout]):- Y>0, Yout is Y - 1.
%cima
s([X,Y], [Xout,Y]):- X>0, Xout is X - 1.
%baixo
s([X,Y], [Xout,Y]):- X<4, Xout is X + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%[ Funções de Busca em Largura ]%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%metodo que faz a extensao do caminho até os nos filhos do estado
estende([Estado|Caminho],ListaSucessores, Pkm, Pkb):-
	% Retorna uma lista chamada (listSsucessores)contendo todos os objetos
        % de ([Sucessor,Estado|Caminho]) que satisfazem as condicoes inpostas na linha de condicoes
	bagof([Sucessor,Estado|Caminho], %Lista de objetos
	        % linhas de condicoes
		(  conditions(Estado, Sucessor, Pkm, Pkb, Caminho) ),
	      ListaSucessores),!. % Retorna uma lista de sucessores validos
estende(_,[],_,_). %se o estado não tiver sucessor, falha e não procura mais

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%[ Condições p/ Busca ]%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
conditions(Estado, Sucessor,Pkm, Pkb, Caminho):-
	s(Estado,Sucessor),  %Qualifica se o sucessor e valido, com os limites
	on(Pkb, [Estado|Caminho]),
	not(on(Sucessor,[Estado|Caminho])),
	%Para nao gerar ciclos
        on(Sucessor, Pkm).   %Estou pisando em um  pokemon


conditions(Estado, Sucessor, Pkm,_, Caminho):-
	s(Estado,Sucessor), %Qualifica se o sucessor e valido.
	not(on(Sucessor,[Estado|Caminho])), %Para nao gerar ciclos
	not(on(Sucessor,Pkm)). %Se nao estou pisando em pokemon, entao de boa

% Busca por largura
solucao_bl(Inicial,Solucao, Pkm, Pkb, Obj) :- bl([[Inicial]],Solucao, Pkm, Pkb, Obj).
% falha ao encontrar a meta, então estende o primeiro estado até seus sucessores e os coloca no final da lista de fronteira
bl([[Estado|Caminho]|_],[Estado|Caminho],_,_, Obj) :- Estado=Obj.
bl([Primeiro|Outros], Solucao, Pkm, Pkb, Obj) :- estende(Primeiro,Sucessores, Pkm, Pkb),
join(Outros,Sucessores,NovaFronteira),
bl(NovaFronteira,Solucao, Pkm, Pkb, Obj).

% Procura
% Parametros: Coordenada inicial, Solucao, Lista Coordenada pokemons, lista pokebola, Objetivo
search(Start, Solution, Pkm, Pkb, Obj):-
	solucao_bl(Start, SolutionTmp, Pkm, Pkb, Obj), inv(SolutionTmp, Solution).

% contabilizar quantos pokemons peguei
find(_, [], 0).
find(El, [El|_], 1).
find(El, [_|T], X):-
	find(El, T, R),
	X = R.

%argumentos: caminho percorrido, lista pokemons, resultado
howMany(_,  [], 0).
howMany(List, [Pkm|T], Res):-
	find(Pkm, List, R2),    % se um pokemon pertence a esta lista, entao R2 = 1
	howMany(List, T, R3),
	Res is R2 + R3.

% Saída do caminho final em arquivo
archive(Solution, Pkm, Pkb):-
    open("exit.txt",write, Stream),
    ( writeln(Stream, Solution),
      writeln(Stream, Pkm),
      writeln(Stream, Pkb),
     fail ; true),
    close(Stream).

%Funcao principal
main(StartingPoint, Pkm, Pkb, Obj, Solution):-
        search(StartingPoint, Solution, Pkm, Pkb, Obj),
	write("Pokemons, nos quadrantes: "), writeln(Pkm),
	write("Pokebola no quadrante: "),  writeln(Pkb),
	howMany(Solution, Pkm, Captured),
	write("Pokemons capturados: "),   writeln(Captured),
	write("Insignia no quadrante: "), writeln(Obj),
	write("Caminho do Ash: "),
	archive(Solution, Pkm, Pkb),!.

%Chame esta funcao primeiro e pressione "W" para mostrar todo o vetor
% Apos isto, chame a funcao principal (main)
err(X):-
	solucao_bl([0,0], X, [], [], [4,4]).
