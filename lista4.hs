meuMap :: (a -> b) -> [a] -> [b]
meuMap _ [] = []
meuMap f (x:xs) = f x : meuMap f xs

meuFilter :: (a -> Bool) -> [a] -> [a]
meuFilter _ [] = []
meuFilter f (x:xs)
    | f x = x : meuFilter f xs
    | otherwise = meuFilter f xs

quadrado = \x -> x * x
resultado1 = meuMap quadrado [1..10]

raiz = \x -> sqrt x
resultado2 = meuMap raiz [4,9,16,25,36]

somar_pares :: [Int] -> Int
somar_pares xs = sum (filter even xs)

ehPrimo :: Int -> Bool
ehPrimo n = n > 1 && null [x | x <- [2..n-1], n `mod` x == 0]

filtraPrimos :: [Int] -> [Int]
filtraPrimos xs = filter ehPrimo xs

applyAll :: [a -> b] -> a -> [b]
applyAll fs x = [f x | f <- fs]

foldMap2 :: (a -> b) -> (b -> b -> b) -> b -> [a] -> b
foldMap2 f g z xs = foldr g z (map f xs)

fatorial :: (Floating a, Enum a) => a -> a
fatorial n = product [1..n]

meuCosseno :: Double -> Double
meuCosseno x = sum [((-1) ** n) * (x ** (2 * n)) / fatorial (2 * n) | n <- [0..10]]
