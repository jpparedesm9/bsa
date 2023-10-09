/************************************************************************/
/*      Archivo:                sp_doc_digitalizado.sp                  */
/*      Stored procedure:       sp_doc_digitalizado                     */
/*      Base de datos:          cob_credito                             */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Andres Cusme                            */
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
/*    Este programa permite insertar los documentos digitalizados       */
/*    tanto del flujo grupal, flujo individual y para clientes          */
/*      individuales                                                    */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA         AUTOR                     RAZON                     */
/*  30/11/2017    P. Ortiz    Agregar Documento y validacion            */
/*  14/12/2017    P. Ortiz    Agregar verificacion de documentos        */
/*  04/05/2018    P. Ortiz    Excluir documentos                        */
/*  24/05/2019    ACHP        Incluir solo cli con tg_monto > cero      */
/*  01/08/2019    ACHP        Activar doc008(Domiciliacion) si el       */
/*                            parametro ADODOM = S                      */
/*  18/01/2021    S. Rojas    Requerimiento #147999                     */
/*  03/03/2021    S. Rojas    Requerimiento #147999                     */
/*  21/06/2021    ACH         ERR155695-Err en pruebas deriv del 147999 */
/*  27/07/2021    ACH         Cambio n pantalla VERIFICAR Y DIGITALIZAR */
/*                            barrerse el flujo por caso REQ#162288     */
/*  20/09/2021    KVI         Req.123670 - estado mod mail,direccion    */
/*  22/03/2022    KVI         Sop.180604 - Deshabilitar doc. Flujo Ind. */
/*  08/12/2022    ACH         REQ194473-OT Vigencia Persona sin Huellas */
/************************************************************************/
use cob_credito
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_doc_digitalizado')
  drop proc sp_doc_digitalizado
go

create proc sp_doc_digitalizado
(
  @s_ssn                   int          = null,
  @s_sesn                  int          = null,
  @s_user                  login        = null,
  @s_term                  varchar(30)  = null,
  @s_date                  datetime     = null,
  @s_srv                   varchar(30)  = null,
  @s_lsrv                  varchar(30)  = null,
  @s_ofi                   smallint     = null,
  @s_rol                   smallint     = null,
  @s_org_err               char(1)      = null,
  @s_error                 int          = null,
  @s_sev                   tinyint      = null,
  @s_msg                   descripcion  = null,
  @s_org                   char(1)      = null,
  @t_debug                 char(1)      = 'N',
  @t_file                  varchar(10)  = null,
  @t_from                  varchar(32)  = null,
  @t_trn                   smallint     = null,
  @t_show_version          bit          = 0,
  @i_operacion             char(1)      = null,
  @i_cliente               int          = null,
  @i_inst_proceso          int          = null,
  @i_grupo                 int          = null,
  @i_fecha                 datetime     = null,
  @i_tipo_doc              varchar(255) = null,
  @i_cargado               char(1)      = null,
  @i_extension             char(8)      = null,
  @i_modo                  int          = null,
  @i_origen                char(1)      = null,
  @i_sin_huella_dactilar   char(1)      = 'N'
)                          
as
declare
@w_catalogo_grupos            int,
@w_catalogo_individuales      int,
@w_catalogo_flujo_individual  int,
@w_catalogo_renovacion        int,
@w_tipo_doc                   varchar(10),
@w_count                      int,
@w_edad                       int,
@w_edad_min                   int,
@w_edad_max                   int,
@w_ente                       int, 
@w_cargado                    char(1),
@w_completado                 char(1),
@w_tramite                    int,
@w_doc_excluidos              int,
@w_fecha_proceso              datetime,
@w_act_doc_domiciliacion      char(1),
@w_existe_registro            char(1),
@w_aval_cre_ind               int,
@w_catalogo_aval              INT,
@w_completado_aval            char(1),
@w_cargado_aval               char(1),
@w_completado_fi              char(1),
@w_secuencial                 int,
@w_completado_proceso         char(1),
@w_completado_cliente         char(1)
      
    
select @w_doc_excluidos = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_prospecto')
select @w_catalogo_grupos = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado')
select @w_catalogo_individuales = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ind')
select @w_catalogo_flujo_individual = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_flujo_ind')
select @w_catalogo_renovacion = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ren')
select @w_catalogo_aval = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_aval')
select @w_edad_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMICI'
select @w_edad_max = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMACI'
select @w_edad = DATEDIFF(year,p_fecha_nac, fp_fecha) from cobis..cl_ente, cobis..ba_fecha_proceso where en_ente = @i_cliente
select @w_act_doc_domiciliacion =  pa_char from cobis..cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'ADODOM'


