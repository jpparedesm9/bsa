use cobis
GO
set ANSI_NULLS ON
GO
set QUOTED_IDENTIFIER OFF
GO
/*************************************************************************/
/*   ARCHIVO:         sp_traspaso.sp                                     */
/*   NOMBRE LOGICO:   sp_traspaso                                        */
/*   Base de datos:   cob_cartera                                        */
/*   PRODUCTO:        Cartera                                            */
/*   Fecha de escritura:   Junio 2018                                    */
/*************************************************************************/
/*                            IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                     PROPOSITO                                         */
/*  El sp permite realizar traspasos de clientes y grupos                */
/*************************************************************************/
/*                     MODIFICACIONES                                    */
/*   FECHA        AUTOR                      RAZON                       */
/* 27/Jun/2018   Estefania Ramirez   Emision inicial                     */
/* 30/Jul/2018   Paul Ortiz Vera     Correccion de fechas y orden        */
/* 06/Ago/2018   Paul Ortiz Vera     Correccion sp                       */
/* 07/May/2021   ACH                 Caso#158146 - Error se actualizaban */
/*                                   operaciones grupales por traspaso de*/
/*                                   cliente,cuando tenian el mismo codig*/
/* 21/Jul/2021   KVI                 Agregado filtro de colectivo        */
/* 05/Nov/2021   ACH                 ERR#171998 no es posible realizar el*/
/*                                   traspaso de cliente entre sucursales*/
/*************************************************************************/

if exists(select 1 from sysobjects where name = 'sp_traspaso')
    drop proc sp_traspaso
go

create proc sp_traspaso
@s_ssn                  int          = null,
@s_user                 login        = null,
@s_ofi                  int          = null,
@s_rol                  int          = null,
@s_date                 datetime     = null,
@s_term					varchar(30) = null,
@s_srv					varchar(30) = null,
@s_lsrv					varchar(30) = null,
@t_trn                  int          = null,
@t_debug                char(1)      = 'N',
@t_file                 varchar(10)  = null,
@i_es_grupo				char(1)		 = 'N',
@i_ofi_or				int			 = null,
@i_ofi_des				int			 = null,
@i_funcionario_or		login		 = null,
@i_funcionario_des		login		 = null,
@i_motivo				int			 = null,
@i_otro_motivo          varchar(50)  = null, 
@i_operacion                 char(1)      = null,
@i_cliente				int			 = null,
@i_solicitud			int			 = null,
@i_banco                cuenta       = null,
@i_clientes				varchar(255) = null,
@i_usuario				login        = null,
@i_es_origen			char		 = null,
@i_razon_rechazo        varchar(255) = null,
@i_ult_result			int		 	 = null,
@i_colectivo			varchar(10)	 = null--KVI 20210721
as

declare
@w_error                 int,
@w_sp_name               varchar(32),
@w_msg                   varchar(255),
@w_operacion             int,
@w_solicitud			 int,
@w_param_tdi			 smallint,
@w_param_tdf			 smallint,
@w_param_vgt			 smallint,
@w_rol					 int,
@w_usuario				 int,
@w_clientes				 varchar(255),
@w_cliente				 varchar(6),
@w_flag					 bit,
@w_tamano				 smallint,
@w_siguiente			 int, 
@w_es_grupo			     char(1), 
@w_ente					 int,
@w_oficial_org			 int,
@w_oficial_des			 int,
@w_oficina_des			 int,
@w_fecha_ini             datetime,
@w_fecha_fin             datetime,
@w_codigo                int,
@w_correo                varchar(64),
@w_usuario_niega         int,
@w_fecha_proceso         datetime,
@w_hora_proceso          datetime,
@w_superior              int,
@w_est_vigente           int,
@w_est_vencida           int,
@w_est_novigente         int,
@w_est_cancelado         int,
@w_est_credito           int,
@w_param_ing_sol         varchar(30),
@w_param_apli_cuest_gr   varchar(30),
@w_param_cap_firm_doc     varchar(30),
@w_grupo                 int,
@w_tramite               int,
@w_id_inst_proc          int,
@w_cod_catalogo          INT,
@w_oficial               int


select @w_sp_name = 'sp_traspaso'

if @t_debug = 'S' print '@i_operacion  ' +  cast(@i_operacion  as varchar)

-- PARAMETROS DE FECHA
select @w_param_tdi = pa_smallint
from   cobis..cl_parametro
where  pa_nemonico = 'TDI'
and    pa_producto = 'CLI'

if @@rowcount = 0 
begin
   select @w_error = 108008
   goto ERROR
end

-- PARAMETRO INGRESAR SOLICITUD
select @w_param_ing_sol = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'ETINGR'

if @@rowcount = 0 
begin
   select @w_error = 103192
   goto ERROR
end

-- PARAMETRO APLICAR CUESTIONARIO - GRUPAL
select @w_param_apli_cuest_gr = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'ETACGR'

if @@rowcount = 0 
begin
   select @w_error = 103193
   goto ERROR
end

--CAPTURAR FIRMAS Y DOCUMENTOS
select @w_param_cap_firm_doc = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ETACFD'

if @@rowcount = 0 
begin
   select @w_error = 103195
   goto ERROR
end

select @w_param_tdf = pa_smallint
from   cobis..cl_parametro
where  pa_nemonico = 'TDF'
and    pa_producto = 'CLI'

if @@rowcount = 0 
begin
   select @w_error = 108009
   goto ERROR
end

