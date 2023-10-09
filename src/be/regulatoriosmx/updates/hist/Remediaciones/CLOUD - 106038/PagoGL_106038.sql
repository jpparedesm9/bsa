
use cob_cartera 
go 

declare
@s_user             		descripcion,
@s_term             		descripcion,
@w_fecha_proceso    		datetime,
@s_ofi              		int,
@s_ssn              		int,
@s_srv              		descripcion,
@w_banco            		varchar(255),
@w_beneficiario     		varchar(255),
@w_op_fecha_ult_proceso    	datetime,
@i_en_linea       			char(1) = 'N' ,
@w_fpago            		descripcion,
@w_moneda           		int,
@w_cod_externo      		varchar(255),
@w_secuencial_ing   		int,
@w_error            		int,
@w_msg              		varchar(255),
@w_op_tramite               int,
@w_operacionca              int,
@w_monto_pago               money,
@w_commit                   char(1)  

--40166	223770002944			8347	4840	GARCIA LINARES SERGIO


select 
@w_operacionca = 40166 ,--AQUI COLOCAR LA OPERACION LA CUAL SE LE VA DESCONTAR LA GARANTIA LIQUIDA 
@w_monto_pago  = 800  --AQUI COLOCAR EL MONTO DE LA GL DEL CLIENTE 

--INICIALIZACION DE VARIABLES
exec @s_ssn  = ADMIN...rp_ssn

--SECUENCIALES
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
--DATOS GENERALES
select 
@s_user             ='usrbatch',
@s_srv              ='CTSSRV',
@s_term             ='batch-apl-gar',
@w_fpago            ='GAR_DEB'

--DATOS DE LA OPERACION 
select
@w_op_fecha_ult_proceso = op_fecha_ult_proceso,
@w_beneficiario  = op_nombre,
@w_banco         = op_banco,
@w_moneda        = op_moneda,
@s_ofi           = op_oficina,
@w_op_tramite    = op_tramite
from   ca_operacion 
where  op_operacion = @w_operacionca 

if @@rowcount = 0   begin 
   select @w_msg = 'NO EXISTE OPERACION'
   goto ERROR
end 


--DATOS DE LA GARANTIA
select @w_cod_externo= gp_garantia
from   cob_credito..cr_gar_propuesta
where  gp_tramite = @w_op_tramite
if @@rowcount = 0   begin 
   select @w_msg = 'NO EXISTE TRAMITE '
   goto ERROR
end 


--INICIO DE LA TRANSACCION 
if @@trancount = 0
begin
   select @w_commit = 'S'
   begin tran
end	  

   exec @w_error = sp_pago_cartera
   @s_user           = @s_user,
   @s_term           = @s_term,
   @s_date           = @w_fecha_proceso,
   @s_sesn           = 1,
   @s_ofi            = @s_ofi ,
   @s_ssn            = @s_ssn,
   @s_srv            = @s_srv,
   @i_banco          = @w_banco,
   @i_beneficiario   = @w_beneficiario,
   @i_fecha_vig      = @w_op_fecha_ult_proceso, 
   @i_ejecutar       = 'S',
   @i_en_linea       = @i_en_linea,
   @i_tipo_cobro     = 'A', --acumulado
   @i_tipo_reduccion = 'T', --reduccion de tiempo 
   @i_producto       = @w_fpago, 
   @i_monto_mpg      = @w_monto_pago,
   @i_moneda         = @w_moneda,
   @i_cuenta         = @w_cod_externo,
   @o_secuencial_ing = @w_secuencial_ing out

if @w_error <> 0 
begin
   select 
   @w_msg = 'ERROR EN APLICACION DE PAGO (sp_pago_cartera)'
   goto ERROR
end  

if @w_commit = 'S'
begin
   select @w_commit = 'N'
   commit tran
end
--FIN TRANSACCION 

ERROR:
if @w_commit = 'S'
begin
   select @w_commit = 'N'
   rollback tran
end

print @w_msg 