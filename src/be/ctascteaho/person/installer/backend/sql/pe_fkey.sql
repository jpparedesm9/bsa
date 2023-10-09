use cob_remesas
go


print 're_codigo_Key on pe_mercado'
CREATE UNIQUE INDEX re_codigo_Key on pe_pro_rango_edad(
                re_codigo)
go

print 'i_mercado on pe_mercado'
CREATE INDEX i_mercado on pe_mercado(
				me_pro_bancario,
				me_tipo_ente)
go

print 'i_pro_final on pe_pro_final'
CREATE UNIQUE INDEX i_pro_final on pe_pro_final(
				pf_pro_final)
go

print 'i_servicio_dis on pe_servicio_dis'
CREATE UNIQUE INDEX i_servicio_dis on pe_servicio_dis(
				sd_nemonico)
go

print 'i_servicio_per on pe_servicio_per'
CREATE UNIQUE INDEX i_servicio_per on pe_servicio_per(
				sp_servicio_per)
go

print 'idx_oa_oficina on pe_oficina_autorizada'
CREATE INDEX idx_oa_oficina on pe_oficina_autorizada(
				oa_oficina)
go

print 'idx1 on pe_par_com_trn'
CREATE INDEX idx1 on pe_par_com_trn(
				pct_categoria,
				pct_causa,
				pct_estado,
				pct_profinal,
				pct_transaccion
                )
go