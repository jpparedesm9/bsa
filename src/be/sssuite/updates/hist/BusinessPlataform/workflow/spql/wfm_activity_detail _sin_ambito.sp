use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_activity_detail')
begin
  drop procedure sp_activity_detail
end
go

/************************************************************/
/*   ARCHIVO:         wfm_activity_detail.sp                 */
/*   NOMBRE LOGICO:   sp_activity_detail                    */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*   Consulta:                                              */
/*   Los resumenes de informacion generada en el motor y    */
/*   editor de WF para el monitor.                          */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA        AUTOR               RAZON                 */
/*   02-Oct-2000  Andres A. Vilenas.  Emision Inicial.      */
/************************************************************/

declare @w_table_code int

select @w_table_code = codigo from cobis..cl_tabla where tabla='cl_regional'

IF isnull(@w_table_code, 0) >0
begin 

exec('
create procedure sp_activity_detail
(
  @s_ssn                int,
  @s_user               varchar(30),
  @s_sesn               int,
  @s_term               varchar(30),
  @s_date               datetime,
  @s_srv                varchar(30),
  @s_lsrv               varchar(30),
  @s_ofi                smallint,
  @t_debug              char(1)     = ' + '''' + 'N' + '''' + ',
  @t_file               varchar(14) = null,
  @t_from               varchar(30) = null,
  @t_trn                int,
  -- Input parameters
  @i_operation          char        = ' + '''' + 'C' + '''' + ',
  @i_type               varchar(30) = null,
  @i_codigo_proceso     int         = null,
  @i_version_proceso    int         = null,
  @i_codigo_actividad   int         = null,
  @i_date_indicator     char(8)     = ' + '''' + '99999999' + '''' + ',
  @i_active             char (1)    = ' + '''' + 'S' + '''' + ',
  @i_login              varchar(30) = null,
  @i_use_date_range     char(1)     = ' + '''' + 'N' + '''' + ',
  @i_start_date         datetime    = null,
  @i_end_date           datetime    = null,
  @i_oficina            varchar(100) = null
  
)
As declare
  @w_sp_name            varchar(32), 
  @w_position           numeric(20),
  @w_piece              varchar(50),
  @w_table_code         int 
  
select @w_sp_name = ' + '''' + 'sp_process_detail' + '''' + '

--Recupera el codigo de la tabla cl_regional
select @w_table_code = codigo from cobis..cl_tabla where tabla= ' + '''' + 'cl_regional' + '''' + '

--Cracion de tabla temporal
CREATE TABLE #office_table(
   id_office int
)

--Split de cadena
if @i_oficina is not null
begin
    SET    @w_position = charindex(' + '''' + ',' + '''' + ' , @i_oficina)
    while  @w_position <> 0
    begin 
        SET @w_piece = LEFT(@i_oficina, @w_position-1)

        insert into #office_table values (cast(@w_piece as int)) 

        SET @i_oficina = stuff(@i_oficina, 1, @w_position, NULL)
        SET @w_position = charindex(' + '''' + ',' + '''' + ', @i_oficina)
    end
    if @i_oficina <> ' + '''' + '' + '''' + '
    begin
        declare @w_office_id int
		select @w_office_id = cast(@i_oficina as int)
		
		if @w_office_id is not null
		begin
		     insert into #office_table values (@w_office_id)
		end
	end
end

