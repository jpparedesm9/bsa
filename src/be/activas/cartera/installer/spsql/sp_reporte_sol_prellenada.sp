/*************************************************************************/
/*   Archivo:              sp_reporte_sol_prellenada.sp                  */
/*   Stored procedure:     sp_reporte_sol_prellenada                     */
/*   Base de datos:        cobis                                         */
/*   Producto:             Credito                                       */
/*   Disenado por:         ACH                                           */
/*   Fecha de escritura:   01 Octubre 2021                               */
/*************************************************************************/
/*                           IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus usuarios    */
/*   sin el debido consentimiento por escrito de la Presidencia          */
/*   Ejecutiva de COBIS o su representante legal.                        */
/*************************************************************************/
/*                             PROPOSITO                                 */
/*   Genera informacion requerida para mostrar en reporte de Solicitud   */
/*   Individual Complementaria                                           */
/*************************************************************************/
/*                              CAMBIOS                                  */
/* 01/Oct/2021    ACH    Req#168878 - Solictud Prellenada                */
/* 04/Ene/2022    KVI    Error#175350 - Sol. Prellenada en Reimpresion   */
/* 15/Jun/2022    ALL    Req#184141 - Sol. Pre. dirección con nro's calle*/
/* 11/Ene/2023    KVI    Req.197007-B2B GrupPaperless F1-num_ext,num_int */
/* 14/Feb/2023    KVI    E.202746 - Modif. (-1) en num_ext,num_int Gr.   */
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_reporte_sol_prellenada' and type = 'P')
   drop proc sp_reporte_sol_prellenada
go

create proc sp_reporte_sol_prellenada(
    @s_ssn         int = null,
    @s_user        login = null,
    @s_sesn        int = null,
    @s_term        varchar(30) = null,
    @s_date        datetime = null,
    @s_srv         varchar(30) = null,
    @s_lsrv        varchar(30) = null,
    @s_rol         smallint = NULL,
    @s_ofi         smallint = NULL,
    @s_org_err     char(1) = NULL,
    @s_error       int = NULL,
    @s_sev         tinyint = NULL,
    @s_msg         descripcion = NULL,
    @s_org         char(1) = NULL,
    @t_debug       char(1) = 'N',
    @t_file        varchar(10) = null,
    @t_from        varchar(32) = null,
	@i_cliente     int,
	@i_es_grupo    char(1) = 'N',
	@i_es_renovacion   char(1) = 'N',
	@i_formato_fecha   int = 103,
	@i_modo        int,
	@i_operacion   char(1),
	@i_tramite     int
)
as
declare 
@w_error         int,
@w_return        int,
@w_mensaje       varchar(255),
@w_sp_name       varchar(30),
@w_msg           varchar(255),
@w_cod_est_civil int,
@w_cod_sexo      int,
@w_banco_anterior varchar(256),
@w_pie            varchar(256),
@w_condusef       varchar(256),
@w_funcionario_tx varchar(256) = '',--'NO EXISTE FUNCIONARIO',
@w_cargo_gerente  int,
@w_fecha_proceso  datetime


select @w_sp_name = 'sp_reporte_sol_prellenada'

select @w_cod_sexo = codigo from cobis..cl_tabla where tabla = 'cl_sexo'
select @w_cod_est_civil = codigo from cobis..cl_tabla where tabla = 'cl_ecivil'

--Se obtiene del sp_lcr_generar_candidatos
select @w_cargo_gerente = pa_smallint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CGEOFI'
and    pa_producto = 'CCA'

select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

