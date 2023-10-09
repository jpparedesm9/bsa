Use cob_conta
go

declare @w_empresa	int,
		@w_fecha	datetime

if exists (select 1 from cob_conta..sysobjects where name = 'cb_oficina')
begin
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_conta..cb_oficina where of_empresa = @w_empresa
    insert into cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado,of_organizacion, of_consolida, of_movimiento, of_codigo) values (@w_empresa,255,'SOFOM SANTANDER'   ,null,'V',@w_fecha,1,'S','N',' ')
   --DIVISIONES 
	insert into cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado,of_organizacion, of_consolida, of_movimiento, of_codigo) values (@w_empresa,1000,'DIVISIONAL METRO'  ,255,'V',@w_fecha,2,'S','N',' ')
	insert into cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado,of_organizacion, of_consolida, of_movimiento, of_codigo) values (@w_empresa,9000,'CENTRALIZADORA'    ,255,'V',@w_fecha,2,'S','N',' ')
   --REGIONALES
    insert into cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado,of_organizacion, of_consolida, of_movimiento, of_codigo) values (@w_empresa,1100,'REGIONAL TOLUCA'  ,1000,'V',@w_fecha,3,'S','N',' ')
	insert into cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado,of_organizacion, of_consolida, of_movimiento, of_codigo) values (@w_empresa,1200,'REGIONAL CHALCO'  ,1000,'V',@w_fecha,3,'S','N',' ')
    insert into cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado,of_organizacion, of_consolida, of_movimiento, of_codigo) values (@w_empresa,9100,'REGIONAL COLECTIVO',9000,'V',@w_fecha,3,'S','N',' ')
   
   --OFICINAS
    insert into cob_conta..cb_oficina (
	of_empresa      ,   of_oficina,      of_descripcion, 
	of_oficina_padre,   of_estado,       of_fecha_estado,
	of_organizacion ,   of_consolida,    of_movimiento, 
	of_codigo)  
	select 
	@w_empresa ,        of_oficina,      UPPER(of_nombre),
	of_regional,        'V',             @w_fecha,
	4          ,        'N'         ,   'S',
	' '
	from cobis..cl_oficina
	where of_subtipo = 'O'
		
end
else
	print 'NO EXISTE TABLA cb_oficina'
go

declare @w_empresa	int, @w_oficina int, @w_organizacion int, @w_oficina_jerarquia int
          
--cb_jerarquia
if exists (select 1 from cob_conta..sysobjects where name = 'cb_jerarquia')
begin	
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
		
	delete from cob_conta..cb_jerarquia where je_empresa = @w_empresa
    --insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre,je_nivel) values (@w_empresa,0,     null, 'V',@w_fecha,1,'S','N',' ')
    

    select @w_oficina = 0
    
    select top 1 @w_oficina = of_oficina 
    from cb_oficina
    where of_oficina > @w_oficina
    and of_movimiento = 'S'
    order by of_oficina
    
    while @@rowcount > 0
    begin

       select 
       @w_oficina_jerarquia = of_oficina,
       @w_organizacion      = of_organizacion
       from cb_oficina
       where of_oficina = @w_oficina
       
       while @@rowcount > 0
       begin
	     insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre,je_nivel) values (@w_empresa,@w_oficina,@w_oficina_jerarquia,@w_organizacion)
       
         select @w_organizacion = @w_organizacion -1
		 
		 select @w_oficina_jerarquia = of_oficina_padre
         from cob_conta..cb_oficina
         where of_oficina = @w_oficina_jerarquia
		 and of_oficina_padre is not null
		 
       end
       
       select top 1 @w_oficina = of_oficina 
       from cb_oficina
       where of_oficina > @w_oficina
       and of_movimiento = 'S'
       order by of_oficina

   end
                                                                                                                  
end
else
	print 'NO EXISTE TABLA cb_oficina'
go