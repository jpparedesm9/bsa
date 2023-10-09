use cob_cartera 
go

declare @w_operacionca int 

select @w_operacionca = op_operacion from ca_operacion where op_banco = '233510035170'


--respaldo
select * into ca_operacion_233510035170    from ca_operacion where 1= 2 
select * into ca_dividendo_233510035170    from ca_dividendo where 1= 2
select * into ca_amortizacion_233510035170 from ca_amortizacion where 1= 2

insert into ca_operacion_233510035170
select * from cob_cartera..ca_operacion     where op_operacion = @w_operacionca

insert into ca_dividendo_233510035170
select * from cob_cartera..ca_dividendo   where di_operacion = @w_operacionca

insert into ca_amortizacion_233510035170
select * from cob_cartera..ca_amortizacion    where am_operacion = @w_operacionca

--borrado
delete cob_cartera..ca_operacion    where op_operacion in(@w_operacionca ,-1*@w_operacionca)
delete cob_cartera..ca_dividendo    where di_operacion in(@w_operacionca ,-1*@w_operacionca)
delete cob_cartera..ca_amortizacion where am_operacion in(@w_operacionca ,-1*@w_operacionca)
                                                       
go 
