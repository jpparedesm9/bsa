/************************************************************************/
/*      Archivo:                constabl.sp                               */
/*      Stored procedure:       sp_consulta_tablas                      */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 25-Oct-1996                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Consulta del contenido de las tablas utilizadas por el Admin    */
/*	Distribuido                                                     */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      11/NOV/1996     J. Arthos       Emision inicial                 */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_consulta_tablas')
   drop proc sp_consulta_tablas
go

create proc sp_consulta_tablas (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(32) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint =NULL,
	@i_tabla		descripcion,
	@i_cod			int = 0,
	@i_cod_text		descripcion = " ",
	@i_criterio		int = 0,
	@i_sec			int = 0,
	@i_siguiente		tinyint = 0,
	@i_ofi			int = 0,
	@i_rol			int = 0
)
as
set rowcount 20
if @i_tabla = "ad_usuario"
begin
	select "ESTADO" = us_estado,
	       "LOGIN" = us_login,
	       "FILIAL" = us_filial,
	       "OFICINA" = us_oficina,
	       "NODO" = us_nodo,
	       "FECHA ASIG." = us_fecha_asig,
	       "FECHA ULT. MOD."= us_fecha_ult_mod,
	       "FECHA ULT. PWD."= us_fecha_ult_pwd,
	       "CREADOR" = us_creador
	from ad_usuario
	where ((us_login = @i_cod_text) and (@i_siguiente = 0))
	   or us_login > @i_cod_text
	order by us_login
end
if @i_tabla = "cl_funcionario"
begin
	if @i_criterio = 1
	begin
		select "COD" = fu_funcionario,
		       "LOGIN" = fu_login,
		       "ESTADO" = fu_estado,
		       "NOMBRE" = fu_nombre,
		       "SEXO" = fu_sexo,
		       "NOMINA" = fu_nomina,
		       "DEPARTAMENTO" = fu_departamento,
		       "OFICINA" = fu_oficina,
		       "CARGO" = fu_cargo,
		       "SEC." = fu_secuencial,
		       "JEFE" = fu_jefe,
		       "NIVEL" = fu_nivel,
		       "FECHA ING." = fu_fecha_ing,
		       "TELEFONO" = fu_telefono,
		       "DINERO" = fu_dinero,
		       "CLAVE" = fu_clave,
		       "OFFSET" = fu_offset	-- ARO:23/01/2001   CRYPWD
		from cl_funcionario
		where ((fu_login = @i_cod_text) and (@i_siguiente = 0))
		   or fu_login > @i_cod_text
		order by fu_login
	end
	else
	begin
		select "COD" = fu_funcionario,
		       "LOGIN" = fu_login,
		       "ESTADO" = fu_estado,
		       "NOMBRE" = fu_nombre,
		       "SEXO" = fu_sexo,
		       "NOMINA" = fu_nomina,
		       "DEPARTAMENTO" = fu_departamento,
		       "OFICINA" = fu_oficina,
		       "CARGO" = fu_cargo,
		       "SEC." = fu_secuencial,
		       "JEFE" = fu_jefe,
		       "NIVEL" = fu_nivel,
		       "FECHA ING." = fu_fecha_ing,
		       "TELEFONO" = fu_telefono,
		       "DINERO" = fu_dinero,
		       "CLAVE" = fu_clave,
		       "OFFSET" = fu_offset	-- ARO:23/01/2001   CRYPWD		       
		from cl_funcionario
		where ((fu_funcionario = @i_cod) and (@i_siguiente = 0))
		   or fu_funcionario > @i_cod
		order by fu_funcionario
	end
end
if @i_tabla = "cl_tabla"
begin
	if @i_criterio = 1
	begin
		select "COD" = codigo,
		       "TABLA" = tabla,
		       "DESCRIPCION" = descripcion
		from cl_tabla
		where ((tabla = @i_cod_text) and (@i_siguiente = 0))
		   or tabla > @i_cod_text
		order by tabla
	end
	else
	begin
		select "COD" = codigo,
		       "TABLA" = tabla,
		       "DESCRIPCION" = descripcion
		from cl_tabla
		where ((codigo = @i_cod) and (@i_siguiente = 0))
		   or codigo > @i_cod
		order by codigo
	end
end
if @i_tabla = "cl_catalogo"
begin
	select "TABLA" = tabla,
	       "COD" = codigo,
	       "VALOR" = valor,
	       "ESTADO" = estado
	from cl_catalogo
	where (((tabla = @i_cod and codigo > @i_cod_text) or (tabla > @i_cod))
	  and @i_siguiente = 1)
	   or (tabla >= @i_cod and @i_siguiente = 0)
	order by tabla
end
if @i_tabla = "cl_default"
begin
	select "TABLA" = tabla,
	       "COD" = codigo,
	       "OFICINA" = oficina,
	       "VALOR" = valor,
	       "SRV" = srv
	from cl_default
	where (tabla = @i_cod
	  and (codigo >= @i_cod_text and oficina > @i_ofi or @i_siguiente = 0))
	   or tabla > @i_cod
	order by tabla
end
if @i_tabla = "cl_ttransaccion"
begin
	select "COD" = tn_trn_code,
	       "DESCRIPCION" = tn_descripcion,
	       "NEMONICO" = tn_nemonico,
	       "DESC. LARGA" = tn_desc_larga
	from cl_ttransaccion
	where ((tn_trn_code = @i_cod) and (@i_siguiente = 0))
	   or tn_trn_code > @i_cod
	order by tn_trn_code
