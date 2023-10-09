/***********************************************************************************************************/
---No historia  			: 77227
---Título del Bug			: Sarta inicio de dia
---Fecha					: 28/Jul/2016 
--Descripción del Problema	: El parámetro de SRVR no corresponde al servidor actual. Los directorios en la ba_path_fuente no corresponden a los existentes
--Descripción de la Solución: se actualiza parametro y paths
--Autor						: Tania Baidal
/***********************************************************************************************************/

--Instalador Remesas - re_table
use cob_remesas
go
drop table re_trn_contable
go

CREATE TABLE re_trn_contable (
    tc_secuencial   int not null identity,
    tc_producto tinyint not null,
    tc_moneda   tinyint not null,
    tc_tipo_tran    smallint    not null,
    tc_causa    varchar(5)  null,
    tc_ofic_orig    smallint    not null,
    tc_ofic_dest    smallint    not null,
    tc_perfil   varchar(10) not null,
    tc_concepto varchar(10) not null,
    tc_valor    money   not null,
    tc_valor_me money   not null,
    tc_numtran  int not null,
    tc_tipo char(1) not null,
    tc_prod_banc    tinyint not null,
    tc_clase_clte   char(1) not null,
    tc_tipo_cta varchar(3)  null,
    tc_cliente  int null,
    tc_base money   null,
    tc_tipo_impuesto    varchar(1)  null,
    tc_concepto_imp varchar(10) null,
    tc_referencia   varchar(15) null,
    tc_fecha    datetime    null,
    tc_estcta   char(1) null,
    tc_estado   char(3) null,
    tc_comprobante  int null,
    tc_mensaje  varchar(120)    null,
    tc_cuenta1  varchar(24) null,
    tc_cuenta2  varchar(24) null,
    tc_hora datetime    null
)
go


use cob_ahorros
go

--Instalador Ahorros - ah_pkey

if exists( select 1 from sysindexes where name='ah_cuenta_batch_Key')
    drop index ah_cuenta_batch.ah_cuenta_batch_Key
 go 
 
CREATE UNIQUE CLUSTERED INDEX ah_cuenta_batch_Key
    ON ah_cuenta_batch (cb_cuenta)
go

use cobis
go

--Instalador Ahorros - ah_batch
update ba_path_pro 
   set pp_path_fuente = 'C:\Cobis\vbatch\ahorros\objetos\', 
       pp_path_destino = 'C:\Cobis\vbatch\ahorros\listados\'
where pp_producto = 4
go

--Instalador de Admin
update cl_parametro set pa_char = 'CLOUDSRV'
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'
go

