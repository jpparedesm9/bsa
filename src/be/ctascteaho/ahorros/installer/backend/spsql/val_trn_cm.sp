/***********************************************************************/
/*  Archivo:                        val_trn_cm.sp                      */
/*  Stored procedure:               sp_val_trn_cm                      */
/*  Base de Datos:                  cob_ahorros                        */
/*  Producto:                       Ahorros                            */
/***********************************************************************/
/*                           IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de      */
/*  "MACOSA", representantes exclusivos para el Ecuador de la          */
/*  "NCR CORPORATION".                                                 */
/*  Su uso no autorizado queda expresamente prohibido asi como         */
/*  cualquier alteracion o agregado hecho por alguno de sus            */
/*  usuarios sin el debido consentimiento por escrito de la            */
/*  Presidencia Ejecutiva de MACOSA o su representante.                */
/***********************************************************************/
/*                      PROPOSITO                                      */
/*  Realiza la validacion de las transacciones cargadas masivamente    */
/*  desde un archivo plano hacia estructuras temporales                */
/***********************************************************************/
use cob_ahorros
go

if exists(select * from sysobjects where name = 'sp_val_trn_cm')
   drop proc sp_val_trn_cm
go

create proc sp_val_trn_cm(
    @i_archivo_tran    varchar(50),
    @i_archivo_det_chq varchar(50),	
	@i_fecha           datetime,
	@t_show_version    bit = 0
)
as
declare
   @w_sp_name           varchar(30),
   @w_msg               varchar(132),
   @w_error             int,
   @w_fecha_proceso     datetime,
   @w_msg_err_ins       varchar(200),
   @w_dias_vigen_ant       int,
   @w_dias_vigen_pos       int,
   @w_fec_min_chq       datetime,
   @w_fec_max_chq       datetime,
   @w_ejecucion_tran    int,
   @w_ejecucion_det_chq int
   
select @w_sp_name = 'sp_val_trn_cm' 

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
  return 0
end

--FECHA PROCESO
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_ejecucion_tran = isnull(max(lc_ejecucion),0) + 1
from ah_log_cm_tran
where lc_nom_archivo = @i_archivo_tran


select @w_ejecucion_det_chq = isnull(max(lc_ejecucion),0) + 1
from ah_log_cm_tran
where lc_nom_archivo = @i_archivo_det_chq

select @w_msg_err_ins = mensaje
from cobis..cl_errores
where numero = 357035

if @w_msg_err_ins is null
begin
    select @w_msg_err_ins = 'ERROR AL INSERTAR EN EL LOG DE ERRORES'
end

--TRANSACCION NO SE ENCUENTRA EN CATALOGO DE TRANSACCIONES MASIVAS
select @w_msg = ''

select @w_msg = mensaje
from cobis..cl_errores
where numero = 357027

