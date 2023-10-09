/*************************************************/
---No Bug: 75596
---Título del Bug: MAN - Mantenimiento Causales ND/NC por Oficina 
---Fecha: 24/06/2016
--Descripción del Problema: no inserta registro 
--Descripción de la Solución: SE envia script de remediación con autorización de trn
--Autor: Ignacio Yupa
/*************************************************/

-------------------
use cob_remesas
go

/******************************************************/
--Fecha Creación del Script: 2016/06/23               */
--Historial  Dependencias:                            */
--Modificacion tabla re_catalogo_ofi */
--Modulo :MIS CTA_AHO                                 */
/******************************************************/
/* PK__re_catalogo_ofi__3575474C */
print 'PK__re_catalogo_ofi__3575474C'
if exists (select i.name from sysindexes i, sysobjects o
    where i.id = o.id and i.name = 'PK__re_catalogo_ofi__3575474C' and o.name = 're_catalogo_ofi')
drop index re_catalogo_ofi.PK__re_catalogo_ofi__3575474C
go

/* re_catalogo_ofi_Key */
print 're_catalogo_ofi_Key'
if exists (select i.name from sysindexes i, sysobjects o
    where i.id = o.id and i.name = 're_catalogo_ofi_Key' and o.name = 're_catalogo_ofi')
drop index re_catalogo_ofi.re_catalogo_ofi_Key
go

/* PK__re_catalogo_ofi__3575474C */
print 'PK__re_catalogo_ofi__3575474C'
if exists (select * from sysindexes
    where name = 'PK__re_catalogo_ofi__3575474C')
drop index re_catalogo_ofi.PK__re_catalogo_ofi__3575474C
go

/* re_catalogo_ofi */
print 'ELIMINA TABLA ====> re_catalogo_ofi'
go
if exists (select * from sysobjects where name = 're_catalogo_ofi')
    drop TABLE re_catalogo_ofi
go

print 'TABLA ====> re_catalogo_ofi'
go
CREATE TABLE re_catalogo_ofi (
    co_index    int IDENTITY(1,1) not null,
    co_tipo char(1) not null,
    co_oficina  smallint    null,
    co_tabla    varchar(30) not null,
    co_cod_tabla    varchar(30) not null,
    co_codigo   varchar(10) not null
)
go

print 'PK__re_catalogo_ofi__3575474C on re_catalogo_ofi'
CREATE UNIQUE INDEX PK__re_catalogo_ofi__3575474C on re_catalogo_ofi(
                co_index)
                
print 're_catalogo_ofi_Key on re_catalogo_ofi'
CREATE INDEX re_catalogo_ofi_Key on re_catalogo_ofi(
                co_codigo,
                co_oficina,
                co_tabla)
go


use cobis
go

update cobis..cl_oficina set of_bloqueada = 'N' where of_subtipo = 'O'
go

--IYU 
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 4 --->PRODUCTO 4 - CUENTA DE AHORROS

delete FROM ad_tr_autorizada 
 WHERE ta_transaccion in ( 234) 
   and ta_producto = @w_producto
   and ta_rol = @w_rol

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 234, @w_rol, getdate(), 1, 'V', getdate())

go
                