% Joanna Wojciechowska 429677

:- ensure_loaded(library(lists)).

wyprawy :- 
    current_prolog_flag(argv, [Sciezka|_]),
    wczytajPlik(Sciezka, WszystkieTrasy),
    writeln(WszystkieTrasy),
    readAll(WszystkieTrasy).

wczytajPlik(NazwaPliku, Trasy) :-
    open(NazwaPliku, read, Strumien),
    wczytajTrasy(Strumien, Trasy),
    close(Strumien).

wczytajTrasy(Strumien, []) :-
    at_end_of_stream(Strumien).

wczytajTrasy(Strumien, [Trasa | Trasy]) :-
    read(Strumien, Trasa),
    wczytajTrasy(Strumien, Trasy).

readAll(WszystkieTrasy) :-
    write('Podaj miejsce startu: '), 
    read(Start),
    Start \= koniec,
    write('Podaj miejsce koncowe: '),
    read(Koniec),
    Koniec \= koniec,
    !,
    parseWarunki(Dlugosc, Rodzaje),
    find_routes(WszystkieTrasy, Rodzaje, Dlugosc, Start, Koniec). 

readAll(_) :- write('Koniec programu. Milych wedrowek!'), nl.

find_routes(WszystkieTrasy, Rodzaje, Dlugosc, Start, Koniec) :-
    find_all_paths(WszystkieTrasy, Start, Koniec, Rodzaje, Dlugosc, ZnalezioneTrasy),
    write(ZnalezioneTrasy).
%    wyswietlMultiTrasy(ZnalezioneTrasy).

parseWarunki(Dlugosc, Rodzaje) :- 
    write('Podaj warunki: '),
    read(Wars),
    readWarunki(Wars, Warunki),
    sprawdzWarunki(Warunki, 0),
    !,
    separateWarunki(Warunki, Dlugosc, Rodzaje),
    writeln(Dlugosc),
    writeln(Rodzaje).

separateWarunki([], nil, []).
separateWarunki([rodzaj(R)|Warunki], Dlugosc, [R|Rodzaje]) :-
    separateWarunki(Warunki, Dlugosc, Rodzaje).

separateWarunki([dlugosc(A, B)|Warunki], dlugosc(A, B), Rodzaje) :-
    separateWarunki(Warunki, nil, Rodzaje).

parseWarunki(Warunki) :- 
    writeln('Podaj jeszcze raz.'),    
    parseWarunki(Warunki).

readWarunki(nil, []).
readWarunki((Warunek, Warunki), [Warunek|Acc]) :-
    !,
    readWarunki(Warunki, Acc).
readWarunki(X, [X]).

sprawdzWarunki([], _).
sprawdzWarunki([rodzaj(_)|Warunki], N) :- 
    !, sprawdzWarunki(Warunki, N).

sprawdzWarunki([dlugosc(Comp, Num)|Warunki], 0) :-
    comp(Comp),
    number(Num),
    Num >= 0,
    !, sprawdzWarunki(Warunki, 1).

sprawdzWarunki([ZlyWarunek|_], _) :-
    write('Error: niepoprawny warunek - '), write(ZlyWarunek), nl,
    fail.


comp(eq).
comp(lt).
comp(le).
comp(gt).
comp(ge).

sprawdzDlugosc(dlugosc(eq, K), K).
sprawdzDlugosc(nil, _).
sprawdzDlugosc(dlugosc(lt, K), Km) :- Km < K.
sprawdzDlugosc(dlugosc(le, K), Km) :- Km =< K.
sprawdzDlugosc(dlugosc(gt, K), Km) :- Km > K.
sprawdzDlugosc(dlugosc(ge, K), Km) :- Km >= K.

checkDlugosc(Dlugosc, Trasa) :- 
    sumList(Trasa, Suma),
    sprawdzDlugosc(Dlugosc, Suma).
sumList([], 0).
sumList([trasa(_, _, _, _, _, Km)|Rest], Suma) :- 
    sumList(Rest, PrevSuma),
    Suma is PrevSuma + Km.

memberOrEmpty(_, []) :- !.
memberOrEmpty(A, B) :- 
    member(A, B).

find_path(Edges, Source, Destination, Rodzaje, Dlugosc, [Trasa]) :-
    member(Trasa, Edges),
 %   checkDlugosc(Dlugosc, Trasa),
    Trasa = trasa(_, Source, Destination, Rodzaj, _, _),
    memberOrEmpty(Rodzaj, Rodzaje).

% Recursive case: Find a path from Source to Destination
find_path(Edges, Source, Destination, Rodzaje, Dlugosc, [Trasa|Path]) :-
    member(Trasa, Edges),
    Trasa = trasa(_, Source, Intermediate, Rodzaj, _, _),
    memberOrEmpty(Rodzaj, Rodzaje),
    Intermediate \== Destination,
    find_path(Edges, Intermediate, Destination, Rodzaje, Dlugosc, Path).

% Find all paths between Source and Destination
find_all_paths(Edges, Source, Destination, Rodzaje, Dlugosc, Paths) :-
    bagof(Path, find_path(Edges, Source, Destination, Rodzaje, Dlugosc, Path), Paths).

findalll(Pr, Acc, L) :- call(Pr, X), \+(member(X, Acc)), !, findalll(Pr, [X|Acc], L).
findalll(_, L, L).
findallll(Predykat, Lista) :- findalll(Predykat, [], Lista).

% Wyswietla wszystkie znalezione trasy.
wyswietlMultiTrasy([]).
wyswietlMultiTrasy([(Trasa, Suma)|Trasy]) :- 
    wyswietlTrasy(Trasa, Suma),
    wyswietlMultiTrasy(Trasy).

% Wyswietla pojedyncza trase.
wyswietlTrasy([], Dlugosc) :-
    format('~nDlugosc trasy: ~w.~n', [Dlugosc]).

wyswietlTrasy([Trasa|Trasy], Dlugosc) :-
    Trasa = trasa(Tid, Start, Koniec, Rodzaj, _, _),
    format('~w -(~w,~w)-> ~w', [Start, Tid, Rodzaj, Koniec]),
    wyswietlTrasy(Trasy, Dlugosc).