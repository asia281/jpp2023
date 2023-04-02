//  9 (obsługa błędów wykonania) OutOfRangeExeption

ist<int> list;
list::push(0);
list::push(1);
list::push(2);

print(list.len, list.at(4));