use cobis
go

if exists (select 1 from sysobjects
           where  name = 'sp_oficina')
  drop proc sp_oficina
go

create proc sp_oficina (
   @s_ssn           int         = NULL,
   @s_user          login       = NULL,
   @s_sesn          int         = NULL,
   @s_term          varchar(32) = NULL,
   @s_date          datetime    = NULL,
   @s_srv           varchar(30) = NULL,
   @s_lsrv          varchar(30) = NULL, 
   @s_rol           smallint    = NULL,
   @s_ofi           smallint    = NULL,
   @s_org_err       char(1)     = NULL,
   @s_error         int         = NULL,
   @s_sev           tinyint     = NULL,
   @s_msg           descripcion = NULL,
   @s_org           char(1)     = NULL,
   @t_show_version  bit         = 0,
   @t_debug         char(1)     = 'N',
   @t_file          varchar(14) = null,
   @t_from          varchar(32) = null,
   @t_trn           smallint    = null,
   @i_operacion     char(1)     = 'S',
   @i_modo          tinyint     = NULL,
   @i_tipo          char(2)     = NULL,
   @i_oficina       smallint    = NULL,
   @i_valor         descripcion = NULL,
   @i_filial        tinyint     = 1,
   @i_area          char(10)    = NULL,
   @i_descripcion   varchar(60) = NULL,
   @i_formato_fecha int         = NULL,
   @i_regional      varchar(10) = NULL,
   @i_valorcat      varchar(64) = NULL,
   @i_opcion		char(1) 	= 'N', --RAL 01.06.2016 modificaciones en oficina version BMI
   @i_criterio      varchar(30) = '%'
   
)
as
declare @w_sp_name       varchar(32),
   @o_filial             tinyint,
   @o_area               char(10),
   @o_arnombre           descripcion,
   @o_finombre           descripcion,
   @o_oficina            smallint,
   @o_lonombre           descripcion,
   @o_subtipo            char(1),
   @o_nombre             descripcion,
   @o_direccion          direccion,
   @o_ciudad             int, -- PES VERSION COLOMBIA
   @o_cinombre           descripcion,
   @o_sucursal           smallint,
   @o_sunombre           descripcion,
   @o_valor              varchar(12),
   @o_tipo               char(1),
   @o_tinombre           descripcion,
   -- DATOS ADICIONALES
   @o_regional           smallint,    --RAL 01.06.2016 modificaciones en oficina version BMI
   @o_subregional        varchar(10), --Subregional de la oficina
   @o_tip_punt_at        varchar(10),
   @o_obs_horario        varchar(255),
   @o_cir_comunic        varchar(20),
   @o_nomb_encarg        varchar(64),
   @o_ci_encarg          varchar(20),
   @o_horario            tinyint,
   @o_tipo_horar         varchar(10),
   @o_jefe_agenc         int,
   @o_cod_fie_asf        varchar(10),
   @o_fec_aut_asf        varchar(10),
   @o_sector             varchar(10),
   @o_des_regional       varchar(64),
   @o_des_subregional    varchar(64),
   @o_des_tip_punt       varchar(64),
   @o_des_horario        varchar(64),
   @o_des_tipo_horar     varchar(64),
   @o_nom_jefe_agenc     varchar(64),
   @o_des_sector         varchar(64),
   -- georeferenciacion
   @o_lat_coord          char(1),
   @o_lat_grados         float,
   @o_lat_minutos        float,
   @o_lat_segundos       float,
   @o_lon_coord          char(1),
   @o_lon_grados         float,
   @o_lon_minutos        float,
   @o_lon_segundos       float,
                         
   @o_cod_depart         varchar(10), 
   @o_des_depart         varchar(64),
   @o_cod_prov           int,
   @o_des_prov           varchar(64),
   @o_relacion_oficina   smallint,
   @o_des_relacion_ofi   descripcion,
   @o_barrio             int, --cc0009 RLA
   @o_des_barrio         descripcion, --admin cc0009 RLA
   @o_bandera			 int,
   --RAL 01.06.2016 modificaciones en oficina version BMI
   @o_zona			     smallint,    
   @o_cob			     smallint,
   @o_znombre            descripcion, 
   @o_cobnombre          descripcion, 
   @o_rnombre            descripcion,
   @w_subtipo_opcion     char(1),
   @o_bloqueada			 char(1)
   --RAL 01.06.2016 modificaciones en oficina version BMI
 

