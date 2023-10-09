use cobis
go

declare @w_proceso_ods_d     int,
        @w_proceso_ods_m     int,
        @w_secuencial_ods_d  int,
        @w_secuencial_ods_m  int,
        @w_sarta             int

select @w_proceso_ods_d = 7527,
       @w_proceso_ods_m = 7528,
       @w_sarta         = 22

select @w_secuencial_ods_d = sb_secuencial
from cobis..ba_sarta_batch
where sb_batch = @w_proceso_ods_d

select @w_secuencial_ods_m = sb_secuencial
from cobis..ba_sarta_batch
where sb_batch = @w_proceso_ods_m

select  *
from cobis..ba_parametro
where pa_sarta = @w_sarta
and   pa_batch in (@w_proceso_ods_d, @w_proceso_ods_m)

update cobis..ba_parametro
set   pa_ejecucion = 32
where pa_sarta = @w_sarta
and   pa_batch = @w_proceso_ods_d


update cobis..ba_parametro
set   pa_ejecucion = 33
where pa_sarta = @w_sarta
and   pa_batch = @w_proceso_ods_m

select  *
from cobis..ba_parametro
where pa_sarta = @w_sarta
and   pa_batch in (@w_proceso_ods_d, @w_proceso_ods_m)