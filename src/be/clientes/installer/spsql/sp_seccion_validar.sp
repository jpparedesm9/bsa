/************************************************************************/
/*  Archivo:                sp_seccion_validar.sp                       */
/*  Stored procedure:       sp_seccion_validar                          */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 15/Ago/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Permite actualizar un Prospecto a Cliente de forma automática        */
/* siempre que este cumpla con el ingreso de cada modulo                */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  15/Ago/2017 P. Ortiz             Emision Inicial                    */
/*  23/Ago/2017 P. Ortiz             Corregir excepcion                 */
/*  06/Sep/2017 P. Ortiz             Agregar Conyuge y Listas Negras    */
/*  06/Sep/2017 P. Ortiz             Agregar Seccion Documentos Digit   */
/*  22/Abr/2021 S. Rojas             Req #155939                        */
/* **********************************************************************/

use cobis
go

if exists(select 1 from sysobjects where name ='sp_seccion_validar')
	drop proc sp_seccion_validar
go

create proc sp_seccion_validar (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = NULL,
   @s_org_err         char(1)     = NULL,
   @s_error           int         = NULL,
   @s_sev             tinyint     = NULL,
   @s_msg             descripcion = NULL,
   @s_org             char(1)     = NULL,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_operacion       char(1),
   @i_ente            int         = null,
   @i_seccion         catalogo    = null,
   @i_completado      char(1)     = null,
   @i_telefono        char(1)     = null,
   @i_modo            int         = 0,
   @o_msg_referencias varchar(132)= null output,
   @o_msg_documentos  varchar(132)= null output,
   @o_msg_relacion    varchar(132)= null output,
   @o_msg_santander   varchar(132)= null output,
   @o_msg_listas      varchar(132)= null output,
   @o_msg_buro        varchar(132)= null output,
   @o_msg_ingresos    varchar(132)= null output,
   @o_msg_direccion   varchar(132)= null output,
   @o_msg_telefono    varchar(132)= null output
)as
declare 
   @w_ts_name         varchar(32),
   @w_num_error       int,
   @w_sp_name         varchar(32),
   @w_seccion         catalogo,
   @w_completado      char(1),
   @w_actual          char(1),  
   @w_seccion_act	  catalogo,
   @w_ultima_seccion  char(1), --Permite saber si el que se va a insertar es el último valor
   @w_contar          int,      --Permite contar cuantos modulos faltan por completar
   @w_ea_cta_banco    varchar(45),
   @w_ea_estado_std   varchar(10),
   @w_en_banco        varchar(20),
   @w_contar_ref      int,
   @w_relacion        char(1),
   @w_ea_lista_negra  char(1),
   @w_nro_catalogo 	  int,
   @w_nro_documentos  int,
   @w_documentos      char(1),
   @w_calif_buro      varchar(10),
   @w_ingresos        money,
   @w_nivel_riesgo_cg char(1),
   @w_estado_ente     char(1)
   
select @w_sp_name = 'sp_seccion_validar'

--Valida si el cliente ya está Activo
select @w_estado_ente = ea_estado from cobis..cl_ente_aux where ea_ente = @i_ente
if(@w_estado_ente = 'A')
begin
	return 0
end

/* Obtener informacion del cliente */
--Validar transformacion a cliente
SELECT	@w_ea_cta_banco  = ea_cta_banco,
		@w_ea_estado_std = ea_estado_std,
		@w_ea_lista_negra= ea_lista_negra
FROM cobis..cl_ente_aux WHERE ea_ente = @i_ente

SELECT	@w_en_banco 		= en_banco,
		@w_calif_buro       = p_calif_cliente,
		@w_ingresos         = en_otros_ingresos
FROM cobis..cl_ente WHERE en_ente = @i_ente

--Cantidad de referencias del cliente
select @w_contar_ref = count(rp_referencia) from cobis..cl_ref_personal 
where rp_persona = @i_ente

--Comprobando si tiene los documentos completo
SELECT @w_nro_catalogo = count(codigo) FROM cobis..cl_catalogo 
WHERE tabla = (SELECT codigo FROM cobis..cl_tabla 
WHERE tabla = 'cr_doc_digitalizado_ind')
AND codigo IN ('001', '002','003')

SELECT @w_nro_documentos = count(dd_tipo_doc) FROM cob_credito..cr_documento_digitalizado
WHERE dd_cliente = @i_ente
AND dd_inst_proceso = 0 	-- 0 Es para individual
AND dd_grupo = 0			-- 0 Es para individual
AND dd_tipo_doc in (SELECT codigo FROM cobis..cl_catalogo 
					WHERE tabla = (SELECT codigo FROM cobis..cl_tabla 
						WHERE tabla = 'cr_doc_digitalizado_ind'))
AND dd_cargado = 'S'

