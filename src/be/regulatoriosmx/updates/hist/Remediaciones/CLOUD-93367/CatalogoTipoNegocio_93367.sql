

PRINT '--->> Registro de catalogos-cr_tipo_negocios'
use cobis
go
declare @w_tabla int,
        @w_apostrofe char(1)

select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_negocio'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tipo_negocio', 'TIPO DE NGOCIO')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

select @w_apostrofe = CHAR(39)


INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '01', 'SERVICIO MEDICO', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '02', 'CIA '+'Q' + @w_apostrofe  +' OTORGA', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '03', 'COMP PETROLERA', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '04', 'EDITORIAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '05', 'SERV FIDUCIARIOS', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '06', 'TIENDA COMERCIAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '07', 'COMUNICACIONES', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '08', 'SERVICIOS', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '09', 'PRUEBA OTORGANTE', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '10', 'PRUEBAS BC', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '11', 'PROCESADOR', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '12', 'CONSULTA MI BURO', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '13', 'CONSUMIDOR FINAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '14', 'EDUCACIÓN', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '15', 'SERVS. GRALES.', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '16', 'SEGURO', 'V' )

select *
from cl_catalogo
where tabla = @w_tabla

GO


	
	
