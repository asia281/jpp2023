# 01 (dwa typy) int, bool
# 02 (arytmetyka, porównania)
# 03 (zmienne, przypisanie)
# 04 (print)
# 05 (while, if)

int x;
x = 6;
bool y = x < 5;
if (y) {
	x = x + 2;
}
else {
	if (not true) {
		x = x + 1;
	}
	else{
		x = 2*x - 1;
	}
}

print (x - 1);
print ("\n");

while (x - 1 < 15) {
	x = x + 1;
}

print(x);