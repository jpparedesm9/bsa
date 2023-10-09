/* ********************************************************************* */
/*   Archivo:              b2c_mantenimiento_persona.sp                  */
/*   Stored procedure:     sp_b2c_mantenimiento_persona                  */
/*   Base de datos:        cobis                                         */
/*   Producto:             CLIENTES                                      */
/*   Disenado por:         Sonia Rojas                                   */
/*   Fecha de escritura:   21/Febrero/2022                               */
/* ********************************************************************* */
/*            IMPORTANTE                                                 */
/* ********************************************************************* */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de la           */
/*   "NCR CORPORATION".                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/* ********************************************************************* */
/*            PROPOSITO                                                  */
/* ********************************************************************* */
/*   Este stored procedure inserta personas con datos incompletos        */
/*            MODIFICACIONES                                             */
/*   FECHA         AUTOR      RAZON                                      */
/* ********************************************************************* */
/*   21-Feb-2022   S. Rojas   Emisión inicial                            */
/* ********************************************************************* */

use cobis
go

IF OBJECT_ID ('dbo.sp_b2c_mantenimiento_persona') IS NOT NULL
    DROP PROCEDURE dbo.sp_b2c_mantenimiento_persona
GO


create proc sp_b2c_mantenimiento_persona(
   @s_ssn                        int,
   @s_user                       login,
   @s_term                       varchar (32),
   @s_date                       datetime,
   @s_srv                        varchar(30),
   @s_lsrv                       varchar(30)   = null,
   @s_ofi                        smallint      = null,
   @s_rol                        smallint      = NULL,
   @s_org_err                    char(1)       = NULL,
   @s_error                      int           = NULL,
   @s_sev                        tinyint       = NULL,
   @s_msg                        descripcion   = NULL,
   @s_org                        char(1)       = NULL,
   @t_debug                      char(1)       ='N',
   @t_file                       varchar(14)   = null,
   @t_from                       descripcion   = null,
   @t_trn                        int,
   @t_show_version               bit           = 0,     -- Mostrar la version del programa
   @i_ente                       int           = null,
   @i_nombre                     varchar(30)   = null,        -- Primer nombre del cliente
   @i_papellido                  varchar(30)   = null,        -- Primer apellido del cliente
   @i_sapellido                  varchar(30)   = null,  -- Segundo apellido del cliente
   @i_segnombre                  varchar(30)   = null,  -- Segundo nombre
   @i_filial                     tinyint       = null,  -- Codigo de la filial
   @i_oficina                    smallint      = null,  -- Codigo de la oficina
   @i_cedula                     varchar(30)   = null,  -- Numero del documento de identificacion 
   @i_oficial                    smallint      = 0,     -- Codigo del oficial asignado al cliente
   @i_fecha_nac                  datetime      = '1999-01-01',  -- Fecha de nacimiento JLI,
   @i_cliente_casual             char(1)       = 'GC', -- GC Cliente Casual
   @i_sexo                       varchar(10)   = 'D',  -- Operación I: D - Default
   @i_entidad_fed_nac            varchar(4)    = null,   
   @i_bio_tipo_identificacion    varchar(10)   = null,
   @i_bio_cic                    varchar(9)    = null,
   @i_bio_ocr                    varchar(13)   = null,
   @i_bio_numero_emision         varchar(2)    = null,
   @i_bio_clave_lector           varchar(18)   = null,
   @i_bio_huella_dactilar        char(1)       = null,
   @i_cta_banco                  varchar(45)   = null,
   @i_buc                        varchar(20)   = null,
   @i_id_expediente              varchar(24)   = null,
   @i_operacion                  char(1),
   @i_modo                       int           = 0,
   @o_curp                       varchar(40)   = null out
)as
declare
@w_sp_name             descripcion,
@w_anios_edad          smallint,    --MTA edad del cliente
@w_error               int,
@w_nacionalidad        smallint,
@w_edad_min            tinyint,
@w_edad_max            tinyint,
@w_rfc                 varchar(30),
@w_nombre_completo     varchar (254),
@w_return              int,
@w_ciudad_nac          descripcion,
@w_secuencial          int,
@w_commit              char(1) = 'S',
-- ---
@w_nombres             varchar(255),
@w_msg 				varchar(255), 
@o_mensaje 			varchar(255)

select  @w_nacionalidad = pa_smallint
from 	cl_parametro
where pa_nemonico = 'PAIS'

select @w_edad_min = pa_tinyint  --Edad minima
from cl_parametro 
where pa_nemonico = 'MDE'
and   pa_producto = 'ADM'

select @w_edad_max = pa_tinyint --Edad maxima
from   cl_parametro 
where pa_nemonico ='EMAX'
and   pa_producto = 'ADM'

select @w_sp_name = 'sp_b2c_mantenimiento_persona'