if @t_show_version = 1
begin
    print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.2'
    return 0
end

select @w_sp_name = 'sp_oficina'

-- Search
if @i_operacion='S'
-- BUSQUEDA DE TODAS LAS OFICINAS REGISTRADAS
begin
if @t_trn = 1573
begin
set rowcount 20
   if @i_modo = 0
   begin
      select
         'Filial'    = of_filial,
         'Codigo'    = of_oficina,
         'Oficina'   = substring(of_nombre, 1, 30),
         'Area'      = substring(c.valor,1,30),
         'Tipo'      = of_subtipo,
         'Direccion' = substring(of_direccion, 1, 30),
         'Distrito'  = substring(ci_descripcion, 1, 30),
		 'BLOQUEADA' = of_bloqueada
      from  cl_oficina, cl_ciudad, cl_tabla b, cl_catalogo c
      where ci_ciudad = of_ciudad
      and   b.tabla ='cl_area_oficina'
      and   b.codigo = c.tabla
      and   c.codigo = of_area
      order by of_filial, of_oficina
   end
   
   if @i_modo = 1
   begin
      select 
         'Filial'    = of_filial,
         'Codigo'    = of_oficina,
         'Oficina'   = substring(of_nombre,1,30),
         'Area'      = substring(c.valor,1,30),
         'Tipo'      = of_subtipo,
         'Direccion' = substring(of_direccion,1,30),
         'Distrito'  = substring(ci_descripcion,1,30),
		 'BLOQUEADA' = of_bloqueada
      from  cl_oficina, cl_ciudad, cl_tabla b, cl_catalogo c
      where((of_filial > @i_filial) or (of_filial = @i_filial and of_oficina > @i_oficina))
      and   b.tabla ='cl_area_oficina'
      and   b.codigo = c.tabla
      and   c.codigo = of_area
      and   ci_ciudad = of_ciudad
      order by of_filial, of_oficina

      -- ARO: 2 DE JUNIO DEL 2000: CORRECCION SIGUIENTES
      if @@rowcount=0
      Begin
         exec sp_cerror
              -- NO EXISTEN MAS DATOS
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 151121
         set rowcount 0
         return 1
      End
      -- FIN ARO
   end
   
   if @i_modo = 2 -- CODIGO
   begin
   
      select 
         'Filial'    = of_filial,
         'Codigo'    = of_oficina,
         'Oficina'   = substring(of_nombre,1,30),
         'Area'      = substring(c.valor,1,30),
         'Tipo'      = of_subtipo,
         'Direccion' = substring(of_direccion,1,30),
         'Distrito'  = substring(ci_descripcion,1,30),
		 'BLOQUEADA' = of_bloqueada
      from  cl_oficina, cl_ciudad, cl_tabla b, cl_catalogo c
      where ci_ciudad = of_ciudad
      and   b.tabla ='cl_area_oficina'
      and   b.codigo = c.tabla
      and   c.codigo = of_area
      and   of_oficina = @i_oficina
      order by of_filial, of_oficina
         
      -- ARO: 2 DE JUNIO DEL 2000: CORRECCION SIGUIENTES
      if @@rowcount=0
      Begin
         exec sp_cerror
              -- NO EXISTEN MAS DATOS
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 151121
         set rowcount 0
         return 1
      End
      
      -- Fin ARO
   end
   
   if @i_modo = 3 -- NOMBRE
   begin
      select
         'Filial'    = of_filial,
         'Codigo'    = of_oficina,
         'Oficina'   = substring(of_nombre,1,30),
         'Area'      = substring(c.valor,1,30),
         'Tipo'      = of_subtipo,
         'Direccion' = substring(of_direccion,1,30),
         'Distrito'  = substring(ci_descripcion,1,30),
		 'BLOQUEADA' = of_bloqueada
      from cl_oficina, cl_ciudad, cl_tabla b, cl_catalogo c
      where ci_ciudad = of_ciudad
      and b.tabla ='cl_area_oficina'
      and b.codigo = c.tabla
      and c.codigo = of_area
      and 
         (
         of_nombre like '%'+@i_descripcion+'%'
         or 
         of_nombre like UPPER ('%'+@i_descripcion+'%')
         or
         of_nombre like LOWER ('%'+@i_descripcion+'%')
         )
      and ((of_filial > @i_filial) or (of_filial = @i_filial and of_oficina > @i_oficina))            
      order by of_filial, of_oficina         

      -- ARO: 2 DE JUNIO DEL 2000: CORRECCION SIGUIENTES
      if @@rowcount=0
      Begin
         exec sp_cerror
              -- NO EXISTEN MAS DATOS
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 151121
         set rowcount 0
         return 1
      End
      -- FIN ARO
   end
   
    set rowcount 0
    return 0
