
# 08 (pętla for)

fun factorial(int x) -> int {
    int i;
    int res = 1;
    for (i from 1 to x){
        res = res * i;
    }
    return res;
}

int fac = factorial(6);
printEndl(fac);

fun mult_3(int x, int exp) -> int {
    int i;
    int res = 1;

    for (i in 1 to x){
        res = res * i;
    }
    return res;
}

int y = pow(2, 4);
print(y);