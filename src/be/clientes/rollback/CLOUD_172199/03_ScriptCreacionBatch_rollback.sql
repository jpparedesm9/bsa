use cobis
go

delete from cobis..ba_batch
where ba_batch in (36439, 36440, 36441, 36442, 36443, 36444, 36445, 36446, 36447, 36448, 36449)

delete from cobis..ba_parametro 
where pa_batch in (36439, 36440, 36441, 36442, 36443, 36444, 36445, 36446, 36447, 36448, 36449)
and pa_sarta = 0

go 