end
else
begin
   exec sp_cerror
        -- 'NO CORRESPONDE CODIGO DE TRANSACCION'
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
   return 1
end
end

-- QUERY
-- QUERY ESPECIFICO DE DATOS
if @i_operacion='Q'
begin
if @t_trn = 1572 
begin
	select @o_bandera = 0
	
    select 
      @o_filial            = of_filial,
      @o_finombre          = fi_nombre,
      @o_subtipo           = of_subtipo,
      @o_oficina           = of_oficina,
      @o_lonombre          = of_nombre,
      @o_direccion         = of_direccion,
      @o_sucursal          = of_sucursal,  --RAL 01.06.2016 modificaciones en oficina version BMI
      @o_ciudad            = of_ciudad,
      @o_area              = of_area,
      @o_regional          = of_regional,      
      @o_tip_punt_at       = of_tip_punt_at,
      @o_obs_horario       = of_obs_horario,
      @o_cir_comunic       = of_cir_comunic,
      @o_nomb_encarg       = of_nomb_encarg,
      @o_ci_encarg         = of_ci_encarg,
      @o_horario           = of_horario,
      @o_tipo_horar        = of_tipo_horar,
      @o_jefe_agenc        = of_jefe_agenc,
      @o_cod_fie_asf       = of_cod_fie_asf,
      @o_fec_aut_asf       = convert(varchar(10),of_fec_aut_asf,@i_formato_fecha),
      @o_sector            = of_sector,
      @o_cod_depart        = of_depart_pais,  
      @o_cod_prov          = of_provincia,
      @o_relacion_oficina  = of_relac_ofic,
      @o_subregional       = of_subregional,
	  @o_barrio            = of_barrio,      --cc0009 rla
	  @o_zona 	           = of_zona,        --RAL 01.06.2016 modificaciones en oficina version BMI
	  @o_cob 		       = of_cob,          --RAL 01.06.2016 modificaciones en oficina version BMI
	  @o_bloqueada 		   = of_bloqueada          --JHGL Version fal.
   from  cl_oficina, cl_filial
   where of_oficina = @i_oficina
   and   of_filial  = fi_filial

  if @@rowcount = 0
  begin 
    -- 'NO EXISTE DATO SOLICITADO'
    exec sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 101001
    return 1
  end

  if @o_subtipo in ('A', 'R') --= 'A'       --AGENCIA o REGIONAL/TERRITORIAL  --RAL 01.06.2016 modificaciones en oficina version BMI
  begin
	select @o_sunombre = isnull(of_nombre,'')
	from   cl_oficina
	where  of_oficina = @o_sucursal
	if @@rowcount = 0
		select @o_bandera = 1
  end
  --RAL 01.06.2016 modificaciones en oficina version BMI
  else if @o_subtipo = 'O'  --OFICINA
  begin
    select @o_znombre   = isnull(a.of_nombre, ''), 
           @o_cobnombre = b.of_nombre, 
		   @o_rnombre   = c.of_nombre
    from cl_oficina a, 
	     cl_oficina b, 
		 cl_oficina c
    where a.of_oficina = @o_zona 
    and b.of_oficina   = @o_cob 
    and c.of_oficina   = @o_regional
	
	if @@rowcount = 0 select @o_bandera = 1
  end
  else if @o_subtipo = 'Z'  --ZONA
  begin
    select @o_cobnombre = isnull(a.of_nombre, ''), 
	       @o_rnombre   = b.of_nombre
    from cl_oficina a, 
	     cl_oficina b
    where a.of_oficina = @o_cob 
    and b.of_oficina   = @o_regional
	
	if @@rowcount = 0 select @o_bandera = 1
  end
  else if @o_subtipo = 'C'  --CENTRO OPERATIVO
  begin
    select @o_rnombre = isnull(of_nombre, '')
    from cl_oficina
    where of_oficina = @o_regional
	
	if @@rowcount = 0 select @o_bandera = 1
  end
  --RAL 01.06.2016 modificaciones en oficina version BMI
  /*                                                                                                                                                                                                                               
  if @@rowcount = 0
  begin
    select @o_sunombre = ''
  end
  */
  select @o_cinombre = isnull(ci_descripcion,'')
  from   cl_ciudad
  where  ci_ciudad = @o_ciudad
  if @@rowcount = 0
     select @o_bandera = 1
  
  if @o_area <> null
  begin
     select @o_arnombre = isnull(c.valor,'')
     from  cl_tabla b, cl_catalogo c      
     where b.tabla  = 'cl_area_oficina'
     and   b.codigo = c.tabla
     and   c.codigo = @o_area
	 if @@rowcount = 0
		select @o_bandera = 1
  end
  
  --RAL 01.06.2016 modificaciones en oficina version BMI
  /*
  if @o_regional <> null
  begin
     select @o_des_regional = isnull(c.valor, '')
     from   cl_tabla b, cl_catalogo c      
     where  b.tabla  = 'cl_regional'
     and    b.codigo = c.tabla
     and    c.codigo = @o_regional
	 if @@rowcount = 0
		select @o_bandera = 1
  end
  */
  --RAL 01.06.2016 modificaciones en oficina version BMI
  
  if @o_subregional <> null
  begin
     select @o_des_subregional = isnull(c.valor,'')
     from   cl_tabla b, cl_catalogo c      
     where  b.tabla  = 'cl_subregional'
     and    b.codigo = c.tabla
     and    c.codigo = @o_subregional
	 if @@rowcount = 0
		select @o_bandera = 1
  end
  
  if @o_tip_punt_at <> null
  begin
     select @o_des_tip_punt = isnull(c.valor,'')
     from   cl_tabla b, cl_catalogo c      
     where  b.tabla  = 'cl_tipo_punto_at'
     and    b.codigo = c.tabla
     and    c.codigo = @o_tip_punt_at
	 if @@rowcount = 0
		select @o_bandera = 1
  end
  
  if @o_horario <> null
  begin
     select @o_des_horario = isnull(th_descripcion,'')
     from   ad_tipo_horario
     where  th_tipo = @o_horario
     and    th_estado = 'V'
	 if @@rowcount = 0
		select @o_bandera = 1
  end

  if @o_tipo_horar <> null
  begin
     select @o_des_tipo_horar = isnull(c.valor,'')
     from   cl_tabla b, cl_catalogo c      
     where  b.tabla  = 'cl_tipo_horario'
     and    b.codigo = c.tabla
     and    c.codigo = @o_tipo_horar
	 if @@rowcount = 0
		select @o_bandera = 1
  end
  
  if @o_jefe_agenc <> null
  begin
     select @o_nom_jefe_agenc = isnull(fu_nombre,'')
     from   cl_funcionario
     where  fu_funcionario = @o_jefe_agenc
	 --if @@rowcount = 0
		--select @o_bandera = 1
  end

  if @o_sector <> null
  begin
     select @o_des_sector = isnull(c.valor,'')
     from   cl_tabla b, cl_catalogo c      
     where  b.tabla  = 'cl_sector_geografico'
     and    b.codigo = c.tabla
     and    c.codigo = @o_sector
	 if @@rowcount = 0
		select @o_bandera = 1
  end
 /*
  if @o_cod_depart <> null
  begin
     select @o_des_depart = isnull(dp_descripcion,'')
       from cl_depart_pais     
      where dp_departamento = @o_cod_depart
	  if @@rowcount = 0
		select @o_bandera = 1
  end
 */
 if @o_cod_prov <> null
  begin
     select @o_des_prov = isnull(pv_descripcion,'')
       from cl_provincia      
      where pv_provincia = @o_cod_prov
	  if @@rowcount = 0
		select @o_bandera = 1
  end
 
  if @o_relacion_oficina <> null
  begin
     select @o_des_relacion_ofi = isnull(of_nombre,'')
       from cl_oficina
      where of_oficina = @o_relacion_oficina
	  if @@rowcount = 0
		select @o_bandera = 1
  end
  
  --CC0009 rla
  if @o_barrio <> null
  begin
     select @o_des_barrio = isnull (ba_descripcion, '')
       from cl_barrio
      where ba_barrio =   @o_barrio   
      and	ba_distrito = @o_cod_prov			
	  and	ba_canton =   @o_ciudad
	  if @@rowcount = 0
		select @o_bandera = 1
  end
  
 --CC0009 rla
  select @o_filial,           @o_finombre,    @o_subtipo,        @o_oficina,        @o_lonombre,
         @o_direccion,        @o_ciudad,      @o_cinombre,       @o_sucursal,       @o_sunombre,
         @o_area,             @o_arnombre,    @o_regional,       @o_tip_punt_at,    @o_obs_horario,
         @o_cir_comunic,      @o_nomb_encarg, @o_ci_encarg,      @o_horario,        @o_tipo_horar,
         @o_jefe_agenc,       @o_cod_fie_asf, @o_fec_aut_asf,    @o_sector,         @o_des_regional,
         @o_des_tip_punt,     @o_des_horario, @o_des_tipo_horar, @o_nom_jefe_agenc, @o_des_sector,
         @o_cod_depart ,      @o_des_depart,  @o_cod_prov,       @o_des_prov,       @o_relacion_oficina,
         @o_des_relacion_ofi, @o_subregional, @o_des_subregional,@o_barrio ,        @o_des_barrio,
		 @o_zona,             @o_znombre,     @o_cob,            @o_cobnombre,      @o_rnombre,   --RAL 01.06.2016 modificaciones en oficina version BMI
		 @o_bandera,          @o_bloqueada				
  return 0
