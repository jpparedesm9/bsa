/********************************************************************/
/* Fecha:   05-MAR-2015                                             */
/* Objeto:  Script de autorizacion de transacciones a roles COBIS   */
/* Modulo:  COBIS - ADMIN                                        */
/********************************************************************/
use cobis
GO

declare @w_rol int, @w_producto int, @w_moneda int

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = 1

if @@rowcount <> 1
begin
   print 'ERROR: *** No se encontro definido rol para autorizar transacciones ***'
end

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'
if @@rowcount <> 1
begin
   print 'ERROR: *** No se encontro definido producto COBIS para autorizar transacciones ***'
end

--INSERT DE LA TRANSACCION AUTORIZADA
delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.CatalogManagement.Search' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.CatalogManagement.Search', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.ReadOffice' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.OfficeManagement.ReadOffice', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficerManagement.ReadOfficer' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.OfficerManagement.ReadOfficer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.ParameterManagement.ParameterManagement' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.ParameterManagement.ParameterManagement', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficerManagement.SearchOfficer' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.OfficerManagement.SearchOfficer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.SearchCity' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.OfficeManagement.SearchCity', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.BranchManagement.ReadBranch' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.BranchManagement.ReadBranch', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

delete from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.ParameterManagement.ProcessDate' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.ParameterManagement.ProcessDate', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )

delete from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference' and ts_rol = @w_rol and ts_producto = @w_producto
insert into ad_servicio_autorizado values('SystemConfiguration.OfficeManagement.SearchOfficeGeoreference', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )

go
