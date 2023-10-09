use cobis
go

declare 
@w_producto           int,
@w_tn_trn_code        int,
@w_pd_procedure       int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_descripcion = 'CLIENTES' -- Obtiene el codigo del producto

select 
@w_tn_trn_code = 21744, -- Se inicializa el codigo de la transacción
@w_pd_procedure  = 21744

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ADMINISTRADOR',
'FUNCIONARIO OFICINA',
'ASESOR',
'MESA DE OPERACIONES'
)

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values(@w_tn_trn_code, 'OBTENER CATALOGO REGISTROS VIGENTES', convert(char(6), @w_tn_trn_code), 'OBTENER CATALOGO REGISTROS VIGENTES')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure
insert into cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(@w_pd_procedure, 'sp_obtener_catalogo', 'cob_credito', 'V', getdate(), 'sp_obt_cat.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
insert into cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code
insert into cobis..ad_tr_autorizada
select @w_producto, 'R', 0, @w_tn_trn_code, rol, getdate(), 1, 'V', getdate()
from @w_roles

go
