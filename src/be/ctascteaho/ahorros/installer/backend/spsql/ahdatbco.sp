/***********************************************************************/
/*      Archivo:                        ahdatbco.sp                    */
/*      Stored procedure:               sp_ah_datos_bco                */
/*      Base de Datos:                  cob_ahorros                    */
/*      Producto:                       AHORROS                        */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Consulta datos del banco para la impresion de los contratos de      */
/* ahorros.                                                            */
/***********************************************************************/

use cob_ahorros
go

if exists(select * from sysobjects where name = 'sp_ah_datos_bco')
   drop proc sp_ah_datos_bco
go

create proc sp_ah_datos_bco
as

declare @w_cod_ente_cobis int,
        @w_correo         varchar(50),
        @w_sitioweb       varchar(50)

--Obtener parametro codigo de banco COBIS
select @w_cod_ente_cobis = pa_int
from   cobis..cl_parametro 
where  pa_nemonico = 'ENCO'

--Obtener parametro correo electronico 
select @w_correo = pa_char
from   cobis..cl_parametro 
where  pa_nemonico = 'EMCO'

--Obtener parametro Pagina de internet
select @w_sitioweb = pa_char
from   cobis..cl_parametro 
where  pa_nemonico = 'PWCO'

select  'nombre_corto'  = en_nombre, 
        'nombre_largo'  = en_nomlar, 
        'direccion'     = (select top 1 di_descripcion from cobis..cl_direccion where di_ente = en_ente),
        'telefono1'     = (select te_valor from cobis..cl_telefono where te_ente = en_ente and te_secuencial = 1),
        'telefono2'     = (select te_valor from cobis..cl_telefono where te_ente = en_ente and te_secuencial = 2),
        'correo'        = @w_correo,
        'sitio_web'     = @w_sitioweb
from    cobis..cl_ente 
where   en_ente = @w_cod_ente_cobis


return 0
go

