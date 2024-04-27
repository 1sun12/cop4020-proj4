% Title:    Block World
% Author:   Regan ODonnell
% Class:    COP4020

start([on(b1, surface), on(b2, b1)]).

move(Block, Destination, S1, S2) :-
    select(on(Block, _), S1, Rest),
    append([on(Block, Destination)], Rest, S2),
    write('Moving block '), write(Block), write(' to '), write(Destination).

block(Block, Situation) :-
    member(on(Block, _), Situation).

location(Location, Situation) :-
    (member(on(Location, _), Situation); Location = surface).

move2(Block, Destination, S1, S2) :-
    block(Block, S1),
    location(Destination, S1),
    move(Block, Destination, S1, S2).

clear_top(surface, _).
clear_top(Block, Situation) :-
    \+ (member(on(_, Block), Situation)).

move3(Block, Destination, S1, S2) :-
    clear_top(Block, S1),
    clear_top(Destination, S1),
    move2(Block, Destination, S1, S2).

clear(Block, S1, S2) :-
    clear_top(Block, S1),
    S2 = S1.

clear(Block, S1, S2) :-
    select(on(Block, OnTop), S1, Rest),
    clear(OnTop, Rest, Temp),
    move(Block, surface, Temp, S2).


% Test Start Situation
% ?- start(S).

% Test Move Predicate
% ?- start(S), move(b2, surface, S, NewSituation).

% Test Block and Location Predicates
% ?- start(S), block(Block, S).
% ?- start(S), block(b3, S).
% ?- start(S), block(surface, S).
% ?- start(S), location(Location, S).

% % Test Move2 Predicate
% ?- start(S), move2(b2, surface, S, NewSituation).
% ?- start(S), move2(surface, b1, S, _).
% ?- start(S), move2(b1, table, S, _).

% % Test Clear_Top Predicate
% ?- start(S), clear_top(surface, S).
% ?- start(S), clear_top(b1, S).
% ?- start(S), clear_top(b2, S).

% % Test Move3 Predicate
% ?- start(S), move3(b2, surface, S, _).
% ?- start(S), move3(surface, b1, S, _).

% % Test Clear Predicate
% ?- start(S), clear(b2, S, _).
% ?- start(S), clear(b1, S, _).

% % Test Recursive Clear
% start2([on(b1, surface), on(b2, b1), on(b3, b2)]).
% ?- start2(S), clear(b1, S, _).