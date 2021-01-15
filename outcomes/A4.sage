load("__common__.sage")

def generator():
    
    injective = choice([true,false])
    surjective = choice([true,false])
    
    rank = randrange(3,4)
    if injective and surjective:
        A = simple_random_matrix_of_rank(rank,rows=rank,columns=rank)
    elif injective and not surjective:
        A = simple_random_matrix_of_rank(rank,rows=choice([rank+1,rank+2]),columns=rank)
    elif not injective and surjective:
        A = simple_random_matrix_of_rank(rank,rows=rank, columns=choice([rank+1,rank+2]))
    elif not injective and not surjective:
        A = simple_random_matrix_of_rank(rank,rows=choice([rank+1,rank+2]), columns=choice([rank+1,rank+2]))


    return {
      "matrix": A,
      "columns": A.ncols(),
      "rows": A.nrows(),
      "rref": A.rref(),
      "injective": injective,
      "surjective": surjective
    }
