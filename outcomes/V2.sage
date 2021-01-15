load("__common__.sage")

def generator():
    # create a 4x4 or 5x3 matrix
    rows = randrange(3,5)
    columns = 8-rows

    #start with nice RREF
    max_number_of_pivots = min(rows,columns) 
    number_of_pivots = randrange(2,max_number_of_pivots+1)
    A = simple_random_matrix_of_rank(number_of_pivots,rows=rows,columns=columns,augmented=True)

    #determine if final column is a pivot or not
    is_linear_combo = (columns-1 not in A.pivots())

    return {
        "is_linear_combo": is_linear_combo,
        "veclist": vectorList(A.columns()[:-1]),
        "combovector": column_matrix(A.column(-1)),
        "statement": choice([True,False]),
        "veceq": vectorEquation(A),
        "matrix": A,
        "rref": A.rref(),
        "pivots": A.pivots(),
    }