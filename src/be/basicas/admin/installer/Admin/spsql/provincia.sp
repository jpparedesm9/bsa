/************************************************************************/
/*  Archivo           : provonc.sp                                      */
/*  Stored procedure  : sp_provincia                                    */
/*  Base de datos     : cobis                                           */
/*  Producto          : Administrador                                   */
/*  Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 08-Nov-1992                                     */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                        PROPOSITO                                     */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Busqueda de provincia                                               */
/*                        MODIFICACIONES                                */
/*  FECHA       AUTOR         RAZON                                     */
/*  08/Nov/92   M. Davila     Emision Inicial                           */
/*  12/Ene/93   L. Carvajal   Tabla de errores, variables               */
/*  25/Feb/93   M. Davila     Eliminacion de la tabla de cata logo      */
/*  26/Abr/94   F.Espinosa    Parametros tipo 'S' Transacciones de Serv.*/
/*  03/May/95   S. Vinces     Cambios por Admin Distribuido             */
/*  27/Feb/2015 L. Maldonado  Adicion del campo pv_depart_pais          */
/*  08/Jul/15   J.Guamani     Opcion de busqueda 'Q'                    */
/*  11-04-2016  BBO           Migracion Sybase-Sqlserver FAL            */
/*  22-06-2016  H.Garcia      Ajuste control de oficinas FAL            */
/*  21-Feb-18   ALFNSI        Correcciones migracion                    */
/************************************************************************/
use cobis
go

SET ANSI_nullS OFF
go

if exists (select * from sysobjects where name = 'sp_provincia')
   drop proc sp_provincia

go
create proc sp_provincia (
       @s_ssn                int           = null,
       @s_user               login         = null,
       @s_sesn               int           = null,
       @s_term               varchar(32)   = null,
       @s_date               datetime      = null,
       @s_srv                varchar(30)   = null,
       @s_lsrv               varchar(30)   = null, 
       @s_rol                smallint      = null,
       @s_ofi                smallint      = null,
       @s_org_err            char(1)       = null,
       @s_error              int           = null,
       @s_sev                tinyint       = null,
       @s_msg                descripcion   = null,
       @s_org                char(1)       = null,
       @t_debug              char(1)       = 'N',
       @t_file               varchar(14)   = null,
       @t_from               varchar(32)   = null,
       @t_trn                smallint      = null,
       @t_show_version       bit           = 0,
       @i_operacion          varchar(2),
       @i_modo               tinyint       = null,
       @i_tipo               varchar(1)    = null,
       @i_provincia          int           = null, -- Cambio de smallint a int
       @i_descripcion        descripcion   = null,
       @i_region_nat         varchar(2)    = null,
       @i_region_ope         varchar(3)    = null,
       @i_pais               smallint      = null,
       @i_estado             estado        = null,
       @i_central_transmit   varchar(1)    = null,
       @i_valor              descripcion   = null,
       @i_provinc_alf        varchar(64)   = null,
       @i_departamento       catalogo      = null,
       @o_filas              tinyint       = null out
)
as
declare @w_sp_name           varchar(32),
        @w_cambio            int,
        @w_codigo            int,
        @w_ciudad            int,
        @w_descripcion       descripcion,
        @w_region_nat        varchar(2),
        @w_region_ope        varchar(3),
        @w_pais              smallint,
        @w_estado            estado,
        @w_transaccion       int,
        @v_descripcion       descripcion,
        @v_region_nat        varchar(2),
        @v_region_ope        varchar(3),
        @v_pais              smallint,
        @v_estado            estado,
        @v_departamento      catalogo,
        @o_provincia         int,         -- Cambio de smallint a int
        @w_server_logico     varchar(10),
        @w_num_nodos         smallint,    
        @w_contador          smallint,
        @w_cmdtransrv        varchar(60),
        @w_nt_nombre         varchar(30),
        @w_clave             int,
        @w_return            int,
        @w_codigo_c          varchar(10),
        @w_departamento      catalogo,
        @w_numerror          int,          -- Guarda num de errror
        @w_tabregnat         int,
        @w_tabregope         int,
        @w_usa_deppais       char(1)

select @w_sp_name = 'sp_provincia',
       @o_filas   = 13

if @t_show_version = 1
begin
    print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.2'
    return 0
