use cob_conta
go

declare 
@w_cliente int,
@w_cotizacion money ,
@w_asiento int,
@w_comprobante int,
@w_max_oficina int , 
@w_max_area int,
@w_max_asientos int,
@w_msg varchar(255),
@w_fecha_proceso datetime ,
@w_oficina int, 
@w_tot_debito money, 
@w_tot_credito money,
@w_tot_debito_me money,
@w_tot_credito_me money,
@w_operacioca int, 
@w_error int,
@w_commit char(1)


select 
@w_cotizacion = 1,
@w_commit = 'N'

select 
cliente = bo_cliente, 
diferencia = sum(bo_diferencia) 
into #clientes
from cb_boc
where bo_diferencia <> 0 
and bo_cliente in (102024,102045,102069,102086,102292,102300,104431,104439) --- AQUI COLOCAR LA LISTA DE CLIENTES A ALINEAR PREVIO A ANALISIS DE CADA CASO
group by bo_cliente
having sum(bo_diferencia) = 0


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


select @w_cliente = 0

select * into #asientos from cob_conta_tercero..ct_sasiento_tmp
where 1 = 2

while (1=1) begin

   select top 1 @w_cliente = cliente 
   from #clientes
   where cliente > @w_cliente
   order by cliente
   
   if @@rowcount = 0 break
   
   
   --existan registros con diferencias 
   if not exists ( select 1 from cb_boc where bo_cliente = @w_cliente and bo_diferencia <> 0) begin 
      select @w_msg = 'ERROR: NO EXISTEN DIFERENCIAS EN EL BOC PARA ESTE CLIENTE'
      goto ERROR
   end 
   
   --verificar suma de las diferencia den cero
   --
   if (select sum(bo_diferencia) from cb_boc where bo_cliente = @w_cliente ) <> 0 begin 
      select @w_msg = 'ERROR: LAS DIFERENCIAS NO ESTAN COMPENSADAS PARA ESTE CLIENTE'
      goto ERROR
   end 
   
   truncate table #asientos
   
   /* RESERVAR UN RANGO DE COMPROBANTES */
   exec @w_error = cob_conta..sp_cseqcomp
   @i_tabla = 'cb_scomprobante', 
   @i_empresa = 1,
   @i_fecha = @w_fecha_proceso,
   @i_modulo = 7,
   @i_modo = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
   @o_siguiente = @w_comprobante out
   
   if @w_error <> 0 begin
   select @w_msg = 'ERROR: AL GENERAR NUMERO DE COMPROBANTE'
   goto ERROR
   end 
   
   
   insert into #asientos( 
   sa_producto, sa_fecha_tran, sa_comprobante,
   sa_empresa, sa_asiento, sa_cuenta,
   sa_oficina_dest, sa_area_dest, 
   sa_credito,
   sa_debito, 
   sa_credito_me,
   sa_debito_me, 
   sa_concepto, sa_cotizacion, sa_tipo_doc,
   sa_tipo_tran, sa_moneda, sa_opcion,
   sa_ente, sa_con_rete, sa_base,
   sa_valret, sa_con_iva, sa_valor_iva,
   sa_iva_retenido, sa_con_ica, sa_valor_ica,
   sa_con_timbre, sa_valor_timbre, sa_con_iva_reten,
   sa_con_ivapagado, sa_valor_ivapagado, sa_documento,
   sa_mayorizado, sa_con_dptales, sa_valor_dptales,
   sa_posicion, 
   sa_debcred, 
   sa_oper_banco, sa_cheque, sa_doc_banco, 
   sa_fecha_est, sa_detalle, sa_error)
   select 
   7, @w_fecha_proceso, @w_comprobante,
   1, 0, bo_cuenta, 
   bo_oficina, 1090, 
   case when bo_diferencia < 0 then abs(bo_diferencia) else 0 end,
   case when bo_diferencia > 0 then abs(bo_diferencia) else 0 end,
   0,
   0,
   'ALINEAMIENTO', @w_cotizacion, 'N',
   'A', cu_moneda, 0, 
   bo_cliente, 'N', 0,
   0, 'N', 0, 
   0, 'N', 0, 
   'N', 0, 'N',
   'N', 0, 'ALINEAMIENTO',
   'N', null, null,
   'S', 
   case when bo_diferencia < 0 then '2' else '1' end, 
   null, null, null, 
   null, null, 'N' 
   from cb_boc, cb_cuenta 
   where bo_cuenta = cu_cuenta 
   and abs(bo_diferencia) >= 0.01
   and bo_cliente = @w_cliente 
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL INSERTAR LOS ASIENTOS'
      goto ERROR
   end 
   
   select @w_asiento = 0
   
   update #asientos set 
   sa_asiento = @w_asiento, 
   @w_asiento = @w_asiento +1
   
   
   --datos 
   select 
   @w_max_oficina = max(sa_oficina_dest),
   @w_max_area = max(sa_area_dest),
   @w_max_asientos = max(sa_asiento),
   @w_tot_debito = sum(sa_debito),
   @w_tot_credito = sum(sa_credito),
   @w_tot_debito_me = sum(sa_debito_me),
   @w_tot_credito_me = sum(sa_credito_me)
   from #asientos
   
   --- 
   
   if @@trancount = 0 begin 
   select @w_commit = 'S'
      begin tran 
   end 
   
   insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock) (
   sc_producto, sc_comprobante, sc_empresa,
   sc_fecha_tran, sc_oficina_orig, sc_area_orig,
   sc_digitador, sc_descripcion, sc_fecha_gra, 
   sc_perfil, sc_detalles, sc_tot_debito,
   sc_tot_credito, sc_tot_debito_me, sc_tot_credito_me,
   sc_automatico, sc_reversado, sc_estado,
   sc_mayorizado, sc_observaciones, sc_comp_definit,
   sc_usuario_modulo, sc_tran_modulo, sc_error)
   values (
   7, @w_comprobante, 1,
   @w_fecha_proceso, @w_max_oficina, @w_max_area,
   'CONSOLA', 'ALINEAMIENTO', getdate(), 
   'CCA_EST', @w_max_asientos, @w_tot_debito,
   @w_tot_credito, @w_tot_debito_me, @w_tot_credito_me,
   7, 'N', 'I',
   'N', null, null,
   'sa', 0, 'N')
   
   if @@error <> 0 begin 
   select @w_msg = 'ERROR: AL INSERTAR DETALLE DE COMPROBANTES'
   goto ERROR
   end 
   
   
   
   insert into cob_conta_tercero..ct_sasiento_tmp
   select * from #asientos
   
   select * from #asientos
   
   select top 1 
   @w_operacioca= op_operacion, 
   @w_oficina =op_oficina
   from cob_cartera..ca_operacion 
   where op_cliente = @w_cliente 
   and op_estado in ( 1,2,4)
   
   update cob_cartera..ca_transaccion set
   tr_ofi_oper = @w_oficina
   where tr_operacion = @w_operacioca
   and tr_ofi_oper <> @w_oficina
   
   if @@error <> 0 begin 
   select @w_msg = 'ERROR: AL ACTUALIZAR LA OFICINA EN LA TRANSACCION'
   goto ERROR
   end 
   
   
   if @w_commit = 'S' begin 
   select @w_commit = 'N'
   commit tran 
   end 
   
   
   goto SIGUIENTE 
   
   ERROR:
   print @w_msg 
   
   if @w_commit = 'S' begin 
   select @w_commit = 'N'
   rollback tran 
   end 
   
   SIGUIENTE: 
   end
   
