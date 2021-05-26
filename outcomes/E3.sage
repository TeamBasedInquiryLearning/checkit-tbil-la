load("__common__.sage")

def generator():
    # create a 4x4 or 5x3 matrix
    rows = randrange(3,5)
    columns = 8-rows

    #start with nice RREF
    max_number_of_pivots = min(rows,columns) 
    number_of_pivots = randrange(2,max_number_of_pivots+1)
    A = simple_random_matrix_of_rank(number_of_pivots,rows=rows,columns=columns,augmented=True)

    #Choose prompt
    prompt = choice(["system","vectoreq"])

    # Get RREF
    rref = copy(A.echelon_form())


    return {
        'system': latex_system_from_matrix(A),
        'matrix': A,
        'rref': rref,
        'solution': latex_solution_set_from_matrix(A),
        'prompt_system': prompt=='system',
        'prompt_vectoreq': prompt=='vectoreq',
        'vectoreq': vectorEquation(A)
    }
