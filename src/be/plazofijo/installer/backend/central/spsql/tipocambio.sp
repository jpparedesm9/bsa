/************************************************************************/
/*      Archivo:                tipcam.sp                               */
/*      Stored procedure:       sp_tipocambio                           */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               PLAZO FIJO                              */
/*      Disenado por:           Memito Saborío A.                       */
/*      Fecha de escritura:     29/ago/01                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'Banco Cuscatlan', representantes exclusivos                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de CUSCATLAN o su representante.          */
/*                              PROPOSITO                               */
/*      Este script ejecuta una serie de procesos que devuelve el tipo  */
/*      de cambio solicitado en una variable output, si el tipo es 1    */
/*      se envía el tipo de cambio de compra, sino el de venta.         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                   RAZON                   */
/*      29/ago/01       Memito Saborío A        Creación                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_tipocambio')
   drop proc sp_tipocambio
go

create proc sp_tipocambio
@s_ssn                  int          = null,
@s_user                 login        = null,
@s_term                 varchar(30)  = null,
@s_date                 datetime     = null,
@s_srv                  varchar(30)  = null,
@s_lsrv                 varchar(30)  = null,
@s_ofi                  smallint 	 = null,
@s_rol                  smallint 	 = NULL,
@t_debug                char(1) 	 = 'N',
@t_file                 varchar(10)  = null,
@t_from                 varchar(32)  = null,
@t_trn                  smallint     = null,
@i_tipo                 smallint     = 1,  --Tipo de cambio compra por default
@i_fecha                datetime,
@i_moneda               smallint,
@i_empresa              tinyint      = 1,   --Banco como empresa default
@o_factor               float 	     = null  output
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_compra			    float,
@w_venta			    float,
@w_fecha_max            datetime,
@w_cot4				    float,
@w_cotiza 		        float, 
@w_moneda_base          tinyint  

select @w_sp_name = 'sp_calc_cotiza'

if @t_trn <> 14439 begin
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141112
      /*  'Error en codigo de transaccion' */
      return 1
end  

if not exists(select * from cobis..cl_moneda where mo_moneda = @i_moneda) begin
    exec cobis..sp_cerror
    	@t_debug=@t_debug,
    	@t_file=@t_file,
    	@t_from=@w_sp_name, 
    	@i_num = 101045
    return  1
end

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0 begin
    exec cobis..sp_cerror
    	@t_debug=@t_debug,
    	@t_file=@t_file,
    	@t_from=@w_sp_name, 
    	@i_num = 601018
    return  1
end 


if @w_moneda_base = @i_moneda begin
	select @o_factor = 1
	return 0
end

--*** Obtener la fecha máxima de la tabla de tipos de cambio ***
SELECT @w_fecha_max = max(co_fecha) 
FROM pf_cotizacion
WHERE co_moneda = @i_moneda
AND co_fecha <= @i_fecha

--*** Obtener tipo de cambios para la fecha solicitada ***
SELECT @w_venta = isnull(co_venta_billete,0), @w_compra = isnull(co_compra_billete,0)
FROM pf_cotizacion
WHERE co_moneda = @i_moneda
AND co_fecha = @i_fecha

if @w_venta = 0 or @w_compra = 0 
--*** Si para la fecha solicitada el tipo de cambio es 0 tomar la fecha  ***
--*** máxima de tipo de cambio para la moneda solicitada                 ***
	SELECT @w_venta = co_venta_billete, @w_compra = co_compra_billete 
	FROM pf_cotizacion
	WHERE co_moneda = @i_moneda
		AND co_fecha = @w_fecha_max

if @w_venta = 0 or @w_compra = 0 begin
    exec cobis..sp_cerror
    	@t_debug=@t_debug,
    	@t_file=@t_file,
    	@t_from=@w_sp_name, 
    	@i_num = 601018
    return  1
end

if @i_tipo = 1 --* Tipo de cambio de compra
	select @o_factor = @w_compra
else	      --* Tipo de cambio de venta
	select @o_factor = @w_venta

return 0
go