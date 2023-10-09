/************************************************************************/
/*   Archivo:             ah_batch_act_est_cta.sp                       */
/*   Stored procedure:    sp_batch_act_cta                              */
/*   Base de datos:       cob_ahorros                                   */
/*   Producto:            Ahorros                                       */
/*   Disenado por:        Edwin Jimenez                                 */
/*   Fecha de escritura:  19 de Agosto de 2015                          */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Proceso batch para actualizar cuentas de ahorros                   */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   18/Ago/2015        Edwin Jimenez     Emision Inicial ORS 001237    */
/*   02/May/2016        J. Calderon       Migración a CEN               */
/************************************************************************/

USE cob_ahorros
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_batch_act_cta')
   drop proc sp_batch_act_cta
go

create proc sp_batch_act_cta(
@t_show_version     bit     = 0
)

as
declare
@w_codigo           int,
@w_error            int,
@w_tipo_id          char(2),          
@w_nombrelargo      varchar(64),
@w_observacion      varchar(255),
@w_path             varchar(256),
@w_table            varchar(256),
@w_file             varchar(256),
@w_msg              varchar(256),
@w_sql              varchar(1024),
@w_backup           varchar(128),
@w_cmd              sysname,
@w_fecha_proceso    datetime,
@w_comando          varchar(500),
@w_s_app            varchar(50),
@w_bd               varchar(50),
@w_fuente           varchar(250),
@w_path_error_s_app varchar(250),
@w_errores          varchar(250),
@w_tabla            varchar(250),
@w_ente             int,
@w_producto         int,
@w_cta_banco        cuenta,
@w_estado           char(1),
@w_operacion        char(1),
@w_ofi_cta          int,
@w_ssn              int,
@w_sp_name          varchar(30)



/* Captura del nombre del Store Procedure */

select @w_sp_name = 'sp_batch_act_cta'


---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end

/*Creacion de la tabla donde se almacenaran los datos contenidos en el archivo plano*/
if exists (select 1 from sysobjects where name = 'ah_ctas_actualizar' and xtype = 'U')
   drop table ah_ctas_actualizar
   
create table ah_ctas_actualizar(
ca_cta_banco      varchar(12),
ca_operacion      char(1),
ca_observacion    varchar(254))

/*Parametro de Ubicacion*/
select @w_path = ba_path_destino
from  cobis..ba_batch 
where ba_arch_fuente = 'cob_ahorros..sp_batch_act_cta'

select @w_path_error_s_app = pa_char
from cobis..cl_parametro
where pa_nemonico = 'S_APP'

if @@rowcount = 0 begin
   print @@rowcount
   print @w_path_error_s_app
   print @w_path
   print 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
   return 1   
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 

/* Carga Parametros para el bcp */
select @w_s_app    = @w_path_error_s_app + 's_app',
       @w_cmd      = @w_s_app + ' bcp ',
       @w_bd       = 'cob_ahorros', 
       @w_file     = 'Act_DesAct_Cta_AHO.txt',  
       @w_tabla    = 'ah_ctas_actualizar',
       @w_fuente   = @w_path + @w_file,
       @w_errores  = @w_path + @w_file + '.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' in ' + @w_fuente + ' -c -t"|" -auto -login '  + '-config ' + @w_s_app + '.ini > ' + @w_errores
 
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print @w_error
   return @w_error
end

