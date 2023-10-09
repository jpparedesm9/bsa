-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cob_credito
go

IF OBJECT_ID ('cr_orden_eje_cuestionario') IS NOT NULL
	DROP TABLE cr_orden_eje_cuestionario
GO

create table cr_orden_eje_cuestionario (
    oe_tproducto varchar(10),
	oe_nemonico_regla varchar(10),
	oe_nombre_regla varchar(256),
	oe_orden int,
	oe_id_rol_wf int,
	oe_estado char(1),
	CONSTRAINT PK_cr_orden_eje_cuestionario PRIMARY KEY(oe_tproducto, oe_nemonico_regla, oe_orden)
)
--oe_id_rol_wf codigo de rol en la tabla cob_workflow..wf_rol
insert into cr_orden_eje_cuestionario values ('RENOVACION', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')
insert into cr_orden_eje_cuestionario values ('GRUPAL', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')
insert into cr_orden_eje_cuestionario values ('INDIVIDUAL', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')
insert into cr_orden_eje_cuestionario values ('REVOLVENTE', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')

insert into cr_orden_eje_cuestionario values ('RENOVACION', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
insert into cr_orden_eje_cuestionario values ('GRUPAL', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
insert into cr_orden_eje_cuestionario values ('INDIVIDUAL', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
insert into cr_orden_eje_cuestionario values ('REVOLVENTE', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cob_credito
go

IF OBJECT_ID ('cr_ej_regla_aplica_cuest') IS NOT NULL
	DROP TABLE cr_ej_regla_aplica_cuest
GO

create table cr_ej_regla_aplica_cuest (
    er_id_inst_proc    int,
    er_tramite         int,	
	er_cliente         int, --integrante(s) en la solicitud
	er_tproducto       varchar(20),	
	er_aplica          char(1),
	er_orden           int,
	er_login           login, -- rol workflow	
	er_rol_w           int, -- rol workflow
	er_nemonico_regla  char(10),
	er_fecha_evalua    datetime,
	er_valores_reglas  varchar(256),
	er_in_etapa        char(1),
	er_est_en_cred     char(1)
)

create index cr_ej_regla_aplica_cuest_key
    on cob_credito..cr_ej_regla_aplica_cuest (er_id_inst_proc, er_cliente, er_tproducto)
go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cobis
go

select * from cl_parametro where pa_nemonico = 'CDWCOO' and pa_producto = 'CRE'
delete cl_parametro where pa_nemonico = 'CDWCOO' and pa_producto = 'CRE'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Código para coordinador workflow', 'CDWCOO', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CRE')
go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
--CATALOGOS ACTIVIDADES CUESITONARIO
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_act_cuestionario'

select @w_id_tabla = codigo from cl_tabla where tabla = @w_tabla

if ( @w_id_tabla is null) begin
    select @w_id_tabla = max(codigo) + 1 from cl_tabla
	insert into cl_tabla (codigo, tabla, descripcion) values (@w_id_tabla, @w_tabla, 'Codigos de Actividades Cuestionarios por Producto')
	
	update cobis..cl_seqnos
	set siguiente = @w_id_tabla
	where tabla = 'cl_tabla'
	and bdatos = 'cobis'
end

select * from cl_tabla where codigo = @w_id_tabla
select * from cl_catalogo_pro where cp_tabla = @w_id_tabla
select * from cl_catalogo where tabla = @w_id_tabla

delete cl_catalogo_pro where cp_producto = 'ADM' and cp_tabla = @w_id_tabla
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('ADM', @w_id_tabla)

--select * from cob_workflow..wf_actividad where upper(ac_nombre_actividad) like '%CUESTIONAR%'
--Se agrega la descripcion porque es un valor que puede ser visualizado por pantalla.
--GRUPAL es tambien para RENOVACION ya que en la sincronizacion los dos son tratados igual.
delete cl_catalogo where tabla = @w_id_tabla
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'GRUPAL', 'APLICAR CUESTIONARIO - GRUPAL', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'INDIVIDUAL', 'APLICAR CUESTIONARIO - INDIVID', 'V', NULL, NULL, NULL)

go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cobis
go

select * from cl_errores where numero in (2101172)

delete from cl_errores where numero in (2101172)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (2101172, 1, 'No Existen etapa APLICAR CUESTIONARIO parametrizada')
go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cobis
go

select * from cl_errores where numero in (705080)

delete from cl_errores where numero in (705080)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (705080, 1, 'La regla no existe o no está en Producción')
go
