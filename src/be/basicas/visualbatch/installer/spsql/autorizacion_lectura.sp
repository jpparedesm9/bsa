/************************************************************************/
/* Archivo:                autorizacion_lectura.sp                      */
/* Stored procedure:       sp_autorizacion_lectura                      */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:           Fernando Ortega V.                           */
/* Fecha de escritura:     19-Marzo-2009                                */
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
/*    Mantenimiento a la tabla ba_autorizacion_lectura                  */
/*    Consulta y verificacion de autorizacion reportes batch            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    19-Mar-2009    F. Ortega V.    Emision Inicial                    */
/*                                   para cargar el arbol de reportes   */
/*    18-Ago-2011    S. Soto         Incluir solo reportes de la sarta  */
/*    19-ABR-2016    BBO             Migracion SYB-SQL FAL              */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_autorizacion_lectura')
    drop proc sp_autorizacion_lectura
go


create proc sp_autorizacion_lectura (
            @s_ssn            int         = null,
            @s_date           datetime    = null,
            @s_user           login       = null,
            @s_term           descripcion = null,
            @s_corr           char(1)     = null,
            @s_ssn_corr       int         = null,
            @s_ofi            smallint    = null,
            @t_rty            char(1)     = null,
            @t_trn            smallint    = 802,
            @t_debug          char(1)     = 'N',
            @t_file           varchar(14) = null,
            @t_from           varchar(30) = null,
            @i_operacion      char(1),
            @i_modo           smallint    = null,            
            @i_producto       int         = null,
            @i_sarta          int         = null,
            @i_batch          int         = null,
            @i_rol            int         = null,
            @i_login          login       = null,
            @i_oficina        int         = null
)
as 

declare  
  @w_sp_name        varchar(32),
  @w_existe         int

  select @w_sp_name = 'sp_autorizacion_lectura'

-------------------------------
/*   Chequeo de Existencia   */
-------------------------------
    if exists (select * from ba_lectura_reporte
               where lr_rol      = @i_rol
                 and (lr_login  = @i_login or @i_login is null)
                 and lr_sarta    = @i_sarta
                 and (lr_batch    = @i_batch or @i_batch is null)
              )
       select @w_existe = 1

    else
       select @w_existe = 0


------------------------------------------
/* Insertar un registro de autorizacion */
------------------------------------------

if @i_operacion = 'I'
begin
    if @w_existe = 1
        if @i_batch is null
           begin
               delete cobis..ba_lectura_reporte
               where lr_rol = @i_rol
               and lr_login = @i_login
               and lr_sarta = @i_sarta
           end
        else
        begin
             /* El login ya tiene autorizado el proceso   */
             exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 808059
             return 1
         end

    begin tran

    if @i_batch is null
    begin
        insert into cobis..ba_lectura_reporte
               (lr_rol, lr_login, lr_sarta, lr_batch )
        select  distinct @i_rol, @i_login, @i_sarta, sb_batch 
        from cobis..ba_sarta_batch, cobis..ba_batch
        where sb_batch = ba_batch 
          and sb_sarta = @i_sarta
          and ba_tipo_batch = 'R' --SSO, 18-08-2011, incluir solo reportes de la sarta

        if @@error <> 0 
        begin
            /* Error al insertar la autorizacion de procesos del lote para el login*/
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808060
            return 1
        end
    end
    else
    begin
        insert into cobis..ba_lectura_reporte
               (lr_rol, lr_login, lr_sarta, lr_batch )
        values (@i_rol, @i_login, @i_sarta, @i_batch )

        if @@error <> 0 
        begin
            /* Error al insertar la autorizacion del proceso para el login  */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808061
            return 1
        end
    end
    commit tran
    return 0
end


----------------------------------------
/* Borrar un registro de autorizacion */
----------------------------------------

if @i_operacion = 'D'
begin 
   begin tran
    if @i_batch is null
    begin
       delete ba_lectura_reporte
        where lr_rol     = @i_rol
         and lr_login   = @i_login
          and lr_sarta   = @i_sarta

       if @@error <> 0
       begin                    /*  Error al eliminar autorizacion del proceso para el login  */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808064,
                @i_sev = 1
            return 1
       end
    end
    else
    begin
      delete ba_lectura_reporte
       where lr_rol     = @i_rol
        and lr_login   = @i_login
         and lr_sarta   = @i_sarta
         and lr_batch   = @i_batch
      
      if @@error <> 0
      begin                    /*  Error al eliminar autorizacion del proceso para el login  */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 808064,
               @i_sev = 1
          return 1
      end
    end
    commit tran
    return 0
end



