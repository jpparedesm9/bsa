use cobis
go

declare @w_horas int,
        @w_fecha datetime


select @w_horas = 1

select @w_fecha = DATEADD(HH, -(@w_horas), GETDATE())

select @w_fecha


 
SELECT COUNT(1) as 'CORREOS EN PROCESO TIPO SMTP'
FROM cobis..ns_notificaciones_despacho
WHERE nd_tipo = 'MAIL'
AND nd_estado = 'R'
and nd_fecha_mod > @w_fecha

UPDATE cobis..ns_notificaciones_despacho
SET nd_estado = 'P',
	nd_tries = 0
WHERE nd_tipo = 'MAIL'
AND nd_estado = 'R'
and nd_fecha_mod > @w_fecha


SELECT COUNT(1)  'CORREOS PENDIENTES TIPO SMTP'
FROM cobis..ns_notificaciones_despacho
WHERE nd_tipo = 'MAIL'
AND nd_estado = 'P'
and nd_fecha_mod > @w_fecha
