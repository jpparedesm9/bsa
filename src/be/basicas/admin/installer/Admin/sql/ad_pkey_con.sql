/************************************************************************/
/*	Archivo:		ad_pkey.sql				*/
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
/*	Este script crea los indices en clave primaria del CONTROLADOR	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

/* ad_nodo_nivel */
print '=====> ad_nodo_nivel'
CREATE UNIQUE CLUSTERED INDEX ad_nodo_nivel_Key ON ad_nodo_nivel (
	nn_filial,
	nn_oficina,
	nn_nodo,
	nn_codigo_nivel,
	nn_codigo_mapa
)
go

/* ad_nivel_mapa*/
print '=====> ad_nivel_mapa'
CREATE UNIQUE CLUSTERED INDEX ad_nivel_mapa_Key ON ad_nivel_mapa (
	nm_codigo_nivel,
	nm_codigo_mapa
)
go

/* ad_nivel*/
print '=====> ad_nivel'
CREATE UNIQUE CLUSTERED INDEX ad_nivel_Key ON ad_nivel (
	ni_codigo_nivel
)
go

/* ad_mapa*/
print '=====> ad_mapa'
CREATE UNIQUE CLUSTERED INDEX ad_mapa_Key ON ad_mapa (
	mp_codigo_mapa
)
go

/* ad_icono*/
print '=====> ad_icono'
CREATE UNIQUE CLUSTERED INDEX ad_icono_Key ON ad_icono (
	ic_codigo_nivel,
	ic_codigo_mapa,
	ic_codigo_icono,
        ic_mapa_hijo
)
go

/* ad_catalogo_icono*/
print '=====> ad_catalogo_icono'
CREATE UNIQUE CLUSTERED INDEX ad_catalogo_icono_Key ON ad_catalogo_icono (
        ci_codigo_icono
)
go
