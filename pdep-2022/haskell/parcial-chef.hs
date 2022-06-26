--Parcial Pdep - Funcional 06/06/2022 - Juan Nardi - DNI: 43722088 - Legajo: 203892-4.

import Text.Show.Functions()

--Modelado de los participantes y de los platos, con type alias para los ingredientes.

data Participante = UnParticipante {
    nombre       :: String,
    trucos       :: [Truco],
    especialidad :: Plato
} deriving Show

data Plato = UnPlato {
    dificultad  :: Int,
    componentes :: [Ingrediente]
} deriving Show 

type Ingrediente = (Nombre, Cantidad)
type Nombre      = String
type Cantidad    = Int

nombreIngrediente :: Ingrediente -> Nombre --Función usada para darle más expresividad al código
nombreIngrediente unIngrediente = fst unIngrediente

cantidadIngrediente :: Ingrediente -> Cantidad --Función usada para darle más expresividad al código
cantidadIngrediente unIngrediente = snd unIngrediente

-- Parte A - Modelado trucos de cocina y categorización de platos

type Truco = Plato -> Plato

endulzar :: Int -> Truco
endulzar cantidadAzucar unPlato = agregarIngrediente ("Azucar", cantidadAzucar) unPlato

salar :: Int -> Truco
salar cantidadSal unPlato = agregarIngrediente ("Sal", cantidadSal) unPlato

darSabor :: Int -> Int -> Truco
darSabor cantidadSal cantidadAzucar unPlato = salar cantidadSal . endulzar cantidadAzucar $ unPlato

duplicarPorcion :: Truco
duplicarPorcion unPlato = modificarPorcionIngredientes (* 2) unPlato

simplificar :: Truco 
simplificar unPlato 
    | esUnBardo unPlato = cambiarDificultad 5 . quitarComponentesPequeños $ unPlato
    | otherwise         = unPlato

--Funciones auxiliares

agregarIngrediente :: Ingrediente -> Plato -> Plato
agregarIngrediente unIngrediente unPlato = mapComponentes (flip (++) [unIngrediente]) unPlato --Uso del flip para agregar el ingrediente al final de la lista de componentes, por lo que cada vez que se use esta función se agregará el ingrediente al final.
                                                                                              --Para agregar los ingredientes al principio de la lista solo basta con mapComponentes ((++) [unIngrediente]) unPlato
modificarPorcionIngredientes :: (Cantidad -> Cantidad) -> Plato -> Plato
modificarPorcionIngredientes unaFuncion unPlato = mapComponentes (map (cambiarCantidadIngrediente unaFuncion)) unPlato

cambiarCantidadIngrediente :: (Cantidad -> Cantidad) -> Ingrediente -> Ingrediente
cambiarCantidadIngrediente unaFuncion (unNombre, unaCantidad) = (unNombre, unaFuncion unaCantidad)

esUnBardo :: Plato -> Bool
esUnBardo unPlato = ((> 7) . dificultad $ unPlato) && ((> 5) . cantidadComponentes $ unPlato)

cantidadComponentes :: Plato -> Int
cantidadComponentes unPlato = length . componentes $ unPlato

cambiarDificultad :: Int -> Plato -> Plato
cambiarDificultad unaDificultad unPlato 
    | unaDificultad <= 10 && unaDificultad >= 0 = mapDificultad (const unaDificultad) unPlato
    | unaDificultad > 10                        = mapDificultad (const 10) unPlato
    | otherwise                                 = mapDificultad (const 0) unPlato
-- En esta última función se restringe la dificultad para que sea siempre entre 0 y 10.

quitarComponentesPequeños :: Plato -> Plato
quitarComponentesPequeños unPlato = mapComponentes (filter (not . esIngredientePequeño)) unPlato

esIngredientePequeño :: Ingrediente -> Bool
esIngredientePequeño unIngrediente = (< 10) . cantidadIngrediente $ unIngrediente 

--Mappers para evitar la repetición de lógica

