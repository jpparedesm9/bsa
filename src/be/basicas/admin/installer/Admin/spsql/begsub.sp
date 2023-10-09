use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_submit')

    drop proc sp_begin_submit

go

create proc sp_begin_submit

    (

    @i_toserver    varchar(30),        

        /* Servidor en el que se ejecutara el stored procedure */

    @i_touser    varchar(30)     = null,

        /* Usuario que recibira la respuesta del stored procedure */

        /* Si @i_touser = null  */

        /*    Si el storproc no ejecuta sp_begin_resubmit  */

        /*        Entonces la respuesta va directamente al  */

        /*        usuario que inicio la transaccion  */

        /*    Si el stor proc ejecuta sp_begin_resubmit  */

        /*        Entonces la respuesta debe ser una sola   */

        /*        linea con parametros adicionales  */

        /*        para re-ejecutar el stored proc original  */

        /*  Si @i_touser no es null  */

        /*    El resultado de la ejecucion del stored procedure  */

        /*    ira a travez de mail al usuario respectivo en el  */

        /*    servidor remoto  */

    @i_storproc    varchar(30)

        /*  Nombre del stored proc a ejecutarse remotamente */

        /*  Formato:  'string1.string2' */

        /*             string1 = base de datos(opcional) */

        /*           string2 = stored procedure */

    )

as

raiserror 44441 's' /* Submit */

select i_tipo        = 's',

       i_toserver    = @i_toserver,

       i_touser      = @i_touser,

       i_storproc    = @i_storproc

go



