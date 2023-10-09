/************************************************************************/
/*  Archivo           : oficina.sp                                      */
/*  Stored procedure  : sp_oficina                                      */
/*  Base de datos     : cobis                                           */
/*  Producto          : Clientes                                        */
/*  Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 12-Nov-1992                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                PROPOSITO                                             */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Busqueda de todas las oficina                                       */
/*  Querys especificos de oficina                                       */
/*                MODIFICACIONES                                        */
/*  FECHA        AUTOR         RAZON                                    */
/*  12/Nov/1992  M. Davila     Emision Inicial                          */  
/*  23/Nov/1993  R. Minga      V. Documentacion, Verificacion y validac.*/
/*  26/Abr/1994  F.Espinosa    Parametros tipo 'S'                      */
/*  20/Feb/2015  L.Maldonado   Busqueda de oficinas - campos georeferenc*/
/*  27/Feb/2015  J.Guamani     Adicion de parametros tipo 'Q'           */
/*  30/Jun/2015  O.Garcia      Inclusion del campo subregional          */
/*  01/Jun/2016  R. Altamirano Cambios para oficina version BMI         */
/*  22/Jun/2016  J. Hernandez  Version Fal.                             */
/*  21/Feb/2018  ALFNSI        Correcciones migracion                   */
/*  22/Ago/2019  P. Ortiz Vera Agregar opcion de calculo georeferencia  */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_oficina')
   drop proc sp_oficina
go
create proc sp_oficina (
       @s_ssn           int         = null,
       @s_user          login       = null,
       @s_sesn          int         = null,
       @s_term          varchar(32) = null,
       @s_date          datetime    = null,
       @s_srv           varchar(30) = null,
       @s_lsrv          varchar(30) = null, 
       @s_rol           smallint    = null,
       @s_ofi           smallint    = null,
       @s_org_err       char(1)     = null,
       @s_error         int         = null,
       @s_sev           tinyint     = null,
       @s_msg           descripcion = null,
       @s_org           char(1)     = null,
       @t_show_version  bit         = 0,
       @t_debug         char(1)     = 'N',
       @t_file          varchar(14) = null,
       @t_from          varchar(32) = null,
       @t_trn           smallint    = null,
       @i_operacion     char(1)     = 'S',
       @i_modo          tinyint     = null,
       @i_tipo          char(2)     = null,
       @i_oficina       smallint    = null,
       @i_valor         descripcion = null,
       @i_filial        tinyint     = null,
       @i_area          char(10)    = null,
       @i_descripcion   varchar(60) = null,
       @i_formato_fecha int         = null,
       @i_regional      varchar(10) = null,
       @i_valorcat      varchar(64) = null,
       @i_opcion        char(1)     = 'N',    -- Oficinas vs BMI
       @i_login         login       = ''
)
as
declare @w_sp_name            varchar(32),
        @w_return             int,
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
        @o_regional           smallint,    
        @o_subregional        varchar(10),   -- Subregional de la oficina
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
        @o_barrio             int, 
        @o_des_barrio         descripcion, 
        @o_bandera            int,
        @o_zona               smallint,    
        @o_cob                smallint,
        @o_znombre            descripcion, 
        @o_cobnombre          descripcion, 
        @o_rnombre            descripcion,
        @w_subtipo_opcion     char(1),
        @o_bloqueada          char(1),
        @w_tabarof            int,
        @w_oficina            int
   

if @t_show_version = 1
begin
    print 'Stored procedure sp_oficina, Version 4.0.0.2'
    return 0
end

select @w_sp_name = 'sp_oficina'
-- Valida codigo de transaccion
if  (@t_trn !=  1573  or @i_operacion != 'S')
and (@t_trn !=  1572  or @i_operacion != 'Q')
and (@t_trn !=  1574  or @i_operacion != 'H')
and (@t_trn !=  15388 or @i_operacion != 'G')
and (@t_trn !=  15388 or @i_operacion != 'R')
begin
   select @w_return  = 151051
   goto ERROR
end

-- Obtener codigo de la tabla cl_area_oficina
select @w_tabarof = codigo
from   cobis..cl_tabla
where  tabla = 'cl_area_oficina'

-- Search
-- BUSQUEDA DE TODAS LAS OFICINAS REGISTRADAS
if @i_operacion='S'

