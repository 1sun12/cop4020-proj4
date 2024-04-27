% Title:    Block World
% Author:   Regan ODonnell
% Class:    COP4020

start([on(b1, surface), on(b2, b1)]).

move(Block, Destination, S1, S2) :-
    select(on(Block, _), S1, Rest),
    append([on(Block, Destination)], Rest, S2),
    write('Moving block '), write(Block), write(' to '), write(Destination).