module Main where

-- Importa os arquivos dos outros alunos
import Tipos
import Logica

import qualified Data.Map as Map
import Data.Time.Clock (getCurrentTime)
import System.IO
import Control.Exception (catch, IOException)

-- Persistência de Dados
salvarEstado :: Inventario -> LogEntry -> IO ()
salvarEstado inv logEntry = do
    writeFile "Inventario.dat" (show inv)
    appendFile "Auditoria.log" (show logEntry ++ "\n")

registrarFalhaLog :: LogEntry -> IO ()
registrarFalhaLog logEntry = 
    appendFile "Auditoria.log" (show logEntry ++ "\n")

-- Loop Interativo
loop :: Inventario -> IO ()
loop inv = do
    putStrLn "\n--- Sistema de Inventario ---"
    putStrLn "1. Adicionar Item (Teste)"
    putStrLn "2. Sair"
    putStr "Escolha uma opcao: "
    hFlush stdout
    
    opcao <- getLine
    tempoAtual <- getCurrentTime
    
    case opcao of
        "1" -> do
            let novoItem = Item "001" "Mouse" 50 "Perifericos"
            -- Chama a SUA função (do Aluno 2)
            case addItem tempoAtual novoItem inv of
                Right (novoInv, logGerado) -> do
                    salvarEstado novoInv logGerado
                    putStrLn ">>> Sucesso! Salvo no disco."
                    loop novoInv
                
                Left erroMsg -> do
                    putStrLn $ ">>> FALHA: " ++ erroMsg
                    registrarFalhaLog (LogEntry tempoAtual Add erroMsg (Falha erroMsg))
                    loop inv
                    
        "2" -> putStrLn "Saindo..."
        
        _ -> do
            putStrLn "Opcao invalida."
            loop inv

-- Inicialização
main :: IO ()
main = do
    conteudo <- catch (readFile "Inventario.dat") tratandoErroLeitura
    
    let invInicial = if conteudo == "" 
                     then Map.empty 
                     else read conteudo :: Inventario
    
    putStrLn $ "Iniciado com " ++ show (Map.size invInicial) ++ " item(ns)."
    loop invInicial
  where
    tratandoErroLeitura :: IOException -> IO String
    tratandoErroLeitura _ = return ""