end

-- Valida codigo de transaccion
if  (@t_trn !=  1526  or @i_operacion != 'I')
and (@t_trn !=  1527  or @i_operacion != 'U')
and (@t_trn !=  1549  or @i_operacion != 'S')
and (@t_trn !=  1548  or @i_operacion != 'Q')
and (@t_trn !=  1550  or @i_operacion != 'H')
begin
   select @w_return  = 151051
   goto ERROR
end

-- Evaluacion Estructura Geografica
select @w_usa_deppais = substring(c.valor,1,1)
from   cobis..cl_tabla t,
       cobis..cl_catalogo c
where  t.tabla  = 'cl_estructura_pais'
and    t.codigo = c.tabla
and    c.codigo = 'D'

if @@rowcount = 0
begin
   select @w_return  = 151051
   goto ERROR
end

-- Obtener el codigo de Region Natural
select @w_tabregnat = codigo
from   cobis..cl_tabla
where  tabla = 'cl_region_nat'

-- Obtener el codigo de Region Natural
select @w_tabregope = codigo
from   cobis..cl_tabla
where  tabla = 'cl_region_ope'

if @i_operacion in ('I','U')
begin
   -- VERIFICACION DE CLAVES FORANEAS
   select @w_codigo = null
   from   cl_catalogo c
   where  c.codigo = @i_region_nat
   and    c.tabla  = @w_tabregnat
   
   if @@rowcount = 0
   begin
      select @w_return  = 101039
      goto ERROR
   end
   
   select @w_codigo = null
   from   cl_catalogo c
   where  c.codigo = @i_region_ope
   and    c.tabla  = @w_tabregope
   
   if @@rowcount = 0
   begin
      select @w_return  = 101040
      goto ERROR
   end
   
      
   select @w_codigo = null
   from   cl_pais
   where  pa_pais = @i_pais 
   if @@rowcount = 0
   begin
      select @w_return  = 101018
      goto ERROR
   end
   
   if isnull(@w_usa_deppais,'N') = 'S'
   begin
      -- DEPARTAMENTO
      select @w_codigo = null
      from   cl_depart_pais, 
             cl_pais
      where  dp_pais         = pa_pais
      and    dp_pais         = @i_pais
      and    dp_departamento = @i_departamento
      
      if @@rowcount = 0
      begin
         select @w_return  = 101038
         goto ERROR
      end
   end
end

-- INSERT
if @i_operacion = 'I'
begin


   -- PROVINCIA
   if exists (select pv_provincia  from cl_provincia
             where pv_provincia = @i_provincia )
   begin
      select @w_return  = 151073
      goto ERROR
   end
   
   begin tran
  
      -- INSERT CL_PROVINCIA
      insert into cl_provincia 
             (pv_provincia,   pv_descripcion,   pv_region_nat,
              pv_region_ope,  pv_pais,          pv_estado,
              pv_depart_pais)
      values (@i_provincia,   @i_descripcion,   @i_region_nat,
              @i_region_ope,  @i_pais,          'V',
              @i_departamento)
              
      if @@error != 0
      begin
         select @w_return  = 103043
         goto ERROR
      end
      
      -- TRANSACCION SERVICIO - PROVINCIA
      insert into ts_provincia 
             (secuencia,    tipo_transaccion,      clase,        fecha,
              oficina_s,    usuario,               terminal_s,   srv, 
              lsrv,         hora,                  provincia,    descripcion, 
              region_nat,   region_ope,            pais,         estado, 
              departamento)
      values (@s_ssn,       1526,                  'N',          @s_date,
              @s_ofi,       @s_user,               @s_term,      @s_srv,
              @s_lsrv,      getdate(),             @i_provincia, @i_descripcion, 
              @i_region_nat,@i_region_ope,         @i_pais,      'V',
              @i_departamento)
      
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran
   
   -- ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO
   select @w_codigo_c = convert(varchar(10), @i_provincia)
      exec 
         @w_return      = sp_catalogo
         @s_ssn         = @s_ssn,
         @s_user        = @s_user,
         @s_sesn        = @s_sesn,
         @s_term        = @s_term,
         @s_date        = @s_date,
         @s_srv         = @s_srv,
         @s_lsrv        = @s_lsrv,
         @s_rol         = @s_rol,
         @s_ofi         = @s_ofi,
         @s_org_err     = @s_org_err,
         @s_error       = @s_error,
         @s_sev         = @s_sev,
         @s_msg         = @s_msg,
         @s_org         = @s_org,
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @t_trn         = 584,
         @i_operacion   = 'I',
         @i_tabla       = 'cl_provincia',
         @i_codigo      = @w_codigo_c,
         @i_descripcion = @i_descripcion,
         @i_estado      = 'V'
   
   if @w_return != 0
      return @w_return
   
