
/************************************************************************/
/* Archivo                :     renovac.sp                              */
/* Stored procedure       :     sp_renovacion                           */
/* Base de datos          :     cob_cartera                             */
/* Producto               :     Cartera                                 */
/* Disenado por           :     R.Garces                                */
/* Fecha de escritura     :     11/Mar/98                               */
/* **********************************************************************/
/*                             IMPORTANTE                               */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* 'MACOSA'.                                                            */
/* Su uso no autorizado queda expresamente prohibido asi como           */
/* cualquier alteracion o agregado hecho por alguno de sus              */
/* usuarios sin el debido consentimiento por escrito de la              */
/* Presidencia Ejecutiva de MACOSA o su representante.                  */
/* **********************************************************************/
/*                             PROPOSITO                                */
/*  Aplicar los pagos para cancelar el(los) prestamo(s) a renovar       */
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      06/Dic/2016     I. Yupa         AJUSTES CONTABLES MEXICO        */
/*      07/06/2021       AGO       Considerar cuando no tiene op        */
/*                                 Anterior solo deje lo solicitado     */
/* **********************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_renovacion')
   drop proc sp_renovacion
go
CREATE proc sp_renovacion
   @s_rol              tinyint      = null,
   @s_ssn               int         = null,
   @s_sesn              int         = null,
   @s_date              datetime,
   @s_user              login       = null,
   @s_term              descripcion = null,
   @s_ofi               smallint    = null,
   @i_banco             cuenta      = null, -- OBLIGACION NUEVA
   @i_detalledes        char(1)     = 'S',
   @i_verificar         char(1)     = 'N',
   @i_valor_renovar     money       = null,
   @i_monto_pago        money       = null,
   @i_forma_pago        catalogo    = null,
   @i_cuenta_banco      cuenta      = null,
   @i_formato_fecha     int         = 101
as
declare
   @w_sp_name                    varchar(32),
   @w_forma_pago                 catalogo,
   @w_fecha_ult_proc             datetime,
   @w_error                      int,
   @w_operacionca                int,
   @w_moneda                     tinyint,
   @w_tramite_nueva              int,
   @w_banco_renovada             varchar(24),
   @w_est_cancelado              smallint,
   @w_est_suspenso               smallint,
   @w_est_castigado              smallint,
   @w_est_vencido                smallint,
   @w_est_vigente                smallint,   
   @w_estado_op_vieja            tinyint,
   @w_div_vigente                int,
   @w_estado_fin                     tinyint,
   @w_secuencial_ing             int,
   @w_fecha_ini_nueva            datetime,
   @w_num_renovaciones_ant       smallint,
   @w_commit                     char(1),
   @w_msg                        varchar(120),
   @w_monto_pago                 money,
   @w_datos_renovada             varchar(64),
   @w_clase                      varchar(10),
   @w_cliente                    int,
   @w_cod_comercial              varchar(10),
   @w_tipo_tramite               varchar(1),
   @w_oficial                    int,
   @w_secuencial                 int,
   @w_return                     int,
   @w_ult_tramite                int,         --Inc_7615
   @w_cl_cartera                 varchar(10), --Inc_7615
   @w_clase_nva                  varchar(10),  --Inc_7615   
   @w_estado_operacion           tinyint,
   @w_fecha_ult_proceso          datetime,
   @w_beneficiario               int,
   @w_nombre                     varchar(50),
   @w_op_fecha_ult_proceso       datetime,
   @w_cotizacion_hoy             float = 0,
   @w_num_dec_mn                 tinyint,
   @w_monto_pagado               money = 0,
   @w_monto_renovar_mn           money = 0,
   @w_operacionca_n              int,
   @w_desembolso                 int,
   @w_plazo_no_vigente           tinyint,
   @w_min_fecha_vig              datetime,
   @w_saldo_ant                  money,
   @w_operacion_ant              int,
   @w_oficina_ant                int,
   @w_toperacion_ant             catalogo,  
   @w_moneda_ant                 money ,         
   @w_fecha_ult_proceso_ant      datetime ,
   @w_oficial_ant                     int ,
   @w_fecha_proceso              datetime,
   @w_secuencial_pag             int, 
   @w_estado                     int ,
   @w_banco_generado             cuenta 
   
-- INICIALIZACION DE VARIABLES
select 
@w_sp_name   = 'sp_renovacion',
@w_commit    = 'N'

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_castigado  = @w_est_castigado out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_vigente    = @w_est_vigente   out

/* DETERMINAR LA FORMA DE PAGO DE RENOVACION */
select @w_forma_pago = pa_char 
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'FDESRE'

/* Clase Comercial */
select @w_cod_comercial = pa_char 
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'CCOM'

if @@rowcount = 0 select @w_forma_pago = 'RENOVACION'



select @w_fecha_proceso  = fp_fecha
from cobis..ba_fecha_proceso

