use cob_workflow
go
if exists (select 1 from sysobjects
            where name = 'sp_process_detail')
begin
  -- print 'ELIMINANDO EL PROCEDIMIENTO sp_resumen_req_wf'
  drop procedure sp_process_detail
end
go
-- print 'CREANDO EL PROCEDIMIENTO sp_process_detail'
go
/************************************************************/
/*   ARCHIVO:         wf_resumen.sp                     */
/*   NOMBRE LOGICO:   sp_resumen_wf                     */
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

if isnull(@w_table_code,0) > 0
begin 

exec('

CREATE PROCEDURE sp_process_detail
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
  @i_date_indicator     char(8)     = ' + '''' + '99999999' + '''' + ',
  @i_use_date_range     char(1)     = ' + '''' + 'N' + '''' + ',
  @i_start_date         date        = null,
  @i_end_date           date        = null,
  @i_oficina            varchar(100) = null
  
)
As declare
  @w_sp_name            varchar(32),
  @w_position           numeric(20),
  @w_piece              varchar(50),
  @w_table_code         int

select @w_sp_name = ' + '''' + 'sp_process_detail' + '''' + '

--Recupera el codigo de la tabla cl_regional
select @w_table_code = codigo from cobis..cl_tabla where tabla=' + '''' + 'cl_regional' + '''' + '

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
        SET @w_position = charindex(' + '''' + ',' + '''' + ' , @i_oficina)
    end
    if @i_oficina <>' + '''' + '' + '''' + '
    begin
        declare @w_office_id int
		select @w_office_id = cast(@i_oficina as int)
		
		if @w_office_id is not null
		begin
		     insert into #office_table values (@w_office_id)
		end
	end
end

if (@i_version_proceso <= -1)
begin
    select @i_version_proceso = null
end


