% Joanna Wojciechowska 429677

:- ensure_loaded(library(lists)).

wyprawy :- 
    current_prolog_flag(argv, [FileName|_]),
    open(FileName, read, Stream),
    readEdges(Stream, PrevEdges),
    close(Stream),
    parseEdges(PrevEdges, Edges),
    readAndFind(Edges).

% Read edges from file.
readEdges(Stream, []) :-
    at_end_of_stream(Stream).

readEdges(Stream, [Edge | Edges]) :-
    read(Stream, Edge),
    readEdges(Stream, Edges).

parseEdges([], []).
parseEdges([end_of_file], []).
parseEdges([trasa(Tid, Source, Destination, Type, oba, Km)|Rest], [Added1,Added2|Acc]) :- 
    Added1 = edge(Tid, Source, Destination, Type, Km),
    Added2 = edge(Tid, Destination, Source, Type, Km),
    parseEdges(Rest, Acc).

parseEdges([trasa(Tid, Source, Destination, Type, jeden, Km)|Rest], [Added|Acc]) :- 
    Added = edge(Tid, Source, Destination, Type, Km),
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
    !.

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

% Check dlugosc condition and append it to accumulator.
checkConditions([dlugosc(Comp, N)|Conditions], 0, dlugosc(Comp, N), Types) :-
    checkComp(Comp),
    number(N), N >= 0,
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

checkCondsNotLen(Edge, Vis, Type, Types) :- 
    \+ member(Edge, Vis),
    checkType(Type, Types).

checkAllConds(Edge, Vis, Length, Sum, Type, Types) :- 
    checkLength(Length, Sum),
    checkCondsNotLen(Edge, Vis, Type, Types).

% Find any edge.
findPath(Edges, nil, nil, Types, Length, 0, Vis, ([Edge], Sum)) :-
    member(Edge, Edges),
    Edge = edge(_, _, _, Type, Sum),
    checkAllConds(Edge, Vis, Length, Sum, Type, Types).

% Find an edge from Source.
findPath(Edges, Source, nil, Types, Length, PrevSum, Vis, ([Edge], Sum)) :-
    member(Edge, Edges),
    Edge = edge(_, Source, _, Type, Km),
    Sum is PrevSum + Km,
    checkAllConds(Edge, Vis, Length, Sum, Type, Types).

% Find an edge to Destination.
findPath(Edges, nil, Destination, Types, Length, 0, Vis, ([Edge], Sum)) :-
    member(Edge, Edges),
    Edge = edge(_, _, Destination, Type, Sum),
    checkAllConds(Edge, Vis, Length, Sum, Type, Types).

% Find an edge from Source to Destination.
findPath(Edges, Source, Destination, Types, Length, PrevSum, Vis, ([Edge], Sum)) :-
    member(Edge, Edges),
    Edge = edge(_, Source, Destination, Type, Km),
    Sum is PrevSum + Km,
    checkAllConds(Edge, Vis, Length, Sum, Type, Types).

% Find a path to Destination.
findPath(Edges, nil, Destination, Types, Length, PrevSum, Vis, ([Edge|Path], Sumcc)) :-
    Edge = edge(_, _, Intermediate, Type, Km),
    member(Edge, Edges),
    Intermediate \== Destination,
    Sum is PrevSum + Km,
    checkCondsNotLen(Edge, Vis, Type, Types),
    findPath(Edges, Intermediate, Destination, Types, Length, Sum, [Edge|Vis], (Path, Sumcc)).

% Find a path from Source to Destination.
% Stores sum of edges until now in PrevSum and visited edges in Vis.
findPath(Edges, Source, Destination, Types, Length, PrevSum, Vis, ([Edge|Path], Sumcc)) :-
    member(Edge, Edges),
    Edge = edge(_, Source, Intermediate, Type, Km),
    Intermediate \== Destination,
    Sum is PrevSum + Km,
    checkCondsNotLen(Edge, Vis, Type, Types),
    findPath(Edges, Intermediate, Destination, Types, Length, Sum, [Edge|Vis], (Path, Sumcc)).

% Check if route has a given type.
checkType(_, []).
checkType(Type, L) :- member(Type, L).

% Find all paths between Source and Destination
findPaths(Edges, Source, Destination, Types, Length, FoundRoutes) :-
    findalll(findPath(Edges, Source, Destination, Types, Length, 0, []), FoundRoutes).

findalll(Pr, Acc, L) :- call(Pr, X), \+(member(X, Acc)), !, findalll(Pr, [X|Acc], L).
findalll(_, L, L).
findalll(Condition, FoundRoutes) :- findalll(Condition, [], FoundRoutes).

% Print all found routes.
printMultiRoutes([]).
printMultiRoutes([(Route, Sum)|Routes]) :- 
    printRoutes(Route, Sum),
    printMultiRoutes(Routes).

% Print single route.
printRoutes([Edge|[]], Sum) :-
    Edge = edge(Tid, Source, Destination, Type, _),
    format('~w -(~w,~w)-> ~w~nDlugosc trasy: ~w.~n', 
    [Source, Tid, Type, Destination, Sum]).

printRoutes([Edge|Routes], Sum) :-
    Edge = edge(Tid, Source, _, Type, _),
    format('~w -(~w,~w)-> ', [Source, Tid, Type]),
    printRoutes(Routes, Sum).