--- DATOS DE LA OPERACION NUEVA
select 
@w_tramite_nueva     = op_tramite,
@w_moneda            = op_moneda,
@w_fecha_ini_nueva   = op_fecha_liq,
@w_banco_renovada    = op_anterior,
@w_cliente           = op_cliente,
@w_oficial           = op_oficial,
@w_clase_nva         = op_clase, --Inc_7615
@w_estado_operacion  = op_estado,
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_operacionca_n     = op_operacion
from   ca_operacion
where  op_banco   = @i_banco

if @@rowcount = 0 begin
   select @w_error = 710559, @w_msg = 'NO SE ENCUENTRA LA OPERACION: ' + @i_banco
   goto ERRORFIN
end



select 
@w_operacion_ant         = op_operacion,
@w_oficina_ant           = op_oficina,     
@w_toperacion_ant        = op_toperacion,
@w_moneda_ant            = op_moneda,
@w_fecha_ult_proceso_ant = op_fecha_ult_proceso, 
@w_oficial_ant           = op_oficial 
from ca_operacion 
where op_banco = @w_banco_renovada

if @@trancount = 0 begin
   begin tran
   select @w_commit = 'S'
end

select @w_monto_pagado = 0

exec @w_secuencial = sp_gen_sec
     @i_operacion  = @w_operacionca_n
            
/* LAZO PARA CANCELAR LAS OPERACIONES A RENOVAR */

declare renovacion cursor  for select 
op_banco,             op_operacion,          op_moneda,
op_fecha_ult_proceso, op_estado,             or_saldo_original, op_cliente,
op_nombre
from   ca_operacion,  cob_credito..cr_op_renovar
where  op_banco   = or_num_operacion
and    or_tramite = @w_tramite_nueva
and    or_aplicar = 'S'   ---ESTA BANDERA DE APLICAR S SE LLENA EN EL SP_DESEMBOLSAR_REN GRUPALES , SE COLOCA N CUANDO NO TIENE PRESTAMO ANTERIOR Y EN S CUANDO SI
for read only
   
open renovacion
   
fetch renovacion into  
@w_banco_renovada,   @w_operacionca,       @w_moneda,
@w_fecha_ult_proc,   @w_estado_op_vieja,   @w_monto_pago,
@w_beneficiario,     @w_nombre
   
while @@fetch_status = 0   begin


   if @w_monto_pago <= 0 GOTO SIGUIENTE 
   
   update cob_credito..cr_op_renovar set   
   or_finalizo_renovacion  = 'S'
   where  or_tramite       = @w_tramite_nueva
   and    or_num_operacion = @w_banco_renovada

   if @@error <> 0 begin
      select @w_error = 710002, @w_msg = 'ERROR AL MARCAR COMO FINALIZADA LA RENOVACION ' + @w_banco_renovada   
      goto ERROR1          
   end
   
   select @w_monto_renovar_mn = @w_monto_pago
   select @w_monto_pagado = @w_monto_pagado + @w_monto_pago
   
   if @w_moneda <> 0
      begin
         exec sp_buscar_cotizacion
            @i_moneda     = @w_moneda,
            @i_fecha      = @w_op_fecha_ult_proceso,
            @o_cotizacion = @w_cotizacion_hoy out
            
         if @w_cotizacion_hoy is null 
            select @w_cotizacion_hoy = 1
               
         select @w_monto_renovar_mn = round(@w_monto_pago *  @w_cotizacion_hoy, @w_num_dec_mn)      
         select @w_monto_pagado = @w_monto_pagado + @w_monto_renovar_mn
      end
      else
      begin         
            select @w_cotizacion_hoy = 1
      end
      
   --- CALCULAR NUMERO DE LINEA
   select @w_desembolso = max(dm_desembolso) + 1
   from   ca_desembolso
   where  dm_secuencial = @w_secuencial
   and    dm_operacion  = @w_operacionca_n
   and    dm_estado     = 'NA'

   if @w_desembolso is null
      select @w_desembolso = 1
      
      insert into ca_desembolso
             (dm_secuencial,      dm_operacion,         dm_desembolso,
              dm_producto,        dm_cuenta,            dm_beneficiario,
              dm_oficina_chg,     dm_usuario,           dm_oficina,
              dm_terminal,        dm_dividendo,         dm_moneda,
              dm_monto_mds,       dm_monto_mop,         dm_monto_mn,
              dm_cotizacion_mds,  dm_cotizacion_mop,    dm_tcotizacion_mds,
              dm_tcotizacion_mop, dm_estado,            dm_cod_banco,
              dm_cheque,          dm_fecha,             dm_prenotificacion,
              dm_carga,           dm_concepto,          
              dm_valor,           dm_ente_benef,        dm_idlote,dm_pagado)
      values (@w_secuencial,     @w_operacionca_n,     @w_desembolso,
              @w_forma_pago,     @w_banco_renovada,    @w_nombre, 
              @s_ofi,             @s_user,             @s_ofi,
              @s_term,            1,                   @w_moneda,
              @w_monto_pago,      @w_monto_pago,       isnull(@w_monto_renovar_mn,0),
              @w_cotizacion_hoy,  @w_cotizacion_hoy,    'C',
              'C',                'NA',                 0,
              '0',                @s_date,              0,
              0,                  'REGISTRO DESEMBOLSO RENOVACION',          
              0,                  @w_beneficiario,      0, 'N')
      
      if @@error <> 0
      begin
         close renovacion
         deallocate renovacion
      
         select @w_error = 711073
         goto ERRORFIN
      end
   
   goto SIGUIENTE
   
   ERROR1:
   
   close renovacion
   deallocate renovacion   
      
   goto ERRORFIN
      
   SIGUIENTE:
   
   fetch renovacion into  
   @w_banco_renovada,   @w_operacionca,       @w_moneda,
   @w_fecha_ult_proc,   @w_estado_op_vieja,   @w_monto_pago,
   @w_beneficiario,     @w_nombre

