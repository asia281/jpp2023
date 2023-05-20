% Joanna Wojciechowska 429677
% swipl --goal=wyprawy --stand_alone=true -o wyprawy -c jw429677.pl 


:- ensure_loaded(library(lists)).

wyprawy :- 
    current_prolog_flag(argv, [Sciezka|_]),
    wczytajPlik(Sciezka, Trasy),
    write(Trasy), nl,
    readAll.

wczytajPlik(NazwaPliku, Trasy) :-
    open(NazwaPliku, read, Strumien),
    wczytajTrasy(Strumien, Trasy),
    close(Strumien).

wczytajTrasy(Strumien, []) :-
    at_end_of_stream(Strumien).

wczytajTrasy(Strumien, [Trasa | Trasy]) :-
    read(Strumien, Trasa),
    wczytajTrasy(Strumien, Trasy).

readAll :-
    write('Podaj miejsce startu: '), 
    read(Start),
    Start \= koniec,
    write('Podaj miejsce koncowe: '),
    read(Koniec),
    Koniec \= koniec,
    !,
    parseWarunki(Warunki).

readAll :- write('Koniec programu. Milych wedrowek!'), nl.

parseWarunki(Warunki) :- 
    write('Podaj warunki: '),
    read(Wars),
    readWarunki(Wars, Warunki),
    sprawdzWarunki(Warunki, 0),
    !.

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
    !,
    sprawdzWarunki(Warunki, N).

sprawdzWarunki([dlugosc(Comp, Num)|Warunki], 0) :-
    comp(Comp),
    number(Num),
    Num >= 0,
    !,
    sprawdzWarunki(Warunki, 1).

sprawdzWarunki([ZlyWarunek|_], _) :-
    write('Error: niepoprawny warunek - '), write(ZlyWarunek), nl,
    fail.


comp(eq).
comp(lt).
comp(le).
comp(gt).
comp(ge).

sprawdzDlugosc(eq, K, K).
sprawdzDlugosc(lt, K, Km) :- Km < K.
sprawdzDlugosc(le, K, Km) :- Km =< K.
sprawdzDlugosc(gt, K, Km) :- Km > K.
sprawdzDlugosc(ge, K, Km) :- Km >= K.

spelniaWarunki(_, nil).
spelniaWarunki(Trasa, Warunki) :-
    Warunki \= nil, 
    member(rodzaj(Rodzaj), Warunki),
    member(dlugosc(War, K), Warunki),
    Trasa = trasa(_, _, _, Rodzaj, _, Km),
    sprawdzDlugosc(War, K, Km).

wyswietlTrasy([]).
wyswietlTrasy([Trasa|Trasy]) :-
    Trasa = trasa(Tid, Start, Koniec, Rodzaj, _, Dlugosc),
    format('~w -(~w,~w)-> ~w~nDlugosc trasy: ~w.~n', [Start, Tid, Rodzaj, Koniec, Dlugosc]),
    wyswietlTrasy(Trasy).


find_all(_, _, Acc).
find_all(Warunki, [Trasa|Y], Acc) :- 
    find_all(Warunki, Y, NewAcc),
    (spelniaWarunki(Trasa, Warunki), Acc = NewAcc + Trasa, Acc = NewAcc).

findalll(Pr, Acc, L) :- call(Pr, X), \+(member(X, Acc)), !, findalll(Pr, [X|Acc], L).
findalll(_, L, L).
findallll(Predykat, Lista) :- findalll(Predykat, [], Lista).

% Predykat znajdujący wyprawy spełniające podane warunki
find_routes(WszystkieTrasy, Start, Koniec, Warunki, ZnalezioneTrasy) :-
    findall(Trasa, (
        member(Trasa, WszystkieTrasy),
        Trasa = trasa(_, Start, Koniec, _, _, _),
        spelniaWarunki(Trasa, Warunki)
    ), ZnalezioneTrasy).
