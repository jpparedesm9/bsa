/*************************************************************************************/
--No Historia                : CGS-B145792 
--Titulo de la Historia      : Tasas Referenciales
--Fecha                      : 27/11/2017
--Descripcion del Problema   : Tasas Referenciales
--Descripcion de la Solucion : Tasas Referenciales
--Autor                      : Francisco Vargas
/*************************************************************************************/


print '=====> ts_tasas_referenciales'

use cobis 

go

if exists (select * from sysobjects where type='V' and name='ts_tasas_referenciales')
    drop view ts_tasas_referenciales
go


CREATE VIEW ts_tasas_referenciales (
    secuencia, tipo_transaccion, clase, fecha,
    oficina_s, usuario, terminal_s, srv, lsrv,
    tasa, descripcion, estado, grupo
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_codigocat, ts_descripcion, ts_protocolo, ts_base
from   ad_tran_servicio 
where  ts_tipo_transaccion = 15188
or     ts_tipo_transaccion = 15189
 
 go

if exists ( select * from sysobjects where name = 'te_ttasas_referenciales' )
	drop TABLE te_ttasas_referenciales
go

print '=====> te_ttasas_referenciales'
go
CREATE TABLE te_ttasas_referenciales (
        tr_tasa         catalogo       null,
        tr_descripcion  descripcion    null,
        tr_estado       char(1)        null,
        tr_grupo        catalogo       null
)
go

go
