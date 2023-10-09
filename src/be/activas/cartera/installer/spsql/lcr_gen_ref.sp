/************************************************************************/
/*    Base de datos:            cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Andy González                           */
/*      Fecha de escritura:     12/10/2021                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*     Genera la referencia para el socio comercial                     */
/************************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_lcr_gen_ref')
	drop proc sp_lcr_gen_ref
GO

CREATE proc sp_lcr_gen_ref(
@s_user             login              = 'usrbatch',
@s_term             varchar(30)        = 'CTSSRV',
@i_canal            varchar(30)        = null,   --PROVIENE DE LA B2C PARA GENERAR DISPERSIONES DE UN DIA DE DURACION 
@i_id_referencia    varchar(30)        = null,
@i_monto            money              = null,
@i_monto_cap        money              = null, -- para referencias socio comercial
@i_monto_iva        money              = null, -- para referencias socio comercial
@i_monto_com        money              = null, -- para referencias socio comercial
@i_tipo_tran        char(2)            = null,
@o_referencia	    varchar(255)       = null out --valor sugerido a pagar
)
as declare 
@w_error              int,
@w_sp_name            varchar(30),
@w_msg                varchar(255),
@w_referencia_in      varchar(30),
@w_referencia_out     varchar(30),
@w_monto              varchar(20),
@w_fecha              varchar(10),
@w_tipo_tran_corresp  varchar(4),
@w_operacionca        int,
@w_saldo_cap          money,
@w_fecha_reg          datetime,
@w_moneda             int,
@w_monto_aprobado     money,
@w_observacion        varchar(255),
@w_cliente            int, 
@w_fecha_valor        datetime,
@w_fecha_proceso      datetime,
@w_hora_actual        datetime ,
@w_secuencial        int  		



select @w_sp_name = 'sp_lcr_gen_ref'

select @w_referencia_out = null



select @w_fecha_proceso  = fp_fecha 
from cobis..ba_fecha_proceso 
 --OBTENER OPERACION ENVIADA DESDE LA B2C 
   --TODO VALIDAR SI SE ENVIA LA OPERACION O EL CLIENTE DE LA B2C  PARA MANTENER LA LLAVE DE LA REFERENCIA
   
select @w_tipo_tran_corresp = ctr_tipo
from   ca_corresponsal
inner join ca_corresponsal_tipo_ref 
on     co_id          = ctr_co_id
where  ctr_tipo_cobis = @i_tipo_tran
and    co_nombre      = 'SOCIO'
and    ctr_convenio   = '9999'   --REGISTRO TEMPORAL EN LA CORRESPONSAL HASTA HOMOLOGAR EL PI 


select 
@w_operacionca = isnull(op_operacion,0), 
@w_monto_aprobado    = op_monto_aprobado,
@w_moneda            = op_moneda, 
@w_cliente           = op_cliente
from ca_operacion 
where op_banco = @i_id_referencia

if @@rowcount = 0 or @w_operacionca = 0 begin 
  
  select 
  @w_error = 700001, 
  @w_msg = 'ERROR: NO EXISTE OPERACION LCR'
  
  goto  ERROR_FIN   
  
end 

   
   
--VALIDACION DE CUPO DISPONIBLE 
select @w_saldo_cap    = isnull(sum(am_acumulado -am_pagado ),0) 
from ca_amortizacion 
where am_operacion     = @w_operacionca
and   am_concepto      = 'CAP'

if (@w_saldo_cap + @i_monto > @w_monto_aprobado) begin 
   select  
   @w_msg  = 'ERROR:LA LINEA DE CREDITO DEL CLIENTE NO TIENE SALDO SUFICIENTE PARA CUBRIR LA PRESENTE UTILIZACION',
   @w_error= 70003
   goto ERROR_FIN
end 


if (@i_monto <= 0  or @i_monto_cap <=0 or @i_monto_iva <=0 or @i_monto_com <=0) begin 

   select  
   @w_msg  = 'ERROR: EL MONTO NO PUEDE SER MENOR O IGUAL 0',
   @w_error= 700087
   goto ERROR_FIN

end 


 -- GENERACION DE LA REFERENCIA 


if @i_monto > 0    begin     

  select 
  @w_monto = dbo.LlenarI(replace(convert(varchar(20), @i_monto), '.', ''), '0', 8),
  @w_referencia_in = rtrim(ltrim(@w_tipo_tran_corresp)) + dbo.LlenarI(convert(varchar,  @w_cliente  ), '0', 12),  
  @w_fecha = replace(convert(varchar(10), @w_fecha_proceso, 103), '/', '')   


  
  exec @w_error = sp_dv_base22
  @i_input = @w_referencia_in,
  @i_monto = @w_monto,
  @i_fecha = @w_fecha,
  @o_output= @w_referencia_out out
  
  if @w_error != 0 return @w_error
  
end 



---GENERACION DEL  REGISTRO DE LA REFERENCIA CON ESTADO I 

--IDENTIFICAMOS SI EXISTE UNA REFERENCIA EN CURSO ESTADO Z, I 
--EN CASO DE EXISTIR REFERENCIA VALIDAR SI ESTA VALIDA DURANTE EL DIA DE LA SOLICITUD
   
select 
@w_secuencial     = co_secuencial,
@w_fecha_reg      = co_fecha_real,
@w_hora_actual    = getdate()
from ca_lcr_referencia_sc 
where co_codigo_interno =  @w_operacionca 
--and co_referencia       =  @w_referencia_out
and co_estado in ( 'Z')


if (@@rowcount >0) begin 

	update   ca_lcr_referencia_sc set 
	co_estado = 'X'
	where co_codigo_interno =  @w_operacionca
	
    if @@error <> 0 begin
        select 
        @w_error = @w_error,
        @w_msg  = 'NO SE ACTUALIZÓ REFERENCIA'   
        goto ERROR_FIN
    end	

end    
   

--INSERCION DEL REGISTRO 
--Z TEMPORAL PARA USARSE EN EL VALE DE COMPRA
--X ANULADO 

   

--INSERCION DEL REGISTRO 
insert into cob_cartera..ca_lcr_referencia_sc 
(co_corresponsal,         co_tipo,         co_codigo_interno, co_fecha_proceso,       co_fecha_valor, 
co_referencia,           co_moneda,        co_monto,          co_status_srv,          co_estado, 
co_error_id,             co_error_msg,     co_archivo_ref,    co_archivo_fecha_corte, co_archivo_carga_usuario, 
co_concil_est,           co_concil_motivo, co_concil_user,    co_concil_fecha,        co_concil_obs,  
co_trn_id_corresp,       co_accion,        co_login,          co_terminal,            co_fecha_real, 
co_linea				,co_monto_cap, 	   co_monto_com, 	  co_monto_iva) 
values      
('SANTANDER',            'PI',             @w_operacionca,    @w_fecha_proceso,       @w_fecha_proceso, 
@w_referencia_out,       @w_moneda,        @i_monto,              '',                     'Z',        --//ESTADO TEMPORAL PARA QUE SEA USADO DENTRO DE LA VIGENCIA
0,                        '',              NULL,              NULL,                    NULL, 
NULL,                     NULL,            NULL,              NULL,                    NULL, 
NULL,                     'I',             @s_user,          @s_term,                  getdate(), 
NULL,                     @i_monto_cap,    @i_monto_com,     @i_monto_iva)

 
if @@error <> 0 begin
  select 
  @w_error = @w_error,
  @w_msg  = 'NO SE INSERTO EL REGISTRO PAGO CORRESPONSAL'   
  goto ERROR_FIN
end	



select @o_referencia =  @w_referencia_out    

return 0
ERROR_FIN:

exec cobis..sp_cerror 
    @t_from = @w_sp_name, 
    @i_num  = @w_error, 
    @i_msg  = @w_msg
return @w_error

go


