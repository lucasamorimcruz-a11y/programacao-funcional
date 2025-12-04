import Data.Char (isAlpha, toLower)
import Data.List (sort)
type Doc = String
type Linha = String
type Palavra = String

separarLinhas :: Doc -> [Linha]
separarLinhas = lines

limparLinha :: Linha -> Linha
limparLinha [] = []
limparLinha (c : cs)
  | isAlpha c = toLower c : limparLinha cs
  | otherwise = ' ' : limparLinha cs

numLinhas :: [Linha] -> [(Int, Linha)]
numLinhas ls = zip [1 ..] ls

numeraPalavras :: [(Int, Linha)] -> [(Int, Palavra)]
numeraPalavras [] = []
numeraPalavras ((n, linha) : resto) =
  let palavras = words (limparLinha linha)
      palavrasOK = filter (\p -> length p >= 3) palavras
      pares = [(n, p) | p <- palavrasOK]
   in pares ++ numeraPalavras resto

ordenar :: [(Int, Palavra)] -> [(Int, Palavra)]
ordenar = sort

agrupar :: [(Int, Palavra)] -> [([Int], Palavra)]
agrupar [] = []
agrupar ((n, p) : xs) =
  let (iguais, dif) = pegaIguais p xs
      nums = n : map fst iguais
   in (nums, p) : agrupar dif

pegaIguais ::
  Palavra ->
  [(Int, Palavra)] ->
  ([(Int, Palavra)], [(Int, Palavra)])
pegaIguais _ [] = ([], [])
pegaIguais p ((n2, p2) : xs)
  | p == p2 =
      let (i, d) = pegaIguais p xs
       in ((n2, p2) : i, d)
  | otherwise =
      let (i, d) = pegaIguais p xs
       in (i, (n2, p2) : d)

eliminarRep :: [([Int], Palavra)] -> [([Int], Palavra)]
eliminarRep [] = []
eliminarRep ((nums, p) : resto) =
  let semRep = removeRep nums
   in (semRep, p) : eliminarRep resto

removeRep :: [Int] -> [Int]
removeRep [] = []
removeRep (x : xs)
  | x `elem` xs = removeRep xs
  | otherwise = x : removeRep xs

construirIndice :: Doc -> [([Int], Palavra)]
construirIndice =
  eliminarRep
    . agrupar
    . ordenar
    . numeraPalavras
    . numLinhas
    . separarLinhas

main :: IO ()
main = do
  putStrLn "nnmoe do arquivo:"
  nome <- getLine
  conteudo <- readFile nome
  let indice = construirIndice conteudo
  mapM_ print indice