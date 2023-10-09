/************************************************************************/
/*  Archivo           : ciudad.sp                                       */
/*  Stored procedure  : sp_ciudad                                       */
/*  Base de datos     : cobis                                           */
/*  Producto          : Administracion                                  */
/*  Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                  IMPORTANTE                                          */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  COBISCORP SA,representantes exclusivos para el Ecuador de la        */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante            */
/************************************************************************/
/*            PROPOSITO                                                 */
/*  Este programa procesa las transacciones de:                         */
/*  Insercion de ciudades                                               */
/*  Actualizacion de ciudades                                           */
/*  Busqueda de ciudades                                                */
/*  Query de ciudades                                                   */
/*  Ayuda de ciudades                                                   */
/************************************************************************/
/*           MODIFICACIONES                                             */
/*  FECHA       AUTOR          RAZON                                    */
/*              Emision        inicial                                  */
/*  20/Abr/94   F.Espinosa     Parametros tipo 'S' Transacc. servic.    */
/*  02/May/95   S. Vinces      Cambiso de Admin Distribuido             */
/*  20/Abr/94   F.Iza          Modificaci¢n Busca ciudad                */
/*  3/Mar/2015  Omar Garcia    Adicion del campo ci_canton a la tabla   */
/*  08/Jul/15   J.Guamani      Opcion de busqueda 'Q'                   */
/*  11-04-2016  BBO            Migracion Sybase-Sqlserver FAL           */
/*  21-Feb-18   ALFNSI         Correcciones migracion                   */
/************************************************************************/

use cobis
go

SET ANSI_nullS OFF
go

if exists (select * from sysobjects where name = 'sp_ciudad')
   drop proc sp_ciudad
go

create proc sp_ciudad (
       @s_ssn              int         = null,
       @s_user             login       = null,
       @s_sesn             int         = null,
       @s_term             varchar(32) = null,
       @s_date             datetime    = null,
       @s_srv              varchar(30) = null,
       @s_lsrv             varchar(30) = null, 
       @s_rol              smallint    = null,
       @s_ofi              smallint    = null,
       @s_org_err          char(1)     = null,
       @s_error            int         = null,
       @s_sev              tinyint     = null,
       @s_msg              descripcion = null,
       @s_org              char(1)     = null,
       @t_show_version     bit         = 0,
       @t_debug            char(1)     = 'N',
       @t_file             varchar(14) = null,
       @t_from             varchar(32) = null,
       @t_trn              smallint    = null,
       @i_operacion        varchar(2)  = null,
       @i_tipo             varchar(1)  = null,
       @i_modo             tinyint     = null,
       @i_ciudad           int         = null, 
       @i_valorcat         catalogo    = null,
       @i_descripcion      descripcion = null,
       @i_provincia        int         = null, --Cambio de smallint a int
       @i_pais             smallint    = null, 
       @i_estado           estado      = null,
       @i_cod_bce          smallint    = null,
       @i_central_transmit varchar(1)  = null,
       @i_valor            descripcion = null,   
       @i_ciudad_alf       varchar(64) = null,
       @i_canton           int         = null
)
as
declare @w_sp_name          varchar(32),
        @w_cambio           int,
        @w_parroq           int,
        @w_codigo           int,
        @w_descripcion      descripcion,
        @w_provincia        int, --Cambio de smallint a int
        @w_pais             smallint,
        @w_estado           estado,
        @v_descripcion      descripcion,
        @v_provincia        int, --Cambio de smallint a int
        @v_pais             smallint,
        @v_estado           estado,
        @v_cod_bce          smallint,
        @w_cod_bce          smallint,
        @w_return           int,
        @w_codigo_c         varchar(10), 
        @w_cod_pais         smallint,
        @w_canton           int,
        @w_ciudad           int,
        @w_longitud         int,
        @w_caracter         char(1),
        @w_pos              smallint,
        @w_valida           tinyint,
        @w_usa_canton       char(1),
        @w_numerror         int

select @w_sp_name  = 'sp_ciudad'
select @w_longitud = datalength(@i_valorcat),
       @w_pos      = 1      

if @t_show_version = 1
begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.1'
    return 0
end

