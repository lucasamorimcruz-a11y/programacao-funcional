import Data.Char (toLower)
import Distribution.Compat.CharParsing (lower)

type Word' = String

type Line = String

type Doc = String

data Tree = Node Word' [Int] Tree Tree | Leaf deriving (Show)

-- função que não esta no pedido mas que junta maiusculas com minisculas, tendo em vista que sem ela, "Aqui" conta como diferente de aqui
lowerCaps :: String -> String
lowerCaps = map toLower

numLines :: [Line] -> [(Int, Line)]
numLines linesOfText = zip [1 ..] linesOfText

allNumWords :: [(Int, Line)] -> [(Int, Word')]
allNumWords [] = [] 
allNumWords ((num, palavra) : xs) =
  map (\p -> (num,  lowerCaps p)) (words palavra) ++ allNumWords xs
 
insOrd :: (Ord a) => a -> [a] -> [a] -- só compila com Ord
insOrd x [] = [x]
insOrd x (y : ys)
  | x == y = y : ys
  | x < y = x : y : ys
  | otherwise = y : insOrd x ys

ins :: Word' -> Int -> Tree -> Tree
ins palavra nLinha Leaf = Node palavra [nLinha] Leaf Leaf 
ins palavra nLinha (Node p linha esq dir)
  | palavra == p = Node p (insOrd nLinha linha) esq dir
  | palavra < p = Node p linha (ins palavra nLinha esq) dir
  | otherwise = Node p linha esq (ins palavra nLinha dir)

mIndexTree :: [(Int, Word')] -> Tree
mIndexTree [] = Leaf
mIndexTree ((nLinha, palavra) : xs) = ins palavra nLinha (mIndexTree xs)

makeIndexTree :: Doc -> Tree
makeIndexTree doc = mIndexTree (allNumWords (numLines (lines doc)))

printOrdenado :: Tree -> IO ()
printOrdenado Leaf = return ()
printOrdenado (Node  palavra linhas esq dir) = do
  printOrdenado esq
  putStrLn (palavra ++ " :" ++ show linhas)
  printOrdenado dir

main :: IO ()
main = do
  arq <- readFile "arquivo.txt"
  printOrdenado (makeIndexTree  arq)
