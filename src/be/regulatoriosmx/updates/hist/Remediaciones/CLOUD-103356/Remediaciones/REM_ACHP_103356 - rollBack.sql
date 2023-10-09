--SULLY HERNANDEZ MORALES
--CURP: HEMS781010MDFRRL03
--RFC: HEMS781010
--COD: 26395

--PENELOPEZ HAYDEE NAVARRO TAPIA
--CURP: NATP790529MDFVPN05
--RFC: NATP790529
--COD: 25866

--NOMBRE: SULLY HERNANDEZ MORALES # 26395 Fecha de Nacimiento correcta:10/10/1978
--NOMBRE: PENELOPE HAYDEE NAVARRO TAPIA # 25866 Fecha de nacimiento correcta: 29-05-1979.

--SELECT 'CURP' = en_ced_ruc, 'rfc' = en_nit, 'rfc1' = en_rfc, p_fecha_nac, * FROM cobis..cl_ente
--WHERE en_ente IN (20995)
--SELECT 'CURP' = ea_ced_ruc, 'rfc' = ea_nit, * FROM cobis..cl_ente_aux
--WHERE ea_ente IN (20995)

print 'Cliente 26395'
UPDATE cobis..cl_ente
SET p_fecha_nac = '10/09/1978',    -- 10/10/1978
    en_ced_ruc  = 'HEMS781009MDFRRL02', --curp
	en_nit      = 'HEMS7810094Z2', --rfc
	en_rfc      = 'HEMS7810094Z2'  --rfc
WHERE en_ente IN (26395)

UPDATE cobis..cl_ente_aux
SET ea_ced_ruc  = 'HEMS781009MDFRRL02', --curp
	ea_nit      = 'HEMS7810094Z2' --rfc¿
WHERE en_ente IN (26395)

print 'Cliente 25866'
UPDATE cobis..cl_ente
SET p_fecha_nac = '05/28/1979',    -- 29/05/1979
    en_ced_ruc  = 'NATP710521MDFVPN04', --curp
	en_nit      = 'NATP710521N29', --rfc
	en_rfc      = 'NATP710521N29'  --rfc
WHERE en_ente IN (25866)

UPDATE cobis..cl_ente_aux
SET ea_ced_ruc  = 'NATP710521MDFVPN04', --curp
	ea_nit      = 'NATP710521N29' --rfc¿
WHERE en_ente IN (25866)
go