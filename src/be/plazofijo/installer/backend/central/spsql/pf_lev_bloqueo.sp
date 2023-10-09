/************************************************************************/
/*      Archivo:                pf_lev_bloqueo.sp                       */
/*      Stored procedure:       sp_lev_bloqueo                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la devolucion de dinero si el deposito    */
/*      activo hasta un dia antes de ejecutar este programa. Ademas     */
/*      cambia el estado del deposito a ANULADO. Si hubo problemas se   */
/*      gera el movimiento monetario por el monto total de todos los    */
/*      problemas que tuvo el deposito. Este programa se usa cuando el  */
/*      cheque devuelto llega al Banco luego de que el deposito se      */
/*      activo                                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_lev_bloqueo') is not null
   drop proc sp_lev_bloqueo
go

create proc sp_lev_bloqueo(
@i_param1               varchar(255) = null)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_error                int,
@w_fecha                datetime,
@w_ente                 int,
@w_msg                  varchar(140),
@w_s_app                varchar(60),
@w_path                 varchar(60),
@w_archivo              varchar(60),
@w_comando              varchar(1000),
@w_fecha_proceso	    datetime,
@w_servidor             varchar(30),
@w_secuencial           int,
@w_anio                 varchar(4),
@w_mes                  varchar(2),
@w_dia                  varchar(2),
@w_fecha_corte          varchar(10),
@w_hora                 varchar(25),
@w_return               int,
@w_numdeci              tinyint

select @w_sp_name = 'sp_lev_bloqueo'


/*SE CARGA LA INFORMACION DESDE EL ARCHIVO PLANO*/

/*OBTIENE LA RUTA DEL S_APP*/
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_s_app is null begin
   select @w_error = 400008, 
   @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR_FIN
end

/*OBTIENE LA RUTA DONDE SE CARGA EL ARCHIVO PLANO*/
select @w_path = pp_path_destino
from  cobis..ba_path_pro
where pp_producto = 14

if @@trancount = 0
begin
   select  @w_msg   = 'NO EXISTE RUTA DE LISTADOS PARA EL BATCH',
           @w_error = 150000
end


select @w_fecha_proceso = fp_fecha 
from   cobis..ba_fecha_proceso

if @@rowcount = 0
begin
   select @w_msg = 'Error - Fecha de Proceso Nula',
          @w_error = 700002
   Goto ERROR_FIN   
end

select @w_anio = convert(varchar(4),datepart(yyyy,@w_fecha_proceso)),
       @w_mes = right('00' + convert(varchar(2),datepart(mm,@w_fecha_proceso)),2), 
       @w_dia = right('00' + convert(varchar(2),datepart(dd,@w_fecha_proceso)),2) 
       
select @w_fecha_corte = (@w_anio + right('00' + @w_mes,2) + right('00'+ @w_dia,2))

select @w_hora = CONVERT(varchar, GETDATE(), 108)

select @w_hora = REPLACE(@w_hora, ':', '_')

if exists (select 1 from sysobjects where name = 'pf_desbloqueo_tmp')
   drop table pf_desbloqueo_tmp

create table pf_desbloqueo_tmp(
de_operacion     varchar(15),
de_cedula        varchar(15)
)


/*CARGA EN VARIABLE @W_COMANDO*/
select @w_comando = @w_s_app +'s_app'+ ' bcp -auto -login cob_pfijo..pf_desbloqueo_tmp in ' + 
                    @w_path + @i_param1 + 
                    ' -b100 -t"|" -c -e'+'Asociacion_Nueva.err'  +  ' -config '+ @w_s_app + 's_app.ini'
--print @w_comando
/*SE EJECUTA CON CMDSHELL*/
   exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO '+ @w_archivo + ' '+ convert(varchar, @w_error)
   goto ERROR_FIN
end

if exists (select 1 from sysobjects where name = 'pf_desbloqueo_tmp2')
   drop table pf_desbloqueo_tmp2

create table pf_desbloqueo_tmp2(
det_fecha         datetime,
det_operacion     varchar(15),
det_cedula        varchar(15),
det_observacion   varchar(60),
det_estado        char(1)
)

insert into pf_desbloqueo_tmp2
select det_fecha     = getdate(),
       det_operacion = de_operacion,
       det_cedula    = de_cedula,
       det_observacion = null,
       det_estado    = 'P'
from cob_pfijo..pf_desbloqueo_tmp 

