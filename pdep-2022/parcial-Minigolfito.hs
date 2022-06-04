--Parcial Minigolfito

--Modelado jugadores

data Jugador = UnJugador {
    nombre      :: String,
    padre       :: String,
    habilidades :: Habilidad
} deriving (Show, Eq)

data Habilidad = Habilidad {
    fuerzaJugador    :: Int,
    precisionJugador :: Int
} deriving (Show, Eq)

bart:: Jugador
bart = UnJugador {
    nombre      = "Bart",
    padre       = "Homero",
    habilidades = habilidadBart
}

todd :: Jugador
todd = UnJugador {
    nombre      = "Todd",
    padre       = "Ned",
    habilidades = habilidadTodd
}

rafa :: Jugador
rafa = UnJugador {
    nombre      = "Rafa",
    padre       = "Gorgory",
    habilidades = habilidadRafa
}

habilidadBart :: Habilidad
habilidadBart = Habilidad { fuerzaJugador = 25, precisionJugador = 60 }
habilidadTodd :: Habilidad
habilidadTodd = Habilidad { fuerzaJugador = 15, precisionJugador = 80 }
habilidadRafa :: Habilidad
habilidadRafa = Habilidad { fuerzaJugador = 10, precisionJugador =  1 }

--Modelado palos de golf

data Tiro = UnTiro {
    velocidad :: Int,
    precision :: Int,
    altura    :: Int
} deriving (Show,Eq)

tiroEn0 :: Tiro
tiroEn0 = UnTiro { velocidad = 0, precision = 0, altura = 0 }

type Palo = Habilidad -> Tiro

putter :: Palo
putter unaHabilidad = UnTiro {
    velocidad = 10, 
    precision = precisionJugador unaHabilidad * 2,
    altura = 0
}

madera :: Palo
madera unaHabilidad = UnTiro {
    velocidad = 100,
    precision = div (precisionJugador unaHabilidad) 2,
    altura = 5
}

hierros :: Int -> Palo
hierros n unaHabilidad = UnTiro {
    velocidad = fuerzaJugador unaHabilidad * n,
    precision = div (precisionJugador unaHabilidad) n,
    altura = alturaTiro (n-3)
}

precisionUnJugador :: Jugador -> Int
precisionUnJugador unJugador = precisionJugador . habilidades $ unJugador

fuerzaUnJugador :: Jugador -> Int
fuerzaUnJugador unJugador = fuerzaJugador . habilidades $ unJugador

alturaTiro :: Int -> Int
alturaTiro unaAltura 
    | unaAltura >= 0 = unaAltura
    | otherwise      = 0

mapAltura :: (Int -> Int) -> Tiro -> Tiro
mapAltura unaFuncion unTiro = unTiro { altura = unaFuncion . altura $ unTiro }

velocidadTiro :: Int -> Tiro -> Tiro
velocidadTiro unaVelocidad unTiro
    | unaVelocidad >= 0 = mapVelocidad (const unaVelocidad) unTiro
    | otherwise         = mapVelocidad (const 0) unTiro

mapVelocidad :: (Int -> Int) -> Tiro -> Tiro
mapVelocidad unaFuncion unTiro = unTiro { velocidad = unaFuncion . velocidad $ unTiro }

precisionTiro :: Int -> Tiro -> Tiro
precisionTiro unaPrecision unTiro
    | unaPrecision >= 0 = mapPrecision (const unaPrecision) unTiro
    | otherwise         = mapPrecision (const 0) unTiro

mapPrecision :: (Int -> Int) -> Tiro -> Tiro
mapPrecision unaFuncion unTiro = unTiro { precision = unaFuncion . precision $ unTiro }

palos :: [Palo]
palos = [putter, madera] ++ palosHierro

palosHierro :: [Palo]
palosHierro = zipWith ($) (repeat hierros) [1..10]

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = usarPalo unPalo unJugador

usarPalo :: Palo -> Jugador -> Tiro
usarPalo unPalo unJugador = unPalo (habilidades unJugador)

data Obstaculo = UnObstaculo {
    puedeSuperarse :: Tiro -> Bool,
    efectoAlTiro :: Tiro -> Tiro
}

