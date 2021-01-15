load("__common__.sage")

def generator():
    n=choice([4,5])
    vec=[]
    for i in range(0,n):
        vec.append(vector([ randrange(-6,6), randrange(-6,6), randrange(-6,6), randrange(-6,6), randrange(-6,6)]))

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

    xs=[var("x_"+str(i+1)) for i in range(0,n)]


    return {
      "independent": independent,
      "vecset": vectorSet(vec),
      "veceq": vectorEquation(A.augment(zero_vector(ZZ,5),subdivide=true)),
      "prompt": choice([true,false]),
      "matrix": A.augment( vector([0 for i in range(0,A.nrows())]),true),
      "rref":A.augment( vector([0 for i in range(0,A.nrows())]),true).rref(),
    }
