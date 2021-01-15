load("__common__.sage")

def generator():
    A=simple_random_matrix_of_rank(4,rows=4,columns=4)

    return {
      "name": choice(["A","B","C","M","N","P","Q"]),
      "matrix": A,
      "inverse": A.inverse()
    }

