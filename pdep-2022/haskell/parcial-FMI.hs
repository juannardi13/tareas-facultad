--Parcial FMI

data Pais = UnPais {
    ingresoPerCapita :: Int,
    poblacionSectorPublico :: Int,
    poblacionSectorPrivado :: Int,
    recursos :: [Recurso],
    deudaFMI :: Int
}

type Recurso = String

--recetas FMI

type Receta = Pais -> Pais

prestar :: Int -> Receta
prestar n unPais = endeudarse (porcentaje 150 . enMillones $ n) unPais

reducirSectorPublico :: Int -> Receta
reducirSectorPublico cantidadDespedidos unPais = reducirIngreso cantidadDespedidos . despedirPublicos cantidadDespedidos $ unPais

explotacion :: Recurso -> Receta
explotacion unRecurso unPais = reducirDeuda (enMillones 2) . quitarRecurso unRecurso $ unPais

blindaje :: Receta 
blindaje unPais = reducirSectorPublico 500 . prestar (mitadPBI unPais) $ unPais

--Funciones auxiliares

mitadPBI :: Pais -> Int
mitadPBI unPais = div (pbi unPais) 2

pbi :: Pais -> Int
pbi unPais = (ingresoPerCapita unPais) * (poblacionActiva unPais)

poblacionActiva :: Pais -> Int
poblacionActiva unPais = (poblacionSectorPrivado unPais) + (poblacionSectorPublico unPais)

quitarRecurso :: Recurso -> Pais -> Pais
quitarRecurso unRecurso unPais = mapRecursos (quitar unRecurso) unPais

quitar :: Recurso -> [Recurso] -> [Recurso]
quitar _ [] = []
quitar unRecurso (primerRecurso : demasRecursos)
    | unRecurso == primerRecurso = demasRecursos
    | otherwise = primerRecurso : quitar unRecurso demasRecursos

reducirDeuda :: Int -> Pais -> Pais
reducirDeuda unaCantidad unPais = mapDeuda (flip (-) unaCantidad) unPais

reducirIngreso :: Int -> Pais -> Pais
reducirIngreso cantidadDespedidos unPais
    | cantidadDespedidos > 100 = mapIngreso (flip (-) (porcentaje 20 (ingresoPerCapita unPais))) unPais
    | otherwise = mapIngreso (flip (-) (porcentaje 15 (ingresoPerCapita unPais))) unPais

despedirPublicos :: Int -> Pais -> Pais
despedirPublicos despedidos unPais = mapSectorPublico (flip (-) despedidos) unPais

endeudarse :: Int -> Pais -> Pais
endeudarse unaCantidad unPais = mapDeuda ((+) unaCantidad) unPais

porcentaje :: Int -> Int -> Int
porcentaje unPorcentaje unaCantidad = unaCantidad * (div unPorcentaje 100)

enMillones :: Int -> Int
enMillones unaCantidad = unaCantidad * 1000000

--mappers para evitar la repeticion de logica

mapRecursos :: ([Recurso] -> [Recurso]) -> Pais -> Pais
mapRecursos unaFuncion unPais = unPais { recursos = unaFuncion . recursos $ unPais }

mapDeuda :: (Int -> Int) -> Pais -> Pais
mapDeuda unaFuncion unPais = unPais { deudaFMI = unaFuncion . deudaFMI $ unPais }

mapIngreso :: (Int -> Int) -> Pais -> Pais
mapIngreso unaFuncion unPais = unPais { ingresoPerCapita = unaFuncion . ingresoPerCapita $ unPais }

mapSectorPublico :: (Int -> Int) -> Pais -> Pais
mapSectorPublico unaFuncion unPais = unPais { poblacionSectorPublico = unaFuncion . poblacionSectorPublico $ unPais }

-- representacion de Namibia

namibia :: Pais
namibia = UnPais {
    ingresoPerCapita = enMillones 4140,
    poblacionSectorPublico = 400000,
    poblacionSectorPrivado = 650000,
    recursos = ["Mineria", "Ecoturismo"],
    deudaFMI = enMillones 50
}

--Modelado recetas

receta1 :: [Receta]
receta1 = [prestar 200, explotacion "Mineria"]

aplicarANamibia :: Pais
aplicarANamibia = usarRecetas namibia receta1

usarRecetas :: Pais -> [Receta] -> Pais
usarRecetas unPais unasRecetas = foldr ($) unPais unasRecetas

--Punto 4

zafan :: [Pais] -> [Pais]
zafan listaDePaises = filter (elem "Petroleo" . recursos) listaDePaises

deudaAFavor :: [Pais] -> Int
deudaAFavor listaDePaises = sum . map deudaFMI $ listaDePaises
