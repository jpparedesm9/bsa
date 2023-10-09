---------------------------
--CORRECCION DE SERVICIOS
---------------------------

use cobis
go

--Copia de Respaldo
IF NOT EXISTS (SELECT  1 FROM ServicioTmp)
   SELECT * INTO ServicioTmp
   FROM ad_servicio_autorizado

select count(*) from ad_servicio_autorizado

declare @w_rol      int,  
        @w_rol_menu INT


select @w_rol_menu = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

--ROL 1
PRINT ('ROL 1')
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='ADMINISTRADOR'
if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL1'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END

--ROL 2
PRINT ('ROL 2')
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='OPERADOR DE BATCH COBIS'

if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL 2'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END
  
--ROL 10
PRINT ('ROL 10')
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='FUNCIONARIO OFICINA'

if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL 10'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END

--ROL 11
PRINT ('ROL 11')
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='CONSULTA'

if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL 11'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END

--ROL 12
PRINT ('ROL 12')
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='ASESOR'

if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL 12'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END
  
--ROL 13
PRINT ('ROL 13') 
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='OPERADOR SOFOME'

if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL 13'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END
 
--ROL 14
PRINT ('ROL 14')
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='ASESOR MOVIL'

if exists (select 1 from ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
           and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol ))
BEGIN
   select count(*) AS 'ROL 14'
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
   
   insert into ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod 
   from ad_servicio_autorizado t1 
   where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from ad_servicio_autorizado t2 where ts_rol = @w_rol )
END


select count(*) from ad_servicio_autorizado
select count (*) FROM ServicioTmp
GO



