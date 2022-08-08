% Parcial - El Kioskito

% atiende(Dia, Empleado, horario(HoraEntrada, HoraSalida)).

empleado(dodain).
empleado(lucas).
empleado(juanC).
empleado(juanFdS).
empleado(leoC).
empleado(martu).
empleado(mariu).
empleado(valu).

atiende(lunes, dodain, horario(9, 15)).
atiende(miercoles, dodain, horario(9, 15)).
atiende(martes, lucas, horario(10, 20)).
atiende(sabado, juanC, horario(18, 22)).
atiende(domingo, juanC, horario(18, 22)).
atiende(jueves, juanFdS, horario(10, 20)).
atiende(viernes, juanFdS, horario(12, 20)).
atiende(lunes, leoC, horario(14, 18)).
atiende(miercoles, leoC, horario(14, 18)).
atiende(miercoles, martu, horario(23, 24)).

atiende(sabado, valu, horario(18, 22)).
atiende(domingo, valu, horario(18, 22)).
atiende(lunes, valu, horario(9, 15)).
atiende(miercoles, valu, horario(9, 15)).

atiende(Dia, valu, horario(Horario)) :-
    atiende(Dia, juanC, horario(Horario)).
atiende(Dia, valu, horario(Horario)) :-
    atiende(Dia, dodain, horario(Horario)).

estaPensando(maiu, martes, horario(0, 8)).
estaPensando(maiu, miercoles, horario(0, 8)).

quienAtiende(Dia, Hora, Empleado) :-
    atiende(Dia, Empleado, horario(HoraEntrada, HoraSalida)),
    between(HoraEntrada, HoraSalida, Hora).

foreverAlone(Empleado, Dia, Hora) :-
    quienAtiende(Dia, Hora, Empleado),
    forall(empleado(OtroEmpleado), not(quienAtiende(Dia, Hora, OtroEmpleado))).

posibilidadesDeAtencion(Dia, Empleado) :-
    undefined.

% venta(Empleado, Dia, fecha(NumeroDia, NumeroMes), Ventas).

venta(dodain, lunes, fecha(10, 8), [golosinas(1200)]).
venta(dodain, miercoles, fecha(12, 8), [bebida(alcoholica, 8), bebida(noAlcoholica, 1), golosinas(10)]).
venta(martu, miercoles, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, martes, fecha(11, 8), [golosinas(600)]).
venta(lucas, martes, fecha(18, 8), [bebida(noAlcoholica, 2), cigarrillos([derby])]).

esSuertudo(Empleado) :-
    venta(Empleado, _, _, _),
    forall(venta(Empleado, _, _, [Venta|_]), ventaImportante(Venta)).

ventaImportante(golosinas(Precio)) :-
    Precio > 100.

ventaImportante(cigarrillos(Marcas)) :-
    length(Marcas, CantidadMarcas),
    CantidadMarcas > 2.

ventaImportante(bebida(alcoholica, _)).
ventaImportante(bebida(_, Cantidad)) :-
    Cantidad > 5.

