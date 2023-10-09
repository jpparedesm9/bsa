/****************************************************************************/
/*     Archivo:             reparperfil.sp                                  */
/*     Stored procedure:    sp_par_perfil                                   */
/*     Base de datos:       cob_remesas                                     */
/*     Disenado por:                                                        */
/*     Fecha de escritura:                                                  */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*     Este programa es parte de los paquetes bancarios propiedad de        */
/*     "MACOSA, representante exclusivos para el Ecuador de la              */
/*     "NCR CORPORATION".                                                   */
/*       Su uso no autorizado queda expresamente prohibido asi como         */
/*     cualquier alteracion o agregado hecho por alguno de sus usuarios     */
/*     sin el debido consentimiento por escrito de la Presidente Ejecutiva  */
/*     de MACOSA o su represente.                                           */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*   Este programa administra las operaciones de Insercion, Actualizacion   */
/*   Eliminacion, Busqueda  de la Relación de Perfiles Contables            */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     16/Ago/2016     J. TAgle		    Migración CEN                       */
/****************************************************************************/

use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_par_perfil')
   drop proc sp_par_perfil
go

CREATE proc sp_par_perfil(
@s_ssn           int         = null,
@s_srv           varchar(30) = null,
@s_user          varchar(30) = null,
@s_sesn          int         = null,
@s_term          varchar(10) = null,
@s_date          datetime    = null,
@s_ofi           smallint    = null,
@s_rol           smallint    = null,
@s_org           char(1)     = null,
@t_debug         char(1)     = 'N',
@t_file          varchar(14) = null,
@t_from          varchar(32) = null,
@t_rty           char(1)     = 'N',
@t_trn           int,
@i_operacion     char(1),
@i_modo          tinyint     = null,
@i_producto      tinyint     = null,
@i_transaccion   smallint    = null,
@i_perfil    varchar(10) = null,
@i_tipo_trn      varchar(10) = null,
@i_secuencia     int         = 0
)
as
                                                                                                                                                                                                                                                            
declare 
@w_sp_name       varchar(30),
@w_return        int,
@w_error         int,
@w_existe        bit,
@w_reg_duplicado bit,
@w_secuencia     int,
@w_producto      tinyint,
@w_transaccion   smallint,
@w_perfil    varchar(10),
@w_tipo_trn      varchar(10),
@v_producto      tinyint,
@v_transaccion   smallint,
@v_perfil    varchar(10),
@v_tipo_trn      varchar(10)
        
select @w_sp_name   = 'sp_par_perfil',
       @w_existe    = null,
       @w_reg_duplicado = null
       
--if @i_secuencia is null select @i_secuencia = 0
                                                                                                                                                                                                                                              
/* Verificacion de la transaccion */
if (@t_trn = 720 and (@i_operacion not in ('I', 'U', 'D')))
or (@t_trn = 721 and (@i_operacion not in ('A', 'Q')))
begin
   select @w_error = 351019
   goto ERROR
end

if @i_operacion in ('I', 'U', 'D')
begin
    if exists(select 1 from re_trn_perfil
          where tp_secuencial = @i_secuencia)
          
        select @w_existe      = 1,
               @w_producto    = tp_producto,
               @w_transaccion = tp_tipo_tran,
               @w_perfil      = tp_perfil,
               @w_tipo_trn    = tp_tipo
        from re_trn_perfil
        where tp_secuencial = @i_secuencia
    else 
        select @w_existe = 0
    
    if @i_operacion = 'I'
    begin
        if exists(select 1 from re_trn_perfil
                  where tp_producto   = @i_producto
                  and   tp_tipo_tran  = @i_transaccion)
              
            select @w_reg_duplicado = 1
        else
            select @w_reg_duplicado = 0
    end 
        
    if @i_operacion = 'U'
    begin
        if exists(select 1 from re_trn_perfil
              where tp_producto = @i_producto
              and tp_tipo_tran  = @i_transaccion
              and tp_secuencial != @i_secuencia)
              
            select @w_reg_duplicado = 1
        else
            select @w_reg_duplicado = 0
    end     
end     

/* OPERACION DE CONSULTA SEARCH "A" */
if (@t_trn = 721 and @i_operacion = 'A')
begin
    set rowcount 20

    select
    'PRODUCTO'    = tp_producto,
    'TRANSACCION' = tp_tipo_tran,
    'PERFIL'      = tp_perfil,
    'TIPO TRN'    = tp_tipo,
	'SEC'		  = tp_secuencial

    from  re_trn_perfil
    where tp_secuencial > isnull(@i_secuencia, 0)
    and   (tp_producto  = @i_producto or @i_producto is null)
    and   (tp_tipo_tran = @i_transaccion or @i_transaccion is null)
    order by tp_secuencial

    if @@rowcount = 0
    begin
        /* No existen mas registros */
        if @i_modo = 0
           select @w_error = 208158     
        else if @i_modo = 1
           select @w_error = 201095
           
  goto ERROR
    end
   
    set rowcount 0
end

/* OPERACION DE CONSULTA QUERY "Q" */
if (@t_trn = 721 and @i_operacion = 'Q')
begin
    select
    @w_producto    = tp_producto,
    @w_transaccion = tp_tipo_tran,
    @w_perfil      = tp_perfil,
    @w_tipo_trn    = tp_tipo
    from  re_trn_perfil
    where tp_secuencial = @i_secuencia
    and   (tp_producto  = @i_producto or @i_producto is null)
    and   (tp_tipo_tran = @i_transaccion or @i_transaccion is null)
    
    if @@rowcount = 0
    begin
        /* No existe registro */
        select @w_error = 351049
        goto ERROR
    end

    select
    @w_producto,
    @w_transaccion,
    @w_perfil,
    @w_tipo_trn
