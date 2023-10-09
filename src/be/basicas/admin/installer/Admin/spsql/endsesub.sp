use cobis
go



if exists (select * from sysobjects where name = 'sp_end_secure_submit')

    drop proc sp_end_secure_submit

go

create proc sp_end_secure_submit

    (

    @i_wait        char(1)        = 'N'

        /* Seleccion de espera, 'S' o 'N' */

        /* Si 'S' */

        /*    Entonces el usuario no recibe respuesta inmediata */

        /*      y el stored proc remoto debera ejecutar  */

        /*    sp_begin_resubmit para reejecutar el actual */

        /*    stored proc con parametros adicionales */

        /* Si 'N' */

        /*    Entonces la respuesta va al usuario local */

    )

as

select upper(@i_wait)



/*

PTO 1996-06-24 No usar la funcion prWait para evitar problemas de 

sincronizacion entre submit y resubmit 



if (@i_wait = 'S') or (@i_wait = 's')

begin

    raiserror 44441 'w' /* Wait */

    select    null

end

*/

go

