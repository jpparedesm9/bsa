
use cob_conta_super
go

if not exists(select 1 from sysobjects o, sysindexes i 
              where o.name = 'sb_riesgo_hrc' and o.type = 'U'
              and i.id = o.id and i.name = 'idx1')

   create clustered index idx1 on cob_conta_super..sb_riesgo_hrc(rh_num_cred)
go

