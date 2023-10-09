
/************************************************************************/
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           SMO                                     */
/*      archivo:                lcr_rdes.sp                              */
/*      Fecha de escritura:     02/Jul/2019                             */
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
/*      Reversa los desembolsos rechazado por el banco                  */
/************************************************************************/  
/*                        MOFICIACIONES                                 */
/* 02/Jul/2019          SMO                  Emision inicial            */
/* 10/Sept/2019         SMO                  Corrección estados         */
/* 19/Oct/2021          KVI           Req.166501-Comentado reverso a los*/
/*                                    desembolsos                       */
/************************************************************************/  

use cob_cartera
go

IF OBJECT_ID ('sp_lcr_resp_desembolso') IS NOT NULL
    DROP PROCEDURE sp_lcr_resp_desembolso
GO

create proc sp_lcr_resp_desembolso
(
@s_ssn           int         = null,
@s_sesn          int         = null,
@s_date          datetime    = null,
@s_user          login       = null,
@s_term          varchar(30) = null,
@s_ofi           smallint    = null,
@s_srv           varchar(30) = null,
@s_lsrv          varchar(30) = null,
@s_rol           smallint    = null,
@s_org           varchar(15) = null,
@s_culture       varchar(15) = null,
@t_rty           char(1)     = null,
@t_debug         char(1)     = 'N',
@t_file          varchar(14) = null,
@t_trn           smallint    = null,     
@o_msg           varchar(255)= null OUT
)
as 
declare
@w_banco 				cuenta,
@w_linea 				int,
@w_consecutivo 		int,
@w_incremental  		int,
@w_secuencial  		int,
@w_cliente  			int,
@w_monto  				varchar(10),
@w_operacion  			int,
@w_fecha_real  		datetime,
@w_fecha       		varchar(20),
@w_hora       			varchar(5),
@w_folio         		varchar(10),
@w_operacion_str 		varchar(10),
@w_causa_rechazo  	varchar(10),
@w_causa_rechazo_str varchar(30),
@w_mail            	varchar(255),
@w_id                int = 0,
@w_subject           varchar(100),
@w_body              varchar(500),
@w_error             int,
@w_msg               varchar(200),
@w_enteCobis         int,
@w_nombreC           varchar(250),
@w_anio              varchar(4),	
@w_mes_in			  	varchar(15),
@w_mes_es			  	varchar(15),
@w_dia 				  	varchar(2),
@w_fecha_b           varchar(25),
@w_parraf_1          varchar(250),
@w_parraf_2          varchar(250),
@w_monto_m           varchar(20),
@w_referencia        varchar(30)
	
	
select 
@w_banco = '0',
@w_linea = 0,
@w_consecutivo = 0

print 'sp_lcr_resp_desembolso Antes'

--return 0

print 'sp_lcr_resp_desembolso Despues'

create table #ordenes_reversar(
or_incremental int identity(1,1),
or_banco cuenta,
or_linea int,
or_cliente int,
or_consecutivo int,
or_operacion   int,
or_causa       varchar(10)
)

