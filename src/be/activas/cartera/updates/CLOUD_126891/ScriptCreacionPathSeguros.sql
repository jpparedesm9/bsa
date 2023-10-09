use cobis
go


if not exists (select 1 from cobis..ba_path_pro where pp_producto = 77)
begin
    insert into cobis..ba_path_pro (pp_producto, pp_path_fuente                    , pp_path_destino)
                            values (77         , 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\seguros\listados\')
end

select * from cobis..ba_path_pro where pp_producto = 77

go




