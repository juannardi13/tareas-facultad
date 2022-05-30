--Simulacro de parcial PdeGym

-- Tipo de Dato de una Persona comenzando con la parte A
data Persona = UnaPersona {
    nombre :: String, 
    calorias :: Int,
    indiceHidratacion :: Int,
    tiempoLibre :: Int,
    equipamientos :: [Equipamiento]
} deriving Show

type Equipamiento = String
type Ejercicio = Persona -> Persona

--FUNCION abdominales
abdominales :: Int -> Ejercicio
abdominales cantidadDeRepeticiones unaPersona = pierdeCalorias (8 * cantidadDeRepeticiones) unaPersona

pierdeCalorias :: Int -> Persona -> Persona
pierdeCalorias caloriasQuePierde unaPersona = mapCalorias (flip (-) caloriasQuePierde) unaPersona

mapCalorias :: (Int -> Int) -> Persona -> Persona
mapCalorias unaFuncion unaPersona = unaPersona { calorias = unaFuncion . calorias $ unaPersona }

--FUNCION flexiones
flexiones :: Int -> Ejercicio
flexiones cantidadDeRepeticiones unaPersona = (pierdeCalorias (16 * cantidadDeRepeticiones)) . (pierdeHidratacion 2 10 cantidadDeRepeticiones) $ unaPersona

pierdeHidratacion :: Int -> Int -> Int -> Persona -> Persona
pierdeHidratacion hidratacionQuePierde cadaCuantoPierde cantidadDeRepeticiones unaPersona = mapIndiceHidratacion (flip (-) (hidratacionQuePierde * (div cantidadDeRepeticiones cadaCuantoPierde))) unaPersona

mapIndiceHidratacion :: (Int -> Int) -> Persona -> Persona
mapIndiceHidratacion unaFuncion unaPersona = unaPersona { indiceHidratacion = unaFuncion . indiceHidratacion $ unaPersona }

--FUNCION levantarPesas
levantarPesas :: Int -> Int -> Ejercicio
levantarPesas cantidadDeRepeticiones pesoPesa unaPersona | usaPesa unaPersona = pierdeCalorias (32 * cantidadDeRepeticiones) . pierdeHidratacion pesoPesa 10 cantidadDeRepeticiones $ unaPersona
                                                         | otherwise = unaPersona

usaPesa :: Persona -> Bool
usaPesa unaPersona = elem "pesa" (equipamientos unaPersona)

--FUNCION laGranHomeroSimpson
laGranHomeroSimpson :: Ejercicio
laGranHomeroSimpson unaPersona = unaPersona

--FUNCION renovarEquipo
renovarEquipo :: Persona -> Persona
renovarEquipo unaPersona = mapEquipamientos (agregarDelante "Nuevo ") unaPersona

agregarDelante :: String -> [String] -> [String]
agregarDelante unString unaLista = map ((++) unString) unaLista

mapEquipamientos :: ([String] -> [String]) -> Persona -> Persona
mapEquipamientos unaFuncion unaPersona = unaPersona { equipamientos = unaFuncion . equipamientos $ unaPersona }

--FUNCION volverseYoguista
volverseYoguista :: Persona -> Persona
volverseYoguista unaPersona = pierdeCalorias (div (calorias unaPersona) 2) . duplicaIndiceHidratacion . compraColchoneta . vendeTodo $ unaPersona

vendeTodo :: Persona -> Persona
vendeTodo unaPersona = mapEquipamientos (const []) unaPersona

compraColchoneta :: Persona -> Persona
compraColchoneta unaPersona = mapEquipamientos ((:) "colchoneta") unaPersona

duplicaIndiceHidratacion :: Persona -> Persona
duplicaIndiceHidratacion unaPersona | indiceHidratacion unaPersona <= 50 = mapIndiceHidratacion (* 2) unaPersona
                                    | otherwise = maximaHidratacion unaPersona

maximaHidratacion :: Persona -> Persona
maximaHidratacion unaPersona = mapIndiceHidratacion (const 100) unaPersona

--FUNCION volverseBodyBuilder
volverseBodyBuilder :: Persona -> Persona
volverseBodyBuilder unaPersona | soloTienePesas unaPersona = agregarAlNombre " BB" . triplicaCalorias $ unaPersona
                               | otherwise = unaPersona

soloTienePesas :: Persona -> Bool
soloTienePesas unaPersona = all (== "pesa") (equipamientos unaPersona)

agregarAlNombre :: String -> Persona -> Persona 
agregarAlNombre unString unaPersona = mapNombre (flip (++) unString) unaPersona

triplicaCalorias :: Persona -> Persona
triplicaCalorias unaPersona = aumentaCalorias ((calorias unaPersona) * 2) unaPersona

mapNombre :: (String -> String) -> Persona -> Persona
mapNombre unaFuncion unaPersona = unaPersona { nombre = unaFuncion . nombre $ unaPersona }

aumentaCalorias :: Int -> Persona -> Persona 
aumentaCalorias unasCalorias unaPersona = mapCalorias ((+) unasCalorias) unaPersona

--FUNCION comerUnSandwich
comerUnSandwich :: Persona -> Persona
comerUnSandwich unaPersona = maximaHidratacion . aumentaCalorias 500 $ unaPersona

