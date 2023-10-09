-----------------------------------------------------------------------
-- ROLLBACK CATALOGO DE PREGUNTAS - FORMULARIO KYC - AUTO-ONBOARDING --
-----------------------------------------------------------------------
use cobis
go

declare 
@w_nom_tabla varchar(30)

select @w_nom_tabla = 'cl_preg_form_kyc_auto_onboard'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

go 
