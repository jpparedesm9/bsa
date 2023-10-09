use cobis
go
delete from cobis..ns_template where te_id=17 and te_nombre  = 'NotificacionDescuento.xslt'
go

insert into cobis..ns_template values(17,'XSLT','NEUTRAL','NotificacionDescuento.xslt','A','1.0.0.0')
go

declare @w_tabla int

select @w_tabla = codigo from cobis..cl_tabla where tabla ='ca_param_notif'

delete from cobis..cl_catalogo where tabla = @w_tabla and codigo in ('NPDT_NJAS','NPDT_NPDF','NPDT_NXML')
delete from cobis..cl_catalogo where tabla = @w_tabla and codigo in ('NPDTD_NJAS','NPDTD_NPDF','NPDTD_NXML')

insert into cobis..cl_catalogo values(@w_tabla, 'NPDTD_NJAS','DiscountNotification.jasper','V',NULL,NULL,NULL)
insert into cobis..cl_catalogo values(@w_tabla, 'NPDTD_NPDF','DiscountNotification_','V',NULL,NULL,NULL)
insert into cobis..cl_catalogo values(@w_tabla, 'NPDTD_NXML','DiscountNotification.xml','V',NULL,NULL,NULL)
go