
use cob_conta_super
go

if exists(select 1 from sysobjects o, sysindexes i 
          where o.name = 'sb_riesgo_hrc' and o.type = 'U'
          and i.id = o.id and i.name = 'idx1')

   drop index sb_riesgo_hrc.idx1
go

 