print 'La edad es: ' + convert(varchar(10), @w_edad)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_fecha_proceso = convert(datetime,(convert(varchar,@w_fecha_proceso,101) + ' ' + convert(varchar,datepart(hh, getDate())) + ':' + convert(varchar,datepart(mi, getDate())) + ':' + convert(varchar,datepart(ss, getdate())) ))
    
if @i_operacion = 'U'
begin
    if @t_trn = 21365
    begin
	
	    if (@i_cliente = 0 and @i_inst_proceso > 0 and  @i_grupo = 0)
		begin
		    update cob_workflow..wf_req_inst
			set    ri_nombre_doc = rtrim(@i_tipo_doc) + '.' + rtrim(@i_extension),
			       ri_fecha_registro = getdate()
			where  ri_id_inst_proc = @i_inst_proceso
			and    ri_nombre_doc like '%'+@i_tipo_doc+'%'
			return 0
		end
        
        if exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @i_tipo_doc)
        begin
            update cob_credito..cr_documento_digitalizado
            set dd_cargado   = 'S',
                dd_extension = @i_extension,
                dd_fecha     = @w_fecha_proceso
            where dd_cliente             = @i_cliente 
                and dd_inst_proceso        = @i_inst_proceso
                and dd_grupo             = @i_grupo
                and dd_tipo_doc            = @i_tipo_doc
                --and dd_tipo_doc not in ('001', '002', '003', '004', '005', '006', '007') --Banco pide excluir
            
			if @i_tipo_doc = '010'
			begin
			  if exists (select 1 from cob_credito..cr_estados_sol_mod_dat where es_ente = @i_cliente)
              begin
			    update cob_credito..cr_estados_sol_mod_dat 
				set es_estado_dir = 'N',
				    es_estado_mail = 'N',
				    es_fecha = @w_fecha_proceso
			    where es_ente = @i_cliente
			  end
			  else 
			  begin
			    insert into cob_credito..cr_estados_sol_mod_dat (es_ente,es_estado_dir,es_estado_mail,es_fecha)
                values (@i_cliente,'N','N',@w_fecha_proceso)
			  end
			end
            
            -- Actualizacion Automatica de Prospecto a Cliente
            exec cobis..sp_seccion_validar
                @i_ente            = @i_cliente,
                @i_operacion     = 'V',
                @i_seccion         = '5', --5 es Documentos Digitalizados
                @i_completado     = 'S'
            
        end
        else
        begin
            /*if((@i_tipo_doc = '008') OR (@i_tipo_doc = '009'))
            begin*/
            insert into cob_credito..cr_documento_digitalizado (dd_inst_proceso,dd_cliente,dd_grupo,dd_fecha,dd_tipo_doc,dd_cargado,dd_extension)
            values (@i_inst_proceso,@i_cliente,@i_grupo,@i_fecha,@i_tipo_doc,'S',@i_extension)
        
            -- Actualizacion Automatica de Prospecto a Cliente
            exec cobis..sp_seccion_validar
                @i_ente            = @i_cliente,
                @i_operacion     = 'V',
                @i_seccion         = '5', --5 es Documentos Digitalizados
                @i_completado     = 'S'
            --end
        end
    end
end
  