--Parte B

type Rutina = [Ejercicio]

--FUNCION una rutina esPeligrosa
esPeligrosa :: Int -> Rutina -> Persona -> Bool
esPeligrosa tiempoRutina ejerciciosRutina unaPersona = estaAgotado . hacerRutina tiempoRutina ejerciciosRutina $ unaPersona

estaAgotado :: Persona -> Bool
estaAgotado unaPersona = ((< 50) . calorias $ unaPersona) && ((< 10) . indiceHidratacion $ unaPersona)

hacerRutina :: Int -> Rutina -> Persona -> Persona
hacerRutina _ [] unaPersona = unaPersona
hacerRutina tiempoRutina (primerEjercicio : demasEjercicios) unaPersona | tiempoRutina <= tiempoLibre unaPersona = mapTiempoLibre (flip (-) tiempoRutina) (foldl (hacerEjercicio) (primerEjercicio unaPersona) demasEjercicios)
                                                                        | otherwise                              = unaPersona

mapTiempoLibre :: (Int -> Int) -> Persona -> Persona
mapTiempoLibre unaFuncion unaPersona = unaPersona { tiempoLibre = unaFuncion . tiempoLibre $ unaPersona }

hacerEjercicio :: Persona -> Ejercicio -> Persona
hacerEjercicio unaPersona unEjercicio = unEjercicio unaPersona

--FUNCION una rutina esBalanceada
esBalanceada :: Int -> Rutina -> Persona -> Bool
esBalanceada tiempoRutina ejerciciosRutina unaPersona = estaBalanceada unaPersona tiempoRutina ejerciciosRutina

estaBalanceada :: Persona -> Int -> Rutina -> Bool
estaBalanceada unaPersona tiempoRutina unaRutina = ((>80) . indiceHidratacion . hacerRutina tiempoRutina unaRutina $ unaPersona) && ((< div (calorias unaPersona) 2) . calorias . hacerRutina tiempoRutina unaRutina $ unaPersona)

--MODELADO abdominales infinitos
elAbominableAbdominal :: Persona -> Persona
elAbominableAbdominal unaPersona = hacerRutina 60 abdominalesInfinitos unaPersona

abdominalesInfinitos :: Rutina
abdominalesInfinitos = zipWith ($) (repeat abdominales) (iterate (+1) 1)

--Parte C 

type Grupo = [Persona]

--FUNCION seleccionarGrupoDeEjercicio, pensé que sería más amigable a la vista mostrar solamente los nombres de las personas del grupo, ya que quizás mostraría otros datos que no interesan y complicaría la lectura del resultado
seleccionarGrupoDeEjercicio :: Persona -> Grupo -> [String]
seleccionarGrupoDeEjercicio unaPersona unGrupoDeEjercicio = nombresPersonas . filter (mismoTiempoLibre unaPersona) $ unGrupoDeEjercicio

nombresPersonas :: Grupo -> [String]
nombresPersonas unGrupo = map nombre unGrupo

mismoTiempoLibre :: Persona -> Persona -> Bool
mismoTiempoLibre unaPersona otraPersona = (tiempoLibre unaPersona) == (tiempoLibre otraPersona)

--FUNCION promedioDeRutina, la pensé como una dupla, donde el primer elemento sería el promedio de las calorías del grupo y el segundo el promedio del indice de hidratación
promedioDeRutina :: Int -> Rutina -> Grupo -> (Int, Int)
promedioDeRutina tiempoRutina ejerciciosRutina unGrupoDeEjercicio = (promedioDe calorias (hacerRutinaJuntos tiempoRutina ejerciciosRutina unGrupoDeEjercicio), promedioDe indiceHidratacion (hacerRutinaJuntos tiempoRutina ejerciciosRutina unGrupoDeEjercicio))

hacerRutinaJuntos :: Int -> Rutina -> Grupo -> Grupo
hacerRutinaJuntos unTiempo unaRutina unGrupo = map (hacerRutina unTiempo unaRutina) unGrupo 

promedioDe :: (Persona -> Int) -> Grupo -> Int
promedioDe unaFuncion unGrupo = div (sum . (map unaFuncion) $ unGrupo) (length unGrupo) 

--Modelado de Personas para agilizar las pruebas

julio :: Persona
julio = UnaPersona { nombre = "julio", calorias = 2000, indiceHidratacion = 80, tiempoLibre = 60, equipamientos = ["pesa", "colchoneta"]}
benjamin :: Persona
benjamin = UnaPersona { nombre = "benjamin", calorias = 1520, indiceHidratacion = 45, tiempoLibre = 120, equipamientos = ["pesa", "pesa", "pesa"]}
catalina :: Persona
catalina = UnaPersona { nombre = "catalina", calorias = 1000, indiceHidratacion = 70, tiempoLibre = 180, equipamientos = ["colchoneta", "sonajero"]}
milagros :: Persona
milagros = UnaPersona { nombre = "milagros", calorias = 1260, indiceHidratacion = 25, tiempoLibre = 60, equipamientos = ["pesa", "mancuerna", "pelota"]}
juan :: Persona
juan = UnaPersona { nombre = "juan", calorias = 2500, indiceHidratacion = 90, tiempoLibre = 60, equipamientos = ["colchoneta", "cinta", "pelota"]}