/************************************************************************/
/*      Archivo:                lcr_validar_cc.sp                       */
/*      Stored procedure:       sp_lcr_cc_validar_registro              */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           PXSG                                    */
/*      Fecha de escritura:     Enero/2019                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Recibe un código de registro B2C y devuelve datos del cliente.  */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    27/01/2019           PXSG              Emision Inicial            */
/*                                            Un código solo es valido  */
/*                                         si el cliente no esta activo */
/*                                         en banca virtual             */
/*    13/06/2019           AINCA           Se cambia la busqueda        */
/*										   de código de enrolamiento a  */
/*										   código de cliente            */
/************************************************************************/


use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_lcr_cc_validar_registro')
    drop proc sp_lcr_cc_validar_registro
go

create proc sp_lcr_cc_validar_registro(
@s_ssn                     int          = null,
@s_sesn                    int          = null,
@s_date                    datetime     = null,
@s_user                    varchar(14)  = null,
@s_term                    varchar(30)  = null,
@s_ofi                     smallint     = null,
@s_srv                     varchar(30)  = null,
@s_lsrv                    varchar(30)  = null,
@s_rol                     smallint     = null,
@s_org                     varchar(15)  = null,
@s_culture                 varchar(15)  = null,
@t_rty                     char(1)      = null,
@t_debug                   char(1)      = 'N',
@t_file                    varchar(14)  = null,
@t_trn                     int          = null,
@i_cod_cliente             int,         
@i_procedencia             varchar(1)   ='P',
@o_msg                     varchar(200) = '' output
)                         
as                        
declare                   
@w_sp_name                 varchar(25),
@w_error                   int,
@w_id_inst_proc            int,
@w_cliente                 int,
@w_fecha_vigencia          datetime,
@w_nombres                 varchar(40),
@w_apellidos               varchar(40),
@w_telefono                varchar(15),
@w_fecha_proceso           datetime,
@w_banco                   varchar(24),
@w_tramite                 int,
@w_est_cancelado           tinyint,
@w_est_novigente           tinyint,
@w_est_vigente             tinyint,
@w_est_castigado           tinyint,
@w_est_vencido             tinyint,
@w_login_ente_registrado   tinyint,
@w_operacionca             int,
@w_oficial                 int,
@w_oficial_superior        int,
@w_asesor                  int,
@w_nombre_asesor           varchar(70),
@w_fecha_ini               datetime,
@w_fecha_fin               datetime,
@w_fecha_ult_proceso       datetime,
@w_fecha_valor             datetime,
@w_estado                  int,
@w_monto_aprobado          money,
@w_saldo_exigible          money,
@w_utilizado               money,
@w_disponible              money,
@w_intentos_fallidos       int,
@w_maximo_intentos         int

select 
@w_sp_name = 'sp_lcr_cc_validar_registro',
@w_error = 0

-- @i_procedencia la procedencia es desde que pantalla fue llamada
-- R para reseteo y P para pagos

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

--Parametro para Intentos fallidos
select @w_maximo_intentos = pa_tinyint 
from cobis..cl_parametro 
where pa_nemonico = 'B2CMIF' 
and   pa_producto = 'BVI'

--- ESTADOS DE CARTERA 
exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_novigente  = @w_est_novigente OUT,
@o_est_vencido    = @w_est_vencido   out

if @w_error <> 0 begin
    select  
    @o_msg   = 'ERROR: FALLO AL VALIDAR'
    goto ERROR
end

select
@w_fecha_vigencia = max(rb_fecha_vigencia)
from cob_credito..cr_b2c_registro
where rb_cliente = @i_cod_cliente

if @w_fecha_vigencia is null
begin
    select 
    @w_error = 2101005, 
    @o_msg   = 'EL cliente no es usuario de la TUIIO Móvil'
    goto ERROR
end

select
@w_id_inst_proc   = rb_id_inst_proc,
@w_cliente        = rb_cliente
from cob_credito..cr_b2c_registro
where rb_cliente = @i_cod_cliente
and rb_fecha_vigencia = @w_fecha_vigencia


select @w_tramite = io_campo_3
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @w_id_inst_proc

--0.- Validacion Cuando el cliente ha superado el numero de intentos Fallidos

select @w_intentos_fallidos = isnull(count (1),0)
from bv_b2c_intento_desafio
where id_cliente     = @w_cliente
and id_fecha_proceso = @w_fecha_proceso
and id_resultado     = 'N'


if @w_intentos_fallidos >= @w_maximo_intentos begin
   select
   @w_error     = 1850072, 
   @o_msg       = 'HA SUPERADO EL NUMERO DE INTENTOS DE HOY, INTENTELO MAÑANA'
   goto ERROR
end

select 
@w_nombres = en_nombre + ' ' +isnull(p_s_nombre,''),
@w_apellidos = isnull(p_p_apellido,'') + ' ' +isnull(p_s_apellido,'')
from cobis..cl_ente
where en_ente = @w_cliente

select top 1 
@w_telefono = te_valor 
from cobis..cl_telefono
where te_ente = @w_cliente
and te_tipo_telefono = 'C'
order by te_direccion, te_secuencial


