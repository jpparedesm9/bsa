
use cobis 
go 

delete from ba_sarta_batch_exec
where sb_sarta = 2

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 2

go

delete from ba_sarta_batch_exec
where sb_sarta = 3

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 3

go

delete from ba_sarta_batch_exec
where sb_sarta = 4

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 4

go


delete from ba_sarta_batch_exec
where sb_sarta = 1010
go

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 1010

go


--------------------------------------
delete from ba_sarta_batch_exec
where sb_sarta = 12
go

delete from ba_sarta_batch_exec
where sb_sarta = 13
go

delete from ba_sarta_batch_exec
where sb_sarta = 22
go

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 12
go

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 13
go

insert into ba_sarta_batch_exec
(sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 
 sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
       sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
       'N', null, 0
from ba_sarta_batch
where sb_sarta = 22
go

--------------------------------------

