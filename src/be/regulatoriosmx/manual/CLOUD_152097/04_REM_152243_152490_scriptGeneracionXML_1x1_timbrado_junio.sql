use cob_conta_super
go

declare @w_orden int, @w_fecha datetime, @w_error int

----------C:\WorkFolder\'ReFacturacionGenXML\------
----4horas
print 'Inicia generacion' + convert(varchar(30),getdate())

--04_REM_scriptEjecucion_ingreso_info.sql, se llena la tabla sb_fecha_gen_xml_refacturacion
select t_orden = orden,
       t_fecha = fecha,
	   t_ingreso = ingreso,
	   t_generacion = generacion
into #sb_fecha_gen_xml_refacturacion
from sb_fecha_gen_xml_refacturacion
where orden = 1 -- junio

--insert into sb_fecha_gen_xml_refacturacion values (1,'06/15/2019','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (2,'07/15/2019','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (3,'08/15/2019','N','N')

update #sb_fecha_gen_xml_refacturacion
set t_generacion = 'N'

/*Si se quiere procesar todos otra vez
update sb_info_gen_xml_refacturacion
   set procesado = 'N',
       nombre_archivo = ''
 where timbrado = 'S'
*/

--------------------------------GENERACION DE ARCHIVO
select @w_orden = 0
while exists (select 1 from #sb_fecha_gen_xml_refacturacion where t_orden > @w_orden and t_generacion = 'N')
begin       
    select TOP 1 @w_fecha = t_fecha,
	             @w_orden = t_orden
      from #sb_fecha_gen_xml_refacturacion
     where t_orden > @w_orden
    
    print 'Inicio proceso externo para generar xml para fecha: ' + convert(varchar(30), @w_fecha)
	
	exec @w_error = sp_gen_xml_refacturacion_timbrado
         @i_param1 = @w_fecha

    update #sb_fecha_gen_xml_refacturacion 
	   set t_generacion = 'S'
	 where t_orden = @w_orden
	 
    print 'Fin proceso externo para generar xml para fecha: ' + convert(varchar(30), @w_fecha)	 
end

update sb_fecha_gen_xml_refacturacion
   set generacion = t_generacion
  from #sb_fecha_gen_xml_refacturacion
 where orden = t_orden

drop table #sb_fecha_gen_xml_refacturacion
print 'Fin generacion' + convert(varchar(30),getdate())

go
