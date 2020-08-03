load("__common__.sage")

def generator():
    l = choice([-1,1])*randrange(1,5)
    dim = randrange(1,4)
    A = random_matrix(QQ,4,algorithm="echelonizable",rank=4-dim,upper_bound=9)
    B = A+l*identity_matrix(4)

    #Find kernel basis
    basis = A.right_kernel(basis='pivot').basis()

    return {
      "matrix": B,
      "eigenvalue": l,
      "basis": vectorSet(basis), 
    }
