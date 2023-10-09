/************************************************************************/
/*      Archivo:                b_corresp.sp                            */
/*      Stored procedure:       sp_consulta_corresponsal                */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 27-Ene-2004                             */
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
/*      Este script crea los procedimientos para las consultas de los   */
/*      Bancos Corresponsales en Comercio Exterior.                     */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA          AUTOR              RAZON                         */
/*      23-Ene-2004    N. Silva           Emision Inicial               */
/*      30-Nov-2016    A.Zuluaga          Desacople                     */
/************************************************************************/
use cob_pfijo
go

set ansi_nulls off
go

if exists (select * from sysobjects where name = 'sp_consulta_corresponsal')
   drop proc sp_consulta_corresponsal
go
create proc sp_consulta_corresponsal (
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
	@i_banc_corresp		int,       
	@i_ofic_corresp         int             = NULL,
        @i_operacion            char(1)         = 'S',
	@i_valor                varchar(64)     = '%',
        @i_descripcion          varchar(64)     = '',
        @i_modo                 integer         = NULL
)
as
declare @w_sp_name              descripcion,
        @w_return               int
        
       
select @w_sp_name = 'sp_consulta_corresponsal'
/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14459
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 149065
	return 1
end

------------------------------------------------------------------------
-- B£squeda Bancos Corresponsales con Oficinas Corresponsales Asociadas
------------------------------------------------------------------------
if @i_operacion = 'S'
begin

   exec @w_return = cob_interfase..sp_icomext
        @i_operacion    = 'E',
        @i_valor        = @i_valor,
        @i_descripcion  = @i_descripcion,
        @i_modo         = @i_modo,
        @i_banc_corresp = @i_banc_corresp

   if @w_return <> 0
      return @w_return

end

------------------------------------
-- Detalle para busqueda individual
------------------------------------
if @i_operacion = 'Q'
begin

   exec @w_return = cob_interfase..sp_icomext
        @i_operacion    = 'F',
        @i_valor        = @i_valor,
        @i_descripcion  = @i_descripcion,
        @i_modo         = @i_modo,
        @i_banc_corresp = @i_banc_corresp,
        @i_ofic_corresp = @i_ofic_corresp

   if @w_return <> 0
      return @w_return


end
return 0
go
