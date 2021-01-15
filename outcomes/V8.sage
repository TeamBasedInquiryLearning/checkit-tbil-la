load("__common__.sage")

def generator():
    context=choice(["polynomial","matrix"])
    task=choice(["independent","span"])

    if task=="independent":
        n=4
 
        #Pick if yes a linear combination or no
        independent = choice([false,true])
        
        if independent:
            A=simple_random_matrix_of_rank(n,rows=4,columns=n)
        else:
            A=simple_random_matrix_of_rank(choice([2,3]),rows=4,columns=n)

        result=independent

    if task=="span":
        #Pick How many vectors in R4
        n=choice([4,5,6])

        #Pick if yes a spanning set or no
        span = choice([false,true])
        
        if span:
            A=simple_random_matrix_of_rank(4,rows=4,columns=n)
        else:
            A=simple_random_matrix_of_rank(choice([2,3]),rows=4,columns=n)

        result=span

    #Create equation
    if context=="polynomial":
        polys=[ sum([v[i]*x^i for i in range(0,len(v))]) for v in A.columns() ]
        vset=polys
        vars=[var("y_"+str(i+1)) for i in range(0,A.ncols())]
        lc=linearCombination(vars,polys,parentheses=true)
        if task=="independent":
            eq=Equation(lc,"0")
        else:
            eq=lc

    if context=="matrix":
        matrices = [ matrix(ZZ,2,v) for v in A.columns()]
        vset=matrices
        vars=[var("y_"+str(i+1)) for i in range(0,A.ncols())]
        lc=linearCombination(vars,matrices)
        if task=="independent":
            eq=Equation(lc,matrix(ZZ,2)) #matrix() defaults to zero matrix
        else:
            eq=lc

    return {
      "task": task,
      "context": context,
      "set": bracedSet(vset),
      "equation": eq,
      "result": result,
      "matrix": A,
      "rref": A.rref(),
    }