/***********************************************************************/

/* rtryinit: Guardar procedimiento en el REENTRY                       */

/* PTO: 98/10/14: Emision inicial                                      */

/* Procedure: sp_reentry_init                                          */

/***********************************************************************/



use cobis
go



if exists (select * from sysobjects where name = 'sp_reentry_init')

  drop proc sp_reentry_init

go



create proc sp_reentry_init

(

    @i_server        varchar(30),

    @i_base          varchar(30),

    @i_sp            varchar(30),

    @i_trn           int = null,     /* Solo por compatibilidad. Usar @t_trn */

    /* Parametros COBIS estandar */

    @s_ssn           int = null,

    @s_lsrv          varchar(30) = null,

    @s_srv           varchar(30) = null,

    @s_user          varchar(30) = null,

    @s_sesn          int = null,

    @s_term          varchar(10) = null,

    @s_ofi           int = null,

    @s_rol           smallint = null,

    @s_date          datetime = null,

    @s_cliente       int = null,

    @s_servicio      tinyint = null,

    @s_perfil        smallint = null,

    @s_ssn_branch    int = null,

    @t_ejec          char(1) = null,

    @t_corr          char(1) = null,

    @t_ssn_corr      int = null,

    @t_rty           char(1) = null,

    @t_trn           int = null,

    @t_sp_error      varchar(32)=null,

    /* Clave para activar reentrada */

    @o_clave         int out

)

as

declare

    @w_return        int,

    @w_proc          int,

    @w_sp_name       varchar(30)



/*  Captura nombre de Stored Procedure  */

select @w_sp_name = 'sp_reentry_init'



/* Solo por compatibilidad. Se debe usar @t_trn en lugar de @i_trn */

if @t_trn is null

    select @t_trn = @i_trn



begin tran



exec @w_return = sp_rseqnos

     @i_tabla = 'ad_sp_reentry',

     @o_siguiente = @w_proc out



if @w_return <> 0

begin  

    exec cobis..sp_cerror

        @t_from = @w_sp_name,

        @i_num  = 50001,

        @i_sev  = 1,

        @i_msg  = 'No fue posible generar una nueva reentrada'

    return @w_return

end



select @o_clave = @w_proc



insert into re_procedure (

    pr_fecha, pr_server, pr_prioridad, pr_estado, pr_proc,

    pr_base, pr_nom_proc, pr_tipo, pr_veces, pr_num_vez, pr_intervalo,

    pr_unidad, pr_oficina, pr_usuario, pr_rol, pr_trn,

    pr_ssn_branch, pr_sp_error)

values (

    '', @i_server, 5, 'I', @w_proc,

    @i_base, @i_sp, 'N', 0, 0, NULL,

    NULL, @s_ofi, @s_user, @s_rol, @t_trn,

    @s_ssn_branch, @t_sp_error)



if @@error <> 0

begin  

    exec cobis..sp_cerror

        @t_from = @w_sp_name,

        @i_num  = 50002,

        @i_sev  = 1,

        @i_msg  = 'No fue posible crear una nueva reentrada'

    return 1

end



if @s_ssn is not null

begin

    insert into re_parametro(

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server,@w_proc, '@s_ssn', 0, 56, datalength(@s_ssn), @s_ssn)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_ssn'

        return 1

    end

end



if @s_lsrv is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server,@w_proc, '@s_lsrv', 0, 39, datalength(@s_lsrv), @s_lsrv)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_lsrv'

        return 1

    end

end



if @s_srv is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server,@w_proc,'@s_srv', 0, 39, datalength(@s_srv), @s_srv)

    

    if @@error <> 0

    begin  

       exec cobis..sp_cerror

           @t_from = @w_sp_name,

           @i_num  = 50003,

           @i_sev  = 1,

           @i_msg  = 'No fue posible insertar el parametro @s_srv'

       return 1

    end

end



if @s_user is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server,@w_proc,'@s_user', 0, 39, datalength(@s_user), @s_user)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_user'

        return 1

    end

end



if @s_sesn is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server,@w_proc,'@s_sesn', 0, 56, datalength(@s_sesn), @s_sesn)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_sesn'

        return 1

    end

end



if @s_term is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server,@w_proc,'@s_term', 0, 39, datalength(@s_term), @s_term)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_term'

        return 1

    end

end



if @s_ofi is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server, @w_proc, '@s_ofi', 0, 56, datalength(@s_ofi), @s_ofi)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_ofi'

        return 1

    end

end



if @s_rol is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_smallint)

    values (

        @i_server, @w_proc, '@s_rol', 0, 52, datalength(@s_rol), @s_rol)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_rol'

        return 1

    end

end



if @s_date is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_datetime)

    values (

        @i_server, @w_proc, '@s_date', 0, 61, datalength(@s_date), @s_date)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_date'

        return 1

    end

end



if @s_cliente is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server, @w_proc, '@s_cliente', 0, 56, datalength(@s_cliente), @s_cliente)

   

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_cliente'

        return 1

    end

end



if @s_servicio is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_tinyint)

    values (

        @i_server, @w_proc, '@s_servicio', 0, 48, datalength(@s_servicio), @s_servicio)

   

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_servicio'

        return 1

    end

end



if @s_perfil is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_smallint)

    values (

        @i_server, @w_proc, '@s_perfil', 0, 52, datalength(@s_perfil), @s_perfil)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_perfil'

        return 1

    end

end



if @s_ssn_branch is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server, @w_proc, '@s_ssn_branch', 0, 56, datalength(@s_ssn_branch), @s_ssn_branch)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @s_ssn_branch'

        return 1

    end

end



if @t_ejec is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server, @w_proc, '@t_ejec', 0, 47, datalength(@t_ejec), @t_ejec)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @t_ejec'

        return 1

    end

end



if @t_corr is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server, @w_proc, '@t_corr', 0, 47, datalength(@t_corr), @t_corr)

   

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @t_corr'

        return 1

    end

end



if @t_ssn_corr is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server, @w_proc, '@t_ssn_corr', 0, 56, datalength(@t_ssn_corr), @t_ssn_corr)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @t_ssn_corr'

        return 1

    end

end



if @t_rty is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_varchar)

    values (

        @i_server, @w_proc, '@t_rty', 0, 47, datalength(@t_rty), @t_rty)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @t_rty'

        return 1

    end

end



if @t_trn is not null

begin

    insert into re_parametro (

        pa_server, pa_proc, pa_nomparam, pa_tipo_io, pa_tipodato, pa_largo, pa_int)

    values (

        @i_server, @w_proc, '@t_trn', 0, 56, datalength(@t_trn), @t_trn)

    

    if @@error <> 0

    begin  

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 1,

            @i_msg  = 'No fue posible insertar el parametro @t_trn'

        return 1

    end

end



commit tran



return 0

go

