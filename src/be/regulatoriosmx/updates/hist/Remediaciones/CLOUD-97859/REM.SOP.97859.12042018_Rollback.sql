/*************************************************************************************/
--No Historia                : SOP-97859
--Titulo de la Historia      : CAMBIO DE ASESOR
--Fecha                      : 12/04/2018
--Descripcion del Problema   : CAMBIO DE ASESOR
--Descripcion de la Solucion : Actualizacion de asesor del grupo 17 (Rollback)
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
declare @w_oficial     int,
        @w_oficial_old int,
        @w_login       varchar(14),
        @w_login_old   varchar(14),
        @w_grupo       int

select @w_login     = 'emoraleslu',
       @w_login_old = 'mahernandezso',
       @w_grupo     = 17

select @w_oficial = fu_funcionario
from cobis..cl_funcionario
where fu_login = @w_login

select @w_oficial_old = fu_funcionario
from cobis..cl_funcionario
where fu_login = @w_login_old


select 'Oficial'          = @w_oficial,
       'Login'            = @w_login,
       'Oficial Anterior' = @w_oficial_old,
       'Login Anterior'   = @w_login_old

print'Informacion Actual Grupo ' + cast(@w_grupo as varchar)
select en_oficial, c_funcionario, *
from cobis..cl_ente 
where en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   en_oficial = @w_oficial_old

select gr_oficial, *
from cobis..cl_grupo
where gr_grupo   = @w_grupo
and   gr_oficial = @w_oficial_old

select cg_usuario, *
from cobis..cl_cliente_grupo
where cg_grupo   = @w_grupo
and   cg_usuario = @w_login_old

select tr_oficial, tr_usuario, tr_usuario_apr, *
from cob_credito..cr_tramite
where tr_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   tr_oficial = @w_oficial_old

select op_oficial, *
from cob_cartera..ca_operacion
where op_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   op_oficial = @w_oficial_old

print'Actualizacion Informacion Grupo ' + cast(@w_grupo as varchar)
update cobis..cl_ente set
en_oficial    = @w_oficial,
c_funcionario = @w_login
where en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   en_oficial = @w_oficial_old

update cobis..cl_grupo set gr_oficial = @w_oficial
where gr_grupo   = @w_grupo
and   gr_oficial = @w_oficial_old

update cobis..cl_cliente_grupo set cg_usuario = @w_login
where cg_grupo   = @w_grupo
and   cg_usuario = @w_login_old

update cob_credito..cr_tramite set
tr_oficial     = @w_oficial,
tr_usuario     = @w_login,
tr_usuario_apr = @w_login
where tr_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   tr_oficial = @w_oficial_old

update cob_cartera..ca_operacion set op_oficial = @w_oficial
where op_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   op_oficial = @w_oficial_old

print'Informacion Actualizada Grupo ' + cast(@w_grupo as varchar)
select en_oficial, c_funcionario, *
from cobis..cl_ente 
where en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   en_oficial = @w_oficial

select gr_oficial, *
from cobis..cl_grupo
where gr_grupo   = @w_grupo
and   gr_oficial = @w_oficial

select cg_usuario, *
from cobis..cl_cliente_grupo
where cg_grupo   = @w_grupo
and   cg_usuario = @w_login

select tr_oficial, tr_usuario, tr_usuario_apr, *
from cob_credito..cr_tramite
where tr_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   tr_oficial = @w_oficial

select op_oficial, *
from cob_cartera..ca_operacion
where op_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
and   op_oficial = @w_oficial
go

