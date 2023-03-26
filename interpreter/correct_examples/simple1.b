int x;
x = 2;
bool y = x < 5;
if (y) {
	x = x + 2;
}
else {
	if (not true) {
		x = x + 1;
	}
	else{
		x = x - 1;
	}
};
print (x + 1);
print ("\n");

while (x + 2 < 10) {
	x = x + 1;
}

print(x);