select @w_param_vgt = pa_smallint
from   cobis..cl_parametro
where  pa_nemonico = 'VGT'
and    pa_producto = 'CLI'



exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente   = @w_est_vigente out,
@o_est_vencido   = @w_est_vencida out,
@o_est_novigente = @w_est_novigente out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_credito   = @w_est_credito out

if @w_error <> 0 
begin
   goto ERROR
end

select @w_usuario = oc_oficial
from cl_funcionario, cc_oficial
where oc_funcionario = fu_funcionario
and fu_login = @i_usuario

select @w_rol = ro_rol from cobis..ad_rol	
where ro_descripcion = 'MESA DE OPERACIONES'

/* Fecha Proceso*/
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

/* Se crean estructuras temprales requeridas */
create table #grupos(
	grupo int
)
create table #clientes(
	ente int
)
create table #tramites(
   tramite   int
)
create table #oficiales_tmp(
   ot_oficial     int primary key,
   ot_nombre      varchar(255),
   ot_usuario     login,
   ot_estado      estado,
   ot_oficina     smallint,
   ot_superior    int
)

--SRO. Tabla temporal operaciones hijas
create table #operaciones_hijas_tmp(
   oht_operacion     int,
   oht_monto         money,
   oht_atraso        int,
   oht_tramite_pd    int,
   oht_grupo         int
)

