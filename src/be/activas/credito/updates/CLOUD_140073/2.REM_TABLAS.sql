use cob_cartera
go

if not exists (select 1 from sys.columns 
           where Name = N'op_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion')) begin
   alter table ca_operacion
   add op_desplazamiento     int null
end   


if not exists (select 1 from sys.columns 
           where Name = N'opt_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_tmp')) begin
   alter table ca_operacion_tmp
   add opt_desplazamiento     int null
end   


if not exists (select 1 from sys.columns 
           where Name = N'oph_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_his')) begin
   alter table ca_operacion_his
   add oph_desplazamiento     int null
end  


if not exists (select 1 from sys.columns 
           where Name = N'ops_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_ts')) begin
   alter table ca_operacion_ts
   add ops_desplazamiento     int null
end  


if not exists (select 1 from sys.columns 
           where Name = N'dt_desplazamiento'
           and Object_ID = Object_ID(N'ca_default_toperacion')) begin
   alter table ca_default_toperacion
   add dt_desplazamiento smallint null
end  


if not exists (select 1 from sys.columns 
           where Name = N'dts_desplazamiento'
           and Object_ID = Object_ID(N'ca_default_toperacion_ts')) begin
   alter table ca_default_toperacion_ts
   add dts_desplazamiento smallint null
end  
go

use cob_cartera_his
go

if not exists (select 1 from sys.columns 
           where Name = N'oph_desplazamiento'
           and Object_ID = Object_ID(N'ca_operacion_his')) begin
   alter table ca_operacion_his
   add oph_desplazamiento     int null
end  

go