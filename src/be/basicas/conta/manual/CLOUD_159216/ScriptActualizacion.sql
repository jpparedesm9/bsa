use cobis
go

select * from an_role_module where rm_mo_id = 45 and rm_rol = 10

if not exists(select 1 from an_role_module where rm_mo_id = 45 and rm_rol = 10)
begin
    insert into dbo.an_role_module (rm_mo_id, rm_rol)
    values (45, 10)
end

select * from an_role_module where rm_mo_id = 45 and rm_rol = 10