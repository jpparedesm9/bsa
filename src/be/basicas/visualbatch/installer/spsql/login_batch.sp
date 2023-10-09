/************************************************************************/
/* Archivo:                login_batch.sp                               */
/* Stored procedure:       sp_login_batch                               */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:           Francisco López                              */
/* Fecha de escritura:     13-Diciembre-2004                            */
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
/*    Mantenimiento a la tabla ba_login_batch                           */
/*    Consulta y verificacion de autorizacion procesos batch            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    13-Dic-2004    F. López        Emision Inicial                    */
/*    01-Mar-2005    J. Parra        Opcion de eliminación de todos los */
/*                                   procesos de un lote                */
/*    24-Sep-2008    S. Soto         Uso del treeview                   */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_login_batch')
    drop proc sp_login_batch

go

create proc sp_login_batch (
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
            @i_login          login       = null,
            @i_producto       int         = null,
            @i_sarta          int         = null,
            @i_estado         char(1)     = null,
            @i_batch          int         = null,
            @i_secuencial     smallint    = null
)
as declare  @w_today          datetime,         /* fecha del dia                       */
            @w_return         int,              /* valor que retorna                   */
            @w_sp_name        varchar(32),      /* descripcion del stored procedure    */
            @w_existe         int,              /* codigo existe = 1    no existe = 0  */     
            @w_sarta          int,
            @w_batch          int,
            @w_estado         char(1),
            @w_secuencial     smallint,
            @w_dependencia    smallint,
       @w_login          login

select @w_today = getdate()
select @w_sp_name = 'sp_login_batch'


if (@t_trn <> 8111 and @i_operacion = 'I') or    -- Insercion
   (@t_trn <> 8111 and @i_operacion = 'U') or    -- Actualizacion
   (@t_trn <> 8111 and @i_operacion = 'D') or    -- Eliminacion
   (@t_trn <> 8112 and @i_operacion = 'S') or    -- Busqueda
   (@t_trn <> 8112 and @i_operacion = 'V') or    -- Verificacion
   (@t_trn <> 8112 and @i_operacion = 'T')       -- Arbol
begin        /* Tipo de transaccion no corresponde */
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801077
    return 1
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' 
begin
    select @w_login  = lb_login,
           @w_sarta  = lb_sarta,
           @w_batch  = lb_batch,
           @w_estado = lb_estado
     from cobis..ba_login_batch
     where lb_login  = @i_login
       and lb_sarta  = @i_sarta
       and lb_batch  = isnull(@i_batch,lb_batch)

    if @@rowcount = 0
        select @w_existe = 0
    else
        select @w_existe = 1
end


/* Insercion de autorizacion */
/*****************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
        if @i_batch is null
           begin
               delete cobis..ba_login_batch
               where lb_login = @i_login
               and lb_sarta = @i_sarta
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
        insert into cobis..ba_login_batch
               (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
        select  distinct @i_login, @i_sarta, sb_batch, @w_today, @i_estado, @s_user, @w_today
        from cobis..ba_sarta_batch
        where sb_sarta = @i_sarta

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
        insert into cobis..ba_login_batch
               (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
        values (@i_login, @i_sarta, @i_batch ,@w_today, @i_estado, @s_user, @w_today)

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


/* Actualizacion      */

if @i_operacion = 'U'
begin 
    if @w_existe = 0
    begin              /*   Autorizacion del proceso para el login no existe     */
        exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 808062
        return 1
    end

    begin tran

    update ba_login_batch
       set lb_estado        = @i_estado,
           lb_usuario       = @s_user,
           lb_fecha_ult_mod = @w_today
     where lb_login   = @i_login
       and lb_sarta   = @i_sarta
       and lb_batch   = @i_batch

    if @@error <> 0
    begin                    /*  Error al actualizar autorizacion del proceso para el login  */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 808063
        return 1
    end
    commit tran
    return 0
end

/* Eliminar un registro    */

if @i_operacion = 'D'
begin 
    if @w_existe = 0
    begin              /*   Autorizacion del proceso para el login no existe     */
        exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 808062
        return 1
    end

    begin tran
    if @i_batch is null
    begin
       delete ba_login_batch
        where lb_login   = @i_login
          and lb_sarta   = @i_sarta

       if @@error <> 0
       begin                    /*  Error al eliminar autorizacion del proceso para el login  */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808064
           return 1
       end
    end
    else
    begin
      delete ba_login_batch
       where lb_login   = @i_login
         and lb_sarta   = @i_sarta
         and lb_batch   = @i_batch
      
      if @@error <> 0
      begin                    /*  Error al eliminar autorizacion del proceso para el login  */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 808064
          return 1
      end
    end
    commit tran
    return 0
end

/* Busqueda de registros para un login     */

if @i_operacion = 'S'
begin
    set rowcount 20

    select 'LOTE  ' = lb_sarta, 
           'NOMBRE LOTE' = sa_nombre,
           'PROCESO' = lb_batch,
           'NOMBRE PROCESO' = ba_nombre,
           'ESTADO' = lb_estado,
           'FECHA ULT' = convert(VARCHAR,lb_fecha_ult_mod,101),
           'USUARIO' = lb_usuario
    from cobis..ba_login_batch, cobis..ba_sarta, cobis..ba_batch
    where lb_login   = @i_login
       and ( (@i_modo = 0) or (@i_modo = 1 and (lb_sarta = @i_sarta and lb_batch > @i_batch or lb_sarta > @i_sarta)))
       and sa_sarta = lb_sarta
       and ba_batch = lb_batch

    if @@rowcount = 0
         return 1

    set rowcount 0
    return 0
end


/*      Verificacion de autorizacion para el login */

if @i_operacion = 'V'
begin
    if @w_existe = 0
    begin              /*   Autorizacion del proceso para el rol no existe     */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 808062
        return 1
    end

    if @w_estado <> 'V'
    begin              /*   autorizacion del proceso para el rol no esta vigente     */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 808065
        return 1
    end
end

/*Consulta para elaborar el arbol de sartas y procesos*/
if @i_operacion = 'T'
begin
    set rowcount 20

    select distinct 'Cod Producto' = sa_producto,
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
     order by sa_producto, sa_sarta, ba_batch

  --  if @@rowcount = 0
    --     return 1

    set rowcount 0
    return 0
end 


/* Busqueda de registros para un login para marcarlos en el tree view */
if @i_operacion = 'B'
begin
    set rowcount 20

    select 'Producto' = sa_producto, 
           'lote ' = lb_sarta, 
           'Num Programa' = lb_batch,
           'Estado ' = lb_estado,
           'Autorizante' = lb_usuario
    from cobis..ba_login_batch, cobis..ba_sarta      
    where lb_sarta = sa_sarta 
      and lb_login = @i_login
      and ( (@i_modo = 0) or (@i_modo = 1 and ((sa_producto = @i_producto and sa_sarta = @i_sarta and lb_batch > @i_batch)
                                            or (sa_producto = @i_producto and sa_sarta > @i_sarta) 
                                            or  sa_producto > @i_producto)))
     order by sa_producto, lb_sarta, lb_batch

  --  if @@rowcount = 0
    --     return 1

    set rowcount 0
    return 0
end


go



