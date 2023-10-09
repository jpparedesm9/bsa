/*BUEN DIA

SOLICITAMOS DE SU APOYO PARA LAS SIGUIENTES REASIGNACIONES:

ASESOR ASIGNADO: DULCE SELENE JERÓNIMO VILLA USUARIO: dsjeronimo 194	DULCE SELENE JERONIMO VILLA	F	N	47051	2	3346	3	6	238	1	Jun 11 2018 12:00AM	dsjeronimo


ASESOR A REASIGNAR: GUADALUPE SUSANA ROSALES PEREZ USUARIO: gsrosales 171	GUADALUPE SUSANA ROSALES PEREZ	F	N	45791	2	3346	3	1	170	0	Jun 5 2018 12:00AM	gsrosales		Oct 5 2018 10:11AM			V	0x84d956da750f31171ec48a9dbf2e06a2	ROPG800811PI0		Jun 5 2018 12:00AM


PROSPECTO:

30643 - PAULA OSORIO ZAMORA

ASESOR ASIGNADO: ADOLFO ANGEL LOPEZ GOMEZ USUARIO: aalopezg  190

ASESOR A REASIGNAR: GUADALUPE SUSANA ROSALES PEREZ USUARIO: gsrosales

PROSPECTO:

19318 - BLANCA ESTHER BRAVO RODRIGUEZ
18507 - JUANA RAMIREZ VIVEROS




*/

USE cobis 
go

declare 
@w_oficial_ant       login,
@w_oficial_dest      login,
@w_commit            char(1),
@w_login_dest        login,
@w_oficina_dest      int,
@w_msg               varchar(255),
@w_funcionario_dest  int

select @w_funcionario_dest =  171


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
where  en_ente in (30643,19318,18507)


ERROR:
print @w_msg

go