



/************************************************************************/
/*    Base de datos:            cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Andy González                           */
/*      Fecha de escritura:     02/03/2022                              */
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
/*     Genera la referencia generica                                    */
/************************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_ref_generica')
	drop proc sp_ref_generica
GO

CREATE proc sp_ref_generica(
@s_user                 login              = 'usrbatch',
@s_term                 varchar(30)        = 'CTSSRV',
@i_id_referencia        varchar(30)        = null,  ---PRESTAMO 
@o_referencia_std	    varchar(255)       = null out, --valor sugerido a pagar,
@o_referencia_oxxo	    varchar(255)       = null out, --valor sugerido a pagar
@o_referencia_elv	    varchar(255)       = null out --valor sugerido a pagar
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
@w_cliente            varchar(255), 
@w_fecha_valor        datetime,
@w_fecha_proceso      datetime,
@w_hora_actual        datetime ,
@w_secuencial         int ,
@w_ref_oxxo_out       varchar(255), 		
@w_ref_elavon_out     varchar(255),
@w_ref_std_out        varchar(255),
@w_long_oxxo_ref      int,
@w_long_std_ref       int,
@w_long_elv_ref       int,
@w_id_oxxo            char(2),
@w_toperacion         catalogo,
@w_tipo_tran          catalogo,
@w_ctr_tipo           int,
@w_operacion          int,
@w_ref_elv_out        varchar(255) ,
@w_est_vencido        int,
@w_est_cancelado      int,
@w_est_no_vigente     int , 
@w_est_vigente        int ,
@w_op_padre           cuenta ,
@w_fecha_liq          datetime , 
@w_nombre_of          varchar(255),
@w_fecha_ven          datetime,
@w_oficina            int,
@w_convenio_std       varchar(10),
@w_convenio_elav      varchar(10),
@w_convenio_oxxo      varchar (10),
@w_es_padre           char(1) ,
@w_saldo_exigible      money,
@w_saldo_no_exigible   money

 

select @w_sp_name = 'sp_ref_generica', @w_es_padre  = 'N'

select 
@w_ref_oxxo_out   = null,
@w_ref_elavon_out = null,
@w_ref_std_out    = null,


@w_long_oxxo_ref = 14, 
@w_long_std_ref  = 15,
@w_long_elv_ref  = 15


select @w_fecha_proceso  = fp_fecha 
from cobis..ba_fecha_proceso 



select @w_id_oxxo = pa_char 
from cobis..cl_parametro
where pa_nemonico = 'IDOXXO'


exec @w_error     = sp_estados_cca
@o_est_vencido    = @w_est_vencido    out,
@o_est_cancelado  = @w_est_cancelado  out ,
@o_est_vigente    = @w_est_vigente    out ,
@o_est_novigente  = @w_est_no_vigente out

if @w_error <> 0 begin 
   select
   @w_error = 701103,
   @w_msg = 'Error !:No exite estado vencido'
   goto ERROR_FIN
end


if exists (select 1 from ca_ciclo where ci_prestamo = @i_id_referencia)
      select @w_es_padre = 'S'


if @w_es_padre  = 'N' 
	select 
	@w_operacionca = isnull(op_operacion,0), 
	@w_monto_aprobado    = op_monto_aprobado,
	@w_moneda            = op_moneda, 
	@w_fecha_liq         = op_fecha_ini,
	@w_cliente           = op_nombre,
	@w_fecha_ven         = op_fecha_fin,
	@w_oficina           = op_oficina, 
	@w_toperacion        = op_toperacion
	from ca_operacion 
	where op_banco = @i_id_referencia
	and op_estado not in ( @w_est_cancelado,@w_est_no_vigente)
else 
	select 
	@w_operacionca = isnull(op_operacion,0), 
	@w_monto_aprobado    = op_monto_aprobado,
	@w_moneda            = op_moneda, 
	@w_fecha_liq         = op_fecha_ini,
	@w_cliente           = op_nombre,
	@w_fecha_ven         = op_fecha_fin,
	@w_oficina           = op_oficina, 
	@w_toperacion        = op_toperacion
	from ca_operacion 
	where op_banco = @i_id_referencia


if @@rowcount = 0 or @w_operacionca = 0 begin 
  
  select 
  @w_error = 700001, 
  @w_msg = 'ERROR: NO EXISTE OPERACION VALIDA PARA GENERAR REFERENCIA'
  
  goto  ERROR_FIN   
  
end 



select @w_nombre_of = isnull(of_nombre, '') 
from cobis..cl_oficina 
where of_oficina = @w_oficina


select * into #ca_referencia_generica from ca_referencia_generica where 1 = 2 




select @w_monto = 0

select @w_saldo_exigible = isnull(sum(am_cuota - am_pagado),0)
from ca_amortizacion, ca_dividendo
where am_operacion = @w_operacionca 
and am_operacion   = di_operacion
and am_dividendo   = di_dividendo
and (di_estado  = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso ))


select @w_monto = @w_saldo_exigible
   
   
if  @w_saldo_exigible = 0 begin 

   select @w_saldo_no_exigible = isnull(sum(am_cuota - am_pagado),0)
   from ca_amortizacion, ca_dividendo
   where am_operacion =  @w_operacionca 
   and am_operacion   = di_operacion
   and am_dividendo   = di_dividendo
   and (di_estado = @w_est_vigente )
   
   
   select @w_monto = @w_saldo_no_exigible

end   




   
   




select 
@w_tipo_tran = 'PG' ,
@w_ctr_tipo = 70




if @w_toperacion = 'INDIVIDUAL' begin 

   select 
   @w_tipo_tran = 'PI' ,
   @w_ctr_tipo = 72

  
end 


if @w_toperacion = 'REVOLVENTE' begin 

   select 
   @w_tipo_tran = 'PI',
   @w_ctr_tipo = 71

   
end 


--OXXO 


select 
@w_tipo_tran_corresp =  ctr_tipo, 
@w_convenio_oxxo     = ctr_convenio
from cob_cartera..ca_corresponsal_tipo_ref 
where ctr_co_id       = (select co_id from cob_cartera..ca_corresponsal where co_nombre = 'OXXO')
and   ctr_tipo_cobis  =  @w_tipo_tran
and   ctr_tipo   =    @w_ctr_tipo

select @w_referencia_out = @w_id_oxxo 
                           + rtrim(ltrim(@w_tipo_tran_corresp)) 
                          + rtrim(ltrim(dbo.LlenarI(@w_operacionca, '0', (@w_long_oxxo_ref - (len(@w_tipo_tran_corresp) + len(@w_id_oxxo) +1))))) 
select @w_referencia_out = @w_referencia_out + convert(char(1),dbo.fn_base10(@w_referencia_out))
select @w_ref_oxxo_out  = @w_referencia_out 


insert into #ca_referencia_generica
select 
'OXXO',                 @w_tipo_tran,      @w_operacionca,    @w_fecha_proceso,       @w_fecha_proceso, 
@w_ref_oxxo_out,         @w_moneda,        @w_monto,              '',                  'Z',        --//ESTADO TEMPORAL PARA QUE SEA USADO DENTRO DE LA VIGENCIA
0,                        '',              NULL,              NULL,                    NULL, 
NULL,                     NULL,            NULL,              NULL,                    NULL, 
NULL,                     'I',             @s_user,          @s_term,                  getdate(), 
NULL



--GENERACION REFERENCIA SANTANDER Y ELAVON 


select 
@w_tipo_tran_corresp =  ctr_tipo, 
@w_convenio_std      = ctr_convenio
from cob_cartera..ca_corresponsal_tipo_ref 
where ctr_co_id       = (select co_id from cob_cartera..ca_corresponsal where co_nombre = 'SANTANDER')
and   ctr_tipo_cobis  = @w_tipo_tran
and   ctr_tipo   =    @w_ctr_tipo

select @w_referencia_out = rtrim(ltrim(@w_tipo_tran_corresp)) 
						+ rtrim(ltrim(dbo.LlenarI(@w_operacionca, '0', (@w_long_std_ref - (len(@w_tipo_tran_corresp)  +1))))) 
select @w_referencia_out = @w_referencia_out + convert(char(1),dbo.fn_base10(@w_referencia_out))
select @w_ref_std_out    = @w_referencia_out 


insert into #ca_referencia_generica
select 
'SANTANDER',            @w_tipo_tran,      @w_operacionca,    @w_fecha_proceso,       @w_fecha_proceso, 
@w_ref_std_out,         @w_moneda,         @w_monto,              '',                  'Z',        --//ESTADO TEMPORAL PARA QUE SEA USADO DENTRO DE LA VIGENCIA
0,                        '',              NULL,              NULL,                    NULL, 
NULL,                     NULL,            NULL,              NULL,                    NULL, 
NULL,                     'I',             @s_user,          @s_term,                  getdate(), 
NULL



select 
@w_tipo_tran_corresp =  ctr_tipo ,
@w_convenio_elav      = ctr_convenio
from cob_cartera..ca_corresponsal_tipo_ref 
where ctr_co_id       = (select co_id from cob_cartera..ca_corresponsal where co_nombre = 'ELAVON')
and   ctr_tipo_cobis  = @w_tipo_tran
and   ctr_tipo   =    @w_ctr_tipo

select @w_referencia_out = rtrim(ltrim(@w_tipo_tran_corresp)) 
						 + rtrim(ltrim(dbo.LlenarI(@w_operacionca, '0', (@w_long_elv_ref - (len(@w_tipo_tran_corresp)  +1))))) 
select @w_referencia_out = @w_referencia_out + convert(char(1),dbo.fn_base10(@w_referencia_out))
select @w_ref_elv_out  = @w_referencia_out 


insert into #ca_referencia_generica
select 
'ELAVON',            @w_tipo_tran,      @w_operacionca,    @w_fecha_proceso,       @w_fecha_proceso, 
@w_ref_elv_out,         @w_moneda,         @w_monto,              '',                  'Z',        --//ESTADO TEMPORAL PARA QUE SEA USADO DENTRO DE LA VIGENCIA
0,                        '',              NULL,              NULL,                    NULL, 
NULL,                     NULL,            NULL,          NULL,                    NULL, 
NULL,                     'I',             @s_user,          @s_term,                  getdate(), 
NULL



--BORRADO DE REFERENCIA SI EXISTE UNA 

if exists (select 1 from cob_cartera..ca_referencia_generica  where rg_codigo_interno = @w_operacionca and rg_login  = @s_user)
   delete cob_cartera..ca_referencia_generica where rg_codigo_interno = @w_operacionca
   

 
    

--INSERCION DEL REGISTRO 
insert into cob_cartera..ca_referencia_generica  
select * from #ca_referencia_generica


 
if @@error <> 0 begin
  select 
  @w_error = @w_error,
  @w_msg  = 'NO SE INSERTO EL REGISTRO PAGO CORRESPONSAL'   
  goto ERROR_FIN
end	



--select @o_referencia =  @w_referencia_out   

select
'monto'             = @w_monto,
'fecha_ini'        = convert(varchar,@w_fecha_liq,103),
'cliente_nombre'   = @w_cliente,
'fecha_fin'        = convert(varchar,@w_fecha_ven,103),
'oficina_nombre'   = @w_nombre_of,
'ref_std'          = @w_ref_std_out,
'ref_elv'          = @w_ref_elv_out,
'ref_oxxo'         = @w_ref_oxxo_out,
'conv_std'         = isnull(@w_convenio_std,''),
'conv_elav'        = isnull(@w_convenio_elav,''),
'conv_oxxo'        = isnull(@w_convenio_oxxo,'')


select 
@o_referencia_std	=@w_ref_std_out,  --valor sugerido a pagar,
@o_referencia_oxxo	=@w_ref_oxxo_out, --valor sugerido a pagar
@o_referencia_elv	=@w_ref_elv_out     




return 0


ERROR_FIN:

exec cobis..sp_cerror 
    @t_from = @w_sp_name, 
    @i_num  = @w_error, 
    @i_msg  = @w_msg
return @w_error



GO



