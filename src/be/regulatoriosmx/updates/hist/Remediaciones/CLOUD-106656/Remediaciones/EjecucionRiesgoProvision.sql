use cob_conta_super
go


exec sp_riesgo_provision @i_param1 = '08/01/2018' -- 31 Julio 
select Ciclos ,* from sb_riesgo_provision where Num_cliente  in( '45468839', '44809621','42776589')
go

exec sp_riesgo_provision @i_param1 = '09/01/2018' -- 31 Agosto 
select Ciclos, * from sb_riesgo_provision where Num_cliente  in( '45468839', '44809621','42776589')
go


