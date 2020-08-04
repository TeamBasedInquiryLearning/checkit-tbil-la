load("__common__.sage")

def generator():
    # create a mxn standard matrix
    columns = randrange(3,5)
    rows = choice([7,8])-columns
    A = random_matrix(QQ,rows,columns,algorithm='echelonizable',rank=choice([min(rows,columns),min(rows,columns)-1]),upper_bound=9)


    if len(A.pivots())==columns:
        injective=true
    else:
        injective=false

    if len(A.pivots())==rows:
        surjective=true
    else:
        surjective=false

    return {
      "matrix": A,
      "columns": columns,
      "rows": rows,
      "rref": A.rref(),
      "injective": injective,
      "surjective": surjective
    }