--Validacion de relacion con conyuge
SELECT @w_relacion = 'S' --inicializo variable para entes sin estado civil 'CA' o 'UN'

if @i_operacion = 'V'
begin
	
	select @w_ultima_seccion = 'N'
	
	if not exists (SELECT 1 FROM cobis..cl_seccion_validar
	               where sv_ente       = @i_ente)
	begin
		
		SELECT @w_seccion_act = 0
		WHILE 1 = 1
		BEGIN
			select top 1 @w_seccion_act = c.codigo from cobis..cl_catalogo AS c
			where tabla in (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_modulo_cliente')
			and c.codigo > @w_seccion_act
			and c.estado = 'V'
			order by c.codigo asc
			
			IF @@ROWCOUNT = 0
	      		BREAK
			
			insert into cobis..cl_seccion_validar(sv_ente, sv_seccion, sv_completado)
    		values(@i_ente, RTRIM(@w_seccion_act), 'N')
			
		END
	end
	
	if exists (SELECT 1 FROM cobis..cl_seccion_validar
	           where sv_ente       = @i_ente
	           and   sv_seccion    = @i_seccion
	           and   sv_completado = 'N')
	begin
		select @i_operacion = 'U'
	end
	
	SELECT @w_contar = count(sv_completado) FROM cobis..cl_seccion_validar 
	WHERE sv_ente = @i_ente
	AND sv_completado = 'N'
	
	SELECT @w_seccion_act = 0
	if (@w_contar = 1)
	begin
		select top 1 @w_seccion_act = sv_seccion FROM cobis..cl_seccion_validar 
	   	WHERE sv_ente = @i_ente
	   	and sv_completado = 'N'
		
		if (@w_seccion_act = @i_seccion)
		begin
			select @w_ultima_seccion = 'S'
		end
		else
		begin
			select @w_ultima_seccion = 'N'
		end
	end
	if (@w_contar = 0)
	begin
		select @i_operacion = 'F'
	end
	if ((@i_operacion = 'V') and (@w_ultima_seccion = 'N'))
	begin
		goto fin
	end
end

if @i_operacion = 'U'
begin
    
    if (@i_seccion = '4') --4 es Referencias del cliente
    begin
    	if @w_contar_ref < 2
      	begin
    		goto fin
    	end
    end
    
    if (@i_seccion = '5') --5 es Documentos Digitalizados
    begin
    	
    	--Comprobando si tiene los documentos completo
		SELECT @w_nro_catalogo = count(codigo) FROM cobis..cl_catalogo 
		WHERE tabla = (SELECT codigo FROM cobis..cl_tabla 
		WHERE tabla = 'cr_doc_digitalizado_ind')
		AND codigo IN ('001', '002','003')
		
		SELECT @w_nro_documentos = count(dd_tipo_doc) FROM cob_credito..cr_documento_digitalizado
		WHERE dd_cliente = @i_ente
		AND dd_inst_proceso = 0 	-- 0 Es para individual
		AND dd_grupo = 0			-- 0 Es para individual
		AND dd_tipo_doc in (SELECT codigo FROM cobis..cl_catalogo 
							WHERE tabla = (SELECT codigo FROM cobis..cl_tabla 
								WHERE tabla = 'cr_doc_digitalizado_ind'))
		AND dd_cargado = 'S'
		
    	--Si no tiene completos sale sin actualizar
    	if (@w_nro_documentos < @w_nro_catalogo)
      	begin
    		goto fin
    	end
    end
    
    
    select
        @w_seccion         = sv_seccion,
        @w_completado      = sv_completado        
    from cobis..cl_seccion_validar
    where sv_ente = @i_ente
    if @@rowcount = 0
      begin
         select @w_num_error =  103149 --No existe el registro que desea actualizar
         goto errores
      end 
    
    begin tran
    
    if @i_seccion is not null
        select @w_seccion = @i_seccion
        
    if @i_completado is not null
        select @w_completado = @i_completado
    
      --Actualizar completado de sección
    update cobis..cl_seccion_validar
    set  sv_completado        = @w_completado
    where sv_ente    = @i_ente
    and   sv_seccion = @i_seccion
      
      if @@error != 0
      begin
         select @w_num_error = 103150 --Error al actualizar la seccion del cliente
         goto errores
      end
    
      commit tran
    
    if (@w_ultima_seccion = 'S')
    begin
    	select @i_operacion = 'F'
    end
    else
    begin
    	goto fin
    end
    
end

if @i_operacion = 'F'
begin
   
    --Validar transformacion a cliente
	SELECT	@w_ea_cta_banco  	= ea_cta_banco,
			@w_ea_estado_std 	= ea_estado_std,
			@w_ea_lista_negra 	= ea_lista_negra,
			@w_nivel_riesgo_cg 	= ea_nivel_riesgo_cg
	FROM cobis..cl_ente_aux WHERE ea_ente = @i_ente
	
	SELECT	@w_en_banco 		= en_banco,
			@w_calif_buro       = p_calif_cliente,
			@w_ingresos         = en_otros_ingresos
	FROM cobis..cl_ente WHERE en_ente = @i_ente
	
	--Validacion de relacion con conyuge
	SELECT @w_relacion = 'S' --inicializo variable para entes sin estado civil 'CA' o 'UN'
	
	IF EXISTS (SELECT 1 FROM cobis..cl_ente WHERE en_ente = @i_ente
				AND ((p_estado_civil = 'CA') OR (p_estado_civil = 'UN')))
	begin
		
		IF EXISTS (select 1 from cobis..cl_conyuge where co_ente = @i_ente)
		BEGIN																	  
			SELECT @w_relacion = 'S' --Tiene relacion si pasa
		end
		else
		begin
			SELECT @w_relacion = 'N' --No tiene relacion no pasa
		end
	end
	
	if exists( select 1 from cobis..cl_telefono where te_ente = @i_ente and te_tipo_telefono = 'C')
	begin
		select @i_telefono = 'S'
	end

   if ((@w_ea_cta_banco IS NOT NULL) and (@w_ea_estado_std IS NOT NULL) and (@w_en_banco IS NOT NULL)
           and (@w_ea_lista_negra <> 'S') and (@w_relacion = 'S') and (@w_ingresos IS NOT NULL))
   begin
      if((@w_nivel_riesgo_cg <> 'F') or (@w_nivel_riesgo_cg is not null))  begin
         if @i_modo = 0 begin
           
            --Actualiza automaticamente el Estado
            update cobis..cl_ente_aux
            set   ea_estado = 'A',
			      ea_fecha_activacion = getdate()
            where ea_ente    = @i_ente
            
            if @@error <> 0 begin   
               select @w_num_error = 103151 --Error al actualizar Prospecto a Cliente!
               goto errores
            end
            
         end
         else return 0
      end else begin
         select @w_num_error = 103167 --Error al actualizar Prospecto a Cliente!
         goto errores
      end
   end
    
    
    goto fin
end

if @i_operacion = 'Q'
begin
	
	/*if @w_contar_ref < 2
  	begin
		select @o_msg_referencias = mensaje from cobis..cl_errores where numero = 103166 --Debe tener al menos 2 referencias!
	end*/
	
	if (@w_nro_documentos < @w_nro_catalogo)
  	begin
		select @o_msg_documentos = mensaje 
		from cobis..cl_errores where numero = 103167 --Debe cumplir los documentos requeridos!
	end
	
	if exists (select 1 from cobis..cl_ente where en_ente = @i_ente
				and ((p_estado_civil = 'CA') or (p_estado_civil = 'UN')))
	begin
		if not exists (select 1 from cobis..cl_conyuge where co_ente = @i_ente)
		begin
			select @o_msg_relacion = mensaje 
			from cobis..cl_errores where numero = 103168 --Debe regularizar su estado civil!
		end
	end
	
	if ((@w_ea_cta_banco is null) and (@w_ea_estado_std is null) and (@w_en_banco is null))
	begin
	    select @o_msg_santander = mensaje 
	    from cobis..cl_errores where numero = 103169 --Debe consultar datos de Santander!
	end
	
	
	if (@w_ea_lista_negra = 'S')
	begin
	    select @o_msg_listas = mensaje 
	    from cobis..cl_errores where numero = 103170  --El cliente esta en Listas Negras!
	end
	
	if (@w_calif_buro = 'ROJO')
	begin
	    select @o_msg_buro = mensaje 
	    from cobis..cl_errores where numero = 103171  --El cliente tiene buro ROJO!
	end
	
	if (@w_ingresos is null)
	begin
	    select @o_msg_ingresos = mensaje 
	    from cobis..cl_errores where numero = 103172  --El cliente no tiene ingresos registrados!
	end
	
	if not exists(select 1 from cobis..cl_direccion where di_ente = @i_ente and di_tipo = 'RE')
	begin
		select @o_msg_direccion = mensaje 
	    from cobis..cl_errores where numero = 103173  --El cliente no tiene direccion de Domicilio!
	end
	else if not exists(select 1 from cobis..cl_direccion where di_ente = @i_ente and di_tipo = 'AE')
	begin
		select @o_msg_direccion = mensaje 
	    from cobis..cl_errores where numero = 103174  --El cliente no tiene direccion de Negocio!
	end
	
	if not exists( select 1 from cobis..cl_telefono where te_ente = @i_ente and te_tipo_telefono = 'C')
	begin
		select @o_msg_telefono = mensaje 
	    from cobis..cl_errores where numero = 103175  --El cliente debe tener al menos un telefono!
	end
	
	goto fin
end

--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0

go

