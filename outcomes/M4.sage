load("__common__.sage")

def generator():
    A=random_matrix(QQ,4,4,algorithm='echelonizable',rank=4,upper_bound=9)

    return {
      "name": choice(["A","B","C","M","N","P","Q"]),
      "matrix": A,
      "inverse": A.inverse()
    }

