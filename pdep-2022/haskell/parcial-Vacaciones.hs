--Parcial Vacaciones

--Modelado Turistas

data Turista = UnTurista {
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [Idioma]
} deriving (Show, Eq)

type Idioma = String

--Modelado de excursiones

type Excursion = Turista -> Turista

playa :: Excursion
playa unTurista 
    | viajaSolo unTurista = bajarCansancio 5 unTurista
    | otherwise           = bajarStress 1 unTurista

apreciarElementoDelPaisaje :: String -> Excursion
apreciarElementoDelPaisaje unElemento unTurista = bajarStress (length unElemento) unTurista

salirAHablarIdioma :: String -> Excursion
salirAHablarIdioma unIdioma unTurista = viajaraAcompaniado . aprendeIdioma unIdioma $ unTurista

caminar :: Int -> Excursion
caminar unosMinutos unTurista = aumentaCansancio (intensidad unosMinutos) . bajarStress (intensidad unosMinutos) $ unTurista

paseoEnBarco :: String -> Excursion
paseoEnBarco intensidadMarea unTurista
    | esFuerte intensidadMarea    = aumentarStress 6 . aumentaCansancio 10 $ unTurista
    | esModerada intensidadMarea  = unTurista
    | esTranquila intensidadMarea = salirAHablarIdioma "Aleman" . apreciarElementoDelPaisaje "Mar" . caminar 10 $ unTurista

--Funciones auxiliares

bajarCansancio :: Int -> Turista -> Turista
bajarCansancio unaCantidad unTurista = mapCansancio (flip (-) unaCantidad) unTurista

aumentaCansancio :: Int -> Turista -> Turista
aumentaCansancio unaCantidad unTurista = mapCansancio ((+) unaCantidad) unTurista

bajarStress :: Int -> Turista -> Turista
bajarStress unaCantidad unTurista = mapStress (flip (-) unaCantidad) unTurista

aumentarStress :: Int -> Turista -> Turista
aumentarStress unaCantidad unTurista = mapStress ((+) unaCantidad) unTurista

viajaraAcompaniado :: Turista -> Turista
viajaraAcompaniado unTurista = unTurista { viajaSolo = False }

aprendeIdioma :: String -> Turista -> Turista
aprendeIdioma unIdioma unTurista 
    | yaSabeElIdioma unIdioma unTurista = unTurista
    | otherwise = mapIdioma (flip (++) [unIdioma]) unTurista

yaSabeElIdioma :: String -> Turista -> Bool
yaSabeElIdioma unIdioma unTurista = elem unIdioma (idiomas unTurista)

intensidad :: Int -> Int
intensidad unosMinutos = div unosMinutos 4

esFuerte :: String -> Bool
esFuerte unaMarea = unaMarea == "Fuerte"

esModerada :: String -> Bool
esModerada unaMarea = unaMarea == "Moderada"

esTranquila :: String -> Bool
esTranquila unaMarea = unaMarea == "Tranquila"

--mappers auxiliares para evitar repeticion de logica

mapCansancio :: (Int -> Int) -> Turista -> Turista
mapCansancio unaFuncion unTurista = unTurista { cansancio = unaFuncion . cansancio $ unTurista }

mapStress :: (Int -> Int) -> Turista -> Turista
mapStress unaFuncion unTurista = unTurista { stress = unaFuncion . stress $ unTurista }

mapIdioma :: ([String] -> [String]) -> Turista -> Turista
mapIdioma unaFuncion unTurista = unTurista { idiomas = unaFuncion . idiomas $ unTurista }

--ejemplos Turistas

ana :: Turista
ana = UnTurista {
    cansancio = 0,
    stress = 21,
    viajaSolo = False,
    idiomas = ["Español"]
}

beto :: Turista
beto = UnTurista {
    cansancio = 15,
    stress = 15,
    viajaSolo = True,
    idiomas = ["Aleman"]
}

cathi :: Turista
cathi = UnTurista {
    cansancio = 15,
    stress = 15,
    viajaSolo = True,
    idiomas = ["Aleman", "Catalan"]
}

--Turista hace excursion

hacerExcursion :: Turista -> Excursion -> Turista
hacerExcursion unTurista unaExcursion = bajarStress (diezPorCiento unTurista) . unaExcursion $ unTurista

diezPorCiento :: Turista -> Int
diezPorCiento unTurista = div (stress unTurista) 10

deltaExcursionSegun :: (Turista -> Int) -> Turista -> Excursion -> Int
deltaExcursionSegun unIndice unTurista unaExcursion = deltaSegun unIndice (hacerExcursion unTurista unaExcursion) unTurista

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

excursionEducativa :: Turista -> Excursion -> Bool
excursionEducativa unTurista unaExcursion = (> 0) . (deltaExcursionSegun cantidadDeIdiomasAprendidos unTurista) $ unaExcursion 

