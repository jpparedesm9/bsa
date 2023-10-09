/************************************************************************/
/*  Archivo:            reconsocb.sp                                    */
/*  Stored procedure:   cob_remesas..sp_consolida_trn_cb                */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Corresponsales Bancarios                        */
/*  Disenado por:       Luis Carlos Moreno C.                           */
/*  Fecha de escritura: 13-Mar-2014                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/* Req 420. Genera insumo informe consolidado de redes posicionadas.    */
/************************************************************************/

use cob_remesas
go
 
if exists (select 1 from sysobjects where name = 'sp_consolida_trn_cb')
   drop proc sp_consolida_trn_cb
go

create proc sp_consolida_trn_cb(
@s_user           varchar(30) = null,
@s_term           varchar(30) = null,
@s_rol            int = null,
@s_ofi            smallint = null,
@s_ssn            int = null,
@t_trn            int = null,
@i_operacion      char(1) = null,
@i_codigo_red     int = null,
@i_estado         char(1) = null,
@i_fecha_desde    datetime = null,
@i_fecha_hasta    datetime = null,
@i_sec            int = 0,
@i_modo           int = 0
)

as
declare 
@w_sp_name              varchar(50),
@w_error                int,
@w_msg                  varchar(255),
@w_errores              varchar(255),
@w_secuencial           int

select @w_sp_name         = 'sp_consolida_trn_cb',
       @w_error           = 0,
       @w_msg             = ''

