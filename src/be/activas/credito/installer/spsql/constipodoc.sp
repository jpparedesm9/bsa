/* ********************************************************************* */
/*      Archivo:                constipodoc.sp                           */
/*      Stored procedure:       sp_consultar_tipo_documento              */
/*      Base de datos:          cob_credito                              */
/*      Producto:               Credito                                  */
/*      Disenado por:           Sonia Rojas                              */
/*      Fecha de escritura:     28-Enero-2019                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Consultar Tipos de documentos grupales, individuales y de        */ 
/*      clientes.                                                        */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*     28/01/2019       SROJAS               Version Inicial             */
/* ***********************************************************************/

use cob_credito
go

IF OBJECT_ID ('dbo.sp_consultar_tipo_documento') IS NOT NULL
	DROP PROCEDURE dbo.sp_consultar_tipo_documento
GO


create proc sp_consultar_tipo_documento(
@s_ssn                     int           = null,
@s_ofi                     smallint,
@s_user                    login,
@s_date                    datetime,
@s_srv                     varchar(30)   = null,
@s_term                    descripcion   = null,
@s_rol                     smallint      = null,
@s_lsrv                    varchar(30)   = null,
@s_sesn                    int           = null,
@s_org                     char(1)       = null,
@s_org_err                 int           = null,
@s_error                   int           = null,
@s_sev                     tinyint       = null,
@s_msg                     descripcion   = null,
@t_rty                     char(1)       = null,
@t_trn                     int           = null,
@t_debug                   char(1)       = 'N',
@t_file                    varchar(14)   = null,
@t_from                    varchar(30)   = null
)
as



select 
convert(varchar,td_codigo_tipo_doc) + '-WORKFLOW', 
td_nombre_tipo_doc 
from cob_workflow..wf_tipo_documento
where td_tipo_doc    = 'D'
and td_vigencia_doc  = 'V'
union
select 
LTRIM(RTRIM(c.codigo)) + '-PERSONA',
c.valor  
from   
cobis..cl_catalogo c, 
cobis..cl_tabla t
where t.tabla = 'cr_doc_digitalizado_ind'
and c.tabla  = t.codigo
and c.estado = 'V'
union
select 
LTRIM(RTRIM(c.codigo)) + '-GRUPO',
c.valor  
from   
cobis..cl_catalogo c, 
cobis..cl_tabla t
where t.tabla = 'cr_doc_digitalizado'
and c.tabla  = t.codigo
and c.estado = 'V'
order by 2 asc


go