/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : CGS-S119681 Impresi�n de Documentos - Documentos (3) - II Parte - Flujo Grupal
--Fecha                      : 12/07/2017
--Descripci�n del Problema   : nuevos reportes
--Descripci�n de la Soluci�n : Registrar el servicio para la consulta de info de prestamos gurpales
--                             y registro de pantalla DUMMY
--Autor                      : Walther Toledo
--Instalador                 : cr_catalogos.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/
/**********************************************************************************************************************/

use cobis
go

declare @w_secuencial int
select @w_secuencial = codigo from cobis..cl_tabla where tabla = 'cr_tplazo_ind'

update cobis..cl_catalogo set valor = 'SEMANA(S)'
where tabla = @w_secuencial and codigo = 'W'

update cobis..cl_catalogo set valor = 'QUINCENA(S)'
where tabla = @w_secuencial and codigo = 'Q'

select tabla, codigo, valor from cobis..cl_catalogo where tabla = @w_secuencial

go