# 06 (funkcje lub procedury, rekurencja)

fun inc(& int num, int num2) -> void{
	num = num + 1;
	num2 = num2 + 1
};

int x = 10;
int y = 10;

inc(& x, y);

print("x = ");
print(x);
print(", y =");
print(y);