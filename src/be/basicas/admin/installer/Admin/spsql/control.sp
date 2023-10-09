use cob_distrib
go



if exists (select * from sysobjects where name = 'sp_control')

    drop proc sp_control

go



create proc sp_control

(

    @i_operacion  char(1),

    @i_server     varchar(30) = null,

    @i_logid    int=-1,

    @i_estado     char(1) = null,

    @i_error      int = 0,

    @i_mensaje    varchar(128) = ''

)

as

begin

    /* Actualizar estado */

    if @i_operacion = 'U'

    begin

        update di_control

        set ct_estado = @i_estado,

            ct_fecha = getdate()

        where ct_servidor = @i_server

        return 0

    end 



    /* Actualizar ID */

    if @i_operacion = 'A'

    begin

        update di_control

        set ct_estado = 'U',

            ct_logid = @i_logid,

            ct_fecha = getdate(),

            ct_error = 0,

            ct_mensaje = ''

        where ct_servidor = @i_server

        return 0

    end 

    

    /* Registrar error */

    if @i_operacion = 'E'

    begin

        update di_control

        set ct_estado = 'E',

            ct_logid = @i_logid,

            ct_fecha = getdate(),

            ct_error = @i_error,

            ct_mensaje = @i_mensaje

        where ct_servidor = @i_server

        return 0

    end 

    

    /* Listar servidores */

    if @i_operacion = 'S'

    begin

        update di_control

        set ct_estado = 'D', ct_fecha = getdate()

        

        select ct_servidor, ct_direccion, 'T', ct_logid, ct_error

        from di_control

        where ct_habilitado = 'S'

        return 0

    end 

end

go

