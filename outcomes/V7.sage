load("__common__.sage")

def generator():
    #Pick some  vectors in R4
    n=choice([3,4,5])
    dim=choice(range(2,n))
    A=simple_random_matrix_of_rank(dim,columns=n,rows=4)
    basis=[A.column(i) for i in A.pivots()]

    return {
      "vlist": vectorSet(A.columns()),
      "basis": vectorSet(basis),
      "dimension": dim,
      "matrix": A,
      "rref": A.rref(),
    }