go

drop table #clientes
drop table #asientos

go

----xxxxxxxxxxxxxxxxxxxxxxx
USE cob_conta
GO
SELECT * FROM cob_conta..cb_det_perfil 
WHERE dp_producto = 7 
AND dp_perfil IN ('CCA_GAR')
AND dp_codval IN (141)

DELETE FROM cob_conta..cb_det_perfil 
WHERE dp_producto = 7 
AND dp_perfil IN ('CCA_GAR')
AND dp_codval IN (141)

SELECT * FROM cob_conta..cb_det_perfil 
WHERE dp_producto = 7 
AND dp_perfil IN ('CCA_GAR')
AND dp_codval IN (141)
GO

----xxxxxxxxxxxxxxxxxxxxxxx
USE cob_conta
GO

SELECT * FROM cob_conta..cb_det_perfil 
WHERE dp_producto = 7 
AND dp_perfil IN ('CCA_GAR')
GO

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 7, '14019101', 'CTB_OF', '1', 141, 'N', 'O', NULL, 'L')
GO

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 8, '241302', 'CTB_OF', '2', 141, 'N', 'O', NULL, 'L')
GO

SELECT * FROM cob_conta..cb_det_perfil 
WHERE dp_producto = 7 
AND dp_perfil IN ('CCA_GAR')
GO
