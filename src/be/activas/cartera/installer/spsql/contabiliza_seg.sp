/************************************************************************/
/*  Archivo:                   contabiliza_seg.sp                      	*/
/*  Stored procedure:          sp_contabiliza_seguro                 	*/
/*  Base de Datos:             cob_custodia                            	*/
/*  Producto:                  Custodia                                	*/
/*  Disenado por:              Jose Sanchez                          	*/
/*  Fecha de Documentacion:    09/Octubre/2019                          */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*          PROPOSITO                                                  	*/
/*  Este stored procedure permite crear o devolver el valor            	*/
/*  del seguro                                                     		*/
/*                                                                      */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA              AUTOR               RAZON                        */
/* 09/Octubre/2019    Jose Sanchez       Emision Inicial                */
/* 03/Marzo/2021      Sonia Rojas        Req #147999                    */ 
/************************************************************************/

use cob_cartera
go

if exists (select * from sysobjects where name = 'sp_contabiliza_seguro' and xtype = 'P')
    drop proc sp_contabiliza_seguro
go

create proc sp_contabiliza_seguro (
@s_date               datetime,
@s_user               login        = null,
@s_ofi                INT          = null,
@s_term               descripcion  = null,
@i_operacion          char(2)  = null, /*C = Creacion y D = Devolver*/
@i_tramite            varchar(100) = null,
@i_monto              money        = NULL,
@i_en_linea           CHAR(1)      = 'S',
@i_ente               int          = null,
@i_grupo              int          = null,
@i_forma_pago         varchar(16)  = 'SANTANDER',
@i_moneda             int          = 0,
@o_secuencial         int          = null output          
)
as
declare

@w_error              int,          /* VALOR QUE RETORNA  */
@w_sp_name            varchar(32),  /* NOMBRE STORED PROC */
@w_commit             char(1),
@w_monto              money,
@w_fecha_proc         datetime,
@w_clase_cartera      catalogo,
@w_calificacion       char(1),
@w_hora               varchar(8),
@w_secuencial         int,
@w_concepto           varchar(50),
@w_grupo              int, 
@w_monto_seguro       money,
@w_toper_trn_gar      catalogo,
@w_cliente            cuenta,
@w_codigo_externo     cuenta,
@w_codvalor           varchar(10),
@w_banco_padre        cuenta,
@w_operacionca        int,
@w_tipo_tran          varchar(10),
@w_beneficiario       varchar(50)   


if @i_tramite   is not null 
begin 
   select @w_banco_padre = tg_referencia_grupal 
   from  cob_credito..cr_tramite_grupal 
   where tg_tramite = @i_tramite
   
   select @w_operacionca = dc_operacion 
   from  cob_cartera..ca_det_ciclo 
   where dc_referencia_grupal = @w_banco_padre 
   and   dc_cliente = @i_ente 
   
   if @@rowcount <> 0 
   begin 
      select @s_ofi = op_oficina 
	  from cob_cartera..ca_operacion
	  where op_operacion = @w_operacionca
   end 
end 

select 
@w_sp_name = 'sp_contabiliza_seguro',
@w_commit = 'N'

select @w_fecha_proc = fp_fecha
from cobis..ba_fecha_proceso

select @s_date = @w_fecha_proc

select @w_toper_trn_gar = pa_char 
from  cobis..cl_parametro
where pa_nemonico in ('TOPGAR')
and   pa_producto = 'CCA'

select @w_toper_trn_gar = isnull(@w_toper_trn_gar, 'GARANTIA')

if @i_grupo is not null begin 
	select @w_grupo   = @i_grupo
end
else begin
	select @w_grupo   = se_grupo
	from   cob_cartera..ca_seguro_externo
    where  se_cliente = @i_ente 
    and    se_tramite = @i_tramite	
end


select @w_cliente = convert(varchar, @i_ente)