--desembolsos lcr exitosos
create table #desembolsos_exitosos(
or_banco cuenta
)
/*-- Se comenta en REQ 166501 TRX SOCIO COMERCIAL
--Recupera las operaciones revolventes
insert into #ordenes_reversar
select 
or_banco 		= odf_banco,
or_linea 		= odf_linea,
or_cliente 		= op_cliente,
or_consecutivo = odf_consecutivo,
or_operacion 	= op_operacion,
or_causa 		= odf_causa_rechazo
from ca_santander_orden_deposito_fallido, ca_operacion
where odf_banco 	= op_banco
and op_toperacion = 'REVOLVENTE'
and odf_estado 	= 'P'


--REVERSAR LAS ORDENES FALLIDAS
select @w_incremental=0
while 1=1 
begin
	select top 1
	@w_banco 			= or_banco,
	@w_linea 			= or_linea,
	@w_consecutivo 	= or_consecutivo,
	@w_incremental 	= or_incremental,
	@w_operacion   	= or_operacion,
	@w_cliente     	= or_cliente,
	@w_causa_rechazo 	= or_causa
	from #ordenes_reversar
	where or_incremental > @w_incremental
	order by or_incremental
	
	if @@rowcount = 0
		break;
	
	select @w_secuencial = sod_secuencial
	from ca_santander_orden_deposito 
	where sod_linea =@w_linea
	and sod_banco=@w_banco
	and sod_consecutivo = @w_consecutivo
  
  	--reversar la transaccion
  	exec @w_error   = sp_fecha_valor 
	@i_operacion 	= 'R',
	@i_banco 		= @w_banco,
	@i_secuencial	= @w_secuencial,
	@s_user 			= @s_user,
	@s_term 			= @s_term,
	@s_date 			= @s_date
	 
  	if @w_error = 0
	begin
		update ca_santander_orden_deposito_fallido
		set odf_estado 		= 'R' --reversado
		where  odf_banco 		= @w_banco
		and odf_linea 			= @w_linea
		and odf_consecutivo 	= @w_consecutivo ----tr_secuencial
	 
	--NOTIFICAR A LA B2C
	select 
	@w_monto 			= convert(varchar(10),dtr_monto),
	@w_fecha_real 		= tr_fecha_real
	from ca_transaccion, ca_det_trn
	where tr_operacion 	= dtr_operacion
	and tr_secuencial 	= dtr_secuencial
	and tr_secuencial 	= @w_secuencial
	and tr_operacion		= @w_operacion
	and dtr_afectacion 	=  'D'
	and tr_tran 			= 'DES'

	select @w_fecha	= convert(varchar(20), @w_fecha_real, 107)
	select @w_hora 	= convert(varchar(5), @w_fecha_real, 8)
	select @w_folio 	= convert(varchar(10),@w_operacion)+'_'+convert(varchar,@w_consecutivo)
	 	
 	 	
	select @w_causa_rechazo_str =  valor 
	from cobis..cl_catalogo c, cobis..cl_tabla t
	where c.tabla 	= t.codigo
	and t.tabla 	= 'causa_rechazo'
	and c.codigo 	= @w_causa_rechazo
	
	if @w_causa_rechazo_str is null
	   select @w_causa_rechazo_str = @w_causa_rechazo
	   
	exec cob_bvirtual..sp_b2c_msg_ingresar
	@i_cliente	= @w_cliente,
	@i_banco    = @w_banco,                  
	@i_tipo_msg	= 'ERROR_DES',                 
	@i_var1   	= @w_monto,     
	@i_var2   	= @w_fecha,     
	@i_var3   	= @w_hora,     
	@i_var4   	= @w_folio,
	@i_var5   	= @w_causa_rechazo_str

	end
	else 
	begin
		print 'error al reversar op_banco :'+@w_banco+' error:'+convert(varchar,@w_error)  		
	end
end --end while
*/
create table #ordenes_desembolso(
	od_referencia   varchar(30),
	od_consecutivo  int  null,
	od_linea        int null,
	od_fecha        varchar(8)
)

create table #ordenes_notificar(
	on_cliente   int,
	on_nom_cliente varchar(100),
 	on_fecha     datetime,
	on_monto     money,
	on_banco     cuenta,
	on_tipo      varchar(30),
	on_referencia varchar(30)
)

--NOTIFICAR LOS DESEMBOLSOS EXITOSOS

insert into #ordenes_desembolso
select rd_descripcion_referencia, 
convert(int,REPLACE(rd_descripcion_referencia,'ABONO TUIIO',''))/10000, 
convert(int,REPLACE(rd_descripcion_referencia,'ABONO TUIIO',''))% 10000, 
rd_fecha_transferencia
from ca_santander_resultado_desembolso
where rd_estado_mail = 'I'
and rd_causa_rechazo = '00'
   
