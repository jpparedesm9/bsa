use cobis
go
print 'Inicio script 04 codPostalNuevosEnDireccion:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
----
/*******************************************************************/
/*Se obtiene los codigos postales antiguos y nuevos                */
/*******************************************************************/
select distinct 'codpost_antiguo'= e.cp_codigo,
                'codpost_nuevo'  = d.cp_codigo,
                --estos me van a servir para actualiza la tabal de direccion
                e.cp_estado, 
                e.cp_municipio, 
                e.cp_colonia, 
                --- estos no sirven
                'estado_arch' = e.cp_estado_h, 
                'muni_arch'   = e.cp_municipio_h, 
                'colonia_arch' = e.cp_colonia_h
into #para_actualizacion_codigo
from cl_codigo_postal_tmp d, cl_codigo_postal e
where d.cp_codigo  <> e.cp_codigo
and d.cp_estado    = e.cp_estado_h
and d.cp_municipio = e.cp_municipio_h
and d.cp_colonia   = e.cp_colonia_h

/**********************************************************************/
/*Update de Codigos Postales antiguos a nuevos                        */ ----preguntar antes
/**********************************************************************/
   
UPDATE cl_codigo_postal
   SET cp_codigo = codpost_nuevo
  FROM #para_actualizacion_codigo
 where cp_codigo      = codpost_antiguo
   and cp_estado_h    = estado_arch
   and cp_municipio_h = muni_arch
   and cp_colonia_h   = colonia_arch

/**********************************************************************/
/*Update de codigo postal en base a la provincia, minicipio, colonia  */
/*                                     estado,    ciudad,    parroquia*/
/**********************************************************************/
select 'direcc_a_actualizar' = 'direcc_a_actualizar',
       'Cliente' = di_ente,	   
	   'NombreCLiente' = (select isnull (en_nombre,'') +' '+ isnull(p_s_nombre,'') +' '+ 
	   isnull(p_p_apellido,'') +' '+ isnull(p_s_apellido,'') from cobis..cl_ente where en_ente = di_ente),
       'Estado'    = di_provincia, 
	   'Municipio' = di_ciudad, 
	   'Colonia'   = di_parroquia, codpost_antiguo, codpost_nuevo
from cobis..cl_direccion, #para_actualizacion_codigo
where  di_provincia = cp_estado   -- estado
and    di_ciudad    = cp_municipio-- municio
and    di_parroquia = cp_colonia  --colonia
and    di_codpostal = codpost_antiguo

update cobis..cl_direccion
set    di_codpostal = codpost_nuevo
from   #para_actualizacion_codigo
where  di_provincia = cp_estado   -- estado
and    di_ciudad    = cp_municipio-- municio
and    di_parroquia = cp_colonia  --colonia
and    di_codpostal = codpost_antiguo


select 'codPostAnt_vs_codPostNuev'='codPostAnt_vs_codPostNuev', * from #para_actualizacion_codigo -- join con la tabla direccion--cuando envia a actualizar debe salir cerror registros

drop table #para_actualizacion_codigo

print 'Fin script 04 codPostalNuevosEnDireccion:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)

go
