load("__common__.sage")

def generator():
    # random row scaling
    row = randrange(0,4)
    scale = randrange(2,6)*choice([-1,1])
    scale_matrix = identity_matrix(4).with_rescaled_row(row,scale)
    scale_op = rowOp("diagonal",row+1,row+1,scale)
    # random row swapping
    rows = sample([0,1,2,3],2)
    shuffle(rows)
    swap_matrix = identity_matrix(4).with_swapped_rows(rows[0],rows[1])
    swap_op = rowOp("permutation",rows[0]+1, rows[1]+1)
    # random row adding 
    rows = sample([0,1,2,3],2)
    shuffle(rows)
    scale = randrange(2,6)*choice([-1,1])
    add_matrix = identity_matrix(4).with_added_multiple_of_row(rows[0],rows[1],scale)
    add_op = rowOp("elementary",rows[0]+1,rows[1]+1,scale)

    #choose two random ops
    ops = sample([0,1,2],2)
    shuffle(ops)
    row_op1 = [scale_op,swap_op,add_op][ops[0]]
    mat1 = [scale_matrix,swap_matrix,add_matrix][ops[0]]
    row_op2 = [scale_op,swap_op,add_op][ops[1]]
    mat2 = [scale_matrix,swap_matrix,add_matrix][ops[1]]


    name1, name2 = sample(["B","C","M","N","P","Q"],2)

    #randomly swap order of ops
    swapped = choice([True,False])


    return {
      "row_op1": row_op1,
      "row_op2": row_op2,
      "mat1": mat1,
      "mat2": mat2,
      "name1": name1,
      "name2": name2,
      "swapped": swapped
    }


