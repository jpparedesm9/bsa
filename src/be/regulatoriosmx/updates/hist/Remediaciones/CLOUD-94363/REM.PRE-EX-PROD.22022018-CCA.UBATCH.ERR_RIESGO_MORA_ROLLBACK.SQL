
use cobis
go

select ba_arch_resultado
from  cobis..ba_batch
where ba_batch = 36426

update cobis..ba_batch
set   ba_arch_resultado = 'COB_RIESGOS_MORAS_DIARIO'
where ba_batch = 36426

select ba_arch_resultado
from  cobis..ba_batch
where ba_batch = 36426
go

