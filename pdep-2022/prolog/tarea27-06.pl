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

% Muerte en la mansión Dreadbury (v1.9)
% [Hechos, reglas, predicados, generación, not]

% Armar un programa Prolog que resuelva el siguiente problema lógico:

% Quien mata es porque odia a su víctima y no es más rico que ella. Además, quien mata debe vivir en la mansión Dreadbury.
% Tía Agatha, el mayordomo y Charles son las únicas personas que viven en la mansión Dreadbury.
% Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
% Agatha odia a todos los que viven en la mansión, excepto al mayordomo.
% Quien no es odiado por el mayordomo y vive en la mansión, es más rico que tía Agatha
% El mayordomo odia a las mismas personas que odia tía Agatha.



% El programa debe resolver el problema de quién mató a la tía Agatha. 
% Mostrar la consulta utilizada y la respuesta obtenida.


% Agregar los mínimos hechos y reglas necesarios para poder consultar:
% - Si existe alguien que odie a milhouse.
% - A quién odia charles.
% - El nombre de quien odia a tía Ágatha.
% - Todos los odiadores y sus odiados.
% - Si es cierto que el mayordomo odia a alguien.
% Mostrar las consultas utilizadas para conseguir lo anterior, junto con las respuestas obtenidas.