superarObstaculo :: Obstaculo -> Tiro -> Tiro
superarObstaculo unObstaculo unTiro
    | puedeSuperarse unObstaculo unTiro = efectoAlTiro unObstaculo unTiro
    | otherwise = tiroEn0

tunelConRampita :: Obstaculo
tunelConRampita = UnObstaculo { 
    puedeSuperarse = superaTunelConRampita,
    efectoAlTiro = efectoTunelConRampita
}

laguna :: Int -> Obstaculo
laguna largoLaguna = UnObstaculo {
    puedeSuperarse = superaLaguna,
    efectoAlTiro = efectoLaguna largoLaguna
}

hoyo :: Obstaculo
hoyo = UnObstaculo {
    puedeSuperarse = superaHoyo,
    efectoAlTiro = efectoHoyo
}

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita unTiro = precision unTiro > 90 && vaAlRasDelSuelo unTiro

vaAlRasDelSuelo :: Tiro -> Bool
vaAlRasDelSuelo unTiro = (== 0) . altura $ unTiro

efectoTunelConRampita :: Tiro -> Tiro
efectoTunelConRampita unTiro = duplicarVelocidad . precisionTiro 100 $ unTiro

duplicarVelocidad :: Tiro -> Tiro
duplicarVelocidad unTiro = mapVelocidad (*2) unTiro

superaLaguna :: Tiro -> Bool
superaLaguna unTiro = velocidad unTiro > 80 && alturaParaLaguna unTiro

alturaParaLaguna :: Tiro -> Bool
alturaParaLaguna unTiro = (altura unTiro >= 1) && (altura unTiro <= 5)

efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largoLaguna unTiro = mapAltura (flip div largoLaguna) unTiro

superaHoyo :: Tiro -> Bool
superaHoyo unTiro = velocidadParaHoyo unTiro && precision unTiro > 95 && vaAlRasDelSuelo unTiro

velocidadParaHoyo :: Tiro -> Bool
velocidadParaHoyo unTiro = velocidad unTiro >= 5 && velocidad unTiro <= 20

efectoHoyo :: Tiro -> Tiro
efectoHoyo _ = tiroEn0

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter (pasaObstaculoConPalo unObstaculo unJugador) palos

pasaObstaculoConPalo :: Obstaculo -> Jugador -> Palo -> Bool
pasaObstaculoConPalo unObstaculo unJugador unPalo = puedeSuperarse unObstaculo (golpe unJugador unPalo)

cantidadObstaculosPasados :: Tiro -> [Obstaculo] -> Int
cantidadObstaculosPasados unTiro conjuntoObstaculos = length (obstaculosPasados unTiro conjuntoObstaculos)

obstaculosPasados :: Tiro -> [Obstaculo] -> [Obstaculo]
obstaculosPasados unTiro obstaculos = takeWhile (\ x -> puedeSuperarse x unTiro) obstaculos

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil unJugador obstaculos = undefined

type Puntos = Int

padresPerdedores :: [(Jugador, Puntos)] -> [String]
padresPerdedores listaConPuntajes = map (padre . fst) (perdedores listaConPuntajes)

perdedores :: [(Jugador, Puntos)] -> [(Jugador, Puntos)]
perdedores listaConPuntajes = filter (not . esGanador listaConPuntajes) listaConPuntajes

esGanador :: [(Jugador, Puntos)] -> (Jugador, Puntos) -> Bool
esGanador listaDeJugadores unJugador = unJugador == (ganador listaDeJugadores)

ganador :: [(Jugador, Puntos)] -> (Jugador, Puntos)
ganador listaConPuntajes = foldl1 mayorEntreDuplas listaConPuntajes

mayorEntreDuplas :: (a, Int) -> (a, Int) -> (a, Int)
mayorEntreDuplas unaDupla otraDupla 
    | snd unaDupla >= snd otraDupla = unaDupla
    | otherwise = otraDupla


maximoSegun f lista = foldl1 (mayorSegun f) lista
mayorSegun f a b
  | f a > f b = a
  | otherwise = b
