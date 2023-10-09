use cobis
go

/*************/
/*   TABLA cc_estado_cta  */
/*************/

delete cl_catalogo_pro
  from cl_tabla
where tabla  = 'cc_estado_cta'
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
where cl_tabla.tabla = 'cc_estado_cta'
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
where cl_tabla.tabla = 'cc_estado_cta'
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
where tabla = 'cl_tabla'



select @w_codigo= @w_codigo + 1
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_codigo, 'cc_estado_cta', 'Estado de Cuenta Corriente')

insert into cl_catalogo_pro values ('CTE', @w_codigo)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, 'A', 'ACTIVA', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, 'C', 'CERRADA', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, 'G', 'GERENCIA', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, 'I', 'INACTIVA', 'V')
GO

/*************/
/*   TABLA cc_tipo_indicador  */
/*************/

delete cl_catalogo_pro
  from cl_tabla
where tabla  = 'cc_tipo_indicador'
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
where cl_tabla.tabla = 'cc_tipo_indicador'
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
where cl_tabla.tabla = 'cc_tipo_indicador'
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
where tabla = 'cl_tabla'



select @w_codigo= @w_codigo + 1
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_codigo, 'cc_tipo_indicador', 'Tipo Indicador')

insert into cl_catalogo_pro values ('CTE', @w_codigo)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '0', 'OTROS', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1', 'EFECTIVO', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2', 'CHQ. PROPIO', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3', 'CHQ. LOCALES', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4', 'CHQ. OTRAS PLAZAS', 'V')
GO

/*************/
/*   TABLA cc_trn_causa_contb              */
/*************/

delete cl_catalogo_pro
  from cl_tabla
where tabla  = 'cc_trn_causa_contb'
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
where cl_tabla.tabla = 'cc_trn_causa_contb'
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
where cl_tabla.tabla = 'cc_trn_causa_contb'
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
where tabla = 'cl_tabla'



select @w_codigo= @w_codigo + 1
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_codigo, 'cc_trn_causa_contb', 'TRN Causa Contb')

insert into cl_catalogo_pro values ('CTE', @w_codigo)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '14', 'cc_causa_np', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '250', 'cc_estado_cta', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2505', 'cc_numcheques', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2507', 'cc_causa_np', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '253', 'ah_causa_nc', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '255', 'ah_causa_nc', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2556', 'cc_numcheques', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2563', 'cc_nemonico_op', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '257', 'ah_causa_nc_caja', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '259', 'ah_causa_nd', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '262', 'ah_causa_nd', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '264', 'ah_causa_nd', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '266', 'ah_causa_nd_caja', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2673', 'cc_causa_nc_caja', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2674', 'cc_causa_nd_caja', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2679', 're_tipo_impuesto_1', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2680', 're_tipo_impuesto_3', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2681', 're_tipo_impuesto_2', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2682', 're_tipo_impuesto_4', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2689', 're_tipo_impuesto_1', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2690', 're_tipo_impuesto_3', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2691', 're_tipo_impuesto_2', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2692', 're_tipo_impuesto_4', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2699', 'cc_tipo_garantia', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2706', 'pe_tipo_ente', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2727', 'cc_fpago_convenios', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2734', 'cc_ins_boveda', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2735', 'cc_ins_boveda_rec', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2752', 'cc_fpago_convenios', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2753', 'cc_tipo_garantia', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2756', 'cc_tipo_garantia', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2758', 'cc_tipo_garantia', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2766', 'cc_fpago_convenios', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2770', 'cc_fpago_convenios', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2772', 'cc_fpago_convenios', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2792', 're_tipo_impuesto_5', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2908', 'cc_causa_oioe', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '32', 'cc_causa_oioe', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '329', 'ah_causa_nd', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '37', 'cc_numcheques', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '401', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '402', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '403', 're_codigo_contable', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '404', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '405', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '406', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '407', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '408', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '409', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '410', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '48', 'cc_causa_nc', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '482', 'cc_causa_faltante', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '483', 'cc_causa_sobrante', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '50', 'cc_causa_nd', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '647', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '668', 're_codigo_contabl', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '691', 'cc_tipo_canje', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '86', 'cc_causa_oe', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '91', 'cc_concepto_emision', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '217', 'ah_causa_bloq_contb', 'V')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '218', 'ah_causa_desbloq_contb', 'V')
GO


/*************/
/*   TABLA cc_plazas_bco_rep              */
/*************/

delete cl_catalogo_pro
  from cl_tabla
where tabla  = 'cc_plazas_bco_rep'
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
where cl_tabla.tabla = 'cc_plazas_bco_rep'
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
where cl_tabla.tabla = 'cc_plazas_bco_rep'
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
where tabla = 'cl_tabla'



select @w_codigo= @w_codigo + 1
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_codigo, 'cc_plazas_bco_rep', 'Plazas Banco de la Republica')

insert into cl_catalogo_pro values ('CTE', @w_codigo)

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1000', 'CANJE DIRECTO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1240', 'MAGANGUE', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1352', 'APARTADO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1503', 'TUNJA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1507', 'DUITAMA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1516', 'SOGAMOSO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1530', 'CHIQUINQUIRA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1803', 'MANIZALES', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2000', 'CANJE DELEGADO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2401', 'AGUACHICA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2403', 'VALLEDUPAR', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2703', 'MONTERIA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3000', 'CANJE REPUBLICA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3164', 'LA DORADA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3303', 'QUIBDO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3603', 'RIOHACHA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3905', 'NEIVA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4209', 'CIENAGA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4210', 'SANTA MARTHA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4212', 'FUNDACION', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4501', 'VILLAVICENCIO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4801', 'PASTO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4806', 'IPIALES', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5101', 'CUCUTA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5120', 'OCANA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5401', 'ARMENIA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5703', 'PEREIRA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6020', 'BARRANCABERMEJA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6042', 'SAN GIL', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6044', 'SOCORRO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6303', 'SINCELEJO', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6601', 'IBAGUE', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6635', 'ESPINAL', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6918', 'POPAYAN', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6950', 'SEVILLA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6955', 'TULUA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6963', 'BUENAVENTURA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '7103', 'LETICIA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '7303', 'ARAUCA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '7503', 'FLORENCIA', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '8103', 'SAN ANDRES', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '8603', 'YOPAL', 'V')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '9000', 'NACIONAL CEDEC', 'V')
GO

use cobis
go
print 'Script de remediacion bug 75339'
declare @tabla int
/*********************************/
/*   TABLA re_estado_servicio    */
/*********************************/
print 'Catálogo re_estado_servicio'
if exists(select 1 from cobis..cl_tabla where tabla = 're_estado_servicio')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 're_estado_servicio'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 're_estado_servicio', 'Estado Servicio')
insert into cobis..cl_catalogo values (@tabla, 'H', 'HABILITADO', 'V', null,null,null)
insert into cobis..cl_catalogo values (@tabla, 'N', 'NO HABILITADO', 'V', null,null,null)