insert into #ordenes_notificar
select			
sod_cliente,
null,  
convert(datetime,sod_fecha_real),
sod_monto,
sod_banco,
sod_tipo,
od_referencia
from ca_santander_orden_deposito,#ordenes_desembolso,ca_operacion
where 
sod_banco 		  		= op_banco
and sod_fecha 			= od_fecha
and sod_consecutivo 	= od_consecutivo
and sod_linea 			= od_linea
and sod_tipo 			= 'DES'
and op_toperacion 	= 'REVOLVENTE'	

update #ordenes_notificar 
set on_nom_cliente = en_nombre + ' '+p_p_apellido
from cobis..cl_ente
where en_ente= on_cliente

select @w_id 			= te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'
select @w_subject 	= 'Utilización de la línea de crédito'
select @w_parraf_2	= 'Recuerda realizar en tiempo el pago de tu crédito y cuidar tu historial crediticio.'
select @w_anio 		= LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
select @w_mes_in  	= LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
select @w_dia  		= LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
select @w_mes_es 		= (case @w_mes_in when 'January' then 'Enero' 
                              when 'February' then 'Febrero' when 'March' then 'Marzo' 
                              when 'April' then 'Abril' when 'May' then 'Mayo' 
                              when 'June' then 'Junio' when 'July' then 'Julio' 
                              when 'August' then 'August' when 'August' then 'August' 
                              when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                              when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)
    
select @w_fecha_b 	=  @w_dia+'-'+@w_mes_es+'-'+@w_anio
select @w_enteCobis 	= 0

while 1=1
begin
   select top 1 
   @w_enteCobis = on_cliente,
   @w_monto_m   = convert(varchar(10),on_monto),
   @w_nombreC   = on_nom_cliente,
   @w_referencia     = on_referencia
   from #ordenes_notificar
   where on_cliente>@w_enteCobis
   order by on_cliente
   
   if @@rowcount = 0
      break
   
   select @w_mail = di_descripcion 
   from cobis..cl_direccion
   where di_ente=@w_enteCobis
   and di_tipo = 'CE'    
   
	select @w_parraf_1 = 'Acabas de utilizar tu línea de crédito, se ha registrado un retiro por la cantidad de $'+@w_monto_m+' desde tu aplicación móvil Tuiio Santander.'
   select @w_parraf_2 = 'Recuerda realizar en tiempo el pago de tu crédito y cuidar tu historial crediticio.'
	select @w_body 	 = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>'+@w_parraf_1+'</parrafoDoc><parrafoDoc2>'+@w_parraf_2+'</parrafoDoc2></data>'

 	exec @w_error 				  =  cobis..sp_despacho_ins
         @i_cliente          = @w_enteCobis,
         @i_template         = @w_id,
         @i_servicio         = 1,
         @i_estado           = 'P',
         @i_tipo             = 'MAIL',
         @i_tipo_mensaje     = 'I',
         @i_prioridad        = 1,
         @i_from             = null,
         @i_to               = @w_mail,
         @i_cc               = null,
         @i_bcc              = null,
         @i_subject          = @w_subject,
         @i_body             = @w_body,
         @i_content_manager  = 'HTML',
         @i_retry            = 'S',
         @i_fecha_envio      = null,
         @i_hora_ini         = null,
         @i_hora_fin         = null,
         @i_tries            = 0,
         @i_max_tries        = 2,
         @i_var1             = null
    	   
    if @w_error <> 0
    begin
       select @w_msg = 'ERROR AL ENVIAR NOTIFICACION CODIGO DEL CLIENTE'+convert(varchar(100),@w_enteCobis)
       select @w_error = 5000
       
    end	
    else
    	update ca_santander_resultado_desembolso
	 	set rd_estado_mail = 'P'
	 	where rd_descripcion_referencia =   @w_referencia
end
return 0


