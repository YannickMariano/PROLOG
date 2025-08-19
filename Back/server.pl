:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).

% --------------------------
% Définition des routes HTTP
% ---------------------------
:- http_handler(root(api), handle_request, []).

% ---------------------------
% Démarrer le serveur
% ---------------------------
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% ---------------------------
% Base de connaissances
% ---------------------------
crime_type(assassinat).
crime_type(vol).
crime_type(escroquerie).

suspect(john).
suspect(mary).
suspect(alice).
suspect(bruno).
suspect(sophie).

% Faits
has_motive(john, vol).
was_near_crime_scene(john, vol).
has_fingerprint_on_weapon(john, vol).

has_motive(mary, assassinat).
was_near_crime_scene(mary, assassinat).
has_fingerprint_on_weapon(mary, assassinat).

has_motive(alice, escroquerie).
has_bank_transaction(alice, escroquerie).

has_bank_transaction(bruno, escroquerie).
owns_fake_identity(sophie, escroquerie).

% Témoin
eyewitness_identification(mary, assassinat).

% Règles
is_guilty(Suspect, vol) :-
    has_motive(Suspect, vol),
    was_near_crime_scene(Suspect, vol),
    ( has_fingerprint_on_weapon(Suspect, vol)
    ; eyewitness_identification(Suspect, vol)
    ).

is_guilty(Suspect, assassinat) :-
    has_motive(Suspect, assassinat),
    was_near_crime_scene(Suspect, assassinat),
    ( has_fingerprint_on_weapon(Suspect, assassinat)
    ; eyewitness_identification(Suspect, assassinat)
    ).

is_guilty(Suspect, escroquerie) :-
    has_motive(Suspect, escroquerie),
    ( has_bank_transaction(Suspect, escroquerie)
    ; owns_fake_identity(Suspect, escroquerie)
    ).

% ---------------------------
% Gestion des requêtes HTTP
% ---------------------------

handle_request(Request) :-
    http_parameters(Request, [
        suspect(Suspect, [atom]),
        crime(Crime, [atom])
    ]),
    (   is_guilty(Suspect, Crime)
    ->  Reply = json([result='guilty'])
    ;   Reply = json([result='not_guilty'])
    ),
    format('Access-Control-Allow-Origin: *~n'),  % Autoriser toutes origines
    reply_json(Reply).
