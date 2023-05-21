% Joanna Wojciechowska 429677

:- ensure_loaded(library(lists)).

wyprawy :- 
    current_prolog_flag(argv, [FileName|_]),
    readFile(FileName, Edges),
    writeln(Edges),
    readAll(Edges).

readFile(FileName, Edges) :-
    open(FileName, read, Stream),
    readEdges(Stream, Edges),
    close(Stream).

readEdges(Stream, []) :-
    at_end_of_stream(Stream).

readEdges(Stream, [Edge | Edges]) :-
    read(Stream, Edge),
    readEdges(Stream, Edges).

readAll(Edges) :-
    write('Podaj miejsce startu: '), 
    read(Source),
    Source \= koniec,
    write('Podaj miejsce koncowe: '),
    read(Destination),
    Destination \= koniec,
    !,
    parseConditions(Length, Types),
    find_all_paths(Edges, Source, Destination, Types, Length, FoundRoutes),
    printMultiRoutes(FoundRoutes),
    readAll(Edges). 

readAll(_) :- writeln('Koniec programu. Milych wedrowek!').

parseConditions(Length, Types) :- 
    write('Podaj warunki: '),
    read(Cond),
    readConditions(Cond, Conditions),
    checkConditions(Conditions, 0),
    !,
    separateConditions(Conditions, Length, Types),
    writeln(Length),
    writeln(Types).

separateConditions([], nil, []).
separateConditions([rodzaj(R)|Conditions], Length, [R|Types]) :-
    separateConditions(Conditions, Length, Types).

separateConditions([dlugosc(A, B)|Conditions], dlugosc(A, B), Types) :-
    separateConditions(Conditions, nil, Types).

parseConditions(Conditions) :- 
    writeln('Podaj jeszcze raz.'),    
    parseConditions(Conditions).

readConditions(nil, []).
readConditions((Cond, Conditions), [Cond|Acc]) :-
    !,
    readConditions(Conditions, Acc).
readConditions(X, [X]).

checkConditions([], _).
checkConditions([rodzaj(_)|Conditions], N) :- 
    !, checkConditions(Conditions, N).

checkConditions([dlugosc(Comp, Num)|Conditions], 0) :-
    checkComp(Comp),
    number(Num),
    Num >= 0,
    !, checkConditions(Conditions, 1).

checkConditions([BadCond|_], _) :-
    write('Error: niepoprawny warunek - '), write(BadCond), nl,
    fail.

checkComp(eq).
checkComp(lt).
checkComp(le).
checkComp(gt).
checkComp(ge).

checkLength(dlugosc(eq, K), K).
checkLength(nil, _).
checkLength(dlugosc(lt, K), Km) :- Km < K.
checkLength(dlugosc(le, K), Km) :- Km =< K.
checkLength(dlugosc(gt, K), Km) :- Km > K.
checkLength(dlugosc(ge, K), Km) :- Km >= K.

find_path(Edges, nil, nil, Types, Length, _, ([Route], Sum)) :-
    member(Route, Edges),
    Route = trasa(_, _, _, Type, _, Sum),
    checkLength(Length, Sum),
    memberOrEmpty(Type, Types).

find_path(Edges, Source, nil, Types, Length, PrevSum, ([Route], Sum)) :-
    member(Route, Edges),
    Route = trasa(_, Source, _, Type, _, Km),
    Sum is PrevSum + Km,
    checkLength(Length, Sum),
    memberOrEmpty(Type, Types).

find_path(Edges, nil, Destination, Types, Length, _, ([Route], Km)) :-
    member(Route, Edges),
    Route = trasa(_, _, Destination, Type, _, Km),
    checkLength(Length, Km),
    memberOrEmpty(Type, Types).

find_path(Edges, Source, Destination, Types, Length, PrevSum, ([Route], Sum)) :-
    member(Route, Edges),
    Route = trasa(_, Source, Destination, Type, _, Km),
    Sum is PrevSum + Km,
    checkLength(Length, Sum),
    memberOrEmpty(Type, Types).

find_path(Edges, nil, Destination, Types, Length, PrevSum, ([Route|Path], Sumcc)) :-
    member(Route, Edges),
    Route = trasa(_, _, Intermediate, Type, _, Km),
    memberOrEmpty(Type, Types),
    Intermediate \== Destination,
    Sum is PrevSum + Km,
    find_path(Edges, Intermediate, Destination, Types, Length, Sum, (Path, Sumcc)).

% Recursive case: Find a path from Source to Destination
find_path(Edges, Source, Destination, Types, Length, PrevSum, ([Route|Path], Sumcc)) :-
    member(Route, Edges),
    Route = trasa(_, Source, Intermediate, Type, _, Km),
    memberOrEmpty(Type, Types),
    Intermediate \== Destination,
    Sum is PrevSum + Km,
    find_path(Edges, Intermediate, Destination, Types, Length, Sum, (Path, Sumcc)).

memberOrEmpty(_, []).
memberOrEmpty(A, B) :- 
    member(A, B).

% Find all paths between Source and Destination
find_all_paths(Edges, Source, Destination, Types, Length, FoundRoutes) :-
    findalll(find_path(Edges, Source, Destination, Types, Length, 0), FoundRoutes).

findalll(Pr, Acc, L) :- call(Pr, X), \+(member(X, Acc)), !, findalll(Pr, [X|Acc], L).
findalll(_, L, L).
findalll(Condition, FoundRoutes) :- findalll(Condition, [], FoundRoutes).

% printa wszystkie znalezione Routes.
printMultiRoutes([]).
printMultiRoutes([(Route, Sum)|Routes]) :- 
    printRoutes(Route, Sum),
    printMultiRoutes(Routes).

% printa pojedyncza trase.
printRoutes([Route|[]], Length) :-
    Route = trasa(Tid, Source, Destination, Type, _, _),
    format('~w -(~w,~w)-> ~w~nDlugosc trasy: ~w.~n', [Source, Tid, Type, Destination, Length]).

printRoutes([Route|Routes], Length) :-
    Route = trasa(Tid, Source, _, Type, _, _),
    format('~w -(~w,~w)-> ', [Source, Tid, Type]),
    printRoutes(Routes, Length).