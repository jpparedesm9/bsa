/************************************************************************/
/*      Archivo:                sp_doc_digitalizado.sp                  */
/*      Stored procedure:       sp_doc_digitalizado                     */
/*      Base de datos:          cob_credito                             */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Andres Cusme		                    */
/*      Fecha de escritura:     03-Jul-2017                             */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este programa permite insertar los documentos digitalizados	    */
/*    tanto del flujo grupal, flujo individual y para clientes			*/
/*	  individuales														*/
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    													                */
/*  													                */
/************************************************************************/
use cob_credito
go

--set ANSI_NULLS off
--GO
--set QUOTED_IDENTIFIER off
--GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_doc_digitalizado')
  drop proc sp_doc_digitalizado
go

create proc sp_doc_digitalizado
(
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_cliente      int = null,
  @i_inst_proceso int = null,
  @i_grupo		  int = null,
  @i_fecha        datetime = null,
  @i_tipo_doc	  varchar(10) = null,
  @i_cargado	  char(1) = null,
  @i_extension	  char(8) = null,
  @i_modo		  int = null  
)
as
  declare
	@w_catalogo_grupos 			  int,
	@w_catalogo_individuales	  int,
	@w_catalogo_flujo_individual  int,
	@w_tipo_doc				  varchar(10),
	@w_count					  int				  
	
	select @w_catalogo_grupos = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado')
	select @w_catalogo_individuales = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ind')
	select @w_catalogo_flujo_individual = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_flujo_ind')

  if @i_operacion = 'U'
  begin
    if @t_trn = 21365
	begin
		if exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @i_tipo_doc)
		begin
			update cob_credito..cr_documento_digitalizado
			set dd_cargado = 'S',
			    dd_extension = @i_extension
			where dd_cliente 			= @i_cliente 
				and dd_inst_proceso		= @i_inst_proceso
				and dd_grupo 			= @i_grupo
				and dd_tipo_doc			= @i_tipo_doc
		end
		else
		begin
			insert into cob_credito..cr_documento_digitalizado (dd_inst_proceso,dd_cliente,dd_grupo,dd_fecha,dd_tipo_doc,dd_cargado,dd_extension)
            values (@i_inst_proceso,@i_cliente,@i_grupo,@i_fecha,@i_tipo_doc,'S',@i_extension)
		end
	end
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn = 21365 
    begin
			if @i_modo = 1 --Grupos
				begin
		SELECT @w_tipo_doc = 0
		set @w_count = 0

		SELECT TOP 1 @w_tipo_doc = codigo 
					FROM cobis..cl_catalogo WHERE tabla = @w_catalogo_grupos
		AND codigo > @w_tipo_doc
		ORDER BY codigo asc
		WHILE @@ROWCOUNT > 0
			BEGIN
			PRINT convert(VARCHAR, @w_tipo_doc)
			if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
				begin
				  insert into cob_credito..cr_documento_digitalizado
				  values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
				  set @w_count = @w_count + 1
				end

				SELECT TOP 1 @w_tipo_doc = codigo 
				FROM cobis..cl_catalogo 
							WHERE tabla = @w_catalogo_grupos
				AND codigo > @w_tipo_doc
				ORDER BY codigo asc
			END
					
			select
				'INSTANCIA_PROCESO' = dd_inst_proceso,
				'CLIENTE' = dd_cliente,
				'GRUPO' = dd_grupo,
				'FECHA_PROCESO' = dd_fecha,
						'TIPO_DOCUMENTO' = (select valor from cobis..cl_catalogo where tabla = @w_catalogo_grupos and codigo = dd_tipo_doc),
				'CARGADO' = dd_cargado,
                'ID_DOCUMENTO' = dd_tipo_doc,
				'EXTENSION' = dd_extension
				from   cob_credito..cr_documento_digitalizado
				where dd_cliente 		= @i_cliente
					and dd_inst_proceso = @i_inst_proceso
					and dd_grupo		= @i_grupo
				end
			else if @i_modo = 2 --Clientes individuales
				begin
					SELECT @w_tipo_doc = 0
					set @w_count = 0

					SELECT TOP 1 @w_tipo_doc = codigo 
					FROM cobis..cl_catalogo WHERE tabla = @w_catalogo_individuales
					AND codigo > @w_tipo_doc
					ORDER BY codigo asc
					WHILE @@ROWCOUNT > 0
						BEGIN
						PRINT convert(VARCHAR, @w_tipo_doc)
						if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
							begin
							  insert into cob_credito..cr_documento_digitalizado
							  values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
							  set @w_count = @w_count + 1
							end

							SELECT TOP 1 @w_tipo_doc = codigo 
							FROM cobis..cl_catalogo 
							WHERE tabla = @w_catalogo_individuales
							AND codigo > @w_tipo_doc
							ORDER BY codigo asc
						END
			
					select
						'INSTANCIA_PROCESO' = dd_inst_proceso,
						'CLIENTE' = dd_cliente,
						'GRUPO' = dd_grupo,
						'FECHA_PROCESO' = dd_fecha,
						'TIPO_DOCUMENTO' = (select valor from cobis..cl_catalogo where tabla = @w_catalogo_individuales and codigo = dd_tipo_doc),
						'CARGADO' = dd_cargado,
						'ID_DOCUMENTO' = dd_tipo_doc,
						'EXTENSION' = dd_extension
						from   cob_credito..cr_documento_digitalizado
						where dd_cliente 		= @i_cliente
							and dd_inst_proceso = @i_inst_proceso
							and dd_grupo		= @i_grupo
				end
			else if @i_modo = 3 --Flujo individual
				begin
					SELECT @w_tipo_doc = 0
					set @w_count = 0

					SELECT TOP 1 @w_tipo_doc = codigo 
					FROM cobis..cl_catalogo WHERE tabla = @w_catalogo_flujo_individual
					AND codigo > @w_tipo_doc
					ORDER BY codigo asc
					WHILE @@ROWCOUNT > 0
						BEGIN
						PRINT convert(VARCHAR, @w_tipo_doc)
						if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
							begin
							  insert into cob_credito..cr_documento_digitalizado
							  values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
							  set @w_count = @w_count + 1
							end

							SELECT TOP 1 @w_tipo_doc = codigo 
							FROM cobis..cl_catalogo 
							WHERE tabla = @w_catalogo_flujo_individual
							AND codigo > @w_tipo_doc
							ORDER BY codigo asc
						END
			
					select
						'INSTANCIA_PROCESO' = dd_inst_proceso,
						'CLIENTE' = dd_cliente,
						'GRUPO' = dd_grupo,
						'FECHA_PROCESO' = dd_fecha,
						'TIPO_DOCUMENTO' = (select valor from cobis..cl_catalogo where tabla = @w_catalogo_flujo_individual and codigo = dd_tipo_doc),
						'CARGADO' = dd_cargado,
						'ID_DOCUMENTO' = dd_tipo_doc,
						'EXTENSION' = dd_extension
						from   cob_credito..cr_documento_digitalizado
						where dd_cliente 		= @i_cliente
							and dd_inst_proceso = @i_inst_proceso
							and dd_grupo		= @i_grupo
				end
	end  
  end

go

