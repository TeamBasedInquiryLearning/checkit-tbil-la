load("__common__.sage")

def generator():
    #Pick if yes a linear combination or no
    independent = choice([False,True])
    
    n = choice([3,4])
    if independent:
        A=simple_random_matrix_of_rank(n,rows=4,columns=n)
    else:
        A=simple_random_matrix_of_rank(n-1,rows=4,columns=n)


    xs=[var("x_"+str(i+1)) for i in range(4)]


    return {
      "independent": independent,
      "vecset": vectorSet(A.columns()),
    #   "veceq": vectorEquation(A.augment(zero_vector(ZZ,5),subdivide=true)),
      "matrix": A,
      "rref":A.rref(),
    }