-- CONSULTA DE DATOS DE CLIENTES Y OPERACIONES
if @i_operacion = 'Q' --Consulta de clientes y Grupos para solicitudes
begin
	
	if(@w_usuario is null)
	begin
		select @w_usuario = oc_oficial
		from cl_funcionario, cc_oficial
		where oc_funcionario = fu_funcionario
		and fu_login = convert(varchar,@i_funcionario_or)
	end

	if @i_es_grupo = 'N'
	begin
		
		select @w_rol = ur_rol from ad_usuario_rol 
		where ur_login = @s_user
		
		select @w_cod_catalogo = (select codigo from cobis..cl_tabla where tabla = 'cl_estados_ente')
		
		select 
		cs_ente as ente
		into #cliente 		
		from cl_solicitud_traspaso, cl_cli_sol_traspaso 
		where cs_solicitud = st_solicitud
		and st_estado = 'V'
		and st_es_grupo = 'N'
		
		insert into #cliente
		select cg_ente from cobis..cl_cliente_grupo where cg_estado = 'V'
		
		select valor as valor, codigo as codigo
		into #estados
		from cobis..cl_catalogo 
		where tabla = @w_cod_catalogo

        select  @w_oficial   = oc_oficial 
		from cobis..cc_oficial, cobis..cl_funcionario
		where oc_funcionario = fu_funcionario
		and   fu_login       = @i_funcionario_or
		
		if @@rowcount = 0 begin
		   select @w_error = 151091
		   goto ERROR
		end
		
		set rowcount 100
		
        select 	
        'codigo'		= en_ente, 
        'nombre'		= en_nomlar,
        'fechaCrea' 	= convert(varchar,en_fecha_crea,103), 
        'fechaMod'		= convert(varchar,en_fecha_mod,103), 
        'estado' 		= (select valor from #estados WHERE codigo = ea_estado ), 
        'ciclo'			= en_nro_ciclo,
        'montoCre'      = 0.0,
        'semanasAtra'   = ''
        from cobis..cl_ente en, cobis..cl_ente_aux
        where en_ente  = ea_ente
        and en_oficial = @w_oficial
        and (@i_colectivo is null or (@i_colectivo is not null and ea_colectivo = @i_colectivo))--KVI 20210721
        and en_ente not in (select ente from #cliente)
        and en_ente > @i_ult_result
        order by en_ente, en_nomlar
		
	end
	else
	begin 
		select 	'codigo'		= gr_grupo, 
				'nombre' 		= gr_nombre,
				'fechaCrea'		= gr_fecha_registro,
				'fechaMod'		= gr_fecha_modificacion, 
				'p_activos'		= 'N', 
				's_activas'		= 'N', 
				'ciclo'			= gr_num_ciclo,
				'montoCre'      = convert(money,0.0),
				'semanasAtra'   = convert(varchar(64),'')
		into #gruposSolicitud
		from cobis..cl_grupo
		where gr_oficial = @w_usuario
		and gr_grupo > @i_ult_result
		
		--print convert(varchar, @w_usuario)
		
		delete #gruposSolicitud
		from cl_solicitud_traspaso, cl_cli_sol_traspaso 
		where cs_solicitud = st_solicitud
		and st_estado = 'V'
		and st_es_grupo = 'S'
		and cs_ente = codigo
	
		--SRO.Monto y días de atraso operaciones hijas
		insert into #operaciones_hijas_tmp
		select 
		op_operacion,
		op_monto,
		isnull(datediff(ww,(select min(di_fecha_ven) from cob_cartera..ca_dividendo 
		                    where di_operacion = op_operacion
		                    and di_estado = @w_est_vencida),@w_fecha_proceso),0),
		tg_tramite,
		tg_grupo		
		from cob_cartera..ca_operacion, 
        cob_credito..cr_tramite_grupal,
		#gruposSolicitud
        where op_cliente      = tg_cliente     
        and   op_operacion    = tg_operacion
        and   tg_grupo        = codigo
        and   op_estado  not in (@w_est_novigente, @w_est_cancelado, @w_est_credito)

        --SRO. Actualización monto y días de atraso grupos 
		update #gruposSolicitud
		set p_activos    = 'S',
		    montoCre     = isnull((select sum(isnull(oht_monto,0)) from #operaciones_hijas_tmp where oht_grupo = codigo),0),
			semanasAtra  = isnull((select max(isnull(oht_atraso,0)) from #operaciones_hijas_tmp where oht_grupo = codigo),0)
	
		
		update #gruposSolicitud
		set s_activas = 'S'
		from cob_workflow..wf_inst_proceso
		where io_campo_1 = codigo
		and   io_campo_7 = 'S'
		and   io_estado  = 'EJE'
		
		select  'codigo'		= codigo, 
				'nombre' 		= nombre,
				'fechaCrea'		= convert(varchar,fechaCrea,103),
				'fechaMod'		= convert(varchar,fechaMod,103), 
				'estado'		= case 
									when p_activos = 'S' and s_activas = 'S' then 'Grupo dispersado con solicitud' 
									when p_activos = 'S' and s_activas = 'N' then 'Grupo dispersado' 
									when p_activos = 'N' and s_activas = 'S' then 'Grupo con solicitud' 
									when p_activos = 'N' and s_activas = 'N' then 'Grupo' 
								  end, 
				'ciclo'			= ciclo,
				'montoCre'      = montoCre,
				'semanasAtra'   = (case when semanasAtra = '' or semanasAtra is null then semanasAtra
		                             else semanasAtra + ' semanas' end)
		from #gruposSolicitud
		
	end
end
if @i_operacion = 'I' --Ingreso de Solicitudes
begin
begin tran

	exec sp_cseqnos
			@i_tabla =	   'cl_solicitud_traspaso', 
			@o_siguiente 		= @w_siguiente out
	
	select @w_fecha_ini = convert(datetime,(convert(varchar,@w_fecha_proceso,101) + ' ' + convert(varchar,datepart(hh, getdate())) + ':00:00'))
	select @w_fecha_fin = dateadd(hh, @w_param_vgt, @w_fecha_ini)
	
	while @w_flag = 0
	begin
	  begin TRY
		set @w_cliente = RIGHT(LEFT(@w_clientes,CHARINDEX(',', @w_clientes,1)-1),CHARINDEX(',', @w_clientes,1)-1)
		set @w_tamano = LEN(@w_cliente) 
 		set @w_clientes = SUBSTRING(@w_clientes,@w_tamano + 2, LEN(@w_clientes)) 
		
		if(@i_es_grupo = 'S')
		begin
			if not(DAY(@w_fecha_proceso) between @w_param_tdi and @w_param_tdf)
			begin
				
				if exists (select 1 from cob_workflow..wf_inst_proceso, cob_cartera..ca_operacion
							where op_tramite = io_campo_3
							and io_estado = 'TER'
							and io_id_inst_proc = (select max(io_id_inst_proc) from cob_workflow..wf_inst_proceso where io_campo_1 = @w_cliente and io_campo_7 = 'S')
							and op_estado = 1
							and op_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_cliente))
				begin
					select @w_error = 108010
					goto ERROR
				end
			end
		end
		else
		begin
			if not(DAY(@w_fecha_proceso) between @w_param_tdi and @w_param_tdf)
			begin
				
				if exists (select 1 from cob_workflow..wf_inst_proceso, cob_cartera..ca_operacion
							where op_tramite = io_campo_3
							and io_estado = 'TER'
							and io_id_inst_proc = (select max(io_id_inst_proc) from cob_workflow..wf_inst_proceso 
								where io_campo_1 = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = @w_cliente) and io_campo_7 = 'S')
							and op_estado = 1
							and op_cliente = @w_cliente)
				begin
					select @w_error = 108010
					goto ERROR
				end
			end
		end
		
	  END TRY
	  begin CATCH 
		
		if(@i_es_grupo = 'S')
		begin
			if not(DAY(@w_fecha_proceso) between @w_param_tdi and @w_param_tdf)
			begin
				
				if exists (select 1 from cob_workflow..wf_inst_proceso, cob_cartera..ca_operacion
							where op_tramite = io_campo_3
							and io_estado = 'TER'
							and io_id_inst_proc = (select max(io_id_inst_proc) from cob_workflow..wf_inst_proceso where io_campo_1 = @w_cliente and io_campo_7 = 'S')
							and op_estado = 1
							and op_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_cliente))
				begin
					select @w_error = 108010
					goto ERROR
				end
			end
		end
		else
		begin
			if not(DAY(@w_fecha_proceso) between @w_param_tdi and @w_param_tdf)
			begin
				
				if exists (select 1 from cob_workflow..wf_inst_proceso, cob_cartera..ca_operacion
							where op_tramite = io_campo_3
							and io_estado = 'TER'
							and io_id_inst_proc = (select max(io_id_inst_proc) from cob_workflow..wf_inst_proceso 
								where io_campo_1 = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = @w_cliente) and io_campo_7 = 'S')
							and op_estado = 1
							and op_cliente = @w_cliente)
				begin
					select @w_error = 108010
					goto ERROR
				end
			end
		end
		
		set @w_flag = 1
	  END CATCH 
	end
	
	
	
	
	insert into cl_solicitud_traspaso (st_solicitud, st_es_grupo, 
		st_fun_origen, st_fun_destino, st_usuario, st_motivo_tras, 
		st_otro_motivo, st_fecha, st_hora, st_estado, st_ofi_origen,
		st_ofi_destino, st_usuario_rol)
	values(@w_siguiente, @i_es_grupo, 
		@i_funcionario_or, @i_funcionario_des, @s_user, @i_motivo, 
		@i_otro_motivo, @w_fecha_ini, @w_fecha_fin, 'V', @i_ofi_or,
		@i_ofi_des, @s_rol)
	
	select @w_clientes = @i_clientes, @w_flag = 0
 
	while @w_flag = 0
	begin
	  begin TRY
		set @w_cliente = RIGHT(LEFT(@w_clientes,CHARINDEX(',', @w_clientes,1)-1),CHARINDEX(',', @w_clientes,1)-1)
		set @w_tamano = LEN(@w_cliente) 
 		set @w_clientes = SUBSTRING(@w_clientes,@w_tamano + 2, LEN(@w_clientes)) 
		insert into cl_cli_sol_traspaso (cs_solicitud, cs_ente)
		values (@w_siguiente, @w_cliente)
	  END TRY
	  begin CATCH 
		insert into cl_cli_sol_traspaso (cs_solicitud, cs_ente)
		values (@w_siguiente, @w_clientes)
		set @w_flag = 1
	  END CATCH 
	end
commit tran
end
if @i_operacion = 'M' --Consulta de Clientes/Grupos de solicitudes
begin
	
	select @i_es_grupo = st_es_grupo from cl_solicitud_traspaso where st_solicitud = @i_solicitud
	
	if(@i_es_grupo = 'N')
	begin
		select 	'codigo' 	= cs_ente,
				'nombre' 	= upper(isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') 
    	                                    + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')),
		   		'tipo' 	 	= (select valor from cobis..cl_catalogo where ea_estado = codigo
									and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estados_ente'))
		from cobis..cl_cli_sol_traspaso, cobis..cl_solicitud_traspaso, cobis..cl_ente, cobis..cl_ente_aux
		where en_ente = cs_ente
		and   ea_ente = en_ente
		and   st_solicitud = cs_solicitud
		and   cs_solicitud = @i_solicitud
		
	end
	else
	begin
		select 	'codigo' = cs_ente,
				'nombre' = gr_nombre,
		   		'tipo' 	 = 'Grupo'
		from cobis..cl_cli_sol_traspaso, cobis..cl_solicitud_traspaso, cobis..cl_grupo
		where gr_grupo = cs_ente
		and   st_solicitud = cs_solicitud
		and   cs_solicitud = @i_solicitud
	end
	
	if @@rowcount = 0 
	begin
	   select @w_error = 108012
	   goto ERROR
	end
end
if @i_operacion = 'R' --Eliminacion de solicitudes
begin
	begin tran
	
	update cl_solicitud_traspaso
    set st_razon_rechazo = @i_razon_rechazo,
    st_estado = 'R'     --estado Rechazado
    where st_solicitud = @i_solicitud
	
	if @@error <> 0
    begin
     select @w_error = 357006 --ERROR AL ELIMINAR REGISTRO!
     goto ERROR
    end
    
    exec @w_error = cobis..sp_cseqnos
    @t_debug     = 'N',
    @t_file      = null,
    @t_from      = @w_sp_name,
    @i_tabla     = 'cl_ns_traspaso',
    @o_siguiente = @w_codigo out
    
    if @w_error <> 0
    begin
        select @w_error = 2101007 --NO EXISTE TABLA EN TABLA DE SECUENCIALES
        goto ERROR
    end

    if exists (select 1 from cobis..cl_ns_traspaso 
    			where nt_codigo = @w_codigo)
    begin
    	select @w_error = 70129 --ERROR AL INSERTAR REGISTRO! 
         goto ERROR
    end
    
	--SRO. se modifica por usuarios operativos, no se encuentran en la cc_oficial
    select 	@w_usuario 			= fu_funcionario,
    		@w_correo           = mf_descripcion
    from cobis..cl_solicitud_traspaso 
	inner join cobis..cl_funcionario
	on st_usuario = fu_login
	left join cobis..cl_medios_funcio on fu_funcionario = mf_funcionario
   	where st_solicitud = @i_solicitud
  
	
	if @@rowcount = 0 begin
	   select @w_usuario_niega 	= fu_funcionario
       from  cobis..cl_funcionario
       where fu_login = @s_user	   
	end 
    
    select @w_usuario_niega 	= fu_funcionario
    from  cobis..cl_funcionario
    where fu_login = @s_user

    
    insert into cobis..cl_ns_traspaso(
    		nt_codigo,             nt_traspaso_id,            nt_oficial,             nt_oficial_niega,
    		nt_correo,             nt_estado)
    values( @w_codigo,             @i_solicitud,              @w_usuario,             @w_usuario_niega,
    		@w_correo,             'P') --Estado Pendiente 
    if @@error <> 0
    begin 
        select @w_error = 70129 --ERROR AL INSERTAR REGISTRO! 
        goto ERROR
    end
    
    commit tran
end
if @i_operacion = 'A' --Aprobacion de solicitudes
begin 
	select @w_es_grupo = st_es_grupo,
	@w_oficial_des     = fu_funcionario,
	@i_funcionario_or  = st_fun_origen,
	@i_funcionario_des = st_fun_destino
	from cl_solicitud_traspaso, cl_funcionario
	where fu_login = st_fun_destino
	and st_solicitud = @i_solicitud
	
	/* Oficial Origen*/
	select @w_oficial_org = fu_funcionario
	from cl_solicitud_traspaso, cl_funcionario
	where fu_login = st_fun_origen 
	and st_solicitud = @i_solicitud
	
	/* Oficina Destino*/
	select @w_oficina_des = fu_oficina
	from cl_solicitud_traspaso, cl_funcionario
	where fu_login = st_fun_destino
	and st_solicitud = @i_solicitud
	
	if @w_es_grupo = 'S' --Grupos
	begin
		
		--Consulta si la fecha actual se encuentra dentro del intervalo para realizar traspasos
	    if not(DAY(@w_fecha_proceso) between @w_param_tdi and @w_param_tdf) begin
			
			if exists (select 1 from cob_cartera..ca_operacion 
						where op_cliente in (select cg_ente 
						                     from cl_cliente_grupo 
						                     where  cg_estado = 'V'
						                     and    cg_grupo in (select cs_ente 
														         from cobis..cl_cli_sol_traspaso 
														         where cs_solicitud = @i_solicitud))
					and   op_estado in (select es_codigo from cob_cartera..ca_estado where es_procesa = 'S')) begin
				select @w_error = 108010
				goto ERROR
			end
		end
		
		insert into #grupos
	    select cs_ente 
	    from cl_cli_sol_traspaso 
	    where cs_solicitud = @i_solicitud
	    
	    insert into #clientes
	    select cg_ente from cobis..cl_cliente_grupo, #grupos
	    where cg_grupo = grupo
		and   cg_estado = 'V'
---------------------------------	    
	    /*insert into #tramites
	    select tr_tramite
	    from #grupos g, cob_credito..cr_tramite, cob_cartera..ca_operacion -- caso##158146
	    where grupo = tr_cliente
	    and tr_tramite = op_tramite
	    and op_estado <> @w_est_cancelado
	    and tr_estado  not in ('X', 'Z')
	    and tr_tramite in (select distinct(tg_tramite) from cob_credito..cr_tramite_grupal where tg_grupo = g.grupo)
	    and tr_grupal  = 'S'*/
---------------------------------
        --Obtener tramites padres, donde las operaciones hijas no se hayan cancelado.
        insert into #tramites
        select distinct (tg_tramite)
        from #grupos, cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
        where op_operacion = tg_operacion
        and tg_grupo = grupo
        and op_estado <> @w_est_cancelado		
		
		--Se elimina los tramites que fueron cancelados
		delete #tramites
		from cob_credito..cr_tramite
		where tramite = tr_tramite
		and tr_estado in ('X', 'Z')
		
	begin tran
		
        update cobis..cl_grupo 
	    set gr_oficial = @w_oficial_des,
		    gr_sucursal = @w_oficina_des
		from #grupos
		where gr_grupo = grupo

	    update cobis..cl_cliente_grupo 
	    set cg_usuario = @i_funcionario_des,
		    cg_oficial = @w_oficial_des
		from #grupos, #clientes
		where cg_grupo = grupo
		and cg_ente = ente
		
	    update cobis..cl_ente 
		set en_oficial = @w_oficial_des,
			c_funcionario = @i_funcionario_des,
			en_oficina = @w_oficina_des
		from #clientes
		where en_ente = ente
		
        update cob_credito..cr_tramite
	    set tr_oficina = isnull(@w_oficina_des,0),
		    tr_oficial = isnull(@w_oficial_des,0)
		from #tramites
	    where tr_tramite = tramite
	   		 
		--- ACTUALIZACION OFICINA Y OFICIAL EN OPERACION PADRE
		update cob_cartera..ca_operacion
		set op_oficina = isnull(@w_oficina_des,0),
		    op_oficial = isnull(@w_oficial_des,0)
		from #tramites
	    where op_tramite = tramite
	   
	    update cl_solicitud_traspaso 
	    set st_estado = 'A'
	    where st_solicitud = @i_solicitud
	    and st_fun_origen = @i_funcionario_or
	    and st_fun_destino = @i_funcionario_des 
	   		
		select @w_ente = 0
		
	    while 1 = 1 begin
	        select top 1 @w_ente = ente 
		    from #clientes
			where ente > @w_ente
	        order by ente asc
			
			if @@rowcount = 0
				break
			
			exec @w_error = cob_credito..sp_traslada_tramite
			@i_operacion            = 'F',    
			@i_cliente           	= @w_ente,   
			@i_oficina_destino   	= @w_oficina_des,
			@i_oficial_origen   	= @w_oficial_org,
			@i_oficial_destino   	= @w_oficial_des,
			@i_es_grupo             = @w_es_grupo
			
			if @w_error <> 0
			begin
				goto ERROR
			end
			
			exec @w_error = cob_cartera..sp_traslada_cartera
			@i_operacion         = 'I',
		    @i_cliente           = @w_ente,   
		    @i_oficina_destino   = @w_oficina_des,
		    @i_oficial_destino   = @w_oficial_des,
		    @i_en_linea          = 'S',
		    @s_user              = @s_user,
		    @s_term              = @s_term,
		    @s_date              = @s_date,
		    @s_ofi               = @s_ofi,
			@i_es_grupo          = @w_es_grupo
		    
			
			if @w_error <> 0
			begin
				goto ERROR
			end

		end
		
	   --SRO. INICIA SINCRONIZACION
	   select @w_grupo = 0
		
	   while 1=1 begin		
          select top 1 @w_grupo = grupo
          from #grupos
          where grupo > @w_grupo
          order by grupo asc
          
          if @@rowcount = 0 break
          
          exec @w_error = cobis..sp_xml_grupos
          @s_user       = @s_user,
          @i_grupo     = @w_grupo,
          @i_operacion = 'E'
          
          IF @w_error <> 0 BEGIN
             GOTO ERROR
          end         
           		   
       end
		
	   select @w_tramite = 0
		
	   while 1 = 1 begin
		
	      select top 1 @w_tramite = tramite
	      from #tramites
	      where tramite > @w_tramite
	      order by tramite asc
	      
		  if @@rowcount = 0 break 
		  
	      select @w_id_inst_proc = io_id_inst_proc 
	      from cob_workflow..wf_inst_proceso, cob_workflow..wf_inst_actividad 
	      where io_id_inst_proc = ia_id_inst_proc
	      and io_campo_3    = @w_tramite
	      and ia_nombre_act = @w_param_ing_sol
	      and ia_estado     in ('INA', 'ACT')
	      and ia_tipo_dest  is null
	       
	      if @@rowcount > 0 begin
		
	         exec @w_error = cob_credito..sp_grupal_xml	        
             @i_inst_proc  = @w_id_inst_proc 
             IF @w_error <> 0 BEGIN
               GOTO ERROR
             end

	      end
          
          
          if exists (select 1 
		             from cob_workflow..wf_inst_proceso, cob_workflow..wf_inst_actividad 
		             where io_id_inst_proc = ia_id_inst_proc
					 and io_campo_3 = @w_tramite
					 and ia_nombre_act = @w_param_apli_cuest_gr
					 and ia_estado = 'ACT'
					 and ia_tipo_dest is null) begin

             exec @w_error = cob_credito..sp_actividad_sincroniza
		     @i_operacion        = 'I',
		     @i_tramite          = @w_tramite,
		     @i_nombre_actividad = @w_param_apli_cuest_gr,
		     @i_sincroniza       = 'S'
		     
		     IF @w_error <> 0 BEGIN
               GOTO ERROR
             end

		  end
		
	   end 
       --SRO. FINALIZA SINCRONIZACION
		commit tran
	end 
	
   if @w_es_grupo = 'N' begin--Personas
   
		begin tran	
	
		if not(DAY(@w_fecha_proceso) between @w_param_tdi and @w_param_tdf)
		begin
			
			if exists (select 1 from cob_cartera..ca_operacion
						where op_cliente in (select cs_ente from cobis..cl_cli_sol_traspaso 
											where cs_solicitud = @i_solicitud)
      				and   op_estado in (1,2)) begin
				select @w_error = 108010
				goto ERROR
			end
		end
		
		if exists(select * from cobis..cl_cliente_grupo where cg_estado = 'V'
      				and cg_ente in (select cs_ente from cl_cli_sol_traspaso	where cs_solicitud = @i_solicitud)) begin
			select @w_error = 108013
				goto ERROR
		end
		
      update cobis..cl_ente 
	  set en_oficial = @w_oficial_des,
          c_funcionario = @i_funcionario_des,
		  en_oficina = @w_oficina_des
      where en_ente in (select cs_ente
		from cl_cli_sol_traspaso
		where cs_solicitud = @i_solicitud)
		
      update cl_solicitud_traspaso set 
	  st_estado = 'A'
		where st_solicitud = @i_solicitud
		and st_fun_origen = @i_funcionario_or
		and st_fun_destino = @i_funcionario_des
		
	  --SRO. INICIA SINCRONIZACION
	  select @w_cliente = 0
		
	  while 1 = 1 begin
	     
	     select top 1 @w_cliente = cs_ente
         from cl_cli_sol_traspaso
         where cs_solicitud = @i_solicitud
		 and   cs_ente      > @w_cliente 
		 order by cs_ente asc
		 
		 if @@rowcount = 0 break
		 
		 
         exec @w_error = cob_sincroniza..sp_sinc_arch_xml
         @i_param1  = 'Q',
         @i_param2  = 0,
         @i_param3  = 1,
         @i_param4 = @w_cliente
		 
		 if @w_error <> 0 begin
		    goto ERROR
		 end
		 
		 exec @w_error = cob_credito..sp_traslada_tramite
	     @i_operacion           = 'F',    
	     @i_cliente           	= @w_cliente,   
	     @i_oficina_destino   	= @w_oficina_des,
	     @i_oficial_origen   	= @w_oficial_org,
	     @i_oficial_destino   	= @w_oficial_des,
         @i_es_grupo            = @w_es_grupo
	     
	     if @w_error <> 0
	     begin
	     	goto ERROR
	     end
		 
		 exec @w_error = cob_cartera..sp_traslada_cartera
	     @i_operacion         = 'I',
	     @i_cliente           = @w_cliente,   
	     @i_oficina_destino   = @w_oficina_des,
	     @i_oficial_destino   = @w_oficial_des,
	     @i_en_linea          = 'S',
	     @s_user              = @s_user,
	     @s_term              = @s_term,
	     @s_date              = @s_date,
	     @s_ofi               = @s_ofi,
         @i_es_grupo          = @w_es_grupo
	        	      
	     if @w_error <> 0
	     begin
	     	goto ERROR
	     end
		  
		 select @w_id_inst_proc = io_id_inst_proc 
		 from cob_workflow..wf_inst_proceso,
		 cob_workflow..wf_inst_actividad
		 where io_id_inst_proc = ia_id_inst_proc
		 and   io_campo_1      = @w_cliente
		 and   io_campo_4      = 'REVOLVENTE'
		 and   io_campo_7      <> 'S'
		 and   io_estado       = 'EJE'
		 and   ia_nombre_act   = @w_param_cap_firm_doc
		 and   ia_estado       = 'ACT'

         if @@rowcount > 0 begin
		    exec @w_error = cob_credito..sp_xml_documentos_lcr
			@i_inst_proc = @w_id_inst_proc
			
			if @w_error <> 0 begin
		       goto ERROR
		    end	
		 end 		 
	  end
	  --SRO. FINALIZA SINCRONIZACION

	   	commit tran
	   
	end 
end


if ((@i_operacion = 'O') or (@i_operacion = 'F') or (@i_operacion = 'S'))--Consulta de oficinas
begin
	
	select @w_superior = oc_oficial,
	       @w_usuario  = oc_oficial
	from cl_funcionario, cc_oficial
	where oc_funcionario = fu_funcionario
	and fu_login = @s_user
	
	declare @oficiales table(
		nombre		varchar(255),
		estados     estado,
		oficina     smallint,
		usuario     login
	) 
	
	/* Inserta oficial actual solo si no es consulta */
	if(@i_operacion <> 'S')
	begin
		insert into #oficiales_tmp
		select 	oc_oficial,
				fu_nombre + ' - ' + (select valor from cl_catalogo where fu_estado = codigo
				                  and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estado_ser')),
				fu_login,
				fu_estado,
				fu_oficina,          
			    fu_jefe 
		from  cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_catalogo
		where  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, 1)
		and  oc_funcionario   = fu_funcionario
		and  codigo           = oc_tipo_oficial
		and  fu_login = @s_user
		and  tabla = (select codigo
		             from cobis..cl_tabla
		            where tabla = 'cc_tipo_oficial')   
		order by fu_funcionario desc
	end
	
	/* Insertar Jerarquia */
	insert into #oficiales_tmp
	select 	oc_oficial,
			fu_nombre + ' - ' + (select valor from cl_catalogo where fu_estado = codigo
			                  and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estado_ser')),
			fu_login,
			fu_estado,
			fu_oficina,          
		    @w_superior 
	from  cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_catalogo
	where  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, 1)
	and  (oc_ofi_nsuperior = @w_superior)
	and  oc_funcionario   = fu_funcionario
	and  codigo           = oc_tipo_oficial
	and  tabla = (select codigo
	             from cobis..cl_tabla
	            where tabla = 'cc_tipo_oficial')   
	order by fu_funcionario desc
	
	while exists ( select  1
	      from  cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_catalogo
	      where  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, 1)
	      and  oc_funcionario   = fu_funcionario
	      and  codigo           = oc_tipo_oficial
	      and  tabla = (select codigo
	                     from cobis..cl_tabla
	                    where tabla = 'cc_tipo_oficial')  
	      and oc_ofi_nsuperior in (select ot_oficial from #oficiales_tmp)
	      and oc_oficial not in (select ot_oficial from #oficiales_tmp))
	begin
	   
		insert into #oficiales_tmp
		select  
		oc_oficial,
		fu_nombre + ' - ' + (select valor from cl_catalogo where fu_estado = codigo
		                  and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estado_ser')),
		fu_login,
		fu_estado,
		fu_oficina,          
		         oc_ofi_nsuperior 
		from  cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_catalogo
		where  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, 1)
		and  oc_funcionario   = fu_funcionario
		and  codigo           = oc_tipo_oficial
		and  tabla = (select codigo
		             from cobis..cl_tabla
		            where tabla = 'cc_tipo_oficial')  
		and oc_ofi_nsuperior in (select ot_oficial from #oficiales_tmp)
		and oc_oficial not in (select ot_oficial from #oficiales_tmp) 
		          order by fu_funcionario desc
	end
	
	
	if @i_operacion = 'O' 
	begin
		
		if @s_rol = @w_rol --Mesa de operaciones
		begin
			select distinct 
					'idOfi'		= fu_oficina,
					'nombreOfi'	= valor 
			from cobis..cl_funcionario fu, cobis..cl_catalogo ca, cobis..cl_tabla ta
			where  ta.tabla = 'cl_oficina'
			and ta.codigo = ca.tabla 
			and ca.codigo = fu.fu_oficina
		end
		else
		begin
			select distinct 
					'idOfi'	= ot_oficina,  
					'nombreOfi'	= valor
			from #oficiales_tmp, cobis..cl_catalogo ca, cobis..cl_tabla ta
			where  ta.tabla = 'cl_oficina'
			and ta.codigo = ca.tabla 
			and ca.codigo = ot_oficina
		end
		
	end
	
	if @i_operacion = 'F' --Consulta de oficiales por oficina
	begin 
		
		if @s_rol = @w_rol --Mesa de operaciones
		begin
			if @i_es_origen = 'S'
			begin
				select 	'nombre'	= fu_nombre + ' - ' + valor,
						'estado'	= fu_estado, 
						'oficina'	= fu_oficina,
						'usuario'	= fu_login
				from cobis..cl_funcionario, cc_oficial, cobis..cl_catalogo
				where fu_funcionario = oc_funcionario 
				and fu_estado = codigo
				and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estado_ser')
				and fu_oficina = @i_ofi_or --cambia en middleware
				order by fu_nombre asc
			end
			else if @i_es_origen = 'N'
			begin
			--print '2...@i_ofi_or: '+ convert(varchar,@i_ofi_or)
				select 	'nombre'	= fu_nombre + ' - ' + valor,
						'estado'	= fu_estado, 
						'oficina'	= fu_oficina,
						'usuario'	= fu_login
				from cobis..cl_funcionario, cc_oficial, cobis..cl_catalogo, cobis..ad_usuario_rol, cobis..ad_rol
				where fu_funcionario = oc_funcionario 
				and fu_estado = codigo
				and fu_login = ur_login
				and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estado_ser')
				and fu_estado = 'V'
				and fu_oficina = @i_ofi_or --cambia en middleware
				and fu_login = ur_login	
				and ur_rol = ro_rol
				and ro_descripcion = 'ASESOR'				
				order by fu_nombre asc
			end
		end
		else
		begin
			if @i_es_origen = 'S'
			begin
				select 	'nombre'	= ot_nombre,
						'estado'	= ot_estado,
						'oficina'	= ot_oficina,
						'usuario'	= ot_usuario
				from #oficiales_tmp 
				where ot_oficina = @i_ofi_or
				and ot_oficina = @i_ofi_or 
				order by ot_nombre asc
			end
			else if @i_es_origen = 'N'
			begin
				select 	'nombre'	= fu_nombre + ' - ' + valor,
						'estado'	= fu_estado, 
						'oficina'	= fu_oficina,
						'usuario'	= fu_login
				from cobis..cl_funcionario, cc_oficial, cobis..cl_catalogo, cobis..ad_usuario_rol, cobis..ad_rol
				where fu_oficina = @i_ofi_or
				and fu_funcionario = oc_funcionario 
				and fu_estado = codigo
				and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estado_ser')
				and fu_estado = 'V'
				and fu_login = ur_login	
				and ur_rol = ro_rol
				and ro_descripcion = 'ASESOR'
				order by fu_nombre asc
			end
		end
	end 
	if @i_operacion = 'S' --Consulta de solicitudes
	begin
		
		select @w_hora_proceso = convert(datetime,(convert(varchar,@w_fecha_proceso,101) + ' ' + convert(varchar,datepart(hh, getdate())) + ':00:00'))
		
		if exists(select * from cobis..cl_solicitud_traspaso 
					where (datediff(hh, @w_hora_proceso, st_hora)) <= 0)
		begin
			update cl_solicitud_traspaso
		    set st_razon_rechazo = 'Tiempo de espera excedido',
		    st_estado = 'C'     --estado Rechazado
		    where (datediff(hh, @w_hora_proceso, st_hora)) <= 0
			and   st_estado not in ('A','R')
		end
		
		if @s_rol = @w_rol --Mesa de operaciones
		begin
			select 	'solicitud'		= st_solicitud,
				'nombreOfi'		= fu_nombre,
				'rolDesc'		= ro_descripcion,
				'tipoCust'		= (case st_es_grupo when 'N' then 'Prospecto/Cliente' else 'Grupo' end), 
				'fechaIni' 		= st_fecha,
				'fechaFin' 		= st_hora,--st_hora,
				'ofiOrigen' 	= (select distinct valor + ' - ' + fu_nombre from cobis..cl_catalogo, cobis..cl_funcionario where fu_login = st_fun_origen
									and codigo = fu_oficina	and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_oficina')),
				'ofiDestino' 	= (select distinct valor + ' - ' + fu_nombre from cobis..cl_catalogo, cobis..cl_funcionario where fu_login = st_fun_destino
									and codigo = fu_oficina	and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_oficina')),
				'razonTras'		= (select (case valor when '7' then valor + '-' + st_otro_motivo else valor end) 
									from cobis..cl_catalogo where codigo = st_motivo_tras
									and tabla = (select codigo from cobis..cl_tabla where tabla = 'cr_motivo_traspaso'))
			from cl_solicitud_traspaso, cl_funcionario, ad_rol
			where fu_login  = st_usuario
			and st_usuario_rol = ro_rol
			and st_estado = 'V'
			and st_ofi_origen = @i_ofi_or
			order by st_solicitud
		end
		else
		begin
			select 	'solicitud'		= st_solicitud,
				'nombreOfi'		= fu_nombre,
				'rolDesc'		= ro_descripcion,
				'tipoCust'		= (case st_es_grupo when 'N' then 'Prospecto/Cliente' else 'Grupo' end), 
				'fechaIni' 		= st_fecha,
				'fechaFin' 		= st_hora,--st_hora,
				'ofiOrigen' 	= (select distinct valor + ' - ' + fu_nombre from cobis..cl_catalogo, cobis..cl_funcionario where fu_login = st_fun_origen
									and codigo = fu_oficina	and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_oficina')),
				'ofiDestino' 	= (select distinct valor + ' - ' + fu_nombre from cobis..cl_catalogo, cobis..cl_funcionario where fu_login = st_fun_destino
									and codigo = fu_oficina	and tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_oficina')),
				'razonTras'		= (select (case valor when '7' then valor + '-' + st_otro_motivo else valor end) 
									from cobis..cl_catalogo where codigo = st_motivo_tras
									and tabla = (select codigo from cobis..cl_tabla where tabla = 'cr_motivo_traspaso'))
			from cl_solicitud_traspaso, cl_funcionario, ad_rol, #oficiales_tmp, cc_oficial
			where fu_login  = st_usuario
			and st_usuario_rol = ro_rol
			and st_estado = 'V'
			and st_ofi_origen = @i_ofi_or
			and fu_funcionario = oc_funcionario
			and oc_oficial = ot_oficial
			order by st_solicitud
		end
	
		/*if @@rowcount = 0 
		begin
		   select @w_error = 108012
		   goto ERROR
		end*/
		
	end
end

return 0

ERROR:

exec cobis..sp_cerror
@t_debug  = @t_debug,
@t_file   = @t_file,
@t_from   = @w_sp_name,
@i_num    = @w_error,
@i_msg    = @w_msg

return 1

go