if @i_operacion = 'D' begin
    select @w_tipo_tran        = 'DSE',
           @w_beneficiario     = 'DEVOLUCION SEGURO',
           @w_concepto         = 'DEV. SEGURO'
    
	select 	@w_monto     		= @i_monto
      
	update cob_cartera..ca_seguro_externo set 
	se_estado				= 'D',
    se_monto_devuelto		= isnull(se_monto_devuelto,0) + @w_monto,
    se_fecha_ult_intento	= @w_fecha_proc,
	se_usuario              = @s_user,
	se_terminal             = @s_term
	where 	se_grupo 	= @w_grupo 
	and    	se_cliente	= @i_ente
	and    	se_tramite 	= @i_tramite
   
	 
	
end 

if @i_operacion = 'C' begin


	update cob_cartera..ca_seguro_externo
	set se_estado			= 'C',
    se_monto_pagado			= isnull(se_monto_pagado,0) + @i_monto,
	se_fecha_ult_intento	= @w_fecha_proc, 
	se_forma_pago           = @i_forma_pago,
    se_usuario              = @s_user,
	se_terminal             = @s_term
	where	se_grupo	    = @w_grupo
	and		se_cliente	    = @i_ente
	and		se_tramite	    = @i_tramite
   
	select 
	@w_monto     = @i_monto,
	@w_concepto  = 'CONST. SEG',
    @w_tipo_tran = 'SEG'              ,
    @w_beneficiario = 'CONSTITUIR SEGURO'
end

/* SECUENCIAL DE SEGURO */   
exec @o_secuencial = cob_cartera..sp_gen_sec
@i_operacion       = -3

insert into cob_cartera..ca_transaccion(
tr_fecha_mov,    		tr_toperacion,		tr_moneda,
tr_operacion,          	tr_tran,           	tr_secuencial,
tr_en_linea,           	tr_banco,          	tr_dias_calc,
tr_ofi_oper,           	tr_ofi_usu,        	tr_usuario,
tr_terminal,           	tr_fecha_ref,      	tr_secuencial_ref,
tr_estado,             	tr_gerente,        	tr_gar_admisible,
tr_reestructuracion,   	tr_calificacion,   	tr_observacion,                              
tr_fecha_cont,         	tr_comprobante)
values(
@s_date,				@w_toper_trn_gar, 	@i_moneda,
-3,                    	@w_tipo_tran,       @o_secuencial, 
'S',                   	@w_cliente      ,  	0,
@s_ofi,                	@s_ofi,             @s_user,
@s_term,              	@s_date,            -999,  
'ING',                 	'',                 '',
'',                    	'',                 @w_concepto,
@s_date,               	0)
   
if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR
end


select 	@w_codvalor = cp_codvalor 
from 	cob_cartera..ca_producto
where 	cp_producto = @i_forma_pago

if @w_codvalor is null
begin
   select @w_error = 70203
   goto ERROR
end
				 
insert into cob_cartera..ca_det_trn(
dtr_secuencial,		dtr_operacion,	dtr_dividendo,
dtr_concepto,       dtr_estado,    	dtr_periodo,
dtr_codvalor,       dtr_monto,     	dtr_monto_mn,
dtr_moneda,         dtr_cotizacion,	dtr_tcotizacion,
dtr_afectacion,     dtr_cuenta,    	dtr_beneficiario,
dtr_monto_cont)
values(
@o_secuencial,		-3,				0,
@i_forma_pago,     	1,            	0,
@w_codvalor,       	@w_monto,     	@w_monto,
@i_moneda,         	1,            	'N',
'D',              	'00000',       	@w_beneficiario,
0.00)

if @@error <> 0 begin
	select @w_error = 710001
	goto ERROR
end
 
return 0

ERROR:
if @w_commit = 'S'
begin
	select @w_commit = 'N'
	rollback tran
	return @w_error
end

if @i_en_linea = 'S' begin 
	exec cobis..sp_cerror
	@t_from  = @w_sp_name,
	@i_num   = @w_error   
end
   
return @w_error

GO