if (@i_operacion = 'S')
begin
	
	if @i_cliente = 0 -- Error#175350
	begin 
	  select @i_cliente = io_campo_1,
	         @i_es_grupo = (case io_campo_4 when 'GRUPAL' then 'S' else 'N' end)
	  from cob_workflow..wf_inst_proceso
	  where io_campo_3 = @i_tramite
	  
	  print 'cliente: ' + convert(varchar(64),@i_cliente)
	  print 'esGrupo: ' + @i_es_grupo
	end --
	
	if(@i_es_renovacion = 'S') begin
	    select @w_pie = pa_char from cobis..cl_parametro where pa_nemonico = 'RSCRFP'
		select @w_condusef = pa_char from cobis..cl_parametro where pa_nemonico = 'RSCRFR'
	end
	else begin
	    select @w_pie = pa_char from cobis..cl_parametro where pa_nemonico = 'RSCGPI'
		select @w_condusef = pa_char from cobis..cl_parametro where pa_nemonico = 'RSCGRE'	
	end

	create table #clientes(
	    cliente int
	)
	
    if (@i_es_grupo = 'S') begin
        insert #clientes
		select cg_ente
    	from cl_cliente_grupo
    	where cg_grupo = @i_cliente
		and cg_estado = 'V'	
	end else begin
        insert #clientes
		select en_ente
    	from cl_ente
    	where en_ente = @i_cliente		
	end
	
    select 'ente' = en_ente,
           'oficina_id' = en_oficina,
		   'sucursal' = convert(varchar(256),''), -- (código y descripción de la oficina donde pertenece el cliente.)
           'importe_solicitado' = convert(varchar(256),''), -- (este dato saldrá en blanco)
           'fecha' = convert(varchar(10), @w_fecha_proceso, @i_formato_fecha), -- dd/mm/aa (fecha en la que se genere la solicitud prellenada)
           'apellido_paterno' = isnull(p_p_apellido,''),
           'apellid_materno' = isnull(p_s_apellido,''),
           'nombre' = isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,''),
           --direccion
    	   'cod_direccion' = convert(int,0), --
    	   'correo_electronico' = convert(varchar(256),''), --
           'fecha_nacimiento' = convert(varchar(10), p_fecha_nac, @i_formato_fecha), -- dd/mm/aa
           'direccion' = convert(varchar(256),''), -- (calle)
           'referencia_domicilio' = convert(varchar(256),''), --
		   'id_colonia' = convert(int,0),
           'colonia' = convert(varchar(256),''), -- (código y descripción)
           'id_municipio' = convert(int,0),
           'municipio_demarcacion_territorial' = convert(varchar(256),''), -- (código y descripción)
           'id_estado' = convert(int,0),
		   'estado' = convert(varchar(256),''), --
           'pais' = (select pa_descripcion from cl_pais where pa_pais = p_pais_emi),
           'codigo_postal' = convert(varchar(256),''), -- (código y descripción)
           'telefono_celular' = convert(varchar(256),''), --
    	   'num_credito_ant' = convert(varchar(256),''), --
		   'entidad_nacimiento_id' = p_depa_nac, -- (código y descripción)
    	   'entidad_nacimiento' = (select pv_descripcion from cl_provincia where pv_provincia = p_depa_nac),-- (código y descripción)
           'genero' = (select codigo from cl_catalogo where tabla = @w_cod_sexo and codigo = p_sexo), -- (femenino/masculino)
           'estado_civil' = (select codigo from cl_catalogo where tabla = @w_cod_est_civil and codigo = p_estado_civil), -- (casado, soltero, viudo, divorciado, unión libre)
	       'oficial' = en_oficial, --id nombre_asesor
		   'nombre_asesor' = convert(varchar(256), @w_funcionario_tx),-- Nombre Asesor
	       'nombre_coordinador' = convert(varchar(256),''), -- Nombre coordinador
		   'id_coordinador' = convert(int,0), -- Nombre coordinador,
		   'nombre_gerente' = convert(varchar(256), @w_funcionario_tx), -- Nombre gerente
		   'id_gerente' = convert(int,0), -- Nombre gerente			   
	       'nombre_analista' = convert(varchar(256), @w_funcionario_tx), -- Nombre analista		   
		   'id_analista' = convert(int,0), -- Nombre analista	
		   'nombre_grupo' = convert(varchar(256), ''), -- Nombre grupo		   
		   'nombre_director' = convert(varchar(256), ''), -- Nombre director
		   'nombre_subdirector' = convert(varchar(256), ''), -- Nombre subdirector
		   'num_ext' = convert(int,null), -- Numero Exterior --Req.197007
		   'num_int' = convert(int,null)  -- Numero Interior --Req.197007
    into #sol_prellenada
    from cl_ente, #clientes
    where en_ente = cliente

    select 'max_operacion' = max(op_operacion),
           'cliente_c' = op_cliente
	into #operacion_max
	from cob_cartera..ca_operacion, #sol_prellenada
	where op_cliente = ente
	and op_toperacion = 'GRUPAL'
	and op_anterior is not null -- validar
	group by op_cliente

    update #sol_prellenada
	set num_credito_ant = op_anterior
	from cob_cartera..ca_operacion, #operacion_max
	where op_cliente = cliente_c
	and cliente_c = ente
	and max_operacion = op_operacion
	
	--GRUPO DEL QUE FORMA PARTE
	update #sol_prellenada
	set nombre_grupo = (select gr_nombre from cobis..cl_grupo 
	where gr_grupo = (select cg_grupo from cobis..cl_cliente_grupo 
	where cg_ente = ente and cg_estado = 'V'))
	from #clientes
	where ente = cliente
	
	--NOMBRE DIRECTOR
	update #sol_prellenada
	set nombre_director = (select pa_char from cobis..cl_parametro where pa_nemonico = 'NRSPN2')
	from #clientes
	where ente = cliente
	
	--NOMBRE SUBDIRECTOR
	update #sol_prellenada
	set nombre_subdirector = (select pa_char from cobis..cl_parametro where pa_nemonico = 'NRSPN1')
	from #clientes
	where ente = cliente
		

--------ASESOR
	update #sol_prellenada
	set nombre_asesor = fu_nombre,
	    id_coordinador = fu_jefe
	from cobis..cc_oficial, 
         cobis..cl_funcionario
    where oc_oficial = oficial
    and oc_funcionario = fu_funcionario
    and isnull(oficial, 0) <> 0	
	