mapComponentes :: ([Ingrediente] -> [Ingrediente]) -> Plato -> Plato
mapComponentes unaFuncion unPlato = unPlato { componentes = unaFuncion . componentes $ unPlato }

mapDificultad :: (Int -> Int) -> Plato -> Plato
mapDificultad unaFuncion unPlato = unPlato { dificultad = unaFuncion . dificultad $ unPlato }

--Categorizacion platos

esVegano :: Plato -> Bool
esVegano unPlato = (not . tiene "Carne" $ unPlato) && (not . tiene "Huevos" $ unPlato) && (not . tieneLacteos $ unPlato)

sinTACC :: Plato -> Bool
sinTACC unPlato = not . tiene "Harina" $ unPlato

esComplejo :: Plato -> Bool
esComplejo unPlato = esUnBardo unPlato --Ya que un plato era un bardo si tenía más de 5 componentes y su dificultad era mayor a 7

{-
Podría también definir esComplejo como lo hice con esUnBardo, y al hacerlo debería cambiar la guarda de la línea 46 por 
46|   | esComplejo unPlato = cambiarDificultad 5 . quitarComponentesPequeños $ unPlato

Entonces debería desaparecer la funcion esUnBardo y quedar:

esComplejo :: Plato -> Bool
esComplejo unPlato = ((> 7) . dificultad $ unPlato) && ((> 5) . cantidadComponentes $ unPlato)

También podría dejar ambas funciones definidas igual por si en algún momento cambian los requerimientos para que un plato
sea un bardo o sea complejo y poder cambiarlo facilmente por separado.
-}

noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = (> 2) . sum . mostrarGramaje . ingredientesSalados $ unPlato

--Funciones auxiliares

tiene :: String -> Plato -> Bool
tiene unIngrediente unPlato = any ((== unIngrediente) . nombreIngrediente) (componentes unPlato)

tieneLacteos :: Plato -> Bool --Terminar
tieneLacteos unPlato = any esLacteo (componentes unPlato)

lacteos :: [Nombre]
lacteos = ["Leche", "Manteca", "Yogurth", "Queso"]

esLacteo :: Ingrediente -> Bool
esLacteo unIngrediente = elem (nombreIngrediente unIngrediente) lacteos

ingredientesSalados :: Plato -> [Ingrediente]
ingredientesSalados unPlato = filter ((== "Sal") . nombreIngrediente) (componentes unPlato) 

mostrarGramaje :: [Ingrediente] -> [Cantidad]
mostrarGramaje listaDeIngredientes = map cantidadIngrediente listaDeIngredientes --Muestra solamente las cantidades de cada ingrediente

--Parte B (Modelar a PEPE y a su PLATO)

pepe :: Participante
pepe = UnParticipante{
    nombre       = "Pepe Ronccino", 
    trucos       = trucosPepe,
    especialidad = platoPepe
}

trucosPepe :: [Truco]
trucosPepe = [darSabor 2 5, simplificar, duplicarPorcion]

platoPepe :: Plato
platoPepe = UnPlato {
    dificultad  = 9,
    componentes = componentesPlatoPepe
}

componentesPlatoPepe :: [Ingrediente]
componentesPlatoPepe = [("Sal", 5), ("Azucar", 3), ("Leche", 100), ("Carne", 150), ("Pan rallado", 80), ("Huevos", 50)]

--Parte C

cocinar :: Plato -> Participante -> Plato
cocinar unPlato unParticipante = aplicarTrucosDe unParticipante . especialidad $ unParticipante

esMejorQue :: Plato -> Plato -> Bool
esMejorQue unPlato otroPlato = tieneMasDificultad unPlato otroPlato && usaMenosCantidades unPlato otroPlato

participanteEstrella :: [Participante] -> Participante
participanteEstrella unosParticipantes = foldl1 quienGana unosParticipantes

