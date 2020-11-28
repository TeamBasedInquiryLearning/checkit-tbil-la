load("__common__.sage")

def generator():
    # create a 4x4 or 5x3 matrix
    rows = randrange(3,5)
    columns = 8-rows

    #start with nice RREF
    max_number_of_pivots = min(rows,columns) 
    number_of_pivots = randrange(2,max_number_of_pivots+1)
    A = random_matrix(QQ,rows,columns,algorithm='echelonizable',rank=number_of_pivots,upper_bound=9)
    A.subdivide([],[columns-1])

    # construct variables
    xs=[var("x_"+str(i+1)) for i in range(0,columns-1)]

    # construct system
    system=[A.delete_columns([columns-1]).row(r)*vector(xs)==A.column(-1)[r] for r in range(0,rows)]

    #Choose prompt
    prompt = choice(["system","vectoreq"])

    # Get RREF
    rref = copy(A.echelon_form())
    rref.subdivide([],[columns-1])
    constants = rref.column(-1)
    free_vars = [var("a"), var("b"), var("c"), var("d")]

    # get solution
    if columns-1 in A.pivots():
        # a pivot in the last column represents a contradiction
        solset=setBuilder()
    else:
        # get particular solution
        part_sol = []
        abbr_part_sol = list(rref.column(-1))
        for i in range(0,columns-1):
            if i in A.pivots():
                part_sol.append(abbr_part_sol.pop(0))
            else:
                part_sol.append(0)
        sol = column_matrix(QQ,part_sol)
        # add span of homogeneous general solution
        predicate = []
        for v in A.delete_columns([columns-1]).right_kernel(basis='pivot').basis():
            free_var = free_vars.pop(0)
            predicate.append(free_var)
            predicate.append(",")
            sol += free_var*column_matrix(v)
        if (len(predicate) > 0):
            predicate.pop() #Remove extra comma
            predicate.append(LatexExpr(r"\in\mathbb{R}"))
            solset = setBuilder(sol,predicate)
        else:
            infinite = False
            solset = setBuilder(sol)


    return {
        'system': latex_system_from_matrix(A,variable_list=xs),
        'alignCols': A.ncols(),
        'matrix': A,
        'rref': rref,
        'solution': solset,
        'prompt': prompt,
        'vectoreq': vectorEquation(A)
    }