/*********************************/
/*   TABLA cl_sectoreco          */
/*********************************/
print 'Catálogo cl_sectoreco'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_sectoreco')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_sectoreco'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_sectoreco', 'Sector Economico')
insert into cl_catalogo values(@tabla, '10','FALTA SECTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '90','OTRAS CLASIFICACIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '112','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '114','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '115','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '126','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '127','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '128','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '130','AGRICULTURA GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '220','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '230','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '10000','AGRICULTURA, GANADERIA, SILVICULTURA Y PESCA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '20000','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '30000','PESCA MARITIMA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '50000','EXTRACCION DE CARBON DE PIEDRA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '60000','EXTRACCION DE PETROLEO CRUDO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '70000','EXTRACCION DE MINERALES METALIFEROS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '80000','EXPLOTACION DE OTRAS MINAS Y CANTERAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '90000','ACTIVIDADES DE SERVICIO DE APOYO PARA LA EXPLOTACION DE MIN', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '100000','ELABORACION DE PRODUCCION ALIMENTICIOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '110000','ELABORACION DE BEBIDAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '120000','ELABORACION DE PRODUCTOS DE TABACO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '130000','FABRICACION DE PRODUCTOS TEXTILES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '140000','FABRICACION DE PRENDAS DE VESTIR, EXEPTO PRENDAS DE PIEL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '150000','FABRICACION DE PRODUCTOS DE CUERO Y PRODUCTOS CONEXOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '160000','PRODUCCION DE MADERA Y FABRICACION DE PRODUCTOS DE MADERA Y', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '170000','FABRICACION DE PAPEL Y DE PRODUCTOS DE PAPEL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '180000','IMPRESION Y REPRODUCCION DE  GRABACIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '190000','FABRICACION DE COQUE Y PRODUCTOS DE LA REFINACION DE PETROL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '200000','FABRICACION DE SUSTANCIAS Y PRODUCTOS QUIMICOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '210000','FABRICACION DE PRODUCTOS FARMACEUTICOS, SUSTANCIAS QUIMICAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '220000','FABRICACION DE PRODUCTOS DE CAUCHO Y DE PLASTICO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '230000','FABRICACION DE OTROS PRODUCTOS MINERALES NO METALICOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '240000','FABRICACION DE METALES COMUNES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '250000','FABRICACION DE PRODUCTOS ELABORADOS DE METAL, EXEPTOMAQUINA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '260000','FABRICACION DE PRODUCTOS DE INFORMATICA, DE ELECTRONICA Y D', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '270000','FABRICACION DE EQUIPO ELECTRICO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '280000','FABRICACION DE MAQUINARIA Y EQUIPO N.C.P', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '290000','FABRICACION DE VEHICULOS AUTOMOTORES, REMOLQUES Y SEMIRREMO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '300000','FABRICACION DE OTRO EQUIPO DE TRASNPORTE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '310000','FABRICACION DE MUEBLES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '320000','OTRAS INDUSTRIAS MANUFACTURERAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '350000','SUMINISTRO DE ELECTRICIDAD, GAS, VAPOR Y AIRE ACONDICIONADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '360000','CAPTACION, TRATAMIENTO Y DISTRIBUCION DE AGUA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '380000','RECOGIDA, TRATAMIENTOS Y ELIMINACION DE DESECHOS,RECUPERACI', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '410000','CONSTRUCCION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '420000','OBRAS DE INGENIERIA CIVIL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '430000','ACTIVIDADES ESPECIALIZADAS DE CONSTRUCCION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '450000','COMERCIO AL POR MAYOR Y AL POR MENOR Y REPARACION DE VEHICU', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '460000','COMERCIO AL POR MAYOR, EXEPTO EL DE VEHICULOS AUTOMOTORES Y', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '470000','COMERCIO AL POR MAYOR NO ESPECIALIZADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '490000','TRANSPORTE Y ALMACENAMIENTO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '500000','TRANSPORTE POR VIA ACUATICA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '510000','TRANSPORTE POR VIA AEREA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '520000','ALMACENAMIENTO Y ACTIVIDADES DE APOYO AL TRANSPORTE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '530000','ACTIVIDADES POSTALES Y DE MENSAJERIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '550000','ACTIVIDADES DE ALOJAMIENTO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '560000','ACTIVIDADES DE SERVICIO DE COMIDAS Y BEBIDAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '590000','ACTIVIDADES DE PRODUCCION DE PELICULAS CINEMATOGRAFIAS, VID', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '600000','ACTIVIDADES DE PROGRAMACION Y TRANSMISION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '610000','TELECOMUNICACIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '630000','ACTIVIDADES DE SERVICIOS DE INFORMACION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '640000','ACTIVIDADES DE SERVICIOS FINANCIEROS, EXEPTO LAS DE SEGUROS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '650000','SEGUROS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '660000','ACTIVIDADES AUXILIARES DE LAS ACTIVIDADES DE SERVICIOS FINA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '680000','ACTIVIDADES INMOBILIARIAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '690000','ACTIVIDADES PROFESIONALES, CIENTIFICAS Y TECNICAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '700000','ACTIVIDADES DE OFICINAS PRINCIPALES; ACTIVIDADES DE CONSULT', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '710000','ACTIVIDADES DE ARQUITECTURA E INGENIERIA; ENSAYOS Y ANALISI', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '730000','PUBLICIDAD Y ESTUDIOS DE MERCADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '740000','OTRAS ACTIVIDADES PROFESIONALES, CIENTIFICAS Y TECNICAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '750000','ACTIVIDADES VETERINARIAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '770000','ACTIVIDADES DE ALQUILER Y ARRENDAMIENTO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '780000','ACTIVIDADES DE EMPLEO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '790000','ACTIVIDADES DE AGENCIAS DE VIAJES Y OPERADORES TURISTICOS Y', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '800000','ACTIVIDADES DE SEGURIDAD E INVESTIGACION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '810000','ACTIVIDADES DE SERVICIOS A EDIFICIOS Y DE PAISAJISMO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '820000','ACTIVIDADES ADMINISTRATIVAS Y DE APOYO DE OFICINA Y OTRAS A', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '840000','ADMINISTRACION PUBLICA Y DEFENSA; PLANES DE SEGURIDAD SOCIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '850000','ENSENAZA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '860000','ACTIVIDADES DE ATENCION DE LA SALUD HUMANA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '870000','ACTIVIDADES DE ATENCION EN INSTITUCIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '880000','ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '900000','ACTIVIDADES CREATIVAS, ARTISTICAS Y DE ENTRETENIMIENTO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '910000','ACTIVIDADES DE BIBLIOTECAS, ARCHIVOS Y MUSEOS Y OTRAS ACTIV', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '920000','ACTIVIDADES DE JUEGOS DE AZAR Y APUESTAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '930000','ACTIVIDADES DEPORTIVAS, DE ESPARCIMIENTO Y RECREATIVAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '940000','ACTIVIDADES DE ASOCIACIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '950000','REPARACION DE ORDENADORES Y DE EFECTOS PERSONALES Y ENSERES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '960000','OTRAS ACTIVIDADES DE SERVICIOS PERSONALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '970000','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE PERSONAL DOM', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '990000','ACTIVIDADESDE ORGANIZACIONES Y ORGANOS EXTRATERRITORIALES', 'V', null, null, null)

/*********************************/
/*   TABLA cl_relacion_banco     */
/*********************************/
print 'Catálogo cl_relacion_banco'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_relacion_banco')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_relacion_banco'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_relacion_banco', 'Relacion con la Institucion')
insert into cl_catalogo values(@tabla, '001','CLIENTE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '002','EMPLEADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '003','FILIAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '004','EX-EMPLEADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '005','PENSIONADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '006','PROVEEDOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '007','ACCIONISTA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '008','MIEMBRO JUNTA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '009','ASESOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '010','PLANIFICADOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011','ABOGADO EXTERNO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012','AVALUADOR', 'V', null, null, null)

/*********************************/
/*   TABLA cl_tipo_productor     */
/*********************************/
print 'Catálogo cl_tipo_productor'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_tipo_productor')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_tipo_productor'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_tipo_productor', 'Tipos de Productor')
insert into cl_catalogo values(@tabla, '000','NO ES USUARIO DE CREDITO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001','MICROEMPRESARIO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '002','OLA INVERNAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '003','GRAN PRODUCTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '004','MEDIANO PRODUCTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '005','PEQUEÐO PRODUCTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '006','ASOC Y ALIANZAS MEDIANO PRODUCTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '007','REINSERTADOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '008','MUJER RURAL DE BAJOS INGRESOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '009','DESPLAZADOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '010','FUNCIONARIOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011','ASOC Y ALIANZAS - PEQUEÐO PRODUCTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012','FAMILIAS EN ACCION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '013','MICROEMPRESARIO FINAGRO', 'V', null, null, null)

/*********************************/
/*   TABLA cl_nat_jur            */
/*********************************/
print 'Catálogo cl_nat_jur'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_nat_jur')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_nat_jur'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_nat_jur', 'Tipo de Nat.Juridica')
insert into cl_catalogo values(@tabla, 'OF','OFICIAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'PA','PARTICULAR', 'V', null, null, null)

/*********************************/
/*   TABLA cl_tip_soc          */
/*********************************/
print 'Catálogo cl_tip_soc'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_tip_soc')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_tip_soc'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_tip_soc', 'Tipo de Sociedades')	
insert into cl_catalogo values(@tabla, '000','FALTA TIPO DE SOCIEDAD', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001','CUENTAS DE PARTICIPACION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '002','ENTIDAD SIN ANIMO DE LUCRO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '003','OFICIAL DE ORDEN DEPARTAMENTAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '004','OFICIAL DE ORDEN MUNICIPAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '005','OFICIAL DE ORDEN NACIONAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '006','OFICIAL DE SEGURIDAD SOCIAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '007','OFICIAL EMPRESA INDUSTRIAL Y COMERCIAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '008','OFICIAL FINANCIERA NACIONAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '009','SOCIEDAD ANONIMA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '010','SOCIEDAD CENTRALIZADA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011','SOCIEDAD COLECTIVA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012','SOCIEDAD COOPERATIVA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '013','SOCIEDAD DE ECONOMIA MIXTA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014','SOCIEDAD DE ESTABLECIMIENTO PUBLICO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '015','SOCIEDAD DE RESPONSABILIDAD LIMITADA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '016','SOCIEDAD EN COMANDITA POR ACCIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '017','SOCIEDAD EN COMANDITA SIMPLE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '018','SOCIEDAD EXTRANJERA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '019','SOCIEDAD MERCANTIL DE HECHO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '020','SOCIEDAD POR ACCIONES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '021','SOCIEDADES DE FAMILIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '022','NO APLICA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '023','SOCIEDAD PRIVADA NACIONAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '024','SOCIEDAD MULTINACIONAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '025','ENTIDAD PUBLICA EXTRANJERA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '026','SOCIEDAD POR ACCIONES SIMPLIFICADAS', 'V', null, null, null)

/*********************************/
/*   TABLA cl_situacion_cliente          */
/*********************************/
print 'Catálogo cl_situacion_cliente'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_situacion_cliente')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_situacion_cliente'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_situacion_cliente', 'Situacion del Cliente')
insert into cl_catalogo values(@tabla, 'ACE','ACUERDO PRIVADO DE REESTRUCTURACION', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'ACP','ACUERDO DE PAGOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'ACU','ACUERDO DE ACREEDORES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'CAS','CASTIGADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'CIR','CIRCULAR 039', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'CON','CONCORDATO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'ENT','LEY 358/97 ENDEUDAMIENTO TERRITORIAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'FDO','FALLECIDO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'LEY','LEY 550', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'LIQ','LIQUIDACION OBLIGATORIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'LYS','LEY 617', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'NOA','LEY 715/01 APLICACIAN DE LOS RECURSOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'NOR','NORMAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'PCT','DECRETO 2540/01 CREDITOS ENTID.TERRITORIALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, 'VEN','LEY 50', 'V', null, null, null)

/*********************************/
/*   TABLA cl_tipo_cliente          */
/*********************************/
print 'Catálogo cl_tipo_cliente'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_tipo_cliente')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_tipo_cliente'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_tipo_cliente', 'Tipo de cliente')
insert into cl_catalogo values(@tabla, '001','TITULAR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '002','APODERADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '003','REPRESENTANTE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '004','TUTOR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '005','CORRESPONSAL BANCARIO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '006','CORRESPONSAL BANCARIO RED POSICIONADA', 'V', null, null, null)

/*********************************/
/*   TABLA cl_actividad          */
/*********************************/
print 'Catálogo cl_actividad'	
if exists(select 1 from cobis..cl_tabla where tabla = 'cl_actividad')
begin
	select @tabla = codigo from cobis..cl_tabla where tabla = 'cl_actividad'
	delete cobis..cl_tabla where codigo = @tabla
	delete cobis..cl_catalogo where tabla = @tabla
end

select @tabla = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@tabla, 'cl_actividad', 'ACTIVIDAD')
insert into cl_catalogo values(@tabla, '001000','ASALARIADOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001001','EMPLEADO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001002','AMA DE CASA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001003','ESTUDIANTE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001004','PERSONA NATURAL SUBSIDIADA POR TERCEROS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '001005','SIN ACTIVIDAD ECONOMICA SOLO PARA PERSONAS NATURALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '009000','UTILIDADES Y EN GENERAL, TODO CUANTO REPRESENTWE RENDIMIENT', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011100','CULTIVO DE CEREALES (EXCEPTO ARROZ), LEGUMBRES Y SEMILLAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011200','CULTIVO DE ARROZ', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011300','CULTIVO DE HORTALIZAS, RAICES Y TUBERCULOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011400','CULTIVO DE TABACO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011500','CULTIVO DE PLANTAS TEXTILES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '011900','OTROS CULTIVOS TRANSITORIOS NCP', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012100','CULTIVO DE FRUTAS TROPICALES Y SUBTROPICALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012200','CULTIVO DE PLATANO Y BANANO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012300','CULTIVO DE CAFE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012400','CULTIVO DE CANA DE AZUCAR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012500','FLORICULTURA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012600','CULTIVO DE PALMA PARA ACEITE OTROS FRUTOS OPOLEAGINOSOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012700','CULTIVO DE PLANTAS CON LAS QUE SE PREPARAN BEBIDAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012800','CULTIVO DE ESPECIAS Y DE PLANTAS AROMATICAS Y MEDICINALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '012900','OTROS CULTIVOS PERMANENTES n.c.p', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '013000','PROPAGACION DE PLANTAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014100','CRIA DE GANADO BOVINO Y BUFALINO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014200','CRIA DE CABALLOS Y OTROS EQUINOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014300','CRIA DE OVEJAS Y CABRAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014400','CRIA DE GANADO PORCINO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014500','CRIA DE AVES DE CORRAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014900','CRIA DE OTROS ANIMALES NCP', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014901','APICULTURA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '014902','CUNICULTURA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '015000','EXPLOTACION MIXTA (AGRICOLA Y PECUARIA)', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '016100','ACTIVIDADES DE APOYO A LA AGRICULTURA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '017000','CAZA ORDINARIA Y MEDIANTE TRAMPAS Y ACTIVIDADES DE SERVICI', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '021000','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '022000','EXTRACCION DE MADERA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '023000','RECOLECCION DE PRODUCTOS FORESTALES DIFERENTES A LA MADERA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '031100','PESCA MARITIMA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '031200','PESCA DE AGUA DULCE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '051000','EXTRACCION DE HULLA (CARBON DE PIEDRA), Y TURBA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '052000','EXTRACCION Y AGLOMERACION DE CARBON LIGNITICO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '061000','EXTRACCION DE PETROLEO CRUDO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '062000','EXTRACCION DE GAS NATURAL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '071000','EXTRACCION DE MINERALES DE HIERRO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '072100','EXTRACCION DE MINERALES DE URANIO Y DE TORIO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '072200','EXTRACCION DE ORO Y OTROS METALES PRECIOSOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '072300','EXTRACCION DE MINERALES DE NIQUEL', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '072900','EXTRACCION DE OTROS MINERALES METALIFEROS NO FERROSOS NCP', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '081100','EXTRACCION DE PIEDRA, ARENA, ARCILLAS COMUNES, YESO Y ANHI', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '081200','EXTRACCION DE ARCILLAS DE USO INDUSTRIAL, CALIZA, CAOLIN Y', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '082000','EXTRACCION DE ESMERALDAS, PIEDRAS PRECIOSAS Y SEMIPRECIOSA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '089100','EXTRACCION DE MINERALES PARA LA FABRICACION DE ABONOS Y PR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '089200','EXTRACCION DE HALITA (SAL)', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '089900','EXTRACCION DE OTROS MINERALES NO METALICOS NCP', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '099000','ACTIVIDADES DE APOYO PARA EXPLOTACION DE MINAS Y CANTERAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '101100','PROCESAMIENTO Y CONSERVACION DE CARNES Y EMBUTIDOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '101200','PROCESAMIENTO Y CONSERVACION DE PESCADOS, CRUSTACEOS Y MO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '102000','PROCESAMIENTO Y CONSERVACION DE FRUTAS, LEGUMBRES, HORTA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '102001','ELABORACION DE JUGOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '102002','PRODUCCION DE HELADOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '103000','ELABORACION DE ACEITES Y GRASAS DE ORIGEN VEGETAL Y ANIMA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '104000','ELABORACION DE PRODUCTOS LACTEOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '105100','ELABORACION DE PRODUCTOS DE MOLINERIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '105200','ELABORACION DE ALMIDONES Y DE PRODUCTOS DERIVADOS DEL ALM', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '106100','TRILLA DE CAFE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '106200','DESCAFEINADO TOSTION Y MOLIENDA DEL CAFE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '106300','OTROS DERIVADOS DEL CAFE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '107100','ELABORACION Y REFINACION DE AZUCAR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '107200','PRODUCCION DE PANELA Y DERIVADOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108100','PANADERIA Y PASTELERIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108101','INSUMOS DE PANADERIA Y PASTELERIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108200','ELABORACION DE CACAO Y CHOCOLATE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108201','PRODUCCION DE GELATINAS, DULCES Y GOLOSINAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108300','ELABORACION DE MACARRONES, FIDEOS, ALCUZCUZ Y PRODUCTOS F', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108900','ELABORACION DE OTROS PRODUCTOS ALIMENTICIOS NCP', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108901','PRODUCCION DE AREPAS, EMPANADAS, TAMALES, ENVUELTOS Y OTR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '108902','PRODUCCION DE ALMIENTOS CONGELADOS CONSERVAS Y CONDIMENTO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '109000','ELABORACION DE ALIMENTOS PREPARADOS PARA ANIMALES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '110100','DESTILACION, RECTIFICACION Y MEZCLA DE BEBIDAS ALCOHOLICA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '110200','ELABORACION DE BEBIDAS FERMENTADAS NO DESTILADAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '110300','PRODUCCION DE MALTA, ELABORACION DE CERVEZAS Y OTRAS BEBI', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '110400','ELABORACION DE BEBIDAS NO ALCOHOLICAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '120000','ELABORACION DE PRODUCTOS DE TABACO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '131100','PREPARACION E HILATURA DE FIBRAS TEXTILES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '131200','TEJEDURA DE PRODUCTOS TEXTILES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '131300','ACABADO DE PRODUCTOS TEXTILES', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '131301','CONFECCION DE ROPA PARA TERCEROS O SATELITE', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '131302','MODISTERIA - SASTRERIA', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '139100','FABRICACION DE TEJIDOS DE PUNTO Y GANCHILLO', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '139101','PRODUCCION DE OTROS TEJIDOS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '139200','CONFECCION CON MATERIALES TEXTILES (SIN PRENDAS DE VESTIR', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '139300','FABRICACION DE TAPICES Y/O ALFOMBRAS', 'V', null, null, null)
insert into cl_catalogo values(@tabla, '139400','FABRICACION DE CUERDAS, CORDELES, CABLES, BRAMANTES Y RED', '', null, null, null)
insert into cl_catalogo values(@tabla, '139900','FABRICACION DE OTROS ARTICULOS TEXTILES NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '139901','FABRICACION DE LENCERIA Y BORDADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '139902','FABRICACION DE ARTICULOS PARA MASCOTAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '141000','CONFECCION DE PRENDAS DE VESTIR, EXCEPTO PRENDAS DE PIEL', '', null, null, null)
insert into cl_catalogo values(@tabla, '141001','PRODUCCION PRENDAS INDUSTRIALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '141002','CONFECCION LINEA PROPIA DE ROPA EN GENERAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '151100','CURTIDO DE CUEROS Y TENIDO DE PIELES', '', null, null, null)
insert into cl_catalogo values(@tabla, '151300','FABRICACION DE ARTICULOS DE VIAJE, BOLSOS DE MANO, Y ARTI', '', null, null, null)
insert into cl_catalogo values(@tabla, '151301','PRODUCCION DE ARTICULOS EN CUERO Y MARROQUINERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '152100','FABRICACION DE CALZADO DE CUERO Y PIEL', '', null, null, null)
insert into cl_catalogo values(@tabla, '152200','FABRICA DE CALZADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '152300','FABRICACION DE PARTES DEL CALZADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '161000','ASERRADO, ACEPILLADO E IMPREGNACION DE LA MADERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '162000','FABRICACION HOJAS DE MADERA PARA ENCHAPADO Y TABLEROS PAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '163000','FABRICACION DE PARTES Y PIEZAS DE CARPINTERIA PARA CONSTR', '', null, null, null)
insert into cl_catalogo values(@tabla, '164000','FABRICACION DE RECIPIENTES DE MADERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '169000','PRODUCCION DE ARTESANIAS EN MADERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '170100','FABRICACION DE PASTAS CELULOSICAS; PAPEL Y CARTON', '', null, null, null)
insert into cl_catalogo values(@tabla, '170200','FABR. DE PAPEL Y CARTON ONDULADO, DE ENVASES, EMPAQUES Y', '', null, null, null)
insert into cl_catalogo values(@tabla, '170900','FABRICACION DE OTROS ARTICULOS DE PAPEL Y CARTON', '', null, null, null)
insert into cl_catalogo values(@tabla, '181100','ACTIVIDADES DE SERVICIOS RELACIONADAS CON LA IMPRESION', '', null, null, null)
insert into cl_catalogo values(@tabla, '181200','EDICION DE PERIODICOS, REVISTAS Y PUBLICACIONES PERIODICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '181201','OTROS TRABAJOS DE EDICION', '', null, null, null)
insert into cl_catalogo values(@tabla, '181202','PRODUCCION ARTICULOS ARTE BARROCO - SERVICIO DE ENCUADERN', '', null, null, null)
insert into cl_catalogo values(@tabla, '181203','PRODUCCION DE TARJETERIA - TIPOGRAFIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '182000','TALLER DE SERIGRAFIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '182001','PRODUCCION DE OBRAS ARTISTICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '191000','FABRICACION DE PRODUCTOS DE HORNOS DE COQUE', '', null, null, null)
insert into cl_catalogo values(@tabla, '192100','ELABORACION DE COMBUSTIBLE NUCLEAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '201100','FABRICACION DE SUSTANCIAS Y PROD. QUIMICOS BASICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '201200','FABRICACION DE ABONOS Y COMPUESTOS INORGANICOS NITROGENAD', '', null, null, null)
insert into cl_catalogo values(@tabla, '201300','FABRICACION DE FORMAS BASICAS DE PLASTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '201301','FABRICACION DE ARTICULOS DE PLASTICO NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '201400','FABRICACION DE CAUCHO', '', null, null, null)
insert into cl_catalogo values(@tabla, '202100','FABRICACION DE PLAGUICIDAS Y OTROS PRODUCTOS QUIMICOS DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '202101','PRODUCCION DE QUIMICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '202200','FABRICACION DE PINTURAS, BARNICES Y REVESTIMIENTOS SIMILA', '', null, null, null)
insert into cl_catalogo values(@tabla, '202300','FABRICACION DE JABONES Y DETERGENTES', '', null, null, null)
insert into cl_catalogo values(@tabla, '202301','PRODUCCION DE COSMETICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '202900','FABRICACION DE OTROS PRODUCTOS QUIMICOS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '203000','FABRICACION DE FIBRAS SINTETICAS Y ARTIFICIALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '210000','FABRICACION DE PRODUCTOS FARMACEUTICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '221100','FABRICACION DE LLANTAS Y NEUMATICOS DE CAUCHO', '', null, null, null)
insert into cl_catalogo values(@tabla, '221200','REENCAUCHE DE LLANTAS USADAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '221201','SERVICIO DE MONTALLANTAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '231000','FABRICACION DE VIDRIO Y DE PRODUCTOS DE VIDRIO', '', null, null, null)
insert into cl_catalogo values(@tabla, '239100','FABRICACION DE PRODUCTOS REFRACTARIOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '239200','FABRICACION DE PRODUCTOS DE ARCILLA PARA LA CONSTRUCCION', '', null, null, null)
insert into cl_catalogo values(@tabla, '239201','FABRICACION DE MATERIALES DE CONSTRUCCION', '', null, null, null)
insert into cl_catalogo values(@tabla, '239300','FABRICACION DE OTROS PRODUCTOS DE CERAMICA Y PORCELANA', '', null, null, null)
insert into cl_catalogo values(@tabla, '239301','PRODUCCION DE ARTESANIAS EN CERAMICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '239400','FABRICACION DE CEMENTO, CAL Y YESO', '', null, null, null)
insert into cl_catalogo values(@tabla, '239500','FABRICACION DE ARTICULOS DE HORMIGON, CEMENTO Y YESO', '', null, null, null)
insert into cl_catalogo values(@tabla, '239600','CORTE, TALLADO Y ACABADO DE LA PIEDRA', '', null, null, null)
insert into cl_catalogo values(@tabla, '239900','FABRICACION DE OTROS PRODUCTOS MINERALES NO METALICOS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '241000','INDUSTRIAS BASICAS DE HIERRO Y DE ACERO', '', null, null, null)
insert into cl_catalogo values(@tabla, '242100','INDUSTRIAS BASICAS DE METALES PRECIOSOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '242900','INDUSTRIAS BASICAS DE OTROS METALES NO FERROSOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '243100','FUNDICION DE HIERRO Y DE ACERO', '', null, null, null)
insert into cl_catalogo values(@tabla, '243200','FUNDICION DE METALES NO FERROSOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '251100','FABRICACION DE PRODUCTOS METALICOS PARA USO ESTRUCTURAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '251200','FABRICACION DE TANQUES, DEPOSITOS Y RECIPIENTES DE METAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '251300','FABRICACION DE GENERADORES DE VAPOR, EXCEPTO CALDERAS DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '252000','FABRICACION DE ARMAS Y MUNICIONES', '', null, null, null)
insert into cl_catalogo values(@tabla, '259100','FORJA, PRENSADO, ESTAMPADO Y LAMINADO DE METAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '259200','TRATAMIENTO Y REVESTIMIENTO DE METALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '259201','TALLER DE MECANICA AUTOMOTRIZ - LATONERIA Y PINTURA', '', null, null, null)
insert into cl_catalogo values(@tabla, '259202','ORNAMENTACION METALMECANICA Y CERRAJERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '259300','FABRICACION DE ARTICULOS DE CUCHILLERIA, HERRAMIENTAS DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '259900','FABRICACION DE OTROS PRODUCTOS ELABORADOS DE METAL NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '259901','METALMECANICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '263000','FABRICACION DE EQUIPOS DE COMUNICACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '264000','FABRICACION DE APARATOS ELECTRONICOS DE CONSUMO', '', null, null, null)
insert into cl_catalogo values(@tabla, '265200','FABRICACION DE RELOJES', '', null, null, null)
insert into cl_catalogo values(@tabla, '266000','FABRICACION DE EQUIPOS Y ARTICULOS MEDICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '266001','PRODUCCION IMPLEMENTOS ORTOPEDICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '267000','FABRICACION DE INSTRUMENTOS OPTICOS Y DE EQUIPO FOTOGRAFI', '', null, null, null)
insert into cl_catalogo values(@tabla, '267001','LABORATORIO OPTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '271200','FABRICACION DE APARATOS DE DISTRIBUCION Y CONTROL DE LA E', '', null, null, null)
insert into cl_catalogo values(@tabla, '272000','FABRICACION DE PILAS, BATERIAS Y ACUMULADORES ELECTRICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '273100','FABRICACION DE HILOS Y CABLES ELECTRICOS Y DE FIBRA OPTIC', '', null, null, null)
insert into cl_catalogo values(@tabla, '274000','FABRICACION DE LAMPARAS ELECTRICAS Y EQUIPO DE ILUMINACIO', '', null, null, null)
insert into cl_catalogo values(@tabla, '275000','FABRICACION DE APARATOS DE USO DOMESTICO NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '279000','FABRICACION DE MOTORES, GENERADORES Y TRANSFORMADORES ELE', '', null, null, null)
insert into cl_catalogo values(@tabla, '279001','PRODUCCION DE ARTEFACTOS ELECTRICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '281100','FABR. DE MOTORES Y TURBINAS, EXCEPTO MOTORES PARA AERONAV', '', null, null, null)
insert into cl_catalogo values(@tabla, '281300','FABRICACION DE BOMBAS, COMPRESORES, GRIFOS Y VALVULAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '281400','FABRICACION DE COJINETES, ENGRANAJES, TRENES DE ENGRANAJE', '', null, null, null)
insert into cl_catalogo values(@tabla, '281500','FABRICACION DE HORNOS, HOGARES Y QUEMADORES INDUSTRIALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '281600','FABRICACION DE EQUIPO DE ELEVACION Y MANIPULACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '281700','FABRICACION DE MAQUINARIA DE OFICINA, CONTABILIDAD E INFO', '', null, null, null)
insert into cl_catalogo values(@tabla, '281900','FABRICACION DE OTROS TIPOS DE MAQUINARIA DE USO GENERAL N', '', null, null, null)
insert into cl_catalogo values(@tabla, '282100','FABRICACION DE MAQUINARIA AGROPECUARIA Y FORESTAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '282200','FABRICACION DE MAQUINAS HERRAMIENTA', '', null, null, null)
insert into cl_catalogo values(@tabla, '282300','FABRICACION DE MAQUINARIA PARA LA METALURGIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '282400','FABRICACION DE MAQUINARIA PARA LA EXPLOTACION DE MINAS Y', '', null, null, null)
insert into cl_catalogo values(@tabla, '282500','FABRICACION DE MAQUINARIA PARA LA ELABORACION DE ALIMENTO', '', null, null, null)
insert into cl_catalogo values(@tabla, '282600','FABRICACION DE MAQUINARIA PARA LA ELABORACION DE PRODUCTO', '', null, null, null)
insert into cl_catalogo values(@tabla, '282900','FABRICACION DE OTROS TIPOS DE MAQUINARIA DE USO ESPECIAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '291000','FABRICACION DE VEHICULOS AUTOMOTORES Y SUS MOTORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '292000','FABRICACION DE CARROCERIAS PARA VEHICULOS AUTOMOTORES (RE', '', null, null, null)
insert into cl_catalogo values(@tabla, '293000','FABR. DE PARTES, PIEZAS Y ACCESORIOS (AUTOPARTES) PARA VE', '', null, null, null)
insert into cl_catalogo values(@tabla, '293001','PRODUCCION REPUESTOS Y ACCESORIOS PARA AUTOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '301100','CONSTRUCCION BARCOS Y REPARACION DE ESTRUCTURAS FLOTANTES', '', null, null, null)
insert into cl_catalogo values(@tabla, '301200','CONSTRUCCION Y REPARACION DE EMBARCACIONES DE RECREO Y DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '302000','FABRICACION DE LOCOMOTORAS Y DE MATERIAL RODANTE PARA FER', '', null, null, null)
insert into cl_catalogo values(@tabla, '303000','FABRICACION DE AERONAVES Y DE NAVES ESPACIALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '309100','FABRICACION DE MOTOCICLETAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '309200','FABRICACION DE BICICLETAS Y DE SILLONES DE RUEDAS PARA DI', '', null, null, null)
insert into cl_catalogo values(@tabla, '309900','FABRICACION DE OTROS TIPOS DE EQUIPO DE TRANSPORTE NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '311000','FABRICACION DE MUEBLES PARA EL HOGAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '311001','PRODUCCION DE MUEBLES EN MADERA Y METALICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '311002','PRODUCCION COCINAS INTEGRALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '311003','FABRICACION DE MUEBLES PARA OFICINA', '', null, null, null)
insert into cl_catalogo values(@tabla, '312000','FABRICACION DE COLCHONES Y SOMIERES', '', null, null, null)
insert into cl_catalogo values(@tabla, '321000','FABRICACION DE JOYAS Y DE ARTICULOS CONEXOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '321001','TALLER DE JOYERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '322000','FABRICACION DE INSTRUMENTOS MUSICALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '323000','FABRICACION DE ARTICULOS Y EQUIPO PARA PRACTICA DE DEPORT', '', null, null, null)
insert into cl_catalogo values(@tabla, '324000','FABRICACION DE JUEGOS Y JUGUETES Y ROMPECABEZAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '329000','OTRAS INDUSTRIAS MANUFACTURERAS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '329001','PRODUCCION DE VELADORAS Y ARTICULOS RELIGIOSOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '351300','DISTRIBUCION DE ENERGIA ELECTRICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '352000','FABRICACION DE GAS Y DISTRIBUCION DE COMBUSTIBLES GASEOSO', '', null, null, null)
insert into cl_catalogo values(@tabla, '353000','SUMINISTRO DE VAPOR Y AIRE ACONDICIONADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '360000','CAPTACION, DEPURACION Y DISTRIBUCION DE AGUA', '', null, null, null)
insert into cl_catalogo values(@tabla, '381100','RECOLECCION DE DESECHOS NO PELIGROSOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '411100','CONSTRUCCION DE EDIFICIOS RESIDENCIALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '411101','SERVICIO REPARACIONES LOCATIVAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '411200','CONSTRUCCION DE EDIFICACIONES PARA USO NO RESIDENCIAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '429000','CONSTRUCCION DE OBRAS DE INGENIERIA CIVIL', '', null, null, null)
insert into cl_catalogo values(@tabla, '431100','DEMOLICION', '', null, null, null)
insert into cl_catalogo values(@tabla, '431200','PREPARACION DEL TERRENO', '', null, null, null)
insert into cl_catalogo values(@tabla, '432100','INSTALACIONES ELECTRICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '432900','OTRAS INSTALACIONES ESPECIALIZADAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '432901','INSTALACIONES HIDRAULICAS Y TRABAJOS CONEXOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '432902','TRABAJOS DE INSTALACION DE EQUIPOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '433000','TERMINACION Y ACABADO DE EDIFICIOS Y OBRAS DE INGENIERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '433001','VENTA E INSTALACION DE VIDRIOS - VIDRIERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '439000','OTRAS ACTIVIDADES ESPECIALIZADAS PARA LA CONSTRUCCION DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '439001','ALQUILER DE ANDAMIOS PARA CONSTRUCCION', '', null, null, null)
insert into cl_catalogo values(@tabla, '451100','COMERCIO DE VEHICULOS AUTOMOTORES NUEVOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '451200','COMERCIO DE VEHICULOS AUTOMOTORES USADOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '452000','TALLER DE MECANICA AUTOMOTRIZ', '', null, null, null)
insert into cl_catalogo values(@tabla, '452001','SERVICIO DE LAVADO DE AUTOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '453000','COMERCIO DE PARTES, PIEZAS (AUTOPARTES) Y ACCESORIOS (LUJ', '', null, null, null)
insert into cl_catalogo values(@tabla, '454200','COMERCIO, MANTENIMIENTO Y REPARACION DE MOTOCICLETAS Y DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '454201','VENTA DE REPUESTOS Y ACCESORIOS PARA MOTOCICLETA', '', null, null, null)
insert into cl_catalogo values(@tabla, '461000','COMERCIO AL POR MAYOR A CAMBIO DE UNA RETRIBUCION O POR C', '', null, null, null)
insert into cl_catalogo values(@tabla, '461001','VENTA DE PRODUCTOS AGRICOLAS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461002','VENTA DE PRODUCTOS PECUARIOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461003','VENTA DE HUEVOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461004','VENTA DE LENCERIA Y BORDADOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461005','VENTA ARTICULOS DE ASEO AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461006','VENTA DE PRODUCTOS DE CUERO Y MARROQUINERIA AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461007','VENTA DE ARTESANIAS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '461008','COMERCIO AL POR MAYOR DE CAFE PERGAMINO', '', null, null, null)
insert into cl_catalogo values(@tabla, '462000','COMERCIO AL POR MAYOR DE MATERIAS PRIMAS AGROPECUARIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '462001','VENTA DE POLLOS Y CERDOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '462002','COMPRA Y VENTA DE GANADO AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '463100','COMERCIO AL POR MAYOR DE PRODUCTOS ALIMENTICIOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '463101','VENTA DE CARNICOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '463102','VENTA DE DULCES, GOLOCINAS Y OTROS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '463103','VENTA DE HELADOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '463104','COMERCIO AL POR MAYOR DE CAFE TRILLADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '463200','COMERCIO AL POR MAYOR DE BEBIDAS Y TABACO', '', null, null, null)
insert into cl_catalogo values(@tabla, '463201','VENTA DE CIGARRILLOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '463202','VENTA DE CERVEZA AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '464100','COMERCIO AL POR MAYOR DE PRODUCTOS TEXTILES Y productos c', '', null, null, null)
insert into cl_catalogo values(@tabla, '464200','COMERCIO AL POR MAYOR DE PRENDAS DE VESTIR, ACCESORIOS DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '464300','COMERCIO AL POR MAYOR DE CALZADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '464400','COMERCIO AL POR MAYOR DE APARATOS Y EQUIPO DE USO DOMESTI', '', null, null, null)
insert into cl_catalogo values(@tabla, '464500','COMERCIO AL POR MAYOR DE PRODUCTOS FARMACEUTICOS, MEDICIN', '', null, null, null)
insert into cl_catalogo values(@tabla, '464501','VENTA COSMETICOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '464502','VENTA DE PRODUCTOS FARMACETTICOS AL POR MAYOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '464503','COMERCIO AL POR MAYOR DE EQUIPOS MEDICOS Y QUIRURGICOS Y', '', null, null, null)
insert into cl_catalogo values(@tabla, '465100','COMERCIO AL POR MAYOR DE COMPUTADORES EQUIPO PERIFERICO Y', '', null, null, null)
insert into cl_catalogo values(@tabla, '465300','COMERCIO AL POR MAYOR DE MAQUINARIA Y EQUIPO EQUIPO AGROP', '', null, null, null)
insert into cl_catalogo values(@tabla, '465900','COMERCIO AL POR MAYOR DE OTROS TIPOS DE MAQUINARIA Y EQUI', '', null, null, null)
insert into cl_catalogo values(@tabla, '466100','COMERCIO AL POR MAYOR DE COMBUSTIBLES SOLIDOS, LIQUIDOS,', '', null, null, null)
insert into cl_catalogo values(@tabla, '466200','COMERCIO AL POR MAYOR DE METALES Y PRODUCTOS METALIFEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '466300','COMERCIO AL POR MAYOR DE MATERIALES DE CONSTRUCCION, ARTI', '', null, null, null)
insert into cl_catalogo values(@tabla, '466400','COMERCIO AL POR MAYOR DE PRODUCTOS QUIMICOS BASICOS, CAUC', '', null, null, null)
insert into cl_catalogo values(@tabla, '466500','COMERCIO AL POR MAYOR DE DESPERDICIOS O DESECHOS Y CHATAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '466900','COMERCIO AL POR MAYOR DE OTROS PRODUCTOS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '466901','COMERCIO AL POR MAYOR DE FLORES Y PLANTAS ORNAMENTALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '469000','COMERCIO AL POR MAYOR DE FLORES Y PLANTAS ORNAMENTALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '471100','COMERCIO AL POR MENOR DE PRODUCTOS EN ESTABLECIMIENTOS N', '', null, null, null)
insert into cl_catalogo values(@tabla, '471101','VENTA DE ABARROTES, TIENDA, MINIMERCADO, SUPERMERCADO Y/O', '', null, null, null)
insert into cl_catalogo values(@tabla, '471900','COMERCIO AL POR MENOR, EN ESTABLECIMIENTOS NO ESPECIALIZA', '', null, null, null)
insert into cl_catalogo values(@tabla, '471901','VENTA DULCES Y GOLOSINAS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '471902','VENTA DE AREPAS, EMPANADAS, TAMALES, ENVUELTOS Y OTROS AL', '', null, null, null)
insert into cl_catalogo values(@tabla, '471903','CIGARRERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '471904','CAFETERIA Y PASTELERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '471905','CAFE INTERNET', '', null, null, null)
insert into cl_catalogo values(@tabla, '471907','CHARCUTERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '471908','COMIDAS RAPIDAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '471909','VENTA PRODUCTOS EN MADERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '471910','VENTA PRODUCTOS DE LIMPIEZA', '', null, null, null)
insert into cl_catalogo values(@tabla, '471911','VENTA. ACUARIOS-PECES', '', null, null, null)
insert into cl_catalogo values(@tabla, '471912','CHAZAS, VENTAS AMBULANTES', '', null, null, null)
insert into cl_catalogo values(@tabla, '471913','VENTA MISCELANEA EN GENERAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '471914','VENTA DE LANAS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '472200','COMERCIO AL POR MENOR DE PRODUCTOS AGRICOLAS PARA NEL CON', '', null, null, null)
insert into cl_catalogo values(@tabla, '472201','VENTA DE FRUTAS Y VERDURAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '472202','VENTA DE HIERBAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '472203','COMPRA Y VENTA DE CAFE', '', null, null, null)
insert into cl_catalogo values(@tabla, '472204','COMERCIO AL POR MENOR DE LECHE, PRODUCTOS LACTEOS Y HUEVO', '', null, null, null)
insert into cl_catalogo values(@tabla, '472300','COMERCIO AL POR MENOR DE CARNES (INCLUYE AVES DE CORRAL),', '', null, null, null)
insert into cl_catalogo values(@tabla, '472301','VENTA POLLO, AVICOLA AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '472302','VENTA PESCADOS CRUDOS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '472303','VENTA DE PRODUCTOS CARNICOS, CARNECERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '472304','SALSAMENTARIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '472400','COMERCIO AL POR MENOR DE BEBIDAS Y PRODUCTOS DEL TABACO E', '', null, null, null)
insert into cl_catalogo values(@tabla, '472401','BAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '472402','VENTA DE RANCHO Y LICORES AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '472403','DEPOSITO DE CERVEZA', '', null, null, null)
insert into cl_catalogo values(@tabla, '472900','COMERCIO AL POR MENOR DE OTROS PRODUCTOS ALIMENTICIOS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '472901','VENTA DE MATERIAS PRIMAS PARA COMESTIBLES', '', null, null, null)
insert into cl_catalogo values(@tabla, '473100','COMERCIO AL POR MENOR DE COMBUSTIBLE PARA AUTOMOTORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '473200','COMERCIO AL POR MENOR DE LUBRICANTES (ACEITES, GRASAS), A', '', null, null, null)
insert into cl_catalogo values(@tabla, '474100','VENTA DE MUEBLES DE OFICINA AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '474200','COMERCIO POR MENOR DE EQUIPOS Y APARATOS DE SONIDO Y DE V', '', null, null, null)
insert into cl_catalogo values(@tabla, '475100','COMERCIO AL POR MENOR DE PRODUCTOS TEXTILES EN ESTABLECIM', '', null, null, null)
insert into cl_catalogo values(@tabla, '475101','VENTA DE TEXTILES AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475102','VENTA DE ADORNOS, HILOS, BOTONES Y OTROS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475103','VENTA DE INSUMOS DE CONFECCION', '', null, null, null)
insert into cl_catalogo values(@tabla, '475200','VENTA PINTURAS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475201','FERRETERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475202','MARQUETERIA Y VIDRIERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475203','VENTA DE CRISTAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '475204','VENTA DE MARMOL', '', null, null, null)
insert into cl_catalogo values(@tabla, '475205','VENTA DE MADERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475206','VENTA DE ACERO', '', null, null, null)
insert into cl_catalogo values(@tabla, '475400','COMERCIO AL POR MENOR DE ELECTRODOMESTICOS EN ESTABLECIMI', '', null, null, null)
insert into cl_catalogo values(@tabla, '475500','COMERCIO AL POR MENOR DE MUEBLES PARA EL HOGAR EN ESTABLE', '', null, null, null)
insert into cl_catalogo values(@tabla, '475501','VENTA DE MUEBLES PARA EL HOGAR AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475502','VENTA DE ARTEFACTOS ELECTRICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475900','COMERCIO AL POR MENOR DE PRODUCTOS DIVERSOS NCP, EN ESTAB', '', null, null, null)
insert into cl_catalogo values(@tabla, '475901','VENTA DE CORTINAS Y/O ENCAJES', '', null, null, null)
insert into cl_catalogo values(@tabla, '475902','VENTA DE ARTICULOS Y OBRAS DE ARTE', '', null, null, null)
insert into cl_catalogo values(@tabla, '475903','VENTA DE CELULARES Y ACCESORIOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475904','VENTA DE COLCHONES, ESPUMAS Y/O ALMOHADAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475905','VENTA DE ARTICULOS DECORATIVOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475906','VENTA DE INSTRUMENTOS MUSICALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '475907','VENTA DE PRODUCTOS EN CERAMICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475908','VENTA DE ARTESANIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475909','VENTA DE ARTICULOS EN COBRE', '', null, null, null)
insert into cl_catalogo values(@tabla, '475910','VENTA DE MUSICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475911','VENTA DE CARPAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475912','VENTA. DE EXTINTORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '475913','VENTA DE JUGUETES Y JUEGOS DIDACTICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475914','VENTA DE CARBON', '', null, null, null)
insert into cl_catalogo values(@tabla, '475915','VENTA DE CONCENTRADOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475916','VENTA DE BICICLETAS Y ACCESORIOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475917','VENTA DE VISUTERIA Y JOYAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475918','VENTA DE GAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475919','VENTA DE PLANTAS ORNAMENTALES AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475920','VENTA DE ADORNOS - MISCELANEA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475921','VENTA DE ARTICULOS PARA PISCINA AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475922','VENTA DE PORDUCTOS DE LIMPIEZA AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475923','VENTA DE ARTICULOS DE ASEO AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475924','VENTA DE DESECHABLES', '', null, null, null)
insert into cl_catalogo values(@tabla, '475925','VENTA DE ARTICULOS DEPORTIVOS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475926','VENTA DE LOTERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475927','VENTA DE FLORES - FLORISTERIA AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '475928','VENTA DE JOYERIA Y RELOJERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '475929','VENTA DE ANIMALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '475930','VENTA DE AGROQUIMICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '475931','OPTICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '476100','COMERCIO AL POR MENOR DE LIBROS, PERIODICOS, MATERIALES Y', '', null, null, null)
insert into cl_catalogo values(@tabla, '476101','VENTA DE PERIODICOS Y REVISTAS AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '476102','LIBRERIA Y PAPELERIA AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '477100','VENTA DE ROPA EN GENERAL - ALMACEN', '', null, null, null)
insert into cl_catalogo values(@tabla, '477200','COMERCIO AL POR MENOR DE TODO TIPO DE CALZADO, ARTICULOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '477201','VENTA DE ARTICULOS EN CUERO Y MARROQUINERIA AL PRO MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '477202','VENTA DE CALZADO AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '477203','VENTA DE CALZADO DEPORTIVO AL POR MENOR', '', null, null, null)
insert into cl_catalogo values(@tabla, '477300','COMERCIO AL POR MENOR DE PRODUCTOS FARMACEUTICOS Y MEDICI', '', null, null, null)
insert into cl_catalogo values(@tabla, '477301','DROGUERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '477302','VENTA DE ARTICULOS ODONTOLOGICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '477303','VENTA DE PRODUCTOS NATURISTAS - TIENDA NATURISTA', '', null, null, null)
insert into cl_catalogo values(@tabla, '477304','VENTA DE PRODUCTOS ORTOPEDICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '477400','COMERCIO POR MENOR DE OTROS NUEVOS PRODUCTOS DE CONSUMO E', '', null, null, null)
insert into cl_catalogo values(@tabla, '477401','VENTA INSUMOS AGRICOLAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '477402','VENTA DE PLASTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '477403','VENTA ARTICULOS EN GENERAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '477500','COMERCIO AL POR MENOR DE ARTICULOS DE SEGUNDA MANO', '', null, null, null)
insert into cl_catalogo values(@tabla, '478900','COMERCIO AL POR MENOR DE OTROS PRODUCTOS EN PUESTOS DE VE', '', null, null, null)
insert into cl_catalogo values(@tabla, '478901','VENTA AMBULANTE DE ROPA Y OTROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '478902','VENTA DE TINTOS Y AROMATICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '478903','COMIDAS RAPIDAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '479200','ACTIVIDADES COMERCIALES DE LAS CASAS DE EMPENO O COMPRAVE', '', null, null, null)
insert into cl_catalogo values(@tabla, '479900','OTROS TIPOS DE COMERCIO AL POR MENOR NO REALIZADO EN ESTA', '', null, null, null)
insert into cl_catalogo values(@tabla, '479901','VENTAS POR CATALOGO', '', null, null, null)
insert into cl_catalogo values(@tabla, '479902','DISTRIBUCION PRODUCTOS A DOMICILIO', '', null, null, null)
insert into cl_catalogo values(@tabla, '491100','TRANSPORTE FERREO DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492100','TRANSPORTE DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492101','SERVICIO DE TAXI', '', null, null, null)
insert into cl_catalogo values(@tabla, '492102','TRANSPORTE PTBLICO Y ESCOLAR EN GENERAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '492103','TRANSPORTE INTERMUNICIPAL COLECTIVO REGULAR DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492104','TRANSPORTE INTERNACIONAL COLECTIVO REGULAR DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492105','TRANSPORTE NO REGULAR INDIVIDUAL DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492106','TRANSPORTE COLECTIVO NO REGULAR DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492107','OTROS TIPOS DE TRANSPORTE NO REGULAR DE PASAJEROS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '492300','TRASPORTE DE CARGA POR CARRETERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '492301','TRANSPORTE MUNICIPAL DE CARGA POR CARRETERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '492302','TRANSPORTE DE ALIMENTOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '492303','TRANSPORTE INTERMUNICIPAL DE CARGA POR CARRETERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '492304','SERVICIO TRANSPORTE DE CARGA', '', null, null, null)
insert into cl_catalogo values(@tabla, '492305','TRANSPORTE INTERNACIONAL DE CARGA POR CARRETERA', '', null, null, null)
insert into cl_catalogo values(@tabla, '493000','TRANSPORTE POR TUBERIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '501100','TRANSPORTE PASAJEROS MARITIMO Y DE CABOTAJE', '', null, null, null)
insert into cl_catalogo values(@tabla, '502100','TRANSPORTE FLUVIAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '511100','TRANSPORTE AEREO NACIONAL DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '511200','TRANSPORTE AEREO INTERNACIONAL DE PASAJEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '512100','TRANSPORTE AEREO NACIONAL DE CARGA', '', null, null, null)
insert into cl_catalogo values(@tabla, '512200','TRANSPORTE AEREO INTERNACIONAL DE CARGA', '', null, null, null)
insert into cl_catalogo values(@tabla, '521000','ALMACENAMIENTO Y DEPOSITO', '', null, null, null)
insert into cl_catalogo values(@tabla, '522100','ACTIVIDADES DE ESTACIONES DE TRANSPORTE TERRESTRE VIAS Y', '', null, null, null)
insert into cl_catalogo values(@tabla, '522200','ACTIVIDADES DE PUERTOS Y SERVICIOS COMPLEMENTARIOS PARA T', '', null, null, null)
insert into cl_catalogo values(@tabla, '522300','ACTIVIDADES DE AEROPUERTOS SERVICIOS DE NAVEGACION AEREA', '', null, null, null)
insert into cl_catalogo values(@tabla, '522400','MANIPULACION DE CARGA', '', null, null, null)
insert into cl_catalogo values(@tabla, '522900','OTRAS ACTIVIDADES COMPLEMENTARIAS DEL TRANSPORTE', '', null, null, null)
insert into cl_catalogo values(@tabla, '531000','ACTIVIDADES POSTALES NACIONALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '532000','ACTIVIDADES DE MENSAJERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '551100','ALOJAMIENTO EN HOTELES', '', null, null, null)
insert into cl_catalogo values(@tabla, '551200','SERVICIO DE ALOJAMIENTO EN APARTAHOTELES', '', null, null, null)
insert into cl_catalogo values(@tabla, '551201','ALOJAMIENTO EN RESIDENCIAS ESTUDIANTILES', '', null, null, null)
insert into cl_catalogo values(@tabla, '551300','ALOJAMIENTO EN CENTROS VACACIONALES Y ZONAS DE CAMPING', '', null, null, null)
insert into cl_catalogo values(@tabla, '551900','OTROS TIPOS DE ALOJAMIENTO PARA VISITANTES', '', null, null, null)
insert into cl_catalogo values(@tabla, '561100','EXPENDIO A LA MESA DE COMIDAS PREPARADAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '561101','RESTAURANTE', '', null, null, null)
insert into cl_catalogo values(@tabla, '561102','ASADERO', '', null, null, null)
insert into cl_catalogo values(@tabla, '561200','EXPENDIO, POR AUTOSERVICIO, DE COMIDAS PREPARADAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '561201','EXPENDIO, POR AUTOSERVICIO, DE COMIDAS PREPARADAS EN CAFE', '', null, null, null)
insert into cl_catalogo values(@tabla, '561300','EXPENDIO, A LA MESA, DE COMIDAS PREPARADAS EN CAFETERIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '562900','ACTIVIDADES DE OTROS SERVICIOS DE COMIDAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '562901','VENTA DE FRITANGA', '', null, null, null)
insert into cl_catalogo values(@tabla, '562902','VENTA DE HELADOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '562903','PIZZERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '562904','SERVICIO CASA DE BANQUETES', '', null, null, null)
insert into cl_catalogo values(@tabla, '563000','EXPENDIO DE BEBIDAS ALCOHOLICAS PARA EL CONSUMO DENTRO DE', '', null, null, null)
insert into cl_catalogo values(@tabla, '591400','PRODUCCION Y DISTRIBUCION DE FILMES Y VIDEOCINTAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '591401','SERVICIO TIENDA DE VIDEO', '', null, null, null)
insert into cl_catalogo values(@tabla, '601000','SERVICIOS DE TRANSMISION POR CABLE', '', null, null, null)
insert into cl_catalogo values(@tabla, '602000','ACTIVIDADES DE PROGRAMACION Y TRANSMISION DE TELEVISION', '', null, null, null)
insert into cl_catalogo values(@tabla, '611000','ACTIVIDADES DE TELECOMUNICACIONES ALAMBRICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '611001','SERVICIO TELEFONICO Y MANTENIMIENTO', '', null, null, null)
insert into cl_catalogo values(@tabla, '619000','OTRAS ACTIVIDADES DE TELECOMUNICACIONES', '', null, null, null)
insert into cl_catalogo values(@tabla, '631100','PROCESAMIENTO DE DATOS ALOJAMIENTO (HOSTING) Y ACTIVIDADE', '', null, null, null)
insert into cl_catalogo values(@tabla, '639100','ACTIVIDADES DE AGENCIAS DE NOTICIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '641100','BANCA CENTRAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '642200','ACTIVIDADES DE LAS CORPORACIONES DE AHORRO Y VIVIENDA', '', null, null, null)
insert into cl_catalogo values(@tabla, '642400','ACTIVIDADES DE LAS COOPERATIVAS FINANCIERAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '643100','FIDEICOMISOS FONDOS Y ENTIDADES FINANCIERAS SIMILARES', '', null, null, null)
insert into cl_catalogo values(@tabla, '643200','FONDOS DE CESANTIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '649100','ARRENDAMIENTO FINANCIERO (LEASING)', '', null, null, null)
insert into cl_catalogo values(@tabla, '649200','ACTIVIDADES FINANCIERAS DE FONDOS DE EMPLEADOS Y OTRAS FO', '', null, null, null)
insert into cl_catalogo values(@tabla, '649900','ACTIVIDADES DE LAS SOCIEDADES DE CAPITALIZACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '651100','SEGUROS GENERALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '651200','SEGUROS DE VIDA', '', null, null, null)
insert into cl_catalogo values(@tabla, '651300','REASEGUROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '661100','ADMINISTRACION DE MERCADOS FINANCIEROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '661300','OTRAS ACTIVIDADES RELACIONADAS CON EL MERCADO DE VALORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '661400','ACTIVIDADES DE LAS CASAS DE CAMBIO', '', null, null, null)
insert into cl_catalogo values(@tabla, '662100','ACTIVIDADES DE AGENTES Y CORREDORES DE SEGUROS', '', null, null, null)
insert into cl_catalogo values(@tabla, '681000','ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O', '', null, null, null)
insert into cl_catalogo values(@tabla, '682000','ACTIVIDADES INMOBILIARIAS REALIZADAS A CAMBIO DE UNA RETR', '', null, null, null)
insert into cl_catalogo values(@tabla, '691000','ACTIVIDADES JURIDICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '692000','SERVICIO ASESORIAS CONTABLES', '', null, null, null)
insert into cl_catalogo values(@tabla, '702000','ACTIVIDADES DE CONSULTORIAS DE GESTIOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '702001','ASESORIA TALENTO HUMANO', '', null, null, null)
insert into cl_catalogo values(@tabla, '702002','SERVICIO ASESORIAS. AGROPECUARIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '702003','SERVICIO CONSULTORIA EMPRESARIAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '711000','ACTIVIDADES DE ARQUITECTURA E INGENIERIA Y ACTIVIDADES CO', '', null, null, null)
insert into cl_catalogo values(@tabla, '712000','ENSAYOS Y ANALISIS TECNICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '731000','SERVICIO PUBLICIDAD', '', null, null, null)
insert into cl_catalogo values(@tabla, '732000','INVESTIGACION DE MERCADOS Y REALIZACION DE ENCUESTAS DE O', '', null, null, null)
insert into cl_catalogo values(@tabla, '742000','ACTIVIDADES DE FOTOGRAFIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '749000','OTRASACTIVIDADES PROFESIONALES CIENTIFICAS Y TECNICAS N C P', '', null, null, null)
insert into cl_catalogo values(@tabla, '750000','ACTIVIDADES VETERINARIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '771000','ALQUILER Y ARRENDAMIENTO DE VEHICULOS AUTOMOTORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '772100','ALQUILER ARRENDANMIENTO DE EQUIPO RECREATIVO Y DEPORTIVO', '', null, null, null)
insert into cl_catalogo values(@tabla, '772900','ALQUILER DE EFECTOS PERSONALES Y ENSERES DOMESTICOS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '772901','ALQUILER DE LAVADORAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '773000','ALQUILER DE MAQUINARIA Y EQUIPO EN GENERAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '781000','ACTIVIDADES DE AGENCIAS DE EMPLEO', '', null, null, null)
insert into cl_catalogo values(@tabla, '791100','ACTIVIDADES DE AGENCIAS DE VIAJES', '', null, null, null)
insert into cl_catalogo values(@tabla, '791101','ACTIVIDAD DE TURISMO', '', null, null, null)
insert into cl_catalogo values(@tabla, '791102','SERVICIO DE RECREACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '791103','AGENCIA DE VIAJES', '', null, null, null)
insert into cl_catalogo values(@tabla, '801000','ACTIVIDADES DE SEGURIDAD PRIVADA', '', null, null, null)
insert into cl_catalogo values(@tabla, '811000','ACTIVIDADES COMBINADAS DE APOYO A INSTALACIONES', '', null, null, null)
insert into cl_catalogo values(@tabla, '812100','LIMPIEZA GENERAL INTERIOR DE EDIFICIOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '812900','OTRAS ACTIVIDADES DE LIMPIEZA DE EDIFICIOS E INSTALACIONE', '', null, null, null)
insert into cl_catalogo values(@tabla, '813000','ACTIVIDADES DE PAISAJISMO Y SERVICIOS DE MANTENIMIENTO CONEXOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '821900','FOTOCOPIADO PREPARACION DE DOCUMENTOS Y OTRAS ACTIVIDADES ESPECI', '', null, null, null)
insert into cl_catalogo values(@tabla, '829200','ACTIVIDADES DE ENVASE Y EMPAQUE', '', null, null, null)
insert into cl_catalogo values(@tabla, '829900','OTRAS ACTIVIDADES EMPRESARIALES NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '829901','TRAMITES EN TRANSITO', '', null, null, null)
insert into cl_catalogo values(@tabla, '841100','ACTIVIDADES LEGISLATIVAS DE LA ADMINISTRACION PUBLICA EN', '', null, null, null)
insert into cl_catalogo values(@tabla, '841200','ACTIVIDADES EJECUTIVAS DE LA ADMINISTRACION PUBLICA EN GE', '', null, null, null)
insert into cl_catalogo values(@tabla, '841300','REGULACION DE LAS ACTIVIDADES DE ORGANISMOS QUE PRESTAN S', '', null, null, null)
insert into cl_catalogo values(@tabla, '841400','ACTIVIDADES REGULADORAS Y FACILITADORAS DE LA ACTIVIDAD E', '', null, null, null)
insert into cl_catalogo values(@tabla, '841401','ACTIVIDADES AUXILIARES DE SERVICIOS PARA LA ADMINISTRACIO', '', null, null, null)
insert into cl_catalogo values(@tabla, '842100','RELACIONES EXTERIORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '842200','ACTIVIDADES DE DEFENSA', '', null, null, null)
insert into cl_catalogo values(@tabla, '842300','ORDEN PUBLICO Y ACTIVIDADES DE SEGURIDAD', '', null, null, null)
insert into cl_catalogo values(@tabla, '842400','ACTIVIDADES DE LA JUSTICIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '843000','ACTIVIDADES PLANES DE SEGURIDAD SOCIAL Y DE AFILIACION OB', '', null, null, null)
insert into cl_catalogo values(@tabla, '851200','EDUCACION PREESCOLAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '851201','CENTRO EDUCATIVO Y/O GUARDERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '851300','EDUCACION BASICA PRIMARIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '851900','OTRAS ACTIVIDADES RELACIONADAS CON LA SALUD HUMANA', '', null, null, null)
insert into cl_catalogo values(@tabla, '852100','EDUCACION BASICA SECUNDARIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '852200','EDUCACION MEDIA ACADEMICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '852201','EDUCACION MEDIA ACADEMICA - INTERCAMBIO ESTUDIANTIL', '', null, null, null)
insert into cl_catalogo values(@tabla, '853000','SERVICIO DE EDUCACION LABORAL ESPECIAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '853001','EDUCACION SUPERIOR - PRIM Y SECUN, SERVICIO ACADEMIA DE C', '', null, null, null)
insert into cl_catalogo values(@tabla, '853002','EDUCACION SUPERIOR - EDUCACION EN IDIOMAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '853003','EDUCACION SUPERIO-ESCUELA DE MUSICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '853004','EDUCACION SUPERIOR - ESCUELA FORMACION DEPORTIVA', '', null, null, null)
insert into cl_catalogo values(@tabla, '853005','EDUCACION SUPERIOR - ACADEMIA CONFECCION, BELLEZA Y OTRAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '854300','EDUCACION DE INSTITUCIONES UNIVERSITARIAS O DE ESCUELAS T', '', null, null, null)
insert into cl_catalogo values(@tabla, '855100','EDUCACION NO FORMAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '861000','ACTIVIDADES DE HOSPITALES Y CLINICAS CON INTERNACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '862100','ACTIVIDADES DE LA PRACTICA MEDICA SIN INTERNACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '862200','ACTIVIDADES DE LA PRACTICA ODONTOLOGICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '862201','LABORATORIOS ODONTOLOGICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '862202','SERVICIO MECANICA DENTAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '862203','SERVICIO ODONTOLOGIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '869100','ACTIVIDADES DE APOYO DIAGNOSTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '869200','ACTIVIDADES DE APOYO TERAPEUTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '869201','SERVICIO HOGAR GERIATRICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '869900','OTRAS ACTIVIDADES DE ATENCION DE LA SALUD HUMANA', '', null, null, null)
insert into cl_catalogo values(@tabla, '873000','ACTIVIDADES DE ATENCION EN INSTITUCIONES PARA EL CUIDADE', '', null, null, null)
insert into cl_catalogo values(@tabla, '881000','ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO PARA PER', '', null, null, null)
insert into cl_catalogo values(@tabla, '900200','CREACION MUSICAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '900600','ACTIVIDADES TEATRALES Y MUSICALES Y OTRAS ACTIVIDADES ART', '', null, null, null)
insert into cl_catalogo values(@tabla, '900800','OTRAS ACTIVIDADES DE ESPECTACULOS EN VIVO', '', null, null, null)
insert into cl_catalogo values(@tabla, '910100','ACTIVIDADES DE BIBLIOTECAS Y ARCHIVOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '910200','SERVICIO DECORACION DE INTERIORES', '', null, null, null)
insert into cl_catalogo values(@tabla, '910300','ACTIVIDADES DE JARDINES BOTANICOS, ZOOLOGICOS Y RESERVAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '920000','ACTIVIDADES DE JUEGOS DE AZAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '920001','VENTA LOTERIAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '920002','CAFE BILLAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '920003','CASINOS Y JUEGOS DE AZAR', '', null, null, null)
insert into cl_catalogo values(@tabla, '931900','ACTIVIDADES DEPORTIVAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '931901','GIMNASIO', '', null, null, null)
insert into cl_catalogo values(@tabla, '931902','SERVICIO CLUB DE TENIS DE MESA', '', null, null, null)
insert into cl_catalogo values(@tabla, '932900','OTRAS ACTIVIDADES RECREATIVAS Y DE ESPARCIMIENTO NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '932901','SERVICIO AMPLIFICACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '941100','ACTIVIDADES DE ORGANIZACIONES EMPRESARIALES Y DE EMPLEADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '941200','ACTIVIDADES DE ORGANIZACIONES PROFESIONALES', '', null, null, null)
insert into cl_catalogo values(@tabla, '942000','ACTIVIDADES DE SINDICATOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '949100','ACTIVIDADES DE ORGANIZACIONES RELIGIOSAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '949200','ACTIVIDADES DE ORGANIZACIONES POLITICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '949900','ACTIVIDADES DE OTRAS ORGANIZACIONES NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '951100','MANTENIMIENTO Y REPARACION DE COMPUTADORES Y EQUIPO PERIF', '', null, null, null)
insert into cl_catalogo values(@tabla, '951101','SERVICIO DE REPARACION DE EMBOBINADOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '951200','MANTENIMIENTO Y REPARACION DE EQUIPOS DE COMUNICACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '951201','SERVICIO SOPORTE TECNICO EN SISTEMAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '951202','CONSULTORES EN EQUIPO DE INFORMATICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '951203','SERVICIO DISE-O PAGINA WEB INTERNET', '', null, null, null)
insert into cl_catalogo values(@tabla, '951204','PROCESAMIENTO DE DATOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '951205','ACTIVIDADES RELACIONADAS CON BASES DE DATOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '952300','REPARACION DE CALZADO Y ARTICULOS DE CUERO', '', null, null, null)
insert into cl_catalogo values(@tabla, '952900','MATENIMIENTO Y REPARACIOS DE OTROS EFECTOS PERSONALES Y E', '', null, null, null)
insert into cl_catalogo values(@tabla, '952901','SERVICIO DE REPARCION DE ELECTRODOMESTICOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '952902','SERVICIO DE TAPICERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '952903','SERVICIO DE EBANISTERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '952904','SERVICIO REPARACION DE BICICLETAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '952905','SERVICIO REPARACION DE EQUIPOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '952906','REPARACION Y MANTENIMIENTO DE BASCULAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '952907','TALLER DE ELECTRONICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960100','LAVADO Y LIMPIEZA DE PRENDAS DE TELA Y DE PIEL, INCLUSO L', '', null, null, null)
insert into cl_catalogo values(@tabla, '960101','SERVICIO DE LAVANDERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960200','PELUQUERIA Y OTROS TRATAMIENTOS DE BELLEZA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960201','CENTRO DE ESTETICA FACIAL Y CORPORAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '960202','SALON DE BELLEZA Y PELUQUERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960203','SERVICIO COSMETOLOGIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960300','POMPAS FUNEBRES Y ACTIVIDADES CONEXAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '960301','SERVICIOS FUNEBRES', '', null, null, null)
insert into cl_catalogo values(@tabla, '960900','OTRAS ACTIVIDADES DE SERVICIOS NCP', '', null, null, null)
insert into cl_catalogo values(@tabla, '960901','SERVICIO ALQUILER EQUIPOS DE MUSICA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960902','SERVICIO ARREGLO DE JOYAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '960903','SERVICIO OPTOMETRIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960904','SERVICIO ALQUILER DE VESTIDOS Y DISFRACES', '', null, null, null)
insert into cl_catalogo values(@tabla, '960905','SERVICIO REMONTADORA DE CALZADO - ZAPATERIA', '', null, null, null)
insert into cl_catalogo values(@tabla, '960906','SERVICIO LABORATORIO OPTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '960907','PARQUEADERO', '', null, null, null)
insert into cl_catalogo values(@tabla, '960908','SERVICIO DE TROQUELADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '960909','SERVICIO EMPLEADAS DOMESTICAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '960910','SERVICIO CAMBIO DE SENCILLO', '', null, null, null)
insert into cl_catalogo values(@tabla, '960911','SERVICIO ARREGLO DE PRADOS Y JARDINES', '', null, null, null)
insert into cl_catalogo values(@tabla, '960912','SERVICIO DE ESTAMPADO', '', null, null, null)
insert into cl_catalogo values(@tabla, '960913','SERVICIO DE FUMIGACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '960914','SERVICIO TRABAJOS EN COMPUTACION', '', null, null, null)
insert into cl_catalogo values(@tabla, '960915','SERVICIO GUARDAMALETAS', '', null, null, null)
insert into cl_catalogo values(@tabla, '960916','AGENCIA MATRIMONIAL', '', null, null, null)
insert into cl_catalogo values(@tabla, '970000','HOGARES PRIVADOS CON SERVICIO DOMESTICO', '', null, null, null)
insert into cl_catalogo values(@tabla, '970001','SERVICIO HOGARES PARA ANCIANOS', '', null, null, null)
insert into cl_catalogo values(@tabla, '990000','ORGANIZACIONES Y ORGANOS EXTRATERRITORIALES', '', null, null, null)
GO

