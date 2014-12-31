module F1 where

-- Vad ska de andra funktionernas typsignaturer vara?
fib :: Integer -> Integer
fib n = if n == 0 || n == 1
	then n
	else fib' n
fib' n = fib (n-1) + fib (n-2)

rovarsprak :: String -> String
rovarsprak s = s
karpsravor :: String -> String
karpsravor s = s
medellangd :: String -> Double
medellangd s = 1.0
skyffla :: String -> String
skyffla s = s