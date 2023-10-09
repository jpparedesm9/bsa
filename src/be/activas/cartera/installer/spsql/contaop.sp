/************************************************************************/
/*   Stored procedure:     sp_caconta                                   */
/*   Base de datos:        cob_cartera                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_caconta_op')
   drop proc sp_caconta_op
go
 
CREATE proc [dbo].[sp_caconta_op]

/*
   @i_param1            varchar(255)  = null, 
   @i_param2            varchar(255)  = null, 
   @i_param3            varchar(255)  = null, 
   @i_param4            varchar(255)  = null, 
   @i_param5            varchar(255)  = null,
   @i_param6            varchar(255)  = null,
*/

   @i_banco             cuenta,        
   @s_user              login         = 'admcar',
   @i_debug             char(1)       = 'N'  
 
as declare
   @w_error          	int,
   @w_fecha_proceso     smalldatetime,
   @w_fecha_hasta       smalldatetime,
   @w_fecha_mov         smalldatetime,
   @w_mensaje           varchar(255),
   @w_estado_prod       char(1),
   @w_cod_producto      tinyint,
   @w_sp_name        	descripcion,
   @w_secuencial        int,
   @w_banco             cuenta,
   @w_hijo              varchar(2),
   @w_sarta             int,
   @w_batch             int,
   @w_opcion            char(1),
   @w_bloque            int   
   
/* VARIABLES DE TRABAJO */
select
@w_sp_name      = 'contaop.sp',
@w_mensaje      = '',
@w_estado_prod  = '',
@w_cod_producto = 7 
/*
@w_banco        = convert(varchar(15), rtrim(ltrim(@i_param1))),
@w_hijo         = convert(varchar(2) , rtrim(ltrim(@i_param2))),
@w_sarta        = convert(int        , rtrim(ltrim(@i_param3))),
@w_batch        = convert(int        , rtrim(ltrim(@i_param4))),
@w_opcion       = convert(char(1)    , rtrim(ltrim(@i_param5))),
@w_bloque       = convert(int        , rtrim(ltrim(@i_param6)))
*/
select 
@w_hijo         = 1,
@w_sarta        = 1,
@w_batch        = 1,
@w_opcion       = 'B',
@w_bloque       = 1000

/* DETERMINAR FECHA PROCESO */
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre with (nolock)
where fc_producto = @w_cod_producto

/* DETERMINAR EL ESTADO DE ADMISION DE COMPROBANTES CONTABLES EN COBIS CONTABILIDAD */
select @w_estado_prod = pr_estado
from cob_conta..cb_producto with (nolock)
where pr_empresa  = 1
and   pr_producto = @w_cod_producto

/* VALIDA EL PRODUCTO EN CONTABILIDAD */
if @w_estado_prod not in ('V','E') begin
   select 
   @w_error   = 601018,
   @w_mensaje = ' PRODUCTO NO VIGENTE EN CONTA ' 
   goto ERRORFIN
end

/* DETERMINAR EL RANGO DE FECHAS DE LAS TRANSACCIONES QUE SE INTENTARAN CONTABILIZAR */
select  
@w_fecha_mov   = isnull(min(co_fecha_ini),'01/01/1900'),
@w_fecha_hasta = isnull(max(co_fecha_ini),'01/01/1900')
from cob_conta..cb_corte with (nolock)
where co_empresa = 1
and   co_estado in ('A','V')

if @w_fecha_mov = '01/01/1900' begin
   select 
   @w_error   = 601078,
   @w_mensaje = ' ERROR NO EXISTEN PERIODOS DE CORTE ABIERTOS ' 
   goto ERRORFIN
end

truncate table ca_universo_conta
   
/* INSERTAR EN TEMPORALES TOTALES A CONTABILIZAR */
while @w_fecha_mov <= @w_fecha_hasta begin

   /* TRANSACCIONES A CONTABILIZAR DISTINTAS A PRV */
   insert into ca_universo_conta
   select
   tr_operacion,   tr_secuencial,  tr_fecha_mov,   
   tr_fecha_ref,   tr_ofi_usu,     tr_tran,        
   'N',            0
   from ca_transaccion 
   where  tr_estado    = 'ING'
   and    tr_tran     not in ('PRV','REJ','MIG','HFM')
   and    tr_fecha_mov = @w_fecha_mov
   and    tr_banco     = @i_banco

   if @@error <> 0 begin
      select 
      @w_mensaje = ' ERR AL INSERTAR TRANSACCION CABECERA 1 ' ,
      @w_error   = 710001
      goto ERRORFIN
   end
   
   /*GENERO SECUENCIAL FICTICIO PARA LAS PRV'S */
   select @w_secuencial = datepart(yy,@w_fecha_mov) * 10000 + datepart(mm,@w_fecha_mov) * 100 + datepart(dd,@w_fecha_mov)
   
   /* TRANSACCIONES PRV A CONTABILIZAR */
   insert into ca_universo_conta
   select distinct
   tp_operacion,   @w_secuencial,  @w_fecha_mov,   
   @w_fecha_mov,   0,              'PRV',        
   'N',            0
   from ca_transaccion_prv, ca_operacion 
   where  tp_estado    = 'ING'
   and    tp_fecha_mov = @w_fecha_mov
   and    tp_operacion = op_operacion
   and    op_banco     = @i_banco      

   if @@error <> 0 begin
      select 
      @w_mensaje = ' ERR AL INSERTAR TRANSACCION CABECERA 1 ' ,
      @w_error   = 710001
      goto ERRORFIN
   end
   
   select @w_fecha_mov = dateadd(dd,1,@w_fecha_mov)

end

delete cobis..ba_ctrl_ciclico 
where ctc_sarta = @w_sarta

insert into cobis..ba_ctrl_ciclico
(ctc_sarta, ctc_batch, ctc_secuencial, ctc_procesar)
select sb_sarta,sb_batch, sb_secuencial, 'S'
from cobis..ba_sarta_batch
where sb_sarta = @w_sarta
and   sb_batch = @w_batch

exec sp_caconta
@i_param1              = @w_hijo,
@i_param2              = @w_sarta,
@i_param3              = @w_batch,
@i_param4              = 'B',
@i_param5              = @w_bloque,
@i_debug               = @i_debug

return 0

ERRORFIN:

exec sp_errorlog
@i_fecha     = @w_fecha_proceso, 
@i_error     = 7200, 
@i_usuario   = @s_user,
@i_tran      = 7000, 
@i_tran_name = @w_sp_name, 
@i_rollback  = 'N',
@i_cuenta    = 'CONTABILIDAD', 
@i_descripcion = @w_mensaje

return 0

