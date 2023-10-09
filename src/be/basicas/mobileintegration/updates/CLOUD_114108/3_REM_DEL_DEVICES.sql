use cob_sincroniza
go

DELETE si_dispositivo 
WHERE di_codigo NOT IN (
SELECT di_codigo FROM si_dispositivo,
cobis..cc_oficial
WHERE di_oficial = oc_oficial)

go