insert into ah_log_cm_tran (lc_nom_archivo, lc_ejecucion, lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357027,--TRANSACCION NO SE ENCUENTRA EN CATALOGO DE TRANSACCIONES MASIVAS
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado      in ('I')
  and tr_transaccion not in (select c.codigo 
                             from cobis..cl_catalogo c, cobis..cl_tabla  t
                             where c.tabla = t.codigo
                               and t.tabla = 'ah_transaccion_masiva')

if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end
	
--CUENTA COBIS Y CUENTA MIGRADA TIENEN VALORES NULOS
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357028

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357028,
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and tr_cta_cobis is null
  and tr_cta_mig is null
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

  
--CUENTA MIGRADA Y CUENTA COBIS NO COINCIDEN
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357029

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357029,--CUENTA MIGRADA Y CUENTA COBIS NO ESTÁN RELACIONADAS
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and tr_cta_cobis is not null
  and tr_cta_mig is not null
  and tr_cta_cobis not in (select ca_cta_banco 
                           from ah_cuenta_aux
                           where ca_cta_banco   = tr_cta_cobis 
                           and ca_cta_banco_mig = tr_cta_mig)

if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end
						   
--CUENTA COBIS NO ES ENVIADA Y NO EXISTE EN LA TABLA DE HOMOLOGACION
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357029

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357029,--CUENTA COBIS NO ES ENVIADA Y NO EXISTE EN LA TABLA DE HOMOLOGACION
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and tr_cta_cobis is null
  and tr_cta_mig is not null
  and tr_cta_mig not in (select ca_cta_banco_mig from ah_cuenta_aux 
                         where ca_cta_banco_mig = tr_cta_mig
                           and ca_cta_banco_mig is not null)--se controla cuando es null porque not in no compara con valores nulos
						   
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end
				   
--Valida que el monto en efectivo sea mayor a 0
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357031

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357031,--MONTO DE LA TRANSACCION ES OBLIGATORIO
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and tr_transaccion in ('RE', 'ND', 'NC')
  and isnull(tr_monto_efe, 0) <= 0
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--EL MONTO EN EFECTIVO Y MONTO EN CHEQUE TIENEN VALOR NULO O CERO - APLICA A DEPOSITOS
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357031

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357031,--EL MONTO EN EFECTIVO Y MONTO EN CHEQUE TIENEN VALOR NULO O CERO
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and tr_transaccion in ('DE')
  and isnull(tr_monto_efe, 0) <= 0
  and isnull(tr_monto_chq, 0) <= 0

if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end
  
--CAUSA ES MANDATORIA  PARA ND Y NC
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357033

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357033,--CAUSA ES MANDATORIA  PARA ND Y NC
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and ((tr_transaccion in ('ND', 'NC') and tr_causa is null)
       or (tr_transaccion in ('DE', 'RE') and tr_causa is not null))
	   
	   if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end
  
--MONTO EN CHEQUE NO ES VALIDO PARA LAS TRANSACCIONES: RETIRO, ND Y NC
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357034

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357034,----MONTO EN CHEQUE NO ES VALIDO PARA LAS TRANSACCIONES: RETIRO, ND Y NC
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I')
  and tr_transaccion in ('RE', 'ND', 'NC')
  and tr_monto_chq is not null
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--------------------------------------
--ORIGEN DE REMESAS NO ES VALIDO. VALIDAR CATALOGO DE ORIGEN DE REMESAS
select @w_msg = ''

select @w_msg = mensaje
from cobis..cl_errores
where numero = 357041

insert into ah_log_cm_tran (lc_nom_archivo, lc_ejecucion, lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357041,--ORIGEN DE REMESAS NO ES VALIDO. VALIDAR CATALOGO DE ORIGEN DE REMESAS
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo         =  @i_archivo_tran
  and tr_estado              in ('I')
  and tr_transaccion         =  'DE'
  and isnull(tr_monto_chq,0) =  0
  and tr_remesas            is not null
  and tr_remesas            not in (select c.codigo 
                                    from cobis..cl_catalogo c, cobis..cl_tabla  t
                                    where c.tabla = t.codigo
                                     and t.tabla = 'ah_ori_remesas')

if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end


--ORIGEN DE REMESAS ES VALIDO SOLO PARA DEPOSITOS EN EFECTIVO
select @w_msg = ''

select @w_msg = mensaje
from cobis..cl_errores
where numero = 357042

insert into ah_log_cm_tran (lc_nom_archivo, lc_ejecucion, lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357042,--ORIGEN DE REMESAS ES VALIDO SOLO PARA DEPOSITOS EN EFECTIVO
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm
where tr_nom_archivo   = @i_archivo_tran
  and tr_estado        in ('I')
  and ((tr_transaccion in ('RE', 'ND', 'NC'))
       or 
	   (tr_transaccion = 'DE' and tr_monto_chq is not null))
  and tr_remesas    is not null
  
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--EL TOTAL DE LOS CHEQUES NO COINCIDE CON EL MONTO EN CHEQUES
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357032

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_tran,
       @w_ejecucion_tran,
       tr_secuencial,
	   357032,--VALOR DE CHEQUES NO COINCIDE CON LA SUMA DEL DETALLE DE CHEQUES
	   @w_msg,
	   @i_fecha
from ah_transacciones_cm, ah_det_cheq_cm
where tr_nom_archivo = @i_archivo_tran
  and tr_estado in ('I', 'V')
  and dc_estado in ('I', 'V')
  and tr_transaccion = 'DE'
  and dc_sec_dep = tr_secuencial
  group by tr_secuencial,tr_monto_chq
  having sum(dc_monto) <> isnull(tr_monto_chq,0)

if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--VALIDACIONES DEL CHEQUE
--VALIDACION DEL MONTO DEL CHEQUE
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357031

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_sec_chq, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_det_chq,
       @w_ejecucion_det_chq,
	   dc_sec_dep,
	   dc_sec_chq,
	   357031,--VALOR DEL CHEQUE ES CERO
	   @w_msg,
	   @i_fecha
from ah_det_cheq_cm
where dc_nom_archivo = @i_archivo_det_chq
  and dc_estado in ('I')
  and dc_monto <= 0
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--CHEQUE REPETIDO
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357040

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_sec_chq, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_det_chq,
       @w_ejecucion_det_chq,
	   dc_sec_dep,
	   dc_sec_chq,
	   357040,--CHEQUE REPETIDO
	   @w_msg,
	   @i_fecha
from ah_det_cheq_cm
where dc_nom_archivo = @i_archivo_det_chq
  and dc_estado in ('I')
  and dc_sec_dep in (select dc_sec_dep 
                     from ah_det_cheq_cm
                     where dc_nom_archivo = @i_archivo_det_chq
                       and dc_estado in ('I')
                     group by dc_sec_dep, dc_cod_ban, dc_cuenta_chq, dc_num_chq
                     having count(dc_num_chq)>1)
  
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--EL CHEQUE YA NO TIENE VIGENCIA

--FECHA MINIMA ANTERIOR
select @w_dias_vigen_ant = pa_int 
from cobis..cl_parametro
where pa_nemonico = 'DVCH'
  and pa_producto = 'CTE'
  
if @w_dias_vigen_ant is not null  
begin 
    select @w_fec_min_chq = dateadd( dd, -@w_dias_vigen_ant,@w_fecha_proceso)
    
    select @w_msg = ''
    select @w_msg = mensaje
    from cobis..cl_errores
    where numero = 357039
    

    insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_sec_chq, lc_num_error, lc_mensaje_error ,lc_fecha)
    select @i_archivo_det_chq,
           @w_ejecucion_det_chq,
    	   dc_sec_dep,
    	   dc_sec_chq,
    	   357039,--EL CHEQUE YA NO TIENE VIGENCIA
    	   @w_msg,
    	   @i_fecha
    from ah_det_cheq_cm
    where dc_nom_archivo = @i_archivo_det_chq
      and dc_estado in ('I')
      and dc_fecha_emi  < @w_fec_min_chq
          
    if @@error <> 0
    begin
        select @w_error = 357035
    	select @w_msg   = @w_msg_err_ins
        goto ERROR
    end
end

--FECHA MAXIMA DE VIGENCIA
select @w_dias_vigen_pos = pa_int 
from cobis..cl_parametro
where pa_nemonico = 'DFMCH'
  and pa_producto = 'CTE'
  
if @w_dias_vigen_pos is not null  
begin 
    select @w_fec_max_chq = dateadd( dd, @w_dias_vigen_pos,@w_fecha_proceso)
    
    select @w_msg = ''
    select @w_msg = mensaje
    from cobis..cl_errores
    where numero = 357039

    insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_sec_chq, lc_num_error, lc_mensaje_error ,lc_fecha)
    select @i_archivo_det_chq,
           @w_ejecucion_det_chq,
    	   dc_sec_dep,
    	   dc_sec_chq,
    	   357039,--EL CHEQUE YA NO TIENE VIGENCIA
    	   @w_msg,
    	   @i_fecha
    from ah_det_cheq_cm
    where dc_nom_archivo = @i_archivo_det_chq
      and dc_estado in ('I')
      and dc_fecha_emi  > @w_fec_max_chq
          
    if @@error <> 0
    begin
        select @w_error = 357035
    	select @w_msg   = @w_msg_err_ins
        goto ERROR
    end
end


--EL CODIGO DEL BANCO DEL CHEQUE NO ES VALIDO
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357037
insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_sec_chq, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_det_chq,
       @w_ejecucion_det_chq,
	   dc_sec_dep,
	   dc_sec_chq,
	   357037,--EL CODIGO DEL BANCO DEL CHEQUE NO ES VALIDO
	   @w_msg,
	   @i_fecha
from ah_det_cheq_cm
where dc_nom_archivo = @i_archivo_det_chq
  and dc_estado in ('I')
  and dc_cod_ban not in (select ba_banco from cob_remesas..re_banco)
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end

--ACTUALIZACION DE LA CUENTA COBIS
update ah_transacciones_cm
set tr_cta_cobis = ca_cta_banco
from ah_transacciones_cm, ah_cuenta_aux
where tr_nom_archivo = @i_archivo_tran
  and tr_estado  = 'I'
  and tr_cta_mig = ca_cta_banco_mig
  and tr_cta_cobis is null
  
if @@error <> 0
begin
    select @w_error = 357038
	select @w_msg   = 'ERROR AL INSERTAR EL NUMERO DE CUENTA COBIS EN EL REGISTRO'
    goto ERROR
end


--NUMERO DE DEPOSITO DEL CHEQUE NO SE ENCUENTRA EN EL ARCHIVO DE TRANSACCIONES
select @w_msg = ''
select @w_msg = mensaje
from cobis..cl_errores
where numero = 357030

insert into ah_log_cm_tran (lc_nom_archivo,  lc_ejecucion,  lc_sec_tran, lc_sec_chq, lc_num_error, lc_mensaje_error ,lc_fecha)
select @i_archivo_det_chq,
       @w_ejecucion_det_chq,
	   dc_sec_dep,
	   dc_sec_chq,
	   357030,--NUMERO DE DEPOSITO DEL CHEQUE NO SE ENCUENTRA EN EL ARCHIVO DE TRANSACCIONES
	   @w_msg,
	   @i_fecha
from ah_det_cheq_cm
where dc_nom_archivo = @i_archivo_det_chq
  and dc_estado in ('I')
  and (dc_sec_dep not in (select tr_secuencial 
                         from ah_transacciones_cm
						 where tr_transaccion = 'DE')
       or dc_sec_dep in  (select lc_sec_tran 
                          from ah_log_cm_tran
                          where lc_nom_archivo = @i_archivo_tran    
        				    and lc_ejecucion   = @w_ejecucion_tran)
       )							
  
if @@error <> 0
begin
    select @w_error = 357035
	select @w_msg   = @w_msg_err_ins
    goto ERROR
end


----------------------------------------------------------------
--ACTUALIZACION DE REGISTROS QUE NO PRESENTARON ERROR A ESTADO V
--TRANSACCIONES
update ah_transacciones_cm set tr_estado = 'E'
where tr_nom_archivo = @i_archivo_tran
  and tr_estado = 'I'
  and tr_secuencial in (select lc_sec_tran 
                        from ah_log_cm_tran
                        where lc_nom_archivo = @i_archivo_tran    
						  and lc_ejecucion   = @w_ejecucion_tran)
						  
update ah_transacciones_cm set tr_estado = 'E'
where tr_nom_archivo = @i_archivo_tran
  and tr_transaccion = 'DE'
  and tr_estado = 'I'
  and tr_secuencial in (select lc_sec_tran 
                        from ah_log_cm_tran	                     
						 where lc_nom_archivo = @i_archivo_det_chq
						   and lc_ejecucion   = @w_ejecucion_det_chq)
  
if @@error <> 0
begin
    select @w_error = 357036
    goto ERROR
end


--CHEQUES
update ah_det_cheq_cm set dc_estado = 'E'
from ah_log_cm_tran, ah_det_cheq_cm
where lc_nom_archivo = dc_nom_archivo
  and lc_nom_archivo = @i_archivo_det_chq
  and lc_ejecucion   = @w_ejecucion_det_chq 
  and lc_sec_tran    = dc_sec_dep
  and lc_sec_chq     = dc_sec_chq
  and dc_estado = 'I'
  
if @@error <> 0
begin
    select @w_error = 357036
    goto ERROR
end
 
--ACTUALIZACION DE REGISTROS QUE NO PRESENTARON ERROR A ESTADO V
--TRANSACCIONES

update ah_transacciones_cm set tr_estado = 'V'
where tr_nom_archivo in (@i_archivo_tran, @i_archivo_det_chq)
  and tr_estado = 'I'

if @@error <> 0
begin
    select @w_error = 357036
    goto ERROR
end


update ah_det_cheq_cm set dc_estado = 'V'
where dc_nom_archivo = @i_archivo_det_chq
  and dc_estado = 'I'

if @@error <> 0
begin
    select @w_error = 357036
    goto ERROR
end

return 0
  
ERROR: 
    exec sp_errorlog
    	@i_fecha       = @w_fecha_proceso,
    	@i_error       = @w_error,
    	@i_usuario     = 'batch',
		@i_tran        = 0,
    	@i_descripcion = @w_msg,
    	@i_programa    = @w_sp_name
    	return 1
  
go

