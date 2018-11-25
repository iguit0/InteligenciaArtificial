%Rules about to walk
%right
s([X,Y], [X,Yout]):- Y<4, Yout is Y + 1.
%left
s([X,Y], [X,Yout]):- Y>0, Yout is Y - 1.
%up
s([X,Y], [Xout,Y]):- X>0, Xout is X - 1.
%down
s([X,Y], [Xout,Y]):- X<4, Xout is X + 1.


%Objectives
obj([4,4]).

%That element belongs to list?
on(E, [E|_]).
on(E, [_|T]):- on(E, T).



%insert in lists head
ins(E, [], [E]):- !.
ins(E, List, [E|List]):- !.

%Swapping sides of lists
inv([],[]).
inv([E|C], Linv):-
	inv(C,C_Inv),
	join(C_Inv,[E], Linv).


%join two lists
join([],L,L).
join([H|T],L2,[H|T2]) :- join(T,L2,T2).


%Im not sure what this #### does, but you know... Thats life
estende([Estado|Caminho],ListaSucessores, Pkm, Pkb):-
	% Retorna uma lista chamada (listSsucessores)contendo todos os objetos
        % de ([Sucessor,Estado|Caminho]) que satisfazem as condicoes inpostas na linha de condicoes
	bagof([Sucessor,Estado|Caminho], %Lista de objetos
	        %A linha abaixo, linhas de condicoes
	        %(  s(Estado,Sucessor),not(on(Sucessor,[Estado|Caminho])) ), %<-	                     %A linha acima, linha de condicoes
		(  conditions(Estado, Sucessor, Pkm, Pkb, Caminho) ),
	      ListaSucessores),!. %Retorna uma lista de sucessores validos
estende(_,[],_,_).



conditions(Estado, Sucessor,Pkm, Pkb, Caminho):-
	s(Estado,Sucessor),  %Qualifica se o sucessor e valido, com os limites
<<<<<<< HEAD
	on(Pkb, [Estado|Caminho]),
	not(on(Sucessor,[Estado|Caminho])),
	%Para nao gerar ciclos
        on(Sucessor, Pkm).   %Estou pisando em um  pokemon
	/*writeln("Condition 1"),
	write("Estou em: "), writeln(Estado).
	write("caminho: "), writeln(Caminho),
	write("pokebola : "), writeln(Pkb),
	write("Sucessor: "), writeln(Sucessor),
	writeln("")*/


            %Ja passei pela pokebola antes, entao ta de boa

%!	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FATLA CIAR OPCAO DE QUANDO JA PASSOU NA POKEBOLA


conditions(Estado, Sucessor, Pkm,Pkb, Caminho):-
	s(Estado,Sucessor), %Qualifica se o sucessor e valido.
	not(on(Sucessor,[Estado|Caminho])), %Para nao gerar ciclos
	not(on(Sucessor,Pkm)). %Se nao estou pisando em pokemon, entao de boa
	/*writeln("Condition 2"),
	write("Estou em: "), writeln(Estado).
	write("caminho: "), writeln(Caminho),
	write("pokebola : "), writeln(Pkb),
	write("Sucessor: "), writeln(Sucessor),
	writeln("").*/


=======
	not(on(Sucessor,[Estado|Caminho])),
	%Para nao gerar ciclos
	not(on(Sucessor, Pkm)).   %Estou pisando em um  pokemon
       % on(Pkb, Caminho).    %Ja passei pela pokebola antes, entao ta de boa

%!	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FATLA CIAR OPCAO DE QUANDO JA PASSOU NA POKEBOLA

/*
conditions(Estado, Sucessor, Pkm,Pkb, Caminho):-
	not(on(Sucessor,[Estado|Caminho])), %Para nao gerar ciclos
	s(Estado,Sucessor),  %Qualifica se o sucessor e valido.
	not(on(Sucessor,Pkm)). %Se nao estou pisando em pokemon, entao de boa
*/
>>>>>>> f279301d6ee119d90f3cf32f7b292f4fba8d1fbc


%Busca por largura
solucao_bl(Inicial,Solucao, Pkm, Pkb, Obj) :- bl([[Inicial]],Solucao, Pkm, Pkb, Obj).
bl([[Estado|Caminho]|_],[Estado|Caminho],_,_, Obj) :- Estado=Obj.
bl([Primeiro|Outros], Solucao, Pkm, Pkb, Obj) :- estende(Primeiro,Sucessores, Pkm, Pkb),
join(Outros,Sucessores,NovaFronteira),
bl(NovaFronteira,Solucao, Pkm, Pkb, Obj).

%Searching
%searching without objectives = WIN
%search(_, [],_,_).
% Receive: start Coord, RETURN, list of pokemon Coord, PkbList, Obj
%
search(Start, Solution, Pkm, Pkb, Obj):-
	solucao_bl(Start, SolutionTmp, Pkm, Pkb, Obj), inv(SolutionTmp, Solution).

%How Many pokemons did I get
find(_, [], 0).
find(El, [El|_], 1).
find(El, [_|T], X):-
	find(El, T, R),
	X = R.

<<<<<<< HEAD
%Archive the solution, to show in a Web application
archive(Solution, Pkm, Pkb):-
    open("exit.txt",write, Stream),
    ( writeln(Stream, Solution),
      writeln(Stream, Pkm),
      writeln(Stream, Pkb),
     fail ; true),
    close(Stream).



=======
>>>>>>> f279301d6ee119d90f3cf32f7b292f4fba8d1fbc
%Path walked, list of pokemons, Result
howMany(_,  [], 0).
howMany(List, [Pkm|T], Res):-
	find(Pkm, List, R2),   %If that pokemon belongs to list, then R2=1
	howMany(List, T, R3),
	Res is R2 + R3.

<<<<<<< HEAD
%Main func
main(StartingPoint, Pkm, Pkb, Obj, Solution):-
        search(StartingPoint, Solution, Pkm, Pkb, Obj), %search from pokeball until end
	%join(Solution2, Solution3, Solution),
=======


%Main func
main(StartingPoint, Pkm, Pkb, Obj, Solution):-
	%search(StartingPoint, Solution, Pkm, Pkb, Pkb), %search from start until pokeball
        search(StartingPoint, Solution, Pkm, Pkb, Obj), %search from pokeball until end
	%join(Solution2, Solution3, Solution),

>>>>>>> f279301d6ee119d90f3cf32f7b292f4fba8d1fbc
	write("Pokemons, nos quadrantes: "), writeln(Pkm),
	write("Pokebola no quadrante: "),  writeln(Pkb),
	howMany(Solution, Pkm, Captured),
	write("Pokemons capturados: "),   writeln(Captured),
	obj(I),
	write("Insignia no quadrante: "),    writeln(I),
<<<<<<< HEAD
	write("Caminho do Ash: "),
	archive(Solution, Pkm, Pkb),!.
=======
	write("Caminho do Ash: "), !.
>>>>>>> f279301d6ee119d90f3cf32f7b292f4fba8d1fbc

%Call this function and then press "W", to show all vector.
%After that, you (in the same prompt) can call "main" function
err(X):-
	solucao_bl([0,0], X, [], [], [4,4]).




<<<<<<< HEAD









=======
>>>>>>> f279301d6ee119d90f3cf32f7b292f4fba8d1fbc
