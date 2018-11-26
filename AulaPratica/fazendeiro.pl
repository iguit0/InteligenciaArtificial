%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assume que o estado seja representado por uma lista cujas posições
% são fazendeiro, lobo, ovelha e repolho
% neste problema, o estado inicial é fixo, ou seja,
% [norte,norte,norte,norte]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Regras de sucessão de estados
%fazendeiro atravessa o rio com lobo
s([Saida,Saida,O,R],[Chegada,Chegada,O,R])
[Chegada,Chegada,O,R]).
:- permitido_ir_de([Saida,Saida,O,R],
:- permitido_ir_de([Saida,L,Saida,R],
:- permitido_ir_de([Saida,L,O,Saida],
%fazendeiro atravessa o rio com a ovelha
s([Saida,L,Saida,R],[Chegada,L,Chegada,R])
[Chegada,L,Chegada,R]).
%fazendeiro atravessa o rio com o repolho
s([Saida,L,O,Saida],[Chegada,L,O,Chegada])
[Chegada,L,O,Chegada]).
%fazendeiro atravessa o rio sozinho
s([Saida,L,O,R],[Chegada,L,O,R]) :- permitido_ir_de([Saida,L,O,R],[Chegada,L,O,R]).
%regra que define se é permitido atravessar o rio
permitido_ir_de([F1,_,_,_],[F2,L2,O2,R2]) :- opostas(F1,F2), nao_oferece_perigo(F2,L2,O2,R2).

%regra que define estados que oferecem perigo e não são permitidos
%não há perigo se o fazendeiro estiver com a ovelha ou
nao_oferece_perigo(FO,_,FO,_).
%não há perigo se a ovelha estiver sozinha em uma das margens
nao_oferece_perigo(FLR,FLR,O,FLR) :- opostas(FLR,O).
%preciso definir quais são as margens opostas
opostas(sul,norte).
opostas(norte,sul).
%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%define estado inicial
inicio([norte,norte,norte,norte]).
%define o estado meta
meta([sul,sul,sul,sul]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
solucao_bl(Solucao) :- inicio(X), bl([[X]],Solucao).
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
solucao_bp(Solucao) :- inicio(X), bp([],X,Solucao).
%implementacao da busca em profundidade
%encontra a meta
bp(Caminho,Estado,[Estado|Caminho]) :- meta(Estado).
%senao, coloca o no caminho e continua a busca
bp(Caminho,Estado,Solucao) :- s(Estado,Sucessor), not(pertence(Sucessor,Caminho)), %evita ciclos
bp([Estado|Caminho],Sucessor,Solucao).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
