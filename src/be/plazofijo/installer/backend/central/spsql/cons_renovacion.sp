/************************************************************************/
/*      Archivo:                consren.sp                              */
/*      Stored procedure:       sp_cons_renovacion                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 23/Nov/94                               */
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
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      necesarias para efectuar una renovacion a una operacion de      */
/*      plazo fijo.                                                     */
/*                                                                      */
/*                                                                      */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*      FECHA                   AUTOR              RAZON                */
/*     08/Sep/95	    Carolina Alvarado  XXXX                     */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_renovacion')
   drop proc sp_cons_renovacion
go

create proc sp_cons_renovacion (
		@s_ssn                  int = null,
		@s_user                 login = null,
		@s_sesn                 int = null,
		@s_term                 varchar(30) = null,
		@s_date                 datetime = null,
		@s_srv                  varchar(30) = null,
		@s_lsrv                 varchar(30) = null,
		@s_ofi                  smallint = null,
		@s_rol                  smallint = NULL,
		@t_debug                char(1) = 'N',
		@t_file                 varchar(10) = null,
		@t_from                 varchar(32) = null,
		@t_trn                  smallint,
		@i_num_banco            varchar(15),
    @i_formato_fecha        int = 0  /* GESCY2K B246 */
)
with encryption
as
declare @w_sp_name	varchar(10),
	@w_operacion	int,
	@w_incremento	money,
	@w_tasa		float,
	@w_plazo	smallint,
	@w_fecha_crea	varchar(10),
	@w_descripcion	descripcion

select @w_sp_name = 'sp_cons_renovacion'


if @t_trn <> 14705
begin
  exec cobis..sp_cerror
    @t_debug      = @t_debug, @t_file       = @t_file,
    @t_from       = @w_sp_name, @i_num        = 141018

  /*  'Error en codigo de transaccion' */
  return 1
end

select @w_operacion = op_operacion from pf_operacion 
where op_num_banco = @i_num_banco
select	@w_incremento	= re_incremento, 
	@w_tasa		= re_tasa,
        @w_plazo	= re_plazo, 
	@w_fecha_crea	= convert(varchar(10),re_fecha_crea, @i_formato_fecha),  /* GESCY2K B245 */
	@w_descripcion	= re_descripcion
from pf_renovacion 
where re_operacion = @w_operacion
and	re_estado	= 'I'
if @@rowcount <> 1
begin
	exec cobis..sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 141211
	return 141211
end

select	'INCR/DECR.'		= @w_incremento,
	'TASA'			= @w_tasa,
	'PLAZO'			= @w_plazo,
	'FECHA_SOLICITUD'	= @w_fecha_crea,
	'DESCRIPCION'		= @w_descripcion

return 0   
go
