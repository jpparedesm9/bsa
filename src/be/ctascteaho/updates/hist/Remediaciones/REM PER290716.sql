/***********************************************************************************************************/

---Fecha					: 29/07/2016 
--Descripción del Problema	: autorizacion sp sp_rango_fechas
--Descripción de la Solución: se crea script de remediación
--Autor						: Karen Meza
/***********************************************************************************************************/

------------------------------------------------------------------------
use cobis
go

declare @w_rol  int,
@w_moneda tinyint
select  @w_rol = ro_rol
  from  ad_rol
 where  ro_descripcion like 'MENU POR PROCESOS'
 

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'

-----pe_protran.sql--------
delete ad_pro_transaccion
where pt_producto = 10
and pt_transaccion =732
and pt_moneda=@w_moneda
and pt_tipo='R'

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(10,'R',@w_moneda,732,'V',getdate(),421)    
----------------pe_proc.sql-------
delete ad_procedure
where pd_procedure =421
insert into ad_procedure values(421,'sp_rango_fechas','cob_remesas','V',getdate(),'rangofechas.sp')


-----------------
--pe_traut.sql---------
delete ad_tr_autorizada
 where ta_producto = 10
  and ta_transaccion =732
  and ta_rol = @w_rol
  and ta_moneda=@w_moneda
   
insert into ad_tr_autorizada values(10,'R',@w_moneda,732, @w_rol,getdate(),1,'V',getdate())


----pe_tran.sql------
delete cl_ttransaccion
where tn_trn_code=732
insert into cl_ttransaccion values(732, 'CONSULTA DE RANGOS DE EDAD',    'CORE', 'CONSULTA DE RANGOS DE EDAD')

go




