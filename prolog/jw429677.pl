% Joanna Wojciechowska 429677
% swipl --goal=wyprawy --stand_alone=true -o wyprawy -c jw429677.pl 


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

find_routes(Rodzaje, Dlugosc, WszystkieTrasy, Start, Koniec) :-
    dolaczTrase(WszystkieTrasy, Rodzaje, [], 0, Dlugosc, Start, Koniec, ZnalezioneTrasy),
    wyswietlMultiTrasy(ZnalezioneTrasy).

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

dolaczTrase(_, _, [], _, _, _, _, _).

dolaczTrase(_, _, Sciezka, Suma, Dlugosc, NastStart, Koniec, [(Sciezka, Suma)|Rest]) :- 
    writeln(Sciezka),
    Koniec is NastStart,
    sprawdzDlugosc(Dlugosc, Suma),
    \+member((Sciezka, Suma), Rest).

dolaczTrase(WszystkieTrasy, Rodzaje, [Trasa|AktSciezka], Suma, Dlugosc, NastStart, Koniec, Acc) :- 
    dolaczTrase(WszystkieTrasy, Rodzaje, AktSciezka, PrevSuma, Dlugosc, Start, Koniec, Acc),
    member(Trasa, WszystkieTrasy),
    \+member(Trasa, AktSciezka),
    Trasa = trasa(_, Start, NastStart, Rodzaj, _, Km),
    Suma is PrevSuma + Km,
    member(Rodzaj, Rodzaje).



findalll(Pr, Acc, L) :- call(Pr, X), \+(member(X, Acc)), !, findalll(Pr, [X|Acc], L).
findalll(_, L, L).
findallll(Predykat, Lista) :- findalll(Predykat, [], Lista).


wyswietlMultiTrasy([]).
wyswietlMultiTrasy([(Trasa, Suma)|Trasy]) :- 
    wyswietlTrasy(Trasa, Suma),
    wyswietlMultiTrasy(Trasy).

wyswietlTrasy([], Dlugosc) :-
    format('~nDlugosc trasy: ~w.~n', [Dlugosc]).
wyswietlTrasy([Trasa|Trasy], Dlugosc) :-
    Trasa = trasa(Tid, Start, Koniec, Rodzaj, _, _),
    format('~w -(~w,~w)-> ~w', [Start, Tid, Rodzaj, Koniec]),
    wyswietlTrasy(Trasy, Dlugosc).