begin
   set rowcount 20

   if @i_modo in (1,0)
   begin
      select 'Filial'    = of_filial,
             'Codigo'    = of_oficina,
             'Oficina'   = substring(of_nombre, 1, 30),
             'Area'      = substring(c.valor,1,30),
             'Tipo'      = of_subtipo,
             'Direccion' = substring(of_direccion, 1, 30),
             'Distrito'  = substring(ci_descripcion, 1, 30),
             'Bloqueada' = of_bloqueada
      from   cl_oficina, 
             cl_ciudad,
             cl_catalogo c
      where  ci_ciudad     = of_ciudad
      and    c.tabla       = @w_tabarof
      and    c.codigo      = of_area
      and    ((((of_filial > @i_filial) or (of_filial = @i_filial and of_oficina > @i_oficina)) and @i_modo = 1) or @i_modo = 0)
      order by of_filial, of_oficina

   
      if @@rowcount=0
      begin
         set rowcount 0
         select @w_return  = 151121
         goto ERROR
     end
   end

  
   if @i_modo = 2 -- CODIGO
   begin

      select 'Filial'    = of_filial,
             'Codigo'    = of_oficina,
             'Oficina'   = substring(of_nombre,1,30),
             'Area'      = substring(c.valor,1,30),
             'Tipo'      = of_subtipo,
             'Direccion' = substring(of_direccion,1,30),
             'Distrito'  = substring(ci_descripcion,1,30),
             'Bloqueada' = of_bloqueada
      from   cl_oficina, 
             cl_ciudad, 
             cl_catalogo c
      where  ci_ciudad  = of_ciudad
      and    c.tabla    = @w_tabarof
      and    c.codigo   = of_area
      and    of_oficina = @i_oficina
      order by of_filial, of_oficina
         
      if @@rowcount=0
      begin
         set rowcount 0
         select @w_return  = 151121
         goto ERROR
      end
   end
   
   if @i_modo = 3 -- NOMBRE
   begin
      select 'Filial'    = of_filial,
             'Codigo'    = of_oficina,
             'Oficina'   = substring(of_nombre,1,30),
             'Area'      = substring(c.valor,1,30),
             'Tipo'      = of_subtipo,
             'Direccion' = substring(of_direccion,1,30),
             'Distrito'  = substring(ci_descripcion,1,30),
             'Bloqueada' = of_bloqueada
      from   cl_oficina, 
             cl_ciudad,
             cl_catalogo c
      where  ci_ciudad     = of_ciudad
      and    c.tabla       = @w_tabarof
      and    c.codigo      = of_area
      and    (of_nombre like '%'+@i_descripcion+'%' or of_nombre like UPPER ('%'+@i_descripcion+'%') or of_nombre like LOWER ('%'+@i_descripcion+'%'))
      and    ((of_filial   > @i_filial) or (of_filial = @i_filial and of_oficina > @i_oficina))            
      order by of_filial, of_oficina         

      if @@rowcount=0
      begin
         set rowcount 0
         select @w_return  = 151121
         goto ERROR
      end
   end   
   set rowcount 0
end

