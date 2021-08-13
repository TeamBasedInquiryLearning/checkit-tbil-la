load("__common__.sage")

def generator():
    #Pick if yes a spanning set or no
    span = choice([False,True])

    if span:
        A=simple_random_matrix_of_rank(4,rows=4,columns=choice([4,5]))
    else:
        A=simple_random_matrix_of_rank(choice([2,3]),rows=4,columns=choice([4,5]))
        
    # xs=[var("x_"+str(i+1)) for i in range(0,n)]
    # vectorComb = linearCombination(xs,[column_matrix(v) for v in A.columns()])
    
    return {
      "spans": span,
      "vecset": vectorSet(A.columns()),
    #   "vecComb": vectorComb,
      "matrix": A,
      "rref": A.rref(),
    }