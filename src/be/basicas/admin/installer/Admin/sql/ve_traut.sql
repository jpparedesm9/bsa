/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      12/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/
use cobis
go

/******************************************************************/
/* 	CREACION DE ROL ADMINISTRADOR DE VERSIONES                */
/******************************************************************/
print '*** ad_rol .....(Creacion de rol ADMINISTRADOR DE VERSIONES)'
go

declare @w_rol  smallint
if NOT EXISTS (select * from ad_rol where 
	       ro_descripcion = 'ADMINISTRADOR DE VERSIONES'
		and ro_filial = 1)
begin
	select @w_rol = max(ro_rol) + 1
	from ad_rol
	where ro_filial = 1

	update cl_seqnos
	set siguiente = @w_rol
	where tabla = 'ad_rol'

	insert into ad_rol
	(ro_rol,ro_filial,ro_descripcion,ro_fecha_crea,ro_creador,
	ro_estado,ro_fecha_ult_mod,ro_time_out)
	values 	(@w_rol,1,'ADMINISTRADOR DE VERSIONES',getdate(),1,'V',getdate(),600)
end
else begin
	print 'YA EXISTE EL ROL ADMINISTRADOR DE VERSIONES'
end
go


/* Transacciones autorizadas para el Modulo de Reportes 
   a Entidades de Control */

print '----->  ad_tr_autorizada'
go

declare @w_rol  smallint
select @w_rol = ro_rol  from ad_rol where
               ro_descripcion = 'ADMINISTRADOR DE VERSIONES'
                and ro_filial = 1

delete ad_tr_autorizada where ta_rol = @w_rol

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'

/* Transacciones otros modulos Cobis */
insert into ad_tr_autorizada values(1,'R',@w_moneda,78,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,501,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,502,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,503,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,504,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,568,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,584,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,585,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1502,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1504,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1556,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1560,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1561,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1562,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1564,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1571,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1574,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1577,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1578,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1579,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,1599,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,15222,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,15037,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,15098,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,15103,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,15031,@w_rol,getdate(),1,'V',getdate())
/* CONTROL DE VERSIONES */
insert into ad_tr_autorizada values(1,'R',@w_moneda,28741,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,28742,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,28743,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,28744,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,28745,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,28746,@w_rol,getdate(),1,'V',getdate())

insert into ad_tr_autorizada values(1,'R',@w_moneda,150000,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150001,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150002,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150003,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150004,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150005,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150006,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150007,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150008,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150009,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150010,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150011,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150012,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150013,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150014,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150015,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(1,'R',@w_moneda,150016,@w_rol,getdate(),1,'V',getdate())
go
