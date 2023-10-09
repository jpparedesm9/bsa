
use cob_externos
go

alter table ex_dato_operacion add do_periodicidad int null   

use cob_conta_super
go

alter table sb_dato_operacion add do_periodicidad int null   

use cob_conta_super
go

alter table sb_dato_operacion_tmp add do_periodicidad int null   