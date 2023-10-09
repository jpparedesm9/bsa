--ASESOR ACTUAL: Uriel Calixto Velasco Ruiz (ucvelasco) -- 122
--ASESOR PARA REASIGNAR: Fidel Antonio Coria, (facoria)  --179
--7583 ARACELI MALDONADO ESPINOZA
--14104 GLORIA ESTHER ESPINOZA OLIVARES
--
--ASESOR ACTUAL: asesor Arturo Arcos Flores (arcosfl) --157
--ASESOR PARA REASIGNAR: Jose Gustavo Huescas (jghuescas) --301
--25050 CRISTINA CORTES ARGUELLES

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

create table #prospectos(ente int, funcionario int)

insert into #prospectos values (7583, 122),(14104, 122),(25050, 157)


   
select @w_ente = 0

while exists (select 1 from #prospectos where ente > @w_ente)
begin
    select top 1 
	@w_ente             = ente,
	@w_funcionario_dest = funcionario
	from #prospectos
	where ente > @w_ente
	order by ente
	
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

