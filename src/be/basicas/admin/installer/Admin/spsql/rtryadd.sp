/************************************************************************/

/* rtryadd.sp : Stored procedure para definir las caracteristicas de    */

/*              ejecucion de transacciones de reentry                   */

/*                                                                      */

/* Stored proc   : sp_reentry_add                                       */

/* Realizado por : Patricio Martinez                                    */

/* Fecha inicio  : 93/05/05                                             */

/*                 98/10/14 PTO Soporte para Branch II                  */

/************************************************************************/

use cobis
go



if exists (select * from sysobjects where name = 'sp_reentry_add')

  drop proc sp_reentry_add

go



create proc sp_reentry_add

(

    @i_tipo          char(1),

    @i_key           int,

    @i_server        varchar(30),

    @i_prioridad     tinyint       = 5,

    @i_fecha         datetime      = NULL,

    @i_veces         int           = NULL,

    @i_intervalo     int           = NULL,

    @i_unidad        char(1)       = NULL

)

as

declare

    @w_sp_name       varchar(30),

    @w_base          varchar(30),

    @w_sp            varchar(30),

    @w_user          varchar(30),

    @w_ofi           int,

    @w_rol           smallint,

    @w_trn           int



select @w_sp_name = 'sp_reentry_add'



/* Verificar la existencia del tipo */

if not exists (select * from re_tipoejec where te_tipoejec = @i_tipo)

begin

    exec cobis..sp_cerror

        @t_from = @w_sp_name,

        @i_num  = 50001,

        @i_sev  = 0,

        @i_msg  = 'No existe el tipo de reentrada'

    return 1

end



if @i_veces is NULL

    select @i_veces = 1



/* Fecha = Fecha de proceso + Hora del Sistema */

if @i_fecha is NULL

    select  @i_fecha = convert(datetime,convert(char(6), fp_fecha, 12) +' '

            + convert(char(8), getdate(), 8))

    from  cobis..ba_fecha_proceso



if @i_tipo = 'P' /* Reentry periodico */

begin

    if @i_intervalo is NULL

    begin

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50002,

            @i_sev  = 0,

            @i_msg  = 'Una reentrada periódica requiere un intervalo'

        return 1

    end

    /* Verificar que la unidad del intervalo sea valida */

    if @i_unidad not in ('S', 'M', 'H', 'D', 'E', 'A')

    begin

        exec cobis..sp_cerror

            @t_from = @w_sp_name,

            @i_num  = 50003,

            @i_sev  = 0,

            @i_msg  = 'Unidad puede ser solo (S)egundos, (M)inutos, (H)oras, (D)ías, (M)eses, (A)ños'

        return 1

    end

end



/* Validar la prioridad */

if @i_prioridad not between 1 and 10

begin

    select @i_prioridad = 5

end



/* Buscar datos del procedimiento */

select distinct

    @w_base = pr_base,

    @w_sp   = pr_nom_proc,

    @w_ofi  = pr_oficina,

    @w_user = pr_usuario,

    @w_rol  = pr_rol,

    @w_trn  = pr_trn

from re_procedure

where pr_proc = @i_key



if @@rowcount <> 1

begin

    exec cobis..sp_cerror

        @t_from = @w_sp_name,

        @i_num  = 50003,

        @i_sev  = 0,

        @i_msg  = 'Clave de reentrada no válida'

    return 1

end



/* Crear un nuevo destino en re_procedure */

insert into re_procedure (

    pr_fecha, pr_server, pr_prioridad, pr_estado, pr_proc,

    pr_base, pr_nom_proc, pr_tipo, pr_veces, pr_num_vez, pr_intervalo,

    pr_unidad, pr_oficina, pr_usuario, pr_rol, pr_trn)

values (

    @i_fecha, @i_server, @i_prioridad, 'P', @i_key,

    @w_base, @w_sp, @i_tipo, @i_veces, 0, @i_intervalo,

    @i_unidad, @w_ofi, @w_user, @w_rol, @w_trn)



if @@error <> 0

begin

    exec cobis..sp_cerror

        @t_from = @w_sp_name,

        @i_num  = 50004,

        @i_sev  = 0,

        @i_msg  = 'No fue posible crear una nueva reentrada'

    return 1

end

return 0

go

