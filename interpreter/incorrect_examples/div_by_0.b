//  9 (obsługa błędów wykonania) ZeroDivisionException

int x = 10 / 0;
int y = 0;

int z = 5 % y;

fun div(int a, int b) -> int {
    return a / b
}

int u = div(4, y);

print(x, z, u);

