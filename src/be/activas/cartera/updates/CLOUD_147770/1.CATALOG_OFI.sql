use cobis
go

declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla='ca_descuento_oficina'

if(@w_tabla is not null or @w_tabla> 0)
begin

	delete from cl_catalogo_pro where cp_tabla = @w_tabla
	delete from cl_catalogo where tabla = @w_tabla
	delete from cl_tabla where codigo = @w_tabla
end
else
begin
	select @w_tabla = max(codigo)+1 from cl_tabla
end


insert into cl_tabla values(@w_tabla, 'ca_descuento_oficina', 'Oficinas para plan recompensa')

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'09/07/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('Regional Toluca'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'09/07/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION HIDALGO'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'09/07/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION CDMX'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'09/07/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('Regional Chalco'))


insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/05/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION CHIAPAS'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/05/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION CHIAPAS SOCONUSCO'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/05/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION COATZACOALCOS'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/19/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION MORELOS'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/19/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION GUERRERO'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/19/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION OAXACA ISTMO'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/26/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('REGION QUERETARO'))

insert into cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla,of_oficina,'10/26/2020','V' FROM cobis..cl_oficina
WHERE of_regional IN  (SELECT of_oficina FROM cobis..cl_oficina WHERE of_nombre IN ('Regional Puebla'))
go