cantidadDeIdiomasAprendidos :: Turista -> Int
cantidadDeIdiomasAprendidos unTurista = length . idiomas $ unTurista

excursionDesestresante :: Turista -> Excursion -> Bool
excursionDesestresante unTurista unaExcursion = (>= 3) . (deltaExcursionSegun stress unTurista) $ unaExcursion

--Modelado de Tours

type Tour = [Excursion]

completo :: [Excursion]
completo = [(caminar 20), (apreciarElementoDelPaisaje "Cascada"), (caminar 40), playa, (salirAHablarIdioma "Melmacquiano")]

ladoB :: Excursion -> [Excursion]
ladoB excursionElegida = [(paseoEnBarco "Tranquila"), excursionElegida, (caminar 120)]

islaVecina :: String -> [Excursion]
islaVecina unaMarea = [(paseoEnBarco unaMarea), (excursionQueCambia unaMarea), (paseoEnBarco unaMarea)]

excursionQueCambia :: String -> Excursion
excursionQueCambia unaMarea unTurista
    | esFuerte unaMarea = apreciarElementoDelPaisaje "lago" unTurista
    | otherwise = playa unTurista

--Hacer tours

hacerTour :: Tour -> Turista -> Turista
hacerTour unTour unTurista = hacerExcursiones unTour . aumentarStress (cantidadExcursiones unTour) $ unTurista

hacerExcursiones :: Tour -> Turista -> Turista
hacerExcursiones unaListaDeExcursiones unTurista = foldl hacerExcursion unTurista unaListaDeExcursiones

cantidadExcursiones :: Tour -> Int
cantidadExcursiones unTour = length unTour

{- OTRA FORMA DE HACERLO
hacerTour :: Tour -> Turista -> Turista
hacerTour unTour unTurista = foldl hacerUnaExcursion unTurista unTour

hacerUnaExcursion :: Turista -> Excursion -> Turista
hacerUnaExcursion unTurista unaExcursion = aumentarStress 1 . hacerExcursion unTurista $ unaExcursion
-}

tourConvincente :: [Tour] -> Turista -> Bool
tourConvincente unosTours unTurista = any (esConvincente unTurista) unosTours

esConvincente :: Turista -> Tour -> Bool
esConvincente unTurista unTour = any (desestresanteYAcompaniado unTurista) unTour

desestresanteYAcompaniado :: Turista -> Excursion -> Bool
desestresanteYAcompaniado unTurista unaExcursion = excursionDesestresante unTurista unaExcursion && quedaAcompaniado unTurista unaExcursion

quedaAcompaniado :: Turista -> Excursion -> Bool
quedaAcompaniado unTurista unaExcursion = (== False) . viajaSolo . hacerExcursion unTurista $ unaExcursion

efectividadTour :: Tour -> [Turista] -> Int
efectividadTour unTour unosTuristas = sum . espiritualidadTuristas unTour . resultoConvincente unTour $ unosTuristas 

espiritualidadTuristas :: Tour -> [Turista] -> [Int]
espiritualidadTuristas unTour unosTuristas = map (espiritualidadDespuesDelTour unTour) unosTuristas

espiritualidadDespuesDelTour :: Tour -> Turista -> Int
espiritualidadDespuesDelTour unTour unTurista = perdidaStress unTurista unTour + perdidaCansancio unTurista unTour

perdidaStress :: Turista -> Tour -> Int
perdidaStress unTurista unTour = sum . (map (deltaExcursionSegun stress unTurista)) $ unTour

perdidaCansancio :: Turista -> Tour -> Int
perdidaCansancio unTurista unTour = sum . (map (deltaExcursionSegun cansancio unTurista)) $ unTour

resultoConvincente :: Tour -> [Turista] -> [Turista]
resultoConvincente unTour unosTuristas = filter (flip esConvincente unTour) unosTuristas

--Tour Infinitas Playas

playasInfinitas :: Tour
playasInfinitas = repeat playa

{-
b. El tour de las playas infinitas es básicamente hacer que cada uno de los turistas vaya infinitas veces a la playa
gracias a la lazy evaluation de Haskell, podemos hacer que comience el tour pero nunca terminará, si alguna vez la visita a la
playa resulta desestresante, entonces finalmente el tour será convincente para quien lo tome. Pero mientras no sea desestresante la playa
seguirá evaluandose hasta el fin de los tiempos sin dar un resultado, ya que con que solamente haya alguna excursion desestresante el tour
ya es convincente. Por lo que Haskell evaluará cualquier tour infinito y dirá si es convincente apenas encuentre dentro del tour una excursion
que sea desestresante para aquel que la toma.

c. No, puede pasar que el tour sea convincente para alguien. Pero al intentar evaluar la efectividad Haskell se encontrará con que no puede
sumar la espiritualidad de aquellos que toman el tour. Existe la posibilidad de que a nadie le parezca efectivo el tour, por lo que tendremos una
sumatoria de una lista vacia ya que nadie toma el tour porque no le parece convincente.
-}
