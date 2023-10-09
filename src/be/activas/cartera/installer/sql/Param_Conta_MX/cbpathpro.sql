
use cobis
go

delete cobis..ba_path_pro 
where pp_producto in (4, 6, 7, 14, 19, 21, 36)
go


insert into cobis..ba_path_pro values (4,  'C:\Cobis\VBatch\Ahorros\Objetos\',      'C:\Cobis\VBatch\Ahorros\listados\')
insert into cobis..ba_path_pro values (6,  'C:\Cobis\VBatch\Conta\Objetos\',        'C:\Cobis\VBatch\Conta\listados\')
insert into cobis..ba_path_pro values (7,  'C:\Cobis\VBatch\Cartera\Objetos\',      'C:\Cobis\VBatch\Cartera\listados\')
insert into cobis..ba_path_pro values (14, 'C:\Cobis\VBatch\PFijo\Objetos\',        'C:\Cobis\VBatch\PFijo\listados\')
insert into cobis..ba_path_pro values (19, 'C:\Cobis\VBatch\Custodia\Objetos\',     'C:\Cobis\VBatch\Custodia\listados\')
insert into cobis..ba_path_pro values (21, 'C:\Cobis\VBatch\Credito\Objetos\',      'C:\Cobis\VBatch\Credito\listados\')
insert into cobis..ba_path_pro values (36, 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
insert into cobis..ba_path_pro values (77  ,'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\seguros\listados\')

go

