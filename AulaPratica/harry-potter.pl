/* Utilize a base de conhecimento a seguir para responder as questões.
Dado o conjunto de dados, qual é a resposta do Prolog para:
	mago(ron). true.
	bruxo(ron). error.
	mago(hermione). false.
	bruxa(hermione). error.
	mago(harry). false.
	mago(X). X = ron.
	bruxo(X). error.

*/

mago(ron).
possuiVarinha(harry).
jogadorQuadribol(harry).
mago(X):- possuiVassoura(X), possuiVarinha(X).possuiVassoura(X):- jogadorQuadribol(X).
