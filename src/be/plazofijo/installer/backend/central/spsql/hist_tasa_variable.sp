/************************************************************************/
/*      Archivo:                histavar.sp                             */
/*      Stored procedure:       sp_hist_tasa_variable                   */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 14/Mar/05                               */
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
/*      Este programa permite realizar la consulta de datos hist¢ricos  */
/*      de tasas variables                                              */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR                RAZON                           */
/*      14-Mar-05  Gabriela Arboleda    Emision Inicial DP00126 GB      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_hist_tasa_variable')
   drop proc sp_hist_tasa_variable
go
create proc sp_hist_tasa_variable (
   @s_ssn                        int = NULL,
   @s_user                       login = NULL,
   @s_term                       varchar(30) = NULL,
   @s_date                       datetime = NULL,
   @s_sesn                       int = NULL,
   @s_srv                        varchar(30) = NULL,
   @s_lsrv                       varchar(30) = NULL,
   @s_ofi                        smallint = NULL,
   @s_rol                        smallint = NULL,
   @t_debug                      char(1) = 'N',
   @t_file                       varchar(10) = NULL,
   @t_from                       varchar(32) = NULL,
   @t_trn                        smallint = NULL,
   @i_operacion                  char(1),
   @i_formato_fecha              int     = 0,
   @i_fecha_inicial              datetime,
   @i_fecha_final                datetime,
   @i_tipo_deposito              varchar(5) = NULL,
   @i_secuencial                 int        = 0 
)
with encryption
as
declare         
   @w_sp_name                    varchar(32)

-------------------------------
-- Inicializaci¢n
-------------------------------
select @w_sp_name = 'sp_hist_tasa_variable'
--------------------------------------
-- Verificaci¢n de Transacciones
--------------------------------------
if   (@t_trn <> 14549 or @i_operacion <> 'S') 
begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
          return 1
end


----------------------------------------------------
----------------------------------------------------
-- CONSULTA HISTORICOS DE TASAS
----------------------------------------------------
----------------------------------------------------
if @i_operacion = 'S'
begin
   set rowcount 20

   if @i_tipo_deposito IS NULL 
   begin
      select 'TIPO DE DPF'         = hv_mnemonico_prod,
             'SPREAD ACTUAL'       = hv_spread_vigente,
             'USUARIO ACTUAL'      = UA.fu_nombre,
             'FECHA ACTUAL'        = convert(varchar(10),hv_fecha_crea, @i_formato_fecha),
             'SPREAD ANTERIOR'     = hv_spread_vigente_ant,
             'USUARIO ANTERIOR'    = UP.fu_nombre,
             'FECHA ANTERIOR'      = convert(varchar(10),hv_fecha_crea_ant, @i_formato_fecha),
             'SECUENCIAL'          = hv_secuencial,
             'TIPO PLAZO'          = hv_tipo_plazo + ' - ' + pl_descripcion,		--LIM 26/ENE/2006
	     'TIPO MONTO'	   = hv_tipo_monto + ' - ' + mo_descripcion		--LIM 02/FEB/2006
      from   pf_hist_tasa_variable
      inner join pf_plazo on
         hv_tipo_plazo   = pl_mnemonico
         inner join pf_monto on
            hv_tipo_monto = mo_mnemonico
            inner join cobis..cl_funcionario UA on
               UA.fu_login  = hv_usuario
               left outer join cobis..cl_funcionario UP on
                  UP.fu_login  = hv_usuario_ant
      where  hv_secuencial > @i_secuencial
	  and  hv_fecha_crea between @i_fecha_inicial and @i_fecha_final
      order  by hv_secuencial      
   end
   else
   begin
      select 'TIPO DE DPF'         = hv_mnemonico_prod,
             'SPREAD ACTUAL'       = hv_spread_vigente,
             'USUARIO ACTUAL'      = UA.fu_nombre,
             'FECHA ACTUAL'        = convert(varchar(10),hv_fecha_crea, @i_formato_fecha),
             'SPREAD ANTERIOR'     = hv_spread_vigente_ant,
             'USUARIO ANTERIOR'    = UP.fu_nombre,
             'FECHA ANTERIOR'      = convert(varchar(10),hv_fecha_crea_ant, @i_formato_fecha),
             'SECUENCIAL'          = hv_secuencial,
	     'TIPO PLAZO'          = hv_tipo_plazo + ' - ' + pl_descripcion,	--LIM 26/ENE/2006
	     'TIPO MONTO'	   = hv_tipo_monto + ' - ' + mo_descripcion		--LIM 02/FEB/2006
      from   pf_hist_tasa_variable
      inner join pf_plazo on 
         hv_tipo_plazo   = pl_mnemonico
         inner join pf_monto on
            hv_tipo_monto = mo_mnemonico
            inner join cobis..cl_funcionario UA on
               UA.fu_login = hv_usuario
               left outer join cobis..cl_funcionario UP on
                  UP.fu_login = hv_usuario_ant
      where  hv_secuencial > @i_secuencial
	  and  hv_fecha_crea between @i_fecha_inicial and @i_fecha_final
      and  hv_mnemonico_prod = @i_tipo_deposito
      order  by hv_secuencial      
   end
end

return 0
go

