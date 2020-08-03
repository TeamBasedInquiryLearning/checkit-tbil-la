load("__common__.sage")

def generator():
    #Pick How many vectors in R4
    n=choice([4,5,6])
    vec=[]
    for i in range(0,n):
        vec.append(vector([ randrange(-5,5),randrange(-5,5), randrange(-5,5),randrange(-5,5)]))

    #Pick if yes a spanning set or no
    span = choice([false,true])

    #If they should not span, generate columns 3 or 4 through n.
    if span==false:
        if choice([false,true]):
            vec[2] = randrange(-3,3)*vec[0]+randrange(-4,4)*vec[1]
        for i in range (3,n):
            vec[3] = randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]

    #Constructor uses vecs as rows
    A=matrix(vec).transpose()
    if rank(A)<4:
        span = false
    else:
        span = true

    xs=[var("x_"+str(i+1)) for i in range(0,n)]
    vectorComb = linearCombination(xs,[column_matrix(v) for v in vec])

    return {
      "spans": span,
      "vecset": vectorSet(vec),
      "vecComb": vectorComb,
      "prompt": choice([true,false])
    }