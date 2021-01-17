load("__common__.sage")

def generator():
    # create a mxn standard matrix
    columns = randrange(3,4)
    rows = 7-columns
    A = simple_random_matrix_of_rank(min(rows,columns)-1,rows=rows,columns=columns)

    # construct variables
    xs=choice([
      column_matrix(vector([var("x_"+str(i+1)) for i in range(0,columns)])),
      column_matrix(vector([var("x"),var("y"),var("z"),var("zw",latex_name="w")][0:columns])),
    ])

    #Get kernel set
    free_vars = [var("a"), var("b"), var("c"), var("d")]
    kernelbasis=A.right_kernel(basis='pivot').basis()

    solutions = column_matrix(zero_vector(ZZ, len(A.columns())))
    # add span of homogeneous general solution
    predicate = []
    for v in kernelbasis:
        free_var = free_vars.pop(0)
        predicate.append(free_var)
        predicate.append(",")
        solutions += free_var*column_matrix(v)
    if (len(predicate) > 0):
        predicate.pop() #Remove extra comma
        predicate.append(LatexExpr(r"\in\mathbb{R}"))
        kernel = setBuilder(solutions,predicate)
    else:
        kernel = setBuilder(solutions)

    #Get image basis    
    imagebasis=[A.column(i) for i in A.pivots()]

    return {
      "columns": columns,
      "rows": rows,
      "Tvar": A*xs,
      "varvector": xs,
      "matrix": A,
      "rref": A.rref(),
      "imagebasis": vectorSet(imagebasis),
      "kernelbasis": vectorSet(kernelbasis),
      "kernel": kernel,
      "rank": len(imagebasis),
      "nullity": len(kernelbasis)
    }
