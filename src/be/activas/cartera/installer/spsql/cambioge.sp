/************************************************************************/
/*	Archivo:		cambioge.sp        			*/
/*	Stored procedure:	sp_cambio_gerente                       */
/*	Base de datos:		cob_cartera				*/
/*	Producto: 		Cartera					*/
/*	Disenado por:  		Juan Sarzosa               		*/
/*	Fecha de escritura:	Ene  2001  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA".							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/ 
/*				PROPOSITO             			*/
/*	                                                                */
/*	Insertar la transaccion CGE (Cambio de Gerente) al momento      */
/*	que se detecte el cambio del mismo --Personalizacion Tequendama	*/
/************************************************************************/ 
/*                              CAMBIOS                                 */
/*	FEB-14-2002		RRB	      Agregar campos al insert	               */
/*					                                    en ca_transaccion		*/
/* MAR-07-2005      EPB         Insert tr_fecha_ref ok                  */
/************************************************************************/

use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_cambio_gerente')
	drop proc sp_cambio_gerente
go


create proc sp_cambio_gerente (
        @s_date                 datetime = NULL,
	@t_trn			smallint = null,
        @i_gerente_anterior     smallint = null,
       	@i_gerente		smallint = null,
        @i_cliente 		int	 = null,	
        @i_tr_operacion         int 	 = null,
        @i_tr_toperacion	catalogo = null, 
        @i_tr_moneda		smallint = null,
        @i_tr_banco		cuenta 	 = null,
        @i_tr_ofi_oper		smallint = null,	
	     @i_tr_ofi_usu 		smallint = null,	
        @i_tr_usuario		varchar(14) = null,
        @i_tr_terminal		varchar(30) = null,
        @i_fecha_proceso        datetime = null
)
as
declare  @w_sp_name 		varchar(32),
         @w_secuencial 		int,
         @w_en_linea            char(1),
         @w_producto            tinyint,
      	 @w_gar_admisible	char(1), 
      	 @w_reestructuracion	char(1),
      	 @w_calificacion	char(1),  
      	 @w_op_fecha_ult_proceso datetime

/*Nombre del SP */
select @w_sp_name = 'sp_cambio_gerente'

/*Generar secuencial para la transaccion */
exec @w_secuencial = sp_gen_sec 
@i_operacion   = @i_tr_operacion

/*Verificar si el sistema est  en l¡nea o no */
select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_abreviatura = 'CCA'
set transaction isolation level read uncommitted

select @w_en_linea = pm_estado 
from cobis..cl_pro_moneda 
where pm_producto = @w_producto
set transaction isolation level read uncommitted

if @w_en_linea = 'V' 
   select @w_en_linea = 'S' 
else 
   select @w_en_linea = 'N' 

/* Datos de la operaci¢n para insertar en transacciones -- RRB: feb-14/2002, Ley 50 */
select @w_gar_admisible	   = op_gar_admisible,
         @w_reestructuracion = op_reestructuracion,
         @w_calificacion     = op_calificacion,
         @w_op_fecha_ult_proceso = op_fecha_ult_proceso
from ca_operacion
where op_operacion = @i_tr_operacion

insert into ca_transaccion 
(tr_secuencial,     tr_fecha_mov,         tr_toperacion,    tr_moneda, 
 tr_operacion,      tr_tran,              tr_en_linea,      tr_banco,    tr_dias_calc, 
 tr_ofi_oper,       tr_ofi_usu,           tr_usuario,       tr_terminal, tr_fecha_ref,
 tr_secuencial_ref, tr_estado,            tr_observacion,   tr_gerente, 	  
 tr_gar_admisible,  tr_reestructuracion , tr_calificacion, 
 tr_fecha_cont,     tr_comprobante)
values 
(@w_secuencial,     @s_date,              @i_tr_toperacion,     @i_tr_moneda,
 @i_tr_operacion,   'CGE',                @w_en_linea,          @i_tr_banco, 0,
 @i_tr_ofi_oper,    @i_tr_ofi_usu,        @i_tr_usuario,        @i_tr_terminal, @w_op_fecha_ult_proceso, 
 0, 'NCO',          convert(varchar(5),   @i_gerente_anterior), @i_gerente,
 isnull(@w_gar_admisible,''),isnull(@w_reestructuracion,''),isnull(@w_calificacion,''),  
 @s_date,0)

if @@error != 0 
   return 708165 

insert into cob_conta_tercero..ct_cambio_gerente
values 
(@w_producto, @i_cliente, @i_tr_banco, @i_gerente_anterior, @i_gerente, @s_date, 'V')

if @@error != 0 
   return 710204

return 0
go


