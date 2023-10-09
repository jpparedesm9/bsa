use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_resumen_wf')
begin
  drop procedure sp_resumen_wf
end
go
-- print 'CREANDO EL PROCEDIMIENTO sp_resumen_wf'
go
/************************************************************/
/*   ARCHIVO:         wf_resumen.sp                         */
/*   NOMBRE LOGICO:   sp_resumen_wf                         */
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

IF isnull(@w_table_code, 0) > 0
begin

exec(' 
create procedure sp_resumen_wf
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
  @i_operation          char        = ' + '''' + 'C' + '''' + ',
  @i_type               varchar(30) = null,
  @i_codigo_proceso     int         = null,
  @i_version_proceso    int         = null,
  @i_date_indicator     char(8)     = ' + '''' + '99999999' +  '''' + ',
  @i_use_date_range     char(1)     = ' + '''' + 'N' + '''' + ',
  @i_start_date         datetime    = null,
  @i_end_date           datetime    = null,
  @i_oficina            varchar(100) = null
)
As declare
  @w_sp_name            varchar(32),
  @w_position           numeric(20),
  @w_piece              varchar(50),
  @w_table_code         int,
  @w_ins_canceladas     int 

--Nombre del SP
select @w_sp_name = ' + '''' + 'sp_resumen_wf' + '''' + '

--se valida si vienen fechas
if @i_start_date is not null OR @i_end_date is not null
begin 
         select @i_use_date_range  = ' + '''' + 'S' + '''' + '
end 


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
        SET @w_position = charindex('+ '''' + ',' + '''' + ' , @i_oficina)
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