if @i_operacion = 'V'
begin
    if @t_trn = 21365
    begin
        if (@i_inst_proceso is not null)
        begin
            select @w_ente = 0
            set @w_completado = 'S'
            
            select @w_tramite = io_campo_3
            from cob_workflow..wf_inst_proceso
            where io_id_inst_proc = @i_inst_proceso
            
            while 1 = 1
            begin
                
                select top 1 @w_ente = cg_ente 
                from cobis..cl_cliente_grupo 
                inner join cob_credito..cr_tramite_grupal on tg_grupo = cg_grupo and tg_cliente = cg_ente
                where cg_grupo = @i_grupo
                and tg_tramite = @w_tramite
                and tg_participa_ciclo = 'S'
                and cg_ente > @w_ente
                and tg_monto > 0
                order by cg_ente asc
                
                if @@rowcount = 0
                    break

                /* Verificar que todos los documentos esten cargados para el cliente */
                if exists (select top 1 * from cob_credito..cr_documento_digitalizado 
                                where dd_cliente = @w_ente 
                                    and dd_inst_proceso = @i_inst_proceso)
                begin
                    select top 1 @w_cargado = dd_cargado from cob_credito..cr_documento_digitalizado 
                    where dd_cliente = @w_ente --7095
                    and dd_inst_proceso = @i_inst_proceso --3689
                    and dd_cargado = 'N'
                    
                    if @@rowcount = 0
                        set @w_completado = 'S'
                end
                else
                begin
                    set @w_completado = 'N'
                    break
                end
                
                if (@w_cargado = 'N')
                begin
                    set @w_completado = 'N'
                    break
                end
                
            end
            
            /* Devuelvo resultado de validacion */
            select top 1
            'sintaciaProceso'   = @i_inst_proceso,
            'grupo'             = @i_grupo,
            'completado'         = convert(varchar(1),@w_completado)
            --print 'El estado de cargado es: ' + convert(varchar(10), isnull(@w_completado, 'Valor Null'))
            
        end
        
        return 0
        
    end
end
  

