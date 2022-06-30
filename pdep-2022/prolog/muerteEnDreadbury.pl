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

viveEnLaMansion(agatha).
viveEnLaMansion(mayordomo).
viveEnLaMansion(charles).

mata(Asesino, Asesinado) :- 
    odia(Asesino, Asesinado),
    not(esMasRico(Asesino, Asesinado)),
    viveEnLaMansion(Asesino).

odia(charles, Odiado) :-    
    viveEnLaMansion(Odiado),
    not(odia(agatha, Odiado)).

odia(agatha, Odiado) :-
    viveEnLaMansion(Odiado),
    Odiado \= mayordomo.

odia(mayordomo, Odiado) :-  
    odia(agatha, Odiado).

esMasRico(MasRico, agatha) :-
    not(odia(mayordomo, MasRico)),
    viveEnLaMansion(MasRico).

% Consultas:

% ?- mata(Alguien, agatha).         //  Alguien = agatha ; false.

% ?- odia(Alguien, milhouse).     //    false.
% ?- odia(charles, Alguien).     //     Alguien = mayordomo ; false.
% ?- odia(Nombre, agatha).      //      Nombre = agatha ; Alguien = mayordomo.
% ?- odia(Odiador, Odiado).    //       Odiador = charles, Odiado = mayordomo ; Odiador = Odiado, Odiado = agatha ; Odiador = agatha, Odiado = charles ; Odiador = mayordomo, Odiado = agatha ; Odiador = mayordomo, Odiado = charles.
% ?- odia(mayordomo, _).      //        true; true.