-- Si la operacion es de consulta.
if @i_operation = ' + '''' + 'C' + '''' + '
begin
    if @i_date_indicator = ' + '''' + '99999999' + '''' + '
    begin
        if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + '
        begin
                select
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ))
                from wf_proceso p, wf_inst_proceso ip
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso and
				io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and io_version_proc = @i_version_proceso))
                and   io_oficina_inicio in (select id_office from #office_table)
                ),
                -- El tiempo maximo para un proceso determinado
                (select max(datediff(minute, io_fecha_crea, getdate())-(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ))
                from wf_proceso p, wf_inst_proceso ip
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso
				and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and io_version_proc = @i_version_proceso))
                and io_oficina_inicio in (select id_office from #office_table)
                ),
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso)           
		
		end
		else if @i_type = ' + '''' + 'PROCESSVERSION' + '''' + '
        begin
		         -- Total instancias de proceso abiertas por versión de proceso 
            -- Columnas: código del proceso, versión  del proceso, total instancias a tiempo, total instancias atrasadas
            
            -- Consulta todos las instancias de procesos iniciadas y en ejecucion
            select q1.codigo_proceso, q1.version_proceso, q2.aTiempo, q3.atrasados, null promedios,0 cancelados,0 supendidos, q1.codigo_regional, q1.nombre_regional, q1.codigo_oficina, q1.nombre_oficina 
			from
            (
                select
                io.io_codigo_proc codigo_proceso, 
                io.io_version_proc version_proceso,
                r.codigo codigo_regional,
                r.valor  nombre_regional,
                o.of_oficina codigo_oficina,
                o.of_nombre nombre_oficina
                from wf_inst_proceso io
                inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
                inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
                inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
				cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                        
				from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                where io.io_codigo_proc = @i_codigo_proceso 
                and   io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                group by r.codigo,r.valor,o.of_oficina,o.of_nombre, io.io_codigo_proc, io.io_version_proc 

            ) q1
            left join 
            (
                --Consulta las instancias de procesos iniciadas y en ejecucion (A Tiempo)
                select 
                io.io_codigo_proc codigo_proceso, 
                io.io_version_proc version_proceso,
                r.codigo codigo_regional,
                o.of_oficina codigo_oficina,
                count(io.io_version_proc) aTiempo
                from wf_inst_proceso io
                inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
                inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
                inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
				cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type   
				from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                where io.io_codigo_proc = @i_codigo_proceso 
                and   io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                and datediff(minute, io.io_fecha_crea, getdate()) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   ) <= pr.pr_tiempo_estandar
                group by r.codigo,o.of_oficina,io.io_codigo_proc, io.io_version_proc
            ) q2 on q1.codigo_proceso = q2.codigo_proceso and q1.version_proceso = q2.version_proceso and q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina = q2.codigo_oficina
            left join 
            (
                --Consulta las instancias de procesos iniciadas y en ejecucion (Atrasadas)
                select 
                io.io_codigo_proc codigo_proceso, 
                io.io_version_proc version_proceso,
                r.codigo codigo_regional,
                o.of_oficina codigo_oficina,
                count(io.io_version_proc) atrasados
                from wf_inst_proceso io
                inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
                inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
                inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
				cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type    
				from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
                where io.io_codigo_proc = @i_codigo_proceso 
                and   io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                and datediff(minute, io.io_fecha_crea, getdate()) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   ) > pr.pr_tiempo_estandar
                group by r.codigo,o.of_oficina,io.io_codigo_proc, io.io_version_proc
            ) q3 on q1.codigo_proceso = q3.codigo_proceso and q1.version_proceso = q3.version_proceso and q1.codigo_regional = q3.codigo_regional and q1.codigo_oficina = q3.codigo_oficina
            order by q1.nombre_regional,q1.nombre_oficina,q1.codigo_proceso, q1.version_proceso desc
		
		
		end
		else if @i_version_proceso <> 0
        begin
		        select
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ))
                from wf_proceso p, wf_inst_proceso ip
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso and io_version_proc = @i_version_proceso and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and  io_oficina_inicio in (select id_office from #office_table)),
                
                -- El tiempo maximo para un proceso determinado
                (select max(datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ) )
                from wf_proceso p, wf_inst_proceso ip 
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso and io_version_proc = @i_version_proceso and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and  io_oficina_inicio in (select id_office from #office_table)),
                
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso) 
                
            -- Numero actividades inciadas y ejecutadas a tiempo
            select ia.ia_codigo_act, ia.ia_nombre_act, count(1) aTiempo, r.codigo codigo_regional, r.valor  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, 
			wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, 
			wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                       
			from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                       from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and ia.ia_fecha_fin is null    
			and ia.ia_tipo_dest != ' + '''' + 'PRO' + '''' + '  -- YPA 
            and datediff(minute, ia.ia_fecha_inicio, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   ) <= ar.ar_tiempo_estandar       
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso
            and o.of_oficina in (select id_office from #office_table)           
            group by ia.ia_codigo_act, ia.ia_nombre_act, r.codigo, r.valor, o.of_oficina, o.of_nombre
            
            -- Numero actividades inciadas y ejecutadas a retrasadas
            select ia.ia_codigo_act, ia.ia_nombre_act, count(1) aTiempo, r.codigo codigo_regional, r.valor  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, 
			wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, 
			wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                       
			from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso 
			and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                       from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and ia.ia_fecha_fin is null    
			and ia.ia_tipo_dest != ' + '''' + 'PRO'  + '''' + ' -- YPA 
			and datediff(minute, ia.ia_fecha_inicio, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   )  > ar.ar_tiempo_estandar       
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso
            and o.of_oficina in (select id_office from #office_table)           
            group by ia.ia_codigo_act, ia.ia_nombre_act, r.codigo, r.valor, o.of_oficina, o.of_nombre 
            
            -- Procesos por version iniciados a tiempo (no aplica)
            select ' + '''' + 'a' + '''' + ' = null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Procesos por version iniciados atrasados (no aplica)
            select ' + '''' + 'a' + '''' + ' = null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Numero actividades completadas a tiempo
            select ia.ia_codigo_act, 
            ia.ia_nombre_act, 
            count(1) aTiempo, 
            r.codigo codigo_regional, 
            r.valor  nombre_regional, 
            o.of_oficina codigo_oficina, 
            o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
			wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
			wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                                                                                                     from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
			cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                                     
			from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and (ia.ia_fecha_fin is not null or ( ia.ia_fecha_fin is null and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
            and datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio 
			   )  <= ar.ar_tiempo_estandar 
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso
            and o.of_oficina in (select id_office from #office_table)               
            group by ia.ia_codigo_act, ia.ia_nombre_act, r.codigo, r.valor, o.of_oficina, o.of_nombre 
            
            -- Numero actividades completadas con retraso
            select ia.ia_codigo_act, 
            ia.ia_nombre_act, 
            count(1) retrasadas, 
            r.codigo codigo_regional, 
            r.valor  nombre_regional, 
            o.of_oficina codigo_oficina, 
            o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
			wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
			wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia   
			from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
			cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                                        
			from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and (ia.ia_fecha_fin is not null or ( ia.ia_fecha_fin is null and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
            and datediff(minute, ia_fecha_inicio, ia_fecha_fin)-(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio 
			   )  > ar.ar_tiempo_estandar 
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso    
            and o.of_oficina in (select id_office from #office_table)   
            group by ia.ia_codigo_act, ia.ia_nombre_act, r.codigo, r.valor, o.of_oficina, o.of_nombre 
		
		end
		else
        begin
		
		      -- Resumen para tacometro
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Actividades a tiempo
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Actividades a atrasadas
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Procesos por version iniciados a tiempo
            select io_codigo_proc, io_version_proc, count(1), r.codigo codigo_regional, r.valor  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_inst_proceso io
            inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
			cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                       
			from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            where io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
            and io_codigo_proc = @i_codigo_proceso
            and datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   ) <= pr_tiempo_estandar
            and o.of_oficina in (select id_office from #office_table)
            group by io_codigo_proc, io_version_proc, r.codigo, r.valor, o.of_oficina, o.of_nombre
            order by r.valor, o.of_nombre, io_codigo_proc, io_version_proc desc
            
            -- Procesos por version iniciados atrasados
             select io_codigo_proc, io_version_proc, count(1), r.codigo codigo_regional, r.valor  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_inst_proceso io
            inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
			cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                       
			from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
            where io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
            and io_codigo_proc = @i_codigo_proceso
            and datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   ) > pr_tiempo_estandar
            and o.of_oficina in (select id_office from #office_table)
            group by io_codigo_proc, io_version_proc, r.codigo, r.valor, o.of_oficina, o.of_nombre
            order by r.valor, o.of_nombre, io_codigo_proc, io_version_proc desc
            
            -- Actividades completadas a tiempo
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Actividades completadas atrasadas
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
		
		
		end
		
		
	end
	else
	begin
	
	     if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + '
         begin
		 
		          select            
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(rr_tiempo_real / (rr_num_a_tiempo + rr_num_retrasados)) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso and rr_fecha <> ' + '''' + '99999999' + '''' + '
                and ((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' 
				+ ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
				substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
                or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + '))
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and rr_version_proceso = @i_version_proceso))
                ),
                -- El tiempo maximo para un proceso determinado
                (select max(rr_tiempo_max) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso and rr_fecha <> ' + '''' + '99999999' + '''' + '
                and ((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' 
				+ ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
				substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
                or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + '))
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and rr_version_proceso = @i_version_proceso))
                ),
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso) 
		 
		 end
		 else if @i_type = ' + '''' + 'PROCESSVERSION' + '''' + '
         begin
		 
		           -- Total instancias de proceso abiertas por versión de proceso 
                   -- Columnas: código del proceso, versión  del proceso, total instancias a tiempo, total instancias atrasadas
                   select q1.codigo_proceso, q1.version_proceso,q1.a, q1.b, q1.c, q2.cancelados, q2.suspendidos,q1.codigo_regional, q1.nombre_regional, 
		           q1.codigo_oficina, q1.nombre_oficina  from 
                     (select 
				             r.codigo codigo_regional,
							 r.valor  nombre_regional,
							 o.of_oficina codigo_oficina,
							 o.of_nombre nombre_oficina,
							 p.pr_codigo_proceso codigo_proceso, 
							 p.pr_nombre_proceso nombre_proceso,
							 re.rr_version_proceso version_proceso,
							 sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_a_tiempo else 0 end) a, 
							 sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_retrasados else 0 end)b,
							 (sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_tiempo_real else 0 end) / 
							 case when sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_a_tiempo + rr_num_retrasados else 0 end) = 0 then 1 else
							 (sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_a_tiempo + rr_num_retrasados else 0 end)) end) c
							 from wf_proceso p
							 inner join wf_r_proceso re     on re.rr_codigo_proceso = p.pr_codigo_proceso
							 inner join cobis..cl_oficina o on o.of_oficina = re.rr_oficina
							 inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
							 cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                 
							 from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional = r.codigo
							 where pr_codigo_proceso = @i_codigo_proceso
							 and o.of_oficina in (select id_office from #office_table)
							 and  ((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' 
							 + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
							 substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
							 or   (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + ')
							 or   rr_version_proceso in (select io_version_proc from wf_inst_proceso where io_estado in (' + '''' + 'CAN' + '''' + ',' + '''' + 'SUS' + '''' + ') and io_codigo_proc = @i_codigo_proceso))
							 group by r.codigo,r.valor,o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso, re.rr_version_proceso	 
                    )   q1 
					left join 
					(select
                             r.codigo codigo_regional,
							 r.valor nombre_regional,
							 o.of_oficina codigo_oficina,
							 o.of_nombre nombre_oficina,
							 p.pr_codigo_proceso codigo_proceso, 
							 p.pr_nombre_proceso nombre_proceso,
							 i.io_version_proc version_proceso,
							 count(case when i.io_estado =' + '''' + 'CAN' + '''' + ' and ((@i_use_date_range = ' + '''' + 'S' + '''' 
							 + ' and (io_fecha_crea between @i_start_date and @i_end_date)) or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' )) 
							 then 1 end) cancelados,
							 count(case when i.io_estado =' + '''' + 'SUS' + '''' + ' and ((@i_use_date_range = ' + '''' + 'S' + '''' 
							 + ' and (io_fecha_crea between @i_start_date and @i_end_date)) or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' )) 
							 then 1 end) suspendidos
							 from wf_proceso p
							 inner join wf_inst_proceso i on i.io_codigo_proc = p.pr_codigo_proceso
							 inner join cobis..cl_oficina o on o.of_oficina = i.io_oficina_inicio
							 inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, cobis..cl_catalogo.culture, 
							 cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type      from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional=r.codigo
							 where p.pr_codigo_proceso = @i_codigo_proceso
							 and o.of_oficina in (select id_office from #office_table)
							 group by r.codigo,r.valor,o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso,i.io_version_proc
					)  q2 on q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina=q2.codigo_oficina and q1.codigo_proceso = q2.codigo_proceso and 
							 q1.version_proceso=q2.version_proceso
							 order by q1.nombre_regional,q1.nombre_oficina,q1.codigo_proceso, q1.version_proceso
							 		 
		 end
		 else if @i_version_proceso <> 0
         begin
		         print ' + '''' + 'Entro a version' + '''' + '
            select            
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(rr_tiempo_real / (rr_num_a_tiempo + rr_num_retrasados)) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso 
                and rr_version_proceso = @i_version_proceso
                and rr_fecha <> ' + '''' + '99999999' + '''' + '),
                -- El tiempo maximo para un proceso determinado
                (select max(rr_tiempo_max) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso 
                and rr_version_proceso = @i_version_proceso
                and rr_fecha <> ' + '''' + '99999999' + '''' + '),
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso)
            -- Actividades Completadas
            print '+ '''' + 'Entro a actividades completadas' + '''' + '
            select 
                da_codigo_actividad, 
                ac_nombre_actividad,            
                sum(da_num_a_tiempo), 
                sum(da_num_retrasadas), 
                (sum(da_tiempo_real) / ( sum(da_num_a_tiempo) + sum(da_num_retrasadas)))
            from wf_r_actividades_proc, wf_actividad
            where da_codigo_proceso = @i_codigo_proceso and 
            da_codigo_actividad = ac_codigo_actividad and
            da_fecha <> ' + '''' + '99999999' + '''' + '
            group by da_codigo_actividad, ac_nombre_actividad   
		
		
		 end
		 else
         begin
		         select            
                ' + '''' + 'a' + '''' + ' = null,
                ' + '''' + 'b' + '''' + ' = null,
                ' + '''' + 'c' + '''' + ' = null
            from wf_r_actividades_proc, wf_actividad
            where 1=2
            -- Numero procesos completados a tiempo
            select 
                ' + '''' + 'a' + '''' + ' = null,
                ' + '''' + 'b' + '''' + ' = null,
                ' + '''' + 'c' + '''' + ' = null,
                ' + '''' + 'd' + '''' + ' = null,
                ' + '''' + 'e' + '''' + ' = null,
                ' + '''' + 'f' + '''' + ' = null
            from wf_r_actividades_proc, wf_actividad
            where 1=2
            -- Hack 
            select 
                ' + '''' + 'a' + '''' + ' = null,
                ' + '''' + 'b' + '''' + ' = null,
                ' + '''' + 'c' + '''' + ' = null,
                ' + '''' + 'd' + '''' + ' = null,
                ' + '''' + 'e' + '''' + ' = null
            from wf_r_actividades_proc, wf_actividad
            where 1=2
            -- Procesos por version completados a tiempo y retrasados
            select 
                pr.pr_codigo_proceso, 
                rr.rr_version_proceso,
                sum(rr.rr_num_a_tiempo), 
                sum(rr.rr_num_retrasados), 
                (sum(rr.rr_tiempo_real) / (sum(rr.rr_num_a_tiempo) + sum(rr.rr_num_retrasados))),
                r.codigo codigo_regional,
                r.valor  nombre_regional,
                o.of_oficina codigo_oficina,
                o.of_nombre nombre_oficina
            from wf_proceso pr
            inner join wf_r_proceso rr on pr.pr_codigo_proceso = rr.rr_codigo_proceso
            inner join cobis..cl_oficina o on o.of_oficina = rr.rr_oficina
            inner join (select cobis..cl_catalogo.tabla, cobis..cl_catalogo.codigo, cobis..cl_catalogo.valor, cobis..cl_catalogo.estado, 
			cobis..cl_catalogo.culture, cobis..cl_catalogo.equiv_code, cobis..cl_catalogo.type                                                                                                                                                             
			from cobis..cl_catalogo where tabla = @w_table_code) r on  o.of_regional = r.codigo
            and  pr_codigo_proceso = @i_codigo_proceso
            and rr_fecha <> ' + '''' + '99999999' + '''' + '
            and o.of_oficina in (select id_office from #office_table)
            group by pr_codigo_proceso, rr_version_proceso, r.codigo, r.valor, o.of_oficina, o.of_nombre
            order by  r.valor,o.of_nombre, pr.pr_codigo_proceso, rr.rr_version_proceso 
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


CREATE PROCEDURE sp_process_detail
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
  @i_date_indicator     char(8)     = ' + '''' + '99999999' + '''' + ',
  @i_use_date_range     char(1)     = ' + '''' + 'N' + '''' + ',
  @i_start_date         date        = null,
  @i_end_date           date        = null,
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
    if @i_oficina <>' + '''' + '' + '''' + '
    begin
        declare @w_office_id int
		select @w_office_id = cast(@i_oficina as int)
		
		if @w_office_id is not null
		begin
		     insert into #office_table values (@w_office_id)
		end
	end
end

if (@i_version_proceso <= -1)
begin
    select @i_version_proceso = null
end


-- Si la operacion es de consulta.
if @i_operation = ' + '''' + 'C' + '''' + '
begin
    if @i_date_indicator = ' + '''' + '99999999' + '''' + '
    begin
        if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + '
        begin
                select
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ))
                from wf_proceso p, wf_inst_proceso ip
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso and
				io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and io_version_proc = @i_version_proceso))
                and   io_oficina_inicio in (select id_office from #office_table)
                ),
                -- El tiempo maximo para un proceso determinado
                (select max(datediff(minute, io_fecha_crea, getdate())-(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ))
                from wf_proceso p, wf_inst_proceso ip
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso
				and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and io_version_proc = @i_version_proceso))
                and io_oficina_inicio in (select id_office from #office_table)
                ),
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso)           
		
		end
		else if @i_type = ' + '''' + 'PROCESSVERSION' + '''' + '
        begin
		         -- Total instancias de proceso abiertas por versión de proceso 
            -- Columnas: código del proceso, versión  del proceso, total instancias a tiempo, total instancias atrasadas
            
            -- Consulta todos las instancias de procesos iniciadas y en ejecucion
            select q1.codigo_proceso, q1.version_proceso, q2.aTiempo, q3.atrasados, null promedios,0 cancelados,0 supendidos, q1.codigo_regional, q1.nombre_regional, q1.codigo_oficina, q1.nombre_oficina 
			from
            (
                select
                io.io_codigo_proc codigo_proceso, 
                io.io_version_proc version_proceso,
                ' + '''' + '0' + '''' + ' codigo_regional,
                ' + '''' + '' + '''' + ' nombre_regional,
                o.of_oficina codigo_oficina,
                o.of_nombre nombre_oficina
                from wf_inst_proceso io
                inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
				inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio   
				where io.io_codigo_proc = @i_codigo_proceso 
                and   io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                group by o.of_oficina,o.of_nombre, io.io_codigo_proc, io.io_version_proc 

            ) q1
            left join 
            (
                --Consulta las instancias de procesos iniciadas y en ejecucion (A Tiempo)
                select 
                io.io_codigo_proc codigo_proceso, 
                io.io_version_proc version_proceso,
                ' + '''' + '0' + '''' + ' codigo_regional,
                o.of_oficina codigo_oficina,
                count(io.io_version_proc) aTiempo
                from wf_inst_proceso io
                inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
                inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
				where io.io_codigo_proc = @i_codigo_proceso 
                and   io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                and datediff(minute, io.io_fecha_crea, getdate()) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   ) <= pr.pr_tiempo_estandar
                group by o.of_oficina,io.io_codigo_proc, io.io_version_proc
            ) q2 on q1.codigo_proceso = q2.codigo_proceso and q1.version_proceso = q2.version_proceso and q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina = q2.codigo_oficina
            left join 
            (
                --Consulta las instancias de procesos iniciadas y en ejecucion (Atrasadas)
                select 
                io.io_codigo_proc codigo_proceso, 
                io.io_version_proc version_proceso,
                ' + '''' + '0' + '''' + ' codigo_regional,
                o.of_oficina codigo_oficina,
                count(io.io_version_proc) atrasados
                from wf_inst_proceso io
                inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
                inner join cobis..cl_oficina o on o.of_oficina=io.io_oficina_inicio
				where io.io_codigo_proc = @i_codigo_proceso 
                and   io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and   o.of_oficina in (select id_office from #office_table)
                and datediff(minute, io.io_fecha_crea, getdate()) - (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   ) > pr.pr_tiempo_estandar
                group by o.of_oficina,io.io_codigo_proc, io.io_version_proc
            ) q3 on q1.codigo_proceso = q3.codigo_proceso and q1.version_proceso = q3.version_proceso and q1.codigo_regional = q3.codigo_regional and q1.codigo_oficina = q3.codigo_oficina
            order by q1.nombre_regional,q1.nombre_oficina,q1.codigo_proceso, q1.version_proceso desc
		
		
		end
		else if @i_version_proceso <> 0
        begin
		        select
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ))
                from wf_proceso p, wf_inst_proceso ip
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso and io_version_proc = @i_version_proceso and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and  io_oficina_inicio in (select id_office from #office_table)),
                
                -- El tiempo maximo para un proceso determinado
                (select max(datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = ip.io_oficina_inicio 
			   ) )
                from wf_proceso p, wf_inst_proceso ip 
                where pr_codigo_proceso = io_codigo_proc and
                io_fecha_fin is null and
                pr_codigo_proceso = @i_codigo_proceso and io_version_proc = @i_version_proceso and io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
                and  io_oficina_inicio in (select id_office from #office_table)),
                
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso) 
                
            -- Numero actividades inciadas y ejecutadas a tiempo
            select ia.ia_codigo_act, ia.ia_nombre_act, count(1) aTiempo, '+ '''' + '0' + '''' +' codigo_regional, ' + '''' + '' + '''' + ' nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, 
			wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, 
			wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                       
			from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
			and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and ia.ia_fecha_fin is null    
			and ia.ia_tipo_dest != ' + '''' + 'PRO' + '''' + '  -- YPA 
            and datediff(minute, ia.ia_fecha_inicio, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   ) <= ar.ar_tiempo_estandar       
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso
            and o.of_oficina in (select id_office from #office_table)           
            group by ia.ia_codigo_act, ia.ia_nombre_act, o.of_oficina, o.of_nombre
            
            -- Numero actividades inciadas y ejecutadas a retrasadas
            select ia.ia_codigo_act, ia.ia_nombre_act, count(1) aTiempo, ' + '''' + '0' + '''' + ' codigo_regional, ' + '''' + '' + '''' + '  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, wf_actividad_proc.ar_tiempo_estandar, 
			wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, 
			wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                       
			from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso 
			and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and ia.ia_fecha_fin is null    
			and ia.ia_tipo_dest != ' + '''' + 'PRO'  + '''' + ' -- YPA 
			and datediff(minute, ia.ia_fecha_inicio, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   )  > ar.ar_tiempo_estandar       
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso
            and o.of_oficina in (select id_office from #office_table)           
            group by ia.ia_codigo_act, ia.ia_nombre_act, o.of_oficina, o.of_nombre 
            
            -- Procesos por version iniciados a tiempo (no aplica)
            select ' + '''' + 'a' + '''' + ' = null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Procesos por version iniciados atrasados (no aplica)
            select ' + '''' + 'a' + '''' + ' = null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Numero actividades completadas a tiempo
            select ia.ia_codigo_act, 
            ia.ia_nombre_act, 
            count(1) aTiempo, 
            ' + '''' + '0' + '''' + ' codigo_regional, 
            ' + '''' + '' + '''' + '  nombre_regional, 
            o.of_oficina codigo_oficina, 
            o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
			wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
			wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia                                                                                                                                                     from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and (ia.ia_fecha_fin is not null or ( ia.ia_fecha_fin is null and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
            and datediff(minute, ia_fecha_inicio, ia_fecha_fin) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio 
			   )  <= ar.ar_tiempo_estandar 
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso
            and o.of_oficina in (select id_office from #office_table)               
            group by ia.ia_codigo_act, ia.ia_nombre_act, o.of_oficina, o.of_nombre 
            
            -- Numero actividades completadas con retraso
            select ia.ia_codigo_act, 
            ia.ia_nombre_act, 
            count(1) retrasadas, 
            ' + '''' + '0' + '''' + ' codigo_regional, 
            ' + '''' + '' + '''' + '  nombre_regional, 
            o.of_oficina codigo_oficina, 
            o.of_nombre nombre_oficina
            from   wf_inst_actividad ia
            inner join wf_inst_proceso io on  ia.ia_id_inst_proc=io.io_id_inst_proc
            inner join (select wf_actividad_proc.ar_codigo_actividad, wf_actividad_proc.ar_codigo_proceso, wf_actividad_proc.ar_version_proceso, 
			wf_actividad_proc.ar_tiempo_estandar, wf_actividad_proc.ar_tiempo_efectivo, wf_actividad_proc.ar_costo_act_proc, wf_actividad_proc.ar_suspendida, 
			wf_actividad_proc.ar_ayuda_operativa, wf_actividad_proc.ar_func_asociada, wf_actividad_proc.ar_inst_exce, wf_actividad_proc.ar_margen_tolerancia   
			from wf_actividad_proc where ar_codigo_proceso=@i_codigo_proceso and ar_version_proceso=@i_version_proceso) ar on ia.ia_codigo_act = ar.ar_codigo_actividad
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            and io.io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')            
            and (ia.ia_fecha_fin is not null or ( ia.ia_fecha_fin is null and isnull(ia_tipo_dest,' + '''' + 'OTR' + '''' + ') = ' + '''' + 'PRO' + '''' + '))
            and datediff(minute, ia_fecha_inicio, ia_fecha_fin)-(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ia.ia_fecha_inicio and df_fecha<= ia.ia_fecha_fin and ofi.of_oficina = io.io_oficina_inicio 
			   )  > ar.ar_tiempo_estandar 
            and io.io_codigo_proc  =  @i_codigo_proceso
            and io.io_version_proc =  @i_version_proceso    
            and o.of_oficina in (select id_office from #office_table)   
            group by ia.ia_codigo_act, ia.ia_nombre_act, o.of_oficina, o.of_nombre 
		
		end
		else
        begin
		
		      -- Resumen para tacometro
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Actividades a tiempo
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Actividades a atrasadas
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Procesos por version iniciados a tiempo
            select io_codigo_proc, io_version_proc, count(1), ' + '''' + '0' + '''' + ' codigo_regional, ' + '''' + '' + '''' + '  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_inst_proceso io
            inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio		
			where io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
            and io_codigo_proc = @i_codigo_proceso
            and datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   ) <= pr_tiempo_estandar
            and o.of_oficina in (select id_office from #office_table)
            group by io_codigo_proc, io_version_proc, o.of_oficina, o.of_nombre
            order by o.of_nombre, io_codigo_proc, io_version_proc desc
            
            -- Procesos por version iniciados atrasados
             select io_codigo_proc, io_version_proc, count(1), ' + '''' + '0' + '''' + ' codigo_regional, ' + '''' + '' + '''' + '  nombre_regional, o.of_oficina codigo_oficina, o.of_nombre nombre_oficina
            from wf_inst_proceso io
            inner join wf_proceso pr on pr.pr_codigo_proceso = io.io_codigo_proc
            inner join cobis..cl_oficina o on o.of_oficina = io.io_oficina_inicio
            where io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
            and io_codigo_proc = @i_codigo_proceso
            and datediff(minute, io_fecha_crea, getdate()) -(
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= io.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = io.io_oficina_inicio 
			   ) > pr_tiempo_estandar
            and o.of_oficina in (select id_office from #office_table)
            group by io_codigo_proc, io_version_proc, o.of_oficina, o.of_nombre
            order by o.of_nombre, io_codigo_proc, io_version_proc desc
            
            -- Actividades completadas a tiempo
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
            
            -- Actividades completadas atrasadas
            select ' + '''' + 'a' + '''' + '=null, ' + '''' + 'b' + '''' + ' = null, ' + '''' + 'c' + '''' + ' = null where 1=2
		
		
		end
	end
	else
	begin
	
	     if @i_type = ' + '''' + 'GAUGESUMMARY' + '''' + '
         begin
		 
		          select            
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(rr_tiempo_real / (rr_num_a_tiempo + rr_num_retrasados)) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso and rr_fecha <> ' + '''' + '99999999' + '''' + '
                and ((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
				substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
                or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + '))
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and rr_version_proceso = @i_version_proceso))
                ),
                -- El tiempo maximo para un proceso determinado
                (select max(rr_tiempo_max) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso and rr_fecha <> ' + '''' + '99999999' + '''' + '
                and ((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
				substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
                or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + '))
                and (@i_version_proceso = null
                or (@i_version_proceso <> null and rr_version_proceso = @i_version_proceso))
                ),
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso) 
		 
		 end
		 else if @i_type = ' + '''' + 'PROCESSVERSION' + '''' + '
         begin
		 
		           -- Total instancias de proceso abiertas por versión de proceso 
                   -- Columnas: código del proceso, versión  del proceso, total instancias a tiempo, total instancias atrasadas
                   select q1.codigo_proceso, q1.version_proceso,q1.a, q1.b, q1.c, q2.cancelados, q2.suspendidos,q1.codigo_regional, q1.nombre_regional, 
		           q1.codigo_oficina, q1.nombre_oficina  from 
                     (select 
				             ' + '''' + '0' + '''' + ' codigo_regional,
							 ' + '''' + '' + '''' + ' nombre_regional,
							 o.of_oficina codigo_oficina,
							 o.of_nombre nombre_oficina,
							 p.pr_codigo_proceso codigo_proceso, 
							 p.pr_nombre_proceso nombre_proceso,
							 re.rr_version_proceso version_proceso,
							 sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_a_tiempo else 0 end) a, 
							 sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_retrasados else 0 end)b,
							 (sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_tiempo_real else 0 end) / 
							 case when sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_a_tiempo + rr_num_retrasados else 0 end) = 0 then 1 else
							 (sum(case when rr_fecha <> ' + '''' + '99999999' + '''' + ' then rr_num_a_tiempo + rr_num_retrasados else 0 end)) end) c
							 from wf_proceso p
							 inner join wf_r_proceso re     on re.rr_codigo_proceso = p.pr_codigo_proceso
							 inner join cobis..cl_oficina o on o.of_oficina = re.rr_oficina
							 where pr_codigo_proceso = @i_codigo_proceso
							 and o.of_oficina in (select id_office from #office_table)
							 and  ((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' 
							 + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
							 substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
							 or   (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + ')
							 or   rr_version_proceso in (select io_version_proc from wf_inst_proceso where io_estado in (' + '''' + 'CAN' + '''' + ',' + '''' + 'SUS' + '''' + ') and io_codigo_proc = @i_codigo_proceso))
							 group by o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso, re.rr_version_proceso	 
                    )   q1 
					left join 
					(select
                             ' + '''' + '0' + '''' + ' codigo_regional,
							 ' + '''' + '' + '''' + ' nombre_regional,
							 o.of_oficina codigo_oficina,
							 o.of_nombre nombre_oficina,
							 p.pr_codigo_proceso codigo_proceso, 
							 p.pr_nombre_proceso nombre_proceso,
							 i.io_version_proc version_proceso,
							 count(case when i.io_estado =' + '''' + 'CAN' + '''' + ' and ((@i_use_date_range = ' + '''' + 'S' + '''' 
							 + ' and (io_fecha_crea between @i_start_date and @i_end_date)) or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' )) 
							 then 1 end) cancelados,
							 count(case when i.io_estado =' + '''' + 'SUS' + '''' + ' and ((@i_use_date_range = ' + '''' + 'S' + '''' 
							 + ' and (io_fecha_crea between @i_start_date and @i_end_date)) or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' )) 
							 then 1 end) suspendidos
							 from wf_proceso p
							 inner join wf_inst_proceso i on i.io_codigo_proc = p.pr_codigo_proceso
							 inner join cobis..cl_oficina o on o.of_oficina = i.io_oficina_inicio					 
							 where p.pr_codigo_proceso = @i_codigo_proceso
							 and o.of_oficina in (select id_office from #office_table)
							 group by o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso,i.io_version_proc
					)  q2 on q1.codigo_regional = q2.codigo_regional and q1.codigo_oficina=q2.codigo_oficina and q1.codigo_proceso = q2.codigo_proceso and 
							 q1.version_proceso=q2.version_proceso
							 order by q1.nombre_regional,q1.nombre_oficina,q1.codigo_proceso, q1.version_proceso
							 		 
		 end
		 else if @i_version_proceso <> 0
         begin
		         print ' + '''' + 'Entro a version' + '''' + '
            select            
                -- Resumen para tacometro
                -- Tiempo promedio para un proceso determinado
                (select avg(rr_tiempo_real / (rr_num_a_tiempo + rr_num_retrasados)) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso 
                and rr_version_proceso = @i_version_proceso
                and rr_fecha <> ' + '''' + '99999999' + '''' + '),
                -- El tiempo maximo para un proceso determinado
                (select max(rr_tiempo_max) 
                from wf_r_proceso 
                where rr_codigo_proceso = @i_codigo_proceso 
                and rr_version_proceso = @i_version_proceso
                and rr_fecha <> ' + '''' + '99999999' + '''' + '),
                -- El tiempo estandar para un proceso determinado
                (select pr_tiempo_estandar from wf_proceso where pr_codigo_proceso = @i_codigo_proceso)
            -- Actividades Completadas
            print '+ '''' + 'Entro a actividades completadas' + '''' + '
            select 
                da_codigo_actividad, 
                ac_nombre_actividad,            
                sum(da_num_a_tiempo), 
                sum(da_num_retrasadas), 
                (sum(da_tiempo_real) / ( sum(da_num_a_tiempo) + sum(da_num_retrasadas)))
            from wf_r_actividades_proc, wf_actividad
            where da_codigo_proceso = @i_codigo_proceso and 
            da_codigo_actividad = ac_codigo_actividad and
            da_fecha <> ' + '''' + '99999999' + '''' + '
            group by da_codigo_actividad, ac_nombre_actividad   
		 end
		 else
         begin
		         select            
                ' + '''' + 'a' + '''' + ' = null,
                ' + '''' + 'b' + '''' + ' = null,
                ' + '''' + 'c' + '''' + ' = null
            from wf_r_actividades_proc, wf_actividad
            where 1=2
            -- Numero procesos completados a tiempo
            select 
                ' + '''' + 'a' + '''' + ' = null,
                ' + '''' + 'b' + '''' + ' = null,
                ' + '''' + 'c' + '''' + ' = null,
                ' + '''' + 'd' + '''' + ' = null,
                ' + '''' + 'e' + '''' + ' = null,
                ' + '''' + 'f' + '''' + ' = null
            from wf_r_actividades_proc, wf_actividad
            where 1=2
            -- Hack 
            select 
                ' + '''' + 'a' + '''' + ' = null,
                ' + '''' + 'b' + '''' + ' = null,
                ' + '''' + 'c' + '''' + ' = null,
                ' + '''' + 'd' + '''' + ' = null,
                ' + '''' + 'e' + '''' + ' = null
            from wf_r_actividades_proc, wf_actividad
            where 1=2
            -- Procesos por version completados a tiempo y retrasados
            select 
                pr.pr_codigo_proceso, 
                rr.rr_version_proceso,
                sum(rr.rr_num_a_tiempo), 
                sum(rr.rr_num_retrasados), 
                (sum(rr.rr_tiempo_real) / (sum(rr.rr_num_a_tiempo) + sum(rr.rr_num_retrasados))),
                ' + '''' + '0' + '''' + ' codigo_regional,
                ' + '''' + '' + '''' + '  nombre_regional,
                o.of_oficina codigo_oficina,
                o.of_nombre nombre_oficina
            from wf_proceso pr
            inner join wf_r_proceso rr on pr.pr_codigo_proceso = rr.rr_codigo_proceso
            inner join cobis..cl_oficina o on o.of_oficina = rr.rr_oficina
            
			and  pr_codigo_proceso = @i_codigo_proceso
            and rr_fecha <> ' + '''' + '99999999' + '''' + '
            and o.of_oficina in (select id_office from #office_table)
            group by pr_codigo_proceso, rr_version_proceso, o.of_oficina, o.of_nombre
            order by o.of_nombre, pr.pr_codigo_proceso, rr.rr_version_proceso 
		 end
	
	end
	
end

return 0

'
)

end
go