-- Si la operacion es de consulta.
if @i_operation = ' + '''' + 'C' + '''' + '
begin
    if @i_date_indicator = ' + '''' + '99999999' + '''' + ' 
    begin
        if @i_type = ' + '''' + 'ACTIVITIES' + '''' + ' 
        begin   
		        print ' + '''' + ' Activity Detail - 1' + '''' + '
                select distinct
                ia_codigo_act, 
                ia_nombre_act,
                q1.aTiempo,
                q2.retrasadas,
                ' + '''' + 'c' + '''' + ' = null,
                 0 repetidas,
                --(count(distinct(ia_id_inst_act)) - (count(distinct(ia_id_inst_proc)) * count(distinct(pa_codigo_actividad))))
                r.codigo codigo_regional, 
                r.valor  nombre_regional, 
                o.of_oficina codigo_oficina, 
                o.of_nombre nombre_oficina
                from   wf_inst_actividad ia
                inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
				wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
				wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia         
				from wf_actividad_proc  where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                inner join (select wf_paso.pa_id_paso, wf_paso.pa_codigo_proceso, wf_paso.pa_version_proceso, wf_paso.pa_codigo_actividad, wf_paso.pa_tipo_paso, 
				wf_paso.pa_posicion_x, wf_paso.pa_posicion_y, wf_paso.pa_ancho, wf_paso.pa_alto, wf_paso.pa_automatico, wf_paso.pa_id_programa_tiempo_estandar from wf_paso   where pa_codigo_proceso=@i_codigo_proceso and pa_version_proceso=@i_version_proceso) pa on pa.pa_codigo_actividad = ia.ia_codigo_act
                inner join (select wf_destinatario.de_codigo_actividad, wf_destinatario.de_codigo_proceso, wf_destinatario.de_version_proceso, wf_destinatario.de_id_destinatario, 
				wf_destinatario.de_id_rol_destinatario, wf_destinatario.de_tipo_destinatario, wf_destinatario.de_tipo_distribucion_carga, wf_destinatario.de_codigo_dist_carga, 
				wf_destinatario.de_tipo_oficina_dist_carga, wf_destinatario.de_requiere_usr_log, wf_destinatario.de_version_subpr, wf_destinatario.de_rol_cobis   from wf_destinatario    where de_codigo_proceso=@i_codigo_proceso and de_version_proceso=@i_version_proceso) de on de.de_codigo_actividad = ia.ia_codigo_act
                inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
				cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                             
				from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                left  join (
                    select ia.ia_codigo_act codigo_actividad, r.codigo codigo_regional, o.of_oficina codigo_oficina, count(1) aTiempo
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
					cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type         
					from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and ia_fecha_fin is null
					and isnull(ia.ia_tipo_dest, ' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '
                    and datediff(minute, ia_fecha_inicio, getdate())  - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			    ) <= ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, r.codigo, o.of_oficina
                )   q1 on ia.ia_codigo_act = q1.codigo_actividad and r.codigo=q1.codigo_regional and o.of_oficina = q1.codigo_oficina  
                left  join (
                    select ia.ia_codigo_act codigo_actividad, r.codigo codigo_regional, o.of_oficina codigo_oficina, count(1) retrasadas
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                      from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type  from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and o.of_oficina in (select id_office from #office_table)
                    and ia_fecha_fin is null
					and isnull(ia.ia_tipo_dest,' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '
                    and datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			    ) > ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, r.codigo, o.of_oficina
                )   q2 on ia.ia_codigo_act = q2.codigo_actividad and r.codigo=q2.codigo_regional and o.of_oficina = q2.codigo_oficina  

                where  io.io_codigo_proc  =  @i_codigo_proceso
                and io.io_version_proc =  @i_version_proceso
                and o.of_oficina in (select id_office from #office_table)
                and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                and de.de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ',' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', '+ '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ia.ia_fecha_fin is null
                order by r.valor, o.of_nombre, ia_id_paso
            print ' + '''' + 'Salida Exitosa para consulta de actividades' + '''' + '
            
            return 0
        end
        else if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'S' + '''' + '
        begin
            print ' + '''' + ' Activity Detail - 2' + '''' + '		
            select
                -- Tiempo promedio para una actividad determinada
                (select avg(datediff(minute, ia_fecha_inicio, getdate())- (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ' , ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU'+ '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo maximo para aun actividad determinada
                (select max(datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end 
        if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
        begin
		    print ' + '''' + ' Activity Detail - 3' + '''' + ' 
            select
                -- Tiempo promedio para una actividad determinada
                (select avg(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ',' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and (inst_actividad.ia_fecha_fin is not null or (inst_actividad.ia_fecha_fin is null and  isnull(inst_actividad.ia_tipo_dest, ' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
				and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo maximo para aun actividad determinada
                (select max(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and (inst_actividad.ia_fecha_fin is not null or (inst_actividad.ia_fecha_fin is null and  isnull(inst_actividad.ia_tipo_dest,' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end
        else if @i_type = ' + '''' + 'USERSUMMARY' + '''' + '
        begin
		    print ' + '''' + ' Activity Detail - 4' + '''' + '
            select
            -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(datediff(minute, ia_fecha_inicio, getdate())- (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= a.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    ))
                from wf_inst_actividad a, wf_inst_proceso ip, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                where ia_id_inst_proc = io_id_inst_proc
                and ia_fecha_fin is null  
                and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '				
                and aa_id_inst_act = ia_id_inst_act
                and fu_login = us_login
                and aa_id_destinatario = us_id_usuario
                and io_codigo_proc = @i_codigo_proceso
                and ia_codigo_act = @i_codigo_actividad
                and ar_codigo_actividad = ia_codigo_act
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc
                and io_version_proc = @i_version_proceso
                and fu_login = @i_login
                and io_oficina_inicio  in (select id_office from #office_table)
                group by fu_login, fu_nombre),
                (select max(datediff(minute, ia_fecha_inicio, getdate())- (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= a.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    ))
                from wf_inst_actividad a, wf_inst_proceso ip, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                where ia_id_inst_proc = io_id_inst_proc
                and ia_fecha_fin is null  
                and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '				
                and aa_id_inst_act = ia_id_inst_act
                and fu_login = us_login
                and aa_id_destinatario = us_id_usuario
                and io_codigo_proc = @i_codigo_proceso
                and ia_codigo_act = @i_codigo_actividad
                and ar_codigo_actividad = ia_codigo_act
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc
                and io_version_proc = @i_version_proceso
                and fu_login = @i_login
                and io_oficina_inicio  in (select id_office from #office_table)
                group by fu_login, fu_nombre),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso  
                and ar_version_proceso = @i_version_proceso
                )                
        end
        else        
        begin
		    print ' + '''' + ' Activity Detail - 5 - Revisar' + '''' + '
            select
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(a.b) from 
                    (select datediff(minute, ia_fecha_inicio, getdate()) - (select count(1)*1440 from cobis..cl_dias_feriados df 
                                                                            inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
                                                                            where df_fecha >= ia.ia_fecha_inicio 
                                                                            and df_fecha<= getdate() 
                                                                            and of_oficina = ip.io_oficina_inicio) as b
                    from wf_inst_actividad ia, wf_actividad_proc, wf_inst_proceso ip
                    where ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = @i_codigo_proceso
                    and ar_version_proceso = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad 
                    and ia_fecha_fin is null
				    and ia_id_inst_proc = io_id_inst_proc) as a),
                -- El tiempo maximo para un proceso determinado
                (select max(a.b) from 
                (select datediff(minute, ia_fecha_inicio, getdate()) - (select count(1)*1440 from cobis..cl_dias_feriados df 
                                                                       inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
                                                                       where df_fecha >= ia.ia_fecha_inicio 
                                                                       and df_fecha<= getdate() 
                                                                       and of_oficina = ip.io_oficina_inicio) as b
                from wf_inst_actividad ia, wf_actividad_proc, wf_inst_proceso ip
                where ar_codigo_actividad = ia_codigo_act
                and ar_codigo_proceso = @i_codigo_proceso
                and ar_version_proceso = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad 
                and ia_fecha_fin is null
				and ia_id_inst_proc = io_id_inst_proc) as a),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso
                )

            select fu_login, fu_nombre, count(1), r.codigo codigo_regional, r.valor  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_asig_actividad aa 
            inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
            inner join wf_inst_proceso   io on ia.ia_id_inst_proc = io.io_id_inst_proc
            inner join wf_usuario        us on us.us_id_usuario = aa.aa_id_destinatario
            inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
			wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida,
			wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                             from wf_actividad_proc where ar_codigo_proceso = @i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
			cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                             
			from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            where io.io_codigo_proc = @i_codigo_proceso 
            and   io.io_version_proc = @i_version_proceso
            and   ia.ia_codigo_act = @i_codigo_actividad
            and   o.of_oficina in (select id_office from #office_table)
            and ia_fecha_fin is null 
            and datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = io.io_oficina_inicio
			    ) <= ar_tiempo_estandar
            group by fu.fu_login, fu.fu_nombre,r.codigo , r.valor , o.of_oficina , o.of_nombre 
            
            select fu_login, fu_nombre, count(1), r.codigo codigo_regional, r.valor  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_asig_actividad aa 
            inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
            inner join wf_inst_proceso   io on ia.ia_id_inst_proc = io.io_id_inst_proc
            inner join wf_usuario        us on us.us_id_usuario = aa.aa_id_destinatario
            inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                             from wf_actividad_proc where ar_codigo_proceso = @i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                             from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            where io.io_codigo_proc = @i_codigo_proceso 
            and   io.io_version_proc = @i_version_proceso
            and   ia.ia_codigo_act = @i_codigo_actividad
            and   o.of_oficina in (select id_office from #office_table)
            and ia_fecha_fin is null 
            and datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = io.io_oficina_inicio
			    ) > ar_tiempo_estandar
            group by fu.fu_login, fu.fu_nombre,r.codigo , r.valor , o.of_oficina , o.of_nombre       

        end
    end
    else
    begin
        if @i_type = ' + '''' + 'ACTIVITIES' + '''' + '
        begin
            if @i_active = ' + '''' + 'S' + '''' + '
            begin
			    print ' + '''' + ' Activity Detail - 6' + '''' + '
                select distinct
                ia_codigo_act, 
                ia_nombre_act,
                q1.aTiempo,
                q2.retrasadas,
                ' + '''' + 'c' + '''' + ' = null,
                 0 repetidas,
                --(count(distinct(ia_id_inst_act)) - (count(distinct(ia_id_inst_proc)) * count(distinct(pa_codigo_actividad))))
                r.codigo codigo_regional, 
                r.valor  nombre_regional, 
                o.of_oficina codigo_oficina, 
                o.of_nombre nombre_oficina
                from   wf_inst_actividad ia
                inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia         from wf_actividad_proc  where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                inner join (select wf_paso.pa_id_paso, wf_paso.pa_codigo_proceso, wf_paso.pa_version_proceso, wf_paso.pa_codigo_actividad, wf_paso.pa_tipo_paso, wf_paso.pa_posicion_x, wf_paso.pa_posicion_y, wf_paso.pa_ancho, wf_paso.pa_alto, wf_paso.pa_automatico, wf_paso.pa_id_programa_tiempo_estandar                                                                                    from wf_paso            where pa_codigo_proceso=@i_codigo_proceso and pa_version_proceso=@i_version_proceso) pa on pa.pa_codigo_actividad = ia.ia_codigo_act
                inner join (select wf_destinatario.de_codigo_actividad, wf_destinatario.de_codigo_proceso, wf_destinatario.de_version_proceso, wf_destinatario.de_id_destinatario, wf_destinatario.de_id_rol_destinatario, wf_destinatario.de_tipo_destinatario, wf_destinatario.de_tipo_distribucion_carga, wf_destinatario.de_codigo_dist_carga, wf_destinatario.de_tipo_oficina_dist_carga, wf_destinatario.de_requiere_usr_log, wf_destinatario.de_version_subpr, wf_destinatario.de_rol_cobis                                    from wf_destinatario    where de_codigo_proceso=@i_codigo_proceso and de_version_proceso=@i_version_proceso) de on de.de_codigo_actividad = ia.ia_codigo_act
                inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                             from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                left  join (
                    select ia.ia_codigo_act codigo_actividad, r.codigo codigo_regional, o.of_oficina codigo_oficina, count(1) aTiempo
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                                   from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type         from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and (ia_fecha_fin is not null or (ia_fecha_fin is null and ia_tipo_dest = ' + '''' + 'PRO' + '''' + ')) -- Y.Pacheco
                    and datediff(minute, ia_fecha_inicio,  isnull(ia_fecha_fin,ia_fecha_inicio))- (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= isnull(ia.ia_fecha_fin,ia.ia_fecha_inicio) and ofi.of_oficina = o.of_oficina
			   ) <= ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, r.codigo, o.of_oficina
                )   q1 on ia.ia_codigo_act = q1.codigo_actividad and r.codigo=q1.codigo_regional and o.of_oficina = q1.codigo_oficina  
                left  join (
                    select ia.ia_codigo_act codigo_actividad, r.codigo codigo_regional, o.of_oficina codigo_oficina, count(1) retrasadas
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                                                                        from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                        from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and (ia_fecha_fin is not null or (ia_fecha_fin is null and ia_tipo_dest = ' + '''' + 'PRO' + '''' + ')) -- Y.Pacheco
                    and datediff(minute, ia_fecha_inicio,  isnull(ia_fecha_fin,ia_fecha_inicio))- (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= isnull(ia.ia_fecha_fin,ia.ia_fecha_inicio) and ofi.of_oficina = o.of_oficina
			    ) > ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, r.codigo, o.of_oficina
                )   q2 on ia.ia_codigo_act = q2.codigo_actividad and r.codigo=q2.codigo_regional and o.of_oficina = q2.codigo_oficina  

                where  io.io_codigo_proc  =  @i_codigo_proceso
                and io.io_version_proc =  @i_version_proceso
                and de.de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ' , ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                and (ia_fecha_fin is not null or (ia_fecha_fin is null and ia_tipo_dest = ' + '''' + 'PRO' + '''' + ')) -- Y.Pacheco
                order by r.valor, o.of_nombre, ia_id_paso  
                
            end
            else
            begin
			    print ' + '''' + ' Activity Detail - 7' + '''' + '
                select q1.codigo_actividad, 
                       q1.nombre_actividad, 
                       q1.sum_a_tiempo - isnull(q2.a_tiempo ,0) aTiempo,  
                       q1.sum_retrasadas - isnull(q3.retrasadas ,0) atrasadas,
                       (q1.sum_tiempo_real / ( q1.sum_tiempo_real + q1.sum_retrasadas)),
                       0,
                       q1.codigo_regional, 
                       q1.nombre_regional, 
                       q1.codigo_oficina, 
                       q1.nombre_oficina
                from (
                    select 
                    ac_codigo_actividad codigo_actividad,
                    ac_nombre_actividad nombre_actividad,
                    r.codigo codigo_regional, 
                    r.valor  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina,
                    sum(da_num_a_tiempo)   sum_a_tiempo,
                    sum(da_num_retrasadas) sum_retrasadas,
                    sum(da_tiempo_real)    sum_tiempo_real,
                    sum(da_num_retrasadas + da_num_a_tiempo) sum_retrasadas_a_tiempo
                    from wf_r_actividades_proc da 
                    inner join wf_actividad ac on da.da_codigo_actividad = ac.ac_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = da.da_oficina
					inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
					cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type  from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
					where da_codigo_proceso   = @i_codigo_proceso 
                    and   da_version_proceso  = @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and   da_fecha <> ' + '''' + '99999999' + '''' + '
                    group by ac_codigo_actividad, ac_nombre_actividad, r.codigo, r.valor, o.of_oficina, o.of_nombre
                ) q1 left join (   
                    select 
                    ia_codigo_act codigo_actividad,
                    r.codigo codigo_regional, 
                    o.of_oficina codigo_oficina, 
                    count(1) a_tiempo
                    from wf_inst_actividad ia
                    inner join wf_inst_proceso io on ia.ia_id_inst_proc = io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia     
					from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
                    inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
					cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                 
					from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    where io.io_codigo_proc  = @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso 
                    and o.of_oficina in (select id_office from #office_table)
                    and ia.ia_fecha_fin is not null
                    and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = o.of_oficina
			    )  <= ar.ar_tiempo_estandar
                    and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                    and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    group by ia_codigo_act, r.codigo , o.of_oficina
                )   q2 on q1.codigo_actividad=q2.codigo_actividad and q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina = q2.codigo_oficina
                left join (
                    select 
                    ia_codigo_act codigo_actividad,
                    r.codigo codigo_regional, 
                    o.of_oficina codigo_oficina, 
                    count(1) retrasadas
                    from wf_inst_actividad ia
                    inner join wf_inst_proceso io on ia.ia_id_inst_proc = io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                       from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
                    inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
					cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                            
					from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    where io.io_codigo_proc  = @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso 
                    and   o.of_oficina in (select id_office from #office_table)
                    and ia.ia_fecha_fin is not null
                    and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = o.of_oficina
			    ) > ar.ar_tiempo_estandar
                    and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                    and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    group by ia_codigo_act, r.codigo , o.of_oficina
                )   q3 on q1.codigo_actividad=q3.codigo_actividad and q1.codigo_regional = q3.codigo_regional and q1.codigo_oficina = q3.codigo_oficina
            end
        end
        else if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
        begin
		    print ' + '''' + ' Activity Detail - 8 - Revisar' + '''' + '
            select
                -- Resumen para tacometro
                -- Tiempo promedio para una actividad determinada
                (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                from wf_r_actividades_proc
                where da_codigo_proceso = @i_codigo_proceso 
                and da_version_proceso = @i_version_proceso 
                and da_codigo_actividad = @i_codigo_actividad  
                and da_fecha <> ' + '''' + '99999999' + '''' + '
                ),
                -- El tiempo maximo para una actividad determinada
                (select max(da_tiempo_max) 
                from wf_r_actividades_proc 
                where da_codigo_proceso = @i_codigo_proceso 
                and da_version_proceso = @i_version_proceso 
                and da_codigo_actividad = @i_codigo_actividad 
                and da_fecha <> ' + '''' + '99999999' + '''' + '),
                -- El tiempo estandar para una actividad determinada
                (select ar_tiempo_estandar 
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end
        else if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'S' + '''' + '
        begin
		    print ' + '''' + 'Activity Detail - 9' + '''' + '
            select
                -- Tiempo promedio para una actividad determinada
                (select avg(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) ) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso io, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ia_estado = ' + '''' + 'COM' + '''' + '
                and io_estado <> ' + '''' + 'TER' + '''' + '
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is not null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo maximo para aun actividad determinada
                (select max(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso io, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ia_estado = ' + '''' + 'COM' + '''' + '
                and io_estado <> ' + '''' + 'TER' + '''' + '
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is not null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end
        else if @i_use_date_range = ' + '''' + 'N' + '''' + '
        begin
            if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
            begin
			    print ' + '''' + 'Activity Detail - 10 - Revisar' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    ),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)
            end
            else if @i_type = ' + '''' + 'USERSUMMARY' + '''' + '
            begin 
                -- Resumen    
                if @i_active = ' + '''' + 'S' + '''' + '
                begin
				    print ' + '''' + ' Activity Detail - 11' + '''' + ' 
                    select
                    (select avg(datediff(minute, ia_fecha_inicio, ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ))
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)
                    ),
                    (select max(datediff(minute, ia_fecha_inicio, ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) )
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)
                    ),
                    -- El tiempo estandar para una actividad determinada
                    (select max(ar_tiempo_estandar)
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso  
                    and ar_version_proceso = @i_version_proceso
                    )
                end
                else
                begin
				    print ' + '''' + ' Activity Detail - 12 - Revisar' + '''' + '
                    select 
                    (
                    ((select sum(du_tiempo_real) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') -
                (select isnull(sum(datediff(minute, ia_fecha_inicio, ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) ), 0)
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                    and io_codigo_proc = @i_codigo_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    and fu_login = @i_login))
                    /((select sum(du_num_a_tiempo + du_num_retrasada) 
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') - 
                    (select count(1)
                    from wf_inst_actividad a, wf_inst_proceso, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                    and io_codigo_proc = @i_codigo_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    and fu_login = @i_login))
                    ),
                    (
                    select max(du_tiempo_max) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + '
                    ),
                    (select ar_tiempo_estandar  -- Tiempo est´
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso
                    )
                end
            end
            else
            begin
			    print ' + '''' + ' Activity Detail - 13 - Revisar' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)

                
                
                if @i_active = ' + '''' + 'S' + '''' + '
                begin
				    print ' + '''' + ' Activity Detail - 14' + '''' + '
                    select 
                    fu_login, 
                    fu_nombre,            
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) <= ar_tiempo_estandar then 1 else 0 end), 
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) > ar_tiempo_estandar then 1 else 0 end),
                    count(1),
                    r.codigo codigo_regional, 
                    r.valor  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina             
                    from 
                    wf_asig_actividad aa 
                    inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                    inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
					cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                                                  from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                              from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                    inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                    where  io_codigo_proc = @i_codigo_proceso  
                    and io_version_proc = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and o.of_oficina in (select id_office from #office_table)
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
					and datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) <= ar_tiempo_estandar
                    group by  fu_login, fu_nombre, r.codigo, r.valor, o.of_oficina, o.of_nombre  
					
					select 
                    fu_login, 
                    fu_nombre,            
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) <= ar_tiempo_estandar then 1 else 0 end), 
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) > ar_tiempo_estandar then 1 else 0 end),
                    count(1),
                    r.codigo codigo_regional, 
                    r.valor  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina             
                    from 
                    wf_asig_actividad aa 
                    inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                    inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
					cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                                                  from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                              from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                    inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                    where  io_codigo_proc = @i_codigo_proceso  
                    and io_version_proc = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and o.of_oficina in (select id_office from #office_table)
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
					and datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) > ar_tiempo_estandar
                    group by  fu_login, fu_nombre, r.codigo, r.valor, o.of_oficina, o.of_nombre  
                end
                else
                begin
				    print ' + '''' + ' Activity Detail - 15' + '''' + '
                     select 
                    q1.login,
                    q1.usuario,
                    q1.sumATiempo - isnull(q2.a_tiempo,0) a_tiempo,
                    q1.sumAtrsadas - isnull(q3.atrasadas,0) atrasadas,
                    q1.sumTiempoReal / (q1.sumATiempo + q1.sumAtrsadas) promedio,
                    q1.codigo_regional, 
                    q1.nombre_regional, 
                    q1.codigo_oficina, 
                    q1.nombre_oficina
                    from (
                        select 
                        fu_login login, 
                        fu_nombre usuario,
                        r.codigo codigo_regional, 
                        r.valor  nombre_regional, 
                        o.of_oficina codigo_oficina, 
                        o.of_nombre nombre_oficina,
                        sum(du_num_a_tiempo) sumATiempo,
                        sum(du_num_retrasada) sumAtrsadas,
                        sum(du_tiempo_real)   sumTiempoReal
                        from
                        wf_r_asignacion_act du 
                        inner join wf_usuario us on us.us_id_usuario = du.du_id_usuario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        inner join cobis..cl_oficina o on o.of_oficina = du.du_oficina
                        inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
						cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                         from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                        where  du_codigo_proceso= @i_codigo_proceso  
                        and du_version_proceso = @i_version_proceso
                        and du_codigo_actividad = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and du_fecha <> ' + '''' + '99999999' + '''' + '
                        group by fu_login, fu_nombre, r.codigo, r.valor, o.of_oficina, o.of_nombre
                    ) q1 
                    left join (
                        select 
                        fu_login login,          
                        count(1) a_tiempo,
                        r.codigo codigo_regional, 
                        o.of_oficina codigo_oficina            
                        from 
                        wf_asig_actividad aa 
                        inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                        inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                        inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                        inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                  from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                        inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                     from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                        inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        where  io_codigo_proc = @i_codigo_proceso  
                        and io_version_proc = @i_version_proceso
                        and ia_codigo_act = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and ia.ia_fecha_fin is not null
                        and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) <= ar.ar_tiempo_estandar
                        and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                        and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                        group by fu_login, r.codigo , o.of_oficina
                    ) q2 on q1.login = q2.login and q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina =q2.codigo_oficina
                    left join (
                        select 
                        fu_login login,          
                        count(1) atrasadas,
                        r.codigo codigo_regional, 
                        o.of_oficina codigo_oficina            
                        from 
                        wf_asig_actividad aa 
                        inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                        inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                        inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                        inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                           from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                        inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                           from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                        inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        where  io_codigo_proc = @i_codigo_proceso  
                        and io_version_proc = @i_version_proceso
                        and ia_codigo_act = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and ia.ia_fecha_fin is not null
                        and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) > ar.ar_tiempo_estandar
                        and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                        and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                        group by fu_login, r.codigo , o.of_oficina
                   ) q3 on q1.login = q3.login and q1.codigo_regional = q3.codigo_regional and q1.codigo_oficina =q3.codigo_oficina
                end
            end        
        end
        else
        begin
            if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
            begin 
			    print ' + '''' + ' Activity Detail - 16' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + '+ substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)
            end
            else if @i_type = ' + '''' + 'USERSUMMARY' + '''' + '
            begin 
			  
                -- Resumen    
                if @i_active = ' + '''' + 'S' + '''' + '
                begin
				    print ' + '''' + 'Activity Detail - 17' + '''' + '
                    select
                    (select avg(datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ))
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)
                    group by fu_login, fu_nombre),
                    (select max(datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ))
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)                    
                    group by fu_login, fu_nombre),
                    -- El tiempo estandar para una actividad determinada
                    (select max(ar_tiempo_estandar)
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso  
                    and ar_version_proceso = @i_version_proceso
                    )
                end
                else
                begin
				    print ' + '''' + 'Activity Detail - 18 - REvisar' + '''' + '
                    select 
                    (
                    ((select sum(du_tiempo_real) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') -
                (select isnull(sum(datediff(minute, ia_fecha_inicio, ia_fecha_fin)-(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    )), 0)
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                    and io_codigo_proc = @i_codigo_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    and fu_login = @i_login))
                    /((select sum(du_num_a_tiempo + du_num_retrasada) 
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ')- 
                    (select count(1)
                    from wf_inst_actividad a, wf_inst_proceso, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                    and io_codigo_proc = @i_codigo_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    and fu_login = @i_login))
                    ),
                    (select max(du_tiempo_max) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + '
                    ),
                    (select ar_tiempo_estandar  -- Tiempo est
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso
                    )
                end
            end
            else
            begin
			    print ' + '''' + ' Activity Detail - 19' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + '+ substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + ' +substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)
                if @i_active = ' + '''' + 'S' + '''' + ' 
                begin
				    print ' + '''' + 'Activity Detail - 20' + '''' + '
                    select 
                    fu_login, 
                    fu_nombre,            
                    sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) <= ar_tiempo_estandar then 1 else 0 end) , 
                    sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) > ar_tiempo_estandar then 1 else 0 end),
                    0,
                    r.codigo codigo_regional, 
                    r.valor  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina             
                    from 
                    wf_asig_actividad aa 
                    inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                    inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
					cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                                                  from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                              from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                    inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                    where  io_codigo_proc = @i_codigo_proceso  
                    and io_version_proc = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and o.of_oficina in (select id_office from #office_table)
                    group by  fu_login, fu_nombre, r.codigo, r.valor, o.of_oficina, o.of_nombre                 end
                else
                begin
				       print ' + '''' + 'Activity Detail - 21' + '''' + '
                       select 
                        fu_login login, 
                        fu_nombre usuario,
                        sum(du_num_a_tiempo) sumATiempo,
                        sum(du_num_retrasada) sumAtrsadas,
                        (sum(du_tiempo_real) / (sum(du_num_a_tiempo) + sum(du_num_retrasada))),
                        r.codigo codigo_regional, 
                        r.valor  nombre_regional, 
                        o.of_oficina codigo_oficina, 
                        o.of_nombre nombre_oficina
                        from
                        wf_r_asignacion_act du 
                        inner join wf_usuario us on us.us_id_usuario = du.du_id_usuario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        inner join cobis..cl_oficina o on o.of_oficina = du.du_oficina
                        inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
						cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                    from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                        where  du_codigo_proceso= @i_codigo_proceso  
                        and du_version_proceso = @i_version_proceso
                        and du_codigo_actividad = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and du_fecha <> ' + '''' + '99999999' + '''' + '
                        and convert(datetime, substring(du_fecha, 7, 2) + ' + '''' + '/' + '''' + '+ substring(du_fecha, 5, 2) + ' + '''' + '/' + '''' + '+ substring(du_fecha, 1, 4), 103) 
						between @i_start_date and @i_end_date
                        group by fu_login, fu_nombre, r.codigo, r.valor, o.of_oficina, o.of_nombre
                end
                
            end
        end
    end
end
return 0 

'
)
end

