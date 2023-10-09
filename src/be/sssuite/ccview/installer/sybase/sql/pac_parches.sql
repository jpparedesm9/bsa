use cob_credito
go

if not exists (select 1 from syscolumns  
                where id = object_id('cr_situacion_inversiones')
                  and name = 'si_rol')
begin
   alter table cr_situacion_inversiones add si_rol char(1) null   
end

if not exists (select 1 from syscolumns  
                where id = object_id('cr_situacion_inversiones')
                  and name = 'si_bloqueos')
begin
   alter table cr_situacion_inversiones add si_bloqueos money null
end

if not exists (select 1 from syscolumns  
                where id = object_id('cr_situacion_deudas')
                  and name = 'sd_rol')
begin
   alter table cr_situacion_deudas add sd_rol char(1) null
end

if not exists (select 1 from syscolumns  
                where id = object_id('cr_situacion_gar')
                  and name = 'sg_custodia')
begin
   alter table cr_situacion_gar add sg_custodia int null
end

if exists (select 1 from syscolumns  
                where id = object_id('cr_situacion_gar')
                  and name = 'sg_tipo_gar')
begin
   alter table cr_situacion_gar modify sg_tipo_gar varchar(15) null
end
go