begin tran

   /*VALIDA LA EXISTENCIA DE LA CEDULA*/
   update pf_desbloqueo_tmp2 set
   det_observacion = 'CEDULA NO EXISTE',
   det_estado      = 'E'
   where det_cedula not in (select en_ced_ruc from cobis..cl_ente)

   if @@error <> 0
   begin
   select @w_error = 145001,
   @w_msg = 'ERROR AL ACTUALIZAR LA TABLA DE TRABAJO'
   goto ERROR_FIN
   end

   /*VALIDA LA EXISTENCIA DE LA CEDULA*/
   update pf_desbloqueo_tmp2 set
   det_observacion = 'NO EXISTE OPERACION DE CDT A DESBLOQUEAR',
   det_estado      = 'E'
   where det_operacion not in (select op_num_banco from cob_pfijo..pf_operacion)

   if @@error <> 0
   begin
   select @w_error = 145001,
   @w_msg = 'ERROR AL ACTUALIZAR LA TABLA DE TRABAJO'
   goto ERROR_FIN
   end

   /*VALIDA LA EXISTENCIA DE LA CEDULA*/
   update pf_desbloqueo_tmp2 set
   det_observacion = 'CDT NO PERTENECE AL CLIENTE INDICADO',
   det_estado      = 'E'
   from cob_pfijo..pf_operacion
   where det_operacion = op_num_banco
   and   det_cedula not in (select en_ced_ruc from cobis..cl_ente)

   if @@error <> 0
   begin
   select @w_error = 145001,
   @w_msg = 'ERROR AL ACTUALIZAR LA TABLA DE TRABAJO'
   goto ERROR_FIN
   end

   /*VALIDA LA EXISTENCIA DE LA CEDULA*/
   update pf_desbloqueo_tmp2 set
   det_observacion = 'CDT NO SE ENCUENTRA CON BLOQUEO',
   det_estado      = 'E'
   from cob_pfijo..pf_operacion
   where det_operacion = op_num_banco
   and   op_operacion not in (select rt_operacion from cob_pfijo..pf_retencion)

   if @@error <> 0
   begin
   select @w_error = 145001,
   @w_msg = 'ERROR AL ACTUALIZAR LA TABLA DE TRABAJO'
   goto ERROR_FIN
   end
   
   /*PROCESADOS CORRECTAMENTE*/
   update pf_desbloqueo_tmp2 set
   det_observacion = 'OPERACION NO FUE BLOQUEADA DE FORMA MASIVA',
   det_estado      = 'E'
   from pf_retencion, pf_operacion
   where rt_operacion = op_operacion
   and   det_operacion = op_num_banco
   and    rt_funcionario <> 'op_batch'

   if @@error <> 0
   begin
      select @w_error = 145001,
      @w_msg = 'ERROR AL ACTUALIZAR LA TABLA DE TRABAJO'
      goto ERROR_FIN
   end

   /*PROCESADOS CORRECTAMENTE*/
   update pf_desbloqueo_tmp2 set
   det_observacion = 'PROCESADO CORRECTAMENTE'
   where det_estado = 'P'

   if @@error <> 0
   begin
      select @w_error = 145001,
      @w_msg = 'ERROR AL ACTUALIZAR LA TABLA DE TRABAJO'
      goto ERROR_FIN
   end

   select ret_operacion = rt_operacion,
    ret_ente      = op_ente,
    ret_cuenta    = rt_cuenta,
    ret_valor     = rt_valor,
    ret_historia  = op_historia
   into #retencion
   from pf_retencion, pf_operacion, pf_desbloqueo_tmp2
   where rt_operacion = op_operacion
   and   op_num_banco = det_operacion
   and   det_estado = 'P'
   and   rt_motivo in (select b.codigo from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.codigo = b.tabla
                                       and   a.tabla = 'pf_mot_des_msv')
   and    rt_observacion = 'CUMPLIMIENTO DE OBLIGACIONES CON PASIVOS'
   and    rt_funcionario = 'op_batch'

   delete pf_retencion 
   from #retencion
   where  ret_operacion = rt_operacion
                                   
                                       
   if @@error <> 0
   begin
   select @w_msg = 'Error - Bloqueo CDTs tabla TEMPORAL',
   @w_error = 147013
   goto ERROR_FIN 
   end

   select @w_servidor =  @@servername
      
   /**  INSERCION DE TRANSACCION DE SERVICIO  **/
   exec @w_secuencial = ADMIN...rp_ssn

   insert into ts_retencion
   select secuencial       = @w_secuencial,    
    tipo_transaccion = 14308, 
    clase            = 'N',
    fecha            = @w_fecha_proceso,
    usuario          = 'op_batch' ,
    terminal         = 'consola',
    srv              = @w_servidor,
    lsrv             = null,
    operacion        = ret_operacion,
    rt_secuencial    = 1, 
    valor            = ret_valor,            
    int_retencion    = 0,
    suspendida       = 'N', 
    motivo           = 'INOP', 
    fecha_crea       = @w_fecha_proceso,
    fecha_mod        = @w_fecha_proceso,
    cupon            = null,
    cuenta           = ret_cuenta, 
    producto         = 'CCA',
    observacion      = 'CUMPLIMIENTO DE OBLIGACIONES CON PASIVOS', 
    funcionario      = 'op_batch'
   from #retencion

   /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
   if @@error <> 0
   begin
   select @w_msg = 'Error - Bloqueo CDTs tabla servicio',
   @w_error = 143001
   goto ERROR_FIN 
   end
    

   /**  COMPARAR SI ESE PLAZO FIJO NO POSEE MAS MONTO RETENIDO  **/
   /**  ACTUALIZAR LA TABLA DE OPERACIONES  **/
   update pf_operacion
   set    op_monto_blq = isnull(op_monto_blq,0)- ret_valor,
    op_retenido = 'N'
   from #retencion
   where  op_operacion = ret_operacion                

   if @@error <> 0
   begin
   select @w_msg = 'Error - Bloqueo CDTs tabla pf_operacion',
   @w_error = 145001
   goto ERROR_FIN   
   end    
   
   --SE INSERTA LA HISTORIA DE LA OPERACION
   insert pf_historia 
   select 
   hi_operacion      = ret_operacion,
   hi_secuencial     = ret_historia,
   hi_fecha          = @w_fecha_proceso,
   hi_trn_code       = 14308,
   hi_valor          = ret_valor,
   hi_funcionario    = 'op_batch',
   hi_oficina        = 4069,
   hi_observacion    = 'CUMPLIMIENTO DE OBLIGACIONES CON PASIVOS', 
   hi_fecha_crea     = @w_fecha_proceso,
   hi_fecha_mod      = @w_fecha_proceso,
   hi_tasa           = null,
   hi_cupon          = null,
   hi_fecha_back     = null,
   hi_fecha_anterior = null,
   hi_saldo_capital  = null,
   hi_secuencia      = null
   from #retencion

   /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
   if @@error <> 0
   begin
   select @w_msg = 'Error - Bloqueo CDTs tabla pf_operacion',
   @w_error = 143006
   goto ERROR_FIN  
   end


   /* GES 07/05/01 CUZ-020-082 Se actualilza una sola vez op_historia
   despues de registrar retencion de deposito y cupones */
   update pf_operacion
   set    op_historia = ret_historia + 1
   from   #retencion
   where  op_operacion = ret_operacion

   if @@error <> 0
   begin
   select @w_msg = 'Error - Bloqueo CDTs tabla pf_operacion',
   @w_error = 145001
   goto ERROR_FIN
   end