-- QUERY
-- QUERY ESPECIFICO DE DATOS
if @i_operacion='Q'
begin
   select @o_bandera = 0
   
   select @o_filial            = of_filial,
          @o_finombre          = fi_nombre,
          @o_subtipo           = of_subtipo,
          @o_oficina           = of_oficina,
          @o_lonombre          = of_nombre,
          @o_direccion         = of_direccion,
          @o_sucursal          = of_sucursal, 
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
          @o_barrio            = of_barrio,      
          @o_zona              = of_zona,         -- modificaciones en oficina version BMI
          @o_cob               = of_cob,          -- modificaciones en oficina version BMI
          @o_bloqueada         = of_bloqueada     -- Version fal.
   from   cl_oficina, 
          cl_filial
   where  of_oficina = @i_oficina
   and    of_filial  = fi_filial
   
   if @@rowcount = 0
   begin 
      select @w_return  = 101001
      goto ERROR   
   end
   
   if @o_subtipo in ('A', 'R') --= 'A'       --AGENCIA o REGIONAL/TERRITORIAL  --RAL 31.05.2016 modificaciones en oficina version BMI
   begin
      select @o_sunombre = isnull(of_nombre,'')
      from   cl_oficina
      where  of_oficina = @o_sucursal
      
      if @@rowcount = 0
         select @o_bandera = 1
   end
   else 
   if @o_subtipo = 'O'  --OFICINA
   begin
      select @o_znombre   = isnull(a.of_nombre, ''), 
             @o_rnombre   = c.of_nombre
      from   cl_oficina a,            
             cl_oficina c
      where  a.of_oficina = @o_zona 
      and    c.of_oficina = @o_regional
     
      if @@rowcount = 0 
         select @o_bandera = 1
   end
   else 
   if @o_subtipo = 'Z'  --ZONA
   begin
      select @o_cobnombre = isnull(of_nombre, ''), 
             @o_rnombre   = of_nombre
      from   cl_oficina
      where  of_oficina   = @o_regional
   
      if @@rowcount = 0
         select @o_bandera = 1
   end
   else 
   if @o_subtipo = 'C'  --CENTRO OPERATIVO
   begin
      select @o_rnombre = isnull(of_nombre, '')
      from   cl_oficina
      where  of_oficina = @o_regional
      
      if @@rowcount = 0 
         select @o_bandera = 1
   end

   select @o_cinombre = isnull(ci_descripcion,'')
   from   cl_ciudad
   where  ci_ciudad = @o_ciudad
   
   if @@rowcount = 0
      select @o_bandera = 1
   
   if @o_area is not null
   begin
      select @o_arnombre = isnull(c.valor,'')
      from   cl_catalogo c      
      where  c.tabla  = @w_tabarof
      and    c.codigo = @o_area
      
      if @@rowcount = 0
         select @o_bandera = 1
   end
   
   if @o_subregional is not null
   begin
      select @o_des_subregional = isnull(c.valor,'')
      from   cl_tabla b, cl_catalogo c      
      where  b.tabla  = 'cl_subregional'
      and    b.codigo = c.tabla
      and    c.codigo = @o_subregional
      
      if @@rowcount = 0
         select @o_bandera = 1
   end
   
   if @o_tip_punt_at is not null
   begin
      select @o_des_tip_punt = isnull(c.valor,'')
      from   cl_tabla b, cl_catalogo c      
      where  b.tabla  = 'cl_tipo_punto_at'
      and    b.codigo = c.tabla
      and    c.codigo = @o_tip_punt_at
      
      if @@rowcount = 0
         select @o_bandera = 1
   end
   
   if @o_horario is not null
   begin
      select @o_des_horario = isnull(th_descripcion,'')
      from   ad_tipo_horario
      where  th_tipo   = @o_horario
      and    th_estado = 'V'
      
      if @@rowcount = 0
         select @o_bandera = 1
   end

   if @o_tipo_horar is not null
   begin
      select @o_des_tipo_horar = isnull(c.valor,'')
      from   cl_tabla b, 
             cl_catalogo c      
      where  b.tabla  = 'cl_tipo_horario'
      and    b.codigo = c.tabla
      and    c.codigo = @o_tipo_horar
      
      if @@rowcount = 0
         select @o_bandera = 1
   end
  
   if @o_jefe_agenc is not null
   begin
      select @o_nom_jefe_agenc = isnull(fu_nombre,'')
      from   cl_funcionario
      where  fu_funcionario = @o_jefe_agenc
   end

   if @o_sector is not null
   begin
      select @o_des_sector = isnull(c.valor,'')
      from   cl_tabla b,
             cl_catalogo c      
      where  b.tabla  = 'cl_sector_geografico'
      and    b.codigo = c.tabla
      and    c.codigo = @o_sector
    if @@rowcount = 0
     select @o_bandera = 1
   end
   
   -- Agregado Vs FI
   if @o_cod_depart is not null
   begin
      select @o_des_depart = isnull(dp_descripcion,'')
      from   cl_depart_pais     
      where  dp_departamento = @o_cod_depart
      
      if @@rowcount = 0
         select @o_bandera = 1
   end

   if @o_cod_prov is not null
   begin
      select @o_des_prov = isnull(pv_descripcion,'')
      from   cl_provincia      
      where  pv_provincia = @o_cod_prov
       
      if @@rowcount = 0
         select @o_bandera = 1
   end
 
   if @o_relacion_oficina is not null
   begin
      select @o_des_relacion_ofi = isnull(of_nombre,'')
      from   cl_oficina
      where  of_oficina = @o_relacion_oficina
      
     if @@rowcount = 0
     select @o_bandera = 1
   end
  
   --CC0009 rla
   if @o_barrio is not null
   begin
      select @o_des_barrio = isnull (ba_descripcion, '')
      from   cl_barrio
      where  ba_barrio   = @o_barrio   
      and    ba_distrito = @o_cod_prov     
      and    ba_canton   = @o_ciudad
      
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
          @o_zona,             @o_znombre,     @o_cob,            @o_cobnombre,      @o_rnombre,   
          @o_bandera,          @o_bloqueada        
