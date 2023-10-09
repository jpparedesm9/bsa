/************************************************************************/
/* Archivo:                lectura.sp                                   */
/* Stored procedure:       sp_lectura                                   */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     22-Diciembre-1994                            */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento al catalogo de acceso de lectura de reportes        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    23-Dic-1994    G. Jaramillo    Emision Inicial                    */
/*    23-Oct-2008    S. Soto         Busqueda de operador de batch      */
/*    20-Jul-2012    M. Aldaz        Cambio en campo  @i_login1         */
/*    21/Abr/2016    BBO             Migracion SYB-SQL FAL              */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_lectura')
   drop proc sp_lectura
go


create proc sp_lectura   (
   @s_ssn            int = null,
   @s_date           datetime = null,
   @s_user           login = null,
   @s_term           descripcion = null,
   @s_corr           char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi            smallint = null,
   @t_rty            char(1) = null,
   @t_trn            smallint = 800,
   @t_debug          char(1) = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @i_operacion      char(1),
   @i_modo           smallint = null,
   @i_batch          int  = null,
   @i_tipo           char(1) = null,
   @i_rol            smallint = null,
   @i_login          varchar(14) = null,
   @i_acceso         char(1) = null,
   @i_batch1         int = null,  /*DGU-07-01-1999*/
   @i_rol1           smallint = null,
   @i_login1         varchar(14) = null,
   @i_tipo1          char(1) = null,   /*    20-Jul-2012    M. Aldaz   */
   @i_value          char(1) = null,
   @i_opcion_off     tinyint = 0,
   @i_oficina        smallint = null
)
as 
declare
   @w_today          datetime,   /* fecha del dia */
   @w_return         int,     /* valor que retorna */
   @w_sp_name        varchar(32),   /* descripcion del stored procedure*/
   @w_existe         int,     /* codigo existe = 1 no existe = 0 */
   @w_batch          int,
   @w_tipo           char(1),
   @w_rol            smallint,
   @w_login          varchar(10),
   @w_batch1         int,  /*DGU-07-01-1999*/
   @w_batch2         int,  /*DGU-07-01-1999*/
   @w_rol1           smallint,
   @w_rol2           smallint,
   @w_acceso         char(1),
   @w_rob            tinyint  

select @w_today = getdate()
select @w_sp_name = 'sp_lectura'

if (@t_trn <> 8061 and @i_operacion = 'I') or
   (@t_trn <> 8062 and @i_operacion = 'U') or
   (@t_trn <> 8063 and @i_operacion = 'D') or
   (@t_trn <> 8065 and @i_operacion = 'S') or
   (@t_trn <> 8066 and @i_operacion = 'Q') or
   (@t_trn <> 8067 and @i_operacion = 'R') or
   (@t_trn <> 8068 and @i_operacion = 'L') or
   (@t_trn <> 8068 and @i_operacion = 'A') or
   (@t_trn <> 8068 and @i_operacion = 'B') or
   (@t_trn <> 8068 and @i_operacion = 'C') 

begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801077
   return 1
end


/* Busca los roles existentes para una filial dada */

if @i_operacion = 'R'
begin
   if @i_modo = 1          /* igual a opcion value */
   begin
      select ro_descripcion
        from cobis..ad_rol
       where ro_rol = @i_rol
      
      if @@rowcount = 0
      begin
         /* No existen mas roles */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 801083
         return 1
      end
      return 0
   end

   if @i_modo = 0      /* busqueda de roles */
   begin
      set rowcount 20
      select   'ROL' = ro_rol,
               'DESCRIPCION' = substring(ro_descripcion,1,20) 
        from cobis..ad_rol
       where (ro_rol > @i_rol1 or @i_rol1 is null)
      
      if @@rowcount = 0
      begin
         /* No existen mas roles */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 801083
         return 1
      end
      return 0
   end
end 

/* Busca los usuarios pertenencientes a una filial y rol dado */  

if @i_operacion = 'L'
begin
   if @i_modo = 1
   begin
      select fu_nombre
      from cobis..cl_funcionario
      where fu_login = @i_login

      if @@rowcount = 0
      begin
         /* No existen codigos de login  */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151005
         return 1
      end
      return 0
   end

   if @i_modo = 0
   begin
      set rowcount 20
      select   "LOGIN" = ur_login, 
               "DESCRIPCION" = substring(fu_nombre,1 ,30) 
        from cobis..ad_usuario_rol,cobis..cl_funcionario
       where ur_rol = @i_rol
         and ur_login = fu_login
         and ur_login > isnull(@i_login1,'')
       order by ur_login

      if @@rowcount = 0
      begin
         /* No existen codigos de login  */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 801084
         return 1
      end
      set rowcount 0
      return 0
   end

   if @i_modo = 2
   begin
      set rowcount 20
      select   'LOGIN'=fu_login,
               'DESCRIPCION'=fu_nombre
        from cobis..cl_funcionario
       where fu_login > isnull(@i_login1,'')
       order by fu_login  

      if @@rowcount = 0
      begin
         /* No existen codigos de login  */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 801084
         return 1
      end
      set rowcount 0
      return 0
   end
end





/* Busca los operadores de batch */  

if @i_operacion = 'O'
begin
   select @w_rob = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = "ADM"
      and pa_nemonico = "ROB"
   
   if @@rowcount = 0 
      begin
         /* No existe parametro de rol de operador de  batch */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151161
         return 1
      end
   
   if @i_modo = 0
   begin
      set rowcount 20
      select   "LOGIN" = ur_login, 
               "NOMBRE" = substring(fu_nombre,1 ,30) 
      from cobis..cl_funcionario, cobis..ad_usuario_rol, cobis..ad_rol
      where fu_login = ur_login 
        and ur_rol = ro_rol
        and ro_rol = @w_rob
       order by ur_login

      if @@rowcount = 0
      begin
         /* No existen codigos de login  */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151164
         return 1
      end
      set rowcount 0
      return 0
   end

   if @i_modo = 1
   begin
      set rowcount 20
      select   "LOGIN" = ur_login, 
               "NOMBRE" = substring(fu_nombre,1 ,30) 
      from cobis..cl_funcionario, cobis..ad_usuario_rol, cobis..ad_rol
      where fu_login = ur_login 
        and ur_rol = ro_rol
        and ro_rol = @w_rob
        and ur_login > isnull(@i_login1,'')
       order by ur_login 

      if @@rowcount = 0
      begin
         /* No existen codigos de login  */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151164
         return 1
      end
      set rowcount 0
      return 0
   end

   if @i_modo = 2
   begin
      select fu_nombre
      from cobis..cl_funcionario, cobis..ad_usuario_rol, cobis..ad_rol
      where fu_login = ur_login 
        and ur_rol = ro_rol
        and fu_login = @i_login
        and ro_rol = @w_rob

      if @@rowcount = 0
      begin
         /* No existen operadores de batch con este login  */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151164
         return 1
      end
      return 0
   end
end

go