ELSE
begin

exec('

create procedure sp_activity_detail
(
  @s_ssn                int,
  @s_user               varchar(30),
  @s_sesn               int,
  @s_term               varchar(30),
  @s_date               datetime,
  @s_srv                varchar(30),
  @s_lsrv               varchar(30),
  @s_ofi                smallint,
  @t_debug              char(1)     = ' + '''' + 'N' + '''' + ',
  @t_file               varchar(14) = null,
  @t_from               varchar(30) = null,
  @t_trn                int,
  -- Input parameters
  @i_operation          char        = ' + '''' + 'C' + '''' + ',
  @i_type               varchar(30) = null,
  @i_codigo_proceso     int         = null,
  @i_version_proceso    int         = null,
  @i_codigo_actividad   int         = null,
  @i_date_indicator     char(8)     = ' + '''' + '99999999' + '''' + ',
  @i_active             char (1)    = ' + '''' + 'S' + '''' + ',
  @i_login              varchar(30) = null,
  @i_use_date_range     char(1)     = ' + '''' + 'N' + '''' + ',
  @i_start_date         datetime    = null,
  @i_end_date           datetime    = null,
  @i_oficina            varchar(100) = null
  
)
As declare
  @w_sp_name            varchar(32), 
  @w_position           numeric(20),
  @w_piece              varchar(50)
  
select @w_sp_name = ' + '''' + 'sp_process_detail' + '''' + '

--Cracion de tabla temporal
CREATE TABLE #office_table(
   id_office int
)

