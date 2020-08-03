load("__common__.sage")

def generator():
    context=choice(["polynomial","matrix"])
    task=choice(["independent","span"])

    if task=="independent":
        n=4
        vec=[]
        for i in range(0,n):
            vec.append(vector([ randrange(-6,6), randrange(-6,6), randrange(-6,6), randrange(-6,6)]))

        #Pick if yes a linear combination or no
        independent = choice([false,true])

        #If dependent, Generate the 4th vector and sometimes the 3rd vector
        if independent==0:
            d = choice( range(3,n))
            vec[d]=randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]
            if choice([false,true]):
                d = choice( range(2,n))
                vec[d]=randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]

        A=matrix(vec).transpose()
        if rank(A)<n:
            independent = false
        else:
            independent = true

        result=independent

    if task=="span":
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

        result=span

    #Create equation
    if context=="polynomial":
        polys=[ sum([v[i]*x^i for i in range(0,len(v))]) for v in vec ]
        vset=polys
        vars=[var("y_"+str(i+1)) for i in range(0,len(vec))]
        lc=linearCombination(vars,polys,parentheses=true)
        if task=="independent":
            eq=Equation(lc,"0")
        else:
            eq=lc

    if context=="matrix":
        matrices = [ matrix(ZZ,2,v) for v in vec]
        vset=matrices
        vars=[var("y_"+str(i+1)) for i in range(0,len(vec))]
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
    }