end

-- UPDATE
if @i_operacion = 'U'
begin
   select @w_descripcion  = pv_descripcion,
          @w_region_nat   = pv_region_nat,
          @w_region_ope   = pv_region_ope,
          @w_pais         = pv_pais,
          @w_departamento = pv_depart_pais,
          @w_estado       = pv_estado
   from   cl_provincia
   where  pv_provincia = @i_provincia
         
   select @v_descripcion  = @w_descripcion
   select @v_region_nat   = @w_region_nat
   select @v_region_ope   = @w_region_ope
   select @v_pais         = @w_pais
   select @v_departamento = @w_departamento
   select @v_estado       = @w_estado
   
   if @w_descripcion = @i_descripcion
      select @w_descripcion = null, @v_descripcion = null
   else
      select @w_descripcion = @i_descripcion
      
   if @w_region_nat = @i_region_nat
      select @w_region_nat = null, @v_region_nat = null
   else
      select @w_region_nat = @i_region_nat
      
   if @w_region_ope = @i_region_ope
      select @w_region_ope = null, @v_region_ope = null
   else
      select @w_region_ope =  @i_region_ope
      
   if @w_pais = @i_pais
      select @w_pais = null, @v_pais = null
   else
      select @w_pais = @i_pais

   if @w_departamento = @i_departamento
      select @w_departamento = null, @v_departamento = null
   else
      select @w_departamento = @i_departamento
      
   if @w_estado = @i_estado
      select @w_estado = null, @v_estado = null
   else
   begin
      if @i_estado = 'C'
      begin
         if exists (select 1
                    from   cl_ciudad
                    where  ci_provincia = @i_provincia)
         begin
            select @w_return  = 101072
            goto ERROR
         end
      end

      if exists (select 1 
                 from   cl_pais
                 where  pa_pais   = @i_pais
                 and    pa_estado = 'C')
      begin
         select @w_return  = 101074
         goto ERROR
      end
     
      -- Gerarquia superior Depart pais, de lo contrario empieza por Provincia
      if isnull(@w_usa_deppais,'N') = 'S'
      begin
         if exists (select 1 
                    from   cl_depart_pais
                    where  dp_departamento = @i_departamento
                    and    dp_estado       = 'C')
         begin
            select @w_return  = 101075
            goto ERROR
         end 
      end
      select @w_estado = @i_estado
   end
   
   begin tran
      -- UPDATE PROVINCIA
      update cl_provincia
      set    pv_descripcion = @i_descripcion,
             pv_region_nat  = @i_region_nat,
             pv_region_ope  = @i_region_ope,
             pv_pais        = @i_pais,
             pv_depart_pais = @i_departamento,
             pv_estado      = @i_estado 
      where  pv_provincia = @i_provincia 
   
      if @@error != 0
      begin
         select @w_return  = 105038
         goto ERROR
      end
   
      -- TRANSACCION SERVICIOS - PROVINCIA         
      insert into ts_provincia 
             (secuencia,       tipo_transaccion,      clase,        fecha,
              oficina_s,       usuario,               terminal_s,   srv, 
              lsrv,            hora,                  provincia,    descripcion, 
              region_nat,      region_ope,            pais,         estado, 
              departamento)    
      values (@s_ssn,          1526,                  'P',          @s_date,
              @s_ofi,          @s_user,               @s_term,      @s_srv,
              @s_lsrv,         getdate(),             @i_provincia, @v_descripcion, 
              @v_region_nat,   @v_region_ope,         @v_pais,      @v_estado,
              @v_departamento)
      
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      insert into ts_provincia 
             (secuencia,       tipo_transaccion,      clase,        fecha,
              oficina_s,       usuario,               terminal_s,   srv, 
              lsrv,            hora,                  provincia,    descripcion, 
              region_nat,      region_ope,            pais,         estado, 
              departamento)    
      values (@s_ssn,          1526,                  'A',          @s_date,
              @s_ofi,          @s_user,               @s_term,      @s_srv,
              @s_lsrv,         getdate(),             @i_provincia, @w_descripcion, 
              @w_region_nat,   @w_region_ope,         @w_pais,      @w_estado,
              @w_departamento)
      
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran
   
   select @w_codigo_c = convert(varchar(10), @i_provincia)
   exec @w_return = sp_catalogo
        @s_ssn           = @s_ssn,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_rol           = @s_rol,
        @s_ofi           = @s_ofi,
        @s_org_err       = @s_org_err,
        @s_error         = @s_error,
        @s_sev           = @s_sev,
        @s_msg           = @s_msg,
        @s_org           = @s_org,
        @t_debug         = @t_debug,
        @t_file          = @t_file,
        @t_from          = @w_sp_name,
        @t_trn           = 585,
        @i_operacion     = 'U',
        @i_tabla         = 'cl_provincia',
        @i_codigo        = @w_codigo_c,
        @i_descripcion   = @i_descripcion,
        @i_estado        = @i_estado
   if @w_return != 0
      return @w_return
