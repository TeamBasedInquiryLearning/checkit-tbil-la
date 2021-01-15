load("__common__.sage")

def generator():
    # create a mxn standard matrix
#    columns = randrange(3,5)
#    rows = choice([7,8])-columns
#    A = random_matrix(QQ,rows,columns,algorithm='echelonizable',rank=choice([min(rows,columns),min(rows,columns)-1]),upper_bound=9)
    
    injective = choice([true,false])
    surjective = choice([true,false])
    
    rank = randrange(3,5)
    if injective and surjective:
        A = simple_random_matrix_of_rank(rank,rows=rank,columns=rank)
    elif injective and not surjective:
        A = simple_random_matrix_of_rank(rank,rows=choice([rank+1,rank+2]),columns=rank)
    elif not injective and surjective:
        A = simple_random_matrix_of_rank(rank,rows=rank, columns=choice([rank+1,rank+2]))
    elif not injective and not surjective:
        A = simple_random_matrix_of_rank(rank,rows=choice([rank+1,rank+2]), columns=choice([rank+1,rank+2]))


#    if len(A.pivots())==columns:
#        injective=true
#    else:
#        injective=false
#
#    if len(A.pivots())==rows:
#        surjective=true
#    else:
#        surjective=false

    return {
      "matrix": A,
      "columns": A.ncols(),
      "rows": A.nrows(),
      "rref": A.rref(),
      "injective": injective,
      "surjective": surjective
    }
