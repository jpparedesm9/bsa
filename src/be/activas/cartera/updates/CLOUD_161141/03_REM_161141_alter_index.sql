
 use cob_cartera
 go
 DROP INDEX idx_ca_alta_mas_prosp_1 ON ca_alta_masiva_prosp
CREATE INDEX idx_ca_alta_mas_prosp_1 ON ca_alta_masiva_prosp(am_nombre_archivo)
go
