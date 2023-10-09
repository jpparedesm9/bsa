/************************************************************************/
/*      Archivo:                lcr_ingreg.sp                           */
/*      Stored procedure:       sp_lcr_ingresar_registro                */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Credito                                 */
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
/*      Ingresa un código de registro que será solicitado en la         */
/*      aplicación Business to Client.                                  */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    12/Nov/2018           TBA              Emision Inicial            */
/*    24/Jun/2019           AIN              Cambio en la generació del */
/*                                           código de enrolamineto     */
/* 20/Abr/2020	 PRO	   Se valida clientes antiguos no registrados   */
/* 14/Jun/2021   DCU       Validacion existencia codigo                 */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_lcr_ingresar_registro')
    drop proc sp_lcr_ingresar_registro
go

create proc sp_lcr_ingresar_registro(
@s_ssn           int          = null,
@s_sesn          int          = null,
@s_date          datetime     = null,
@s_user          login        = null,
@s_term          varchar(30)  = null,
@s_ofi           smallint     = null,
@s_srv           varchar(30)  = null,
@s_lsrv          varchar(30)  = null,
@s_rol           smallint     = null,
@s_org           varchar(15)  = null,
@s_culture       varchar(15)  = null,
@t_rty           char(1)      = null,
@t_debug         char(1)      = 'N',
@t_file          varchar(14)  = null,
@t_trn           smallint     = null,
@i_id_inst_proc  int,
@i_es_regenera   char         = 'N',
@i_existe		 char(1)	  = 'S',
@i_ente			 int          = null,
@o_registro_id   varchar(6) = null output,
@o_msg           varchar(200) = null output
)
as
declare
@w_sp_name        varchar(25),
@w_fecha_proceso  datetime,
@w_fecha_vigencia datetime,
@w_dias_vigencia  int,
@w_cliente        int,
@w_tipo_tramite   varchar(255),
@w_ente           int,
@w_grupo          int,
@w_data_xml       varchar(255),
@w_correos_desti  varchar(255),
@w_template       int,
@w_return         int,    
@w_error          int


select @w_sp_name = 'sp_lcr_ingresar_registro'

select @w_fecha_proceso = fp_fecha
from   cobis..ba_fecha_proceso

select @w_dias_vigencia = pa_smallint
from cobis..cl_parametro 
where pa_nemonico = 'B2CDVR'
and   pa_producto = 'CRE'

if @@rowcount = 0   select @w_dias_vigencia = 1

select @w_fecha_vigencia = DATEADD (day, @w_dias_vigencia , @w_fecha_proceso)  

select @w_cliente        = io_campo_1,
	   @w_tipo_tramite   = io_campo_4 -- tipo de tramite
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc


-----------------------
----template correo----
-----------------------
select @w_template = te_id
from   cobis..ns_template 
where  te_nombre    = 'NotificacionIntegranteGrupo.xslt'