end

/* OPERACION DE INGRESO */
if (@t_trn = 720 and @i_operacion = 'I')
begin
    if @w_existe = 1
    begin
        select @w_error = 351047
        goto ERROR
    end
    
    if @w_reg_duplicado = 1 
    begin
        select @w_error = 351047
        goto ERROR
    end
    
    select @w_secuencia = null
    
    begin tran
    
    exec cobis..sp_cseqnos
    @i_tabla     = 're_trn_perfil',
    @o_siguiente = @w_secuencia out

    if @w_secuencia = 0
    begin
        rollback tran
        select @w_error = 351063
        goto ERROR
    end
    
    insert into re_trn_perfil
    (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
    values 
    (@w_secuencia, @i_producto, @i_transaccion, @i_perfil, @i_tipo_trn)
    
    if @@error != 0
    begin
        rollback tran
        select @w_error = 203042
        goto ERROR
    end
    
    insert into ts_par_perfil
    (secuencial, tipo_transaccion, oficina, usuario, 
     terminal, nodo, operacion, clase, fecha_proc, fecha_sis, 
     sec_reg, producto, transaccion, perfil, tipo_trn)
    values
    (@s_ssn, @t_trn, @s_ofi, @s_user, 
     @s_term, @s_srv, @i_operacion, 'N', @s_date, getdate(),
     @w_secuencia, @i_producto, @i_transaccion, @i_perfil, @i_tipo_trn)
     
    if @@error != 0
    begin
        rollback tran
        select @w_error = 353515
        goto ERROR
    end
    
    commit tran
end

/* OPERACION DE MODIFICACION */
if (@t_trn = 720 and @i_operacion = 'U')
begin
    if @w_existe = 0
    begin
        select @w_error = 208106
        goto ERROR
    end
    
    if @w_reg_duplicado = 1 
    begin
        select @w_error = 351047
        goto ERROR
    end
    
    select @v_producto    = @w_producto,
           @v_transaccion = @w_transaccion,
           @v_perfil      = @w_perfil,
           @v_tipo_trn    = @w_tipo_trn

    if @i_producto = @w_producto
        select @w_producto = null,
               @v_producto = null
    else
        select @w_producto = @i_producto

    if @i_transaccion = @w_transaccion
        select @w_transaccion = null,
               @v_transaccion = null
    else
        select @w_transaccion = @i_transaccion
                           
    if @i_perfil = @w_perfil
        select @w_perfil = null, 
               @v_perfil = null
    else
        select @w_perfil = @i_perfil
        
    if @i_tipo_trn = @w_tipo_trn
        select @w_tipo_trn = null, 
               @v_tipo_trn = null
    else
        select @w_tipo_trn = @i_tipo_trn
    
    begin tran
    
    update re_trn_perfil set
    tp_producto  = @i_producto,
    tp_tipo_tran = @i_transaccion,
    tp_perfil    = @i_perfil,
    tp_tipo      = @i_tipo_trn
    where tp_secuencial = @i_secuencia
    
    if @@error != 0
    begin
        rollback tran
        select @w_error = 355032
        goto ERROR
    end
    
    insert into ts_par_perfil
    (secuencial, tipo_transaccion, oficina, usuario, 
     terminal, nodo, operacion, clase, fecha_proc, fecha_sis, 
     sec_reg, producto, transaccion, perfil, tipo_trn)
    values
    (@s_ssn, @t_trn, @s_ofi, @s_user, 
     @s_term, @s_srv, @i_operacion, 'P', @s_date, getdate(),
     @i_secuencia, @v_producto, @v_transaccion, @v_perfil, @v_tipo_trn)
     
    if @@error != 0
    begin
        rollback tran
        select @w_error = 353515
        goto ERROR
    end

    insert into ts_par_perfil
    (secuencial, tipo_transaccion, oficina, usuario, 
     terminal, nodo, operacion, clase, fecha_proc, fecha_sis, 
     sec_reg, producto, transaccion, perfil, tipo_trn)
    values
    (@s_ssn, @t_trn, @s_ofi, @s_user, 
     @s_term, @s_srv, @i_operacion, 'A', @s_date, getdate(),
     @i_secuencia, @w_producto, @w_transaccion, @w_perfil, @w_tipo_trn)
     
    if @@error != 0
    begin
        rollback tran
        select @w_error = 353515
        goto ERROR
    end

    commit tran
end

/* OPERACION DE ELIMINACION */
if (@t_trn = 720 and @i_operacion = 'D')
begin
    if @w_existe = 0
    begin
        select @w_error = 357026
        goto ERROR
    end
    
    begin tran
    
    delete from re_trn_perfil
    where tp_secuencial = @i_secuencia

    if @@error != 0
    begin
        rollback tran
        select @w_error = 357006
        goto ERROR
    end
    
    insert into ts_par_perfil
    (secuencial, tipo_transaccion, oficina, usuario, 
     terminal, nodo, operacion, clase, fecha_proc, fecha_sis, 
     sec_reg, producto, transaccion, perfil, tipo_trn)
    values
    (@s_ssn, @t_trn, @s_ofi, @s_user, 
     @s_term, @s_srv, @i_operacion, 'B', @s_date, getdate(),
     @i_secuencia, @w_producto, @w_transaccion, @w_perfil, @w_tipo_trn)
     
    if @@error != 0
    begin
        rollback tran
        select @w_error = 353515
        goto ERROR
    end
    
    commit tran
end

return 0

ERROR:
   exec cobis..sp_cerror
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_num       = @w_error
   
return  @w_error


GO

