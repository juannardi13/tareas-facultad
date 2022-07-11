% Simulacro Parcial 11-07

%quedaEn(Boliche, Localidad)
quedaEn(pachuli, generalLasHeras).
quedaEn(why, generalLasHeras).
quedaEn(chaplin, generalLasHeras).
quedaEn(masDe40, sanLuis).
quedaEn(qma, caba).

%entran(Boliche, CapacidadDePersonas)
entran(pachuli, 500).
entran(why, 1000).
entran(chaplin, 700).
entran(masDe40, 1200).
entran(qma, 800).

%sirveComida(Boliche)
sirveComida(chaplin).
sirveComida(qma).

%tematico(tematica)
%cachengue(listaDeCancionesHabituales)
%electronico(djDeLaCasa, horaQueEmpieza, horaQueTermina)

%esDeTipo(Boliche, Tipo)
esDeTipo(why, cachengue([elYYo, prrrram, biodiesel, buenComportamiento])).
esDeTipo(masDe40, tematico(ochentoso)).
esDeTipo(qma, electronico(djFenich, 2, 5)).

% Punto 1

esPiola(Boliche) :-
    sirveComida(Boliche),
    quedaEn(Boliche, generalLasHeras).

esPiola(Boliche) :-
    sirveComida(Boliche),
    esGrande(Boliche).

esGrande(Boliche) :-
    entran(Boliche, CapacidadDePersonas),
    CapacidadDePersonas > 700.

% Punto 2

soloParaBailar(Boliche) :-
    not(sirveComida(Boliche)).

% Punto 3

podemosIrConEsa(Localidad) :-
    quedaEn(Localidad, _),
    forall(quedaEn(Localidad, Boliche), esPiola(Boliche)).

% Punto 4

puntaje(Boliche, 8) :-
    esDeTipo(Boliche, tematico(ochentoso)).

puntaje(Boliche, 7) :-
    esDeTipo(Boliche, tematico(Tematica)).

puntaje(Boliche, Puntaje) :-
    esDeTipo(Boliche, electronico(_, HoraInicio, HoraFinal)),
    Puntaje is HoraInicio + HoraFinal.

puntaje(Boliche, 10) :-
    esDeTipo(Boliche, cachengue(ListaTemas)),
    tieneTemaikenes(ListaTemas).

tieneTemaikenes(ListaTemas) :-
    member(biodiesel, ListaTemas),
    member(buenComportamiento, ListaTemas).

% Salvar y evitar la repetición de lógica.

% Punto 5

elMasGrande(Boliche, Localidad) :-
    quedaEn(Boliche, Localidad),
    quedaEn(OtroBoliche, Localidad),
    forall(quedaEn(OtroBoliche, Localidad), esMasGrande(Boliche, OtroBoliche)),
    OtroBoliche \= Boliche.

esMasGrande(Boliche, OtroBoliche) :-
    entran(Boliche, CapacidadDePersonas1),
    entran(OtroBoliche, CapacidadDePersonas2),
    CapacidadDePersonas1 > CapacidadDePersonas2.

% Punto 6

puedeAbastecer(Localidad, CantidadPersonas) :-
    capacidadTotalDeLocalidad(Localidad, CapacidadLocalidad),
    CapacidadLocalidad >= CantidadPersonas.

capacidadTotalDeLocalidad(Localidad, CapacidadLocalidad) :-
    capacidadesDeBoliches(Localidad, CapacidadesBoliches),
    sum_list(CapacidadesBoliches, CapacidadLocalidad).

capacidadesDeBoliches(Localidad, CapacidadesBoliches) :-
    quedaEn(Localidad, _),
    findall(Capacidades, (quedaEn(Localidad, Boliche), entran(Boliche, Capacidades)), CapacidadesBoliches).

% Punto 7

esDeTipo(trabajamosYNosDivertimos, tematico(oficina)).
esDeTipo(elFinDelMundo, electronico(djLuis, 0, 6)).

sirveComida(trabajamosYNosDivertimos).
sirveComida(misterio).

quedaEn(concordia, trabajamosYNosDivertimos).
quedaEn(ushuaia, elFinDelMundo).

entran(trabajamosYNosDivertimos, 500).
entran(elFinDelMundo, 1500).
entran(misterio, 1000000).