if @i_procedencia = 'P'
begin
   if @w_fecha_vigencia < @w_fecha_proceso begin
   
       select 
       @w_error = 2101005, 
       @o_msg   = 'ERROR: CÓDIGO DE REGISTRO NO VIGENTE '+convert(varchar, @i_cod_cliente)
       
       goto ERROR
   end
   
   /*select
   @w_login_ente_registrado = lgn.lo_ente
   from cob_credito..cr_b2c_registro reg
   join cob_bvirtual..bv_ente ente on reg.rb_cliente = ente.en_ente_mis
   join cob_bvirtual..bv_login lgn on ente.en_ente = lgn.lo_ente
   where reg.rb_registro_id = @i_cod_cliente
   and lgn.lo_estado = 'A'
   
   if @@rowcount > 0 begin
       select 
       @w_error = 1850119, 
       @o_msg   = 'ERROR: EL CÓDIGO DE REGISTRO ' + convert(varchar, @i_cod_cliente) + ' YA TIENE UN LOGIN ACTIVO' 
       goto ERROR
   end*/
   
   select @w_banco             = op_banco,
          @w_fecha_ult_proceso = op_fecha_ult_proceso,
          @w_estado            = op_estado
   from cob_cartera..ca_operacion
   where op_tramite  = @w_tramite
   and op_toperacion = 'REVOLVENTE'
   
   
   
   if @@rowcount = 0 begin
       select 
       @w_error = 1850070, 
       @o_msg   = 'ERROR: ESTE CLIENTE NO TIENE OPERACIÓN REVOLVENTE'
       goto ERROR
   END
   
   --1.- Validacion de la operacion 
   select 
   @w_operacionca= op_operacion,
   @w_fecha_ini         = op_fecha_ini,
   @w_fecha_fin         = op_fecha_fin,
   @w_monto_aprobado    = op_monto_aprobado
   from cob_cartera..ca_operacion 
   where op_banco = @w_banco 
   and   op_toperacion  = 'REVOLVENTE'
   and   op_estado IN (1,2,3)
   
   if @@rowcount = 0 begin 
      select  
      @o_msg  = 'ERROR:EL CLIENTE NO TIENE UNA LÍNEA DE CRÉDITO APROBADA ',
      @w_error= 70001
      goto ERROR
   end 
   
   --2.-busqueda del asesor del cliente
   select @w_oficial=en_oficial 
   from   cobis..cl_ente 
   where  en_ente=@w_cliente
   
   select @w_nombre_asesor = fu_nombre
   from   cobis..cc_oficial, cobis..cl_funcionario
   where  oc_funcionario = fu_funcionario
   and    oc_oficial = @w_oficial
   
   if exists (select 1  from cob_cartera..ca_lcr_bloqueo where lb_operacion = @w_operacionca and lb_bloqueo = 'S') begin 
   
      select  
      @o_msg  = 'ERROR:LA LÍNEA DEL CLIENTE ESTÁ BLOQUEDA, FAVOR CONTACTE A '+''+@w_nombre_asesor+''+',SU ASESOR ASIGNADO',
      @w_error= 70002
      goto ERROR
   
   end
   
   
   --3.- Validación de fecha de Vigencia
   
   if(@w_fecha_proceso>@w_fecha_fin)
   begin
      select  
      @o_msg  = 'ERROR:LA LÍNEA DEL CLIENTE ESTA VENCIDA, FAVOR CONTACTE A '+''+@w_nombre_asesor+''+',SU ASESOR ASIGNADO',
      @w_error= 70004
      goto ERROR
   end 
   
   --4.- Validación del Saldo Disponible
   
   select @w_utilizado    = isnull(sum(am_cuota -am_pagado ),0) 
   from cob_cartera..ca_amortizacion 
   where am_operacion     = @w_operacionca
   and   am_concepto      = 'CAP'
     
   SELECT @w_disponible  =@w_monto_aprobado-@w_utilizado--Monto disponible de la linea
     
   if (@w_disponible <= 0) begin 
      select 
       @o_msg = 'ERROR:CLIENTE SIN SALDO DISPONIBLE EN SU LÍNEA DE CRÉDITO,FAVOR CONTACTE A '+''+@w_nombre_asesor+''+',SU ASESOR ASIGNADO',
      @w_error= 70003
      goto ERROR
   end 
   
   
   --5.- Verificación que no exista un valor exigible vencido pendiente de cobro
   select @w_saldo_exigible    = isnull(sum(am_acumulado -am_pagado ),0) 
   from   cob_cartera..ca_amortizacion,cob_cartera..ca_dividendo 
   where  am_operacion     = di_operacion 
   and    am_dividendo     = di_dividendo
   and    am_operacion     = @w_operacionca 
   AND    di_estado        = @w_est_vencido 
   
   if (@w_saldo_exigible > 0) begin 
      select  
       @o_msg = 'ERROR:EL CLIENTE NO ESTÁ AL DÍA EN SUS PAGOS DEL CRÉDITO INDIVIDUAL REVOLVENTE',
      @w_error= 70003
      goto ERROR
   end

end
else if @i_procedencia = 'R'
begin
print 'Ingreso desde la pantalla'
select @w_banco = '0'
end



select 
@w_nombres,
@w_apellidos,
@w_telefono,
@w_id_inst_proc,
@w_cliente,
@w_banco

return 0

ERROR:
exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
        @i_msg    = @o_msg
        
return @w_error

go
