load("__common__.sage")

def generator():
    n=choice([4,5])

    #Pick if yes a linear combination or no
    independent = choice([false,true])
    
    if independent:
        A=simple_random_matrix_of_rank(n,rows=5,columns=n)
    else:
        A=simple_random_matrix_of_rank(choice([n-2,n-1]),rows=5,columns=n)


    xs=[var("x_"+str(i+1)) for i in range(0,n)]


    return {
      "independent": independent,
      "vecset": vectorSet(A.columns()),
      "veceq": vectorEquation(A.augment(zero_vector(ZZ,5),subdivide=true)),
      "prompt": choice([true,false]),
      "matrix": A.augment( vector([0 for i in range(0,A.nrows())]),true),
      "rref":A.augment( vector([0 for i in range(0,A.nrows())]),true).rref(),
    }