if @i_operacion = 'W'--Validar Documentos Digitalizados para Flujo Individual
begin
	if @t_trn = 21365
	begin
		if (@i_inst_proceso is not null)
		begin
			--select @w_ente = 0
			--set @w_completado = 'S'
			--set @w_completado_aval='S'
			set @w_completado_fi='N'
            set @w_completado_proceso = 'N'
            set @w_completado_cliente = 'N'
			set @w_completado_aval = 'N'
			
			select @w_tramite = io_campo_3--Encuentro el tramite de la instancia
			from cob_workflow..wf_inst_proceso
			where io_id_inst_proc = @i_inst_proceso
			
			SELECT @w_aval_cre_ind=tr_alianza--Encuntro el codigo del Aval
            FROM  cob_workflow..wf_inst_proceso,cob_credito..cr_tramite 
            WHERE io_id_inst_proc=@i_inst_proceso
            AND   io_campo_3=tr_tramite
		
            print 'El @i_cliente es: ' + convert(varchar(10), @i_cliente)
            print 'El @w_aval_cre_ind es: ' + convert(varchar(10), @w_aval_cre_ind)
            print 'El @i_inst_proceso es: ' + convert(varchar(10), @i_inst_proceso)

            --caso#REQ#162288
			--Verificar que los docs del proceso esten cargados
			if not exists (select top 1 * from cob_credito..cr_documento_digitalizado 
			    where dd_inst_proceso = @i_inst_proceso and dd_cargado = 'N'
				and dd_tipo_doc in ('001','002','003','008','009') 
				and dd_tipo_doc not in (select de_codigo from cob_credito..cr_documentos_excluidos 
				                        where de_tabla = 'cr_doc_digitalizado_flujo_ind')) --Sop.180604
			set @w_completado_proceso = 'S'
			
			--Verificar que los docs del cliente esten cargados
			if not exists (select top 1 * from cob_credito..cr_documento_digitalizado 
			               where dd_inst_proceso = 0 and dd_cliente = @i_cliente 
				           and dd_grupo = 0 and dd_cargado = 'N'
                           and dd_tipo_doc in ('001','002','003','008','009'))
			set @w_completado_cliente = 'S'
			
			--Verificar que los docs del aval esten cargados			
			if not exists (select top 1 * from cob_credito..cr_documento_digitalizado 
			               where dd_inst_proceso = 0 and dd_cliente = @w_aval_cre_ind 
				           and dd_grupo = 0 and dd_cargado = 'N' 
                           and dd_tipo_doc in ('001','002','003','008','009')
						   and dd_tipo_doc not in (select de_codigo from cob_credito..cr_documentos_excluidos 
				                                   where de_tabla = 'cr_doc_digitalizado_ind')) --Sop.180604
			set @w_completado_aval = 'S'

            if (@w_completado_proceso = 'S' and @w_completado_cliente = 'S' and @w_completado_aval = 'S')
			begin
			    set @w_completado_fi = 'S'
			end
				
            --Verifico que los documentos esten cargados para el tramite
            /*if exists (select top 1 * from cob_credito..cr_documento_digitalizado 
								where dd_cliente = @i_cliente 
									and dd_inst_proceso = @i_inst_proceso)
			end
				PRINT '0'
				select TOP 1  @w_cargado = dd_cargado 
				        from  cob_credito..cr_documento_digitalizado 
					    where dd_cliente = @i_cliente 
					    and   dd_inst_proceso = @i_inst_proceso 
					    and   dd_tipo_doc IN ('011','012')
					    and   dd_cargado = 'N'
						
				if @@rowcount = 0
				begin
				    PRINT'1'
				   	set @w_completado = 'S'
				end
				else
				begin
				    PRINT'2'
				    set @w_completado = 'N'
				end
				
			end else
			begin
			    PRINT'3'
			    set @w_completado = 'N'
			end
			
			PRINT'4'
			
			--Verifico que los documentos esten cargados para el aval
			if exists (select top 1 * from cob_credito..cr_documento_digitalizado 
     					where dd_cliente = @w_aval_cre_ind 
								and dd_inst_proceso = 0
							    and dd_tipo_doc IN ('001','002','003','008'))
				BEGIN
				
				select TOP 1 @w_cargado_aval = dd_cargado 
				       from cob_credito..cr_documento_digitalizado 
					   where dd_cliente = @w_aval_cre_ind 
					   and dd_inst_proceso = 0 
					   AND dd_tipo_doc IN ('001','002','003','008')
					   and dd_cargado = 'N'
				   if @@rowcount = 0
				      begin
				    	set @w_completado_aval = 'S'
				      end
				   else
				      begin
				        set @w_completado_aval = 'N'
				      end
				
				END
				else
				begin
					set @w_completado_aval = 'N'
				END
				@w_completado_tramite = 'N'
				
				if (@w_completado = 'S' and @w_completado_aval='S')
				begin
					set @w_completado_fi = 'S'
				
				END
				print 'El estado de @w_completado es: ' + convert(varchar(10), @w_completado)				
				print 'El estado de @w_completado_aval es: ' + convert(varchar(10), @w_completado_aval)				
				*/

            print 'El valor de @w_completado_proceso es: ' + @w_completado_proceso
			print 'El valor de @w_completado_cliente es: ' + @w_completado_cliente
			print 'El valor de @w_completado_aval es: ' + @w_completado_aval
			
			/* Devuelvo resultado de validacion */
			select top 1
			'sintaciaProceso'   = @i_inst_proceso,
			'grupo' 			= @i_grupo,
			'completado' 		= convert(varchar(1),@w_completado_fi)
			print 'El estado de @w_completado_fi es: ' + convert(varchar(10), @w_completado_fi)
		
		end
		
		return 0
		
	end
