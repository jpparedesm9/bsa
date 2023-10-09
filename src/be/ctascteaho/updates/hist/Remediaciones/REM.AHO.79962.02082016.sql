/***********************************************************************************************************/
---No Bug					: 79962
---Título del Bug			: Bug : Back Office - Relación cuenta a canales
---Fecha					: 02/08/2016 
--Descripción del Problema	: Falta creación de Tabla
--Descripción de la Solución: se crea script de remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

------------------------------------------------------------------------
use cobis
go

-- mis_table.sql
-- full.cmd

print '=====>crea la tabla cl_validacion_huella'
go
if exists ( select 1 from sysobjects where name = 'cl_validacion_huella' )
   drop table cl_validacion_huella
go

create table cl_validacion_huella(
vh_tipo_tran   int         null, 
vh_tipo_ced    char(2)     null,    
vh_ced_ruc     varchar(30) null,  
vh_ref         varchar(30) null,
vh_estado      char(1)     null, 
vh_titularidad char(1)     null, 
vh_usuario     varchar(12) null,
vh_id_caja     int         null,
vh_respuesta   varchar(10) null,
vh_fecha       datetime    null
)
