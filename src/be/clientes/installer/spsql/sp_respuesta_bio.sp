/****************************************************************/
/*   ARCHIVO:         	sp_respuesta_bio.sp		                */
/*   NOMBRE LOGICO:   	sp_respuesta_bio       		            */
/*   PRODUCTO:          CLIENTES                                */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*   Guarda, consulta y actualiza la respuesta de Biocheck		*/
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   05-02-2020    F. Sanmiguel    Emision Inicial.             */
/*   20-05-2020    S. Rojas        #139772                      */
/*   08-10-2020    ACHP            #145927                      */
/*   12-11-2020    S. Rojas        #140485                      */
/*   20-01-2021    PRO             Se corrige bug encontrado    */ 
/*                                 en pruebas del caso 147999   */
/*   06-05-2022    ACHP            #175319-cond no aprob. monto */
/*   06-01-2023    DCU             #175319-cond no aprob. monto */
/*   12/12/2022    ACH             REQ194473-OT Vigencia Persona*/
/*                                 sin Huellas                  */
/****************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_respuesta_bio')
   drop proc sp_respuesta_bio
go

create procedure sp_respuesta_bio(
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int			= null,
	@s_term             varchar(30) = null,
	@s_date             datetime	= null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint	= null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_trn				int         = null,
	@i_ente             int         = null,
	@i_operacion        char(1)     = null,
	@i_ano_registro		varchar(10) = null,
	@i_clave_elector 	varchar(10) = null,
	@i_apellido_paterno varchar(10) = null,
	@i_ano_emision  	varchar(10)	= null,
	@i_no_emi_creden 	varchar(10) = null,
	@i_nombre 			varchar(10) = null,
	@i_apellido_materno varchar(10) = null,
	@i_indice_izquierdo int         = null,
	@i_indice_derecho  	int			= null,
	@i_hash   			varchar(255)= null,
	@i_tipo_sit_regis 	varchar(10) = null,
	@i_tipo_reporte_rob varchar(10) = null,
	@i_tipo				char(1)     = 'Q',--Q Query Normal, H Query Huella
	@i_tipo_ente		char(1)		= null, --C Cliente, G Grupo
	@i_amount			varchar(50)	= null,
	@i_flag				char(1)		= null,
	@i_sequential		varchar(50) = null,
	@i_inst_proc		int			= null,
	@i_valida_huella	char(1)		= null,
	@i_login			varchar(14)	= null, --
	@o_respuesta		varchar(50)	= null out,
	@o_clave_usuario	int			= null out,
	@o_ssn				int 		= null out,
	@o_oficina          smallint	= null out
	
)
as
declare	
@w_sp_name 		varchar(64),
@w_error		int,
@w_secuencia	int,
@w_valores 		varchar(100),
@w_variables 	varchar(100), 
@w_resultado 	varchar(255),
@w_parent 		varchar(255),
@w_integrantes  smallint,
@w_limitados	smallint,
@w_tramite		int,
@w_subproducto	varchar(5),
@w_ente_r		int,
@w_cadena_fin	varchar(500),
@w_asig_act		int,
@w_usuario		varchar(64),
@w_numero       int,
@w_proceso		varchar(5),
@w_pendientes	smallint,
@w_total		smallint,
@w_total_v		smallint,
@w_id_inst_act	int,
@w_ente         int,
@w_toperacion   varchar(20),
@w_tab_id_rol   int,
@w_s_sin_huella int, 
@w_s_sin_huella_doc int
		
--Caso#175319 se deja para evaluar regla Validaci?n Identidad Grupal-VALIDENGR
create table #integrantes_tramite (
   cliente         int,
   nombre_completo varchar(256),
   rol             varchar(256), 
   monto           money
)

--Caso#175319 tabla para guardar solo clientes a ser evaluados 
create table #integrantes_bio (
   cliente         int,
   nombre_completo varchar(256),
   rol             varchar(256), 
   monto           money
)		
		
select @w_sp_name 	= 'sp_respuesta_bio'

if exists (select 1 from cobis..cl_respuesta_bio where rb_ente = @i_ente and rb_inst_proc = @i_inst_proc) and @i_operacion = 'I'
begin
	select @i_operacion = 'U'
end


select 
@w_tramite 	          = io_campo_3,
@w_toperacion         = io_campo_4,
@w_ente               = io_campo_1
from cob_workflow..wf_inst_proceso 
where io_id_inst_proc = @i_inst_proc



if @w_toperacion = 'GRUPAL' begin
   select @w_tab_id_rol = codigo from cobis..cl_tabla where tabla  = 'cl_rol_grupo'
	   
   insert into #integrantes_tramite
   select cliente         = tg_cliente,
          nombre_completo = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''),
          rol             = (select valor from cobis..cl_catalogo where tabla =  @w_tab_id_rol and codigo = cg_rol),
          monto           = tg_monto
   from  cob_credito..cr_tramite_grupal tg, cobis..cl_cliente_grupo cg, cobis..cl_ente,  cob_credito..cr_tramite, cobis..cl_grupo
   where tg_tramite = @w_tramite
   and   tg_cliente = cg_ente 
   and   tg_cliente = en_ente
   and   tg_tramite = tr_tramite
   and   gr_grupo   = tg_grupo
   and   cg_estado  = 'V'
   and   tg_monto > 0
   and   tg_participa_ciclo = 'S'
   
   --por caso#175319 
   insert into #integrantes_bio
   select cliente,         nombre_completo, 
          rol,             monto
   from #integrantes_tramite
   where cliente not in (select rb_ente from cobis..cl_respuesta_bio 
                         where rb_aprobado_por_monto = ('S')
                         and rb_inst_proc = @i_inst_proc)
   
end else  begin

   insert into #integrantes_tramite values ( @w_ente, '', '', 0)
   insert into #integrantes_bio values ( @w_ente, '', '', 0)--por caso#175319 
   
end


if @i_operacion = 'I' begin
   exec cobis..sp_cseqnos
   @t_debug    = @t_debug,
   @t_file     = @t_file,
   @t_from     = @w_sp_name,
   @i_tabla    = 'cl_respuesta_bio',
   @o_siguiente  = @w_secuencia out
		   
   select @i_sequential = convert(varchar(50),@s_ssn)


   INSERT INTO cl_respuesta_bio 
   (rb_secuencia, 
   rb_ente, 
   rb_fecha_registro, 
   rb_tipo_situacion_registral, 
   rb_tipo_reporte_robo_extravio, 
   rb_ano_registro, 
   rb_clave_elector, 
   rb_apellido_paterno, 
   rb_ano_emision, 
   rb_numero_emision_credencial, 
   rb_nombre, 
   rb_apellido_materno, 
   rb_indice_izquierdo, 
   rb_indice_derecho, 
   rb_hash,
   rb_sequential,
   rb_inst_proc,
   rb_valida_huella) 
   VALUES      
   (@w_secuencia, 
   @i_ente, 
   Getdate(), 
   @i_tipo_sit_regis, 
   @i_tipo_reporte_rob, 
   @i_ano_registro, 
   @i_clave_elector, 
   @i_apellido_paterno, 
   @i_ano_emision, 
   @i_no_emi_creden, 
   @i_nombre, 
   @i_apellido_materno, 
   @i_indice_izquierdo, 
   @i_indice_derecho, 
   @i_hash,
   @i_sequential,
   @i_inst_proc,
   @i_valida_huella) 
		 
   if @@error <> 0 begin 
      select @w_error = 103118
	  goto ERROR
   end

end

if @i_operacion = 'U'
begin
   select @i_sequential = convert(varchar(50),@s_ssn)
   
   UPDATE  cobis..cl_respuesta_bio SET
   rb_tipo_situacion_registral 	= @i_tipo_sit_regis, 
   rb_tipo_reporte_robo_extravio 	= @i_tipo_reporte_rob, 
   rb_ano_registro 				    = @i_ano_registro, 
   rb_clave_elector 				= @i_clave_elector, 
   rb_apellido_paterno 			    = @i_apellido_paterno, 
   rb_ano_emision 					= @i_ano_emision, 
   rb_numero_emision_credencial 	= @i_no_emi_creden, 
   rb_nombre 						= @i_nombre, 
   rb_apellido_materno 			    = @i_apellido_materno, 
   rb_indice_izquierdo 			    = @i_indice_izquierdo, 
   rb_indice_derecho 				= @i_indice_derecho, 
   rb_hash 						    = @i_hash,
   rb_sequential					= @i_sequential,
   rb_fecha_registro                = getDate(),
   rb_valida_huella				    = @i_valida_huella
   where rb_ente = @i_ente
   and rb_inst_proc = @i_inst_proc
			

end

if @i_operacion in ('I','U')
begin

   if(@i_flag = 'S')
   begin
      select @i_flag = 'N'
   end
   else
   begin
      select @i_flag = 'S'
   end
   
   select @w_toperacion = io_campo_4
   from cob_workflow..wf_inst_proceso
   where io_id_inst_proc = @i_inst_proc
   
   select  @w_valores = @w_toperacion + '|' + @i_flag + '|' + @i_amount + '|' + convert(varchar(10),isnull(@i_indice_izquierdo,0)) + '|' + convert(varchar(10),isnull(@i_indice_derecho,0))
		
   exec @w_error           = cob_cartera..sp_ejecutar_regla
   @s_ssn                  = @s_ssn,
   @s_ofi                  = @s_ofi,
   @s_user                 = @s_user,
   @s_date                 = @s_date,
   @s_srv                  = @s_srv,
   @s_term                 = @s_term,
   @s_rol                  = @s_rol,
   @s_lsrv                 = @s_lsrv,
   @s_sesn                 = @s_sesn,
   @i_regla                = 'VALINE', 
   @i_tipo_ejecucion       = 'REGLA',     
   @i_valor_variable_regla = @w_valores,--'GRUPAL|N|16000|99|12|',
   @o_resultado1           = @w_resultado out 
   
   if @w_error <> 0 begin goto ERROR end
   
   update cobis..cl_respuesta_bio set 
   rb_resultado        = @w_resultado 
   where rb_ente       = @i_ente 
   and rb_inst_proc    = @i_inst_proc
   select @o_respuesta = @w_resultado
		 
    if (@w_resultado = 'RECHAZADO') begin

		select @w_s_sin_huella = 0, @w_s_sin_huella_doc = 0

		select @w_s_sin_huella = count (1)
		from cl_ente_bio
		where eb_ente = @i_ente
		and eb_sin_huella_dactilar = 'S'
		
		select @w_s_sin_huella_doc = count (1)
		from cl_ente_bio, cob_credito..cr_documento_digitalizado 
		where eb_ente = @i_ente
		and eb_sin_huella_dactilar = 'S'
		and eb_ente = dd_cliente and dd_tipo_doc = '009' and dd_cargado = 'S'
		and dd_inst_proceso = 0 and dd_grupo = 0
		
		if ((@w_s_sin_huella > 0) and (@w_s_sin_huella = @w_s_sin_huella_doc)) begin
		    print '------>>>Proceso: ' + convert(varchar(256), @i_inst_proc) + '--->>Ingreso a revisar rechazados'			
		    update cobis..cl_respuesta_bio set 
            rb_aprobado_por_doc = 'S'
		    from cl_ente_bio, cob_credito..cr_documento_digitalizado 
		    where rb_inst_proc = @i_inst_proc
		    and rb_ente = @i_ente
		    and rb_ente = eb_ente
		    and eb_ente = dd_cliente 
		    and eb_sin_huella_dactilar = 'S'
		    and dd_tipo_doc = '009' and dd_cargado = 'S'
		    and dd_inst_proceso = 0 and dd_grupo = 0
		end else begin
		    update cobis..cl_respuesta_bio set 
            rb_aprobado_por_doc = 'N'
		    where rb_ente = @i_ente
		    and rb_inst_proc = @i_inst_proc	
		end
   end
		 
end

if @i_operacion = 'Q'
begin
   if(@i_tipo = 'Q') begin
      select 'secuencia' 					= rb_secuencia, 
      	   'ente'	   					= rb_ente, 
      	   'fechaRegistro' 				= rb_fecha_registro,
      	   'tipoSituacionRegistral'		= rb_tipo_situacion_registral,
      	   'tipoReporteRoboExtravio'	= rb_tipo_reporte_robo_extravio, 
      	   'anoRegistro'				= rb_ano_registro, 
      	   'claveElector'				= rb_clave_elector, 
      	   'apellidoPaterno'			= rb_apellido_paterno, 
      	   'anoRemision'				= rb_ano_emision, 
      	   'numeroEmisionCredencial'	= rb_numero_emision_credencial, 
      	   'nombre'						= rb_nombre, 
      	   'apellidoMaterno'			= rb_apellido_materno, 
      	   'indiceIzquierdo'			= rb_indice_izquierdo, 
      	   'indiceDerecho'				= rb_indice_derecho, 
      	   'hash'						= rb_hash,
      	   'validaHuella'				= rb_valida_huella
      from cl_respuesta_bio
      where rb_ente = @i_ente
	  
      return 0
	  
   end
	
   if(@i_tipo = 'H')
   begin
	
      create table #ente_bio(
      		ente				int,
      		huellaDactilar		char(1) null,
      		ocr					varchar(13) null,
      		cic					varchar(10) null,
      		nombre				varchar(64) null,
      		apellidoPaterno		varchar(64)	null,
      		apellidoMaterno		varchar(64) null,
      		anioRegistro		varchar(5)	null,
      		anioEmision			varchar(5)	null,
      		numeroCredencial	varchar(5)	null,
      		claveElector		varchar(20)	null,
      		curp				varchar(30)	null,
      		city				varchar(20) null,
      		birthday			varchar(10) null,
      		buc					varchar(20)	null,
			rol                 varchar(256) null,
			monto               money        null,
			nombre_completo     varchar(256) null
      )
      
	     
   
      if(@i_tipo_ente = 'G') begin
         insert into #ente_bio
         select 
		 'ente' 				= en_ente,
         'huellaDactilar'		= null,
         'ocr'				    = null,
         'cic'				    = null,
         'nombre'			    = en_nombre + ' ' + p_s_nombre,			
         'apellidoPaterno'	    = p_p_apellido,
         'apellidoMaterno'	    = p_s_apellido,
         'anioRegistro'		    = null,
         'anioEmision'		    = null,
         'numeroCredencial'	    = null,
         'claveElector'		    = null,
         'curp'				    = en_ced_ruc,
         'city'				    = p_depa_nac,
         'birthday'			    = convert(varchar(10),p_fecha_nac,103),
         'buc'				    = en_banco,
         'rol'                  = rol,
         'monto'                = monto,
         'nombre_completo'      = nombre_completo
         from cl_ente, #integrantes_bio --por caso#175319 
		 where en_ente = cliente
							  
      end else if (@i_tipo_ente = 'R') begin
		
         insert into #ente_bio
         select 
		 'ente' 				= en_ente,
         'huellaDactilar'		= null,
         'ocr'				    = null,
         'cic'				    = null,
         'nombre'			    = en_nombre + ' ' + p_s_nombre,			
         'apellidoPaterno'	    = p_p_apellido,
         'apellidoMaterno'	    = p_s_apellido,
         'anioRegistro'		    = null,
         'anioEmision'		    = null,
         'numeroCredencial'	    = null,
         'claveElector'		    = null,
         'curp'				    = en_ced_ruc,
         'city'				    = p_depa_nac,
         'birthday'			    = convert(varchar(10),p_fecha_nac,103),
         'buc'				    = en_banco,
         'rol'                  = '',
         'monto'                = 0,
         'nombre_completo'      = ''		 
         from cl_ente 
         where en_ente = @i_ente
		
      end
								
      update #ente_bio set 
      huellaDactilar 	= eb_sin_huella_dactilar,
      ocr				= eb_ocr,
      cic				= eb_cic,
      anioRegistro	    = eb_anio_registro,
      anioEmision		= eb_anio_emision,
      numeroCredencial= eb_nro_emision,
      claveElector	= eb_clave_elector
      from cl_ente_bio
      where eb_ente = ente
		
	  --Se a?ade por que dio problema al cargar la pantalla bajo el escenario de que exista dos registros para el mismo numero de proceso y ente
      select 
	  t_proceso       = rb_inst_proc, 
	  t_ente          = rb_ente, 
	  t_resultado     = rb_resultado, 
	  t_valida_huella = rb_valida_huella
      into #respuesta_bio_aux
      from cl_respuesta_bio R, #integrantes_tramite --por caso 175319
      where rb_inst_proc    = @i_inst_proc
	  and cliente = rb_ente
      and rb_fecha_registro = (select max(rb_fecha_registro) 
                               from cl_respuesta_bio, #integrantes_tramite   --por caso 175319
							   where rb_ente    = R.rb_ente 
							   and cliente = rb_ente
							   and rb_inst_proc = R.rb_inst_proc)
      group   by	rb_inst_proc,    rb_ente , rb_resultado, rb_valida_huella

       --Caso: #147867 - Cambio para traer la lista de integrantes con ultimo registro
      select 
	  ente,			
      huellaDactilar,
      ocr,
      cic,				
      nombre,
      apellidoPaterno,
      apellidoMaterno,	
      anioRegistro,	
      anioEmision,	
      numeroCredencial,
      claveElector,	
      curp,
      respuesta = isnull((select t_resultado from #respuesta_bio_aux where t_ente = ente), 'PENDIENTE'),
	  validaHuella = case when huellaDactilar ='S' then 'S' else (select t_valida_huella from #respuesta_bio_aux where t_ente = ente) end,					  
      city,
      birthday,
      buc,
      channel = (select pa_char from cl_parametro where pa_nemonico='RENCHN'),
	  rol,
      monto,
      nombre_completo
      from #ente_bio
	  
   end else begin
      select 	
      eb_ente,
      eb_sin_huella_dactilar
      from cl_ente_bio
      where eb_ente = @i_ente
   end		
		
end	


if(@i_operacion = 'X')
begin

   select 	
   @o_clave_usuario 	= fu_nomina,
   @o_ssn 				= @s_ssn
   from cl_funcionario where fu_login = @s_user
	
end



--Validacion al guardar la validacion biometrica
if(@i_operacion = 'V')
begin

	--Por caso#175319 
	select procesado = 'N', aprob_doc = 'X',  T.* 
	into #integ_insert
	from #integrantes_bio T
	
	declare @w_ente_tmp int
	select @w_ente_tmp = 0
	
    -- Validacion documentacion
	while exists (select 1 from #integ_insert where cliente > @w_ente_tmp and procesado = 'N') begin

		select top 1 @w_ente_tmp = cliente
        from #integ_insert
        where cliente > @w_ente_tmp
		and procesado = 'N'
		order by cliente	 

		select @w_s_sin_huella = 0, @w_s_sin_huella_doc = 0

		select @w_s_sin_huella = count (1)
		from cl_ente_bio
		where eb_ente = @w_ente_tmp
		and eb_sin_huella_dactilar = 'S'
		
		select @w_s_sin_huella_doc = count (1)
		from cl_ente_bio, cob_credito..cr_documento_digitalizado 
		where eb_ente = @w_ente_tmp
		and eb_sin_huella_dactilar = 'S'
		and eb_ente = dd_cliente and dd_tipo_doc = '009' and dd_cargado = 'S'
		and dd_inst_proceso = 0 and dd_grupo = 0

        -- caso#194473
        if (@w_s_sin_huella <> @w_s_sin_huella_doc) begin
        	select @o_respuesta = 'NO' + ';D'
        	return 0;
        end
	
		if not exists (select 1 from cobis..cl_respuesta_bio where rb_inst_proc = @i_inst_proc 
		               and rb_ente = @w_ente_tmp) begin				  
			if ((@w_s_sin_huella > 0) and (@w_s_sin_huella = @w_s_sin_huella_doc)) begin
			    update #integ_insert set aprob_doc = 'S' where cliente = @w_ente_tmp
			    exec cobis..sp_cseqnos
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_tabla    = 'cl_respuesta_bio',
                @o_siguiente  = @w_secuencia out
                
                if(@i_flag = 'N')
                begin
                   select @i_sequential = convert(varchar(50),@s_ssn)
                end
                
                insert into cl_respuesta_bio (rb_secuencia,   rb_ente,               rb_fecha_registro,    rb_inst_proc, 
                                              rb_resultado,   rb_aprobado_por_doc)                                      
                           VALUES            (@w_secuencia,   @w_ente_tmp,            Getdate(),           @i_inst_proc,    
                                              'APROBADO',           'S')
                if @@error <> 0 begin 
                   select @w_error = 103118
	               goto ERROR
                end
			end else if (@w_s_sin_huella > 0 and @w_s_sin_huella_doc = 0) begin	
				update #integ_insert set aprob_doc = 'N' where cliente = @w_ente_tmp
			end
        end 
		else begin
			if exists(select 1 from cobis..cl_respuesta_bio where rb_inst_proc = @i_inst_proc and rb_ente = @w_ente_tmp and rb_resultado = 'RECHAZADO') begin			
			    if ((@w_s_sin_huella > 0) and (@w_s_sin_huella = @w_s_sin_huella_doc)) begin

			    	update #integ_insert set aprob_doc = 'S' where cliente = @w_ente_tmp
			        update cobis..cl_respuesta_bio set rb_aprobado_por_doc = 'S', rb_fecha_registro = Getdate()
			    	where rb_inst_proc = @i_inst_proc and rb_ente = @w_ente_tmp		
					
			    end else if (@w_s_sin_huella > 0 and @w_s_sin_huella_doc = 0) begin	
				
			    	update #integ_insert set aprob_doc = 'N' where cliente = @w_ente_tmp
					update cobis..cl_respuesta_bio set rb_aprobado_por_doc = 'N', rb_fecha_registro = Getdate()
			    	where rb_inst_proc = @i_inst_proc and rb_ente = @w_ente_tmp					
			    end
            end				
		end
		update #integ_insert set procesado = 'S' where cliente = @w_ente_tmp				 
	end
	
	if exists (select 1 from #integ_insert where aprob_doc = 'N') begin
		select @o_respuesta = 'NO' + ';D'
		return 0;	
	end

	/*select @w_integrantes = count(*)
	from cl_cliente_grupo 
				where cg_grupo= @i_ente and cg_estado = 'V'*/
				
   select R.* 
   into #cl_respuesta_bio_aux
   from cl_respuesta_bio R, #integrantes_tramite
   where rb_ente  = cliente
   and rb_inst_proc = @i_inst_proc
   and rb_fecha_registro = (select max(rb_fecha_registro) 
                            from cl_respuesta_bio 
							where rb_ente    = R.rb_ente 
							and rb_inst_proc = R.rb_inst_proc)
	
   --Caso ##145927
   if @w_toperacion = 'GRUPAL' begin
	      
      select @w_integrantes = count(1) from  #integrantes_tramite

      -- Caso: #147867 - Listado de clientes con respuesta

      select @w_limitados = count(1) from #cl_respuesta_bio_aux 
      where rb_resultado = 'LIMITADO'
	   
      select @w_subproducto = case op_promocion 
                                 when 'S' then 'SI'
                                 when 'N' then 'NO'
                                 else 'NG'
      						   end
      from cob_cartera..ca_operacion 
      where op_tramite= @w_tramite
      
      select  @w_valores = @w_subproducto+ '|' + convert(varchar(10),@w_integrantes) + '|' + convert(varchar(10),@w_limitados)
	  print '------>>>Proceso: ' + convert(varchar(256), @i_inst_proc) + '--->>VALORES LIMITADOS: '+ @w_valores
      
      --SE EJECUTA REGLA DE VALIDACION DE CANTIDAD DE LIMITADOS	
      exec @w_error           = cob_cartera..sp_ejecutar_regla
      @s_ssn                  = @s_ssn,
      @s_ofi                  = @s_ofi,
      @s_user                 = @s_user,
      @s_date                 = @s_date,
      @s_srv                  = @s_srv,
      @s_term                 = @s_term,
      @s_rol                  = @s_rol,
      @s_lsrv                 = @s_lsrv,
      @s_sesn                 = @s_sesn,
      @i_regla                = 'VALIDENGR', 
      @i_tipo_ejecucion       = 'REGLA',     
      @i_valor_variable_regla = @w_valores,
      @o_resultado1           = @w_resultado out
      
      select @o_respuesta = @w_resultado 
	   
   end else begin
        	
      select @w_limitados = count(1) from #cl_respuesta_bio_aux 
      where rb_resultado = 'LIMITADO'
      
      if @w_limitados > 0 select @o_respuesta = 'NO'
      else select @o_respuesta = 'SI'	   
      
   end
	
   --SE VALIDA RECHAZADOS Y ELIMINADOS		
   select rb_ente
   into #entes_validar
   from #cl_respuesta_bio_aux, cl_ente_bio
   where rb_resultado = 'RECHAZADO'
   and rb_ente = eb_ente
   and eb_sin_huella_dactilar not in ('S')
   order by rb_ente
   
   --HAY RECHAZADOS
   if (select count(1) from #entes_validar) > 0
   begin
 
      select @o_respuesta = @o_respuesta + ';R'
      select @w_cadena_fin = 'LOS SIGUIENTES CLIENTES TIENEN VALIDACION BIOMETRICA RECHAZADA: '		
	
      while(1=1) begin

	     select top 1 @w_ente_r = rb_ente from #entes_validar
			
		 if @@rowcount = 0 break

         select @w_cadena_fin= @w_cadena_fin + (select convert(varchar(15),en_ente) + ' '+en_nomlar from cl_ente where en_ente = @w_ente_r)
         delete from #entes_validar where rb_ente = @w_ente_r
         
         if (select count(1) from #entes_validar) > 0
         begin
            select @w_cadena_fin = @w_cadena_fin + ', '
         end
		 
      end
		
      select @w_id_inst_act =ia_id_inst_act 
	  from cob_workflow..wf_inst_actividad 
	  where ia_id_inst_proc  = @i_inst_proc 
	  and ia_estado          = 'ACT'
      and ia_tipo_dest       is null 
	  and ia_id_destinatario is null
      
      select @w_asig_act     = aa_id_asig_act 
	  from cob_workflow..wf_asig_actividad 
	  where aa_id_inst_act   = @w_id_inst_act
      
      select top 1 @w_numero = ob_numero 
	  from cob_workflow..wf_observaciones 
      where ob_id_asig_act = @w_asig_act
      order by ob_numero desc
      
      if (@w_numero is not null)
         select @w_numero = @w_numero + 1 --aumento en uno el maximo
      else
         select @w_numero = 1
		
      delete cob_workflow..wf_observaciones 
      where ob_id_asig_act = @w_asig_act
      and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and (ol_texto like '%LOS SIGUIENTES CLIENTES TIENEN VALIDACION BIOMETRICA RECHAZADA:%'))
        
      delete cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and  (ol_texto like '%LOS SIGUIENTES CLIENTES TIENEN VALIDACION BIOMETRICA RECHAZADA:%')
      
      select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
		
      if len(@w_cadena_fin) > 255
      begin
         insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
         values (@w_asig_act, @w_numero, getdate(), @w_proceso, 2, 'a', @w_usuario)
         
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 1, substring(@w_cadena_fin,0,254))
         
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 2, substring(@w_cadena_fin,255,255))
      	
      end else begin
         insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
         values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
			 
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 1, @w_cadena_fin)
      end
   end else	begin
      --Caso ##145927
      select cliente as ente
      into #clientes
      from #integrantes_bio--Por caso#175319 
      		
      delete #clientes 
      where ente in (select eb_ente
                     from cobis..cl_ente_bio 
                     where eb_ente in (select ente from #clientes)
                     and   eb_sin_huella_dactilar = 'S')
      
      select @w_total = count(*) from #clientes
					
      select @w_total_v = count(*) from cl_respuesta_bio 
      where rb_ente in (select ente from #clientes)         
      and rb_inst_proc = @i_inst_proc 			
      
      if(@w_total_v is null OR @w_total_v < @w_total)
      begin
         select @o_respuesta = @o_respuesta + ';P'
      end
      else 
      begin
         select @o_respuesta = @o_respuesta + ';A'
      end
   end
   print '------>>>Proceso: ' + convert(varchar(256), @i_inst_proc) + '--->>o_respuesta: '+ @o_respuesta
end

if(@i_operacion = 'S')
begin
	select @o_oficina = fu_oficina
	from cobis..cl_funcionario
	where fu_login = @i_login
	if @@rowcount = 0
	begin
		select @w_error = 101016
		goto ERROR
	end
end

	
return 0
	
ERROR:

exec sp_cerror
@t_from  = @w_sp_name,
@i_num   = 103118,
@i_msg   = 'Error guardando la información de Biocheck'
return @w_error

go