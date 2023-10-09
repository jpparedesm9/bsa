
use cobis
go

select ba_arch_resultado, *
from  cobis..ba_batch
where ba_batch in (36411, 36419, 36420, 36424)

update cobis..ba_batch
set   ba_arch_resultado = 'Rep_A_0411.txt'
where ba_batch = 36411

update cobis..ba_batch
set   ba_arch_resultado = 'Rep_A_0419.txt'
where ba_batch = 36419

update cobis..ba_batch
set   ba_arch_resultado = 'Rep_A_0420.txt'
where ba_batch = 36420

update cobis..ba_batch
set   ba_arch_resultado = 'Rep_A_0424.txt'
where ba_batch = 36424

select ba_arch_resultado, *
from  cobis..ba_batch
where ba_batch in (36411, 36419, 36420, 36424)

go