-- Valida codigo de transaccion
if  (@t_trn !=  588  or @i_operacion != 'I')
and (@t_trn !=  589  or @i_operacion != 'U')
and (@t_trn !=  1561 or @i_operacion != 'S')
and (@t_trn !=  1560 or @i_operacion != 'Q')
and (@t_trn !=  1562 or @i_operacion != 'H')
begin
   select @w_return  = 151051
   goto ERROR
end

-- Evaluacion Estructura Geografica
select @w_usa_canton = substring(c.valor,1,1)
from   cobis..cl_tabla t,
       cobis..cl_catalogo c
where  t.tabla  = 'cl_estructura_pais'
and    t.codigo = c.tabla
and    c.codigo = 'A'

if @@rowcount = 0
begin
   select @w_return  = 151051
   goto ERROR
end

if @i_valorcat is not null
begin
   while @w_longitud > @w_pos
   begin
      select @w_caracter = substring(@i_valorcat,@w_pos,1)
      if @w_caracter in ('0','1','2','3','4','5','6','7','8','9')
         select @w_valida = 1
      else
      begin
         select @w_valida = 0
         break
      end
      select @w_pos = @w_pos + 1
   end
   if @w_valida = 1
      select @w_ciudad = convert(int, @i_valorcat)
   else
   begin
      select @w_return  = 107130
      goto ERROR
   end
end

if @i_operacion in ('I','U')
begin
   --VERIFICACION DE CLAVES FORANEAS            
   --PROVINCIA
   select @w_codigo = null
   from   cl_provincia
   where  pv_provincia = @i_provincia
   
   if @@rowcount = 0
   begin
      select @w_return  = 101038
      goto ERROR
   end
      
   --CANTON
   if isnull(@w_usa_canton,'N') = 'S'
   begin
      select @w_codigo = null
      from   cl_canton
      where  ca_canton = @i_canton
   
      if @@rowcount = 0
      begin
         select @w_return  = 157946
         goto ERROR
      end
   end
end
   
--INSERT
if @i_operacion = 'I'
begin
  
   --VALIDACION DE DUPLICIDAD DE CIUDAD
   if exists (select ci_ciudad from cl_ciudad       
               where ci_ciudad  = @i_ciudad)
   begin
      select @w_return  = 151063
      goto ERROR
   end
   
   begin tran     
      insert into cl_ciudad 
             (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, 
              ci_pais,   ci_cod_remesas, ci_canton)
      values (@i_ciudad, @i_descripcion, 'V',       @i_provincia, 
              @i_pais,   @i_cod_bce,     @i_canton)
         
      if @@error != 0
      begin
         select @w_return  = 103019
         goto ERROR
      end
         
      --TRANSACCION SERVICIO - CIUDAD
      insert into ts_ciudad 
             (secuencia, tipo_transaccion, clase,        fecha,
              oficina_s, usuario,          terminal_s,   srv,     lsrv,
              ciudad,    descripcion,      provincia,    pais,    estado,  canton)
      values (@s_ssn,    588,              'N',          @s_date,          
              @s_ofi,    @s_user,          @s_term,      @s_srv,  @s_lsrv,    
              @i_ciudad, @i_descripcion,   @i_provincia, @i_pais, 'V',     @i_canton)
      
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran

   --ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO
   select @w_codigo_c = convert(varchar(10), @i_ciudad)
   exec @w_return = sp_catalogo
        @s_ssn               = @s_ssn,
        @s_user              = @s_user,
        @s_sesn              = @s_sesn,
        @s_term              = @s_term,   
        @s_date              = @s_date,   
        @s_srv               = @s_srv,   
        @s_lsrv              = @s_lsrv,   
        @s_rol               = @s_rol,
        @s_ofi               = @s_ofi,
        @s_org_err           = @s_org_err,
        @s_error             = @s_error,
        @s_sev               = @s_sev,
        @s_msg               = @s_msg,
        @s_org               = @s_org,
        @t_debug             = @t_debug,   
        @t_file              = @t_file,
        @t_from              = @w_sp_name,
        @t_trn               = 584,
        @i_operacion         = 'I',
        @i_tabla             = 'cl_ciudad',
        @i_codigo            = @w_codigo_c,
        @i_descripcion       = @i_descripcion,
        @i_estado            = 'V'   
      
   if @w_return != 0
      return @w_return
   end

