use cob_externos 
go 


-- do_renovacion_grupal,      do_renovacion_ind
---C:\bsa\src\be\activas\dependencias\installer\sql\cobex_table.sql  (126 hits)
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ex_dato_operacion' and COLUMN_NAME = 'do_renovacion_grupal') alter table ex_dato_operacion add  do_renovacion_grupal int   null 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ex_dato_operacion' and COLUMN_NAME = 'do_renovacion_ind') alter table ex_dato_operacion add  do_renovacion_ind int null 

use cob_conta_super 
go 


--C:\bsa\src\be\regulatoriosmx\installer\sql\cbsup_table.sql  
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion_tmp' and COLUMN_NAME = 'do_renovacion_grupal') alter table sb_dato_operacion_tmp add  do_renovacion_grupal int  null 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion_tmp' and COLUMN_NAME = 'do_renovacion_ind') alter table sb_dato_operacion_tmp add  do_renovacion_ind int null 

----src/be/plazofijo/installer/backend/central/dependencies/cob_conta_super/sql/sb_table
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion' and COLUMN_NAME = 'do_renovacion_grupal') alter table sb_dato_operacion add  do_renovacion_grupal  int null 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion' and COLUMN_NAME = 'do_renovacion_ind') alter table sb_dato_operacion add  do_renovacion_ind int null 
