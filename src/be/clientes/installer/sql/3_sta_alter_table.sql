use cobis
go


--cc_oficial
--oc_nivel
if not exists(select 1
          from cobis..sysobjects obj, cobis..syscolumns col
          where obj.name = 'cc_oficial'
          and   obj.id = col.id
          and   col.name = 'oc_nivel')
begin
alter table cobis..cc_oficial
   add oc_nivel char(10) null
end
go


--oc_categoria
if not exists(select 1
          from cobis..sysobjects obj, cobis..syscolumns col
          where obj.name = 'cc_oficial'
          and   obj.id = col.id
          and   col.name = 'oc_categoria')
begin
alter table cobis..cc_oficial
   add oc_categoria char(10) null
end
go


--oc_mail
if not exists(select 1
          from cobis..sysobjects obj, cobis..syscolumns col
          where obj.name = 'cc_oficial'
          and   obj.id = col.id
          and   col.name = 'oc_mail')
begin
alter table cobis..cc_oficial
   add oc_mail varchar(254) null
end
go

print 'Creando campo ea_estado_std en cl_ente_aux'
go
if not exists (select 1 from syscolumns  
                where id = object_id('cl_ente_aux')
                  and name = 'ea_estado_std')
begin
   alter table cl_ente_aux
     add ea_estado_std varchar(10) null
end
go