-------COORDINADOR
	update #sol_prellenada
	set nombre_coordinador = fu_nombre--, id_gerente = fu_jefe
	from cobis..cl_funcionario
    where fu_funcionario = id_coordinador
	and fu_funcionario > 0
	
-------GERENTE
    update #sol_prellenada
	set nombre_gerente = fu_nombre
	from cobis..cl_funcionario
    where fu_cargo = @w_cargo_gerente
	and fu_oficina = oficina_id
	and fu_estado	 = 'V'
	and fu_funcionario > 0

	/*update #sol_prellenada
	set nombre_gerente = fu_nombre
	from cobis..cl_funcionario
    where fu_funcionario = id_gerente*/
		   
    update #sol_prellenada
	set entidad_nacimiento_id = eq_valor_arch
    from cob_conta_super..sb_equivalencias A	
    where eq_catalogo   ='ENT_FED' --34 -- estado
    and eq_valor_cat = entidad_nacimiento_id

    update #sol_prellenada
    set sucursal = upper(of_nombre)
    from cobis..cl_oficina
    where of_oficina = oficina_id

    update #sol_prellenada
    set correo_electronico = di_descripcion          		  
    from cl_direccion
    where ente = di_ente
    and di_tipo = 'CE'
    
    update #sol_prellenada
    set cod_direccion = di_direccion,
        direccion = CASE 
            WHEN di_nro < 0
                and di_nro_interno >= 0
                then    di_calle + ', 0, ' + convert(varchar(10),di_nro_interno)
            WHEN di_nro >= 0
                and di_nro_interno < 0
                then    di_calle + ', ' + convert(varchar(10),di_nro) + ', 0'
            WHEN di_nro < 0
                and di_nro_interno < 0
                then    di_calle + ', 0, 0'
           ELSE    di_calle + ', ' + convert(VARCHAR(10),di_nro) + ', ' + convert(varchar(10),di_nro_interno)
        END,
        referencia_domicilio = di_referencia,
        id_colonia = di_parroquia,
		colonia = (select pq_descripcion from cl_parroquia where pq_parroquia = di_parroquia),
        id_municipio = di_ciudad,
		municipio_demarcacion_territorial = (select ci_descripcion from cl_ciudad where ci_ciudad = di_ciudad),
		id_estado = di_provincia,
        estado = (select pv_descripcion from cl_provincia where pv_provincia = di_provincia),
        codigo_postal = di_codpostal
    from cl_direccion
    where ente = di_ente
    and di_tipo = 'RE'
	
	if(@i_es_renovacion = 'N') --Req.197007
	begin
	   update #sol_prellenada
       set direccion = di_calle,
	       num_ext = case -- E.202746
		                 when di_nro < 0 then 0 
						 else di_nro
		             end,
		   num_int = case -- E.202746
		                 when di_nro_interno < 0 then 0 
						 else di_nro_interno
		             end
       from cl_direccion
       where ente = di_ente
       and di_tipo = 'RE'
	end
    
    update #sol_prellenada
    set telefono_celular = te_valor
    from cl_telefono 
    where te_ente = ente 
    and te_direccion = cod_direccion 
    and te_tipo_telefono = 'C'	
    	
    select sucursal                          = convert(varchar(20), isnull(oficina_id,'')) + ' - ' + upper(isnull(sucursal,'')),
           importe_solicitado,
           fecha,
           apellido_paterno                  = upper(isnull(apellido_paterno, '')),
           apellid_materno                   = upper(isnull(apellid_materno, '')),
           nombre                            = upper(isnull(nombre, '')),
    	   correo_electronico,
           fecha_nacimiento,
           direccion                         = upper(direccion),
           referencia_domicilio              = upper(isnull(referencia_domicilio,'')),
           colonia                           = convert(varchar(20), isnull(id_colonia,'')) + ' - ' + upper(isnull(colonia,'')),
           municipio_demarcacion_territorial = convert(varchar(20), isnull(id_municipio,'')) + ' - ' + upper(isnull(municipio_demarcacion_territorial,'')),
           estado                            = upper(estado),
           pais                              = upper(pais),
           codigo_postal,
           telefono_celular,
		   num_credito_ant,
    	   entidad_nacimiento                = convert(varchar(20), isnull(entidad_nacimiento_id, '')) + ' - ' + upper(isnull(entidad_nacimiento,'')),
           genero                            = upper(genero),
           estado_civil                      = upper(estado_civil),
		   nombre_asesor                     = upper(nombre_asesor),
		   nombre_coordinador                = upper(nombre_coordinador),
		   nombre_analista                   = upper(nombre_analista),
		   @w_pie,
		   @w_condusef,
		   nombre_gerente,
		   nombre_grupo,
		   nombre_director,
		   nombre_subdirector,
		   num_ext                          = isnull(convert(varchar(20), num_ext), ''), --Req.197007
		   num_int                          = isnull(convert(varchar(20), num_int), '')  --Req.197007
    from #sol_prellenada
	order by ente asc
end

return 0


ERROR:

exec @w_return = cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = @w_sp_name,
@i_num    = @w_error

return @w_error

go