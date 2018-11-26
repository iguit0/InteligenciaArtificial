%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Regras de sucessão de estados
%enche o jarro de 4 litros
s([0,Y],[4,Y]).
%enche o jarro de 3 litros
s([X,0],[X,3]).
%passa agua do jarro de 4 litros para o de 3 litros ate ele encher
s([X,Y],[X2,3]):- Y < 3, X > (3-Y), X2 is X-(3-Y).
%passa agua do jarro de 4 litros para o de 3 litros ate ficar vazio
s([X,Y],[0,Y2]):- Y < 3, X < (3-Y), X > 0, Y2 is X+Y.
%passa agua do jarro de 3 litros para o de 4 litros ate ele encher
s([X,Y],[4,Y2]):- X < 4, Y > (4-X), Y2 is Y-(4-X).
%passa agua do jarro de 3 litros para o de 4 litros ate ficar vazio
s([X,Y],[X2,0]):- X < 4, Y < (4-X), Y > 0, X2 is X+Y.
%esvazia o jarro de 4 litros
s([_,Y],[0,Y]).
%esvazia o jarro de 3 litros
s([X,_],[X,0]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define o estado meta
meta(Estado) :- pertence(2,Estado).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para usar a busca em largura e em profundidade é preciso aplicar os métodos de manipulação de
lista pertence e concatena.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Métodos para manipulação de listas (Aula Prolog)
pertence(Elem,[Elem|_ ]).
pertence(Elem,[ _| Cauda]) :- pertence(Elem,Cauda).
concatena([ ],L,L).
concatena([Cab|Cauda],L2,[Cab|Resultado]) :- concatena(Cauda,L2,Resultado).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Métodos de busca (Aula Busca Cega)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solucao por busca em largura (bl)
solucao_bl(Inicial,Solucao) :- bl([[Inicial]],Solucao).
%a solução cons=te em estender o caminho até a meta
bl([[Estado|Caminho]|_],[Estado|Caminho]) :- meta(Estado).
%se não encontrou a meta, então estende o caminho até os decendentes
bl([Caminho|Outros],
Solucao)
:-
estende(Caminho,NovoCaminho),
concatena(Outros,NovoCaminho,CaminhoAnterior), bl(CaminhoAnterior,Solucao).
%metodo que faz a extensao do caminho até os nos filhos
estende([Estado|Caminho],NovoCaminho):- bagof([Sucessor,Estado|Caminho],(s(Estado,Sucessor),
not(pertence(Sucessor,[Estado|Caminho]))), NovoCaminho),!.
%se o estado não tiver sucessor, falha e não procura ma= (corte)

estende(_,[]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solucao por busca em profundidade (bp)
solucao_bp(Inicial,Solucao) :- bp([],Inicial,Solucao).
%implementacao da busca em profundidade
%encontra a meta
bp(Caminho,Estado,[Estado|Caminho]) :- meta(Estado).
%senao, coloca o no caminho e continua a busca
bp(Caminho,Estado,Solucao) :- s(Estado,Sucessor), not(pertence(Sucessor,Caminho)), %evita ciclos
bp([Estado|Caminho],Sucessor,Solucao).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
