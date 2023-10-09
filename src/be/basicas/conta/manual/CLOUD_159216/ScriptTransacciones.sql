use cobis
go


if not exists(select 1 from cobis..cl_ttransaccion where tn_trn_code = 6644)
begin
   insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
   values (6644, 'AUTORIZAR/ANULAR', '6643', 'AUTORIZAR/ANULAR')
end

select *
from cobis..cl_ttransaccion
where tn_trn_code = 6644

if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 6644 and ta_rol = 1)
begin
   insert into dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
   values (6, 'R', 0, 6644, 1, getdate(), 1, 'V', getdate())
end

select * from ad_tr_autorizada where ta_transaccion = 6644