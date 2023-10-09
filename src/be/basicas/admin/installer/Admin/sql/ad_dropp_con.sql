/************************************************************************/
/*	Archivo:		ad_dropp.sql				*/
/*	Base de datos:		cobis					*/
/*	Producto:		Controlador				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este script elimina los índices sobre clave primaria del Control*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

/* ad_nodo_nivel */
print '=====> ad_nodo_nivel'
if exists (select name from sysindexes where name='ad_nodo_nivel_Key')
DROP INDEX ad_nodo_nivel.ad_nodo_nivel_Key
go

/* ad_nivel_mapa*/
print '=====> ad_nivel_mapa'
if exists (select name from sysindexes where name='ad_nivel_mapa_Key')
DROP INDEX ad_nivel_mapa.ad_nivel_mapa_Key
go

/* ad_nivel*/
print '=====> ad_nivel'
if exists (select name from sysindexes where name='ad_nivel_Key')
DROP INDEX ad_nivel.ad_nivel_Key
go

/* ad_mapa*/
print '=====> ad_mapa'
if exists (select name from sysindexes where name='ad_mapa_Key')
DROP INDEX ad_mapa.ad_mapa_Key
go

/* ad_icono*/
print '=====> ad_icono'
if exists (select name from sysindexes where name='ad_icono_Key')
DROP INDEX ad_icono.ad_icono_Key
go

/* ad_catalogo_icono*/
print '=====> ad_catalogo_icono'
if exists (select name from sysindexes where name='ad_catalogo_icono_Key')
DROP INDEX ad_catalogo_icono.ad_catalogo_icono_Key
go
