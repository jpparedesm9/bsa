/************************************************************************/
/*      Archivo:                b2c_validar.sp                          */
/*      Stored procedure:       sp_b2c_validar_registro                 */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Nov/2018                                */
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
/*    FECHA      AUTOR            RAZON                                 */
/* 12/Nov/2018    TBA      Emision Inicial                              */
/* 29/Nov/2018    PLO      Un código solo es valido si el cliente       */
/*                         no esta activo en banca virtual              */
/* 05/Feb/2019    ERA      Se comenta Validacion de login activo        */
/* 24/Jun/2019	   PRO 	   Validacion correo para regneracion de codigo */
/* 03/Mar/2020	 P. Ortiz   Validacion prestamos en general             */
/* 20/Abr/2020	 PRO	   Se valida clientes antiguos no registrados   */
/* 26/Nov/2021   DCU       Cambio 173575                                */
/* 15/DIC/2021   DCU       Cambio Corregir Error 174489                 */
/* 17/Feb/2022   S.Rojas   Requerimiento 158566                         */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_validar_registro')
    drop proc sp_b2c_validar_registro
go

create proc sp_b2c_validar_registro(
@s_ssn              int          = null,
@s_sesn             int          = null,
@s_date             datetime     = null,
@s_user             login        = null,
@s_term             varchar(30)  = null,
@s_ofi              smallint     = null,
@s_srv              varchar(30)  = null,
@s_lsrv             varchar(30)  = null,
@s_rol              smallint     = null,
@s_org              varchar(15)  = null,
@s_culture          varchar(15)  = null,
@t_rty              char(1)      = null,
@t_debug            char(1)      = 'N',
@t_file             varchar(14)  = null,
@t_trn              int          = null,
@i_cod_registro     varchar(10)  = null,
@i_esvalidacion	    char(1)      = 'N',
@i_mail             varchar(254) = null,
@i_celular          varchar(20)  = null,
@i_tipo_validacion  char(5)      = 'SMS',
@o_msg              varchar(200) = '' output
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
@w_ttramite                varchar(64),
@w_est_cancelado           tinyint,
@w_est_novigente           tinyint,
@w_est_vigente             tinyint,
@w_est_castigado           tinyint,
@w_login_ente_registrado   tinyint,
@w_ente                    int,
@w_inst_proceso            int,
@w_cod_registro            varchar(10),
@w_rpc                     descripcion,
@w_emailbco                varchar(64),
@w_login                   varchar(64),
@w_body                    varchar(255),
@w_valida_antiguos         char(1),
@w_registrado              char(1),
@w_no_registrado           char(1),
@w_operacion               int,
@w_toperacion              varchar(10),
@w_template                int,
@w_tabla_usu_google        int,
@w_usuario_google          int,
@w_plantilla               int,
@w_bloque                  varchar(4)

select 
@w_sp_name = 'sp_b2c_validar_registro',
@w_error = 0

select @w_valida_antiguos = pa_char from cobis..cl_parametro where pa_nemonico = 'VCLAN'
select @w_tabla_usu_google = codigo from cobis..cl_tabla where tabla = 'cl_usuario_google'
select @w_usuario_google = convert(int,valor) from cobis..cl_catalogo where tabla = @w_tabla_usu_google and codigo = 'usrb2c' and estado = 'V'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


--- ESTADOS DE CARTERA 
exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_novigente  = @w_est_novigente out

print '@w_est_vigente  '  + convert(varchar(10),@w_est_vigente)    
print '@w_est_cancelado'  + convert(varchar(10),@w_est_cancelado)
print '@w_est_castigado'  + convert(varchar(10),@w_est_castigado)
print '@w_est_novigente'  + convert(varchar(10),@w_est_novigente)

if @w_error <> 0 begin
    select  
    @o_msg   = 'ERROR: FALLO AL VALIDAR '
    goto ERROR
end



if(@i_esvalidacion = 'S')
begin
   if @i_tipo_validacion = 'SMS' begin
      if (@i_celular is null or rtrim(ltrim(@i_celular)) = '') begin
         select @w_error = 1890017, @o_msg   = 'ERROR: NO SE INGRESO UN NÚMERO DE CELULAR'
         goto ERROR
      end else begin
         select @w_ente = te_ente FROM cobis..cl_telefono WHERE te_valor = @i_celular AND te_tipo_telefono ='C'
          if exists (select 1 FROM cobis..cl_telefono WHERE te_valor = @i_celular AND te_tipo_telefono ='C' and te_ente <> @w_ente)
          begin
            -- TODO: crear numero de error con el mensaje
            select @w_error = 1890017, @o_msg   = 'ERROR: EL NÚMERO CELULAR YA SE ENCUENTRA REGISTRADO'
            goto ERROR 
          end         
      end
   end else if @i_tipo_validacion = 'MAIL' begin 
      if (@i_mail is null or rtrim(ltrim(@i_mail)) = '') begin
         select @w_error = 1890018, @o_msg   = 'ERROR: NO SE INGRESO UN CORREO ELECTRÓNICO'
         goto ERROR
      end else begin
         select @w_ente = di_ente FROM cobis..cl_direccion WHERE di_descripcion = @i_mail AND di_tipo ='CE'	     
      end
   end

   select @w_rpc = '.cobis..sp_despacho_ins'
   select @w_registrado = 'N', @w_no_registrado = 'N'
	
	--SE REALIZA EL PROCESO DE BUSQUEDA DEBIDO A QUE PUEDE DARSE QUE SI ESTA REGISTRADO EL CREDITO ORIGINAL ESTE CANCELADO
   if(@w_valida_antiguos = 'S') begin

      select @w_registrado = 'N'
	  
      select top 1 
      @w_tramite = op_tramite,
      @w_operacion = op_operacion,
      @w_toperacion = op_toperacion
      from cob_cartera..ca_operacion,
	  cob_credito..cr_tramite_grupal
      where tg_operacion   = op_operacion
      and   tg_prestamo    <> tg_referencia_grupal
      and   tg_cliente     = @w_ente
   	  and   op_estado not in (@w_est_novigente,@w_est_cancelado)
   	  order by op_operacion desc
		
      if( @w_tramite is not null)
   	  begin
   	     select @w_no_registrado ='S' 
   	  end
      else begin
            SELECT top 1 
            @w_tramite = op_tramite,
            @w_operacion = op_operacion,
            @w_toperacion = op_toperacion
            FROM cob_cartera..ca_operacion 
            WHERE op_cliente = @w_ente
            AND op_toperacion not in ('GRUPAL') 
            AND op_estado NOT IN (@w_est_novigente,@w_est_cancelado)
            
            if( @w_tramite is not null)
            begin
               select @w_no_registrado ='S' 
            end else begin
               SELECT top 1 
               @w_tramite        = op_tramite,
               @w_operacion      = op_operacion,
               @w_toperacion     = op_toperacion
               from  cob_cartera..ca_operacion 
               where op_cliente  = @w_ente
               and op_toperacion = 'REVOLVENTE'
               and @w_fecha_proceso between op_fecha_ini and op_fecha_fin
               order by op_tramite desc
            
               if( @w_tramite is not null) begin
                  select @w_no_registrado ='S' 
               end else begin 
                  select  
                  @w_error = 1890020, 
                  @o_msg   = 'El cliente no tiene operaciones activas'
                  goto ERROR
               end
         end
      end
   end   
  
   if @w_registrado='S' or @w_no_registrado ='S'
   begin
   
      if @i_mail is not null or rtrim(ltrim(@i_mail)) = '' begin
         select @w_ente     = di_ente from cobis..cl_direccion 
         where di_ente      in (select en_ente_mis from cob_bvirtual..bv_ente where en_autorizado = 'S')
         and di_descripcion = @i_mail
         and di_tipo        = 'CE'
      end else if @i_celular is not null or rtrim(ltrim(@i_celular)) = '' begin
         select @w_ente = te_ente from cobis..cl_telefono
         where te_ente          in (select en_ente_mis from cob_bvirtual..bv_ente where en_autorizado = 'S')
         and   te_valor         = @i_celular
         and   te_tipo_telefono = 'C'
      end
   
      if(@w_registrado='S')
      begin		 
         select @w_inst_proceso = rb_id_inst_proc
         from cob_credito..cr_b2c_registro
         where rb_cliente       = @w_ente
       
         select @w_toperacion = io_campo_4 FROM cob_workflow..wf_inst_proceso WHERE io_id_inst_proc = @w_inst_proceso
      end else begin
   	
         if(@w_toperacion = 'GRUPAL')
         begin      
            select @w_inst_proceso = io_id_inst_proc
            from cob_workflow..wf_inst_proceso
            where io_campo_3 = (SELECT tg_tramite FROM cob_credito..cr_tramite_grupal WHERE tg_operacion = @w_operacion)
         end
         else
         begin      
            select @w_inst_proceso = io_id_inst_proc
            from cob_workflow..wf_inst_proceso
            where io_campo_3 = @w_tramite
         end
      end
	  
      --REGENERA EL CODIGO DE REGISTRO
      exec @w_error = cob_credito..sp_lcr_ingresar_registro
      @i_es_regenera  = 'S',
      @i_id_inst_proc = @w_inst_proceso,
      @i_existe       = @w_registrado,
      @i_ente         = @w_ente,
      @o_registro_id  = @w_cod_registro	out
   	
   	  if(@w_error <> 0)
   	  begin
         goto ERROR
   	  end
   	  
   	  select @w_emailbco = pa_char
   	  from cobis..cl_parametro
   	  where pa_nemonico = 'IBFROM'
   	  and pa_producto = 'BVI'
   	  
   	  select @w_login = lo_login
   	  from cob_bvirtual..bv_login
   	  where lo_ente = (select en_ente
      from cob_bvirtual..bv_ente
      where en_ente_mis= @w_ente)       
       
      if @w_toperacion = 'GRUPAL'
   	  begin
   	     select @w_template= te_id 
   	     from cobis..ns_template 
   	     where te_nombre = 'NotificacionIntegranteGrupo.xslt'
   	     select @w_body	='<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><codeRegister>'+@w_cod_registro+'</codeRegister></data>'
   	  end
   	  else
   	  begin
   	     select @w_template = te_id 
   	     from cobis..ns_template
   	     where te_nombre = 'CreacionLCR.xslt'
   	     select @w_body	='<?xml version="1.0" encoding="ISO-8859-1"?><data><codigo>'+@w_cod_registro+'</codigo></data>'
   	  end
	
      if @i_tipo_validacion = 'MAIL' begin   	   
   	
         --ENVIA NOTICACION CON NUEVO CODIGO DE REGISTRO
         exec @w_error         = cobis..sp_despacho_ins
         @i_cliente            = @w_ente,
         @i_servicio           = 8,
         @i_estado             = 'P',
         @i_tipo               = 'MAIL',
         @i_tipo_mensaje       = 'I',
         @i_prioridad          = 1,
         @i_num_dir            = '', 
         @i_from               = @w_emailbco,
         @i_to                 = @i_mail,--@i_correo_dest,
         @i_cc                 = '',
         @i_bcc                = '',
         @i_subject            = 'Código de Registro',
         @i_body               = @w_body,
         @i_content_manager    = 'HTML',
         @i_retry              = 'S',
         @i_tries              = 1,
         @i_max_tries          = 2,
         @i_template		    = @w_template
         
         if(@w_error <> 0)
         begin
            goto ERROR
         end
      end else begin

         select @w_plantilla = pa_int
         from cobis..cl_parametro
         where pa_nemonico = 'ENRTPL'
         and   pa_producto = 'BVI'
       
         select @w_bloque = codigo 
         from cobis..cl_catalogo 
         where valor = 'ENROLAMIENTO'
         and   tabla = (select codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms')
         
         delete bv_b2c_registro_tmp where rt_ente = @w_ente 
         insert into bv_b2c_registro_tmp (rt_registro, rt_ente) 
         select top 1 rb_registro_id, @w_ente 
         from cob_credito..cr_b2c_registro 
         where rb_cliente = @w_ente
         order by rb_fecha_vigencia desc
       
         -- Ejecucion del sp para las notificaciones y envio de sms
         exec @w_error         = cobis..sp_despacho_ins
         @i_cliente            = @w_ente,
         @i_servicio           = 8,--@i_canal,
         @i_estado             = 'P',
         @i_tipo               = 'SMS',
         @i_tipo_mensaje       = 'I',
         @i_prioridad          = 1,
         @i_from               = @i_celular,
         @i_to                 = null,
         @i_cc                 = '',
         @i_bcc                = '',
         @i_subject            = 'Notificación SMS OTP',
         @i_body               = '',
         @i_content_manager    = 'TEXT',
         @i_retry              = 'N',
         @i_tries              = 0,
         @i_max_tries          = 0,
         @i_template			 = '',
         @i_var1               = @w_bloque, -- bloque
         @i_var2               = @w_plantilla, -- plantilla
         @i_var3               = @w_ente, 
         @i_var4               = 'S' -- Si valida el buc o no   
         
         if(@w_error <> 0)
         begin
            goto ERROR
         end
      
      end      
     
      delete from cob_bvirtual..bv_in_login 
      where il_login = @w_login 
         
      return 0
   end else begin
      if @i_tipo_validacion = 'MAIL' begin
         select  
         @w_error = 2101005, 
         @o_msg   = 'La cuenta de correo ingresada no está registrada para un cliente de este servicio'
         goto ERROR
      end else begin 
         select  
         @w_error = 2101005, 
         @o_msg   = 'El número de celular ingresado no está registrado para un cliente de este servicio'
         goto ERROR
      end
   end
end


select
@w_id_inst_proc   = rb_id_inst_proc,
@w_cliente        = rb_cliente,
@w_fecha_vigencia = rb_fecha_vigencia
from cob_credito..cr_b2c_registro
where rb_registro_id = @i_cod_registro

if @@rowcount = 0 begin
    select 
    @w_error = 2101005, 
    @o_msg   = 'ERROR: NO EXISTE CODIGO DE REGISTRO '+convert(varchar, @i_cod_registro)
    goto ERROR
end

select 
@w_tramite    = io_campo_3,
@w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @w_id_inst_proc


if @w_fecha_vigencia < @w_fecha_proceso begin

    select 
    @w_error = 2101005, 
    @o_msg   = 'ERROR: CODIGO DE REGISTRO NO VIGENTE '+convert(varchar, @i_cod_registro)
    
    goto ERROR
end

/* Se comenta por solicitud del cliente
select
@w_login_ente_registrado = lgn.lo_ente
from cob_credito..cr_b2c_registro reg
join cob_bvirtual..bv_ente ente on reg.rb_cliente = ente.en_ente_mis
join cob_bvirtual..bv_login lgn on ente.en_ente = lgn.lo_ente
where reg.rb_registro_id = @i_cod_registro
and lgn.lo_estado = 'A'

if @@rowcount > 0 begin
    select 
    @w_error = 1850119, 
    @o_msg   = 'ERROR: EL CODIGO DE REGISTRO ' + convert(varchar, @i_cod_registro) + ' YA TIENE UN LOGIN ACTIVO' 
    goto ERROR
end
*/

print 'antes del nombre'

select 
@w_nombres = en_nombre ,
@w_apellidos = isnull(p_p_apellido,'') 
from cobis..cl_ente
where en_ente = @w_cliente

select top 1 
@w_telefono = te_valor 
from cobis..cl_telefono
where te_ente = @w_cliente
and te_tipo_telefono = 'C'
order by te_direccion, te_secuencial

if @w_ttramite = 'GRUPAL'
begin
   select @w_banco = tg_prestamo 
   from cob_credito..cr_tramite_grupal 
   where tg_cliente = @w_cliente 
   and tg_tramite = @w_tramite
   
   select @w_banco = op_banco
   from cob_cartera..ca_operacion
   where op_banco    = @w_banco
   and   op_estado   NOT IN (@w_est_novigente,@w_est_cancelado)
   and op_toperacion = @w_ttramite
   
   if @@rowcount = 0 begin
       select 
       @w_error = 1890020, 
       @o_msg   = 'El cliente no tiene operaciones activas'
       goto ERROR
   end
   
   /* Luego de validar vigencia se extrae el banco grupal */
   select @w_banco = op_banco
   from cob_cartera..ca_operacion
   where op_tramite  = @w_tramite
   and op_toperacion = @w_ttramite
   
end else if @w_ttramite = 'REVOLVENTE' begin
   
   if @w_cliente <> isnull(@w_usuario_google,0)
   begin
      select @w_banco = op_banco
      from cob_cartera..ca_operacion
      where op_tramite  = @w_tramite
      and op_toperacion = @w_ttramite
      and @w_fecha_proceso between op_fecha_ini and op_fecha_fin
      
      if @@rowcount = 0 begin
          select 
          @w_error = 1890020, 
          @o_msg   = 'El cliente no tiene operaciones activas'
          goto ERROR
      end
   end 
end else begin

   select @w_banco = op_banco
   from cob_cartera..ca_operacion
   where op_tramite    = @w_tramite
   and   op_toperacion = @w_ttramite
   and   op_estado   NOT IN (@w_est_novigente,@w_est_cancelado)
   
   if @@rowcount = 0 begin
      select 
      @w_error = 1890020, 
      @o_msg   = 'El cliente no tiene operaciones activas'
      goto ERROR
   end

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
