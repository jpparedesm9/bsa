
USE cobis
GO




declare @w_codigo int , @w_usuario_onboard int 

select @w_codigo = siguiente from cobis..cl_seqnos
where tabla = 'cl_funcionario' and bdatos = 'cobis'


select @w_usuario_onboard = fu_funcionario 
from cobis..cl_funcionario 
where fu_login = 'onboarding'

if  @w_usuario_onboard is not null begin 

   delete  cobis..cc_oficial where oc_funcionario =  @w_usuario_onboard
   delete from cobis..cl_funcionario where fu_funcionario =  @w_usuario_onboard


end 




INSERT INTO [cobis].[dbo].[cl_funcionario](
[fu_funcionario], [fu_nombre],              [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'USUARIO ONBOARDING', 'M',        'N',                 2,                 9001,          11,          1,               1, getdate(), 'onboarding', getdate(), getdate(), 'V', 'PALE790910', getdate())



update cobis..cl_seqnos set siguiente = (select isnull(max(fu_funcionario),0) from cobis..cl_funcionario) + 1 where tabla = 'cl_funcionario' and bdatos = 'cobis'
GO
---



update cobis..cl_funcionario set fu_offset =	0xFCFD2ABA19A088BBA7624E1845B89A6A	where fu_login = 'onboarding'


insert into cobis..cc_oficial
select distinct fu_funcionario, fu_funcionario, 'P',null,3,null,1,null,null,null from cobis..cl_funcionario
where fu_login in ('onboarding')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('ambarranco'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('onboarding')

go