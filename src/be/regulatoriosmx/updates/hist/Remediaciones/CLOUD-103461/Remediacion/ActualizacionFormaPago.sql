

use cob_cartera 
go 


declare @w_max_asiento int 


select @w_max_asiento = max(dp_asiento) from cob_conta..cb_det_perfil
where dp_perfil = 'CCA_PAG'

select @w_max_asiento = @w_max_asiento +1


if not exists (select 1 from ca_producto where cp_producto = 'SALDOSMINI')  begin 
  insert into cob_cartera..ca_producto (cp_producto, cp_descripcion, cp_categoria, cp_moneda, cp_codvalor, cp_desembolso, cp_pago, cp_atx, cp_retencion, cp_pago_aut, cp_pcobis, cp_producto_reversa, cp_afectacion, cp_estado, cp_act_pas, cp_instrum_SB, cp_canal)
  values  ('SALDOSMINI', 'PAGO PARA SALDOS MENOR CUANTIA', 'SALDOSMINI', 0, 140, 'N', 'S', 'N', 0, 'N', NULL, 'SALDOSMINI', 'D', 'V', 'T', NULL, NULL)
end 

if not exists ( select 1 from cob_conta..cb_det_perfil where dp_producto = 7 and  dp_perfil = 'CCA_PAG' and dp_codval  = 140) begin 
   insert into cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
   values (1, 7, 'CCA_PAG', @w_max_asiento, '510511900201', 'CTB_OF', '1', 140, 'N', 'O', NULL, 'L')
end 


go