-- Si la operacion es de consulta.
if @i_operation = ' + '''' + 'C' + '''' + '
begin

    if @i_date_indicator = ' + '''' + '99999999' + '''' + '
    begin

        delete from wf_temp_statistics_active
		     
        -- Total instancias de proceso abiertas (para todos los procesos). 
        -- Columnas: código del proceso, nombre del proceso, total instancias a tiempo,  
		-- total instancias atrasadas,tiempo promedio procesos activos,codigo regional,nombre regional,codigo oficina, nombre oficina
        insert into wf_temp_statistics_active
		select pr_codigo_proceso, 
               pr_nombre_proceso, 
               count(case when 
			   
			   datediff(minute, io_fecha_crea, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   )
			   <= pr.pr_tiempo_estandar then 1 end) aTiempo,
               count(case when 
			   datediff(minute, io_fecha_crea, getdate())- (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   )
			   >  pr.pr_tiempo_estandar then 1 end) atrasados,
               null, 
               0 cancelados,
               0 suspendidos,
               r.codigo codigo_regional,
               r.valor  nombre_regional,
               o.of_oficina codigo_oficina,
               o.of_nombre nombre_oficina
        from  wf_inst_proceso ip
              inner join wf_proceso pr on ip.io_codigo_proc = pr.pr_codigo_proceso
              inner join cobis..cl_oficina o on o.of_oficina=ip.io_oficina_inicio
              inner join cobis..cl_catalogo r on tabla = @w_table_code and o.of_regional=r.codigo
        where io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
        and   ip.io_oficina_inicio in (select id_office from #office_table)
        group by r.codigo,r.valor,o.of_oficina,o.of_nombre,pr.pr_codigo_proceso, pr.pr_nombre_proceso
        order by r.valor,o.of_nombre,pr_codigo_proceso
		
		
		--Total instancias de proceso abiertas (para todos los procesos)
		select sum(aTiempo), sum(atrasados) from wf_temp_statistics_active
		
		-- Total instancias de proceso abiertas (para todos los procesos). 
		select pr_codigo_proceso, pr_nombre_proceso, aTiempo, atrasados, promedio, cancelados, 
		suspendidos, codigo_regional, nombre_regional, codigo_oficina, nombre_oficina
		from wf_temp_statistics_active  order by pr_nombre_proceso, nombre_oficina
        
    end
    else
    begin
    
	
	delete from wf_temp_statistics_inactive
	
        -- Total instancias de proceso completadas (para todos los procesos)
        select count(rr_num_a_tiempo), count(rr_num_retrasados) from wf_r_proceso where rr_fecha <> ' + '''' + '99999999' + '''' + '
        
        select @w_ins_canceladas  = count(*)
        from   wf_proceso p
               inner join wf_r_proceso re     on re.rr_codigo_proceso = p.pr_codigo_proceso
               inner join cobis..cl_oficina o on o.of_oficina = re.rr_oficina
        where (((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/'+ '''' + ' + 
		substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
        or    (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + ')) 
		and p.pr_codigo_proceso in (select io_codigo_proc from wf_inst_proceso 
		                                         where io_estado in (' + '''' + 'CAN' + '''' + ',' + '''' + 'SUS' +'''' + ',' + '''' + 'TER' + '''' + ')
                                                 and io_codigo_proc = p.pr_codigo_proceso))
        and re.rr_oficina in (select id_office from #office_table)
        
        if @w_ins_canceladas  >0 
        begin
           --Query que saca los procesos cancelados y suspendidos
		   
		   insert into wf_temp_statistics_inactive
		   select q1.codigo_proceso, 
                  q1.nombre_proceso, 
                  q2.a_tiempo , 
                  q2.restrasados, 
                  q2.tiempo_promedio, 
                  q1.cancelados, 
                  q1.suspendidos, 
                  q1.codigo_regional,
                  q1.nombre_regional,
                  q1.codigo_oficina,
                  q1.nombre_oficina 
           from (select r.codigo codigo_regional,
                        r.valor nombre_regional,
                        o.of_oficina codigo_oficina,
                        o.of_nombre nombre_oficina,
                        p.pr_codigo_proceso codigo_proceso, 
                        p.pr_nombre_proceso nombre_proceso,
                        count(case when i.io_estado =' + '''' + 'CAN' + '''' + ' then 1 end) cancelados,
                        count(case when i.io_estado =' + '''' + 'SUS' + '''' + ' then 1 end) suspendidos
                 from   wf_proceso p
                        inner join wf_inst_proceso i on i.io_codigo_proc = p.pr_codigo_proceso
                        inner join cobis..cl_oficina o on o.of_oficina = i.io_oficina_inicio
                        inner join cobis..cl_catalogo r on tabla = @w_table_code and  o.of_regional=r.codigo
                 where o.of_oficina in (select id_office from #office_table)
                 group by r.codigo,r.valor,o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso) q1
             
			 INNER JOIN
                 --Query que muestra los procesos a tiempo, retrasados, tiempo_promedio
                 (select r.codigo codigo_regional,
                         r.valor  nombre_regional,
                         o.of_oficina codigo_oficina,
                         o.of_nombre nombre_oficina,
                         p.pr_codigo_proceso codigo_proceso, 
                         p.pr_nombre_proceso nombre_proceso,
                         sum(case when re.rr_fecha <> ' + '''' + '99999999' + '''' + ' and p.pr_codigo_proceso = re.rr_codigo_proceso then re.rr_num_a_tiempo else 0 end)   a_tiempo, 
                         sum(case when re.rr_fecha <> ' + '''' + '99999999' + '''' + ' and p.pr_codigo_proceso = re.rr_codigo_proceso then re.rr_num_retrasados else 0 end) restrasados, 
                         (sum(re.rr_tiempo_real) / (sum(re.rr_num_a_tiempo) + sum(re.rr_num_retrasados))) tiempo_promedio
                  from wf_proceso p
                       inner join wf_r_proceso re     on re.rr_codigo_proceso = p.pr_codigo_proceso
                       inner join cobis..cl_oficina o on o.of_oficina = re.rr_oficina
                       inner join cobis..cl_catalogo r on tabla = @w_table_code and  o.of_regional = r.codigo
                  where ((
				  (@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
				  substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
                  or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + ') )
				  and p.pr_codigo_proceso in (select io_codigo_proc from  wf_inst_proceso 
                                                            where io_estado in (' + '''' + 'CAN' + '''' + ',' + '''' + 'SUS' + '''' + ',' + '''' + 'TER' + '''' +  ')
                                                            and io_codigo_proc = p.pr_codigo_proceso)
				)
                  and re.rr_oficina in (select id_office from #office_table)
                  group by r.codigo,r.valor,o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso) q2 on q1.codigo_proceso = q2.codigo_proceso 
				  and q1.codigo_oficina=q2.codigo_oficina
                  order by q1.nombre_regional,q1.nombre_oficina,q1.codigo_proceso
				  
				  --se filtra cuando se tiene a_tiempo, restrasados, cancelados, suspendidos en cero
				  select codigo_proceso, nombre_proceso, a_tiempo, restrasados, tiempo_promedio, cancelados, suspendidos, codigo_regional, nombre_regional,
				  codigo_oficina, nombre_oficina
				  from wf_temp_statistics_inactive
				  where a_tiempo >0 or restrasados>0 or cancelados>0 or suspendidos>0
				  order by nombre_proceso, nombre_oficina
        
       end
    end
end

return 0

')
end 
ELSE
begin


exec(' 

create procedure sp_resumen_wf
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
  @i_operation          char        = ' + '''' + 'C' + '''' + ',
  @i_type               varchar(30) = null,
  @i_codigo_proceso     int         = null,
  @i_version_proceso    int         = null,
  @i_date_indicator     char(8)     = ' + '''' + '99999999' +  '''' + ',
  @i_use_date_range     char(1)     = ' + '''' + 'N' + '''' + ',
  @i_start_date         datetime    = null,
  @i_end_date           datetime    = null,
  @i_oficina            varchar(100) = null
)
As declare
  @w_sp_name            varchar(32),
  @w_position           numeric(20),
  @w_piece              varchar(50),
  @w_table_code         int,
  @w_ins_canceladas     int 

--Nombre del SP
select @w_sp_name = ' + '''' + 'sp_resumen_wf' + '''' + '

--se valida si vienen fechas
if @i_start_date is not null OR @i_end_date is not null
begin 
         select @i_use_date_range  = ' + '''' + 'S' + '''' + '
end 


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
        SET @w_position = charindex('+ '''' + ',' + '''' + ' , @i_oficina)
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

-- Si la operacion es de consulta.
if @i_operation = ' + '''' + 'C' + '''' + '
begin

    if @i_date_indicator = ' + '''' + '99999999' + '''' + '
    begin

        delete from wf_temp_statistics_active
		     
        -- Total instancias de proceso abiertas (para todos los procesos). 
        -- Columnas: código del proceso, nombre del proceso, total instancias a tiempo,  
		-- total instancias atrasadas,tiempo promedio procesos activos,codigo regional,nombre regional,codigo oficina, nombre oficina
        insert into wf_temp_statistics_active
		select pr_codigo_proceso, 
               pr_nombre_proceso, 
               count(case when 
			   
			   datediff(minute, io_fecha_crea, getdate()) - (
							select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   )
			   <= pr.pr_tiempo_estandar then 1 end) aTiempo,
               count(case when 
			   datediff(minute, io_fecha_crea, getdate())- (
			               select count(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
			               where df_fecha >= ip.io_fecha_crea and df_fecha<= getdate() and ofi.of_oficina = o.of_oficina
			   )
			   >  pr.pr_tiempo_estandar then 1 end) atrasados,
               null, 
               0 cancelados,
               0 suspendidos,
               ' + '''' + '0' + '''' + ' codigo_regional,
               ' + '''' + '' + '''' + ' nombre_regional,
               o.of_oficina codigo_oficina,
               o.of_nombre nombre_oficina
        from  wf_inst_proceso ip
              inner join wf_proceso pr on ip.io_codigo_proc = pr.pr_codigo_proceso
              inner join cobis..cl_oficina o on o.of_oficina=ip.io_oficina_inicio
        where io_estado in (' + '''' + 'INI' + '''' + ',' + '''' + 'EJE' + '''' + ')
        and   ip.io_oficina_inicio in (select id_office from #office_table)
        group by o.of_oficina,o.of_nombre,pr.pr_codigo_proceso, pr.pr_nombre_proceso
        order by o.of_nombre,pr_codigo_proceso
		
		
		--Total instancias de proceso abiertas (para todos los procesos)
		select sum(aTiempo), sum(atrasados) from wf_temp_statistics_active
		
		-- Total instancias de proceso abiertas (para todos los procesos). 
		select pr_codigo_proceso, pr_nombre_proceso, aTiempo, atrasados, promedio, cancelados, 
		suspendidos, codigo_regional, nombre_regional, codigo_oficina, nombre_oficina
		from wf_temp_statistics_active  order by pr_nombre_proceso, nombre_oficina
        
    end
    else
    begin
    
	
	delete from wf_temp_statistics_inactive
	
        -- Total instancias de proceso completadas (para todos los procesos)
        select count(rr_num_a_tiempo), count(rr_num_retrasados) from wf_r_proceso where rr_fecha <> ' + '''' + '99999999' + '''' + '
        
        select @w_ins_canceladas  = count(*)
        from   wf_proceso p
               inner join wf_r_proceso re     on re.rr_codigo_proceso = p.pr_codigo_proceso
               inner join cobis..cl_oficina o on o.of_oficina = re.rr_oficina
        where (((@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/'+ '''' + ' + 
		substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
        or    (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + ')) 
		and p.pr_codigo_proceso in (select io_codigo_proc from wf_inst_proceso 
		                                         where io_estado in (' + '''' + 'CAN' + '''' + ',' + '''' + 'SUS' +'''' + ',' + '''' + 'TER' + '''' + ')
                                                 and io_codigo_proc = p.pr_codigo_proceso))
        and re.rr_oficina in (select id_office from #office_table)
        
        if @w_ins_canceladas  >0 
        begin
           --Query que saca los procesos cancelados y suspendidos
		   
		   insert into wf_temp_statistics_inactive
		   select q1.codigo_proceso, 
                  q1.nombre_proceso, 
                  q2.a_tiempo , 
                  q2.restrasados, 
                  q2.tiempo_promedio, 
                  q1.cancelados, 
                  q1.suspendidos, 
                  q1.codigo_regional,
                  q1.nombre_regional,
                  q1.codigo_oficina,
                  q1.nombre_oficina 
           from (select ' + '''' + '0' + '''' + ' codigo_regional,
                        ' + '''' + '' + '''' + ' nombre_regional,
                        o.of_oficina codigo_oficina,
                        o.of_nombre nombre_oficina,
                        p.pr_codigo_proceso codigo_proceso, 
                        p.pr_nombre_proceso nombre_proceso,
                        count(case when i.io_estado =' + '''' + 'CAN' + '''' + ' then 1 end) cancelados,
                        count(case when i.io_estado =' + '''' + 'SUS' + '''' + ' then 1 end) suspendidos
                 from   wf_proceso p
                        inner join wf_inst_proceso i on i.io_codigo_proc = p.pr_codigo_proceso
                        inner join cobis..cl_oficina o on o.of_oficina = i.io_oficina_inicio
                 where o.of_oficina in (select id_office from #office_table)
                 group by o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso) q1
             
			 INNER JOIN
                 --Query que muestra los procesos a tiempo, retrasados, tiempo_promedio
                 (select ' + '''' + '0' + '''' + ' codigo_regional,
                        ' + '''' + '' + '''' + ' nombre_regional,
                         o.of_oficina codigo_oficina,
                         o.of_nombre nombre_oficina,
                         p.pr_codigo_proceso codigo_proceso, 
                         p.pr_nombre_proceso nombre_proceso,
                         sum(case when re.rr_fecha <> ' + '''' + '99999999' + '''' + ' and p.pr_codigo_proceso = re.rr_codigo_proceso then re.rr_num_a_tiempo else 0 end)   a_tiempo, 
                         sum(case when re.rr_fecha <> ' + '''' + '99999999' + '''' + ' and p.pr_codigo_proceso = re.rr_codigo_proceso then re.rr_num_retrasados else 0 end) restrasados, 
                         (sum(re.rr_tiempo_real) / (sum(re.rr_num_a_tiempo) + sum(re.rr_num_retrasados))) tiempo_promedio
                  from wf_proceso p
                       inner join wf_r_proceso re     on re.rr_codigo_proceso = p.pr_codigo_proceso
                       inner join cobis..cl_oficina o on o.of_oficina = re.rr_oficina
                  where ((
				  (@i_use_date_range = ' + '''' + 'S' + '''' + ' and (rr_fecha <> ' + '''' + '99999999' + '''' + ' and convert(datetime, substring(rr_fecha, 7, 2) + ' + '''' + '/' + '''' + ' + substring(rr_fecha, 5, 2) + ' + '''' + '/' + '''' + ' + 
				  substring(rr_fecha, 1, 4), 103) between @i_start_date and @i_end_date))
                  or (@i_use_date_range <> ' + '''' + 'S' + '''' + ' and rr_fecha <> ' + '''' + '99999999' + '''' + ') )
				  and p.pr_codigo_proceso in (select io_codigo_proc from  wf_inst_proceso 
                                                            where io_estado in (' + '''' + 'CAN' + '''' + ',' + '''' + 'SUS' + '''' + ',' + '''' + 'TER' + '''' +  ')
                                                            and io_codigo_proc = p.pr_codigo_proceso)
				)
                  and re.rr_oficina in (select id_office from #office_table)
                  group by o.of_oficina,o.of_nombre,p.pr_codigo_proceso, p.pr_nombre_proceso) q2 on q1.codigo_proceso = q2.codigo_proceso 
				  and q1.codigo_oficina=q2.codigo_oficina
                  order by q1.nombre_regional,q1.nombre_oficina,q1.codigo_proceso
				  
				  --se filtra cuando se tiene a_tiempo, restrasados, cancelados, suspendidos en cero
				  select codigo_proceso, nombre_proceso, a_tiempo, restrasados, tiempo_promedio, cancelados, suspendidos, codigo_regional, nombre_regional,
				  codigo_oficina, nombre_oficina
				  from wf_temp_statistics_inactive
				  where a_tiempo >0 or restrasados>0 or cancelados>0 or suspendidos>0
				  order by nombre_proceso, nombre_oficina
        
       end
    end
end

return 0

')

end
go