--UPDATE
if @i_operacion = 'U'
begin
   select @w_descripcion = ci_descripcion,
          @w_provincia   = ci_provincia,
          @w_estado      = ci_estado,
          @w_cod_bce     = ci_cod_remesas,
          @w_canton      = ci_canton   
   from   cl_ciudad
   where  ci_ciudad = @i_ciudad
   
   select @v_descripcion = @w_descripcion
   select @v_provincia   = @w_provincia
   select @v_estado   = @w_estado
   select @v_cod_bce   = @w_cod_bce
   
   if @w_descripcion = @i_descripcion
      select @w_descripcion = null, @v_descripcion = null
   else            
      select @w_descripcion = @i_descripcion
      
   if @w_provincia = @i_provincia 
      select @w_provincia = null, @v_provincia = null
   else
      select @w_provincia = @i_provincia
      
   if @w_cod_bce = @i_cod_bce 
      select @w_cod_bce = null, @v_cod_bce = null
   else
      select @w_cod_bce = @i_cod_bce
      
   if isnull(@w_usa_canton,'N') = 'S'
   begin
      if @w_canton = @i_canton
         select @w_canton = null
      else
         select @w_canton = @i_canton
   end
      
   if @w_estado = @i_estado
      select @w_estado = null, @v_estado = null
   else
   begin
      if @i_estado = 'C'
      begin
         if exists (select 1
                    from   cl_parroquia
                    where  pq_ciudad = @i_ciudad
                    and    pq_estado = 'V')
         begin
            select @w_return  = 101073
            goto ERROR
         end
      end
         
      if @i_estado = 'V'
      begin
         if exists (select 1
                    from   cl_provincia
                    where  pv_provincia = @i_provincia
                    and    pv_estado    = 'C')
         begin
            select @w_return  = 101075
            goto ERROR
         end
      end
   end
      
   begin tran
      update cl_ciudad
      set    ci_descripcion  = @i_descripcion,
             ci_provincia    = @i_provincia,
             ci_estado       = @i_estado,
             ci_cod_remesas  = @i_cod_bce,
             ci_canton       = @i_canton
      where  ci_ciudad = @i_ciudad
      
      if @@error != 0
      begin
         select @w_return  = 105019
         goto ERROR
      end
      
      --TRANSACCION SERVICIOS - CIUDAD
      insert into ts_ciudad 
             (secuencia, tipo_transaccion, clase,        fecha,
              oficina_s, usuario,          terminal_s,   srv,       lsrv,
              ciudad,    descripcion,      provincia,    estado,    canton)
      values (@s_ssn,    589,              'P',          @s_date,   
              @s_ofi,    @s_user,          @s_term,      @s_srv,    @s_lsrv,   
              @i_ciudad, @v_descripcion,   @v_provincia, @v_estado, @i_canton)
      
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      insert into ts_ciudad 
             (secuencia, tipo_transaccion, clase,        fecha,
              oficina_s, usuario,          terminal_s,   srv,       lsrv,
              ciudad,    descripcion,      provincia,    estado,    canton)
                                                                    
      values (@s_ssn,    589,              'A',          @s_date,   
              @s_ofi,    @s_user,          @s_term,      @s_srv,    @s_lsrv,   
              @i_ciudad, @w_descripcion,   @w_provincia, @w_estado, @i_canton)
      
      if @@error != 0
      begin         
         select @w_return  = 103005
         goto ERROR
      end
   commit tran

   --ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO
   select @w_codigo_c = convert(varchar(10), @i_ciudad)
   exec @w_return = sp_catalogo
        @s_ssn             = @s_ssn,
        @s_user            = @s_user,
        @s_sesn            = @s_sesn,
        @s_term            = @s_term,   
        @s_date            = @s_date,   
        @s_srv             = @s_srv,   
        @s_lsrv            = @s_lsrv,   
        @s_rol             = @s_rol,
        @s_ofi             = @s_ofi,
        @s_org_err         = @s_org_err,
        @s_error           = @s_error,
        @s_sev             = @s_sev,
        @s_msg             = @s_msg,
        @s_org             = @s_org,
        @t_debug           = @t_debug,   
        @t_file            = @t_file,
        @t_from            = @w_sp_name,
        @t_trn             = 585,
        @i_operacion       = 'U',
        @i_tabla           = 'cl_ciudad',
        @i_codigo          = @w_codigo_c,
        @i_descripcion     = @i_descripcion,
        @i_estado          = @i_estado   
            
   if @w_return != 0
      return @w_return
   
end