------------------------------------------------------
/* Consultar reportes autorizados para cargar arbol */
------------------------------------------------------
if @i_operacion = 'T'
begin
    set rowcount 20

    select distinct 
           'Cod Producto' = sa_producto,
           'Producto' = pd_descripcion,
           'Num Lote' = sa_sarta, 
           'Lote' = sa_nombre,
           'Num Programa' = ba_batch,
           'Programa' = ba_nombre
    from cobis..cl_producto, cobis..ba_sarta, cobis..ba_sarta_batch, cobis..ba_batch
    where pd_producto = sa_producto
      and sa_sarta = sb_sarta    
      and sb_batch = ba_batch
      and ( (@i_modo = 0) or (@i_modo = 1 and ((sa_producto = @i_producto and sa_sarta = @i_sarta and ba_batch > @i_batch)
                                            or (sa_producto = @i_producto and sa_sarta > @i_sarta) 
                                            or  sa_producto > @i_producto)))
      and (ba_tipo_batch = 'R') -- Solo reportes @i_tipo_batch or @i_tipo_batch is null) -- FOR 2009-03-19
     order by sa_producto, sa_sarta, ba_batch

  --  if @@rowcount = 0
    --     return 1

    set rowcount 0
    return 0
end 


-----------------------------------------------
/* Buscar reportes autorizados para un login */
-----------------------------------------------
if @i_operacion = 'B' 
begin
    set rowcount 20
    select 'Producto' = sa_producto, 
           'lote ' = lr_sarta, 
           'Num Programa' = lr_batch,
           'Estado ' = 'V',
           'Autorizante' = lr_login
    from ba_lectura_reporte, cobis..ba_sarta      
    where lr_sarta = sa_sarta 
      and (lr_rol = @i_rol and lr_login = @i_login)
      and ( (@i_modo = 0) or (@i_modo = 1 and ((sa_producto = @i_producto and sa_sarta = @i_sarta and lr_batch > @i_batch)
                                            or (sa_producto = @i_producto and sa_sarta > @i_sarta) 
                                            or  sa_producto > @i_producto)))
     order by sa_producto, lr_sarta, lr_batch

    set rowcount 0
    return 0
end


-------------------------------------------------------------
/* Consultar oficinas autorizadas para lectura de reportes */
-------------------------------------------------------------
if @i_operacion = 'O' 
begin
    select 'Autorizado'  = case
                              when b.lo_oficina is null then 0
                              else 1
                            end,
            'Cod Oficina' = a.of_oficina ,
            'Nombre '     = a.of_nombre
    --inicio migra syb-sql 19042016
    from cl_oficina a
         left outer join ba_lectura_oficina b on a.of_oficina = b.lo_oficina
    where b.lo_rol   = @i_rol
      and b.lo_login = @i_login
    --fin migra syb-sql 19042016
    /********MIGRACION SYB-SQL FAL
    --from cl_oficina a, ba_lectura_oficina b
    --where a.of_oficina *= b.lo_oficina
    --and b.lo_rol   = @i_rol
    --and b.lo_login = @i_login
    ******/
end


-----------------------------------
/* Autorizar Reporte por Oficina */
-----------------------------------
if @i_operacion = 'A' 
begin
  if not exists (select * from ba_lectura_oficina
                 where lo_rol = @i_rol
                 and lo_login = @i_login
                 and lo_oficina = @i_oficina
                )

   insert into ba_lectura_oficina (lo_rol, lo_login, lo_oficina) values(@i_rol, @i_login, @i_oficina)

   if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808070 -- Error Insercion
         return 1
      end 
end



-----------------------------------------------
/* Eliminar Autorizacion Reporte por Oficina */
-----------------------------------------------
if @i_operacion = 'E' 
begin
   delete ba_lectura_oficina
   where lo_rol = @i_rol
     and (lo_login = @i_login or @i_login is null) -- En el caso de que se quiera eliminar una oficina de un rol, implicar¡a desautorizar a todos los usuarios con ese rol
     and lo_oficina = @i_oficina

   if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808075 -- Error Eliminaci¢n
         return 1
      end  
end


---------------------------------
/* Consultar Roles Disponibles */
---------------------------------
if @i_operacion = 'R' 
begin
   select 
     'COD ROL' = a.ro_rol ,
     'NOMBRE'  = a.ro_descripcion
   from ad_rol a 
   where a.ro_rol = @i_rol or @i_rol is null -- en caso de especificar un rol, obtenemos la descripci¢n de dicho rol
   order by ro_rol

   return
end


--------------------------------
/* Consultar Usuarios por Rol */
--------------------------------
if @i_operacion = 'U' 
begin
   set rowcount 50

   if @i_modo in (0,null)
   BEGIN

   select
      'LOGIN' = ur_login,
      'NOMBRE' = substring(fu_nombre,1 ,30) 
   from cobis..cl_funcionario, cobis..ad_usuario_rol, cobis..ad_rol
   where fu_login = ur_login
     and ur_rol = ro_rol
     and ro_rol = @i_rol
     and (ur_login = @i_login or @i_login is null)  -- en caso de especificar un login, obtenemos la descripci¢n de dicho usuario
     order by ur_login

   if @@rowcount =0 
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808072 -- No Existen Registros
         return 1
      end
   END

   if @i_modo = 1
   BEGIN

   select 
      'LOGIN' = ur_login,
      'NOMBRE' = substring(fu_nombre,1 ,30)
   from cobis..cl_funcionario, cobis..ad_usuario_rol, cobis..ad_rol
   where fu_login = ur_login
     and ur_rol = ro_rol
     and ro_rol = @i_rol
     and (ur_login > @i_login)  -- en caso de especificar un login, obtenemos la descripci¢n de dicho usuario
     order by ur_login

   END

end

go

