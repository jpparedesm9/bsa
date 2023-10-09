use cob_cartera
go


if not exists(select 1 from sys.indexes 
              where name = 'idx_tramite' 
              and object_id = OBJECT_ID('ca_seguro_externo'))
begin              
    create nonclustered index idx_tramite ON ca_seguro_externo (se_tramite)
end 


if not exists(select 1 from sys.indexes 
              where name = 'idx_tramite' 
              and object_id = OBJECT_ID('ca_infogaragrupo'))
begin              
    create nonclustered index idx_tramite ON ca_infogaragrupo (in_tramite)
end 




use cob_credito
go
if not exists(select 1 from sys.indexes 
              where name = 'idx_grupo_promo_inicio' 
              and object_id = OBJECT_ID('cr_grupo_promo_inicio'))
begin   
    create nonclustered index idx_grupo_promo_inicio ON cr_grupo_promo_inicio (gpi_grupo, gpi_ente)
end

if not exists(select 1 from sys.indexes 
              where name = 'idx_grupo_promo_inicio_2' 
              and object_id = OBJECT_ID('cr_grupo_promo_inicio'))
begin 
   create nonclustered index idx_grupo_promo_inicio_2 ON cr_grupo_promo_inicio (gpi_tramite , gpi_grupo )
end