end -- WHILE CURSOR
   
close renovacion
deallocate renovacion


select @w_saldo_ant  = @w_monto_pagado


if @i_valor_renovar > @w_monto_pagado
begin

   select @w_monto_pagado = @i_valor_renovar - @w_monto_pagado
   select @w_monto_renovar_mn = @w_monto_pagado
   if @w_moneda <> 0
      begin
         exec sp_buscar_cotizacion
            @i_moneda     = @w_moneda,
            @i_fecha      = @w_op_fecha_ult_proceso,
            @o_cotizacion = @w_cotizacion_hoy out
            
         if @w_cotizacion_hoy is null
            select @w_cotizacion_hoy = 1
               
         select @w_monto_renovar_mn = round(@w_monto_pago *  @w_cotizacion_hoy, @w_num_dec_mn)      
      end
      
   --- CALCULAR NUMERO DE LINEA
   select @w_desembolso = max(dm_desembolso) + 1
   from   ca_desembolso
   where  dm_secuencial = @w_secuencial
   and    dm_operacion  = @w_operacionca_n
   and    dm_estado     = 'NA'

   if @w_desembolso is null
      select @w_desembolso = 1
      
      insert into ca_desembolso
             (dm_secuencial,      dm_operacion,         dm_desembolso,
              dm_producto,        dm_cuenta,            dm_beneficiario,
              dm_oficina_chg,     dm_usuario,           dm_oficina,
              dm_terminal,        dm_dividendo,         dm_moneda,
              dm_monto_mds,       dm_monto_mop,         dm_monto_mn,
              dm_cotizacion_mds,  dm_cotizacion_mop,    dm_tcotizacion_mds,
              dm_tcotizacion_mop, dm_estado,            dm_cod_banco,
              dm_cheque,          dm_fecha,             dm_prenotificacion,
              dm_carga,           dm_concepto,          
              dm_valor,           dm_ente_benef,        dm_idlote)
      values (@w_secuencial,  @w_operacionca_n,         @w_desembolso,
              isnull(@i_forma_pago,'SANTANDER'),        @i_cuenta_banco,             @w_nombre, 
              @s_ofi,             @s_user,              @s_ofi,
              @s_term,            1,                    0,
              @w_monto_pagado,      @w_monto_pagado,        isnull(@w_monto_renovar_mn,0),
              @w_cotizacion_hoy,  @w_cotizacion_hoy,    'C',
              'C',                'NA',                 0,
              '0',                @s_date,              0,
              0,                  'REGISTRO DESEMBOLSO SANTANDER',          
              0,                  @w_beneficiario,      0)
      
      if @@error <> 0
      begin
         select @w_error = 711073
         goto ERRORFIN
      end   
end

select @w_num_renovaciones_ant = isnull(max(op_num_renovacion),0)
from   ca_operacion,  cob_credito..cr_op_renovar
where  op_banco   = or_num_operacion
and    or_tramite = @w_tramite_nueva

update ca_operacion set    
op_num_renovacion  = @w_num_renovaciones_ant + 1,
op_calificacion    = 'A',
op_oficial         = @w_oficial,
op_numero_reest    = case when op_reestructuracion = 'S' then isnull(op_numero_reest,0) + 1 else op_numero_reest end
where  op_tramite  = @w_tramite_nueva 

if @@error <> 0 begin
   select @w_error = 710002, @w_msg = 'ERROR AL ACTUALIZAR EL NUMERO DE RENOVACIONES '  
   goto ERRORFIN
end


if @w_commit = 'S' begin
   commit tran 
   select @w_commit = 'N'
end

return 0

ERRORFIN:

if @w_commit = 'S' begin
   rollback tran 
   select @w_commit = 'N'
end

return @w_error

GO