COMMIT TRAN

if exists(select 1 from sysobjects where name = 'reporte_desbloqueo')
   drop table reporte_desbloqueo
   
create table reporte_desbloqueo (cadena varchar(2000) not null)  


insert into reporte_desbloqueo (cadena) values('NUMERO DE CDT|OBSERVACION')

insert into reporte_desbloqueo (cadena) 
select  det_operacion + '|' + det_observacion
from pf_desbloqueo_tmp2

/* GENERACION DE REPORTE DE DESBLOQUEO*/
select @w_comando = ''

/* CARGAS EN VARIABLE @W_COMANDO*/
select @w_comando = @w_s_app + 's_app' + ' bcp -auto -login cob_pfijo..reporte_desbloqueo out ' + 
                    @w_path + @i_param1+ 'PROCESADO.txt' + 
                    ' -c -e'+'REPORTE_DETALLE_REGISTROS_NO_ACTUALIZADOS_DETALLADO_CLIENTE.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

/* EJECUTAR CON CMDSHELL */
 exec @w_error = xp_cmdshell @w_comando


If @w_error <> 0 Begin
   select @w_msg = 'Error Generando BCP Reporte bloqueos CDT ' + @w_comando
   goto ERROR_FIN 
End     


return 0
   
ERROR_FIN:

   if @@TRANCOUNT > 0 
      rollback tran
   
   select @w_msg = 'sp_lev_bloqueo' + @w_msg
   print cast(@w_msg as varchar) 
   exec @w_error = sp_errorlog
        @i_fecha      = @w_fecha_proceso,
        @i_error      = @w_error,
        @i_usuario    = 'op_batch',
        @i_tran       = 14108,
        @i_descripcion   = @w_msg
        
   return @w_error
go
