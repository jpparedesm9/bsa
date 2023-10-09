print 'cl_producto'
go

delete cobis..cl_producto
where pd_abreviatura = 'PER'
go

insert into cobis..cl_producto
(pd_producto, pd_tipo, pd_descripcion, pd_abreviatura,
 pd_fecha_apertura, pd_estado,pd_saldo_minimo,pd_costo)
values
(17,'R','PERSONALIZACION','PER',getdate(),'V',$0,$0)
go

declare @w_moneda tinyint,
        @w_rol    tinyint,
        @w_rolp   tinyint
        
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
and pa_producto = 'ADM'

if exists (select * from cl_pro_moneda where pm_producto = 17)
           delete cl_pro_moneda where pm_producto = 17

insert into cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion,
                           pm_fecha_aper, pm_estado)
                values (17, 'R',@w_moneda , 'PERSONALIZACION', getdate(), 'V')

select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'ADMINISTRADOR'

select @w_rolp = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS'


delete cobis..ad_pro_rol
where pr_rol in (@w_rol, @w_rolp)
and pr_producto = 17
and pr_tipo = 'R'
and pr_moneda = @w_moneda


insert into ad_pro_rol
    (pr_rol, pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante,
 pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
 values (@w_rol,17,'R',@w_moneda,getdate(),1,'V',getdate(),null)

insert into ad_pro_rol
(pr_rol, pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante,
 pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
 values
(@w_rolp,17,'R',@w_moneda,getdate(),1,'V',getdate(),null)

update cobis..cl_seqnos
set siguiente = (select max(pd_producto) from cobis..cl_producto)
where tabla = 'cl_producto'

go


