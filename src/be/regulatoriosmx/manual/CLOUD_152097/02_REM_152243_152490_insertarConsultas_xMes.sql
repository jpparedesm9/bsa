use cob_conta_super
go

print 'INicio insertar en base a la consulta:' + convert(varchar(30),getdate())
--Alrededeor de 1 minuto

select 'sb_info_gen_xml_refacturacion' = count(*) from sb_info_gen_xml_refacturacion
select 'sb_fecha_gen_xml_refacturacion' = count(*) from sb_fecha_gen_xml_refacturacion
select 'gen_xml_refacturacion' = count(*) from sb_gen_xml_refacturacion

truncate table sb_info_gen_xml_refacturacion
truncate table sb_fecha_gen_xml_refacturacion
truncate table sb_gen_xml_refacturacion

-- mm/dd/aaaa
--insert into sb_fecha_gen_xml_refacturacion values (1,'05/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (2,'06/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (3,'07/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (4,'08/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (5,'09/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (6,'10/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (7,'11/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (8,'12/15/2018','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (9,'01/15/2019','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (10,'02/15/2019','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (11,'03/15/2019','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (12,'04/15/2019','N','N')
--insert into sb_fecha_gen_xml_refacturacion values (13,'05/15/2019','N','N')
insert into sb_fecha_gen_xml_refacturacion values (1,'06/15/2019','N','N')
insert into sb_fecha_gen_xml_refacturacion values (2,'07/15/2019','N','N')
insert into sb_fecha_gen_xml_refacturacion values (3,'08/15/2019','N','N')
--

declare @w_orden int, @w_fecha datetime

select @w_orden = 0

while exists (select 1 from sb_fecha_gen_xml_refacturacion where orden > @w_orden and ingreso = 'N')
begin       
    select TOP 1 @w_fecha = fecha,
	       @w_orden = orden
      from sb_fecha_gen_xml_refacturacion
     where orden > @w_orden

    print 'Inicio proceso externo para ingresar la data para fecha: ' + convert(varchar(30), @w_fecha)
	
	exec sp_ing_info_gen_xml_refacturacion_timbrado
         @i_param1 = @w_fecha

    update sb_fecha_gen_xml_refacturacion 
	   set ingreso = 'S'
	 where orden = @w_orden
	 
    print 'Fin proceso externo para ingresar la data para fecha: ' + convert(varchar(30), @w_fecha)	 
end
print 'fin insertar en base a la consulta:' + convert(varchar(30),getdate())
go
