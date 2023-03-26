fun square(int x) -> int {
    return x*x;
};

fun isEven(int x) -> bool {
    return x % 2 == 0;
};

int x = square(5);
bool y = isEven(x);