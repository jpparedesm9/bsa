
print 'Inicio generar archivos:' + convert(VARCHAR(30),getdate())

/*Ejecutar proceso de timbrado para los que no fueron timbrados*/
DECLARE @w_fecha DATETIME
select @w_fecha = getdate()
select @w_fecha

EXEC cob_conta_super..sp_xml_estado_cuenta
@i_param1 = @w_fecha

print 'Fin generar archivos' + convert(VARCHAR(30),getdate())

go
