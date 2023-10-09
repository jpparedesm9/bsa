
use cob_externos
go

alter table ex_dato_operacion drop column do_periodicidad

use cob_conta_super
go

alter table sb_dato_operacion drop column  do_periodicidad

use cob_conta_super
go

alter table sb_dato_operacion_tmp drop column  do_periodicidad
go