participanteEstrellaRecursivo :: [Participante] -> Participante
participanteEstrellaRecursivo [] = siemprePierde --Ver ultima de las funciones auxiliares de este punto
participanteEstrellaRecursivo [unParticipante] = unParticipante --Caso base, cuando compare a todos los participantes mostrará al único que quedó, el cual será el ganador
participanteEstrellaRecursivo (primerParticipante : segundoParticipante : demasParticipantes) =
    participanteEstrellaRecursivo (quienGana primerParticipante segundoParticipante : demasParticipantes)  --Caso recursivo

--Funciones Auxiliares

aplicarTrucosDe :: Participante -> Plato -> Plato
aplicarTrucosDe unParticipante unPlato = aplicarTrucos (trucos unParticipante) unPlato --Funcion para darle más expresividad al código

aplicarTrucos :: [Truco] -> Plato -> Plato
aplicarTrucos unosTrucos unPlato = foldr ($) unPlato unosTrucos

tieneMasDificultad :: Plato -> Plato -> Bool
tieneMasDificultad unPlato otroPlato = dificultad unPlato > dificultad otroPlato

usaMenosCantidades :: Plato -> Plato -> Bool
usaMenosCantidades unPlato otroPlato = pesoTodosLosComponentes otroPlato > pesoTodosLosComponentes unPlato

pesoTodosLosComponentes :: Plato -> Int
pesoTodosLosComponentes unPlato = sum . map cantidadIngrediente . componentes $ unPlato --Suma el peso de todos los ingredientes

quienGana :: Participante -> Participante -> Participante --Devuelve el ganador al poner a competir a dos participantes
quienGana unParticipante otroParticipante
    | esMejorQue (platoCocinado unParticipante) (platoCocinado otroParticipante) = unParticipante
    | otherwise                                                                  = otroParticipante

platoCocinado :: Participante -> Plato
platoCocinado unParticipante = cocinar (especialidad unParticipante) unParticipante

siemprePierde :: Participante --Uso este participante para el patron de lista vacia en la funcion recursiva de participante estrella
siemprePierde = UnParticipante {
    nombre       = "Palito Ortega",
    trucos       = [],
    especialidad = especialidadPerdedora --Siempre perderá, además el único caso en el que aparecerá será cuando la lista en participanteEstrellaRecursiva sea vacía
}                                        -- ya que si no es vacía al menos siempre habrá un ganador

especialidadPerdedora :: Plato 
especialidadPerdedora = UnPlato {
    dificultad  = 0,
    componentes = []
}

--Parte D, plato Platinum

platinum :: Plato 
platinum = UnPlato {
    dificultad  = 10,
    componentes = ingredientesPlatinum
}

ingredientesPlatinum :: [Ingrediente]
ingredientesPlatinum = zip ingredientesInfinitos cantidadesIncrementales

ingredientesInfinitos :: [Nombre]
ingredientesInfinitos = zipWith (++) (repeat "Ingrediente ") (map show (iterate (+1) 1))
                      -- otra forma de hacerlo puede ser map (flip (++) "Ingrediente") (map show (iterate (+1) 1)).

cantidadesIncrementales :: [Cantidad]
cantidadesIncrementales = iterate (+1) 1

