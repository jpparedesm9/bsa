use cobis
go



if exists (select * from sysobjects where name = 'sp_rolspro')

    drop proc sp_rolspro

go

create proc sp_rolspro

as



select distinct ta_rol, ta_transaccion, pd_base_datos, pd_stored_procedure

from ad_tr_autorizada, ad_pro_transaccion, ad_procedure

where ta_producto = pt_producto

    and ta_tipo = pt_tipo

    and ta_moneda = pt_moneda

    and ta_transaccion = pt_transaccion

    and pd_procedure = pt_procedure

    and ta_estado = 'V'

    and pt_estado = 'V'

    and pd_estado = 'V'

order by ta_rol, ta_transaccion, pd_base_datos, pd_stored_procedure



go

