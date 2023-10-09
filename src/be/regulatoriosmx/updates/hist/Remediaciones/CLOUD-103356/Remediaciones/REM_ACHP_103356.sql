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
SET p_fecha_nac = '10/10/1978',    -- 10/10/1978
    en_ced_ruc  = 'HEMS781010MDFRRL03', --curp
	en_nit      = 'HEMS781010', --rfc
	en_rfc      = 'HEMS781010'  --rfc
WHERE en_ente IN (26395)

UPDATE cobis..cl_ente_aux
SET ea_ced_ruc  = 'HEMS781010MDFRRL03', --curp
	ea_nit      = 'HEMS781010' --rfc¿
WHERE ea_ente IN (26395)

print 'Cliente 25866'
UPDATE cobis..cl_ente
SET p_fecha_nac = '05/29/1979',    -- 29/05/1979
    en_ced_ruc  = 'NATP790529MDFVPN05', --curp
	en_nit      = 'NATP790529', --rfc
	en_rfc      = 'NATP790529'  --rfc
WHERE en_ente IN (25866)

UPDATE cobis..cl_ente_aux
SET ea_ced_ruc  = 'NATP790529MDFVPN05', --curp
	ea_nit      = 'NATP790529' --rfc¿
WHERE ea_ente IN (25866)
go