{-
La Lazy Evaluation o Evaluación Perezosa es el estilo que tiene Haskell para evaluar las listas. A través de esta es que se 
evalua siempre componente por componente, lo que permitiría trabajar con listas infinitas para determinadas cosas.

¿Qué sucede si aplicamos cada uno de los trucos modelados en la Parte A al platinum?
Con respecto a endulzar, salar o darSabor, la función hará su trabajo sin problemas, pero de la forma en la que yo definí 
la función agregarIngrediente nunca terminará de mostrar el ingrediente agregado ya que yo quise que se argegue al final de la
lista de componentes, se quedará mostrando un plato que solamente diga [("Ingrediente 1", 1), ("Ingrediente 2", 2)...] pero 
los nuevos ingredientes nunca aparecerán ya que estarán al final de una lista infinita.
Si en cambio la función agregarIngrediente, agregara el ingrediente al principio de la lista de componentes, sí se
mostraría al principio, pero al igual que antes se quedaría mostrando una lista infinita de ingredientes, luego de mostrar
el ingrediente agregado.
duplicarPorcion haría exactamente lo mismo que la anterior, pero con una modificación sobre las cantidades de cada ingrediente,
ya que las duplica por lo que en lugar de mostrar [("Ingrediente 1", 1), ("Ingrediente 2", 2), ("Ingrediente 3", 3)...]
hasta el infinito, mostrará [("Ingrediente 1", 2), ("Ingrediente 2", 4), ("Ingrediente 3", 6)...] hasta el infinito.
simplificarPlato también se puede ejecutar sin problemas, bajará la dificultad sin quejas pero al momento de quitar y mostrar
los ingredientes con menos de 10 gramos llegará hasta [..("Ingrediente 9", 9)..] y ahí se quedará procesando la lista infinita
en busca de ingredientes con menos de 10 gramos que nunca aparecerán, porque a partir de este momento solo quedan cantidades de 
10 para arriba.
Resumidamente, se ejecutarán todas las funciones tranquilamente, nunca terminará de completarlas y menos de mostrar los resultados,
esto es debido a la Lazy Evaluation de Haskell, que nos permite trabajar con listas infinitas sin problemas, ya que Haskell evaluará
cada elemento de la lista infinitamente.

¿Cuáles de las preguntas de la Parte A (esVegano, esSinTacc, etc.) se pueden responder sobre el platinum? 
esVegano no podría responderse porque nuevamente Haskell quedará evaluando cada elemento de la lista hasta que aparezca alguno
que pueda decir que un plato no es vegano, al tener ingredientes misteriosos no se sabrá nunca, a menos que se agregue un
ingrediente en los principios de la lista que no sea apto para veganos, apenas haskell lo encuentre podrá decir que un plato
no es vegano.
esSinTACC sufre algo muy parecido a esVegano, quedará evaluando el plato infinitamente, sin dar respuesta, a menos que se agregue 
un ingrediente con harina en los principios de los ingredientes y ahí haskell podrá decir que no es apto para celíacos.
esComplejo, en este podemos obtener una respuesta, ya que evalúa si un plato tiene dificultad más alta que 7 y si tiene más de 
5 componentes, la alta dificultad nos da verdadero ya que tiene 10, y la cantidad de componentes nos dirá que es mayor a 5,
debido a que cuenta la cantidad de ingredientes, cuando llegue a contar 5 elementos (que los contará porque es una lista de 
elementos infinitos) nos dará True también y por lo tanto, nos dice que el plato es Complejo
noAptoHipertension, pasa algo similar a esVegano y esSinTACC, ya que Haskell quedará mirando si encuentra sales por más de 2 
gramos, cosa que no encontrará ya que todos los ingredientes son misteriosos, por lo que quedará evaluando la lista 
infinitamente. Si se llega a agregar al principio de los componentes sales en mayor cantidad a 2 gramos, ya inmediatamente
nos descartará el plato como apto para hipertensos.
También se ejecutarán todas las funciones correctamente gracias a la Lazy Evaluation, tampoco tendremos resultados en ninguna
función, salvo que se modifique el principio de la lista con algún ingrediente particular o que se ejecute la función esComplejo.

¿Se puede saber si el platinum es mejor que otro plato?
Se pueden comparar, platinum nunca será mejor que otro plato porque debe cumplir con: dificultad mayor (lo cumple) y menos componentes.
De esto último siempre se verá que platinum siempre tendrá mayor cantidad de ingredientes que cualquier otro plato que no tenga
ingredientes infinitos, por lo que siempre dará False, porque nunca cumpliría las dos condiciones a la vez. 
En resumen, se ejecutará la función y siempre dará False salvo que se compare con otro plato con ingredientes infinitos, en cuyo
caso Haskell se quedará evaluando en le infinito. Esto es debido a la Lazy Evaluation.
-}
