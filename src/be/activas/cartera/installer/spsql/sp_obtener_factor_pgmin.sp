/************************************************************************/
/*  Archivo:                sp_obtener_factor_pgmin.sp                        */
/*  Stored procedure:       sp_obtener_factor_pgmin                            */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               Cartera                                     */
/*  Disenado por:           PRO                                         */
/*  Fecha de Documentacion: 10/Nov/2020                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*          				PROPOSITO                                   */
/* Calcula el pago minimo de LCR por medio de la regla					*/
/*                                                                      */
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 10/11/2020       PRO             	Emision Inicial                 */ 
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_obtener_factor_pgmin')
	drop proc sp_obtener_factor_pgmin
go

create proc [dbo].[sp_obtener_factor_pgmin](		
    @i_operacion		int				,
	@o_factor			float   		= null out
)

as
declare 
@w_sp_name       		varchar(32),
@w_error            	int,
@w_msg              	descripcion,
@w_operacion			int,
@w_iva					money,
@w_val_descuento 		money,
@w_val_descuento_aux 	money,
@w_operacion_desc   	int,
@w_toperacion			varchar(10),
@w_promocion			char(1),
@w_ciclos				int,
@w_dias_atraso			int,
@w_cliente				int,
@w_est_cancelado		int,
@w_separador			char(1),
@w_valores				varchar(30),
@w_variables			varchar(20),
@w_resultado			varchar(20),
@w_parent				varchar(20),
@w_factor				float,
@w_puntos				float,
@w_oper_padre			cuenta,
@w_oper_padre_int		int,
@w_fecha_proceso		datetime,
@w_mercado				varchar(5)


select 	@w_sp_name 		= 	'sp_obtener_factor_pgmin',
		@w_separador	=	'|'	

select 	@w_operacion 	= 	op_operacion,		
		@w_cliente		= 	op_cliente
from ca_operacion
where op_operacion	= @i_operacion

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_mercado =ea_colectivo 
from cobis..cl_ente_aux 
where ea_ente  = @w_cliente


select @w_mercado = isnull(@w_mercado,'CC')



select @w_valores = @w_mercado


select @w_valores = @w_mercado

print @w_valores

exec  @w_error = cob_pac..sp_rules_param_run
@s_rol                   = 1,
@i_rule_mnemonic         = 'PGMIN',
@i_modo                  = 'S',
@i_tipo                  = 'S',
@i_var_values            = @w_valores, 
@i_var_separator         = @w_separador,
@o_return_variable       = @w_variables  out,
@o_return_results        = @w_resultado 	out,
@o_last_condition_parent = @w_parent  	out 

if(@w_error <> 0)
begin
	goto ERROR
end

if(@w_resultado is not null)
begin
	select @w_factor = convert(float,SUBSTRING(@w_resultado,0, CHARINDEX(@w_separador,@w_resultado)))
	
	print 'Factor :'+convert(varchar(40),@w_factor)

	select @o_factor = @w_factor
end
if(@o_factor is null or @o_factor =0)
begin
	select @o_factor = 33.33
end

return 0

ERROR:
exec cobis..sp_cerror 
	  @t_from = @w_sp_name, 
	  @i_num = @w_error, 
	  @i_msg = @w_msg
     
return @w_error

go
