load("__common__.sage")

def generator():
    invertible = choice([true,false])
    if invertible:
        A=simple_random_matrix_of_rank(4,rows=4,columns=4)
    else:
        A=simple_random_matrix_of_rank(choice([2,3]),rows=4,columns=4)

    return {
      "name": choice(["A","B","C","M","N","P","Q"]),
      "matrix": A,
      "rref": A.rref(),
      "invertible": invertible
    }
