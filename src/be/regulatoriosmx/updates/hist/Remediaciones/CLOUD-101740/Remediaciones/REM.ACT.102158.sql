
use cob_conta_super 
go 


if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_uno') 
    alter table sb_dato_operacion drop column do_respuesta_uno    
   

if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_dos') 
	alter table sb_dato_operacion drop column do_respuesta_dos          
	
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_tres') 
	alter table sb_dato_operacion drop column do_respuesta_tres         
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_cuatro') 
	alter table sb_dato_operacion drop column do_respuesta_cuatro       
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_cinco') 
	alter table sb_dato_operacion drop column do_respuesta_cinco        
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_seis') 
	alter table sb_dato_operacion drop column do_respuesta_seis         
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_siete ') 
	alter table sb_dato_operacion drop column do_respuesta_siete        
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_ocho') 
	alter table sb_dato_operacion drop column do_respuesta_ocho        
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_nueve') 
	alter table sb_dato_operacion drop column do_respuesta_nueve       
	
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_diez') 
	alter table sb_dato_operacion drop column do_respuesta_diez         

	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_once') 
	alter table sb_dato_operacion drop column do_respuesta_once         
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_doce') 
	alter table sb_dato_operacion drop column do_respuesta_doce         
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_trece') 
	alter table sb_dato_operacion drop column do_respuesta_trece        
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_catorce') 
	alter table sb_dato_operacion drop column do_respuesta_catorce      

	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_quince') 
	alter table sb_dato_operacion drop column do_respuesta_quince       
	
	
if  exists (select 1 from sysobjects a, syscolumns b
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_dieciseis') 
	alter table sb_dato_operacion drop column do_respuesta_dieciseis    
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_diecisiete') 
	alter table sb_dato_operacion drop column do_respuesta_diecisiete   
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_respuesta_dieciocho ') 
	alter table sb_dato_operacion drop column do_respuesta_dieciocho   
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_coordinador') 
	alter table sb_dato_operacion drop column do_coordinador            
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion' 
	and b.name = 'do_gerente') 
	alter table sb_dato_operacion drop column do_gerente                
	




if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_uno       ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_uno          
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_dos       ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_dos     
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_tres      ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_tres         
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_cuatro    ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_cuatro       
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_cinco     ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_cinco        
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_seis      ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_seis 
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_siete     ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_siete       
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_ocho      ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_ocho         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_nueve     ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_nueve        
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_diez      ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_diez         
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_once      ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_once    
    
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
    and b.name = 'do_respuesta_doce      ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_doce         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_trece     ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_trece        
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_catorce   ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_catorce      
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_quince    ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_quince       
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_dieciseis ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_dieciseis    
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_diecisiete') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_diecisiete   
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_respuesta_dieciocho ') 
	alter table sb_dato_operacion_tmp drop column do_respuesta_dieciocho  
	
if  exists (select 1 from sysobjects a, syscolumns b
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_coordinador         ') 
	alter table sb_dato_operacion_tmp drop column do_coordinador            
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'sb_dato_operacion_tmp' 
	and b.name = 'do_gerente             ') 
	alter table sb_dato_operacion_tmp drop column do_gerente                


if object_id ('dbo.sb_dato_verificacion') is not null
	drop table dbo.sb_dato_verificacion
go

create table sb_dato_verificacion ( 
dv_fecha          datetime    null,
dv_cliente        int         null,
dv_tramite        int         null,
dv_r01            catalogo    null,
dv_r02            catalogo    null,
dv_r03            catalogo    null,
dv_r04            catalogo    null,
dv_r05            catalogo    null,
dv_r06            catalogo    null,
dv_r07            catalogo    null,
dv_r08            catalogo    null,
dv_r09            catalogo    null,
dv_r10            catalogo    null,
dv_r11            catalogo    null,
dv_r12            catalogo    null,
dv_r13            catalogo    null,
dv_r14            catalogo    null,
dv_r15            catalogo    null,
dv_r16            catalogo    null,
dv_r17            catalogo    null,
dv_r18            catalogo    null,
dv_r19            catalogo    null,
dv_r20            catalogo    null,
dv_puntaje         int        null
)




