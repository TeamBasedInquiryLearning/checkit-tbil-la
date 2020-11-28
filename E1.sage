load("__common__.sage")

def generator():
    # create a 3x5 or 4x4 matrix
    rows = randrange(3,5)
    columns = 8-rows

    #start with nice RREF
    max_number_of_pivots = min(rows,columns-1)
    number_of_pivots = randrange(2,max_number_of_pivots+1)
    A = random_matrix(QQ,rows,columns,algorithm='echelonizable',rank=number_of_pivots,upper_bound=9)
    A.subdivide([],[columns-1]) 

    # construct variables
    xs=choice([
      [var("x_"+str(i+1)) for i in range(0,columns-1)],
      [var("x"),var("y"),var("z"),var("zw",latex_name="w")][0:columns-1],
    ])

    # construct system
    system=[A.delete_columns([columns-1]).row(r)*vector(xs)==A.column(-1)[r] for r in range(0,rows)]

    #randomly swap exercise query
    prompt = choice(["system","matrix","vector"])

    return {
        "system": latex_system_from_matrix(A,variable_list=xs),
        "alignCols": A.ncols(),
        "matrix": A, 
        "vectorequation": vectorEquation(A),
        "prompt": prompt
    }