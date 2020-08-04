load("__common__.sage")

def generator():
    # create a 3x5,4x4,5x3 matrix
    rows = randrange(3,6)
    columns = 8-rows

    #start with nice RREF
    max_number_of_pivots = min(rows,columns-1)
    number_of_pivots = randrange(2,max_number_of_pivots+1)
    A = random_matrix(QQ,rows,columns,algorithm='echelonizable',rank=number_of_pivots,upper_bound=13)

    # construct variables
    xs=vector([var("x_"+str(i+1)) for i in range(0,columns)])

    # construct system
    #system="<md>"
    #for r in A.rows():
    #    system+="<mrow>"+latex(r*xs)+"&=0</mrow>"
    #system+="</md>"


    #Get solution set
    free_vars = [var("a"), var("b"), var("c"), var("d")]
    basis=A.right_kernel(basis='pivot').basis()

    solutions = column_matrix(zero_vector(ZZ, len(A.columns())))
    # add span of homogeneous general solution
    predicate = []
    for v in basis:
        free_var = free_vars.pop(0)
        predicate.append(free_var)
        predicate.append(",")
        solutions += free_var*column_matrix(v)
    if (len(predicate) > 0):
        predicate.pop() #Remove extra comma
        predicate.append(LatexExpr(r"\in\mathbb{R}"))
        solset = setBuilder(solutions,predicate)
    else:
        solset = setBuilder(solutions)

    return {
      "system": systemEquations(A).equations,
      "alignCols": A.ncols()+1,
      "basis": vectorSet(basis),
      "solutions": solset,
      "matrix": A.augment( vector([0 for i in range(0,A.nrows())]),true),
      "rref":A.augment( vector([0 for i in range(0,A.nrows())]),true).rref(),
    }
