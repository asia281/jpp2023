fun parity(int x) -> bool {
    return x % 2 == 1;
};


bool par1 = parity(11);

fun parity(int x) -> bool {
    return x % 2 == 0;
};

bool par2 = parity(11);

print(par1, par2);

fun parity(& int x) -> bool {
    x = 5;
    return true;
};

int par3 = 4;
bool par4 = parity(& par3);

print(par3, par4);