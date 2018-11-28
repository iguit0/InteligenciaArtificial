# Projeto IA - Pokémon :8ball::boom:
O trabalho consiste em criar um conjunto de regras na linguagem de programação Prolog que delineie um ambiente do jogo Pokémon, de forma que o protagonista possa encontrar a primeira insígnia de Kanto. Supomos a existência de um agente capaz de executar ações que modificam o estado atual de seu ambiente.

O ambiente do jogo será uma tabela 5X5 com 25 posições. Ou seja, o jogador estará limitado a este mundo; não sendo possível movimentação do mesmo além das posições citadas. Não será permitida a movimentação para posições inexistentes da tabela, isto é, coordenadas em que seu X e Y sejam, respectivamente, maiores que 4 como também menores que 0.

Assim, dados um estado inicial representando a configuração corrente do mundo do agente, um conjunto de ações que o agente é capaz de executar e uma descrição do estado meta que se deseja atingir, a solução do problema consiste numa sequência de ações que, quando executada pelo agente, transforma o estado inicial num estado meta. Portanto, se trata, por definição, de um problema de busca. O objetivo é desenvolver um modelo lógico consistente para auxiliar nosso protagonista (Ash) a chegar em seu objetivo.
<p align="center"><img src="http://imagem.b2s-space.com/upimg/60505/0/1d853b168b.png"></p>

## Okay, mas como isso funciona? :neutral_face::question:
Para executar o programa, é necessário um interpretador e compilador dos blocos de códigos, adaptados para Prolog, onde existem uma gama de possibilidades para tal função. Para que o Prolog, possa mostrar em seu *prompt* a lista de caminhos completo, é necessário de utilizar a extensão da função [write/1](http://www.swi-prolog.org/FAQ/AllOutput.html), que é definida de forma própria pelo Prolog, sendo a mesma ativada após o aperto da tecla W, quando uma lista, com tamanho maior de 8 tenta ser exibida.

Para auxiliar o usuário, durante a tarefa, foi criada a função err/1, que exibe uma lista longa o suficiente, para que o usuário em seguida possa apertar W e habilitar a função de escrita completa no *prompt*.

Após chamar a função err e apertar W, está habilitado o *prompt* para exibição. Após isso, deve-se chamar a função main/5, instanciando os valores necessários. Os parâmetros seguem a seguinte ordem: Coordenada indicando estado inicial, lista de coordenadas indicando onde os pokemons se encontram no ambiente proposto, lista de coordenadas indicando locais com pokebolas, coordenada onde se encontra a insígnia.

## Desenvolvedores :eyeglasses::computer:
**[@arkfiend](https://github.com/arkfiend)**<br/>
**[@iguit0](https://github.com/iguit0)**
