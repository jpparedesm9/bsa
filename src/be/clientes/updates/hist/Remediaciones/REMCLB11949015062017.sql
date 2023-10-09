/**********************************************************************************************************************/
--No Bug                                : B119490
--Título de la Historia           : CGS-B119490 No presentó Tipo de Identificación en cabecera Referencias Personales
--Fecha                                      : 15/06/2017
--Descripción del Problema   :  No se muestra tipo de identificación
--Descripción de la Solución : Correccion de la tabla y catalogo cl_tipo_documento 
--Autor                                        : Paúl Ortiz Vera
--Instalador                 : ca_cew_menu.sql   -   5_sta_data.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
use cobis
go
--
-- TABLE INSERT cl_tipo_documento
--
truncate table cl_tipo_documento


insert into cl_tipo_documento ( td_secuencial, td_codigo, td_descripcion, td_mascara, td_tipoper, td_provincia, td_aperrapida, td_bloquea, td_nacionalidad, td_digito, td_estado, td_desc_corta, td_compuesto, td_nro_compuesto, td_adicional, td_creacion, td_habilitado_mis, td_habilitado_usu, td_prefijo, td_subfijo ) 
        values ( 0, 'CURP', 'CLAVE UNICA DE REGISTRO DE POBLACION', null, 'P', 'N', 'S', 'N', '68', 'N', 'V', 'CURP', 'S', 0, 0, 'S', 'S', 'S', null, 'CURP' )
go

/*************/
/*   TABLA   */
/*************/

use cobis
go

delete cl_catalogo_pro
    from cl_tabla
where cl_tabla.tabla in ('cl_tipo_documento')
    and codigo = cp_tabla
go

delete cl_catalogo
    from cl_tabla
where cl_tabla.tabla in ('cl_tipo_documento')
    and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
where cl_tabla.tabla in ('cl_tipo_documento')
go

declare @w_codigo smallint

select @w_codigo = isnull(max(codigo),0) + 1
from cl_tabla

select @w_codigo = @w_codigo + 1

print 'Tipos de Documento'
insert into cl_tabla values (@w_codigo, 'cl_tipo_documento', 'TIPOS DE DOCUMENTO')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'CURP', 'CLAVE UNICA DE REGISTRO DE POBLACION','V')