end

-- SEARCH
if @i_operacion = 'S'
begin
   set rowcount 20
            
   select 'CODIGO'               = pv_provincia,
          'PROVINCIA'            = substring(pv_descripcion,1,20),
          'COD. REG. OP.'        = pv_region_ope,
          'REGION OPERERATIVA'   = (select substring(c.valor,1,20) 
                                    from   cobis..cl_catalogo c
                                    where  c.tabla         = @w_tabregope
                                    and    p.pv_region_ope = c.codigo),
          'COD. REG. NAT.'       = pv_region_nat,
          'REGION NATURAL'       = (select substring(c.valor,1,20) 
                                    from   cobis..cl_catalogo c
                                    where  c.tabla         = @w_tabregnat
                                    and    p.pv_region_nat = c.codigo),
          'COD. PAIS'            = pv_pais,
          'PAIS'                 = substring(pa_descripcion,1,20),
          'COD. DEPARTAMENTO'    = pv_depart_pais,
          'DEPARTAMENTO'         = substring(dp_descripcion,1,20),
          'ESTADO'               = pv_estado
   from  cl_provincia p left  outer join cl_depart_pais on (p.pv_depart_pais = dp_departamento), 
         cl_pais  
   where pa_pais         = pv_pais
   and ((pv_provincia    > @i_provincia   and @i_modo = 1) or @i_modo = 0)
   order by pv_provincia                       
            
   if @@rowcount = 0
   begin
      select @w_return  = 101000
      goto ERROR
   end
   set rowcount 0
end

-- QUERY
if @i_operacion = 'Q'
begin

   set rowcount 13
   
   select 'CODIGO'           = pv_provincia,
          'PROVINCIA'        = pv_descripcion,
          'COD. REG. OP.'    = pv_region_ope,
          'REGION OPERATIVA' = isnull((select valor
                                       from   cobis..cl_catalogo c
                                       where  c.tabla  = @w_tabregope
                                       and    c.codigo = p.pv_region_ope) ,''),
          'COD. REG. NAT.'   = pv_region_nat,
          'REGION NATURAL'   = isnull((select valor
                                       from   cobis..cl_catalogo c
                                       where  c.tabla  = @w_tabregnat
                                       and    c.codigo = p.pv_region_nat) ,''),
          'COD. PAIS'         = pv_pais,
          'PAIS'              = pa_descripcion,
          'COD. DEPARTAMENTO' = pv_depart_pais,
          'DEPARTAMENTO'      = dp_descripcion
   from   cl_provincia p left  outer join cl_depart_pais on (p.pv_depart_pais = dp_departamento), 
          cl_pais 
   where  pv_pais        = pa_pais
   and    pv_estado      = 'V'
   and   ((pv_provincia  > @i_provincia     and @i_modo = 1) or @i_modo = 0)
   order  by pv_provincia
   

   if @@rowcount = 0
   begin
      select @w_return  = 101000
      goto ERROR
   end
   set rowcount 0
