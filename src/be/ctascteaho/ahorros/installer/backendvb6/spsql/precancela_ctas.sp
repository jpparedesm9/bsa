/************************************************************************/
/*      Archivo:                precancela_ctas.sp                      */
/*      Stored procedure:       sp_precancela_ctas                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Generar Archivo Cuentas_Cancelar                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_precancela_ctas')
   drop proc sp_precancela_ctas
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_precancela_ctas (
    @t_show_version  bit = 0
)

as
declare
@w_sp_name       varchar(30),
@w_s_app         varchar(255),
@w_path          varchar(255),
@w_nombre        varchar(255),
@w_nombre_cab    varchar(255),
@w_destino       varchar(2500),
@w_errores       varchar(1500),
@w_error         int,
@w_comando       varchar(3500),
@w_nombre_plano  varchar(2500),
@w_msg           varchar(255),
@w_col_id        int,
@w_columna       varchar(100),
@w_cabecera      varchar(2500),
@w_nom_tabla     varchar(100),
@w_montomax_can  money,
@w_fecha         datetime,
@w_dmpm          smallint

/*  Captura nombre de Stored Procedure  */
select @w_sp_name    = 'sp_precancela_ctas'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

/* OBTIENE EL MONTO MAXIMO EN DISPONIBLE PARA LA CANCELACION DE LAS CUENTAS */

select @w_montomax_can = pa_money
from   cobis..cl_parametro
where  pa_producto = 'AHO'
and    pa_nemonico = 'MOEXPA'


if exists (select 1 from ah_ctas_cancelar where cc_fecha < @w_fecha)
begin
   insert into ah_ctas_cancelar_his
   (cc_fecha,               cc_zona,                 cc_nom_zona,
    cc_oficina,             cc_nom_oficina,          cc_documento,
    cc_ctabanco,            cc_cliente,              cc_nombre_cli,
    cc_cuenta,              cc_estado_cta,           cc_producto,
    cc_disponible,          cc_operacion,            cc_estadocca,
    cc_desc_est,            cc_diasmora,             cc_castigado,
    cc_valorven,            cc_deudatotal,           cc_saldado,
    cc_exclusivo,           cc_procesado,            cc_fecha_aper,
    cc_fecha_ult_mov,       cc_fecha_proc,           cc_mensaje,
    cc_exento,              cc_titularidad)
   select
    cc_fecha,               cc_zona,                 cc_nom_zona,
    cc_oficina,             cc_nom_oficina,          cc_documento,
    cc_ctabanco,            cc_cliente,              cc_nombre_cli,
    cc_cuenta,              cc_estado_cta,           cc_producto,
    cc_disponible,          cc_operacion,            cc_estadocca,
    cc_desc_est,            cc_diasmora,             cc_castigado,
    cc_valorven,            cc_deudatotal,           cc_saldado,
    cc_exclusivo,           cc_procesado,            cc_fecha_aper,
    cc_fecha_ult_mov,       cc_fecha_proc,           cc_mensaje,
    cc_exento,              cc_titularidad
   from  ah_ctas_cancelar
   where cc_fecha < @w_fecha
   if @@error <> 0
   begin
      select @w_msg = 'ERROR EN RESPALDO DE REGISTROS FECHAS ANTERIORES', @w_error = 1
      goto ERRORFIN
   end

   delete from  ah_ctas_cancelar where cc_fecha < @w_fecha
   if @@error <> 0
   begin
      select @w_msg = 'ERROR ELIMINANDO REGISTROS FECHAS ANTERIORES', @w_error = 1
      goto ERRORFIN
   end
end

/* SOLO PUEDE REPROCESARSE SI NO SE HAN PROCESADO DEBITOS/CANCELACIONES' */
if exists (select 1 from ah_ctas_cancelar where cc_fecha = @w_fecha and cc_procesado <> 'N')
begin
   select @w_msg = 'YA EXISTEN REGISTROS PROCESADOS PARA ESTA FECHA', @w_error = 1
   goto ERRORFIN
end

delete cob_ahorros..ah_ctas_cancelar where cc_fecha = @w_fecha

if @@error <> 0 begin
   select @w_msg = 'ERROR ELIMINANDO REGISTROS DE CUENTAS A PROCESAR', @w_error = 1
   goto ERRORFIN
end

/* INSERCION DE CLIENTES EXCLUSIVOS DEL PASIVO */

