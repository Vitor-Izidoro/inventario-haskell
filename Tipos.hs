module Tipos where

import Data.Map (Map)
import Data.Time.Clock (UTCTime)

-- item: Registro básico do domínio
data Item = Item {
    itemID     :: String,
    nome       :: String,
    quantidade :: Int,
    categoria  :: String
} deriving (Show, Read, Eq)

-- inventario: Estrutura de dados para armazenar os itens
type Inventario = Map String Item

-- acaoLog: Tipo de dado algébrico (ADT) para as ações
data AcaoLog = Add 
             | Remove 
             | Update 
             | QueryFail
             deriving (Show, Read, Eq)

-- statusLog: ADT para o resultado da operação
data StatusLog = Sucesso 
               | Falha String
               deriving (Show, Read, Eq)

-- logEntry: Registro completo para auditoria
data LogEntry = LogEntry {
    timestamp :: UTCTime,
    acao      :: AcaoLog,
    detalhes  :: String,
    status    :: StatusLog
} deriving (Show, Read, Eq)
