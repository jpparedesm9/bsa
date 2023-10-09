use cobis
go

if not exists (select 1 from cl_producto where pd_producto=21)
begin
    insert into cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
    values (21,'R','CREDITO','CRE',getdate(),'V',null,null)
end

if not exists (select 1 from cl_pro_moneda where pm_producto=21)
begin
    insert into cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion, pm_fecha_aper, pm_estado)
    values (21,'R',0,'CREDITO',getdate(),'V')
end
go
