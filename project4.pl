% Title:    Block World
% Author:   Regan ODonnell
% Class:    COP4020

% define block1 on surface, and block2 on block1
start([on(b1,surface), on(b2,b1)]).

% the move/4 code
move(Block, Destination, S1, S2) :-
    replace(on(Block, _), on(Block, Destination), S1, TempS),
    replace(on(_, Block), on(surface, Block), TempS, S2),
    write('Moving block '), write(Block), write(' to '), write(Destination), nl.

% defining what it means for block2 to be on the surface
block(Block, Situation) :-
    member(on(Block, _), Situation).

location(surface, Situation) :-
    member(on(_, surface), Situation).
location(Location, Situation) :-
    block(Location, Situation).


location(surface, situation) :-
    member(on(_, surface), situation).
location(location, situation) :-
    blk(location, situation).

% moving 2 blocks
move2(Block, Destination, S1, S2) :-
    block(Block, S1),
    location(Destination, S1),
    move(Block, Destination, S1, S2).

% determine if something is on top of it
clear_top(surface, _).
clear_top(Block, Situation) :-
    \+ (member(on(_, Block), Situation)).

move3(Block, Destination, S1, S2) :-
    clear_top(Block, S1),
    clear_top(Destination, S1),
    move2(Block, Destination, S1, S2).

clear(Block, Situation, Result) :-
    clear_top(Block, Situation),
    Result = Situation.
clear(Block, Situation, Result) :-
    member(on(Above, Block), Situation),
    clear(Above, Situation, TempSituation),
    move2(Above, surface, TempSituation, TempResult),
    clear(Block, TempResult, Result).

start(X), move(b2, surface, X, Y).
