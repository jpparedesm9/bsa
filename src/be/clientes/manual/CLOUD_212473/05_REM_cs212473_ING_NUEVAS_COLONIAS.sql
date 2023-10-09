--------Necesario para que se ingresen las colonias, si no no se visualiza en las tablas
use cobis
go
----------------
print 'Inicio script 05_REM_cs212473_ING_NUEVAS_COLONIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)

declare 
@w_secuencial  int,
@w_cp_codigo     varchar(10),
@w_cp_estado     varchar(20),
@w_cp_municipio  varchar(20),
@w_cp_colonia    varchar(20),
@w_cp_nombre_col varchar(255),
@w_codigo_estado    int,
@w_codigo_municipio int,
@w_codigo_colonia   int,
@w_codigo_parroquia int,
@w_pais int,
@w_max_parroquia    int

select @w_pais = 484

create table #informacion_nueva (
secuencial    int     identity,
cp_codigo     varchar(10) not null,
cp_estado     varchar(20),
cp_municipio  varchar(20),
cp_colonia    varchar(20),
cp_nombre_col varchar(255)
)

insert into #informacion_nueva(
       cp_codigo, cp_estado , cp_municipio, cp_colonia, cp_nombre_col) 
select cp_codigo, cp_estado , cp_municipio, cp_colonia, cp_nombre_col
from cobis..cl_codigo_postal_tmp t
where not exists (select 1
                  from cobis..cl_codigo_postal d
                  where d.cp_estado_h   = t.cp_estado
                  and   d.cp_municipio_h= t.cp_municipio
                  and   d.cp_colonia_h  = t.cp_colonia
                  )

select '#informacion_nueva' = count(1) from #informacion_nueva

select 'list_colonias_para_ingresar' = 'list_colonias_para_ingresar', * from #informacion_nueva

select @w_secuencial = 0

while 1 = 1
begin
    select @w_cp_codigo     = '',
           @w_cp_estado     = '',
           @w_cp_municipio  = '',
           @w_cp_colonia    = '',
           @w_cp_nombre_col = '',
           @w_codigo_estado    = 0,
           @w_codigo_municipio = 0,
           @w_codigo_colonia   = 0,
           @w_codigo_parroquia = 0
    
    select  top 1 
    @w_secuencial    = secuencial  ,
    @w_cp_codigo     = cp_codigo   ,
    @w_cp_estado     = cp_estado   ,
    @w_cp_municipio  = cp_municipio, 
    @w_cp_colonia    = cp_colonia  ,
    @w_cp_nombre_col = cp_nombre_col      
    from #informacion_nueva
    where secuencial > @w_secuencial
    order by secuencial asc
      
    if @@rowcount = 0
       break
       
    select  'Secuencial: '  + convert(varchar,@w_secuencial) + '--w_cp_codigo: '+ convert(varchar, @w_cp_codigo)             
    
    select @w_codigo_estado = eq_valor_cat
    from cob_conta_super..sb_equivalencias,
         cobis..cl_provincia
    where eq_catalogo   ='ENT_FED' --34
    and   eq_valor_arch = @w_cp_estado
    and   pv_provincia  = eq_valor_cat  
    
    if @w_codigo_estado is null
    begin
       select 'no exist @w_cp_estado: ' + convert(varchar(10),@w_cp_estado)
    end
    
    select @w_codigo_municipio =  eq_valor_cat
    from cob_conta_super..sb_equivalencias, 
         cobis..cl_ciudad
    where eq_catalogo   = 'ENT_MUN'
    and   ci_ciudad     = eq_valor_cat
    and   eq_valor_arch = @w_cp_municipio
    and   ci_provincia  = @w_codigo_estado 
      
    if @w_cp_municipio is null   
    begin
       select 'No existe @w_municipio: '  + convert(varchar(10),@w_cp_municipio )
    end 
    
    select @w_codigo_colonia =  eq_valor_cat
    from cob_conta_super..sb_equivalencias, 
         cobis..cl_parroquia
    where eq_catalogo   = 'ENT_PARROQ'
    and   pq_parroquia  = eq_valor_cat
    and   eq_valor_arch = @w_cp_colonia
    and   pq_ciudad     = @w_codigo_municipio 
    
    if (@w_codigo_colonia is null or @w_codigo_colonia = 0) and @w_codigo_municipio is not null and @w_codigo_municipio <> 0
    begin
        select  'Va a insertar @w_codigo_colonia: '  +  convert(varchar(10),@w_cp_colonia) + ', se procede a insertar'
        
        select @w_codigo_parroquia = max(pq_parroquia) + 1
        from cobis..cl_parroquia
        
        insert into cobis..cl_parroquia (
                                      pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
                              values (@w_codigo_parroquia, @w_cp_nombre_col , 'U'    , @w_codigo_municipio, 'DM'   , 'V')
        
        insert into cob_conta_super..sb_equivalencias (
                                            eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
                                    values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), @w_cp_colonia, @w_cp_nombre_col , 'V')
        
        select @w_codigo_colonia = @w_codigo_parroquia
    end
    else
        select 'Ya existe @w_codigo_colonia: ' +  convert(varchar(10),@w_codigo_colonia)
     

    select '@w_codigo_postal'    = @w_cp_codigo       ,
         '@w_codigo_estado'    = @w_codigo_estado   ,
         '@w_codigo_municipio' = @w_codigo_municipio,
         '@w_codigo_colonia'   = @w_codigo_colonia  ,
         'estado'              = @w_cp_estado       ,
         'municipio'           = @w_cp_municipio    ,
         'colonia'             = @w_cp_colonia      ,
         'nombre_colonia'      = @w_cp_nombre_col
				  
    if not exists(select 1
                   from cobis..cl_codigo_postal
                   where cp_codigo     = @w_cp_codigo
                   and   cp_estado_h   = @w_cp_estado
                   and   cp_municipio_h= @w_cp_municipio
                   and   cp_colonia_h  = @w_cp_colonia       )
    begin     
        select 'Insertando cl_codigo_postal - 1'	 
        if (@w_cp_codigo is not null and
            @w_codigo_estado is not null and
            @w_codigo_municipio is not null and
            @w_codigo_colonia is not null and
            @w_cp_estado is not null and 
            @w_cp_municipio is not null and
            @w_cp_colonia is not null and
            @w_cp_nombre_col is not null)
        begin          
           select 'Insertando cl_codigo_postal - 2'
           insert into cl_codigo_postal(cp_codigo       , cp_estado       , cp_municipio       , cp_colonia       , cp_pais, cp_estado_h , cp_municipio_h , cp_colonia_h)
                                values (@w_cp_codigo    , @w_codigo_estado, @w_codigo_municipio, @w_codigo_colonia, @w_pais, @w_cp_estado, @w_cp_municipio, @w_cp_colonia) 
           
        end
    end 
    else
        select 'Ya existe el cl_codigo_postal'
end  

drop table #informacion_nueva

select @w_max_parroquia = max(pq_parroquia) + 1 from cobis..cl_parroquia
select @w_max_parroquia

update cobis..cl_seqnos
set    siguiente = @w_max_parroquia
where  tabla = 'cl_parroquia'


print 'Fin script 05_REM_cs212473_ING_NUEVAS_COLONIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--24s
go