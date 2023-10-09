/************************************************************************/
/*      Archivo:                b_autspr.sp                             */
/*      Stored procedure:       sp_cons_autspread                       */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 21-Mar-2005                             */
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
/*      Este script crea los procedimientos para las consultas de las   */
/*      operaciones de plazos fijos.                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      21-Mar-2005     N. Silva           Emision Inicial              */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_autspread')
   drop proc sp_cons_autspread
go
create proc sp_cons_autspread (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint,
@i_operacion            char(1)         = 'S',
@i_formato_fecha        tinyint         = 101,
@i_as_operacion         int             = null,
@i_siguiente            int             = 0)
with encryption
as
declare
@w_sp_name              descripcion,
@w_max_fecha            datetime

select @w_sp_name = 'sp_cons_autspread'

/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14554
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141112
	return 1
end


if @i_operacion = 'S'
begin

   ---------------------------------------
   -- B£squeda de autorizacione pendientes
   ----------------------------------------
   if @i_as_operacion is null 
   begin
	set rowcount 20
      select 'Numero Oper'  = op_num_banco,
             'Cod Oper '    = as_operacion,
             'Spread '      = as_spread,
             'Operador'     = as_operador,
             'Fecha Ing'    = convert(varchar(10),as_fecha,@i_formato_fecha),
             'Utilizado'    = case as_estado
                              when 'V' then 'NO'
                              when 'U' then 'SI'
                              end,
             'Usuario'      = as_usuario,
             'Tasa'         = op_tasa,
             'Moneda'       = op_moneda
        from cob_pfijo..pf_aut_spread,
             cob_pfijo..pf_operacion
       where as_estado = 'V'
         and as_fecha = @s_date
         and op_operacion = as_operacion
	and	as_operacion	> @i_siguiente
       order by as_operacion
	set rowcount 0
   end
   else
   begin 
/****************************************************************************
CCR se debe buscar unicamente el de la fecha actual, no el de la fecha m xima

      select @w_max_fecha = max(as_fecha)
        from cob_pfijo..pf_aut_spread
       where as_operacion = @i_as_operacion
         and as_estado <> 'A'
****************************************************************************/

      select 'Numero Oper'  = op_num_banco,
             'Cod Oper '    = as_operacion,
             'Spread '      = as_spread,
             'Operador'     = as_operador,
             'Fecha Ing'    = convert(varchar(10),as_fecha,@i_formato_fecha),
             'Utilizado'    = case as_estado
                              when 'V' then 'NO'
                              when 'U' then 'SI'
                              end,
             'Usuario'      = as_usuario,
             'Tasa'         = op_tasa,
             'Moneda'       = op_moneda
        from cob_pfijo..pf_aut_spread,
             cob_pfijo..pf_operacion
       where as_fecha = @s_date
         and op_operacion = as_operacion
         and as_operacion = @i_as_operacion
         and as_estado not in ('A','U') --CVA Nov-25-05 Incluir estado U= utilizado
       order by as_operacion
   end
/**************************************
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141182
      return 1
   end

**************************************/

   set rowcount 0
   select 20
end

return 0
go