if @i_operacion = 'S'
begin
   if @i_modo = 0
   begin
      delete from cob_remesas..re_consolidado_trn_cb 
	  where ct_usuario = @s_user
	  
      select 
      ct_fecha      = ts_fecha,       
      ct_cod_red    = ac_codigo,      
      ct_nom_red    = (select ah_nombre
                       from cob_ahorros..ah_cuenta,
                       cob_remesas..re_mantenimiento_cb 
                       where mc_cta_banco = ah_cta_banco
                       and   mc_cod_cb = ac_codigo
                       and   mc_estado = 'H'),
      ct_cant_pagos = case when ts_tipo_tran = 26502 then COUNT(1)      else 0 end,
      ct_vlr_pagos  = case when ts_tipo_tran = 26502 then SUM(ts_monto) else 0 end,             
      ct_cant_cons  = case when ts_tipo_tran = 26518 then COUNT(1)      else 0 end,
      ct_cant_dep   = case when ts_tipo_tran = 26520 then COUNT(1)      else 0 end,
      ct_vlr_dep    = case when ts_tipo_tran = 26520 then SUM(ts_monto) else 0 end,             
      ct_cant_ret   = case when ts_tipo_tran = 26519 then COUNT(1)      else 0 end,
      ct_vlr_ret    = case when ts_tipo_tran = 26519 then SUM(ts_monto) else 0 end,
      ct_estado     = ts_estado
      into #re_consolidado_trn_cb
      from cobis..ws_tran_servicio, cobis..cl_asoc_clte_serv, cobis..cl_oficina
	  where ts_fecha between @i_fecha_desde and @i_fecha_hasta
      and   (ts_estado  = @i_estado or @i_estado is null)
      and   (ts_oficina = @i_codigo_red or @i_codigo_red is null)
      and   ts_oficina  = ac_codigo 
      and   ac_tipo_cb  = 'O'
	  and   ts_campo4   <> '260'
	  and   ts_tipo_tran in (26502,26518, 26519,26520) 
      and   ac_estado   = 'H'
	  
      and   ts_canal    = 9
      and   of_oficina = ts_oficina
      group by ts_fecha,  ac_codigo, of_nombre, ts_estado, ts_tipo_tran
	  
	  if @@error <> 0
      begin
         select @w_error = 360005,
                @w_msg = 'NO SE ENCONTRARON MOVIMIENTOS PARA LA RED POSICIONADA'
         goto ERROR
      end
      
	  insert into cob_remesas..re_consolidado_trn_cb
      select 
         convert(varchar(12), ct_fecha, 103),
         ct_cod_red,    
         ct_nom_red,      
         sum(ct_cant_pagos),
         sum(ct_vlr_pagos),   
         sum(ct_cant_cons),   
         sum(ct_cant_dep),     
         sum(ct_vlr_dep),
         sum(ct_cant_ret),    
         sum(ct_vlr_ret),     
         ct_estado,
         0,
		 @s_user
      from #re_consolidado_trn_cb 
	  where (ct_estado = @i_estado or @i_estado is null)
	  group by ct_fecha, ct_cod_red, ct_nom_red, ct_estado
      order by ct_fecha asc
      
	  if @@error <> 0
      begin
         select @w_error = 360005,
                @w_msg = 'NO SE ENCONTRARON MOVIMIENTOS PARA LA RED POSICIONADA'
         goto ERROR
      end
	  
      select @w_secuencial = 0
      update cob_remesas..re_consolidado_trn_cb
      set ct_secuencial  = @w_secuencial,
          @w_secuencial  = @w_secuencial  + 1
		  
	  if @@error <> 0
      begin
         select @w_error = 360005,
                @w_msg = 'NO SE ENCONTRARON MOVIMIENTOS PARA LA RED POSICIONADA'
         goto ERROR
      end
      
	  set rowcount 20
	  -- DEVUELVE DATOS DE CONSULTA
      select
      'FECHA'                   = ct_fecha,
      'CODIGO'                  = ct_cod_red,
      'NOMBRE'                  = ct_nom_red,
      'CANTIDAD PAGOS'          = ct_cant_pagos,
      'VALOR PAGOS'             = ct_vlr_pagos,
      'CANTIDAD CONSULTA SALDO' = ct_cant_cons,
      'CANTIDAD DEPOSITOS'      = ct_cant_dep,
      'VALOR DEPOSITOS'         = ct_vlr_dep,
      'CANTIDAD RETIROS'        = ct_cant_ret,
      'VALOR RETIROS'           = ct_vlr_ret,
      'ESTADO'                  = case when ct_estado = 'A' then 'EXITOSA' else 'DECLINADA' end,
      'SECUENCIAL'              = ct_secuencial
      from cob_remesas..re_consolidado_trn_cb
	  where (ct_estado = @i_estado or @i_estado is null)
	  and    ct_usuario = @s_user
      order by ct_secuencial
      
      if @@rowcount < 20
	  begin
	     delete from cob_remesas..re_consolidado_trn_cb 
		 where ct_usuario = @s_user
	  end
	  
   end
   else
   begin 
      set rowcount 20
      -- DEVUELVE DATOS DE CONSULTA
      select
      'FECHA'                   = ct_fecha,
      'CODIGO'                  = ct_cod_red,
      'NOMBRE'                  = ct_nom_red,
      'CANTIDAD PAGOS'          = ct_cant_pagos,
      'VALOR PAGOS'             = ct_vlr_pagos,
      'CANTIDAD CONSULTA SALDO' = ct_cant_cons,
      'CANTIDAD DEPOSITOS'      = ct_cant_dep,
      'VALOR DEPOSITOS'         = ct_vlr_dep,
      'CANTIDAD RETIROS'        = ct_cant_ret,
      'VALOR RETIROS'           = ct_vlr_ret,
      'ESTADO'                  = case when ct_estado = 'A' then 'EXITOSA' else 'DECLINADA' end,
      'SECUENCIAL'              = ct_secuencial
      from cob_remesas..re_consolidado_trn_cb
      where ct_secuencial > @i_sec
	  and   (ct_estado  = @i_estado or @i_estado is null)
	  and    ct_usuario = @s_user
      order by ct_secuencial
	  
	  if @@rowcount < 20
	  begin
	     delete from cob_remesas..re_consolidado_trn_cb 
		 where ct_usuario = @s_user
	  end
   end
end
return 0

ERROR:

   set rowcount 0
   exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_num  = @w_error,
   @i_msg  = @w_msg,
   @i_sev  = 0
   

return @w_error

go

