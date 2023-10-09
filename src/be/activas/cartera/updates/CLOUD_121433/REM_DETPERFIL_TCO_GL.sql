use cob_conta 
go 



if  not exists (select 1 from cb_det_perfil where dp_empresa = 1 and dp_producto = 7 and dp_perfil = 'CCA_EST' and dp_asiento =19) 	begin
        
  INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
  VALUES (1, 7, 'CCA_EST', 19, '240191', 'CTB_OF', '2', 132, 'N', 'D', NULL, 'L')


end else begin 

   print 'EXISTE DETALLE DE PERFIL '


end 