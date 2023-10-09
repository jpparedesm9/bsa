--CLIENTE: REYNA CORTES GREGORIO 
--ID: 10944
--ASESOR QUE APARECE EN SISTEMA: ABDALI MONSERRAT AGUIRRE MONTIEL.  --> 169
--ASESOR PARA REASIGNAR: ELENA BERENICE RENDON "EBRENDON".  --> 151

USE cobis 
go

declare 
@w_oficial_ant       login,
@w_oficial_dest      login,
@w_commit            char(1),
@w_login_dest        login,
@w_oficina_dest      int,
@w_msg               varchar(255),
@w_funcionario_dest  int,
@w_ente              int

select @w_funcionario_dest =  169

create table #prospectos(ente int)

insert into #prospectos values (10944)

select 
@w_login_dest   = fu_login, 
@w_oficina_dest = fu_oficina
from cobis..cl_funcionario
where fu_funcionario = @w_funcionario_dest

if @@rowcount = 0 begin
select @w_msg = 'ERROR: FUNCIONARIO '+CONVERT(varchar, isnull(@w_funcionario_dest,'n/a')) + ' NO EXISTE'
   goto ERROR
end
   
select @w_oficial_dest = oc_oficial
from cobis..cc_oficial
where oc_funcionario = @w_funcionario_dest

if @@rowcount = 0 begin 
select @w_msg = 'ERROR: OFICIAL '+CONVERT(varchar, isnull(@w_oficial_dest, 'n/a')) + ' NO EXISTE'
   goto ERROR   
end 
   
select @w_ente = 0

while exists (select 1 from #prospectos where ente > @w_ente)
begin
    select top 1 @w_ente = ente
	from #prospectos
	where ente > @w_ente
	order by ente
  
    update cobis..cl_ente set
    en_oficial     = @w_oficial_dest,
    c_funcionario  = @w_login_dest,
    en_oficina     = @w_oficina_dest
    where  en_ente = @w_ente
    
end

ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
    select @w_commit = 'N'
    rollback tran 
end

drop table #prospectos
go