/* Search */
if @i_operacion = 'S'
begin
   set rowcount 20

   select 'Codigo'         = ci_ciudad,
          'Ciudad'         = substring(ci_descripcion,1, 40),
          'Cod. Provincia' = ci_provincia,
          'Provincia'      = substring(pv_descripcion,1, 20),
          'Cod. Pais'      = pv_pais,
          'Pais'           = substring(pa_descripcion,1, 20),
          'Cod. Canton'    = ci_canton,
          'Canton'         = substring(ca_descripcion,1, 20),
          'Cod.Remesas'    = ci_cod_remesas,
          'Estado'         = ci_estado
   from   cl_ciudad inner join       cl_provincia  on pv_provincia = ci_provincia
                    inner join       cl_pais       on pa_pais      = pv_pais
                    Full  outer join cl_canton     on ci_canton    = ca_canton
                    Full  outer join cl_municipio  on ca_municipio = mu_municipio   and  mu_cod_prov = pv_provincia
   where  ((ci_ciudad > @i_ciudad  and @i_modo = 1) or @i_modo = 0)
   order  by ci_ciudad     

   if @@rowcount = 0
   begin
      select @w_return  = 101000
      goto ERROR
   end
   set rowcount 0

end

/* Query */
if @i_operacion = 'Q'
begin

   set rowcount 20
   select 'Codigo'         = ci_ciudad,
          'Canton'         = substring(ci_descripcion,1, 40),
          'Cod. Provincia' = ci_provincia,
          'Provincia'      = substring(pv_descripcion,1, 20),         
          'Cod.Remesas'    = ci_cod_remesas         
   from   cl_ciudad, 
          cl_provincia
   where  pv_provincia = ci_provincia
   and    ci_estado    = 'V'
   and    ((ci_ciudad  > @i_ciudad and @i_modo = 1) or @i_modo = 0)
   order  by ci_ciudad
   set rowcount 0
end

