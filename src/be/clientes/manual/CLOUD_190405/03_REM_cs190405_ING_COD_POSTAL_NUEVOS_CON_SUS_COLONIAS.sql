use cobis
go
print 'Inicio 03_REM_cs174921_ING_COD_POSTAL_NUEVOS_CON_SUS_COLONIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
----------------
declare @w_secuencial       int,
        @w_codigo_postal    varchar(10),
        @w_estado           varchar(20),
        @w_municipio        varchar(20),
        @w_colonia          varchar(20),
        @w_nombre_colonia   varchar(255),
        @w_codigo_estado    int,
        @w_codigo_municipio int,
        @w_codigo_colonia   int,
        @w_codigo_parroquia int,
		@w_max_parroquia    int

create table #codigos_modificados(
secuencial       int           identity,
codigo_postal    varchar(10)   null,
estado           varchar(20)   null,
municipio        varchar(20)   null,
colonia          varchar(20)   null,
nombre_colonia   varchar(255)  null
)

insert into #codigos_modificados(
       codigo_postal, estado   , municipio   , colonia   , nombre_colonia)
select cp_codigo    , cp_estado, cp_municipio, cp_colonia, cp_nombre_col 
from   cl_codigo_postal_tmp f
where  f.cp_codigo not in (select distinct e.cp_codigo 
                          from cl_codigo_postal_tmp d, cl_codigo_postal e
                          where d.cp_codigo = e.cp_codigo
                          and d.cp_estado = e.cp_estado_h
                          and d.cp_municipio = e.cp_municipio_h
                          and d.cp_colonia = e.cp_colonia_h)
order by cp_estado, cp_municipio

select '#list_colonias_para_validar' = count(1) from #codigos_modificados
select 'list_colonias_para_validar' = 'list_colonias_para_validar', * from #codigos_modificados -- codigos postales nuevos

select @w_secuencial = 0

