/************************************************************************/
/*      Archivo:                canfus.sp                               */
/*      Stored procedure:       sp_cancela                              */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Giovanni White                          */
/*      Fecha de documentacion: 11/Ago/98                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este procedimiento debe insertar en la tabla pf_cancelacion_tmp */
/*      todas y cada una de las operaciones fusionadas que genera una   */
/*      nueva operacion.                                                */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*   FECHA         AUTOR                 RAZON                          */
/*   11/Ago/98  Giovanni White           Emision Inicial                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where type = 'P' and name = 'sp_cancela_tmp')
   drop proc sp_cancela_tmp
go

create proc sp_cancela_tmp (
@s_ssn                  int         = null,
@s_sesn                 int         = null,
@s_user                 login       = null,
@s_term                 varchar(30) = null,
@s_date                 datetime    = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint    = null,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint    = null,
@i_operacion            char(1)     = null,
@i_num_banco            cuenta      = ' ',
@i_solicitante          int         = 0,
@i_secuencial           int         = NULL,
@i_retienimp            char(1)     = NULL)
with encryption
as 
declare
@w_sp_name              varchar(32),
@w_return               int,
@w_fecha                datetime,
@w_moneda               int,
@w_numdeci              int,
@w_usadeci              char(1),
@w_operacion            int,
@w_tsecuencial          int,
@w_secpin               int,
@w_oficina              int,
@w_pen_monto            money,
@w_pen_porce            int,--ojo
@w_solicitante          int,--ojo
@w_tipo                 char(1),
@w_estado               char(1),
@w_fpago                catalogo,
@w_fecha_ven            datetime,
@w_fecha_pg_int         datetime,
@w_accion_sgte          catalogo,
@w_estado_op            catalogo,
@w_comentario           varchar(60),
@w_valor                money,
@w_fecha_crea           datetime,
@w_monto_pg_int         money,
@w_int_ganado           money,
@w_int_pagados          money,
@w_int_vencido          money,
@w_total_int_pagados    money,
@w_fecha_ult_pg_int     datetime,
@w_fecha_mod            datetime,
@w_oficina_ant          int

select @w_sp_name = 'sp_cancela_tmp',
       @w_fecha   = convert(datetime,@s_date,101)

if   (@i_operacion  <> 'I')
begin
  exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 141004
  return 1
end

if   (@t_trn <> 14951)
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141018
  return 1
end

begin tran 
/* BORRADO DE LA TABLA TEMPORAL */

if @i_secuencial <= 1 
begin
   delete pf_cancelacion_tmp
    where cn_usuario = @s_user 
      and cn_sesion = @s_sesn

   if @@error <> 0
   begin
      exec cobis..sp_cerror @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                      @i_num   = 141072
      return  1
   end
end

/* De PF_OPERACION se toman valores principales */
select @w_operacion         = op_operacion,
       @w_oficina           = op_oficina,
       @w_valor             = op_monto, 
       @w_fpago             = op_fpago,
       @w_fecha_ven         = op_fecha_ven,
       @w_fecha_pg_int      = op_fecha_pg_int,
       @w_estado_op         = op_estado,
       @w_oficina_ant       = op_oficina,
       @w_monto_pg_int      = op_monto_pg_int,
       @w_fecha_ult_pg_int  = op_fecha_ult_pg_int,
       @w_int_ganado        = op_int_ganado,
       @w_int_pagados       = op_int_pagados,
       @w_total_int_pagados = op_total_int_pagados,
       @w_fecha_mod         = op_fecha_mod,
       @w_moneda            = op_moneda
  from pf_operacion
 where op_num_banco = @i_num_banco

if @@error <> 0 or @@rowcount = 0
begin
   exec cobis..sp_cerror @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141051
   return  1
end

/* Cargar Valores correspondientes a los Decimales manejados por la Moneda */
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

/* Variables para Insercion */
select @w_tsecuencial = @i_secuencial,
       @w_pen_monto   = 0,
       @w_pen_porce   = 0,
       @w_accion_sgte = 'NULL',
       @w_int_vencido = 0,
       @w_fecha_crea  = @s_date,
       @w_tipo        = 'N',                    /* Cancelacion Normal */
       @w_estado      = 'I',                  /* Ingresado */
       @w_solicitante = @i_solicitante

/* INSERCION en la tabla temporal PF_CANCELACION_TMP */

if @i_operacion = 'I' 
begin
   insert into pf_cancelacion_tmp (
         cn_usuario,          cn_sesion,
         cn_operacion,        cn_tsecuencial,
         cn_secpin,           cn_funcionario,
         cn_oficina,          cn_pen_monto,
         cn_pen_porce,        cn_solicitante,
         cn_tipo,             cn_estado,
         cn_fpago,            cn_fecha_ven,
         cn_fecha_pg_int,     cn_accion_sgte,
         cn_estado_op,        cn_autorizado,
         cn_comentario,       cn_valor,
         cn_fecha_crea,       cn_monto_pg_int,
         cn_int_ganado,       cn_int_pagados,
         cn_int_vencido,      cn_total_int_pagados,
         cn_fecha_ult_pg_int, cn_fecha_mod,
         cn_oficina_ant)
   VALUES (
         @s_user,             @s_sesn,
         @w_operacion,        @w_tsecuencial,
         NULL,                @s_user,
         @w_oficina,          @w_pen_monto,
         @w_pen_porce,        @w_solicitante,
         @w_tipo,             @w_estado,
         @w_fpago,            @w_fecha_ven,
         @w_fecha_pg_int,     @w_accion_sgte,
         @w_estado_op,        NULL,
         NULL,                @w_valor,
         @w_fecha_crea,       @w_monto_pg_int,
         @w_int_ganado,       @w_int_pagados,
         @w_int_vencido,      @w_total_int_pagados,
         @w_fecha_ult_pg_int, @w_fecha_mod,
         @w_oficina_ant)
   
   /* Si no se puede insertar, error */
   if @@error <> 0
   begin
      exec cobis..sp_cerror @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143039
      return  1
   end
end
commit tran    


/* end TRANSACCION */

return 0
go

