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


