use cobis
go
------ 406----------------
--/*******************************************************************/
----DD-para saber cuales se eliminaran
--/*******************************************************************/
print 'Ini script 07_cs204415_CONSULTA_ANT_ELI_ENTREGAR_AL_DESARROLLADOR:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)

select distinct cp_estado_h, cp_municipio_h, cp_colonia_h, cp_estado, cp_municipio, cp_colonia, cp_codigo
into #antigua_informacion
from cl_codigo_postal
group by cp_estado_h, cp_municipio_h, cp_colonia_h, cp_estado, cp_municipio, cp_colonia, cp_codigo
order by cp_estado_h, cp_municipio_h, cp_colonia_h, cp_estado, cp_municipio, cp_colonia, cp_codigo

select distinct cp_estado, cp_municipio, cp_colonia, cp_codigo
into #nueva_informacion
from cl_codigo_postal_tmp
group by cp_estado, cp_municipio, cp_colonia, cp_codigo
order by cp_estado, cp_municipio, cp_colonia, cp_codigo

select cp_estado_h, cp_municipio_h, cp_colonia_h, cp_estado, cp_municipio, cp_colonia, cp_codigo
into #informacion_para_borrar
from #antigua_informacion n
where not exists (select 1
                  from  #nueva_informacion 
                  where n.cp_estado_h    = cp_estado
                  and   n.cp_municipio_h = cp_municipio
				  and   n.cp_colonia_h   = cp_colonia)

--select * from #informacion_para_borrar
go

-----------clientes que tienen los codigos eliminados
select di_ente, 
       convert(varchar(100),null) as tipo,
       convert(varchar(100),null) as nombre,
       cp_codigo, 
       cp_estado_h,    convert(varchar(100),'') as nombre_estado, 
       cp_municipio_h, convert(varchar(100),'') as nombre_municipio, 
       cp_colonia_h,   convert(varchar(100),'') as nombre_colonia
       -----POR PRUEBAS
       ,cp_estado, cp_municipio, cp_colonia
into  #informacion_para_enviar
from  #informacion_para_borrar, cobis..cl_direccion
where cp_estado    = di_provincia
and   cp_municipio = di_ciudad
and   cp_colonia   = di_parroquia
and   cp_codigo    = di_codpostal

--'ENT_FED',   --provincia-estado
--'ENT_MUN',   --ciudad-municipio
--'ENT_PARROQ' --parrroquia-colonia
---------------ESTADO
update #informacion_para_enviar
set    nombre = isnull(en_nombre,'') + ' ' + 
                isnull(p_s_nombre,'')  + ' ' + 
                isnull(p_p_apellido,'') + ' ' + 
                isnull(p_s_apellido,'')
from   cobis..cl_ente
where  en_ente = di_ente

update #informacion_para_enviar
set    tipo = CASE WHEN ea_estado = 'A' THEN 'CLIENTE' ELSE 'PROSPECTO' end
from   cobis..cl_ente_aux
where  ea_ente = di_ente

--SELECT * from   cob_conta_super..sb_equivalencias
---------------ESTADO
update #informacion_para_enviar
set    nombre_estado = pv_descripcion
from   cl_provincia
where  cp_estado = pv_provincia

--select * from cobis..cl_provincia

---------------MUNICIPIO
update #informacion_para_enviar
set    nombre_municipio = ci_descripcion
from   cobis..cl_ciudad
where  cp_municipio = ci_ciudad
and    cp_estado    = ci_provincia

--select * from cobis..cl_ciudad

---------------PARROQUIA
update #informacion_para_enviar
set    nombre_colonia = pq_descripcion
from   cobis..cl_parroquia
where  cp_colonia =  pq_parroquia
and    cp_municipio = pq_ciudad

--select * from cobis..cl_parroquia
--select * from #informacion_para_enviar
select distinct  -- este se envia 492
       'ID_CLIENTE' = di_ente,
       'TIPO'       = tipo,
       'COD_POSTAL' = cp_codigo,
       'NOMBRE'           = nombre,
       'ESTADO'           = cp_estado_h,
       'ESTADO_NOMBRE'    = nombre_estado,
       'MUNICIPIO'        = cp_municipio_h,
       'MUNICIPIO_NOMBRE' = nombre_municipio,
       'COLONIA'          =  cp_colonia_h,
       'COLONIA_NOMBRE'   = nombre_colonia
 from #informacion_para_enviar
 
 
--select distinct * from #informacion_para_enviar

drop table #antigua_informacion
drop table #informacion_para_enviar
drop table #nueva_informacion
drop table #informacion_para_borrar

print 'Fin script 07_cs204415_CONSULTA_ANT_ELI_ENTREGAR_AL_DESARROLLADOR:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--4s
go

------------------------------------------------------------------------------------------------------------
--Para comprobar
------------------------------------------------------------------------------------------------------------
/*select  * from #informacion_para_enviar where di_ente = 52
declare @w_cp_estado int, @w_cp_municipio int , @w_cp_colonia int,
        @w_cp_estado_h varchar(30), @w_cp_municipio_h varchar(30) , @w_cp_colonia_h varchar(30)

select @w_cp_estado = 9,
       @w_cp_municipio = 277,
       @w_cp_colonia = 29008
       
select @w_cp_estado_h = '09',
       @w_cp_municipio_h = '013', 
       @w_cp_colonia_h  = '2389'
       
select * from cl_provincia where pv_provincia = @w_cp_estado
select * from cl_ciudad where ci_ciudad = @w_cp_municipio and ci_provincia = @w_cp_estado
select * from cobis..cl_parroquia where pq_parroquia = @w_cp_colonia and pq_ciudad = @w_cp_municipio

---------------------------
-----------clientes que tienen los codigos eliminados
select count(1)
from  cobis..cl_direccion
WHERE NOT EXISTS (SELECT 1 FROM cobis..cl_codigo_postal
where cp_estado    = di_provincia
and   cp_municipio = di_ciudad
and   cp_colonia   = di_parroquia
--and   cp_codigo    = di_codpostal
)
AND di_tipo <> 'CE'

--399873
--7509 <>'CE'
--7469 sin where en di_codPostal


*/