/* ** Help ** */
if @i_operacion = 'H'
begin

   if @i_tipo = 'A'
   begin   
      set rowcount 20
     
      select 'Cod.'  = ci_ciudad,
             'Nombre'= ci_descripcion,
             'Pais'  = pa_descripcion
      from   cl_ciudad, 
             cl_provincia, 
             cl_pais
      where  ci_provincia = pv_provincia
      and    pv_pais = pa_pais
      and    ci_estado = 'V'
      and    ((ci_ciudad > @i_ciudad or @i_ciudad is null and @i_modo = 1) or @i_modo = 0)
      set rowcount 0
   end

   if @i_tipo = 'V'
   begin
      select ci_descripcion
      from cl_ciudad
      --where (ci_provincia = @i_provincia or @i_provincia is null)
      where   (((ci_ciudad = @i_canton or @i_canton is null) and isnull(@w_usa_canton,'N') = 'S') or isnull(@w_usa_canton,'N') = 'N')
      and     (ci_ciudad = @i_ciudad or @i_ciudad is null)                                    
      and      ci_estado = 'V'
      
      if @@rowcount = 0
      begin
         select @w_return  = 101024
         goto ERROR   
      end
   end

   if @i_tipo = 'B'                                            
   begin      
      set rowcount 20                                     
      
      select 'Cod.'  = ci_ciudad,                    
             'Nombre'= ci_descripcion,             
             'Pais'  = pa_descripcion                
      from   cl_ciudad, 
             cl_provincia, 
             cl_pais     
      where  ci_provincia = pv_provincia          
      and    pv_pais      = pa_pais                    
      and    (ci_provincia = @i_provincia or @i_provincia is null)
      and    ci_estado = 'V'                      
      and    ci_descripcion like @i_valor
      and    ((ci_descripcion > @i_ciudad_alf and @i_modo = 1 ) or @i_modo = 0)
      order by ci_descripcion 
      set rowcount 0  
   end                                    

   if @i_tipo = 'S' 
   begin
      set rowcount 20
      
      select 'Cod.'   = ci_ciudad,                    
             'Nombre' = ci_descripcion,             
             'Pais'   = pa_descripcion 
      from   cl_ciudad, 
             cl_provincia,
             cl_pais
      where  ci_provincia   = pv_provincia
      and    pv_pais        = pa_pais
      and    pv_provincia   = @i_provincia
      and    ci_estado      = 'V'
      and    ((ci_ciudad    > @i_ciudad and  @i_modo = 1) or @i_modo = 0)
      set rowcount 0    
   end
   
   if @i_tipo = 'E'
   begin
      select ci_descripcion
      from   cl_ciudad
      where  ci_ciudad    = @i_ciudad
      and    ci_provincia = @i_provincia
      and    ci_estado    = 'V'
      
      if @@rowcount = 0
      begin
         select @w_return  = 101024
         goto ERROR
      end
   end
   
   if @i_tipo = 'N'
   begin
   
      /* validacion de parametro general del pais */
      /* ADU: 20051214 */
   
      select @w_cod_pais = pa_smallint
      from   cobis..cl_parametro
      where  pa_nemonico = 'CP' 
      and    pa_producto = 'ADM'
      
      if (@w_cod_pais is null)
      begin
         select @w_return  = 101077
         goto ERROR
      end

      set rowcount 20
      select 'Cod.'  = ci_ciudad,                    
             'Nombre'= ci_descripcion,             
             'Pais'  = pa_descripcion 
      from   cl_ciudad, 
             cl_provincia, 
             cl_pais
      where  ci_provincia = pv_provincia
      and    pv_pais   = pa_pais
      and    ci_estado = 'V'
      and    pa_pais   = @w_cod_pais
      and    ((ci_ciudad > @i_ciudad and @i_modo = 1) or @i_modo = 0)
      set rowcount 0
   end
   
   if @i_tipo = 'W'
   begin
      /* validacion de parametro general del pais */
      /* ADU: 20051214 */
      
      select @w_cod_pais = pa_smallint
      from   cobis..cl_parametro
      where  pa_nemonico = 'CP' 
      and    pa_producto = 'ADM'
      
      if (@w_cod_pais is null)
      begin
         select @w_return  = 101077
         goto ERROR
      end

      select ci_descripcion
      from   cl_ciudad
      where  ci_ciudad = @i_ciudad
      and    ci_estado = 'V'
      and    ci_pais   = @w_cod_pais
        
      if @@rowcount = 0
      begin
         select @w_return  = 101024
         goto ERROR
      end
   end  
    
   --NUEVA VALIDACION DE F5 GENERAL DEL CANTÓN
   if @i_tipo = 'R' and isnull(@w_usa_canton,'S') = 'S'
   begin                      
      set rowcount 20
      select 'Cod.Cantón'    = ci_canton, 
             'Nombre Cantón' = ca_descripcion, 
             'Cod. Provincia'= pv_provincia,  
             'Nombre Prov.'  = pv_descripcion, 
             'Cod. País'     = pa_pais,   
             'Nombre País'   = pa_descripcion  
      from   cl_ciudad, 
             cl_provincia, 
             cl_pais, 
             cl_canton
      where  ci_provincia   = @i_provincia
      and    pv_provincia   = ci_provincia 
      and    pa_pais        = ci_pais
      and    ci_canton      = ca_canton
      and    ci_estado      = 'V'
      and    ((ci_ciudad    > @i_ciudad and @i_modo = 1) or @i_modo = 0)
      order by ci_ciudad
      
      if @@rowcount = 0
      begin
         select @w_return  = 151121
         goto ERROR
      end  
      set rowcount 0
   end                                                   
   
   -- Busqueda de ciudades por descripcion
   if @i_tipo = 'Q'                                            
   begin 
      -- Controla mensajes de error
      if @i_ciudad_alf is null
         select @w_numerror = 101001
      else
         select @w_numerror = 151121
       
      set rowcount 20                                     
      select 'Cod. Ciudad'       = ci_ciudad, 
             'Nombre Ciudad'     = ci_descripcion, 
             'Cod. Provincia'    = pv_provincia,  
             'Nombre Prov.'      = pv_descripcion, 
             'Cod. País'         = pa_pais,   
             'Nombre País'       = pa_descripcion 
      from   cl_ciudad, 
             cl_provincia, 
             cl_pais
      where  ci_provincia       = pv_provincia
      and    pv_pais            = pa_pais
      and    pv_pais            = @i_pais
      and    (pv_provincia      = @i_provincia               or @i_provincia  is null or @i_provincia = 0 )
      and    ci_estado          = 'V'                        
      and    (ci_descripcion like @i_valor                   or @i_valor      is null)
      and    (ci_ciudad         > convert(int,@i_ciudad_alf) or @i_ciudad_alf is null)
      order by ci_ciudad
      
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


   
