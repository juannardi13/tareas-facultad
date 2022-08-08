cantante(megurineLuka).
cantante(hatsuneMiku).
cantante(gumi).
cantante(seeU).
cantante(kaito).

sabeCantar(megurineLuka, nightFever, 4).
sabeCantar(megurineLuka, foreverYoung, 5).
sabeCantar(hatsuneMiku, tellYourWorld, 4).
sabeCantar(gumi, foreverYoung, 4).
sabeCantar(gumi, tellYourWorld, 5).
sabeCantar(seeU, novemberRain, 6).
sabeCantar(seeU, nightFever, 5).

esNovedoso(Cantante) :-
    cantidadCancionesQueSabe(Cantante, Cantidad),
    duracionShowDe(Cantante, DuracionShow),
    Cantidad > 2,
    DuracionShow < 15.

cantidadCancionesQueSabe(Cantante, Cantidad) :-
    sabeCantar(Cantante, _, _),
    findall(Cancion, sabeCantar(Cantante, Cancion, _), Canciones),
    length(Canciones, Cantidad).

duracionShowDe(Cantante, DuracionShow) :-
    sabeCantar(Cantante, _, _),
    findall(Duracion, sabeCantar(Cantante, Cancion, Duracion), DuracionesCanciones),
    sum_list(DuracionesCanciones, DuracionShow).

esAcelerado(Cantante) :-
    cantante(Cantante),
    not((sabeCantar(Cantante, _, Duracion), Duracion > 4)).

% concierto(Nombre, Localidad, CantidadDeFama, TipoDeConcierto).

concierto(mikuExpo, estadosUnidos, 2000, gigante).
concierto(magicalMirai, japon, 3000, gigante).
concierto(vocalektVisions, estadosUnidos, 1000, mediano).
concierto(mikuFest, argentina, 100, pequeño).

puedeParticipar(Cantante, Concierto) :-
    cantante(Cantante),
    cumpleCondiciones(Cantante, Concierto).

cumpleCondiciones(_, hatsuneMiku).

cumpleCondiciones(Cantante, mikuExpo) :-
    cantidadCancionesQueSabe(Cantante, Cantidad),
    duracionShowDe(Cantante, Duracion),
    Cantidad > 2,
    Duracion > 6.

cumpleCondiciones(Cantante, magicalMirai) :-
    cantidadCancionesQueSabe(Cantante, Cantidad),
    duracionShowDe(Cantante, Duracion),
    Cantidad > 3,
    Duracion > 10.

cumpleCondiciones(Cantante, vocalektVisions) :-
    duracionShowDe(Cantante, Duracion),
    Duracion < 9.

cumpleCondiciones(Cantante, mikuFest) :-
    cancionesDeMasDeCuatroMinutos(Cantante, Cantidad),
    Cantidad >= 1.

cancionesMasDeCuatroMinutos(Cantante, Cantidad) :-
    cantante(Cantante),
    findall(Cancion, (sabeCantar(Cantante, Cancion, Duracion), Duracion > 4), Canciones),
    length(Canciones, Cantidad).
    
vocaloidMasFamoso(Cantante) :-
    cantante(Cantante),
    forall(cantante(OtroCantante), tieneMasFama(Cantante, OtroCantante)).

tieneMasFama(Cantante, OtroCantante) :-
    puntosFama(Cantante, Puntos),
    puntosFama(OtroCantante, Puntos1),
    Cantante \= OtroCantante,
    Puntos > Puntos1.

puntosFama(Cantante, Puntos) :-
    cantidadCancionesQueSabe(Cantante, CantidadCanciones),
    puntosDeRecitales(Cantante, PuntosRecitales),
    Puntos is CantidadCanciones * PuntosRecitales.

puntosDeRecitales(Cantante, PuntosRecitales) :-
    puedeParticipar(Cantante, _),
    findall(PuntosFama, (puedeParticipar(Cantante, Recital), concierto(Recital, _, PuntosFama, _)), PuntosRecolectados),
    sum_list(PuntajeRecolectado, PuntosRecitales).