end

  
if @i_operacion = 'Q'
begin
    if @t_trn = 21365 
    begin
        if @i_modo = 1 --Grupos
        begin
            select @w_tipo_doc = 0
            set @w_count = 0
            
            while 1 = 1
            begin
            
                if((@w_edad >= @w_edad_min) and (@w_edad <= @w_edad_max))
                begin
                    select top 1 @w_tipo_doc = codigo 
                    from cobis..cl_catalogo where tabla = @w_catalogo_grupos
                    and codigo > @w_tipo_doc
                    order by codigo asc
                    
                    if @@rowcount = 0
                        break
                end
                else
                begin
                    select top 1 @w_tipo_doc = codigo 
                    from cobis..cl_catalogo where tabla = @w_catalogo_grupos
                    and codigo > @w_tipo_doc
                    and codigo not in ('007')
                    order by codigo asc
                    
                    if @@rowcount = 0
                        break
                end
                
                print convert(varchar, @w_tipo_doc)
                if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
                begin
                    if(@w_act_doc_domiciliacion = 'S')
                    begin
                    if((@w_tipo_doc = '008') or (@w_tipo_doc = '009'))
                    begin
                        insert into cob_credito..cr_documento_digitalizado
                        values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                        set @w_count = @w_count + 1
                    end
                end
                    else
                    begin
                        if(@w_tipo_doc = '009')
                        begin
                            insert into cob_credito..cr_documento_digitalizado
                            values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                            set @w_count = @w_count + 1
                        end
                    end
                end
            end
            
             --Banco pide excluir
            create table #doc_excluir (cod_documento char(10))
            insert into #doc_excluir values ('001')
            insert into #doc_excluir values ('002')
            insert into #doc_excluir values ('003')
            insert into #doc_excluir values ('004')
            insert into #doc_excluir values ('005')
            insert into #doc_excluir values ('006')
            insert into #doc_excluir values ('007')            
            
            if exists (select 1 from cob_credito..cr_documento_digitalizado
                       where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso 
                       and dd_grupo = @i_grupo and dd_tipo_doc = '008')
            begin
                set @w_existe_registro = 'S'
            end
            else
            begin
                set @w_existe_registro = 'N'
            end
                    
            if ((@w_act_doc_domiciliacion = 'N') and @w_existe_registro = 'N')
                insert into #doc_excluir values ('008')            
            
            select
            'INSTANCIA_PROCESO' = dd_inst_proceso,
            'CLIENTE'             = dd_cliente,
            'GRUPO'             = dd_grupo,
            'FECHA_PROCESO'     = dd_fecha,
            'TIPO_DOCUMENTO'     = (select valor from cobis..cl_catalogo where tabla = @w_catalogo_grupos and codigo = dd_tipo_doc),
            'CARGADO'             = dd_cargado,
            'ID_DOCUMENTO'         = dd_tipo_doc,
            'EXTENSION'         = dd_extension
            from   cob_credito..cr_documento_digitalizado
            where dd_cliente         = @i_cliente
                and dd_inst_proceso = @i_inst_proceso
                and dd_grupo        = @i_grupo
                and dd_tipo_doc not in (select cod_documento from #doc_excluir)
            
            drop table #doc_excluir
        
        end
        else if @i_modo = 2 --Clientes individuales --usado en pantalla de Mantenimiento de Personas
        begin
		    declare @w_tipo_documento table(
			   codigo      varchar(10)
			)			
			
			/*#147999-Por renovacion en el flujo*/
			select @i_sin_huella_dactilar = ltrim(rtrim(@i_sin_huella_dactilar))
			if (@i_sin_huella_dactilar is null or @i_sin_huella_dactilar = '') begin
			    select @i_sin_huella_dactilar = eb_sin_huella_dactilar
			    from cobis..cl_ente_bio 
			    where eb_ente = @i_cliente
			end
			
			if @i_sin_huella_dactilar = 'S' begin
			   insert into @w_tipo_documento values ('004')
			   insert into @w_tipo_documento values ('005')
			end else  begin
			   insert into @w_tipo_documento values ('004')
			   insert into @w_tipo_documento values ('005')
			   insert into @w_tipo_documento values ('009')
			   insert into @w_tipo_documento values ('011') -- caso#194473
			   --Eliminar documento digitalizado 009
			   if exists(select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = '009')
			   begin
				delete from cob_credito..cr_documento_digitalizado
				where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = '009'
			   end
			   
			   --Eliminar documento digitalizado 011
			   if exists(select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = '011')
			   begin
				delete from cob_credito..cr_documento_digitalizado
				where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = '011'
			   end
			end
			
            select @w_tipo_doc = 0
            set @w_count = 0
            
            select top 1 @w_tipo_doc = codigo 
            from cobis..cl_catalogo 
			where tabla = @w_catalogo_individuales
            and codigo  > @w_tipo_doc
            order by codigo asc
            
			
            while @@rowcount > 0
            begin
                print convert(varchar, @w_tipo_doc)			   
				
                if not exists(select 1 from @w_tipo_documento where codigo = @w_tipo_doc)
                begin
                   if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
                   begin
                     insert into cob_credito..cr_documento_digitalizado
                     values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                     set @w_count = @w_count + 1
                   end
                end
                
                select top 1 @w_tipo_doc = codigo 
                from cobis..cl_catalogo 
                where tabla = @w_catalogo_individuales
                and codigo > @w_tipo_doc
                order by codigo asc
            end
            
            if (@i_origen = 'P')
            begin
			
			   declare @w_cat_doc_excluidos table(
			      codigo      varchar(10),
				  valor       varchar(64)
			   )
			   
			   if (@i_sin_huella_dactilar = 'S') begin
			      insert into @w_cat_doc_excluidos
				  select codigo, valor
				  from   cobis..cl_catalogo
				  where  tabla  = @w_doc_excluidos
			   end else begin
			      insert into @w_cat_doc_excluidos
				  select codigo, valor
				  from   cobis..cl_catalogo
				  where  tabla  = @w_doc_excluidos
				  and    codigo not in ('009')
			   end
			   
               select
               'INSTANCIA_PROCESO'     = A.dd_inst_proceso,
               'CLIENTE'               = A.dd_cliente,
               'GRUPO'                 = A.dd_grupo,
               'FECHA_PROCESO'         = A.dd_fecha,
               'TIPO_DOCUMENTO'        = B.valor,
               'CARGADO'               = A.dd_cargado,
               'ID_DOCUMENTO'          = A.dd_tipo_doc,
               'EXTENSION'             = A.dd_extension
               from  cob_credito..cr_documento_digitalizado A, @w_cat_doc_excluidos B
               where A.dd_tipo_doc     = B.codigo
			   and   A.dd_cliente      = @i_cliente
               and   A.dd_inst_proceso = @i_inst_proceso
               and   A.dd_grupo        = @i_grupo
            end
            else
            begin
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
                where dd_cliente         = @i_cliente
                    and dd_inst_proceso = @i_inst_proceso
                    and dd_grupo        = @i_grupo
            end
        end
        else if @i_modo = 3 --Flujo individual
        begin
            select @w_tipo_doc = 0
            set @w_count = 0
            
            select @w_aval_cre_ind=tr_alianza
   			from cob_workflow..wf_inst_proceso,cob_credito..cr_tramite 
   			where io_id_inst_proc=@i_inst_proceso
   			and io_campo_3=tr_tramite
            
            select top 1 @w_tipo_doc = codigo 
            from cobis..cl_catalogo where tabla = @w_catalogo_flujo_individual
            and codigo > @w_tipo_doc
            order by codigo asc
            
            while @@rowcount > 0
            begin
               print convert(varchar, @w_tipo_doc)
               if @w_tipo_doc in ('003', '004') -- Son los documentos del AVAL
               begin
                  if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @w_aval_cre_ind and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
                  begin
                     insert into cob_credito..cr_documento_digitalizado
                     values (@i_inst_proceso,@w_aval_cre_ind,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                     set @w_count = @w_count + 1
                  end
               end
               else
               begin
                  if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
                  begin
                     insert into cob_credito..cr_documento_digitalizado
                     values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                     set @w_count = @w_count + 1
                  end
               end
               
               select top 1 @w_tipo_doc = codigo 
               from cobis..cl_catalogo 
               where tabla = @w_catalogo_flujo_individual
               and codigo > @w_tipo_doc
               order by codigo asc
            end
        
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
            where dd_inst_proceso = @i_inst_proceso
                --and dd_cliente         = @i_cliente -- Se quita para que aparezcan todos los del tramite
                and dd_grupo        = @i_grupo
		        and dd_tipo_doc not in (select de_codigo from cob_credito..cr_documentos_excluidos where de_tabla = 'cr_doc_digitalizado_flujo_ind') --Sop.180604
        end
        else if @i_modo = 4--Clientes individuales Verificar y Digitalizar
        begin
		    
			select @w_tipo_doc = 0
            set @w_count = 0
			
			select @i_sin_huella_dactilar = eb_sin_huella_dactilar
			from cobis..cl_ente_bio 
			where eb_ente = @i_cliente            
                        
            while 1 = 1  begin
			
			   select top 1 @w_tipo_doc = codigo 
               from cobis..cl_catalogo where tabla = @w_catalogo_individuales
               and codigo > @w_tipo_doc
               and codigo not in ('004', '005')
               order by codigo asc
			   
			   if @@rowcount = 0 break
			
               print convert(varchar, @w_tipo_doc)
			   
			   --PorCaso#194473
			   if(@i_sin_huella_dactilar = 'N') begin
			       delete from cob_credito..cr_documento_digitalizado
				   where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso 
				   and dd_grupo = @i_grupo and dd_tipo_doc in ('009', '011')
			   end
			   
			   --if (@w_tipo_doc <> '009' ) or (@w_tipo_doc = '009' and @i_sin_huella_dactilar = 'S') begin
			   if (@w_tipo_doc not in ('009', '011')) or ((@w_tipo_doc in ('009', '011')) and @i_sin_huella_dactilar = 'S') begin --PorCaso#194473
			      print 'aaaa-1'
                  if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
                  begin
                     print 'aaaa-2'
					 insert into cob_credito..cr_documento_digitalizado
                     values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                     set @w_count = @w_count + 1
                  end
			   end

            end
            
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
            where dd_cliente         = @i_cliente
            and dd_inst_proceso = @i_inst_proceso
            and dd_grupo        = @i_grupo
            and dd_tipo_doc not in ('004', '005', '006', '007')
        end
        else if @i_modo = 5 --Encontrar los documentos del Aval Flujo Individual
        begin
            select @w_tipo_doc = 0
            set @w_count = 0
            
            select @w_aval_cre_ind=tr_alianza
            from  cob_workflow..wf_inst_proceso,cob_credito..cr_tramite 
            where io_id_inst_proc=@i_inst_proceso
            and io_campo_3=tr_tramite
            
            select @i_inst_proceso = 0 --Se reasigna a 0 porque estos documentos se tratan como persona natural
            
            select top 1 @w_tipo_doc = codigo 
            from cobis..cl_catalogo where tabla = @w_catalogo_individuales
            and codigo > @w_tipo_doc
            and codigo not in ('004', '005')    
            order by codigo ASC
            while @@rowcount > 0
            begin
               print convert(varchar, @w_tipo_doc)
               if (@w_tipo_doc not in ('004', '005'))
               begin
               if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @w_aval_cre_ind and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc)
                  begin
                     insert into cob_credito..cr_documento_digitalizado
                     values (@i_inst_proceso,@w_aval_cre_ind,@i_grupo,getdate(),@w_tipo_doc,'N',null)
                     set @w_count = @w_count + 1
                  end  
               end
               
               select top 1 @w_tipo_doc = codigo 
               from cobis..cl_catalogo 
               where tabla = @w_catalogo_individuales
               and codigo > @w_tipo_doc
               order by codigo asc
            end
              
            select
            'INSTANCIA_PROCESO' = dd_inst_proceso,
            'CLIENTE' = dd_cliente,
            'GRUPO' = dd_grupo,
            'FECHA_PROCESO' = dd_fecha,
            'TIPO_DOCUMENTO' = (select valor + ' / AVAL' from cobis..cl_catalogo where tabla = @w_catalogo_individuales and codigo = dd_tipo_doc),
            'CARGADO' = dd_cargado,
            'ID_DOCUMENTO' = dd_tipo_doc,
            'EXTENSION' = dd_extension
            from   cob_credito..cr_documento_digitalizado
            where dd_cliente 		= @w_aval_cre_ind
               and dd_inst_proceso = @i_inst_proceso
               and dd_grupo		= @i_grupo
               and dd_tipo_doc not in ('004', '005', '006', '007')
			   and dd_tipo_doc not in (select de_codigo from cob_credito..cr_documentos_excluidos where de_tabla = 'cr_doc_digitalizado_ind') --Sop.180604
        end		
		else if @i_modo = 6--Flujo colectivo   SRO 29/01/2020
        begin
	       
		   declare @w_catalogo_colectivo_doc table (
		      codigo      varchar(10),
			  valor       varchar(255)
		   )
		   
		   insert into @w_catalogo_colectivo_doc 
		   select codigo, valor 
		   from cobis..cl_catalogo 
		   where tabla = @w_catalogo_individuales
		   and  codigo not in ('004', '006','007')
		   
           select
           'INSTANCIA_PROCESO' = dd_inst_proceso,
           'CLIENTE'           = dd_cliente,
           'GRUPO'             = dd_grupo,
           'FECHA_PROCESO'     = dd_fecha,
           'TIPO_DOCUMENTO'    = valor,
           'CARGADO'           = dd_cargado,
           'ID_DOCUMENTO'      = dd_tipo_doc,
           'EXTENSION'         = dd_extension
            from cob_credito..cr_documento_digitalizado, @w_catalogo_colectivo_doc
            where dd_cliente   = @i_cliente
			and   dd_tipo_doc  = codigo

        end 
		/*else if @i_modo = 7--Flujo renovación   SRO 18/01/2021
        begin
	       
		   declare @w_t_catalogo_renovacion table (
		      secuencial  int identity (1,1),
		      codigo      varchar(10),
			  valor       varchar(255)
		   )
		   
		   insert into @w_t_catalogo_renovacion 
		   select codigo, valor 
		   from cobis..cl_catalogo 
		   where tabla = @w_catalogo_renovacion
		   
		   select @w_secuencial = 0
		   
		   while 1 = 1 begin
		   
		      select top 1 
			  @w_tipo_doc        = codigo,
			  @w_secuencial      = secuencial
			  from   @w_t_catalogo_renovacion 
			  where  secuencial  > @w_secuencial
			  order by secuencial asc
			  
			  if @@rowcount = 0 break
			  
			  if (@w_tipo_doc = '001' or @w_tipo_doc = '002') and not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_tipo_doc = @w_tipo_doc) begin
		         print '1.. codigo tipo doc:'+@w_tipo_doc
				 insert into cob_credito..cr_documento_digitalizado
                 values (0,@i_cliente,0,getdate(),@w_tipo_doc,'N',null)		  
			  end else if (@w_tipo_doc <> '001' and @w_tipo_doc <> '002')  and not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_cliente = @i_cliente and dd_inst_proceso = @i_inst_proceso and dd_grupo = @i_grupo and dd_tipo_doc = @w_tipo_doc) begin
		         print '2.. codigo tipo doc:'+@w_tipo_doc
				 insert into cob_credito..cr_documento_digitalizado
                 values (@i_inst_proceso,@i_cliente,@i_grupo,getdate(),@w_tipo_doc,'N',null)	
			  end
		   end
		   
           select
           'INSTANCIA_PROCESO'    = dd_inst_proceso,
           'CLIENTE'              = dd_cliente,
           'GRUPO'                = dd_grupo,
           'FECHA_PROCESO'        = dd_fecha,
           'TIPO_DOCUMENTO'       = valor,
           'CARGADO'              = dd_cargado,
           'ID_DOCUMENTO'         = dd_tipo_doc,
           'EXTENSION'            = dd_extension
            from cob_credito..cr_documento_digitalizado, @w_t_catalogo_renovacion
            where dd_cliente      = @i_cliente
			and   dd_inst_proceso = @i_inst_proceso
			and   dd_grupo        = @i_grupo
			and   dd_tipo_doc     = codigo
			union			
			select
           'INSTANCIA_PROCESO'    = dd_inst_proceso,
           'CLIENTE'              = dd_cliente,
           'GRUPO'                = dd_grupo,
           'FECHA_PROCESO'        = dd_fecha,
           'TIPO_DOCUMENTO'       = valor,
           'CARGADO'              = dd_cargado,
           'ID_DOCUMENTO'         = dd_tipo_doc,
           'EXTENSION'            = dd_extension
            from cob_credito..cr_documento_digitalizado, @w_t_catalogo_renovacion
            where dd_cliente      = @i_cliente
			and   dd_inst_proceso = 0
			and   dd_grupo        = 0
			and   dd_tipo_doc     = codigo
			and   dd_tipo_doc     in ('001', '002')

        end*/
	end  
          
end
go
