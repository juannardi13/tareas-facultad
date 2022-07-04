% Simulacro Parcial - EscaPdeP

% Base de conocimientos

%persona(Apodo, Edad, Peculiaridades).
persona(ale, 15, [claustrofobia, cuentasRapidas, amorPorLosPerros]).
persona(agus, 25, [lecturaVeloz, ojoObservador, minuciosidad]).
persona(fran, 30, [fanDeLosComics]).
persona(rolo, 12, []).

%esSalaDe(NombreSala, Empresa).
esSalaDe(elPayasoExorcista, salSiPuedes).
esSalaDe(socorro, salSiPuedes).
esSalaDe(linternas, elLaberintoso).
esSalaDe(guerrasEstelares, escapepepe).
esSalaDe(fundacionDelMulo, escapepepe).

%terrorifica(CantidadDeSustos, EdadMinima).
%familiar(Tematica, CantidadDeHabitaciones).
%enigmatica(Candados).

%sala(Nombre, Experiencia).
sala(elPayasoExorcista, terrorifica(100, 18)).
sala(socorro, terrorifica(20, 12)).
sala(linternas, familiar(comics, 5)).
sala(guerrasEstelares, familiar(futurista, 7)).
sala(fundacionDelMulo, enigmatica([combinacionAlfanumerica, deLlave, deBoton])).

% Punto 1

nivelDeDificultadDeLaSala(Sala, Dificultad) :-
    sala(Sala, terrorifica(CantidadDeSustos, EdadMinima)),
    Dificultad is CantidadDeSustos - EdadMinima.

nivelDeDificultadDeLaSala(Sala, 15) :-
    sala(Sala, familiar(futuristica, _)).

nivelDeDificultadDeLaSala(Sala, Dificultad) :-
    sala(Sala, familiar(Tematica, Dificultad)),
    Tematica \= futuristica.

nivelDeDificultadDeLaSala(Sala, Dificultad) :-
    sala(Sala, enigmatica(Candados)),
    length(Dificultad, Candados),

%Punto 2

puedeSalir(Persona, Sala) :-
    not(esClaustrofobica(Persona)),
    nivelDeDificultadDeLaSala(Sala, 1).

puedeSalir(Persona, Sala) :-
    not(esClaustrofobica(Persona)),
    edad(Persona, Edad),
    nivelDeDificultadDeLaSala(Sala, Dificultad),
    Edad > 13,
    Dificultad < 5.

esClaustrofobica(persona(_, _, Peculiaridades)) :-
    member(claustrofobia, Peculiaridades).

edad(persona(_, Edad, _), Edad).

% Punto 3

tieneSuerte(Persona, Sala) :-
    puedeSalir(Persona, Sala),
    noTienePeculiaridades(Persona).

noTienePeculiaridades(persona(_, _, [])).

% Punto 4

esMacabra(Empresa) :-
    forall(esSalaDe(NombreSala, Empresa), esTerrorifica(NombreSala)).

esTerrorifica(sala(_, terrorifica(_, _))).

% Punto 5

esCopada(Empresa) :-
    not(esMacabra(Empresa)),
    promedioDeDificultad(Empresa, Dificultad),
    Dificultad < 4.

promedioDeDificultad(Empresa, Dificultad) :-
    cantidadDeSalas(Empresa, CantidadSalas),
    sumatoriaDificultades(Empresa, Dificultades),
    Dificultad is Dificultades / CantidadSalas.

cantidadDeSalas(Empresa, CantidadSalas) :-
    findall(Salas, esSalaDe(Sala, Empresa), CantidadSalas).


sumatoriaDificultades(Empresa, Dificultades) :-
    esSalaDe(Empresa, Salas),
    findall(Dificultad, nivelDeDificultadDeLaSala(Salas, Dificultad), DificultadesSalas),
    sum_list(DificultadesSalas, Dificultades).

% Punto 6

% empresa(NombreEmpresa, Salas).

empresa(supercelula, [estrellasDePelea, choqueDeLaRealeza]).
empresa(skPista, [miseriaDeLaNoche]).
empresa(vertigo, []).

sala(estrellasDePelea, familiar(videojuegos, 7)).
sala(choqueDeLaRealeza, familiar(videojuegos, _)).
sala(miseriaDeLaNoche, terrorifica(150, 21)).
