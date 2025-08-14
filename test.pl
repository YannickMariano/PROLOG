% ---------------------------
% Types de crime
% ---------------------------
crime_type(assassinat).
crime_type(vol).
crime_type(escroquerie).

% ---------------------------
% Suspects
% ---------------------------
suspect(john).
suspect(mary).
suspect(alice).
suspect(bruno).
suspect(sophie).

% ---------------------------
% Faits
% ---------------------------

% Faits pour vol
has_motive(john, vol).
was_near_crime_scene(john, vol).
has_fingerprint_on_weapon(john, vol).

% Faits pour assassinat
has_motive(mary, assassinat).
was_near_crime_scene(mary, assassinat).
has_fingerprint_on_weapon(mary, assassinat).

% Faits pour escroquerie
has_motive(alice, escroquerie).
has_bank_transaction(alice, escroquerie).

has_bank_transaction(bruno, escroquerie).
owns_fake_identity(sophie, escroquerie).

% Témoin (facultatif)
eyewitness_identification(mary, assassinat).

% ---------------------------
% Règles
% ---------------------------

% Règle pour vol : coupable si motive + présent sur les lieux + empreinte ou témoin
is_guilty(Suspect, vol) :-
    has_motive(Suspect, vol),
    was_near_crime_scene(Suspect, vol),
    ( has_fingerprint_on_weapon(Suspect, vol)
    ; eyewitness_identification(Suspect, vol)
    ).

% Règle pour assassinat
is_guilty(Suspect, assassinat) :-
    has_motive(Suspect, assassinat),
    was_near_crime_scene(Suspect, assassinat),
    ( has_fingerprint_on_weapon(Suspect, assassinat)
    ; eyewitness_identification(Suspect, assassinat)
    ).

% Règle pour escroquerie : coupable si transaction suspecte ou fausse identité
is_guilty(Suspect, escroquerie) :-
    has_motive(Suspect, escroquerie),
    ( has_bank_transaction(Suspect, escroquerie)
    ; owns_fake_identity(Suspect, escroquerie)
    ).

% ---------------------------
% Programme principal
% ---------------------------
main :-
    writeln('Entrer une requête sous la forme crime(suspect, type).'),
    writeln('Exemple : crime(john, vol).'),
    current_input(Input),
    read(Input, crime(Suspect, CrimeType)),
    (   is_guilty(Suspect, CrimeType) ->
        writeln(guilty)
    ;   writeln(not_guilty)
    ),
    halt.
