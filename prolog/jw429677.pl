% Joanna Wojciechowska 429677

:- ensure_loaded(library(lists)).

wyprawy :- 
    current_prolog_flag(argv, [FileName|_]),
    open(FileName, read, Stream),
    readEdges(Stream, PrevEdges),
    close(Stream),
    parseEdges(PrevEdges, Edges),
    writeln(Edges),
    readAndFind(Edges).

% Read edges from file.
readEdges(Stream, []) :-
    at_end_of_stream(Stream).

readEdges(Stream, [Edge | Edges]) :-
    read(Stream, Edge),
    readEdges(Stream, Edges).

parseEdges([], []).
parseEdges([Trasa|Rest], [Added1,Added2,Added3,Added4,Added5,Added6,Added7|Acc]) :- 
    Trasa = trasa(Tid, Source, Destination, Type, oba, Km),
    Added1 = edge(Tid, nil, Destination, Type, Km),
    Added2 = edge(Tid, nil, Source, Type, Km),
    Added3 = edge(Tid, Source, nil, Type, Km),
    Added4 = edge(Tid, Destination, nil, Type, Km),
    Added5 = edge(Tid, nil, nil, Type, Km),
    Added6 = edge(Tid, Source, Destination, Type, Km),
    Added7 = edge(Tid, Destination, Source, Type, Km),
    parseEdges(Rest, Acc).

parseEdges([Trasa|Rest], [Added1,Added2,Added3,Added4|Acc]) :- 
    Trasa = trasa(Tid, Source, Destination, Type, jeden, Km),
    Added1 = edge(Tid, nil, Destination, Type, Km),
    Added2 = edge(Tid, Source, nil, Type, Km),
    Added3 = edge(Tid, nil, nil, Type, Km),
    Added4 = edge(Tid, Source, Destination, Type, Km),
    parseEdges(Rest, Acc).



% Read input and find all routes satisfying conditions.
readAndFind(Edges) :-
    write('Podaj miejsce startu: '), 
    read(Source),
    Source \== koniec,
    write('Podaj miejsce koncowe: '),
    read(Destination),
    Destination \== koniec,
    !,
    parseConditions(Length, Types),
    findPaths(Edges, Source, Destination, Types, Length, FoundRoutes),
    printMultiRoutes(FoundRoutes),
    readAndFind(Edges). 

readAndFind(_) :- writeln('Koniec programu. Milych wedrowek!').

% Read, parse and check conditions on input.
parseConditions(Length, Types) :- 
    write('Podaj warunki: '),
    read(Cond),
    readConditions(Cond, Conditions),
    checkConditions(Conditions, 0, Length, Types),
    !,
    writeln(Length),
    writeln(Types).

parseConditions(Conditions) :- 
    writeln('Podaj jeszcze raz.'),    
    parseConditions(Conditions).

% Transform tuple of conditions to the list.
readConditions(nil, []).
readConditions((Cond, Conditions), [Cond|Acc]) :- 
    !, readConditions(Conditions, Acc).
readConditions(X, [X]).

checkConditions([], _, nil, []).
% Append rodzaj condition.
checkConditions([rodzaj(R)|Conditions], N, Length, [R|Types]) :- 
    !, checkConditions(Conditions, N, Length, Types).

% Check dlugosc condition and at it to accumulator.
checkConditions([dlugosc(Comp, N)|Conditions], 0, dlugosc(Comp, N), Types) :-
    checkComp(Comp),
    number(N),
    N >= 0,
    !, checkConditions(Conditions, 1, nil, Types).

% Check inncorect condition.
checkConditions([BadCond|_], _, _, _) :-
    format('Error: niepoprawny warunek - ~w~n', [BadCond]),
    fail.

% Check if comparator sign is one of possible ones.
checkComp(eq).
checkComp(lt).
checkComp(le).
checkComp(gt).
checkComp(ge).

% Check dlugosc condition with a total length of a path.
checkLength(dlugosc(eq, K), K).
checkLength(nil, _).
checkLength(dlugosc(lt, K), Km) :- Km < K.
checkLength(dlugosc(le, K), Km) :- Km =< K.
checkLength(dlugosc(gt, K), Km) :- Km > K.
checkLength(dlugosc(ge, K), Km) :- Km >= K.

% Find an edge from Source to Destination.
findPath(Edges, Source, Destination, Types, Length, PrevSum, ([Edge], Sum)) :-
    member(Edge, Edges),
    Edge = edge(_, Source, Destination, Type, Km),
    Sum is PrevSum + Km,
    checkLength(Length, Sum),
    checkType(Type, Types).

% Find a path from Source to Destination.
findPath(Edges, Source, Destination, Types, Length, PrevSum, ([Edge|Path], Sumcc)) :-
    member(Edge, Edges),
    Edge = edge(_, Source, Intermediate, Type, Km),
    checkType(Type, Types),
    Intermediate \== Destination,
    Intermediate \== nil,
    Sum is PrevSum + Km,
    findPath(Edges, Intermediate, Destination, Types, Length, Sum, (Path, Sumcc)),
    \+ member(Edge, Path).

% Check if route has a given type.
checkType(_, []).
checkType(Type, L) :- member(Type, L).

% Find all paths between Source and Destination
findPaths(Edges, Source, Destination, Types, Length, FoundRoutes) :-
    findalll(findPath(Edges, Source, Destination, Types, Length, 0), FoundRoutes).

findalll(Pr, Acc, L) :- call(Pr, X), \+(member(X, Acc)), !, findalll(Pr, [X|Acc], L).
findalll(_, L, L).
findalll(Condition, FoundRoutes) :- findalll(Condition, [], FoundRoutes).

% Print all found routes.
printMultiRoutes([]).
printMultiRoutes([(Route, Sum)|Routes]) :- 
    printRoutes(Route, Sum),
    printMultiRoutes(Routes).

% Print single route.
printRoutes([Edge|[]], Length) :-
    Edge = edge(Tid, Source, Destination, Type, _),
    format('~w -(~w,~w)-> ~w~nDlugosc trasy: ~w.~n', 
    [Source, Tid, Type, Destination, Length]).

printRoutes([Edge|Routes], Length) :-
    Edge = edge(Tid, Source, _, Type, _),
    format('~w -(~w,~w)-> ', [Source, Tid, Type]),
    printRoutes(Routes, Length).