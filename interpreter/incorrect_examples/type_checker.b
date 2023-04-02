//  12 (statyczne typowanie)

int v1 = false;
bool v2 = 3;
int v3 = 2 < 4;

fun fun_string() -> string{
    return "hiii";
};

int v4 = fun_string();

fun fun_int(int x) -> int{
    return x + 1;
};

bool v5 = fun_int(4);

fun fun_bool(bool a) -> bool{
    return not a;
};

string v6 = fun_bool(true);
bool v7 = false;
int v8 = fun_bool(v7);

fun fun_void_1(int y) -> void {};
test(v7);

fun fun_void_2(& int y) -> void { };
fun_void_2(& v7)