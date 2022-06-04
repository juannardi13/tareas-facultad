--TP Monopoly

import Text.Show.Functions()

data Jugador = UnJugador {
    nombre :: String,
    dinero :: Int,
    tactica :: String,
    propiedades :: [Propiedad],
    acciones :: [Accion]
} deriving Show

data Propiedad = UnaPropiedad {
    nombrePropiedad :: String,
    precio :: Int
} deriving (Show, Eq)

--Modelado de Carolina y Manuel
carolina :: Jugador
carolina = UnJugador { 
    nombre = "Carolina",
    dinero = 500,
    tactica = "Accionista",
    propiedades = sinPropiedades,
    acciones = [pasarPorElBanco, pagarAAccionistas]
}

manuel   :: Jugador
manuel   = UnJugador { 
    nombre =  "Manuel",
    dinero = 500,
    tactica = "Oferente Singular",
    propiedades = sinPropiedades,
    acciones = [pasarPorElBanco, enojarse]
}

sinPropiedades :: [Propiedad]
sinPropiedades = []

--Modelado De Acciones
type Accion = Jugador -> Jugador

pasarPorElBanco :: Accion
pasarPorElBanco unJugador = aumentarDinero 40 unJugador

enojarse :: Accion
enojarse unJugador = (aumentarDinero 50) . (agregarAccion gritar) $ unJugador

gritar :: Accion
gritar unJugador = mapNombre (flip (++) "AHHHH") unJugador

subastar :: Propiedad -> Accion
subastar unaPropiedad unJugador
    | puedeSubastar unJugador = (restarDinero (precio unaPropiedad)) . (agregarPropiedad unaPropiedad) $ unJugador
    | otherwise = unJugador

cobrarAlquileres :: Propiedad -> Accion
cobrarAlquileres unaPropiedad unJugador
    | esBarata unaPropiedad = aumentarDinero 10 unJugador
    | otherwise             = aumentarDinero 20 unJugador

pagarAAccionistas :: Accion
pagarAAccionistas unJugador 
    | esAccionista unJugador = aumentarDinero 200 unJugador
    | otherwise              = restarDinero   100 unJugador

hacerBerrinchePor :: Propiedad -> Accion
hacerBerrinchePor unaPropiedad unJugador
    | puedeComprar unaPropiedad unJugador = (restarDinero (precio unaPropiedad)) . (agregarPropiedad unaPropiedad) $ unJugador
    | otherwise = hacerBerrinchePor unaPropiedad (gritar . (aumentarDinero 10) $ unJugador)

--Funciones Auxiliares

puedeSubastar :: Jugador -> Bool
puedeSubastar unJugador = suTacticaEs "Oferente singular" unJugador || suTacticaEs "Accionista" unJugador

suTacticaEs :: String -> Jugador -> Bool
suTacticaEs unaTactica unJugador = unaTactica == tactica unJugador

puedeComprar :: Propiedad -> Jugador -> Bool
puedeComprar unaPropiedad unJugador = precio unaPropiedad <= dinero unJugador

agregarPropiedad :: Propiedad -> Jugador -> Jugador
agregarPropiedad unaPropiedad unJugador = mapPropiedades (flip (++) [unaPropiedad]) unJugador

esAccionista :: Jugador -> Bool
esAccionista unJugador = tactica unJugador == "Accionista"

restarDinero :: Int -> Jugador -> Jugador
restarDinero dineroASacar unJugador = mapDinero (flip (-) dineroASacar) unJugador

esBarata :: Propiedad -> Bool
esBarata unaPropiedad = 150 > precio unaPropiedad

aumentarDinero :: Int -> Jugador -> Jugador
aumentarDinero dineroAAgregar unJugador = mapDinero (+ dineroAAgregar) unJugador

agregarAccion :: Accion -> Jugador -> Jugador
agregarAccion unaAccion unJugador = mapAcciones (flip (++) [unaAccion]) unJugador

mapPropiedades :: ([Propiedad] -> [Propiedad]) -> Jugador -> Jugador
mapPropiedades unaFuncion unJugador = unJugador { propiedades = unaFuncion . propiedades $ unJugador }

mapNombre :: (String -> String) -> Jugador -> Jugador
mapNombre unaFuncion unJugador = unJugador { nombre = unaFuncion . nombre $ unJugador }

mapAcciones :: ([Accion] -> [Accion]) -> Jugador -> Jugador
mapAcciones unaFuncion unJugador = unJugador { acciones = unaFuncion . acciones $ unJugador }

mapDinero :: (Int -> Int) -> Jugador -> Jugador
mapDinero unaFuncion unJugador = unJugador { dinero = unaFuncion . dinero $ unJugador }

--ultimaRonda

ultimaRonda :: Jugador -> Jugador
ultimaRonda unJugador = foldr ($) (unJugador) (acciones unJugador)

juegoFinal :: Jugador -> Jugador -> Jugador
juegoFinal unJugador otroJugador
    | dinero (ultimaRonda unJugador) >= dinero (ultimaRonda otroJugador) = unJugador
    | dinero (ultimaRonda unJugador) <  dinero (ultimaRonda otroJugador) = otroJugador