--Split de cadena
if @i_oficina is not null
begin
    SET    @w_position = charindex(' + '''' + ',' + '''' + ' , @i_oficina)
    while  @w_position <> 0
    begin 
        SET @w_piece = LEFT(@i_oficina, @w_position-1)

        insert into #office_table values (cast(@w_piece as int)) 

        SET @i_oficina = stuff(@i_oficina, 1, @w_position, NULL)
        SET @w_position = charindex(' + '''' + ',' + '''' + ', @i_oficina)
    end
    if @i_oficina <> ' + '''' + '' + '''' + '
    begin
        declare @w_office_id int
		select @w_office_id = cast(@i_oficina as int)
		
		if @w_office_id is not null
		begin
		     insert into #office_table values (@w_office_id)
		end
	end
end

-- Si la operacion es de consulta.
if @i_operation = ' + '''' + 'C' + '''' + '
begin
    if @i_date_indicator = ' + '''' + '99999999' + '''' + ' 
    begin
        if @i_type = ' + '''' + 'ACTIVITIES' + '''' + ' 
        begin   
		        print ' + '''' + ' Activity Detail - 1' + '''' + '
                select distinct
                ia_codigo_act, 
                ia_nombre_act,
                q1.aTiempo,
                q2.retrasadas,
                ' + '''' + 'c' + '''' + ' = null,
                 0 repetidas,
                --(count(distinct(ia_id_inst_act)) - (count(distinct(ia_id_inst_proc)) * count(distinct(pa_codigo_actividad))))
                ' + '''' + '0' + '''' + ' codigo_regional, 
                ' + '''' + '' + '''' + ' nombre_regional, 
                o.of_oficina codigo_oficina, 
                o.of_nombre nombre_oficina
                from   wf_inst_actividad ia
                inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
				wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
				wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia         
				from wf_actividad_proc  where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                inner join (select wf_paso.pa_id_paso, wf_paso.pa_codigo_proceso, wf_paso.pa_version_proceso, wf_paso.pa_codigo_actividad, wf_paso.pa_tipo_paso, 
				wf_paso.pa_posicion_x, wf_paso.pa_posicion_y, wf_paso.pa_ancho, wf_paso.pa_alto, wf_paso.pa_automatico, wf_paso.pa_id_programa_tiempo_estandar from wf_paso   where pa_codigo_proceso=@i_codigo_proceso and pa_version_proceso=@i_version_proceso) pa on pa.pa_codigo_actividad = ia.ia_codigo_act
                inner join (select wf_destinatario.de_codigo_actividad, wf_destinatario.de_codigo_proceso, wf_destinatario.de_version_proceso, wf_destinatario.de_id_destinatario, 
				wf_destinatario.de_id_rol_destinatario, wf_destinatario.de_tipo_destinatario, wf_destinatario.de_tipo_distribucion_carga, wf_destinatario.de_codigo_dist_carga, 
				wf_destinatario.de_tipo_oficina_dist_carga, wf_destinatario.de_requiere_usr_log, wf_destinatario.de_version_subpr, wf_destinatario.de_rol_cobis   from wf_destinatario    where de_codigo_proceso=@i_codigo_proceso and de_version_proceso=@i_version_proceso) de on de.de_codigo_actividad = ia.ia_codigo_act
                inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio               
				left  join (
                    select ia.ia_codigo_act codigo_actividad, o.of_oficina codigo_oficina, count(1) aTiempo
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
					and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and ia_fecha_fin is null
					and isnull(ia.ia_tipo_dest, ' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '
                    and datediff(minute, ia_fecha_inicio, getdate())  - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			    ) <= ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, o.of_oficina
                )   q1 on ia.ia_codigo_act = q1.codigo_actividad and o.of_oficina = q1.codigo_oficina  
                left  join (
                    select ia.ia_codigo_act codigo_actividad, o.of_oficina codigo_oficina, count(1) retrasadas
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                      from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and o.of_oficina in (select id_office from #office_table)
                    and ia_fecha_fin is null
					and isnull(ia.ia_tipo_dest,' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '
                    and datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			    ) > ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, o.of_oficina
                )   q2 on ia.ia_codigo_act = q2.codigo_actividad and o.of_oficina = q2.codigo_oficina  

                where  io.io_codigo_proc  =  @i_codigo_proceso
                and io.io_version_proc =  @i_version_proceso
                and o.of_oficina in (select id_office from #office_table)
                and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                and de.de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ',' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', '+ '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ia.ia_fecha_fin is null
                order by o.of_nombre, ia_id_paso
            print ' + '''' + 'Salida Exitosa para consulta de actividades' + '''' + '
            
            return 0
        end
        else if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'S' + '''' + '
        begin
            print ' + '''' + ' Activity Detail - 2' + '''' + '		
            select
                -- Tiempo promedio para una actividad determinada
                (select avg(datediff(minute, ia_fecha_inicio, getdate())- (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ' , ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU'+ '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo maximo para aun actividad determinada
                (select max(datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end 
        if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
        begin
		    print ' + '''' + ' Activity Detail - 3' + '''' + ' 
            select
                -- Tiempo promedio para una actividad determinada
                (select avg(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ',' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and (inst_actividad.ia_fecha_fin is not null or (inst_actividad.ia_fecha_fin is null and  isnull(inst_actividad.ia_tipo_dest, ' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
				and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo maximo para aun actividad determinada
                (select max(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and of_oficina = ip.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso ip, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and (inst_actividad.ia_fecha_fin is not null or (inst_actividad.ia_fecha_fin is null and  isnull(inst_actividad.ia_tipo_dest,' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end
        else if @i_type = ' + '''' + 'USERSUMMARY' + '''' + '
        begin
		    print ' + '''' + ' Activity Detail - 4' + '''' + '
            select
            -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(datediff(minute, ia_fecha_inicio, getdate())- (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= a.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    ))
                from wf_inst_actividad a, wf_inst_proceso ip, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                where ia_id_inst_proc = io_id_inst_proc
                and ia_fecha_fin is null  
                and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '				
                and aa_id_inst_act = ia_id_inst_act
                and fu_login = us_login
                and aa_id_destinatario = us_id_usuario
                and io_codigo_proc = @i_codigo_proceso
                and ia_codigo_act = @i_codigo_actividad
                and ar_codigo_actividad = ia_codigo_act
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc
                and io_version_proc = @i_version_proceso
                and fu_login = @i_login
                and io_oficina_inicio  in (select id_office from #office_table)
                group by fu_login, fu_nombre),
                (select max(datediff(minute, ia_fecha_inicio, getdate())- (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= a.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = ip.io_oficina_inicio
			    ))
                from wf_inst_actividad a, wf_inst_proceso ip, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                where ia_id_inst_proc = io_id_inst_proc
                and ia_fecha_fin is null  
                and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') != ' + '''' + 'PRO' + '''' + '				
                and aa_id_inst_act = ia_id_inst_act
                and fu_login = us_login
                and aa_id_destinatario = us_id_usuario
                and io_codigo_proc = @i_codigo_proceso
                and ia_codigo_act = @i_codigo_actividad
                and ar_codigo_actividad = ia_codigo_act
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc
                and io_version_proc = @i_version_proceso
                and fu_login = @i_login
                and io_oficina_inicio  in (select id_office from #office_table)
                group by fu_login, fu_nombre),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso  
                and ar_version_proceso = @i_version_proceso
                )                
        end
        else        
        begin
		    print ' + '''' + ' Activity Detail - 5 - Revisar' + '''' + '
            select
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(a.b) from 
                    (select datediff(minute, ia_fecha_inicio, getdate()) - (select count(1)*1440 from cobis..cl_dias_feriados df 
                                                                            inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
                                                                            where df_fecha >= ia.ia_fecha_inicio 
                                                                            and df_fecha<= getdate() 
                                                                            and of_oficina = ip.io_oficina_inicio) as b
                    from wf_inst_actividad ia, wf_actividad_proc, wf_inst_proceso ip
                    where ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = @i_codigo_proceso
                    and ar_version_proceso = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad 
                    and ia_fecha_fin is null
				    and ia_id_inst_proc = io_id_inst_proc) as a),
                -- El tiempo maximo para un proceso determinado
                (select max(a.b) from 
                (select datediff(minute, ia_fecha_inicio, getdate()) - (select count(1)*1440 from cobis..cl_dias_feriados df 
                                                                       inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
                                                                       where df_fecha >= ia.ia_fecha_inicio 
                                                                       and df_fecha<= getdate() 
                                                                       and of_oficina = ip.io_oficina_inicio) as b
                from wf_inst_actividad ia, wf_actividad_proc, wf_inst_proceso ip
                where ar_codigo_actividad = ia_codigo_act
                and ar_codigo_proceso = @i_codigo_proceso
                and ar_version_proceso = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad 
                and ia_fecha_fin is null
				and ia_id_inst_proc = io_id_inst_proc) as a),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso
                )

            select fu_login, fu_nombre, count(1),o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_asig_actividad aa 
            inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
            inner join wf_inst_proceso   io on ia.ia_id_inst_proc = io.io_id_inst_proc
            inner join wf_usuario        us on us.us_id_usuario = aa.aa_id_destinatario
            inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
			wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida,
			wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                             from wf_actividad_proc where ar_codigo_proceso = @i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio 
			where io.io_codigo_proc = @i_codigo_proceso 
            and   io.io_version_proc = @i_version_proceso
            and   ia.ia_codigo_act = @i_codigo_actividad
            and   o.of_oficina in (select id_office from #office_table)
            and ia_fecha_fin is null
			and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ') 
            and datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = io.io_oficina_inicio
			    ) <= ar_tiempo_estandar
            group by fu.fu_login, fu.fu_nombre,o.of_oficina , o.of_nombre 
            
            select fu_login, fu_nombre, count(1), o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_asig_actividad aa 
            inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
            inner join wf_inst_proceso   io on ia.ia_id_inst_proc = io.io_id_inst_proc
            inner join wf_usuario        us on us.us_id_usuario = aa.aa_id_destinatario
            inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc where ar_codigo_proceso = @i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
		    where io.io_codigo_proc = @i_codigo_proceso 
            and   io.io_version_proc = @i_version_proceso
            and   ia.ia_codigo_act = @i_codigo_actividad
            and   o.of_oficina in (select id_office from #office_table)
            and ia_fecha_fin is null 
			and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ') 
            and datediff(minute, ia_fecha_inicio, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and of_oficina = io.io_oficina_inicio
			    ) > ar_tiempo_estandar
            group by fu.fu_login, fu.fu_nombre,o.of_oficina , o.of_nombre       

        end
    end
    else
    begin
        if @i_type = ' + '''' + 'ACTIVITIES' + '''' + '
        begin
            if @i_active = ' + '''' + 'S' + '''' + '
            begin
			    print ' + '''' + ' Activity Detail - 6' + '''' + '
                select distinct
                ia_codigo_act, 
                ia_nombre_act,
                q1.aTiempo,
                q2.retrasadas,
                ' + '''' + 'c' + '''' + ' = null,
                 0 repetidas,
                --(count(distinct(ia_id_inst_act)) - (count(distinct(ia_id_inst_proc)) * count(distinct(pa_codigo_actividad))))
                ' + '''' + '0' + '''' + ' codigo_regional, 
                ' + '''' + '' + '''' + '  nombre_regional, 
                o.of_oficina codigo_oficina, 
                o.of_nombre nombre_oficina
                from   wf_inst_actividad ia
                inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc  where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                inner join (select wf_paso.pa_id_paso, wf_paso.pa_codigo_proceso, wf_paso.pa_version_proceso, wf_paso.pa_codigo_actividad, wf_paso.pa_tipo_paso, wf_paso.pa_posicion_x, wf_paso.pa_posicion_y, wf_paso.pa_ancho, wf_paso.pa_alto, wf_paso.pa_automatico, wf_paso.pa_id_programa_tiempo_estandar from wf_paso   where pa_codigo_proceso=@i_codigo_proceso and pa_version_proceso=@i_version_proceso) pa on pa.pa_codigo_actividad = ia.ia_codigo_act
                inner join (select wf_destinatario.de_codigo_actividad, wf_destinatario.de_codigo_proceso, wf_destinatario.de_version_proceso, wf_destinatario.de_id_destinatario, wf_destinatario.de_id_rol_destinatario, wf_destinatario.de_tipo_destinatario, wf_destinatario.de_tipo_distribucion_carga, wf_destinatario.de_codigo_dist_carga, wf_destinatario.de_tipo_oficina_dist_carga, wf_destinatario.de_requiere_usr_log, wf_destinatario.de_version_subpr, wf_destinatario.de_rol_cobis from wf_destinatario    where de_codigo_proceso=@i_codigo_proceso and de_version_proceso=@i_version_proceso) de on de.de_codigo_actividad = ia.ia_codigo_act
                inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                left  join (
                    select ia.ia_codigo_act codigo_actividad, o.of_oficina codigo_oficina, count(1) aTiempo
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and (ia_fecha_fin is not null or (ia_fecha_fin is null and ia_tipo_dest = ' + '''' + 'PRO' + '''' + ')) -- Y.Pacheco
                    and datediff(minute, ia_fecha_inicio,  isnull(ia_fecha_fin,ia_fecha_inicio))- (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= isnull(ia.ia_fecha_fin,ia.ia_fecha_inicio) and ofi.of_oficina = o.of_oficina
			   ) <= ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, o.of_oficina
                )   q1 on ia.ia_codigo_act = q1.codigo_actividad and o.of_oficina = q1.codigo_oficina  
                left  join (
                    select ia.ia_codigo_act codigo_actividad, o.of_oficina codigo_oficina, count(1) retrasadas
                    from   wf_inst_actividad ia
                    inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    and io.io_codigo_proc  =  @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and (ia_fecha_fin is not null or (ia_fecha_fin is null and ia_tipo_dest = ' + '''' + 'PRO' + '''' + ')) -- Y.Pacheco
                    and datediff(minute, ia_fecha_inicio,  isnull(ia_fecha_fin,ia_fecha_inicio))- (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= isnull(ia.ia_fecha_fin,ia.ia_fecha_inicio) and ofi.of_oficina = o.of_oficina
			    ) > ar_tiempo_estandar
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ') 
                    group by ia.ia_codigo_act, o.of_oficina
                )   q2 on ia.ia_codigo_act = q2.codigo_actividad and o.of_oficina = q2.codigo_oficina  

                where  io.io_codigo_proc  =  @i_codigo_proceso
                and io.io_version_proc =  @i_version_proceso
                and de.de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ' , ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                and (ia_fecha_fin is not null or (ia_fecha_fin is null and ia_tipo_dest = ' + '''' + 'PRO' + '''' + ')) -- Y.Pacheco
                order by o.of_nombre, ia_id_paso  
                
            end
            else
            begin
			    print ' + '''' + ' Activity Detail - 7' + '''' + '
                select q1.codigo_actividad, 
                       q1.nombre_actividad, 
                       q1.sum_a_tiempo - isnull(q2.a_tiempo ,0) aTiempo,  
                       q1.sum_retrasadas - isnull(q3.retrasadas ,0) atrasadas,
                       (q1.sum_tiempo_real / ( q1.sum_tiempo_real + q1.sum_retrasadas)),
                       0,
                       q1.codigo_regional, 
                       q1.nombre_regional, 
                       q1.codigo_oficina, 
                       q1.nombre_oficina
                from (
                    select 
                    ac_codigo_actividad codigo_actividad,
                    ac_nombre_actividad nombre_actividad,
                    ' + '''' + '0' + '''' + ' codigo_regional, 
                    ' + '''' + '' + '''' + '  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina,
                    sum(da_num_a_tiempo)   sum_a_tiempo,
                    sum(da_num_retrasadas) sum_retrasadas,
                    sum(da_tiempo_real)    sum_tiempo_real,
                    sum(da_num_retrasadas + da_num_a_tiempo) sum_retrasadas_a_tiempo
                    from wf_r_actividades_proc da 
                    inner join wf_actividad ac on da.da_codigo_actividad = ac.ac_codigo_actividad
                    inner join cobis..cl_oficina o on o.of_oficina = da.da_oficina
                    where da_codigo_proceso   = @i_codigo_proceso 
                    and   da_version_proceso  = @i_version_proceso
                    and   o.of_oficina in (select id_office from #office_table)
                    and   da_fecha <> ' + '''' + '99999999' + '''' + '
                    group by ac_codigo_actividad, ac_nombre_actividad, o.of_oficina, o.of_nombre
                ) q1 left join (   
                    select 
                    ia_codigo_act codigo_actividad,
                    ' + '''' + '0' + '''' + ' codigo_regional, 
                    o.of_oficina codigo_oficina, 
                    count(1) a_tiempo
                    from wf_inst_actividad ia
                    inner join wf_inst_proceso io on ia.ia_id_inst_proc = io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia     
					from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
                    inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
					where io.io_codigo_proc  = @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso 
                    and o.of_oficina in (select id_office from #office_table)
                    and ia.ia_fecha_fin is not null
                    and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = o.of_oficina
			    )  <= ar.ar_tiempo_estandar
                    and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                    and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    group by ia_codigo_act, o.of_oficina
                )   q2 on q1.codigo_actividad=q2.codigo_actividad and q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina = q2.codigo_oficina
                left join (
                    select 
                    ia_codigo_act codigo_actividad,
                    ' + '''' + '0' + '''' + ' codigo_regional, 
                    o.of_oficina codigo_oficina, 
                    count(1) retrasadas
                    from wf_inst_actividad ia
                    inner join wf_inst_proceso io on ia.ia_id_inst_proc = io.io_id_inst_proc
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                       from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ar.ar_codigo_actividad=ia.ia_codigo_act
                    inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
                    where io.io_codigo_proc  = @i_codigo_proceso
                    and io.io_version_proc =  @i_version_proceso 
                    and   o.of_oficina in (select id_office from #office_table)
                    and ia.ia_fecha_fin is not null
                    and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = o.of_oficina
			    ) > ar.ar_tiempo_estandar
                    and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                    and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    group by ia_codigo_act, o.of_oficina
                )   q3 on q1.codigo_actividad=q3.codigo_actividad and q1.codigo_regional = q3.codigo_regional and q1.codigo_oficina = q3.codigo_oficina
            end
        end
        else if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
        begin
		    print ' + '''' + ' Activity Detail - 8 - Revisar' + '''' + '
            select
                -- Resumen para tacometro
                -- Tiempo promedio para una actividad determinada
                (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                from wf_r_actividades_proc
                where da_codigo_proceso = @i_codigo_proceso 
                and da_version_proceso = @i_version_proceso 
                and da_codigo_actividad = @i_codigo_actividad  
                and da_fecha <> ' + '''' + '99999999' + '''' + '
                ),
                -- El tiempo maximo para una actividad determinada
                (select max(da_tiempo_max) 
                from wf_r_actividades_proc 
                where da_codigo_proceso = @i_codigo_proceso 
                and da_version_proceso = @i_version_proceso 
                and da_codigo_actividad = @i_codigo_actividad 
                and da_fecha <> ' + '''' + '99999999' + '''' + '),
                -- El tiempo estandar para una actividad determinada
                (select ar_tiempo_estandar 
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end
        else if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'S' + '''' + '
        begin
		    print ' + '''' + 'Activity Detail - 9' + '''' + '
            select
                -- Tiempo promedio para una actividad determinada
                (select avg(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) ) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso io, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ia_estado = ' + '''' + 'COM' + '''' + '
                and io_estado <> ' + '''' + 'TER' + '''' + '
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is not null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo maximo para aun actividad determinada
                (select max(datediff(minute, ia_fecha_inicio, inst_actividad.ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= inst_actividad.ia_fecha_inicio and df_fecha<= inst_actividad.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    )) 
                from wf_inst_actividad inst_actividad, wf_actividad_proc, wf_inst_proceso io, wf_destinatario
                where ia_codigo_act = ar_codigo_actividad
                and de_codigo_actividad = ar_codigo_actividad
                and de_codigo_proceso = io_codigo_proc
                and de_version_proceso = io_version_proc
                and de_tipo_destinatario IN (' + '''' + 'USR' + '''' + ', ' + '''' + 'JER' + '''' + ', ' + '''' + 'COM' + '''' + ', ' + '''' + 'ROL' + '''' + ', ' + '''' + 'JEU' + '''' + ')
                and ia_estado = ' + '''' + 'COM' + '''' + '
                and io_estado <> ' + '''' + 'TER' + '''' + '
                and ar_codigo_proceso = @i_codigo_proceso
                and ia_id_inst_proc = io_id_inst_proc
                and inst_actividad.ia_fecha_fin is not null
                and ar_codigo_proceso = io_codigo_proc
                and ar_version_proceso = io_version_proc    
                and io_version_proc = @i_version_proceso
                and ia_codigo_act = @i_codigo_actividad
                and io_oficina_inicio  in (select id_office from #office_table)),
                -- El tiempo estandar para una actividad determinada
                (select max(ar_tiempo_estandar)
                from wf_actividad_proc 
                where ar_codigo_actividad = @i_codigo_actividad 
                and ar_codigo_proceso = @i_codigo_proceso 
                and ar_version_proceso = @i_version_proceso)
        end
        else if @i_use_date_range = ' + '''' + 'N' + '''' + '
        begin
            if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
            begin
			    print ' + '''' + 'Activity Detail - 10 - Revisar' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    ),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)
            end
            else if @i_type = ' + '''' + 'USERSUMMARY' + '''' + '
            begin 
                -- Resumen    
                if @i_active = ' + '''' + 'S' + '''' + '
                begin
				    print ' + '''' + ' Activity Detail - 11' + '''' + ' 
                    select
                    (select avg(datediff(minute, ia_fecha_inicio, ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ))
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)
                    ),
                    (select max(datediff(minute, ia_fecha_inicio, ia_fecha_fin) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) )
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)
                    ),
                    -- El tiempo estandar para una actividad determinada
                    (select max(ar_tiempo_estandar)
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso  
                    and ar_version_proceso = @i_version_proceso
                    )
                end
                else
                begin
				    print ' + '''' + ' Activity Detail - 12 - Revisar' + '''' + '
                    select 
                    ((select sum(du_tiempo_real) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') -
					(select isnull(sum(a.b),0) from (
						select datediff(minute, ia_fecha_inicio, ia_fecha_fin) - (select count(1)*1440 
																				  from cobis..cl_dias_feriados df 
																				  inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
																				  where df_fecha >= a.ia_fecha_inicio 
																				  and df_fecha<= a.ia_fecha_fin 
																				  and ofi.of_oficina = io.io_oficina_inicio) as b
						from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
						where ia_id_inst_proc = io_id_inst_proc
						and ia_fecha_fin is not null        
						and aa_id_inst_act = ia_id_inst_act
						and fu_login = us_login
						and aa_id_destinatario = us_id_usuario
						and io_codigo_proc = @i_codigo_proceso
						and ia_codigo_act = @i_codigo_actividad
						and ar_codigo_actividad = ia_codigo_act
						and ar_codigo_proceso = io_codigo_proc
						and ar_version_proceso = io_version_proc
						and io_version_proc = @i_version_proceso
						and ia_estado = ' + '''' + 'COM' + '''' + '
						and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
						and fu_login = @i_login) as a)
                    /((select sum(du_num_a_tiempo + du_num_retrasada) 
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') - 
                    (select count(1)
                    from wf_inst_actividad a, wf_inst_proceso, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                    and io_codigo_proc = @i_codigo_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    and fu_login = @i_login))
                    ),
                    (
                    select max(du_tiempo_max) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + '
                    ),
                    (select ar_tiempo_estandar  -- Tiempo est´
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso
                    )
                end
            end
            else
            begin
			    print ' + '''' + ' Activity Detail - 13 - Revisar' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)

                
                
                if @i_active = ' + '''' + 'S' + '''' + '
                begin
				    print ' + '''' + ' Activity Detail - 14' + '''' + '
                    select 
                    fu_login, 
                    fu_nombre,            
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) <= ar_tiempo_estandar then 1 else 0 end), 
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) > ar_tiempo_estandar then 1 else 0 end),
                    count(1),
                    ' + '''' + '0' + '''' + ' codigo_regional, 
                    ' + '''' + '' + '''' + '  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina             
                    from 
                    wf_asig_actividad aa 
                    inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                    inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                    inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                    where  io_codigo_proc = @i_codigo_proceso  
                    and io_version_proc = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and o.of_oficina in (select id_office from #office_table)
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
					and datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) <= ar_tiempo_estandar
                    group by  fu_login, fu_nombre, o.of_oficina, o.of_nombre  
					
					select 
                    fu_login, 
                    fu_nombre,            
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) <= ar_tiempo_estandar then 1 else 0 end), 
                    --sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) > ar_tiempo_estandar then 1 else 0 end),
                    count(1),
                    ' + '''' + '0' + '''' + ' codigo_regional, 
                    ' + '''' + '' + '''' + '  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina             
                    from 
                    wf_asig_actividad aa 
                    inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                    inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia  from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                    inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                    where  io_codigo_proc = @i_codigo_proceso  
                    and io_version_proc = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and o.of_oficina in (select id_office from #office_table)
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
					and datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) > ar_tiempo_estandar
                    group by  fu_login, fu_nombre, o.of_oficina, o.of_nombre  
                end
                else
                begin
				    print ' + '''' + ' Activity Detail - 15' + '''' + '
                     select 
                    q1.login,
                    q1.usuario,
                    q1.sumATiempo - isnull(q2.a_tiempo,0) a_tiempo,
                    q1.sumAtrsadas - isnull(q3.atrasadas,0) atrasadas,
                    q1.sumTiempoReal / (q1.sumATiempo + q1.sumAtrsadas) promedio,
                    q1.codigo_regional, 
                    q1.nombre_regional, 
                    q1.codigo_oficina, 
                    q1.nombre_oficina
                    from (
                        select 
                        fu_login login, 
                        fu_nombre usuario,
                        ' + '''' + '0' + '''' + ' codigo_regional, 
                        ' + '''' + '' + '''' + '  nombre_regional, 
                        o.of_oficina codigo_oficina, 
                        o.of_nombre nombre_oficina,
                        sum(du_num_a_tiempo) sumATiempo,
                        sum(du_num_retrasada) sumAtrsadas,
                        sum(du_tiempo_real)   sumTiempoReal
                        from
                        wf_r_asignacion_act du 
                        inner join wf_usuario us on us.us_id_usuario = du.du_id_usuario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        inner join cobis..cl_oficina o on o.of_oficina = du.du_oficina
                        where  du_codigo_proceso= @i_codigo_proceso  
                        and du_version_proceso = @i_version_proceso
                        and du_codigo_actividad = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and du_fecha <> ' + '''' + '99999999' + '''' + '
                        group by fu_login, fu_nombre, o.of_oficina, o.of_nombre
                    ) q1 
                    left join (
                        select 
                        fu_login login,          
                        count(1) a_tiempo,
                        ' + '''' + '0' + '''' + ' codigo_regional, 
                        o.of_oficina codigo_oficina            
                        from 
                        wf_asig_actividad aa 
                        inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                        inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                        inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                        inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia   from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                        inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        where  io_codigo_proc = @i_codigo_proceso  
                        and io_version_proc = @i_version_proceso
                        and ia_codigo_act = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and ia.ia_fecha_fin is not null
                        and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) <= ar.ar_tiempo_estandar
                        and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                        and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                        group by fu_login, o.of_oficina
                    ) q2 on q1.login = q2.login and q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina =q2.codigo_oficina
                    left join (
                        select 
                        fu_login login,          
                        count(1) atrasadas,
                        ' + '''' + '0' + '''' + 'codigo_regional, 
                        o.of_oficina codigo_oficina            
                        from 
                        wf_asig_actividad aa 
                        inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                        inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                        inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                        inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia   from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                        inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        where  io_codigo_proc = @i_codigo_proceso  
                        and io_version_proc = @i_version_proceso
                        and ia_codigo_act = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and ia.ia_fecha_fin is not null
                        and datediff(minute, ia.ia_fecha_inicio, ia.ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) > ar.ar_tiempo_estandar
                        and ia.ia_estado = ' + '''' + 'COM' + '''' + '
                        and io.io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                        group by fu_login, o.of_oficina
                   ) q3 on q1.login = q3.login and q1.codigo_regional = q3.codigo_regional and q1.codigo_oficina =q3.codigo_oficina
                end
            end        
        end
        else
        begin
            if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + ' and @i_active = ' + '''' + 'N' + '''' + '
            begin 
			    print ' + '''' + ' Activity Detail - 16' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + '+ substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + '+ substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + '+ substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)
            end
            else if @i_type = ' + '''' + 'USERSUMMARY' + '''' + '
            begin 
			  
                -- Resumen    
                if @i_active = ' + '''' + 'S' + '''' + '
                begin
				    print ' + '''' + 'Activity Detail - 17' + '''' + '
                    select
                    (select avg(datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= a.ia_fecha_inicio and df_fecha<= a.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ))
                    from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                     and io_codigo_proc = @i_codigo_proceso  
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado = ' + '''' + 'EJE' + '''' + '
                    and io_oficina_inicio  in (select id_office from #office_table)
                    group by fu_login, fu_nombre),
					(select max(a.b) from     
                        (select datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(select count(1)*1440 
                                                                             from cobis..cl_dias_feriados df 
                                                                             inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
                                                                             where df_fecha >= a.ia_fecha_inicio 
                                                                             and df_fecha<= a.ia_fecha_fin 
                                                                             and ofi.of_oficina = io.io_oficina_inicio) as b

						from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
						where ia_id_inst_proc = io_id_inst_proc
						and ia_fecha_fin is not null        
						and aa_id_inst_act = ia_id_inst_act
						and fu_login = us_login
						and aa_id_destinatario = us_id_usuario
						 and io_codigo_proc = @i_codigo_proceso  
						and ia_codigo_act = @i_codigo_actividad
						and ar_codigo_actividad = ia_codigo_act
						and ar_codigo_proceso = io_codigo_proc
						and ar_version_proceso = io_version_proc
						and io_version_proc = @i_version_proceso
						and ia_estado = ' + '''' + 'COM' + '''' + '
						and io_estado = ' + '''' + 'EJE' + '''' + '
						and io_oficina_inicio  in (select id_office from #office_table)                    
						group by fu_login, fu_nombre) as a),
                    -- El tiempo estandar para una actividad determinada
                    (select max(ar_tiempo_estandar)
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso  
                    and ar_version_proceso = @i_version_proceso
                    )
                end
                else
                begin
				    print ' + '''' + 'Activity Detail - 18 - REvisar' + '''' + '
                    select 
                    (
                    ((select sum(du_tiempo_real) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') -
					(select isnull(sum(a.b),0) from 
						(select datediff(minute, ia_fecha_inicio, ia_fecha_fin)-(select count(1)*1440 from cobis..cl_dias_feriados df 
																				inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
																				where df_fecha >= a.ia_fecha_inicio 
																				and df_fecha<= a.ia_fecha_fin 
																				and ofi.of_oficina = io.io_oficina_inicio) as b
						from wf_inst_actividad a, wf_inst_proceso io, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
						where ia_id_inst_proc = io_id_inst_proc
						and ia_fecha_fin is not null        
						and aa_id_inst_act = ia_id_inst_act
						and fu_login = us_login
						and aa_id_destinatario = us_id_usuario
						and io_codigo_proc = @i_codigo_proceso
						and ia_codigo_act = @i_codigo_actividad
						and ar_codigo_actividad = ia_codigo_act
						and ar_codigo_proceso = io_codigo_proc
						and ar_version_proceso = io_version_proc
						and io_version_proc = @i_version_proceso
						and ia_estado = ' + '''' + 'COM' + '''' + '
						and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
						and fu_login = @i_login) as a))
                    /((select sum(du_num_a_tiempo + du_num_retrasada) 
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + ') - 
                    (select count(1)
                    from wf_inst_actividad a, wf_inst_proceso, wf_asig_actividad, wf_usuario, cobis..cl_funcionario, wf_actividad_proc
                    where ia_id_inst_proc = io_id_inst_proc
                    and ia_fecha_fin is not null        
                    and aa_id_inst_act = ia_id_inst_act
                    and fu_login = us_login
                    and aa_id_destinatario = us_id_usuario
                    and io_codigo_proc = @i_codigo_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and ar_codigo_actividad = ia_codigo_act
                    and ar_codigo_proceso = io_codigo_proc
                    and ar_version_proceso = io_version_proc
                    and io_version_proc = @i_version_proceso
                    and ia_estado = ' + '''' + 'COM' + '''' + '
                    and io_estado in (' + '''' + 'INI' + '''' + ', ' + '''' + 'EJE' + '''' + ')
                    and fu_login = @i_login))
                    ),
                    (
                    select max(du_tiempo_max) -- Tiempo promedio
                    from wf_r_asignacion_act, wf_usuario, cobis..cl_funcionario
                    where du_codigo_proceso = @i_codigo_proceso
                    and du_codigo_actividad = @i_codigo_actividad
                    and du_version_proceso = @i_version_proceso
                    and fu_login = us_login
                    and du_id_usuario = us_id_usuario
                    and fu_login = @i_login
                    and du_fecha <> ' + '''' + '99999999' + '''' + '
                    ),
                    (select ar_tiempo_estandar  -- Tiempo est´
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso
                    )
                end
            end
            else
            begin
			    print ' + '''' + ' Activity Detail - 19' + '''' + '
                select
                    -- Resumen para tacometro
                    -- Tiempo promedio para un proceso determinado
                    (select avg(da_tiempo_real / (da_num_a_tiempo + da_num_retrasadas)) 
                    from wf_r_actividades_proc
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad  
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo maximo para un proceso determinado
                    (select max(da_tiempo_max) 
                    from wf_r_actividades_proc 
                    where da_codigo_proceso = @i_codigo_proceso 
                    and da_version_proceso = @i_version_proceso 
                    and da_codigo_actividad = @i_codigo_actividad 
                    and da_fecha <> ' + '''' + '99999999' + '''' + '
                    and convert(datetime, substring(da_fecha, 7, 2) + ' + '''' + '/' + '''' + '+ substring(da_fecha, 5, 2) + ' + '''' + '/' + '''' + ' +substring(da_fecha, 1, 4), 103) 
					between @i_start_date and @i_end_date
                    ),
                    -- El tiempo estandar para un proceso determinado
                    (select ar_tiempo_estandar 
                    from wf_actividad_proc 
                    where ar_codigo_actividad = @i_codigo_actividad 
                    and ar_codigo_proceso = @i_codigo_proceso 
                    and ar_version_proceso = @i_version_proceso)
                if @i_active = ' + '''' + 'S' + '''' + ' 
                begin
				    print ' + '''' + 'Activity Detail - 20' + '''' + '
                    select 
                    fu_login, 
                    fu_nombre,            
                    sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) <= ar_tiempo_estandar then 1 else 0 end) , 
                    sum(case when datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio
			    ) > ar_tiempo_estandar then 1 else 0 end),
                    0,
                    ' + '''' + '0' + '''' + ' codigo_regional, 
                    ' + '''' + '' + '''' + '  nombre_regional, 
                    o.of_oficina codigo_oficina, 
                    o.of_nombre nombre_oficina             
                    from 
                    wf_asig_actividad aa 
                    inner join wf_inst_actividad ia on ia.ia_id_inst_act = aa.aa_id_inst_act
                    inner join wf_inst_proceso io on io.io_id_inst_proc = ia.ia_id_inst_proc
                    inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
                    inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
					wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
					wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia   from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
                    inner join wf_usuario us on us.us_id_usuario = aa.aa_id_destinatario
                    inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                    where  io_codigo_proc = @i_codigo_proceso  
                    and io_version_proc = @i_version_proceso
                    and ia_codigo_act = @i_codigo_actividad
                    and o.of_oficina in (select id_office from #office_table)
                    group by  fu_login, fu_nombre, o.of_oficina, o.of_nombre                 
					end
                else
                begin
				       print ' + '''' + 'Activity Detail - 21' + '''' + '
                       select 
                        fu_login login, 
                        fu_nombre usuario,
                        sum(du_num_a_tiempo) sumATiempo,
                        sum(du_num_retrasada) sumAtrsadas,
                        (sum(du_tiempo_real) / (sum(du_num_a_tiempo) + sum(du_num_retrasada))),
                        ' + '''' + '0' + '''' + ' codigo_regional, 
                        ' + '''' + '' + '''' + '  nombre_regional, 
                        o.of_oficina codigo_oficina, 
                        o.of_nombre nombre_oficina
                        from
                        wf_r_asignacion_act du 
                        inner join wf_usuario us on us.us_id_usuario = du.du_id_usuario
                        inner join cobis..cl_funcionario fu on fu.fu_login = us.us_login
                        inner join cobis..cl_oficina o on o.of_oficina = du.du_oficina
                        where  du_codigo_proceso= @i_codigo_proceso  
                        and du_version_proceso = @i_version_proceso
                        and du_codigo_actividad = @i_codigo_actividad
                        and o.of_oficina in (select id_office from #office_table)
                        and du_fecha <> ' + '''' + '99999999' + '''' + '
                        and convert(datetime, substring(du_fecha, 7, 2) + ' + '''' + '/' + '''' + '+ substring(du_fecha, 5, 2) + ' + '''' + '/' + '''' + '+ substring(du_fecha, 1, 4), 103) 
						between @i_start_date and @i_end_date
                        group by fu_login, fu_nombre, o.of_oficina, o.of_nombre
                end
                
            end
        end
    end
end
return 0 
'
)

end
go
