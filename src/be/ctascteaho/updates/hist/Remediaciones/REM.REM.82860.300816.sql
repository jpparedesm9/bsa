/*esta remediación se encuentra en esta ruta $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_table.sql*/

/* re_detalle_cheque */

use cob_remesas
go

if exists (select 1 from sysobjects where name = 're_detalle_cheque' and type = 'U')
   drop table re_detalle_cheque
go


print 'TABLA ====> re_detalle_cheque'
go
create table re_detalle_cheque
       (dc_filial       tinyint      not null,
        dc_oficina      smallint     not null,
        dc_fecha        date         not null,
        dc_fecha_efe    date         null,
        dc_id           smallint     null,
        dc_trn          smallint     null,
        dc_numctrl      int          null,
        dc_secuencial   smallint     not null,
        dc_ssn          int          null,
        dc_ssn_branch   int          null,
        dc_cta_banco    cuenta       null,
        dc_producto     tinyint      null,
        dc_tipo         catalogo     null,
        dc_tipo_chq     catalogo     null,
        dc_co_banco     smallint     null,
        dc_no_banco     varchar(50)  null,
        dc_cta_cheque   varchar(50)  null,
        dc_num_cheque   int          null,
        dc_valor        money        null,
        dc_moneda       tinyint      null,
        dc_fechaemision date         null,
        dc_estado       char(1)      null,
        dc_user         login        null,
        dc_hora         datetime     null,
		dc_detalle      varchar(128) null,		
		dc_factor           float    null,
        dc_cotizacion       float    null,
        dc_valor_convertido   money  null,
        dc_mon_destino      tinyint  null
		
		)
go