while 1 = 1
begin
    select @w_codigo_postal    = null,
           @w_codigo_estado    = null,
           @w_codigo_municipio = null,
           @w_codigo_colonia   = null,
           @w_estado           = null,
           @w_municipio        = null,
           @w_colonia          = null,
           @w_nombre_colonia   = null
      
    select top 1 @w_secuencial =  secuencial,
           @w_codigo_postal  = codigo_postal,
           @w_estado         = estado       ,
           @w_municipio      = municipio    ,
           @w_colonia        = colonia      ,
           @w_nombre_colonia = nombre_colonia
    from #codigos_modificados
    where secuencial > @w_secuencial
    order by secuencial asc 
      
    if @@rowcount = 0
       break
            
    select  'Secuencial: '  + convert(varchar,@w_secuencial) + 
	        '--codigo_postal: '+ convert(varchar, @w_codigo_postal) + 
	        '--@w_estado: '+ convert(varchar, @w_estado)+ 
	        '--@w_municipio: '+ convert(varchar, @w_municipio)+ 
	        '--@w_colonia: '+ convert(varchar, @w_colonia)+ 
	        '--@w_nombre_colonia: '+ convert(varchar, @w_nombre_colonia)

    select @w_codigo_estado = eq_valor_cat
    from   cob_conta_super..sb_equivalencias,
           cobis..cl_provincia
    where  eq_catalogo   ='ENT_FED' --34 -- estado
    and    eq_valor_arch = @w_estado
    and    pv_provincia  = eq_valor_cat
    
	select 'El valor @w_codigo_estado es: ' + convert(varchar(10), isnull(@w_codigo_estado,''))
	
	if (@w_codigo_estado is not null)
	begin
        select @w_codigo_municipio =  eq_valor_cat
        from cob_conta_super..sb_equivalencias, 
             cobis..cl_ciudad
        where eq_catalogo   = 'ENT_MUN'
        and   ci_ciudad     = eq_valor_cat
        and   eq_valor_arch = @w_municipio
        and   ci_provincia  = @w_codigo_estado 

        select 'El valor @w_codigo_municipio es: '  + convert(varchar(10), isnull(@w_codigo_municipio,''))
			   
	    if (@w_codigo_municipio is not null)
		begin
            select @w_codigo_colonia =  eq_valor_cat
            from cob_conta_super..sb_equivalencias, 
                  cobis..cl_parroquia
            where eq_catalogo   = 'ENT_PARROQ'
            and   pq_parroquia  = eq_valor_cat
            and   eq_valor_arch = @w_colonia
            and   pq_ciudad     = @w_codigo_municipio 

            select 'El valor @w_codigo_colonia es: '  + convert(varchar(10), isnull(@w_codigo_colonia,''))
			
            if (@w_codigo_colonia is not null) --- and   @w_codigo_municipio is not null
            begin
			    select 'No inserta cl_parroquia y sb_equivalencias--@w_colonia: ' + convert(varchar(10), isnull(@w_colonia,'')) + 
				       '--@w_codigo_municipio: '  + convert(varchar(10), isnull(@w_codigo_municipio,''))
            end
            else
            begin
			    select 'Insertando cl_parroquia y sb_equivalencias'
                select @w_codigo_parroquia = max(pq_parroquia) + 1
                from cobis..cl_parroquia
                
                insert into cobis..cl_parroquia (
                                              pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
                                      values (@w_codigo_parroquia, @w_nombre_colonia, 'U'    , @w_codigo_municipio, 'DM'   , 'V')
                
                insert into cob_conta_super..sb_equivalencias (
                                              eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
                                      values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), @w_colonia   , @w_nombre_colonia, 'V')
                
                select @w_codigo_colonia = @w_codigo_parroquia			
			end
            if not exists(select 1
                           from cobis..cl_codigo_postal
                           where cp_codigo     = @w_codigo_postal
                           and   cp_estado_h   = @w_estado
                           and   cp_municipio_h= @w_codigo_municipio
                           and   cp_colonia_h  = @w_colonia       )
            begin
                select '@w_codigo_postal'    = @w_codigo_postal   ,
                       '@w_codigo_estado'    = @w_codigo_estado   ,
                       '@w_codigo_municipio' = @w_codigo_municipio,
                       '@w_codigo_colonia'   = @w_codigo_colonia  ,
                       'estado'              = @w_estado        ,
                       'municipio'           = @w_municipio     ,
                       'colonia'             = @w_colonia       ,
                       'nombre_colonia'      = @w_nombre_colonia
                       
                if (@w_codigo_postal is not null and
                    @w_codigo_estado is not null and
                    @w_codigo_municipio is not null and
                    @w_codigo_colonia is not null and
                    @w_estado is not null and
                    @w_municipio is not null and
                    @w_colonia is not null and
                    @w_nombre_colonia is not null)
                begin          
                   select 'Insertando cl_codigo_postal'
                   insert into cl_codigo_postal (cp_codigo       , cp_estado       , cp_municipio       , cp_colonia       , cp_pais, cp_estado_h, cp_municipio_h, cp_colonia_h)
                                         values (@w_codigo_postal, @w_codigo_estado, @w_codigo_municipio, @w_codigo_colonia, 484    , @w_estado  , @w_municipio  , @w_colonia) 
                   
                end
            end
		end
		else
		begin
		    select 'ya existen: valor @w_municipio es: '  + convert(varchar(10), @w_municipio) + 
		           '--El valor @w_codigo_estado es: ' + convert(varchar(10), @w_codigo_estado)
		end
	end
	else
	begin
	    select 'Se debe insertar @w_estado: ' + convert(varchar(10),@w_estado)		
	end
end   

select @w_max_parroquia = max(pq_parroquia) + 1 from cobis..cl_parroquia
select @w_max_parroquia

update cobis..cl_seqnos
set    siguiente = @w_max_parroquia
where  tabla = 'cl_parroquia'

/*
municipio -> ciudad
estado -> provincia
colonia -> parroquia
*/

drop table #codigos_modificados
-- fin
print 'Fin 03_REM_cs174921_ING_COD_POSTAL_NUEVOS_CON_SUS_COLONIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
-- 4s
go
