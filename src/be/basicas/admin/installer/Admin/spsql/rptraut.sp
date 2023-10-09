use cobis
go



if exists (select * from sysobjects where name = 'rp_tr_autorizada')

    drop proc rp_tr_autorizada

go



create proc rp_tr_autorizada (

    @i_rol                  tinyint,

    @i_trn                  int = 0,

    @i_filas                int = 600

)

as

set rowcount @i_filas



select ta_transaccion

from cobis..ad_tr_autorizada

where ta_rol = @i_rol

      and ta_estado = 'V'

      and ta_transaccion > @i_trn

order by ta_transaccion 

return 0

go

