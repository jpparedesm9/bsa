use cob_cartera
go

if exists (select 1 from sys.columns 
           where Name = N'op_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion')) begin
   alter table ca_operacion
   drop column op_desplazamiento
end   


if  exists (select 1 from sys.columns 
           where Name = N'opt_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_tmp')) begin
   alter table ca_operacion_tmp
   drop column opt_desplazamiento  
end   


if  exists (select 1 from sys.columns 
           where Name = N'oph_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_his')) begin
   alter table ca_operacion_his
   drop column oph_desplazamiento     
end  


if  exists (select 1 from sys.columns 
           where Name = N'ops_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_ts')) begin
   alter table ca_operacion_ts
   drop column ops_desplazamiento    
end  


if  exists (select 1 from sys.columns 
           where Name = N'dt_desplazamiento'
           and Object_ID = Object_ID(N'ca_default_toperacion')) begin
   alter table ca_default_toperacion
   drop column dt_desplazamiento 
end  


if  exists (select 1 from sys.columns 
           where Name = N'dts_desplazamiento'
           and Object_ID = Object_ID(N'ca_default_toperacion_ts')) begin
   alter table ca_default_toperacion_ts
   drop column dts_desplazamiento
end  
go

use cob_cartera_his
go

if  exists (select 1 from sys.columns 
           where Name = N'oph_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_his')) begin
   alter table ca_operacion_his
   drop column oph_desplazamiento  
end  

go