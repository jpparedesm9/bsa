use cobis
go

declare @w_tabla int

select @w_tabla = max(codigo) + 1 from cl_tabla

if not exists(select 1 from cl_tabla where tabla = 'bpl_result_policies')
begin

INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla, 'bpl_result_policies', 'Resultado de politicas' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla, '0', 'CUMPLE', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla, '1', 'NO CUMPLE', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla, '2', 'EXCEPCIONA', 'V' )

end

GO

