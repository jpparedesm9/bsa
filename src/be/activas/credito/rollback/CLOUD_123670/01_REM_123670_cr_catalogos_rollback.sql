use cobis
go

declare @w_id_tabla int,
        @w_nom_tabla varchar(30)
		
select @w_nom_tabla = 'cr_doc_digitalizado_ind'
select @w_id_tabla = (select codigo from cobis..cl_tabla where tabla = @w_nom_tabla)

delete from cobis..cl_catalogo 
where tabla = @w_id_tabla
and codigo ='010'
and valor = 'SOLICITUD DE MODIFICACION DE DATOS'
  
go


use cobis
go

declare @w_nom_tabla varchar(30)

select @w_nom_tabla = 'cr_rol_sol_mod_dat'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

go
