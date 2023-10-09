use cob_remesas
go


/* re_detalle_cheque */
print 'TABLA ====> re_detalle_cheque'
go
create table re_detalle_cheque
(
	dc_filial       tinyint      not null,
	dc_oficina      smallint     not null,
	dc_fecha        date         not null,
	dc_fecha_efe    date         null,
	dc_id           smallint     not null,
	dc_trn          smallint     not null,
	dc_numctrl      int          not null,
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

print 'i_bco_cta_chq'
CREATE nonclustered INDEX i_bco_cta_chq on re_detalle_cheque(
                dc_co_banco,
				dc_cta_cheque,
				dc_num_cheque)
go

print 'i_ofi_fech_pro_bco_cta'
CREATE nonclustered INDEX i_ofi_fech_pro_bco_cta on re_detalle_cheque(
                dc_oficina,
				dc_fecha_efe,
				dc_producto,
				dc_cta_banco)
go