if exists (select 1 from sysindexes  where name = 'sb_dato_encuesta1') 
drop index sb_dato_encuesta1 on sb_dato_verificacion 

if exists (select 1 from sysindexes  where name = 'sb_dato_encuesta2') 
drop index sb_dato_encuesta2 on sb_dato_verificacion 

if exists (select 1 from sysindexes  where name = 'sb_dato_encuesta3') 
drop index sb_dato_encuesta3 on sb_dato_verificacion 

create nonclustered index sb_dato_encuesta1 on sb_dato_verificacion(dv_cliente,dv_fecha)
create nonclustered index sb_dato_encuesta2 on sb_dato_verificacion(dv_tramite)
create nonclustered index sb_dato_encuesta3 on sb_dato_verificacion(dv_fecha)



use cob_externos
go 

if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_uno') 
	alter table ex_dato_operacion drop column do_respuesta_uno          
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_dos') 
	alter table ex_dato_operacion drop column do_respuesta_dos         
	
if  exists (select 1 from sysobjects a, syscolumns b
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_tres') 
	alter table ex_dato_operacion drop column do_respuesta_tres         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_cuatro') 
	alter table ex_dato_operacion drop column do_respuesta_cuatro       
	
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_cinco') 
	alter table ex_dato_operacion drop column do_respuesta_cinco        
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_seis') 
	alter table ex_dato_operacion drop column do_respuesta_seis         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_siete') 
	alter table ex_dato_operacion drop column do_respuesta_siete        
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_ocho') 
	alter table ex_dato_operacion drop column do_respuesta_ocho         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_nueve') 
	alter table ex_dato_operacion drop column do_respuesta_nueve        
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_diez')
	alter table ex_dato_operacion drop column do_respuesta_diez         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_once') 
	alter table ex_dato_operacion drop column do_respuesta_once         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_doce') 
	alter table ex_dato_operacion drop column do_respuesta_doce         
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_trece') 
	alter table ex_dato_operacion drop column do_respuesta_trece        
	
if  exists (select 1 from sysobjects a, syscolumns b
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_catorce') 
	alter table ex_dato_operacion drop column do_respuesta_catorce      
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_quince') 
	alter table ex_dato_operacion drop column do_respuesta_quince       
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_dieciseis') 
	alter table ex_dato_operacion drop column do_respuesta_dieciseis   
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_diecisiete') 
	alter table ex_dato_operacion drop column do_respuesta_diecisiete   
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_respuesta_dieciocho') 
	alter table ex_dato_operacion drop column do_respuesta_dieciocho    
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_coordinador') 
	alter table ex_dato_operacion drop column do_coordinador            
	
if  exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' 
	and b.name = 'do_gerente') 
	alter table ex_dato_operacion drop column do_gerente               

if object_id ('dbo.ex_dato_verificacion') is not null
	drop table dbo.ex_dato_verificacion



create table ex_dato_verificacion ( 
dv_fecha          datetime    null,
dv_cliente        int         null,
dv_tramite        int         null,
dv_r01            catalogo    null,
dv_r02            catalogo    null,
dv_r03            catalogo    null,
dv_r04            catalogo    null,
dv_r05            catalogo    null,
dv_r06            catalogo    null,
dv_r07            catalogo    null,
dv_r08            catalogo    null,
dv_r09            catalogo    null,
dv_r10            catalogo    null,
dv_r11            catalogo    null,
dv_r12            catalogo    null,
dv_r13            catalogo    null,
dv_r14            catalogo    null,
dv_r15            catalogo    null,
dv_r16            catalogo    null,
dv_r17            catalogo    null,
dv_r18            catalogo    null,
dv_r19            catalogo    null,
dv_r20            catalogo    null,
dv_puntaje         int        null
)




