
use cob_cartera
go
/************************************************************/
/*   ARCHIVO:         sp_ejec_deslcr.sp                     */
/*   NOMBRE LOGICO:   sp_ejecuta_desembolso_lcr             */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  biginternacionales de */
/*   propiedad bigintelectual.  Su uso  no  autorizado dara */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Ejecutar los desembolsos registrados por socio          */
/*  comercial                                               */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR         RAZON                      */
/* 11/10/2021     DCumbal        Emision Inicial            */
/************************************************************/

if exists(select 1 from sysobjects where name = 'sp_ejecuta_desembolso_lcr')
    drop proc sp_ejecuta_desembolso_lcr
go
create proc sp_ejecuta_desembolso_lcr (
    @t_show_version     bit         =   0
)as
declare
@s_ssn           int,
@s_user          login,
@s_date          datetime ,
@s_srv           descripcion,
@s_term          descripcion,
@s_rol           int,
@s_lsrv          descripcion ,
@s_ofi           int,
@s_sesn          int,
@w_msg           descripcion,
@w_sp_name       varchar(20),
@w_s_app         varchar(50),
@w_path          varchar(50),
@w_banco         cuenta,
@w_monto_compra  money,
@w_monto_total   money,
@w_comision      money,
@w_iva_comision  money,
@w_fecha         datetime,
@w_secuencial    int,
@w_mensaje       varchar(255),
@w_numero_error  int,
@w_error         int,
@w_numdec        int,
@w_moneda        int 

select @w_sp_name = 'sp_ejecuta_desembolso_lcr'

--Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

--INICIALIZACION DE VARIABLES

select 
@s_user             ='usrbatch',
@s_srv              ='CTSSRV',
@s_term             ='batch-utilizacion',
@s_rol              =3,
@s_lsrv             ='CTSSRV',
@w_sp_name          = 'sp_ejecuta_desembolso_lcr',
@s_date             = fp_fecha 
from cobis..ba_fecha_proceso 

select @w_secuencial = 0

while 1 = 1
begin
   select  @s_ssn  = convert(int,rand()*10000)
   
   select top 1 
   @w_secuencial   = dp_secuencial,
   @w_banco        = dp_banco,
   @w_monto_compra = dp_monto_compra,
   @w_monto_total  = dp_monto_aprobado,
   @w_fecha        = dp_fecha_proceso, 
   @w_comision     = dp_comision,
   @w_iva_comision = dp_iva   
   from ca_desembolsos_pendientes
   where dp_secuencial > @w_secuencial 
   and   dp_estado = 'I'
   order by dp_secuencial
   
   if @@rowcount = 0 break
   
   select 
   @s_ofi    = op_oficina ,
   @w_moneda = op_moneda
   from ca_operacion 
   where op_banco = @w_banco
   
   if @@rowcount =0 begin 
      select @w_msg = 'ERROR NO EXISTE LA OPERACION ' 
      goto Siguiente
   end
   
   exec @w_error = sp_decimales
   @i_moneda      = @w_moneda ,
   @o_decimales   = @w_numdec out
   
   select 
   @w_monto_total  = round(@w_monto_total,@w_numdec),
   @w_monto_compra = round(@w_monto_compra,@w_numdec)
   
   begin try
      
      exec @w_error= cob_cartera..sp_lcr_desembolsar 
      @s_ssn              = @s_ssn,
      @s_ofi              = @s_ofi,
      @s_user             = @s_user,
      @s_sesn             = @s_ssn,
      @s_term             = @s_term,
      @s_srv              = @s_srv,
      @s_date             = @s_date,
      @i_banco            = @w_banco ,
      @i_monto            = @w_monto_total,
      @i_monto_compra     = @w_monto_compra,
      @i_fecha_valor      = @s_date,
      @i_socio_comercial  = 'S',
      @i_canal            = 'BATCH' 
    
      if @w_error <> 0
      begin
          print 'Error al procesar desembolso: ' +  @w_banco + ' Error: ' + convert(varchar, @w_error)  
          
          update ca_desembolsos_pendientes set
          dp_estado = 'E',
          dp_error  = @w_error          
          where dp_secuencial = @w_secuencial 
          
          goto Siguiente
      end
      
      update ca_desembolsos_pendientes set
      dp_estado = 'P'
      where dp_secuencial = @w_secuencial 
      
    end try
    begin catch
       select
       @w_numero_error = error_number(),
       @w_mensaje = substring(error_message(),1,250)
       
       print 'Error al procesar desembolso: ' +  @w_banco + ' Error: ' + convert(varchar, @w_numero_error)  + ' - ' +  @w_mensaje
       
       update ca_desembolsos_pendientes set
       dp_estado        = 'E',
       dp_error         =  @w_numero_error,
       dp_mensaje_error =  @w_mensaje         
       where dp_secuencial = @w_secuencial 
       
       goto Siguiente
    end catch     
    
    Siguiente:  
end  




go