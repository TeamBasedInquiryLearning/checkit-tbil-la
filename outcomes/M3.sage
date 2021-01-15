load("__common__.sage")

def generator():
    A=random_matrix(QQ,4,4,algorithm='echelonizable',rank=choice([choice([2,3]),4]),upper_bound=9)
    if A.rank()==4:
        invertible=true
    else:
        invertible=false

    return {
      "name": choice(["A","B","C","M","N","P","Q"]),
      "matrix": A,
      "rref": A.rref(),
      "invertible": invertible
    }
