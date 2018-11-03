mago(ron).
possuiVarinha(harry).
jogadorQuadribol(harry).
mago(X):- possuiVassoura(X), possuiVarinha(X).possuiVassoura(X):- jogadorQuadribol(X).
