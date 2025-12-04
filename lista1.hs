-- questão 1
ehTriangulo a b c =
  a + b > c && a + c > b && b + c > a

-- questão 2

tipoTriangulo a b c =
  if a == b && b == c
    then "eh equilatero"
    else
      if a == b || a == c || b == c
        then "eh isosceles"
        else "eh escaleno"

-- questão 3

trianguloo a b c =
  if ehTriangulo a b c
    then
      tipoTriangulo a b c
    else "nao eh triangulo"

-- questao 4
somaPares 0 = 0
somaPares n =
  if even n
    then n + somaPares (n - 2)
    else somaPares (n - 1)

-- questao 5
somaPot2m m 1 = m
somaPot2m m n = 2 ^ n * m + somaPot2m m (n - 1)

-- questao 6

primo n = [x | x <- [2 .. n - 1], n `mod` x == 0]

-- questao 7
seriePI n = aux n 1 1 0

aux n i s soma
  | 4 / fromIntegral i > 4 / fromIntegral n = aux n (i + 2) (-s) (soma + s * 4 / fromIntegral i)
  | otherwise = soma

-- n lembro se podia usar guardas mas usando..