end
   
-- HELP
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin
      set rowcount 20
      select 'COD.'               = pv_provincia,
             'PROVINCIA'          = pv_descripcion,
             'COD.PAIS'           = pa_pais,
             'PAIS '              = pa_descripcion,
             'COD.DEPARTAMENTO'   = dp_departamento,
             'DEPARTAMENTO '      = dp_descripcion
      from   cl_provincia left  outer join cl_depart_pais on (dp_departamento = pv_depart_pais), 
             cl_pais  
      where  pa_pais         = pv_pais
      and    (pv_pais        = @i_pais or @i_pais is null)
      and    pv_estado       = 'V'
      and    (pv_depart_pais = @i_departamento or @i_departamento is null)
      and    ((pv_provincia  > @i_provincia   and @i_modo = 1)    or @i_modo = 0)
      order by pv_provincia
            
      set rowcount 0
      return 0
   end
   
   if @i_tipo = 'V'
   begin
      select pv_descripcion 
      from   cl_provincia, cl_pais, cl_depart_pais
      where  pv_pais         = pa_pais
      and    pv_depart_pais  = dp_departamento
      and    (pv_pais        = @i_pais          or @i_pais         is null)
      and    (pv_depart_pais = @i_departamento  or @i_departamento is null)
      and    pv_provincia    = @i_provincia
      and    pv_estado       = 'V'

      if @@rowcount = 0
      begin
         select @w_return  = 101000
         goto ERROR
      end

      return 0
   end
   
   if @i_tipo = 'B' -- BUSQUEDA ALFABETICA 
   begin
      set rowcount 20
      select 'COD.'               = pv_provincia,
             'PROVINCIA'          = pv_descripcion,
             'COD.PAIS'           = pa_pais,
             'PAIS '              = pa_descripcion,
             'COD.DEPARTAMENTO'   = dp_departamento,
             'DEPARTAMENTO '     = dp_descripcion
      from   cl_provincia left  outer join cl_depart_pais on (dp_departamento = pv_depart_pais) , 
             cl_pais 
      where  pa_pais           = pv_pais
      and    pv_pais           = @i_pais
      and    pv_estado         = 'V'
      and    pv_descripcion like @i_valor
      and    ((pv_descripcion  > @i_provinc_alf  and @i_modo = 1) or @i_modo = 0)
      and    (pv_depart_pais   = @i_departamento  or @i_departamento is null)
      order by pv_descripcion
      
      set rowcount 0
      return 0
   end
   
   -- CONSULTA CLIENTE POR COD PROVINCIA
   if @i_tipo = 'P'
   begin
      select pv_descripcion 
      from   cl_provincia
      where  pv_provincia     = @i_provincia
      and    (pv_pais         = @i_pais         or @i_pais is null)
      and    (pv_depart_pais  = @i_departamento or @i_departamento is null)
      and    pv_estado = 'V'

      if @@rowcount = 0
      begin
         select @w_return  = 101000
         goto ERROR
      end

      return 0
   end

   /*Controla mensajes de error*/
   if @i_provinc_alf is null
      select @w_numerror = 101209
   else
       select @w_numerror = 151121
      
   /*Busqueda de provincias por descripcion*/
   if @i_tipo = 'Q'
   begin
      set rowcount 20
      select 'COD.'             = pv_provincia,
             'PROVINCIA'        = pv_descripcion,
             'COD.DEPARTAMENTO' = dp_departamento,
             'DEPARTAMENTO '    = dp_descripcion,
             'COD.PAIS'         = pa_pais,
             'PAIS '            = pa_descripcion
      from   cl_provincia left  outer join cl_depart_pais on (dp_departamento = pv_depart_pais),
             cl_pais  
      where  pa_pais           = pv_pais
      and    pv_pais           = @i_pais
      and    pv_estado         = 'V'
      and   (pv_descripcion like @i_valor                    or @i_valor        is null)
      and   (pv_provincia      > convert(int,@i_provinc_alf) or @i_provinc_alf  is null)
      and   (pv_depart_pais    = @i_departamento             or @i_departamento is null)
      order by pv_provincia  
       
      if @@rowcount = 0
      begin
         select @w_return  = @w_numerror
         goto ERROR
      end
      set rowcount 0
   end
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


