



def getFile(name):
    file = open(name, "r")
    return file

#Transform a string in tuples, thats correspond to X and Y from all coordinades
def string2List(Old):
    #[[0,0],[0,1],[0,2],[0,3],[0,4],[1,4],[2,4],[3,4],[4,4]] Eample of input
    #Removing the "\n" last chars
    new = []
    Old = Old[:-2]
    for i in range(0, len(Old)-2):
        if Old[i] != '[' and Old[i] != ']' and Old[i] != ',' and Old[i+2] != '[' and Old[i+2] != ']' and Old[i+2] != ',':
            tupl = (int(Old[i]), int(Old[i+2]))
            new.append(tupl)
   
    return new

#Transforms 3 strings, returning 3 tuple lists
def defVars(file):
    i = 0
    Solution = ""
    Pkm = ""
    Pkb  = ""
    for line in file:
        if i==0:
            Solution = line
        if i==1:
                Pkm = line
        if i==2:
            Pkb = line
        i+=1
    #Making tuple Lists with them
    So = string2List(Solution)
    Pm = string2List(Pkm)
    Pb = string2List(Pkb)
    Ob = So[-1]
    return So, Pm, Pb, Ob

def getLine(Trainner, Pkm, Pkb, Obj, pkNameList, ind):
    #[cam, cam, ash, cam, cam], [pokemon1, cam, pokemon2, cam, cam],
    X = Trainner[0]
    Y = Trainner[1]
    line = ['cam','cam','cam','cam','cam']
    #Pkm
    pkCounter=1
    for j in range (0, len(Pkm)):
        item = Pkm[j]
        if item[0]==ind:
            pos = item[1]
            line[pos] = pkNameList[j]

    #Pkb
    for j in range (0, len(Pkb)):
        item = Pkb[j]
        if item[0]==ind:
            pos = item[1]
            line[pos]='pokebola'  
    #Objective
    if Obj[0]== ind: line[Obj[1]]='obj'
    #Trainner
    if X == ind: line[Y]= 'ash'

    #Modifing lists, when ash take pokemon or pokeballs
    coord = ( Trainner[0], Trainner[1] )
    ret = 0

    if coord in Pkm:
        ret = 1
    if coord in Pkb:
        ret = 2
    return line, ret


    


#Returns a list, composed by 5 lists, representing a full Table.
def getScreen(Trainner, Pkm, Pkb, pkNameList, Obj):
    line = []
    endV = 0
    for i in range(0, 5):
        l, ret = getLine(Trainner, Pkm, Pkb, Obj, pkNameList, i)
        line.append(l)
        if ret> endV: endV = ret
    line = str(line).replace("'","")
    return line, endV

def writeOutput(lines, size, name):
    file = open(name, "w")
    '''
    for i in range(0, size):
        file.write()
    '''
    file.write(lines)
    file.close()









if __name__ == "__main__":
    file = getFile("exit.txt")
    Solution, Pkm, Pkb, Obj= defVars(file)

    #Name of Pkm
    PkmName = []
    count = 1
    for i in range(0, len(Pkm)):
        PkName = 'pokemon'+str(count)
        count+=1
        PkmName.append(PkName)

    tmp = []
    for i in range(0, len(Solution)):
        line, ret = getScreen(Solution[i], Pkm, Pkb, PkmName, Obj)
        tmp.append(line)
        #Remover itens das listas
        #Pkm
        if ret == 1:
            ind = Pkm.index(Solution[i])
            Pkm.remove(Solution[i])
            PkmName.pop(ind)
            #Pkb
        if ret == 2:
            Pkb.remove(Solution[i])


    #tmp = str(tmp).replace("'", "")
    #Change lines
    
    #inv
    tmp.reverse ( ) 

    #size
    size = len(tmp)
    #Output
    out = str(tmp).replace("'", "")
    
    writeOutput(out, size, "screen.txt")





