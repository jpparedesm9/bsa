--ASESOR ACTUAL: ycramirez YOSHIO CESAR RAMIREZ PEXO  --242
--ASESOR PARA REASIGNAR: clopez CLAUDIA IVET LOPEZ NAVA --336
--
--44480 AMANDA AGUILAR TOLENTINO
--43974 TANIA GUADALUPE ESQUIVEL RODRIGUEZ 
--43387 GRISELDA GARCIA CARDENAS 
--43367 DORA OLIVIA GONZALEZ MARCOS 
--43372 GABRIELA LILIA MUÑOZ SALCEDO 
--43797 MARINA AGUILAR TOLENTINO 
--43377 HORTENCIA CAMACHO MONTAÑEZ.

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

select @w_funcionario_dest =  336

create table #prospectos(ente int)

insert into #prospectos values (44480),(43974),(43387),(43367),(43372),(43797),(43377)

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

