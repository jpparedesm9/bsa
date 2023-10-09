use cobis
go

if exists (select * from sysobjects where name = 'sp_begin_resubmit')

    drop proc sp_begin_resubmit

go

create proc sp_begin_resubmit

    (

    @i_toserver    varchar(30),             /* Servidor en el que se ejecutara el stored procedure */

    @i_touser    varchar(30)     = null,    /* Usuario al que esta asocidada la transaccion  */

                                            /* Este parametro se utiliza solo para chequeo de que la */

                                            /* sesion (i_tosesion) corresponde a este usuario */

    @i_tosesion    int                      /* Sesion de la transaccion a ser reejecutada con los */

                                            /* parametros adicionales de la sentencia select ejecutada */

                                            /* luego de este stored procedure */

    )

as

raiserror 44441 'r' /* Resubmit */

select i_tipo        = 'r',

       i_toserver    = @i_toserver,

       i_touser      = @i_touser,

       i_tosesion    = @i_tosesion

return 0

go



