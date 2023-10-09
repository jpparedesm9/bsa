use cobis
go
print 'Inicio script 02 codMunicipiosNuevos:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
----
declare @w_secuencial       int,
        @w_estado           varchar(20),
        @w_municipio        varchar(20),
		@w_nombre_municipio varchar(255),
        @w_codigo_estado    int,
        @w_codigo_municipio int,
		@w_codigo_ciudad int,	
		@w_max_ciudad		int,
		@w_codigo_pais		int

create table #codigos_modificados(
secuencial       int           identity,
estado           varchar(20)   null,
municipio        varchar(20)   null,
nombre_municipio varchar(255)  null
)

insert into #codigos_modificados(       
	   estado   , municipio, nombre_municipio  )
select distinct cp_estado, cp_municipio, cp_nombre_municipio 	
from   cl_codigo_postal_tmp f
where  f.cp_codigo not in (select distinct e.cp_codigo 
                          from cl_codigo_postal_tmp d, cl_codigo_postal e
                          where d.cp_codigo = e.cp_codigo
                          and d.cp_estado = e.cp_estado_h
                          and d.cp_municipio = e.cp_municipio_h)
order by cp_estado, cp_municipio

select @w_secuencial = 0

select @w_codigo_pais = 484

while 1 = 1
begin
    select 
           @w_codigo_estado    = null,
           @w_codigo_municipio = null,    
           @w_estado           = null,
           @w_municipio        = null,
    	   @w_nombre_municipio = null
    
    select top 1 @w_secuencial =  secuencial,
           @w_estado         = estado       ,
           @w_municipio      = municipio    ,
    	   @w_nombre_municipio =  nombre_municipio
    from  #codigos_modificados
    where secuencial > @w_secuencial
    order by secuencial asc 
    
    if @@rowcount = 0
        break
		
    select  'Secuencial: '  + convert(varchar,@w_secuencial) + '--codigo estado: '+ convert(varchar, @w_estado) + '--codigo municipio: '+ convert(varchar, @w_municipio)

    select @w_codigo_estado = eq_valor_cat
    from   cob_conta_super..sb_equivalencias,
           cobis..cl_provincia
    where  eq_catalogo   ='ENT_FED' --34 -- estado
    and    eq_valor_arch = @w_estado
    and    pv_provincia  = eq_valor_cat
    
	select 'valor del @w_codigo_estado: ' + convert(varchar(10), isnull(@w_codigo_estado,''))
	
    if @w_codigo_estado is not null or @w_codigo_estado > 0
	begin
        select @w_codigo_municipio =  eq_valor_cat
        from cob_conta_super..sb_equivalencias, 
             cobis..cl_ciudad
        where eq_catalogo   = 'ENT_MUN'
        and   ci_ciudad     = eq_valor_cat
        and   eq_valor_arch = @w_municipio
        and   ci_provincia  = @w_codigo_estado 
        
		select 'valor del @w_codigo_municipio : ' + convert(varchar(10),@w_codigo_municipio )
	 
        if (@w_codigo_municipio is null or @w_codigo_municipio = 0 ) and @w_codigo_estado is not null
        begin
            select 'Va a insertar @w_municipio: '  + convert(varchar(10),@w_municipio )
		
		    select @w_codigo_ciudad = max(ci_ciudad) + 1
		    from cobis..cl_ciudad
		    
		    /*select @w_codigo_pais = pv_pais
		    from cobis..cl_provincia
		    where pv_provincia = @w_codigo_estado */
		    
		    insert into cobis..cl_ciudad ( 
		    							ci_ciudad,	ci_descripcion,  ci_estado,  ci_provincia, ci_cod_remesas, ci_pais, ci_canton)
		    					values ( @w_codigo_ciudad, @w_nombre_municipio, 'V', @w_codigo_estado,  1, @w_codigo_pais, 1)
		    
		    insert into cob_conta_super..sb_equivalencias (
                                           eq_catalogo , eq_valor_cat                      , eq_valor_arch, eq_descripcion   , eq_estado)
                                   values ('ENT_MUN', convert(varchar(10),@w_codigo_ciudad), @w_municipio , @w_nombre_municipio, 'V')                   		    
        end
		else
		begin
		    select 'Ya existe @w_municipio: ' + convert(varchar(10),@w_municipio) + '--Con @w_codigo_estado:' + convert(varchar(10),@w_codigo_estado)
		end
	end
	else
	begin
	    select 'Debe ser insertado @w_codigo_estado: ' + convert(varchar(10),@w_codigo_estado)
	end
end   

select 'municipios_nuevos'='municipios_nuevos',* from #codigos_modificados -- codigos postales nuevos

select @w_max_ciudad = max(ci_ciudad) + 1 from cobis..cl_ciudad 
select @w_max_ciudad

update cobis..cl_seqnos
set    siguiente = @w_max_ciudad
where  tabla = 'cl_ciudad'

/*
municipio -> ciudad
estado -> provincia
colonia -> parroquia
*/
drop table #codigos_modificados

print 'Fin script 02 codMunicipiosNuevos:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
-- 4s
go
