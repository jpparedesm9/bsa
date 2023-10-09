
use cob_credito
go


if not exists(select 1 from sys.indexes 
              where name = 'idx4' 
              and object_id = OBJECT_ID('cr_tramite_grupal'))
begin              
    create nonclustered index idx4 ON cr_tramite_grupal (tg_grupo, tg_tramite)
end 