--GRUPO
if(@w_tipo_tramite = 'GRUPAL' and @i_es_regenera != 'S')
begin	
	select @w_grupo = @w_cliente	
	
	select @w_ente  = min(cg_ente) 
	from   cobis..cl_cliente_grupo
	where  cg_grupo = @w_grupo --cliente grupal
	
	while 1=1
	begin             
   
      if exists (select 1 from cr_b2c_registro 
              where rb_id_inst_proc = @i_id_inst_proc
              and rb_cliente = @w_ente)
      begin
         delete from cr_b2c_registro where rb_id_inst_proc = @i_id_inst_proc and rb_cliente = @w_ente
      end 
   
		print 'procesando cliente...'+convert(varchar,@w_ente)    
		-------------------
		----notificado------
		--------------------
   
      print 'ingreso a notificar al cliente'+convert(varchar,@w_ente)
      print '--Obtener Código de registro'
      --Obtener Código de registro
      exec cob_credito..sp_lcr_gen_cod_registro 
          @o_cod_id_reg = @o_registro_id  output 
		  
	  while exists (select 1 from cob_credito..cr_b2c_registro where rb_registro_id = @o_registro_id)
	  begin
	     exec cob_credito..sp_lcr_gen_cod_registro 
            @o_cod_id_reg = @o_registro_id  output
	  end 	  
      
      print 'El codigo generado es: ' + @o_registro_id
         
      if(@i_es_regenera = 'S')
      begin
         select @w_fecha_proceso 	= rb_fecha_ingreso
         from cr_b2c_registro 
         where rb_id_inst_proc = @i_id_inst_proc 
      end
      
      print 'insertando en la tabla cr_b2c_registro'
      insert into cr_b2c_registro(
      rb_registro_id,   rb_id_inst_proc,       rb_cliente,
      rb_fecha_ingreso, rb_fecha_vigencia)
      values(
      @o_registro_id,   @i_id_inst_proc,       @w_ente,
      @w_fecha_proceso, @w_fecha_vigencia)
      
      if @@error <> 0    
      begin  
         select @o_msg = 'ERROR: INSERCIÓN DE CODIGO DE REGISTRO FALLIDA'
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1,
         @i_msg   = 'ERROR: INSERCIÓN DE CODIGO DE REGISTRO FALLIDA'
         return 1			
      end			
      print 'llamando al notificado'			
      select @w_correos_desti = di_descripcion
      from  cobis..cl_direccion 
      where di_ente  = @w_ente
      and   di_tipo  = 'CE'					
      ------------------------
      ---inicializar xml------
      select @w_data_xml= '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><codeRegister>cdReg</codeRegister></data>'
      select @w_data_xml= REPLACE(@w_data_xml, 'cdReg',convert(varchar,isnull(@o_registro_id ,'' )))			
      --select @w_correos_desti='jhon.chaparro@middlesoftware.com'
      
      exec cobis..sp_despacho_ins
      @t_trn               = 1,
      @i_cliente           = 1,
      @i_servicio          = 1, 
      @i_estado            = 'P',
      @i_tipo              = 'MAIL',
      @i_prioridad         = 1,
      @i_num_dir           = '',
      @i_from              = null,--'santander.desarrollo@cobiscorp.com',
      @i_to                = @w_correos_desti,
      @i_bcc               = null,
      @i_subject           = 'Regístrate en nuestro servicio de TUIIO Móvil.',
      @i_body              = @w_data_xml,
      @i_content_manager   = 'HTML',
      @i_retry             = 'N',
      @i_fecha_envio       = null,
      @i_hora_ini          = null,
      @i_hora_fin          = null,
      @i_tries             = 0,
      @i_max_tries         = 2,
      @i_template          = @w_template,
      @i_tipo_mensaje      ='N'	
      if @w_return <> 0
      begin
         select @o_msg   = 'ERROR: EN EL ENVIO DE CORREOS'
         exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1,
            @i_msg   = 'ERROR: EN EL ENVIO DE CORREOS'
         return 1		
      end
		
		select top 1 @w_ente = cg_ente       
		from cobis..cl_cliente_grupo
		where cg_estado = 'V' 
		and  cg_ente    > @w_ente
		and  cg_grupo   = @w_grupo
		order by cg_ente asc		
		if @@rowcount = 0
		begin
			break
		end
	end 	
	return 0
end
else
--NO GRUPAL
begin 
	--print 'NO GRUPAL...'
	--Obtener Código de registro
	exec cob_credito..sp_lcr_gen_cod_registro 
		@o_cod_id_reg = @o_registro_id  output 
		
	while exists (select 1 from cob_credito..cr_b2c_registro where rb_registro_id = @o_registro_id)
	begin
	   exec cob_credito..sp_lcr_gen_cod_registro 
		@o_cod_id_reg = @o_registro_id  output
	end 
 	
		
	print 'El codigo generado es: ' + @o_registro_id
	print 'EXISTE:' + @i_existe
	
	if(@i_es_regenera = 'S' and @i_existe ='S')
	begin
		select @w_fecha_proceso 	= rb_fecha_ingreso
		from cr_b2c_registro 
		where rb_id_inst_proc = @i_id_inst_proc 
	end
	
	if(@i_es_regenera = 'S'  and @w_tipo_tramite = 'GRUPAL')
	begin
		select @w_cliente = @i_ente		
	end
	
	if exists (select 1 from cr_b2c_registro where rb_id_inst_proc = @i_id_inst_proc and rb_cliente =@w_cliente)	
	begin
		delete from cr_b2c_registro where rb_id_inst_proc = @i_id_inst_proc and rb_cliente =@w_cliente
	end 
	
	insert into cr_b2c_registro(
	rb_registro_id,   rb_id_inst_proc,       rb_cliente,
	rb_fecha_ingreso, rb_fecha_vigencia)
	values(
	@o_registro_id,   @i_id_inst_proc,       @w_cliente,
	@w_fecha_proceso, @w_fecha_vigencia)
	
	if @@error <> 0    begin  
	select
	@w_error = 1,
	@o_msg   = 'ERROR: INSERCIÓN DE CODIGO DE REGISTRO FALLIDA'
	GOTO ERROR
	end	

	return 0
	
	ERROR:
	return @w_error
end

return 0
go