end
if @i_tabla = "ad_procedure"
begin
	if @i_criterio = 1
	begin
		select "COD" = pd_procedure,
		       "STORED PROC." = pd_stored_procedure,
		       "BASE" = pd_base_datos,
		       "ESTADO" = pd_estado,
		       "FECHA ULT. MOD." = pd_fecha_ult_mod,
		       "ARCHIVO" = pd_archivo
		from ad_procedure
		where ((pd_stored_procedure = @i_cod_text) and (@i_siguiente = 0))
		   or pd_stored_procedure > @i_cod_text
		order by pd_stored_procedure
	end
	else
	begin
		select "COD" = pd_procedure,
		       "STORED PROC." = pd_stored_procedure,
		       "BASE" = pd_base_datos,
		       "ESTADO" = pd_estado,
		       "FECHA ULT. MOD." = pd_fecha_ult_mod,
		       "ARCHIVO" = pd_archivo
		from ad_procedure
		where ((pd_procedure = @i_cod) and (@i_siguiente = 0))
		   or pd_procedure > @i_cod
		order by pd_procedure
	end
end
if @i_tabla = "ad_pro_transaccion"
begin
	select "TRANS." = pt_transaccion,
	       "PROC." = pt_procedure,
	       "PRODUCTO" = pt_producto,
	       "TIPO" = pt_tipo,
	       "MONEDA" = pt_moneda,
	       "ESTADO" = pt_estado,
	       "FECHA ULT. MOD." = pt_fecha_ult_mod,
	       "ESPECIAL" = pt_especial
	from ad_pro_transaccion
	where ((pt_transaccion = @i_cod) and (@i_siguiente = 0))
	   or pt_transaccion > @i_cod
	order by pt_transaccion
end
if @i_tabla = "ad_tr_autorizada"
begin
	select "TRANS." = ta_transaccion,
	       "ROL" = ta_rol,
	       "PRODUCTO" = ta_producto,
	       "TIPO" = ta_tipo,
	       "MONEDA" = ta_moneda,
	       "ESTADO" = ta_estado,
	       "FECHA AUT." = ta_fecha_aut,
	       "FECHA ULT. MOD." = ta_fecha_ult_mod,
	       "AUTORIZANTE" = ta_autorizante
	from ad_tr_autorizada
	where (ta_rol = @i_rol
	  and ((ta_transaccion = @i_cod and @i_siguiente = 0)
	   or ta_transaccion > @i_cod))
	   or ta_rol > @i_rol
	order by ta_rol, ta_transaccion
end
if @i_tabla = "ad_rol"
begin
	select "ROL" = ro_rol,
	       "FILIAL" = ro_filial,
	       "ESTADO" = ro_estado,
	       "DESCRIPCION" = ro_descripcion,
	       "FECHA CREACION" = ro_fecha_crea,
	       "CREADOR" = ro_creador,
	       "FECHA ULT. MOD." = ro_fecha_ult_mod,
	       "TIME OUT" = ro_time_out
	from ad_rol
	where ((ro_rol = @i_cod) and (@i_siguiente = 0))
	   or ro_rol > @i_cod
	order by ro_rol
end
if @i_tabla = "ad_usuario_rol"
begin
	select "ROL" = ur_rol,
	       "LOGIN" = ur_login,
	       "TIPO HORARIO" = ur_tipo_horario,
	       "FECHA AUT." = ur_fecha_aut,
	       "AUTORIZANTE" = ur_autorizante,
	       "FECHA ULT. MOD." = ur_fecha_ult_mod,
	       "ESTADO" = ur_estado
	from ad_usuario_rol
	where ((ur_login = @i_cod_text) and (@i_siguiente = 0))
	   or ur_login > @i_cod_text
	order by ur_login
end
if @i_tabla = "ad_tipo_horario"
begin
	select "TIPO" = th_tipo,
	       "DESCRIPCION" = th_descripcion,
	       "ESTADO" = th_estado,
	       "ULT. SECUENCIAL" = th_ult_secuencial,
	       "FECHA ULT. MOD." = th_fecha_ult_mod,
	       "CREADOR" = th_creador
	from ad_tipo_horario
	where ((th_tipo = @i_cod) and (@i_siguiente = 0))
	   or th_tipo > @i_cod
	order by th_tipo
end
if @i_tabla = "ad_horario"
begin
	select "TIPO" = ho_tipo_horario,
	       "SECUENCIAL" = ho_secuencial,
	       "DIA" = ho_dia,
	       "ESTADO" = ho_estado,
	       "HORA INICIO" = ho_hr_inicio,
	       "HORA FIN" = ho_hr_fin,
	       "FECHA CREACION" = ho_fecha_crea,
	       "FECHA ULT. MOD." = ho_fecha_ult_mod,
	       "CREADOR" = ho_creador
	from ad_horario
	where (ho_tipo_horario = @i_cod
	  and ((ho_secuencial = @i_sec and @i_siguiente = 0)
	   or ho_secuencial > @i_sec))
	   or ho_tipo_horario > @i_cod
	order by ho_tipo_horario
end
set rowcount 0
return 0
go
