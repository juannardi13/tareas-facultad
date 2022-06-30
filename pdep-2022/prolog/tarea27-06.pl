% Tarea 27/06

% Sobre la base de conocimientos de la clase queremos saber:
% si una obra le gusta a Gus si es Sandman o la escribió Isaac Asimov. Tiene que ser inversible;
% si conviene contratar un artista si escribió un bestseller o es reincidente. Tiene que ser inversible.
% si una obra es rioplatense, que es cuando la nacionalidad de su artista es platense (Uruguay o Argentina). ¡Ojo con repetir lógica!

leGustaAGus(sandman).
leGustaAGus(Obra) :-
    escribio(isaacAsimov, Obra).

convieneContratarArtista(Artista) :-
    escribio(Artista, Obra).
    esBestSeller(Obra).

convieneContratarArtista(Artista) :-
    escribio(Artista, Obra).
    esReincidente(Obra).

esObraRioplatense(Obra) :-
    escribio(Artista, Obra).
    esRioplatense(Artista).

esRioplatense(Artista) :-
    esDe(uruguay, Artista).

esRioplatense(Artista) :-
    esDe(argentina, Artista).
