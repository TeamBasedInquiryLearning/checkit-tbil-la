load("__common__.sage")

def generator():
    # create a 4x3 or 3x4 matrix
    rows = randrange(3,5)
    columns = 7-rows
    a,b,c,d = var("a b c d")
    ls = [a,b,c,d][:rows]

    #start with nice RREF
    number_of_pivots = 2
    A = simple_random_matrix_of_rank(number_of_pivots,rows=rows,columns=columns)

    #linear combo
    coeffs = [
        randrange(1,4)*choice([-1,1])
        for _ in range(columns)
    ]
    lin_combo = column_matrix(sum([
        coeffs[p]*A.column(p)
        for p in A.pivots()
    ]))
    if coeffs[A.pivots()[1]]>0:
        sign = "+"
    else:
        sign = ""
    lin_combo_exp = latex(coeffs[A.pivots()[0]]) + \
        latex(column_matrix(A.column(A.pivots()[0]))) + \
        sign + latex(coeffs[A.pivots()[1]]) + \
        latex(column_matrix(A.column(A.pivots()[1])))
    matrix = A.augment(lin_combo, subdivide=True)
    vectors = [
        {
            "v": lin_combo,
            "lin_combo": True,
            "lin_combo_exp": lin_combo_exp,
            "A": matrix,
            "rref": matrix.rref(),
        }
    ]

    # non-linear combo
    non_lin_combo = lin_combo + column_matrix(vector(ZZ, [
        choice([-1,1])
        for _ in range(rows)
    ]))
    while non_lin_combo in A.column_space():
        non_lin_combo += column_matrix(vector(ZZ, [
            choice([-1,1])
            for _ in range(rows)
        ])),
    matrix = A.augment(non_lin_combo, subdivide=True)
    vectors += [
        {
            "v": non_lin_combo,
            "lin_combo": False,
            "A": matrix,
            "rref": matrix.rref(),
        }
    ]

    shuffle(vectors)

    return {
        "ls": ls,
        "veclist": vectorList(A.columns()),
        "vectors": vectors,
        # "combovector": column_matrix(A.column(-1)),
        # "statement": choice([True,False]),
        # "veceq": vectorEquation(A),
        # "matrix": A,
        # "rref": A.rref(),
        # "pivots": A.pivots(),
    }