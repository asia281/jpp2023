//  12 (statyczne typowanie)

fun test() -> int{
};

test();

fun string_not_int() -> string{
    return 1;
};

string v1 = string_not_int();

fun int_not_string(string a) -> int{
    return a;
};

int v2 = int_not_string("string");