/*Actualización Prospecto - Mediante datos obtenidos Renapo*/
if @i_operacion = 'U' begin

   if @t_trn <> 1722 begin
     /* Codigo de transaccion invalido */
     select @w_error = 101147
     goto ERROR
   end
   
   if @i_modo = 0 begin
      /* INICIO DE LA ATOMICIDAD DE LA TRANSACCION */
      if @@trancount = 0 begin
        select @w_commit = 'S'
        begin tran
      end      
      
      if exists (select 1 from cl_ente where en_ced_ruc = @i_cedula and en_ente <> @i_ente) begin
         print 'Ya existe una persona con esta identificación. CURP'
        select @w_error = 70011007
         goto ERROR	   
      end
      
      if ( @i_ente = null or @i_nombre = null or @i_papellido = null or @i_fecha_nac = null or @i_sexo = null or @i_cedula = null ) begin
         select @w_error = 101113
         goto ERROR
      end
      
      if @i_cliente_casual <> 'S' begin
         select @w_anios_edad = datediff(yy, @i_fecha_nac, fp_fecha) from ba_fecha_proceso
        if ((@w_anios_edad < @w_edad_min) and (@w_anios_edad > @w_edad_max)) begin
           select @w_error = 101113
      	 goto ERROR/* 'Falta fecha de nacimiento'*/      
         end
      end
      
      select @w_ciudad_nac =  eq_valor_cat
      from cob_conta_super..sb_equivalencias 
      where eq_catalogo    = 'ENT_FED' 
      and eq_valor_arch    = (select eq_valor_cat 
                              from cob_conta_super..sb_equivalencias
                              where eq_catalogo = 'ENT_CURP' 
      					      and eq_valor_arch = @i_entidad_fed_nac)
      
	select @i_fecha_nac = isnull(@i_fecha_nac, p_fecha_nac),
		@w_ciudad_nac = isnull(@w_ciudad_nac, p_depa_nac),
		@i_sexo = isnull(@i_sexo, p_sexo),
		@i_nombre = isnull(@i_nombre, en_nombre),
		@i_segnombre = isnull(@i_segnombre, p_s_nombre),
		@i_papellido = isnull(@i_papellido, p_p_apellido),
		@i_sapellido = isnull(@i_sapellido, p_s_apellido)
	from cobis..cl_ente
	where en_ente = @i_ente
	and en_subtipo = 'P'
	
    /*Género H (Hombre): Masculino, M (Mujer): Femenino*/
    select @i_sexo = case when @i_sexo = 'H' then 'M' else 'F' end 
      
	select @w_nombre_completo = @i_nombre + ' ' + isnull(@i_segnombre,'') + ' ' + @i_papellido + ' ' + isnull(@i_sapellido, ''),
			@w_nombres        = @i_nombre + ' ' + isnull(@i_segnombre,'')
	
    -- select @w_rfc =  substring(@i_cedula, 1, 10)
	exec @w_return = cobis..sp_generar_curp
	@i_primer_apellido 	= @i_papellido,
	@i_segundo_apellido = @i_sapellido,
	@i_nombres 			= @w_nombres,
	@i_sexo 			= @i_sexo,
	@i_fecha_nacimiento = @i_fecha_nac, --'01/21/1987',
	@i_entidad_nacimiento = @w_ciudad_nac, --'30',
	@o_mensaje 			= @w_msg out,
	@o_rfc 				= @w_rfc OUT

	if @w_error <> 0 begin 
		select @w_error = @w_return
		goto ERROR 
	end 

      update cl_ente set
      en_nombre      = @i_nombre,
      p_s_nombre     = @i_segnombre,
      p_p_apellido   = @i_papellido,
      p_s_apellido   = @i_sapellido,
      p_fecha_nac    = @i_fecha_nac,
      p_sexo         = @i_sexo,
      en_ced_ruc     = @i_cedula,
      en_nit         = @w_rfc,
      en_rfc         = @w_rfc,
      p_depa_nac     = @w_ciudad_nac
      where en_ente  = @i_ente
      
      update cl_ente_aux set
      ea_ced_ruc          = @i_cedula,
      ea_nit              = @w_rfc,
	  ea_consulto_renapo  = 'S'
      where ea_ente  = @i_ente
      
      ----*-----------------------------------------------------------------------------------*--
      ----* REALIZA EL REGISTRO DEL HISTORICO DE IDENTIFICACIONES
      ----* GDE -- CONTROL DE CAMBIOS CLIENTES
      ----*-----------------------------------------------------------------------------------*--
      
      if not exists (select 1 from cl_registro_identificacion where ri_ente = @i_ente) begin
         exec @w_return    = sp_b2c_registra_ident
         @s_user           = @s_user,
         @t_trn            = 1037,
         @i_operacion      = 'I',
         @i_ente           = @i_ente,
         @i_tipo_iden      = 'CURP',
         @i_identificacion = @i_cedula
         
         if @w_return <> 0 begin
            select @w_error = @w_return
            goto ERROR 
         end
      end
      
      if @w_commit = 'S' begin
         commit tran
         select @w_commit = 'N'
      end
      
      --SRO. Inicia Biometricos
      if exists (select 1 from cl_ente_bio where eb_ente = @i_ente) begin
         update cl_ente_bio set 
        eb_tipo_identificacion = @i_bio_tipo_identificacion,
        eb_cic                 = @i_bio_cic,      
        eb_ocr                 = @i_bio_ocr,      
        eb_nro_emision         = @i_bio_numero_emision,
        eb_clave_elector       = @i_bio_clave_lector,      
        eb_sin_huella_dactilar = @i_bio_huella_dactilar
        where eb_ente          = @i_ente 
        
        if @@error <> 0 begin
            select @w_error = 103402
            goto ERROR
         end
        
        insert into cl_ente_bio_his
         (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
         ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
         ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
         ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
         ebh_srv,                             ebh_lsrv)
         values                               
         (@s_ssn,                             @i_ente,               @i_bio_tipo_identificacion,  @i_bio_cic, 	         
         @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	    isnull(@i_bio_huella_dactilar,'N'),  
         getdate(),                           null,                  null,                        null,
         getdate(),                           'I',                   @s_user,                     @s_term,
         @s_srv,                              @s_lsrv)
         	
         if @@error <> 0 begin
           select @w_error = 103402
           goto ERROR
         end
        
      end else begin
          if @i_bio_tipo_identificacion is not null and @i_bio_tipo_identificacion  in ('INE', 'IFE') begin
            if @i_bio_tipo_identificacion = 'INE' and @i_bio_cic is null begin
               select @w_error = 103400
                goto ERROR
            end
            else if @i_bio_tipo_identificacion = 'IFE' and (@i_bio_ocr is null or @i_bio_numero_emision is null or @i_bio_clave_lector is null) begin
                select @w_error = 103401
                goto ERROR
            end
            
            --Secuencial
             exec 
             @w_error     = sp_cseqnos
             @t_debug     = 'N',
             @t_file      = null,
             @t_from      = @w_sp_name,
             @i_tabla     = 'cl_ente_bio',
             @o_siguiente = @w_secuencial out
             
             if @w_error <> 0 begin
                goto ERROR
             end
            
            
            insert into cl_ente_bio
            (eb_secuencial, eb_ente, eb_tipo_identificacion,     eb_cic,      eb_ocr,      eb_nro_emision,        eb_clave_elector,      eb_sin_huella_dactilar,             eb_fecha_registro)
            values  
            (@w_secuencial, @i_ente, @i_bio_tipo_identificacion, @i_bio_cic,  @i_bio_ocr,  @i_bio_numero_emision, @i_bio_clave_lector,  isnull(@i_bio_huella_dactilar,'N'), getdate())
         
            if @@error <> 0 begin
                select @w_error = 103402
                goto ERROR
             end
            
            insert into cl_ente_bio_his
            (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
            ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
            ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
            ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
            ebh_srv,                             ebh_lsrv)
            values                               
            (@s_ssn,                             @i_ente,               @i_bio_tipo_identificacion,  @i_bio_cic, 	         
            @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	    isnull(@i_bio_huella_dactilar,'N'),  
            getdate(),                           null,                  null,                        null,
            getdate(),                           'I',                   @s_user,                     @s_term,
            @s_srv,                              @s_lsrv)
         	
            if @@error <> 0 begin
              select @w_error = 103402
              goto ERROR
            end
            
         end       
      end
   --SRO. Fin Biometricos
   end else if @i_modo = 1 begin --Actualizacion Altair
      update cl_ente_aux set
	  ea_cta_banco  = isnull(@i_cta_banco, ea_cta_banco),
	  ea_estado     = 'A'
	  where ea_ente = @i_ente
	  
      update cobis..cl_ente set
	  en_banco      = isnull(@i_buc, en_banco)
	  where en_ente = @i_ente
	  
	  if not exists (select 1 from cobis..cl_onboard_id_ext where oi_ente = @i_ente )
	  begin
	      insert into cobis..cl_onboard_id_ext 
	      ( oi_ente, oi_id_expediente,oi_fecha_registro)
	      values
	      ( @i_ente , @i_id_expediente, getdate())
	      
	      if @@error <> 0 begin
             select @w_error = 103415
             goto ERROR
          end
	   
	  end
	  else begin
	     update cobis..cl_onboard_id_ext 
	     set oi_id_expediente  = @i_id_expediente,
	         oi_fecha_registro = getdate()
	     where oi_ente = @i_ente
	  end  
   end
   
   return 0
end
 /* Buscar curp cliente por id */
if @i_operacion = 'S' begin

   if @t_trn <> 1724 begin
     /* Codigo de transaccion invalido */
     select @w_error = 101147
     goto ERROR
   end
   
   select @o_curp = en_ced_ruc
   from cl_ente
   where en_ente = @i_ente
   
   return 0
end


ERROR:

   
if @@trancount <> 0 AND @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end


exec sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file,
@t_from  = @w_sp_name,
@i_num   = @w_error

return @w_error

go