
use cob_conta_super 
go 

if exists (select * from sysindexes where id=object_id('dbo.sb_dato_custodia') and name='idx1')  drop index idx1 on sb_dato_custodia 

if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_id')                alter table sb_dato_custodia drop column dc_gl_id                   
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_tramite')           alter table sb_dato_custodia drop column dc_gl_tramite              
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_grupo')             alter table sb_dato_custodia drop column dc_gl_grupo                
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_monto_individual')  alter table sb_dato_custodia drop column dc_gl_monto_individual     
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_monto_garantia')    alter table sb_dato_custodia drop column dc_gl_monto_garantia       
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_fecha_vencimiento') alter table sb_dato_custodia drop column dc_gl_fecha_vencimiento    
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_pag_estado')        alter table sb_dato_custodia drop column dc_gl_pag_estado           
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_pag_fecha')         alter table sb_dato_custodia drop column dc_gl_pag_fecha            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_pag_valor')         alter table sb_dato_custodia drop column dc_gl_pag_valor            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_dev_estado')        alter table sb_dato_custodia drop column dc_gl_dev_estado            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_dev_valor')         alter table sb_dato_custodia drop column dc_gl_dev_valor            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'sb_dato_custodia' and b.name = 'dc_gl_dev_fecha')         alter table sb_dato_custodia drop column dc_gl_dev_fecha            




	
	
	
alter table sb_dato_custodia  alter column dc_garantia     varchar (64)    
alter table sb_dato_custodia  alter column dc_oficina      int             
alter table sb_dato_custodia  alter column dc_categoria    varchar (1)     
alter table sb_dato_custodia  alter column dc_tipo         varchar (14)    
alter table sb_dato_custodia  alter column dc_moneda       int          
alter table sb_dato_custodia  alter column dc_fecha_avaluo datetime        
alter table sb_dato_custodia  alter column dc_valor_actual money          
alter table sb_dato_custodia  alter column dc_estado       varchar (1)    
alter table sb_dato_custodia  alter column dc_abierta      varchar (1)   



create nonclustered index idx1 on dbo.sb_dato_custodia (dc_fecha,dc_garantia,dc_aplicativo)

update statistics sb_dato_custodia
go 

use cob_externos 
go 


if exists (select * from sysindexes where id=object_id('dbo.ex_dato_custodia') and name='idx1')   drop index idx1 on ex_dato_custodia

if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_id')                alter table ex_dato_custodia drop column dc_gl_id                   
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_tramite')           alter table ex_dato_custodia drop column dc_gl_tramite              
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_grupo')             alter table ex_dato_custodia drop column dc_gl_grupo                
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_monto_individual')  alter table ex_dato_custodia drop column dc_gl_monto_individual     
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_monto_garantia')    alter table ex_dato_custodia drop column dc_gl_monto_garantia       
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_fecha_vencimiento') alter table ex_dato_custodia drop column dc_gl_fecha_vencimiento    
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_pag_estado')        alter table ex_dato_custodia drop column dc_gl_pag_estado           
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_pag_fecha')         alter table ex_dato_custodia drop column dc_gl_pag_fecha            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_pag_valor')         alter table ex_dato_custodia drop column dc_gl_pag_valor            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_dev_estado')        alter table ex_dato_custodia drop column dc_gl_dev_estado            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_dev_valor')         alter table ex_dato_custodia drop column dc_gl_dev_valor            
if  exists (select 1 from sysobjects a, syscolumns b where a.id = b.id and a.name = 'ex_dato_custodia' and b.name = 'dc_gl_dev_fecha')         alter table ex_dato_custodia drop column dc_gl_dev_fecha 




 

create nonclustered index idx1 on dbo.ex_dato_custodia (dc_fecha,dc_garantia,dc_aplicativo)
	
alter table ex_dato_custodia  alter column dc_garantia     varchar (64) null
alter table ex_dato_custodia  alter column dc_oficina      int null
alter table ex_dato_custodia  alter column dc_categoria    varchar (1)  null
alter table ex_dato_custodia  alter column dc_tipo         varchar (14) null
alter table ex_dato_custodia  alter column dc_moneda       int          null
alter table ex_dato_custodia  alter column dc_fecha_avaluo datetime     null
alter table ex_dato_custodia  alter column dc_valor_actual money        null
alter table ex_dato_custodia  alter column dc_estado       varchar (1)  null
alter table ex_dato_custodia  alter column dc_abierta      varchar (1)  null


update statistics ex_dato_custodia 
go 