end

-- HELP
if @i_operacion='H'
begin

   -- QUERY DE TODAS LAS OFICINAS DE UNA FILIAL DE 20 EN 20
   if @i_tipo = 'A'
   begin
      if @i_area is null  -- VALIDACIÓN CONSULTA POR AREA
      begin
      
         set rowcount 20
   
         select 'Código'      = a.of_oficina,
                'Oficina'     = a.of_nombre,
                'Código Area' = a.of_area,
                'Nombre Area' = c.valor
         from   cl_oficina a, 
                cl_catalogo c
         where  of_filial       = @i_filial
         and    c.tabla         = @w_tabarof
         and    c.codigo        = a.of_area 
         and    (a.of_regional  = @i_regional  or  @i_regional is null)
         and    ((of_oficina    > @i_oficina  and  @i_modo      = 1)     or  isnull(@i_modo,0) = 0)
         order by of_filial, of_oficina
         
         set rowcount 0
      end
      else  -- VALIDACION PARA VER POR AREAS DE OFICINAS
      begin
         set rowcount 20
         select 'Código'       = a.of_oficina,
                'Oficina'      = a.of_nombre,
                'Código Area'  = a.of_area,
                'Nombre Area'  = c.valor
         from   cl_oficina a, 
                cl_catalogo c
         where  of_filial    = @i_filial
         and    of_area      = @i_area
         and    c.tabla      = @w_tabarof
         and    c.codigo     = a.of_area
         and    ((of_oficina > @i_oficina and  @i_modo = 1) or @i_modo = 0)
         order by of_filial, of_oficina
         set rowcount 0
      end   -- CONSULTA POR AREA
   end      -- FIN DEL TIPO A

   -- QUERY DE TODAS LAS SUCURSALES DE UNA FILIAL DE 20 EN 20
   if @i_tipo = 'S'
   begin
   
      if @i_opcion = 'O'
        select @w_subtipo_opcion = 'Z'
      else if @i_opcion = 'Z'
        select @w_subtipo_opcion = 'R'
      else if @i_opcion = 'C'
        select @w_subtipo_opcion = 'R'
      else if @i_opcion = 'A'
        select @w_subtipo_opcion = 'O'
      else
        select @w_subtipo_opcion = 'S'
    

      set rowcount 20

      select 'Código'       = of_oficina,
             'Oficina'      = of_nombre,
             'Código Area'  = a.of_area,
             'Nombre Area'  = c.valor
      from   cl_oficina a, 
             cl_catalogo c
      where  of_filial                 = @i_filial
      and    c.tabla                   = @w_tabarof
      and    c.codigo                  = a.of_area
      and    of_subtipo                = @w_subtipo_opcion 
      and    isnull(of_bloqueada, 'N') = 'N'
      and    ((of_oficina              > @i_oficina          and @i_modo = 1) or isnull(@i_modo,0) = 0)
      order by of_filial, of_oficina

      set rowcount 0
   end   -- DEL TIPO S

   if @i_tipo = 'V'
   begin
      select  of_nombre
      from    cl_oficina
      where   of_oficina    = @i_oficina
      and     of_filial     = @i_filial  
      and     (of_regional  = @i_regional or @i_regional is null)
      
      if @@rowcount = 0
      begin
         select @w_return  = 101016
         goto ERROR
      end
   end   -- FIN DEL TIPO V
   
   if @i_tipo = 'B' 
   begin
      set rowcount 20
      
      select 'Código'       = of_oficina,
             'Oficina'      = of_nombre,
             'Código Area'  = a.of_area,
             'Nombre Area'  = c.valor
      from   cl_oficina a, 
             cl_catalogo c
      where  of_subtipo     = 'S'
      and    c.tabla        = @w_tabarof
      and    c.codigo       = a.of_area
      and    of_nombre   like @i_valor
      and    ((of_oficina   > @i_oficina and @i_modo = 1) or isnull(@i_modo,0) = 0)
      order by of_filial, of_oficina
      set rowcount 0
   end  -- FIN DEL TIPO B

   -- QUERY DE TODAS LAS AGENCIAS DE UNA FILIAL DE 20 EN 20
   if @i_tipo = 'C'
   begin
      set rowcount 20

      select 'Código'       = of_oficina,
             'Oficina'      = of_nombre,
             'Código Area'  = a.of_area,
             'Nombre Area'  = c.valor
      from   cl_oficina a, 
             cl_catalogo c
      where  of_filial    = @i_filial
      and    c.tabla      = @w_tabarof
      and    c.codigo     = a.of_area
      and    of_subtipo   = 'A'
      and    ((of_oficina > @i_oficina and @i_modo = 1) or isnull(@i_modo,0) = 0)
      order by of_filial, of_oficina

      set rowcount 0
   end   -- DEL TIPO S
  
   -- TODAS LAS OFICINAS  DE CUALQUIER FILIAL
   if @i_tipo = 'AL'
   begin
      set rowcount 20
      
      select 'Código'       = of_oficina,
             'Oficina'      = of_nombre,
             'Código Area'  = a.of_area,
             'Nombre Area'  = c.valor
      from   cl_oficina a, 
             cl_catalogo c
      where  c.tabla        = @w_tabarof
      and    c.codigo       = a.of_area
      and    a.of_nombre like isnull(('%' +    @i_valorcat   + '%'),a.of_nombre)
      and    ((of_oficina   > @i_oficina and  @i_modo = 1) or isnull(@i_modo,0) = 0)
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
        select @w_return  = 101016
        goto ERROR
      end
   end   -- FIN DEL TIPO VL

   -- Oficina dado un subtipo
   if @i_tipo = 'VS'
   begin
      select of_nombre
      from   cl_oficina
      where  of_oficina                = @i_oficina
      and    of_subtipo                = @i_opcion
      and    isnull(of_bloqueada, 'N') = 'N'
   
      if @@rowcount = 0
      begin
         select @w_return  = 101016
         goto ERROR
      end
   end  -- FIN DEL TIPO VS
