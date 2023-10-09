use cobis
go

declare 
@w_of_regional     int,
@w_of_avon         int, 
@w_of_independiente int 

select 
@w_of_regional       = 9100,
@w_of_avon           = 9101,
@w_of_independiente  = 9102




--actualizado en instalador cl_parametros.sql
if exists ( select 1 from cobis..cl_parametro where pa_nemonico in ('VENMIN','VENMAX')) 
   delete cobis..cl_parametro where pa_nemonico in ('VENMIN','VENMAX')


delete cobis..cl_oficina     where of_oficina = @w_of_regional 
delete cob_conta..cb_oficina where of_oficina = @w_of_regional 




---REL OFI --se actualiza dinamicamenete en el instalador src/be/activas/cartera/installer/sql/Param_Conta_MX/cb_relofi.sql

delete  cob_conta..cb_relofi  where re_ofadmin in ( @w_of_regional, @w_of_avon,@w_of_independiente) 



--jerarquia --se actualiza dinamicameen src/be/activas/cartera/installer/sql/Param_Conta_MX/cb_oficina.sql

delete cob_conta..cb_jerarquia where je_oficina in ( @w_of_avon,@w_of_independiente)





use cob_cartera 
go 

--ACTUALIZADO EN src/be/activas/cartera/installer/sql/ca_table.sql
if object_id ('dbo.ca_qry_asesor_colectivo') is not null
	drop table dbo.ca_qry_asesor_colectivo
go


if object_id ('dbo.ca_asesor_colectivo') is not null
	drop table dbo.ca_asesor_colectivo
go



--se actualiza en src/be/activas/cartera/installer/sql/ca_parametros.sql
delete cobis..cl_parametro  where pa_nemonico = 'ESASEX'

go



