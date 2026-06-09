module Tipos where

import qualified Data.Map as Map
import Data.Time.Clock (UTCTime)

-- Definição dos tipos do sistema
data Item = Item { 
    itemID :: String, 
    nome :: String, 
    quantidade :: Int, 
    categoria :: String 
} deriving (Show, Read, Eq)

type Inventario = Map.Map String Item

data AcaoLog = Add | Remove | Update | QueryFail deriving (Show, Read)

data StatusLog = Sucesso | Falha String deriving (Show, Read)

data LogEntry = LogEntry { 
    timestamp :: UTCTime, 
    acao :: AcaoLog, 
    detalhes :: String, 
    status :: StatusLog 
} deriving (Show, Read)

-- O resultado de uma operação bem-sucedida sempre devolve o inventário atualizado e o log
type ResultadoOperacao = (Inventario, LogEntry)