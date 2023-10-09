use cob_cartera
go
if exists ( select 1 from ca_tipo_trn where tt_codigo = 'DSC')
   delete from ca_tipo_trn where tt_codigo = 'DSC'
go

insert into ca_tipo_trn values('DSC', 'DESCUENTO DE TASA', 'N','S')

if exists ( select 1 from cob_cartera..ca_trn_oper where to_tipo_trn = 'DSC')
   delete cob_cartera..ca_trn_oper where to_tipo_trn = 'DSC'
go
select * into #ca_trn_oper from ca_trn_oper where to_toperacion in ( 'GRUPAL','INDIVIDUAL','INTERCICLO','REVOLVENTE')
and to_tipo_trn = 'RPA'

update #ca_trn_oper set 
to_tipo_trn = 'DSC',
to_perfil	= 'CCA_DSC'

insert into ca_trn_oper select * from #ca_trn_oper
go   

use cob_conta
go
if exists(select * from cb_det_perfil where dp_perfil = 'CCA_DSC')
begin
	delete from cb_det_perfil where dp_perfil = 'CCA_DSC'
end

if exists(select * from cb_perfil where pe_perfil = 'CCA_DSC')
begin
	delete from cb_perfil where pe_perfil = 'CCA_DSC'
end
go

insert into cb_perfil values(1,7,'CCA_DSC','DESCUENTO DE TASA')

insert into cb_det_perfil values(1,7,'CCA_DSC',1,'11020203','CTB_OF','1',131,'N','D',null,'L')
insert into cb_det_perfil values(1,7,'CCA_DSC',2,'510511900201','CTB_OF','2',11010,'N','D',null,'L')
insert into cb_det_perfil values(1,7,'CCA_DSC',3,'24010702','CTB_OF','2',12010,'N','D',null,'L')

go
