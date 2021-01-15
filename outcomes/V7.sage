load("__common__.sage")

def generator():
    #Pick some  vectors in R4
    n=choice([4,5,6])
    vec=[]
    for i in range(0,n):
        vec.append( vector([ randrange(-4,4), randrange(-4,4), randrange(-4,4), randrange(-4,4)]))

    #Build some vectors as linear combos
    if choice([false,true]):
        vec[2] = randrange(-5,5)*vec[0]+randrange(-5,5)*vec[1]
    if choice([false,true]):
        vec[3] = randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]
    if n>4 and choice([false,true]):
        vec[4] = randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]+randrange(-3,3)*vec[3]
    if n>5 and choice([false,true]):
        vec[5] = randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]+randrange(-3,3)*vec[3]



    A = matrix(vec).transpose()
    basis=[A.column(i) for i in A.pivots()]


    return {
      "vlist": vectorSet(vec),
      "basis": vectorSet(basis),
      "dimension": len(basis),
      "matrix": A,
      "rref": A.rref(),
    }