insert into ah_ctas_cancelar(
cc_fecha,               cc_zona,                 cc_nom_zona,
cc_oficina,             cc_nom_oficina,          cc_documento,
cc_ctabanco,            cc_cliente,              cc_nombre_cli,
cc_cuenta,              cc_estado_cta,           cc_producto,
cc_disponible,          cc_operacion,            cc_estadocca,
cc_desc_est,            cc_diasmora,             cc_castigado,
cc_valorven,            cc_deudatotal,           cc_saldado,
cc_exclusivo,           cc_procesado,            cc_fecha_aper,
cc_fecha_ult_mov,       cc_fecha_proc,           cc_mensaje,
cc_exento,              cc_titularidad)
select
@w_fecha,               zona,                    nom_zona,
oficina,                nom_ofi,                 (select en_ced_ruc from cobis..cl_ente where en_ente = cliente),
ctabanco,               cliente,                 (select en_nomlar from cobis..cl_ente where en_ente = cliente),
cuenta,                 estado,                  producto,
isnull(disponible,0),   operacion,               estadocca,
desc_est,               diasmora,                castigado,
isnull(valorven, 0),    isnull(deudatotal, 0),   convert(money, 0),
exclusivo,              convert(char(1), 'N'),   fechaaper,
fechaultmov,            null,                    null,
exento,                 titularidad
from cob_ahorros..datos_inac
where exclusivo = 'S'
and   disponible < @w_montomax_can
order by ctabanco

/* INSERCION DE CLIENTES NO EXCLUSIVOS CON MAS DE 30 DIAS DE MORA */

select @w_dmpm = pa_smallint
from  cobis..cl_parametro
where pa_nemonico = 'DMPM'
and   pa_producto = 'CCA'

if @@rowcount = 0
begin
   select @w_msg = 'NO SE ENCONTRO PARAMETRO DIAS DE MORA PARA ABONO DESDE CUENTAS INACTIVAS', @w_error = 1
   goto ERRORFIN
end

insert into ah_ctas_cancelar(
cc_fecha,               cc_zona,                 cc_nom_zona,
cc_oficina,             cc_nom_oficina,          cc_documento,
cc_ctabanco,            cc_cliente,              cc_nombre_cli,
cc_cuenta,              cc_estado_cta,           cc_producto,
cc_disponible,          cc_operacion,            cc_estadocca,
cc_desc_est,            cc_diasmora,             cc_castigado,
cc_valorven,            cc_deudatotal,           cc_saldado,
cc_exclusivo,           cc_procesado,            cc_fecha_aper,
cc_fecha_ult_mov,       cc_fecha_proc,           cc_mensaje,
cc_exento,              cc_titularidad)
select
@w_fecha,               zona,                    nom_zona,
oficina,                nom_ofi,                 (select en_ced_ruc from cobis..cl_ente where en_ente = cliente),
ctabanco,               cliente,                 (select en_nomlar from cobis..cl_ente where en_ente = cliente),
cuenta,                 estado,                  producto,
isnull(disponible,0),   operacion,               estadocca,
desc_est,               diasmora,                castigado,
isnull(valorven, 0),    isnull(deudatotal, 0),   convert(money, 0),
exclusivo,              convert(char(1), 'N'),   fechaaper,
fechaultmov,            null,                    null,
exento,                 titularidad
from cob_ahorros..datos_inac
where exclusivo = 'C'
and   diasmora > @w_dmpm

/** MArca con error las cuentas que estan marcadas para pagos de plazo fijo ****/
update cob_ahorros..ah_ctas_cancelar
set
cc_procesado = 'E',
cc_mensaje = 'Cuenta vinculada con operacion de Plazo Fijo'
from   cob_pfijo..pf_det_pago,
       cob_pfijo..pf_fpago,
       cob_pfijo..pf_operacion ,
       cob_ahorros..ah_ctas_cancelar
where  dp_cuenta     = cc_ctabanco
and    dp_forma_pago = fp_mnemonico
and    fp_producto   = 4
and    dp_operacion  = op_operacion
and    op_estado     in ('ING', 'ACT', 'XACT')
and    dp_estado     <> 'E'


/*** GENERAR BCP ***/
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 4

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'Cuentas_Cancelar',
@w_nom_tabla    = 'ah_ctas_cancelar',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = @w_nombre

select
@w_nombre_plano = @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,getdate())) + '_' + convert(varchar(2), datepart(mm,getdate())) + '_' + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

while 1 = 1
begin
   set rowcount 1
   select
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_ahorros..sysobjects o, cob_ahorros..syscolumns c
   where o.id    = c.id
   and   o.name  = @w_nom_tabla
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_ctas_cancelar out '

select
@w_destino  = @w_path + 'Cuentas_Cancelar.txt',
@w_errores  = @w_path + 'Cuentas_Cancelar.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Generando Archivo Cuentas_Cancelar'
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'Cuentas_Cancelar.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

ERRORFIN:
   print @w_msg

go

