module Logica where

-- Importa o arquivo do Aluno 1
import Tipos 

import qualified Data.Map as Map
import Data.Time.Clock (UTCTime)

-- 1. Lógica para Adicionar Item 
addItem :: UTCTime -> Item -> Inventario -> Either String ResultadoOperacao
addItem tempo atualItem inv = 
    let idItem = itemID atualItem
    in if Map.member idItem inv
       then Left "Erro: Item ja existe no inventario. Use a atualizacao."
       else 
           let novoInv = Map.insert idItem atualItem inv
               logEntry = LogEntry tempo Add ("Adicionado item: " ++ nome atualItem) Sucesso
           in Right (novoInv, logEntry)


