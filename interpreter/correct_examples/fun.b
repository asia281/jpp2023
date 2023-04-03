# 04 (print)
# 06 (procedury lub funkcje, rekurencja)
# 07 (przez zmienną / przez wartość)
# 11 (funkcje zwracające wartość)

fun square(int x) -> int {
    return x * x;
};

fun isEven(int x) -> bool {
    return x % 2 == 0;
};

int x = square(5);
bool y = isEven(x);

fun printer(Fun< bool->int > cond) -> void{
	int i;
	for(i from -5 to 5){
		if (cond(i)){
			print(i);
			print(" ");
		};
	};	
};

printer(isEven);