end
else
begin
   exec sp_cerror
        -- 'NO CORRESPONDE CODIGO DE TRANSACCION'
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
   return 1
end
end


-- HELP
if @i_operacion='H'
begin
if @t_trn = 1574

begin
  -- QUERY DE TODAS LAS OFICINAS DE UNA FILIAL DE 20 EN 20
   

  if @i_tipo = 'A'
  begin
    if @i_area is NULL  -- VALIDACIÓN CONSULTA POR AREA
    begin

    set rowcount 20

    if (@i_modo = 0) or (@i_modo is null)
       begin
          if @i_regional is null
             select 
                'Codigo'     = a.of_oficina,
                'Oficina'    = a.of_nombre,
                'Cod. Area'  = a.of_area,
                'Nombre Area'= c.valor
             from  cl_oficina a, cl_tabla b, cl_catalogo c
             where of_filial = @i_filial
             and   b.tabla   ='cl_area_oficina'
             and   b.codigo  = c.tabla
             and   c.codigo  = a.of_area             
             order by of_filial, of_oficina
          else
             select 
                'Codigo'     = a.of_oficina,
                'Oficina'    = a.of_nombre,
                'Cod. Area'  = a.of_area,
                'Nombre Area'= c.valor
             from  cl_oficina a, cl_tabla b, cl_catalogo c
             where of_filial = @i_filial
             and   b.tabla   ='cl_area_oficina'
             and   b.codigo  = c.tabla
             and   c.codigo  = a.of_area
             and   a.of_regional  = @i_regional
             order by of_filial, of_oficina
       end

    if @i_modo = 1 
       begin
          if @i_regional is null
             select 
                'Codigo'     = of_oficina,
                'Oficina'    = of_nombre,
                'Cod. Area'  = a.of_area,
                'Nombre Area'= c.valor
             from  cl_oficina a, cl_tabla b, cl_catalogo c
             where of_filial  = @i_filial
             and   of_oficina > @i_oficina
             and   b.tabla    ='cl_area_oficina'
             and   b.codigo   = c.tabla
             and   c.codigo   = a.of_area             
             order by of_filial, of_oficina
          else
             select 
                'Codigo'     = of_oficina,
                'Oficina'    = of_nombre,
                'Cod. Area'  = a.of_area,
                'Nombre Area'= c.valor
             from  cl_oficina a, cl_tabla b, cl_catalogo c
             where of_filial  = @i_filial
             and   of_oficina > @i_oficina
             and   b.tabla    ='cl_area_oficina'
             and   b.codigo   = c.tabla
             and   c.codigo   = a.of_area
             and   a.of_regional  = @i_regional
             order by of_filial, of_oficina
       end

     set rowcount 0
   end
  else  -- VALIDACION PARA VER POR AREAS DE OFICINAS
   begin

    set rowcount 20

    if (@i_modo = 0) or (@i_modo is null)
      select
         'Codigo'     = a.of_oficina,
         'Oficina'    = a.of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from cl_oficina a, cl_tabla b, cl_catalogo c
     where of_filial = @i_filial
      and of_area   = @i_area
      and b.tabla   ='cl_area_oficina'
      and b.codigo  = c.tabla
      and c.codigo  = a.of_area
      order by of_filial, of_oficina

    if @i_modo = 1 
      select 
         'Codigo'     = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where of_filial  = @i_filial
      and   of_area    = @i_area
      and   of_oficina > @i_oficina
      and   b.tabla    ='cl_area_oficina'
      and   b.codigo   = c.tabla
      and   c.codigo   = a.of_area
      order by of_filial, of_oficina

     set rowcount 0
  end   --  CONSULTA POR AREA

  end   -- FIN DEL TIPO A

  -- QUERY DE TODAS LAS SUCURSALES DE UNA FILIAL DE 20 EN 20
  if @i_tipo = 'S'
  begin
  
    --RAL 01.06.2016 modificaciones en oficina version BMI
	if @i_opcion = 'O'
		select @w_subtipo_opcion = 'Z'
	else if @i_opcion = 'Z'
		select @w_subtipo_opcion = 'C'
	else if @i_opcion = 'C'
		select @w_subtipo_opcion = 'R'
	--RAL 01.06.2016 modificaciones en oficina version BMI
	
    set rowcount 20

    if (@i_modo = 0) or (@i_modo is null)
      select 'Codigo' = of_oficina,
                    'Oficina' = of_nombre
        from cl_oficina /*, cl_catalogo */
       where of_filial = @i_filial
                and of_subtipo = @w_subtipo_opcion  /* Feb 13/2003 */
         and of_nombre like @i_criterio      --ADU: 2002-05-16
         and of_bloqueada = 'N'
       order by of_filial, of_oficina

    if @i_modo = 1 
      select 'Codigo' = of_oficina,
                     'Oficina' = of_nombre
        from cl_oficina /*, cl_catalogo */
       where of_filial = @i_filial
         and of_oficina > @i_oficina
                and of_subtipo = @w_subtipo_opcion
         and of_nombre like @i_criterio      --ADU: 2002-05-16
         and of_bloqueada = 'N'
       order by of_filial, of_oficina

     set rowcount 0
  end   -- DEL TIPO S

  if @i_tipo = 'V'
  begin
     if @i_regional is null
        select  of_nombre
        from   cl_oficina
        where  of_oficina = @i_oficina
        and    of_filial  = @i_filial        
     else
        select  of_nombre
        from   cl_oficina
        where  of_oficina = @i_oficina
        and    of_filial  = @i_filial
        and   of_regional  = @i_regional

    if @@rowcount = 0
    begin
      exec sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 101016
      -- 'NO EXISTE OFICINA'
      return 1
    end
  end   -- FIN DEL TIPO V
  if @i_tipo = 'B' 
  begin
    set rowcount 20

    if (@i_modo = 0) or (@i_modo is null)
   begin
      select 
         'Codigo'     = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where of_subtipo = 'S'
      and   b.tabla    ='cl_area_oficina'
      and   b.codigo   = c.tabla
      and   c.codigo   = a.of_area
      and   of_nombre like @i_valor
      order by of_filial, of_oficina
   end

    if @i_modo = 1 
      select 
         'Codigo'     = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where of_subtipo = 'S'
      and   b.tabla    ='cl_area_oficina'
      and   b.codigo   = c.tabla
      and   c.codigo   = a.of_area
      and   of_oficina > @i_oficina
      and   of_nombre like @i_valor
  order by of_filial, of_oficina

     set rowcount 0

  end  -- FIN DEL TIPO B

    -- QUERY DE TODAS LAS AGENCIAS DE UNA FILIAL DE 20 EN 20
  if @i_tipo = 'C'
  begin
    set rowcount 20

    if (@i_modo = 0) or (@i_modo is null)
      select 
         'Codigo'     = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where of_filial  = @i_filial
      and   b.tabla    ='cl_area_oficina'
      and   b.codigo   = c.tabla
      and   c.codigo   = a.of_area
      and   of_subtipo = 'A'
      order by of_filial, of_oficina

    if @i_modo = 1 
      select
         'Codigo'     = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where of_filial  = @i_filial
      and   b.tabla    ='cl_area_oficina'
      and   b.codigo   = c.tabla
      and   c.codigo   = a.of_area
      and   of_oficina > @i_oficina
      and   of_subtipo = 'A'
      order by of_filial, of_oficina

     set rowcount 0
  end   -- DEL TIPO S
  
  -- TODAS LAS OFICINAS  DE CUALQUIER FILIAL
  if @i_tipo = 'AL'
  begin
   set rowcount 20
   
   if (@i_modo = 0) or (@i_modo is null)
      select 
         'Cod.'       = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where b.tabla  ='cl_area_oficina'
      and   b.codigo = c.tabla
      and   c.codigo = a.of_area
	  and  a.of_nombre like isnull('%'+@i_valorcat+'%',a.of_nombre)
      order by of_oficina
   if @i_modo = 1
      select 
         'Cod.'       = of_oficina,
         'Oficina'    = of_nombre,
         'Cod. Area'  = a.of_area,
         'Nombre Area'= c.valor
      from  cl_oficina a, cl_tabla b, cl_catalogo c
      where of_oficina > @i_oficina
      and   b.tabla  ='cl_area_oficina'
      and   b.codigo = c.tabla
      and   c.codigo = a.of_area
	  and  a.of_nombre like isnull('%'+@i_valorcat+'%',a.of_nombre)
      order by of_oficina
   set rowcount 0
  end   -- FIN DEL TIPO AL

  if @i_tipo = 'VL'
  begin
    select of_nombre
    from   cl_oficina
    where  of_oficina = @i_oficina

    if @@rowcount = 0
    begin
      exec sp_cerror
           -- 'NO EXISTE OFICINA'
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 101016
      return 1
    end
  end   -- FIN DEL TIPO VL

  --20/07/2016 TBA Se agrega tipo "VS" en la operación "H" por dependencia detectada en la migración
  -- Oficina dado un subtipo
  if @i_tipo = 'VS'
  begin
    select of_nombre
      from cl_oficina
     where of_oficina = @i_oficina
       and of_subtipo = @i_opcion
       and of_bloqueada = 'N'

    if @@rowcount = 0
    begin
      exec sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 101016
                   /*'No existe oficina'*/
      return 1
    end
  end      /* del tipo VS */
  
  return 0
