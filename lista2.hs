-- questão 1 

pertence :: Integer->[Integer]->Bool
pertence n (x:xs) 
    | n == x = True
    | otherwise = pertence n xs

-- questao 2

intersecao :: [Integer]->[Integer]->[Integer]
intersecao [] _ = []
intersecao _ [] = []
intersecao (x:xs) (y:ys)
    | x == y = x : intersecao xs ys
    | x < y = intersecao xs (y:ys)
    | otherwise = intersecao (x:xs) ys


-- questao 3
inverso :: [Integer]->[Integer]
inverso [] = []
inverso (x:xs) = inverso xs ++ [x] -- passa o x pra parte de trás da lista e concatena ela, e faz recursivamente


-- questao 4

nUltimos n