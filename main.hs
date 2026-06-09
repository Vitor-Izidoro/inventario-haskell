module Main where

import Tipos 
import Data.Time.Clock (getCurrentTime)

main :: IO ()
main = do
    putStrLn "--- Iniciando Testes de Serializacao (Aluno 1) ---"
    
    -- testando a serialização do Item
    let itemOriginal = Item "001" "Processador ARMv7" 5 "Hardware"
    
    -- transforma o Item em uma String (para salvar no disco depois)
    let textoSerializado = show itemOriginal
    putStrLn $ "\nItem Serializado: " ++ textoSerializado
    
    -- transforma a String de volta em Item (para ler do disco depois)
    let itemRecuperado = read textoSerializado :: Item
    
    if itemOriginal == itemRecuperado
        then putStrLn "[OK] Teste de Item: (read . show) funciona perfeitamente."
        else putStrLn "[ERRO] Falha na conversao do Item."

    -- 2. testando a serialização do LogEntry (que usa UTCTime e ADTs)
    agora <- getCurrentTime
    let logOriginal = LogEntry agora Add "Adicionado 5 unidades de Hardware" Sucesso
    
    let logTexto = show logOriginal
    let logRecuperado = read logTexto :: LogEntry
    
    if logOriginal == logRecuperado
        then putStrLn "[OK] Teste de LogEntry: (read . show) funciona perfeitamente."
        else putStrLn "[ERRO] Falha na conversao do LogEntry."
        
    putStrLn "\n--- Testes Concluidos ---"