--Parcial Gravity Falls

import Text.Show.Functions()

--Modelado Personas

data Persona = UnaPersona {
    edad        :: Int,
    items       :: [Item],
    experiencia :: Int
} deriving (Show, Eq)

type Item = String

data Criatura = UnaCriatura {
    peligrosidad   :: Int,
    paraDeshacerse :: Persona -> Bool
} deriving Show

siempreDetras :: Criatura
siempreDetras = UnaCriatura {
    peligrosidad   = 0,
    paraDeshacerse = deshacerseSiempreDetras
}

gnomos :: Int -> Criatura
gnomos cantidadGnomos = UnaCriatura {
    peligrosidad   = 2 ^ (cantidadGnomos),
    paraDeshacerse = deshacerseGnomos
}

fantasma :: Int -> (Persona -> Bool) -> Criatura
fantasma poder deshacerseFantasmas = UnaCriatura {
    peligrosidad   = 20 * poder,
    paraDeshacerse = deshacerseFantasmas
}

deshacerseGnomos :: Persona -> Bool
deshacerseGnomos unaPersona = tiene "Soplador de Hojas" unaPersona

deshacerseSiempreDetras :: Persona -> Bool
deshacerseSiempreDetras unaPersona = False

tiene :: String -> Persona -> Bool
tiene unItem unaPersona = elem unItem (items unaPersona)

enfrentamiento :: Persona -> Criatura -> Persona
enfrentamiento unaPersona unaCriatura 
 | (paraDeshacerse unaCriatura) unaPersona = ganarExperiencia (peligrosidad unaCriatura) unaPersona
 | otherwise                               = ganarExperiencia 1 unaPersona

ganarExperiencia :: Int -> Persona -> Persona
ganarExperiencia experienciaGanada unaPersona = mapExperiencia (+ experienciaGanada) unaPersona

mapExperiencia :: (Int -> Int) -> Persona -> Persona
mapExperiencia unaFuncion unaPersona = unaPersona { experiencia = unaFuncion . experiencia $ unaPersona }

cuantaExperienciaGana :: Persona -> [Criatura] -> Int
cuantaExperienciaGana unaPersona unasCriaturas = experiencia (humanoVsCriaturas unaPersona unasCriaturas) - experiencia unaPersona
--                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^^^
--                                         experiencia de la persona luego de enfrentarse a las criaturas   experiencia de la persona antes de enfrentarse a las criaturas

humanoVsCriaturas :: Persona -> [Criatura] -> Persona
humanoVsCriaturas unaPersona unasCriaturas = foldl enfrentamiento unaPersona unasCriaturas
--                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--                       hace enfrentar a una persona con una lista de criaturas, luego nos muestra como queda la persona después de enfrentarlos a todos

--Persona de ejemplo para facilitar las pruebas

dipper :: Persona
dipper = UnaPersona {
    edad        = 12,
    items       = ["Soplador de Hojas", "Disfraz de Oveja"],
    experiencia = 20
}

ejemploDeEnfrentamiento :: Persona -> Persona
ejemploDeEnfrentamiento unaPersona = humanoVsCriaturas unaPersona listaCriaturasEjemplo

listaCriaturasEjemplo :: [Criatura]
listaCriaturasEjemplo = [siempreDetras, (gnomos 10), (fantasma 3 vencerAlFantasmaCat3), (fantasma 1 vencerAlFantasmaCat1)]

vencerAlFantasmaCat1 :: Persona -> Bool
vencerAlFantasmaCat1 unaPersona = (> 10) . experiencia $ unaPersona

vencerAlFantasmaCat3 :: Persona -> Bool
vencerAlFantasmaCat3 unaPersona = tieneMenosDe13 unaPersona && tiene "Disfraz de Oveja" unaPersona

tieneMenosDe13 :: Persona -> Bool
tieneMenosDe13 unaPersona = (< 13) . edad $ unaPersona

--Definicion recursica zipWithIf

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _ _ [] = [] --Caso base 1
zipWithIf _ _ [] _ = [] --Caso base 2
zipWithIf unaFuncion unaCondicion (x:xs) (y:ys) 
    | unaCondicion y = y : zipWithIf unaFuncion unaCondicion (x:xs) ys
    | otherwise      = unaFuncion x y : zipWithIf unaFuncion unaCondicion xs ys

abecedarioDesde :: Char -> [Char]
abecedarioDesde letra = [letra..'z'] ++ ['a'..letra]

desencriptarLetra :: Char -> Char -> Char
desencriptarLetra empezarAbecedario letraADesencriptar 
    | esLetra letraADesencriptar = (abecedarioDesde empezarAbecedario) !! (length (abecedarioHasta (abecedarioDesde empezarAbecedario) letraADesencriptar) + 2)
    | otherwise = letraADesencriptar

esLetra :: Char -> Bool
esLetra unaLetra = elem unaLetra letras

letras :: [Char]
letras = ['a'..'z']

abecedarioHasta :: [Char] -> Char -> [Char]
abecedarioHasta (x:xs) unaLetra 
    | esLaMismaLetra x unaLetra = [unaLetra]
    | otherwise                 = x : abecedarioHasta xs unaLetra

esLaMismaLetra :: Char -> Char -> Bool
esLaMismaLetra unaLetra otraLetra = unaLetra == otraLetra

cesar :: Char -> String -> String
cesar letraClave mensajeADescifrar = map (desencriptarLetra letraClave) mensajeADescifrar

cesarConTodasLasLetras :: [Char] -> String -> String
cesarConTodasLasLetras [] _ = []
cesarConTodasLasLetras (x:xs) unasPalabras = cesar x unasPalabras ++ " " ++ cesarConTodasLasLetras xs unasPalabras