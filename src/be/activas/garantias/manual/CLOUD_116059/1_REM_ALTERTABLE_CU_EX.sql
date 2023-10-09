
use cob_conta_super 
go 



if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_id')                alter table sb_dato_custodia add dc_gl_id   int   
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_tramite')           alter table sb_dato_custodia add dc_gl_tramite   int  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_grupo')             alter table sb_dato_custodia add dc_gl_grupo           int  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_monto_individual')  alter table sb_dato_custodia add dc_gl_monto_individual    money  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_monto_garantia')    alter table sb_dato_custodia add dc_gl_monto_garantia    money null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_fecha_vencimiento') alter table sb_dato_custodia add dc_gl_fecha_vencimiento   datetime null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_pag_estado')        alter table sb_dato_custodia add dc_gl_pag_estado   catalogo null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_pag_fecha')         alter table sb_dato_custodia add dc_gl_pag_fecha  datetime null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_pag_valor')         alter table sb_dato_custodia add dc_gl_pag_valor  money null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_dev_estado')        alter table sb_dato_custodia add dc_gl_dev_estado   catalogo null 
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_dev_valor')         alter table sb_dato_custodia add dc_gl_dev_valor  money  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_dev_fecha')         alter table sb_dato_custodia add dc_gl_dev_fecha  datetime null


if exists (select * from sysindexes where id=object_id('dbo.sb_dato_custodia') and name='idx1')  drop index idx1 on sb_dato_custodia    


create nonclustered index idx1 on dbo.sb_dato_custodia (dc_fecha,dc_gl_id,dc_aplicativo)
	
	
	
alter table sb_dato_custodia  alter column dc_garantia     varchar (64) null
alter table sb_dato_custodia  alter column dc_oficina      int null
alter table sb_dato_custodia  alter column dc_categoria    varchar (1)  null
alter table sb_dato_custodia  alter column dc_tipo         varchar (14) null
alter table sb_dato_custodia  alter column dc_moneda       int          null
alter table sb_dato_custodia  alter column dc_fecha_avaluo datetime     null
alter table sb_dato_custodia  alter column dc_valor_actual money        null
alter table sb_dato_custodia  alter column dc_valor_avaluo money        null
alter table sb_dato_custodia  alter column dc_estado       varchar (1)  null
alter table sb_dato_custodia  alter column dc_abierta      varchar (1)  null
alter table sb_dato_custodia  alter column dc_idonea      varchar (1)  null

update statistics sb_dato_custodia
go 

use cob_externos 
go 

if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_id')                alter table ex_dato_custodia add dc_gl_id                int  
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_tramite')           alter table ex_dato_custodia add dc_gl_tramite           int  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_grupo')             alter table ex_dato_custodia add dc_gl_grupo             int  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_monto_individual')  alter table ex_dato_custodia add dc_gl_monto_individual  money  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_monto_garantia')    alter table ex_dato_custodia add dc_gl_monto_garantia    money null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_fecha_vencimiento') alter table ex_dato_custodia add dc_gl_fecha_vencimiento datetime null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_pag_estado')        alter table ex_dato_custodia add dc_gl_pag_estado        catalogo null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_pag_fecha')         alter table ex_dato_custodia add dc_gl_pag_fecha         datetime null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_pag_valor')         alter table ex_dato_custodia add dc_gl_pag_valor         money null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_dev_estado')        alter table ex_dato_custodia add dc_gl_dev_estado       catalogo null 
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_dev_valor')         alter table ex_dato_custodia add dc_gl_dev_valor        money  null
if  not exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_dev_fecha')         alter table ex_dato_custodia add dc_gl_dev_fecha        datetime null





if exists (select * from sysindexes where id=object_id('dbo.ex_dato_custodia') and name='idx1')   drop index idx1 on ex_dato_custodia

create  nonclustered index idx1 on dbo.ex_dato_custodia (dc_fecha,dc_gl_id, dc_aplicativo)
	
alter table ex_dato_custodia  alter column dc_garantia     varchar (64) null
alter table ex_dato_custodia  alter column dc_oficina      int null
alter table ex_dato_custodia  alter column dc_categoria    varchar (1)  null
alter table ex_dato_custodia  alter column dc_tipo         varchar (14) null
alter table ex_dato_custodia  alter column dc_moneda       int          null
alter table ex_dato_custodia  alter column dc_fecha_avaluo datetime     null
alter table ex_dato_custodia  alter column dc_valor_actual money        null
alter table ex_dato_custodia  alter column dc_valor_avaluo money        null
alter table ex_dato_custodia  alter column dc_estado       varchar (1)  null
alter table ex_dato_custodia  alter column dc_abierta      varchar (1)  null
alter table ex_dato_custodia  alter column dc_idonea       varchar (1)  null

update statistics ex_dato_custodia 
go 

delete cobis..cl_parametro where pa_nemonico = 'CTGARL' and pa_producto = 'CCA'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CUENTA CONTABLE PARA GARANTIAS LIQUIDAS', 'CTGARL', 'C', '241302', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO
