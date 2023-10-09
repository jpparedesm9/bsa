
UPDATE cob_cartera..ca_transaccion SET tr_ofi_usu=tr_ofi_oper

WHERE tr_secuencial =1 
AND tr_operacion IN (123216,123219,123222,123225
                     ,123228,123231,123234,123237)
AND tr_estado='ING'  