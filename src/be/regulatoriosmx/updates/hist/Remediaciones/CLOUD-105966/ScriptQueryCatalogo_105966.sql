

print '--->> Registro de catalogos--- cr_etapa_genera_tabla'
use cobis
go
declare @w_tabla            int,
        @w_codigo_actividad int,
        @w_codigo_act_varch varchar(8)

select @w_tabla = codigo from cl_tabla where tabla = 'cr_etapa_genera_tabla'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_etapa_genera_tabla', 'ETAPAS GENERA TABLA')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
    
end

delete from cobis..cl_catalogo where tabla = @w_tabla

select @w_codigo_actividad = ac_codigo_actividad
from cob_workflow..wf_actividad
where  ac_nombre_actividad like '%APROBAR PRÉSTAMO%'

select @w_codigo_act_varch = convert(varchar(8),@w_codigo_actividad) 
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, @w_codigo_act_varch, 'APROBACION', 'V' )

select * from cobis..cl_catalogo where tabla = @w_tabla