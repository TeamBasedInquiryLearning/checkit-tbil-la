load("__common__.sage")

def generator():
    # create a 3x5,4x4,5x3 matrix
    #Pick how many vectors in R4
    n = choice([3,4,5])
    vec=[]
    for i in range(0,n):
        vec.append(vector([ randrange(-5,5), randrange(-3,3), randrange(-5,5), randrange(-3,3)]))

    #Pick if yes a linear combination or no
    lincombo = choice([false,true])

    combovector=[]

    #Generate additional vecor
    if lincombo==1:
        combovector=randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]
    else:
        combovector = vector([ randrange(-10,10), randrange(-10,10), randrange(-10,10), randrange(-10,10)])
        #Sometimes make 3rd column a dependency
        if choice([false,true]):
            vec[2]=randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]
        #Make sure at columns 4 and 5 are dependencies
        if n>3:
            vec[3]=randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]
        if n>4:
            vec[4]=randrange(-3,3)*vec[0]+randrange(-3,3)*vec[1]+randrange(-3,3)*vec[2]

        A=column_matrix([vec[0],vec[1],vec[2]])
        while 3 not in A.augment(combovector).pivots():
            combovector = vector([ randrange(-10,10), randrange(-10,10), randrange(-10,10), randrange(-10,10)])

    #Generate equivalent vector equation
    xs=[var("x_"+str(i+1)) for i in range(0,n)]

    A=matrix(vec).transpose().augment(combovector,subdivide=true)

    return {
      "lc": lincombo,
      "veclist": vectorList(vec),
      "combovector": column_matrix(combovector),
      "statement": choice([true,false]),
      "veceq": vectorEquation(A),
      "matrix": A,
      "rref": A.rref()
    }