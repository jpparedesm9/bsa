use cobis
go



if exists (select * from sysobjects where name = 'sp_rty_procedure')

   drop procedure sp_rty_procedure

go



create proc sp_rty_procedure

(

    @i_operacion    varchar(2),

    @i_server    varchar(30) = null,

    @i_proc        int = null,

    @o_prioridad    tinyint = null out,

    @o_estado    char(1) = null out,

    @o_num_rec    smallint = 20 out

)

as

declare    @w_estado    char(1),

    @v_estado   char(1),

    @w_sp_name    varchar(30)



select @w_sp_name = 'sp_rty_procedure'



if @i_operacion = 'C'    /* Consulta */

begin

    select @o_prioridad = pr_prioridad,

        @o_estado = pr_estado

    from re_procedure

    where pr_server = @i_server

    and pr_proc = @i_proc

end



if @i_operacion = 'UP'    /* Actualizar Prioridad */

begin

    if @o_prioridad not between 1 and 10

    begin

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50001,

            @i_sev  = 0,

            @i_msg  = 'La prioridad debe estar entre 1 y 10'

        return 1

    end



    update re_procedure

    set pr_prioridad = @o_prioridad

    where pr_server = @i_server

    and pr_proc = @i_proc



    if @@error <> 0

    begin

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num = 50002,

            @i_sev = 0,

            @i_msg = 'No fue posible cambiar la prioridad'

        return 1

    end

    return 0

end



if @i_operacion = 'UE'    /* Actualizar Estado */

begin

    if @o_estado is null or not exists (

        select * from re_chg_procsts

        where cp_nuevo = @o_estado

              and cp_actual = (select pr_estado

                               from re_procedure

                               where pr_server = @i_server

                                     and pr_proc = @i_proc))

    begin

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 0,

            @i_msg  = 'Cambio de estado no permitido'

        return 1

    end



    update re_procedure

    set pr_estado = @o_estado

    where pr_server = @i_server

    and pr_proc = @i_proc



    if @@error <> 0

    begin

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num = 50004,

            @i_sev = 0,

            @i_msg = 'No fue posible cambiar el estado'

        return 1

    end

    return 0

end



if @i_operacion = 'S'

begin

    if isnull(@o_num_rec,0) not between 1 and 20

        select @o_num_rec = 20

    set rowcount @o_num_rec

    select    'Clave'=pr_proc,

        'Base'=pr_base,

        'Procedimiento'=pr_nom_proc,

        'Fecha'=pr_fecha,

        'Prioridad'=pr_prioridad,

        'Estado'=pr_estado,

        'Tipo'=pr_tipo,

        'Veces'=pr_veces,

        'Num.Vez'=pr_num_vez,

        'Intervalo'=pr_intervalo,

        'Unidad'=pr_unidad,

        'Oficina'=pr_oficina,

        'Usuario'=pr_usuario,

        'Rol'=pr_rol,

        'Trn'=pr_trn

    from re_procedure

    where pr_server = @i_server

    order by pr_proc

    set rowcount 0

    return 0

end

go