end   -- FIN  DEL T_TRN
else
begin   -- CUANDO EL T_TRN NO CORRESPONDE
   exec sp_cerror
        -- 'NO CORRESPONDE CODIGO DE TRANSACCION'
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
   return 1
end
end   -- FIN DEL I_OPERACION

-- OPERACION G
-- QUERY ESPECIFICO DE DATOS DE GEOREFERENCIACION
if @i_operacion='G'
begin
   if @t_trn = 15388 
      begin

         select 
            @o_lat_coord    = of_lat_coord,
            @o_lat_grados   = of_lat_grad,
            @o_lat_minutos  = of_lat_min,
            @o_lat_segundos = of_lat_seg,
            @o_lon_coord    = of_long_coord,
            @o_lon_grados   = of_long_grad,
            @o_lon_minutos  = of_long_min,
            @o_lon_segundos = of_long_seg
         from cl_oficina, cl_filial
         where of_oficina = @i_oficina
         and of_filial  = @i_filial
         and of_filial  = fi_filial

         if @@rowcount = 0
         begin
           -- 'NO EXISTE DATO SOLICITADO'
           exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 101001
           return 1
         end
  
         select  @o_lat_coord,   @o_lat_grados,   @o_lat_minutos,   @o_lat_segundos,
                 @o_lon_coord,   @o_lon_grados,   @o_lon_minutos,   @o_lon_segundos
         
         return 0
      end
   else
      begin
         exec sp_cerror
              --  'NO CORRESPONDE CODIGO DE TRANSACCION' 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 151051
         return 1
   end
end
-- FIN OPERACION G 

