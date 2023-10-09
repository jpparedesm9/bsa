use cob_cartera
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='pk_ca_infogaragrupo_det'  )
begin                
   alter table ca_infogaragrupo_det
   drop constraint pk_ca_infogaragrupo_det
end 
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='FK__ca_infoga__ind_g__1ADCA147'  )
begin  
   alter table ca_infogaragrupo_det
   drop constraint FK__ca_infoga__ind_g__1ADCA147
end 
go

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='PK_ca_infogaragrupo'  )
begin 	
   alter table ca_infogaragrupo
   drop constraint PK_ca_infogaragrupo
end
go



if not exists(select 1 from sys.indexes 
              where name = 'idxin_grupo_id' 
              and object_id = OBJECT_ID('ca_infogaragrupo'))
begin              
    create nonclustered index idxin_grupo_id ON ca_infogaragrupo (in_grupo_id)
end 

if not exists(select 1 from sys.indexes 
              where name = 'idx_tramite' 
              and object_id = OBJECT_ID('ca_infogaragrupo'))
begin              
    create nonclustered index idx_tramite ON ca_infogaragrupo (in_tramite)
end 



if not exists(select 1 from sys.indexes 
              where name = 'idx_ind_grupo_id' 
              and object_id = OBJECT_ID('ca_infogaragrupo_det'))
begin              
    create nonclustered index idx_ind_grupo_id ON ca_infogaragrupo_det (ind_grupo_id)
end 