/* Actualiza uno a uno y genera la transaccion de servicio*/
while 1 = 1 begin

   select top 1 
   @w_tipo_id        = en_tipo_ced,
   @w_ente           = en_ente,
   @w_nombrelargo    = en_nomlar,
   @w_cta_banco      = ah_cta_banco,
   @w_observacion    = ca_observacion,
   @w_ofi_cta        = ah_oficina,
   @w_producto       = ah_producto,
   @w_operacion      = ca_operacion
   from  cobis..cl_ente, 
         cob_ahorros..ah_ctas_actualizar,
         cob_ahorros..ah_cuenta
   where en_ced_ruc   = ah_ced_ruc
     and en_ente      = ah_cliente
     and ah_cta_banco = ca_cta_banco
   
   if @@rowcount = 0
      break
    
    exec @w_ssn = ADMIN...rp_ssn
     
    /* VALIDA ACTIVACIONES DE CUENTAS */
    if @w_operacion = 'A'
    begin
    
       /*  RESPALDO */
       insert into ah_log_ctas_act 
       select ah_cta_banco, ah_estado,     
               ah_cliente,ah_ced_ruc,'I'    
       from cob_ahorros..ah_ctas_actualizar,
             cob_ahorros..ah_cuenta
       where ah_cta_banco = ca_cta_banco
         and ah_cta_banco = @w_cta_banco
       
       if @@error <> 0 begin
          select 
          @w_msg   = 'ERROR RESPALDO INSERTA CUENTA = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end 
         
       update cob_ahorros..ah_cuenta with(rowlock) set
       ah_estado = 'A'
       where ah_cta_banco = @w_cta_banco
         and ah_cliente   = @w_ente
         
       if @@error <> 0 begin
          select 
          @w_msg   = 'ERROR UPDATE CUENTA = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end  
       
       /* INSERTAR TRANSACCION DE SERVICIO */   
       insert into ah_tran_servicio (
       ts_secuencial,  ts_ssn_branch, ts_tipo_transaccion,
       ts_tsfecha,     ts_usuario,    ts_terminal, 
       ts_filial,      ts_oficina,    ts_oficina_cta, 
       ts_hora,        ts_estado,     ts_cta_banco,  
       ts_producto,    ts_descripcion_ec,
       ts_cliente)
       values (
       @w_ssn,          0,             4145,
       @w_fecha_proceso,'opbatch',     'consola',
       1,               1,             @w_ofi_cta, 
       getdate(),       'A',           @w_cta_banco,  
       @w_producto,     @w_observacion,
       @w_ente)
       
       if @@error <> 0 begin
          select 
          @w_msg   = 'ERROR INSERTANDO TRANSACCION DE SERVICIO CUENTA = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end 
    end

    if @w_operacion = 'I'
    begin
       
       select 
       @w_cta_banco = lca_cta_banco,
       @w_estado    = lca_estado  
       from cob_ahorros..ah_log_ctas_act
       where lca_cta_banco = @w_cta_banco
         and lca_cliente   = @w_ente
         and lca_estado    = 'I'
         and lca_control   = 'I'
         
       if @@rowcount = 0 begin
          select 
          @w_msg   = 'ERROR NO SE ENCUENTRA CTA EN TABLA RESPALDO = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end

       update cob_ahorros..ah_cuenta with(rowlock) set
       ah_estado = @w_estado
       where ah_cta_banco = @w_cta_banco
         and ah_cliente   = @w_ente
         
       if @@error <> 0 begin
          select 
          @w_msg   = 'ERROR UPDATE CUENTA = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end  
       
       /* INSERTAR TRANSACCION DE SERVICIO */   
       insert into ah_tran_servicio (
       ts_secuencial,  ts_ssn_branch, ts_tipo_transaccion,
       ts_tsfecha,     ts_usuario,    ts_terminal, 
       ts_filial,      ts_oficina,    ts_oficina_cta, 
       ts_hora,        ts_estado,     ts_cta_banco,  
       ts_producto,    ts_descripcion_ec,
       ts_cliente)
       values (
       @w_ssn,          0,             4145,
       @w_fecha_proceso,'opbatch',     'consola',
       1,               1,             @w_ofi_cta, 
       getdate(),       @w_estado,     @w_cta_banco,  
       @w_producto,     @w_observacion,
       @w_ente)
       
       if @@error <> 0 begin
          select 
          @w_msg   = 'ERROR INSERTANDO TRANSACCION DE SERVICIO CUENTA = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end  
       
       update ah_log_ctas_act
       set   lca_control    = 'P'
       where lca_cta_banco = @w_cta_banco
       
       if @@error <> 0 begin
          select 
          @w_msg   = 'ERROR UPDATE CUENTA = ' + @w_cta_banco,
          @w_error = 105027
          goto ERROR
       end 
      
    end
  
    delete ah_ctas_actualizar
    where ca_cta_banco = @w_cta_banco
     
end

/*se revisa si todos las cuentas fueron actualizadas y posteriormente borradas*/
if exists (select 1 from cob_ahorros..ah_ctas_actualizar) begin

   select @w_msg = 'LAS SIGUIENTES CUENTAS PRESENTAN INCONVENIENTES [CTA_AHORROS] '
   
   while 1 = 1 begin
      select top 1
      @w_cta_banco = ca_cta_banco  
      from cob_ahorros..ah_ctas_actualizar
      
      if @@rowcount = 0 
         break
      
      select @w_msg = @w_msg + convert(varchar(12),@w_cta_banco) + ' '
      
      delete cob_ahorros..ah_ctas_actualizar
      where ca_cta_banco = @w_cta_banco
   end
   
   select 
   @w_error = 141050
   goto ERROR
   
end
   
return 0

ERROR:
   print @w_msg 
   exec @w_error        = sp_errorlog
        @i_fecha        = @w_fecha_proceso,
        @i_error        = @w_error,
        @i_usuario      = 'op_batch',
        @i_tran         = 7946,
        @i_descripcion  = @w_msg,
        @i_rollback     = 'N'

return @w_error



go

