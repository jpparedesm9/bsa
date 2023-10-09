/************************************************************************/
/*      Archivo:                histasas.sp                             */
/*      Stored procedure:       sp_hist_tasas                           */
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
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa permite realizar la consulta de datos hist¢ricos  */
/*      de tasas                                                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR                RAZON                           */
/*      11-Mar-05  Gabriela Arboleda    Emision Inicial DP00126 GB      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_hist_tasas')
   drop proc sp_hist_tasas
go
create proc sp_hist_tasas (
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
select @w_sp_name = 'sp_hist_tasas'
--------------------------------------
-- Verificaci¢n de Transacciones
--------------------------------------
if   (@t_trn <> 14540 or @i_operacion <> 'S') 
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
     
      select 
	         'TIPO DE DPF'         = ht_tipo_deposito,
             'TASA ACTUAL'         = ht_vigente,
             'USUARIO ACTUAL'      = UA.fu_nombre,
             'FECHA ACTUAL'        = convert(varchar(10),ht_fecha_crea, @i_formato_fecha),
             'TASA ANTERIOR'       = ht_vigente_ant,
             'USUARIO ANTERIOR'    = UP.fu_nombre,
             'FECHA ANTERIOR'      = convert(varchar(10),ht_fecha_crea_ant, @i_formato_fecha),
             'SECUENCIAL'          = ht_secuencial,
             'TIPO PLAZO'	       = ht_tipo_plazo + ' - ' + pl_descripcion,		--LIM 26/ENE/2006
	         'TIPO MONTO'          = ht_tipo_monto + ' - ' + mo_descripcion		--LIM 02/FEB/2006
      from   pf_hist_tasa
      inner join pf_monto on
         ht_tipo_monto = mo_mnemonico
         inner join pf_plazo on
            ht_tipo_plazo = pl_mnemonico
            inner join cobis..cl_funcionario UA on
               UA.fu_login = ht_usuario
               left outer join cobis..cl_funcionario UP on
                  UP.fu_login = ht_usuario_ant
      where ht_secuencial >  @i_secuencial
      and   ht_fecha_crea >= @i_fecha_inicial
      and   ht_fecha_crea <= @i_fecha_final
      order  by ht_secuencial      
	
   end
   else
   begin
      select 'TIPO DE DPF'         = ht_tipo_deposito,
	         'TASA ACTUAL'         = ht_vigente,
             'USUARIO ACTUAL'      = UA.fu_nombre,
             'FECHA ACTUAL'        = convert(varchar(10),ht_fecha_crea, @i_formato_fecha),
             'TASA ANTERIOR'       = ht_vigente_ant,
             'USUARIO ANTERIOR'    = UP.fu_nombre,
             'FECHA ANTERIOR'      = convert(varchar(10),ht_fecha_crea_ant, @i_formato_fecha),
             'SECUENCIAL'          = ht_secuencial,
       	     'TIPO PLAZO'	       = ht_tipo_plazo + ' - ' + pl_descripcion,		--LIM 26/ENE/2006 
	         'TIPO MONTO'          = ht_tipo_monto + ' - ' + mo_descripcion		--LIM 02/FEB/2006
      from   pf_hist_tasa
      inner join pf_monto on
         ht_tipo_monto = mo_mnemonico
         inner join pf_plazo on
            ht_tipo_plazo = pl_mnemonico
            inner join cobis..cl_funcionario UA on
               UA.fu_login = ht_usuario
               left outer join cobis..cl_funcionario UP on
                  UP.fu_login = ht_usuario_ant
      where ht_secuencial > @i_secuencial
	  and   ht_fecha_crea >= @i_fecha_inicial
	  and   ht_fecha_crea <= @i_fecha_final
      and   ht_tipo_deposito = @i_tipo_deposito  
      order  by ht_secuencial
   end
	set rowcount 0
	return 0
end
go