end     -- FIN DEL I_OPERACION

-- OPERACION G
-- QUERY ESPECIFICO DE DATOS DE GEOREFERENCIACION
if @i_operacion = 'G'
begin
   select @o_lat_coord    = of_lat_coord,
          @o_lat_grados   = of_lat_grad,
          @o_lat_minutos  = of_lat_min,
          @o_lat_segundos = of_lat_seg,
          @o_lon_coord    = of_long_coord,
          @o_lon_grados   = of_long_grad,
          @o_lon_minutos  = of_long_min,
          @o_lon_segundos = of_long_seg
   from   cl_oficina, 
          cl_filial
   where  of_oficina = @i_oficina
   and    of_filial  = @i_filial
   and    of_filial  = fi_filial

   if @@rowcount = 0
   begin
      select @w_return  = 101001
      goto ERROR
   end
  
   select  @o_lat_coord,   @o_lat_grados,   @o_lat_minutos,   @o_lat_segundos,
           @o_lon_coord,   @o_lon_grados,   @o_lon_minutos,   @o_lon_segundos
   
end

-- OPERACION R
-- QUERY DE GEOREFERENCIACION TRANSFORMADA POR LOGIN
if @i_operacion = 'R'
begin
   
   select @w_oficina = fu_oficina from cobis..cl_funcionario where fu_login = @i_login
   
   select 
      'oficina'   = of_oficina,
      'latitud'   = isnull(case
                     when of_lat_coord = 'S' then (convert(decimal(26,6),of_lat_grad) + (convert(decimal(26,6),of_lat_min)/60) + (convert(decimal(26,6),of_lat_seg)/3600)) * -1 
                     else (convert(decimal(26,6),of_lat_grad) + (convert(decimal(26,6),of_lat_min)/60) + (convert(decimal(26,6),of_lat_seg)/3600))
                    end, 0),
      'longitud'  = isnull(case
                     when of_long_coord = 'O' then (convert(decimal(26,6),of_long_grad) + (convert(decimal(26,6),of_long_min)/60) + (convert(decimal(26,6),of_long_seg)/3600)) * -1
                     else (convert(decimal(26,6),of_long_grad) + (convert(decimal(26,6),of_long_min)/60) + (convert(decimal(26,6),of_long_seg)/3600))
                    end, 0)
   from   cl_oficina, 
          cl_filial
   where  of_oficina = @w_oficina
   and    of_filial  = @i_filial
   and    of_filial  = fi_filial
end

return 0

ERROR:
   exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
   /*  'No corresponde codigo de transaccion' */
   return @w_return
go
