% Joanna Wojciechowska 429677
% swipl --goal=wyprawy --stand_alone=true -o wyprawy -c jw429677.pl 


:- ensure_loaded(library(lists)).

wyprawy :-
    current_prolog_flag(argv, [Sciezka|_]),
    wczytajPlik(Sciezka, Trasy),
    write(Trasy), nl,
    write('Podaj miejsce startu: '), read(Start),
    write('Podaj miejsce koncowe: '), read(Koniec),
    write('Podaj warunki: '), read(Warunki),
    (Warunki == koniec -> write('Koniec programu. Milych wedrowek!'), nl, ! ;
     sprawdzWarunki(Warunki),
     find_routes(Trasy, Start, Koniec, Warunki, ZnalezioneTrasy)),
    wyswietlTrasy(ZnalezioneTrasy).
    
wczytajPlik(NazwaPliku, Trasy) :-
    open(NazwaPliku, read, Strumien),
    wczytajTrasy(Strumien, Trasy),
    close(Strumien).

wczytajTrasy(Strumien, []) :-
    at_end_of_stream(Strumien).

wczytajTrasy(Strumien, [Trasa | Trasy]) :-
    read(Strumien, Trasa),
    wczytajTrasy(Strumien, Trasy).

sprawdzWarunki([]).

sprawdzWarunki([Warunek|Warunki]) :-
    functor(Warunek, rodzaj, 1),
    sprawdzWarunki(Warunki).

sprawdzWarunki([Warunek|Warunki]) :-
    functor(Warunek, dlugosc, 2),
    sprawdzWarunki(Warunki).


spelniaWarunki(_, nil).
spelniaWarunki(Trasa, Warunki) :-
    Warunki \= nil, 
    member(rodzaj(Rodzaj), Warunki),
    member(dlugosc(War, K), Warunki),
    Trasa = trasa(_, _, _, Rodzaj, _, Km),
    sprawdzDlugosc(War, K, Km).

sprawdzDlugosc(eq, K, K).
sprawdzDlugosc(lt, K, Km) :- Km < K.
sprawdzDlugosc(le, K, Km) :- Km =< K.
sprawdzDlugosc(gt, K, Km) :- Km > K.
sprawdzDlugosc(ge, K, Km) :- Km >= K.

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
