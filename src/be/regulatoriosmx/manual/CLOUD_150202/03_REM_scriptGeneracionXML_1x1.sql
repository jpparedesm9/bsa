use cob_conta_super
go

declare @w_orden int, @w_fecha datetime, @w_error int

----------C:\WorkFolder\'ReFacturacionGenXML\------
print 'Inicia generacion' + convert(varchar(30),getdate())

--04_REM_scriptEjecucion_ingreso_info.sql, se llena la tabla fecha_gen_xml_refacturacion
select t_orden = orden,
       t_fecha = fecha,
	   t_ingreso = ingreso,
	   t_generacion = generacion
into #fecha_gen_xml_refacturacion
from fecha_gen_xml_refacturacion
--where orden in (1)
--where orden in (2)
--where orden in (3)
--where orden in (4)
--where orden in (5)
--where orden in (5)
--where orden in (6)
--where orden in (7)
--where orden in (8)
--where orden in (9)
--where orden in (10)
--where orden in (11)
--where orden in (12)
--where orden in (1,2,3,4,5,6,7,8,9,10,11,12)

update #fecha_gen_xml_refacturacion
set t_generacion = 'N'

--------------------------------GENERACION DE ARCHIVO
select @w_orden = 0
while exists (select 1 from #fecha_gen_xml_refacturacion where t_orden > @w_orden and t_generacion = 'N')
begin       
    select TOP 1 @w_fecha = t_fecha,
	             @w_orden = t_orden
      from #fecha_gen_xml_refacturacion
     where t_orden > @w_orden
    
    print 'Inicio proceso externo para generar xml para fecha: ' + convert(varchar(30), @w_fecha)
	
	exec @w_error = sp_gen_xml_refacturacion
         @i_param1 = @w_fecha

    update #fecha_gen_xml_refacturacion 
	   set t_generacion = 'S'
	 where t_orden = @w_orden
	 
    print 'Fin proceso externo para generar xml para fecha: ' + convert(varchar(30), @w_fecha)	 
end

update fecha_gen_xml_refacturacion
   set generacion = t_generacion
  from #fecha_gen_xml_refacturacion
 where orden = t_orden

drop table #fecha_gen_xml_refacturacion
print 'Fin generacion' + convert(varchar(30),getdate())

go
