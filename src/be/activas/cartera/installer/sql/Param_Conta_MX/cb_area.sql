Use cob_conta
go
---ANSI
declare @w_empresa	int,
		@w_fecha 	datetime

if exists (select 1 from cob_conta..sysobjects where name = 'cb_area')
begin
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

	delete from cob_conta..cb_area where ar_empresa = @w_empresa

    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,255,'SOFOM SANTANDER',NULL,'V',@w_fecha,1,'S','N')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1010,'D EJECUTIVA',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1020,'OPERACIONES',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1030,'DESARROLLO PRODUCTOS Y SERVICIOS',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1040,'NORMATIVIDAD',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1060,'PLANEACIÓN FINANCIERA',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1050,'RIESGOS',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1070,'RECURSOS HUMANOS',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1080,'SISTEMAS',255,'V',@w_fecha,2,'N','S')
    INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento) VALUES (@w_empresa,1090,'COMERCIAL',255,'V',@w_fecha,2,'N','S')

end
else
	print 'NO EXISTE TABLA cb_area'
	

declare  @w_area int, @w_nivel_area int, @w_area_padre int
          
--cb_jerararea
if exists (select 1 from cob_conta..sysobjects where name = 'cb_jerararea')
begin	

	delete from cob_conta..cb_jerararea where ja_empresa = @w_empresa   

    select @w_area = 0
    
    select top 1 @w_area = ar_area 
    from cb_area
    where ar_area > @w_area
    and ar_movimiento = 'S'
    order by ar_area
    
    while @@rowcount > 0
    begin

       select 
       @w_area_padre = ar_area,
       @w_nivel_area = ar_nivel_area
       from cb_area
       where ar_area = @w_area
       
       while @@rowcount > 0
       begin
	     insert into cob_conta..cb_jerararea (ja_empresa, ja_area,ja_area_padre,ja_nivel) values (@w_empresa,@w_area,@w_area_padre,@w_nivel_area)
       
         select @w_nivel_area = @w_nivel_area -1
		 
		 select @w_area_padre = ar_area_padre
         from cb_area
         where ar_area = @w_area_padre
		 and ar_area_padre is not null
		 
       end
       
       select top 1 @w_area = ar_area 
       from cb_area
       where ar_area > @w_area
       and ar_movimiento = 'S'
       order by ar_area

    end
                                                                                                                  
end
else
	print 'NO EXISTE TABLA cb_oficina'
	

go
