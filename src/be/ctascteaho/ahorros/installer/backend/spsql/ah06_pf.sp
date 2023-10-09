/************************************************************************/
/*    Archivo:                ah06_pf.sp                                */
/*    Stored procedure:       sp_ah06_pf                                */
/*    Base de datos:          cob_ahorros                               */
/*    Producto:               Ahorros                                   */
/************************************************************************/
/*                             IMPORTANTE                               */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "COBISCORP".                                                      */
/*    Su uso no autorizado  queda  expresamente  prohibido asi como     */
/*    cualquier  alteracion  o  agregado  hecho  por  alguno de sus     */
/*    usuarios  sin  el  debido  consentimiento  por  escrito de la     */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Despliega para las pantallas de perfiles contables en el modulo   */
/*    de Contabilidad COBIS los valores que pueden tomar los criterios  */
/*    contables de MONEDA, PRODUCTO, ESTADO              				*/
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 	RAZON               */
/*    22/08/2016			Carmen Milan			Migracion CEN		*/
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_ah06_pf')
	drop proc sp_ah06_pf
go

create proc sp_ah06_pf
(
	@t_show_version bit 		= 0,
	@i_criterio 	tinyint     = null,
	@i_codigo   	varchar(30) = null
)
as

declare
	@w_return         int,
	@w_sp_name        varchar(32),
	@w_tabla          smallint,
	@w_codigo         varchar(30),
	@w_criterio       tinyint

select @w_sp_name = 'sp_ah06_pf'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
	print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
	return 0
end

/* LA 1A VEZ ENVIA LAS ETIQUETAS QUE APARECERAN EN LOS CAMPOS DE LA FORMA */
if @i_criterio is null begin
	select
		'Moneda',
		'Producto',
		'Estado Cta'
end

select @w_codigo   = isnull(@i_codigo, '')
select @w_criterio = isnull(@i_criterio, 0)

/* TABLA TEMPORAL PARA LLENAR LOS DATOS DE TODOS LOS DATOS DEL F5 AL CARGAR LA PANTALLA */
create table #ca_catalogo
(
	ca_tabla       tinyint,
	ca_codigo      varchar(10),
	ca_descripcion varchar(50)
)

/* MONEDA */
if @w_criterio <= 1 
begin
	insert into #ca_catalogo
		select 1, cat.codigo, cat.valor
			from cobis..cl_tabla tab, cobis..cl_catalogo cat
			where tab.tabla  = 'cl_moneda'
			and tab.codigo = cat.tabla

	if @@error <> 0 
		return 203042
end


/* PRODUCTO BANCARIO */
if @w_criterio <= 2 
begin
	insert into #ca_catalogo
		select 3, pb_pro_bancario, pb_descripcion
			from cob_remesas..pe_pro_bancario
			where pb_estado = 'V'

   if @@error <> 0 
	return 203042   
end

/* ESTADO CUENTA */
if @w_criterio <= 3 
begin
	insert into #ca_catalogo
		select 4, cat.codigo, cat.valor
			from cobis..cl_tabla tab, cobis..cl_catalogo cat
			where tab.tabla  = 'ah_estado_cta'
			and tab.codigo = cat.tabla

	if @@error <> 0 
		return 203042   
end

/* RETORNA LOS DATOS AL FRONT-END */
select ca_tabla, ca_codigo, ca_descripcion
	from #ca_catalogo
	where ca_tabla   > @w_criterio
		or (ca_tabla = @w_criterio and ca_codigo > @w_codigo)
	order by ca_tabla, ca_codigo

return 0

go

