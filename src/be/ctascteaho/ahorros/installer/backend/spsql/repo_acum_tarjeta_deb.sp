/************************************************************************/
/*      Archivo:                repo_acum_tarjeta_deb.sp                */
/*      Stored procedure:       sp_repo_acum_tarjeta_deb                */
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
/*      Reporte Acumulado Tarjeta de Debito                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_repo_acum_tarjeta_deb')
   drop proc sp_repo_acum_tarjeta_deb
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_repo_acum_tarjeta_deb (
   @t_show_version  bit = 0
)
as
declare
@w_sp_name        varchar(30),
@w_fecha          datetime,
@w_fecha1         datetime,
@w_msg            varchar(254),
@w_path_s_app     varchar(254),
@w_path           varchar(254),
@w_s_app          varchar(254),
@w_cmd            varchar(254),
@w_bd             varchar(254),
@w_tabla          varchar(254),
@w_tablac         varchar(254),
@w_tablad         varchar(254),
@w_destino        varchar(254),
@w_errores        varchar(254),
@w_erroresc       varchar(254),
@w_destinoc       varchar(254),
@w_comando        varchar(512),
@w_fecha_arch     varchar(10),
@w_nombre         varchar(64),
@w_archivo        varchar(64),
@w_archivoc       varchar(64),
@w_archivod       varchar(64),
@w_arch_out       varchar(64),
@w_batch          int,
@w_error          int,
@w_cont           int,
@anio_listado     varchar(10),
@mes_listado      varchar(10),
@dia_listado      varchar(10)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_repo_acum_tarjeta_deb'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if exists (select 1 from sysobjects where name = 're_rep_acum_tarj_deb_cab')
    drop table re_rep_acum_tarj_deb_cab

create table re_rep_acum_tarj_deb_cab(
et_oficina                       varchar(30),
et_desc_oficina                  varchar(30),
et_zona                          varchar(30),
et_regional                      varchar(30),
et_tar_col                       varchar(30),
et_tar_col_atm                   varchar(30),
et_tar_col_pos                   varchar(30),
et_tar_no_uso                    varchar(30))

if exists (select 1 from sysobjects where name = 're_rep_acum_tarj_deb_det')
    drop table re_rep_acum_tarj_deb_det

create table re_rep_acum_tarj_deb_det(
et_oficina              int,
et_desc_oficina         varchar(64),
et_zona                 varchar(64),
et_regional             varchar(64),
et_tar_col              tinyint,
et_tar_col_atm          tinyint,
et_tar_col_pos          tinyint,
et_tar_no_uso           tinyint
)

insert into re_rep_acum_tarj_deb_cab
values('COD_OFICINA', 'DESC_OFICINA','ZONA', 'REGIONAL', 'TARJETAS_COLOCADAS', 'TARJETAS_COLOCADAS_ATM', 'TARJETAS_COLOCADAS_POS',
       'TARJETAS_SIN_USO')

select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

select @w_fecha1   = convert(smalldatetime,(substring(convert(varchar(10),@w_fecha,101),1,2) + '/' + '01' + '/' + substring(convert(varchar(10),@w_fecha,101),7,4)))

select
et_oficina           = ts_oficina,
et_desc_oficina      = (select of_nombre from cobis..cl_oficina where of_oficina = ts.ts_oficina),
et_zona              = isnull((select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_zona = b.of_oficina) from cobis..cl_oficina a where a.of_subtipo = 'O' and a.of_oficina = ts.ts_oficina),''),
et_regional          = (select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_regional = b.of_oficina) from cobis..cl_oficina a where a.of_oficina = ts.ts_oficina),
et_cta_banco         = ah_cta_banco,
et_tar_col           = convert(tinyint,0),
et_tar_col_atm       = convert(tinyint,0),
et_tar_col_pos       = convert(tinyint,0),
et_tar_no_uso        = convert(tinyint,0)
into #EnrolamientoTdebito
from   cob_ahorros..ah_cuenta as ah, cob_remesas..re_relacion_cta_canal as rc, cob_remesas..re_tran_servicio as ts,cobis..cl_oficina as tr
where  rc_cuenta      = ah_cta_banco
and    of_oficina     = ts.ts_oficina
and    rc_tarj_debito = ts_varchar5
and    rc_canal       = 'TAR'
and    ts_tipo_transaccion  <> 746
and    ts_tsfecha between @w_fecha1 and @w_fecha

select distinct et_oficina,
et_desc_oficina,
et_zona,
et_regional,
et_tar_col,
et_tar_col_atm,
et_tar_col_pos,
et_tar_no_uso
into #re_reporte_tdebito
from #EnrolamientoTdebito

/* # total de tarjetas colocadas */
select distinct et_oficina,ps_cant = COUNT(1)
into #tot_tar_col
from #EnrolamientoTdebito
group by et_oficina

update #re_reporte_tdebito
set    et_tar_col = ps_cant
from   #tot_tar_col
where  #tot_tar_col.et_oficina = #re_reporte_tdebito.et_oficina

/* # total de tarjetas colocadas USO EN POS
   # total de tarjetas colocadas USO EN ATM */

select distinct ts_banco_orig,et_oficina,ts_canal
into   #Canales
from   cobis..ws_tran_servicio, #EnrolamientoTdebito
where  ts_banco_orig = et_cta_banco
and    ts_estado     = 'A'
and    ts_tipo_tran not in (744, 749, 26500)
and    ts_canal in (3,8)
and    ts_fecha between @w_fecha1 and @w_fecha

/* canal 3 para CB ATM */
select distinct et_oficina, ps_cant= COUNT(1)
into #tot_tar_col_atm
from #Canales
where ts_canal in (3)
group by et_oficina

update #re_reporte_tdebito
set    et_tar_col_atm = ps_cant
from   #tot_tar_col_atm
where  #tot_tar_col_atm.et_oficina = #re_reporte_tdebito.et_oficina

/* canal 8 para CB POS */
select distinct et_oficina,ps_cant = COUNT(1)
into #tot_tar_col_pos
from #Canales
where ts_canal in (8)
group by et_oficina

update #re_reporte_tdebito
set    et_tar_col_pos = ps_cant
from   #tot_tar_col_pos
where  #tot_tar_col_pos.et_oficina = #re_reporte_tdebito.et_oficina

/* # total de tarjetas colocadas NO SE USARON EN NINGUN CANAL */
select distinct et_oficina,ps_cant = COUNT(1)
into #tot_tar_col_no_uso
from #EnrolamientoTdebito
where et_cta_banco not in (select ts_banco_orig from #Canales )
group by et_oficina

update #re_reporte_tdebito
set    et_tar_no_uso = ps_cant
from   #tot_tar_col_no_uso
where  #tot_tar_col_no_uso.et_oficina = #re_reporte_tdebito.et_oficina

insert into re_rep_acum_tarj_deb_det
select *
from #re_reporte_tdebito

select
@w_cont      = 0,
@w_bd        = 'cob_ahorros',
@w_tablac    = 're_rep_acum_tarj_deb_cab',
@w_tablad    = 're_rep_acum_tarj_deb_det',
@w_arch_out  = 'REPORTE_USO_ACUMULADO_TD',
@w_batch     = 4021
goto BCP

BCP:

/*Creacion BCP*/
select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

select
@w_s_app = @w_path_s_app + 's_app'

/*Path destino archivo BCP*/
select
@w_path = ba_path_destino
from  cobis..ba_batch
where ba_batch = @w_batch

/*Generacion archivo cabecera*/
select
@w_cmd       = @w_s_app + ' bcp -auto -login ',
@w_tabla     = @w_tablac,
@w_archivoc  = @w_tablac

select
@w_destinoc  = @w_path + @w_archivoc +'.txt',
@w_erroresc  = @w_path + @w_archivoc +'.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tablac + ' out ' + @w_destinoc + ' -b5000 -c -e' + @w_erroresc + ' -t"|" ' + '-config ' + @w_s_app + '.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO CABECERA ' + @w_destinoc + ' ' + convert(varchar, @w_error)
   goto ERROR
end

/*Generacion archivo datos*/
select
@w_cmd      = @w_s_app + ' bcp -auto -login ',
@w_tabla    = @w_tablad,
@w_archivod = @w_tablad

select
@w_destino  = @w_path + @w_archivod +'.txt',
@w_errores  = @w_path + @w_archivod +'.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tablad + ' out ' + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + '.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_destino + ' ' + convert(varchar, @w_error)
   goto ERROR
end

select @w_fecha_arch = convert(varchar, @w_fecha, 112),
       @anio_listado = substring(@w_fecha_arch,1,4),
       @mes_listado  = substring(@w_fecha_arch,5,2),
       @dia_listado  = substring(@w_fecha_arch,7,2)

select @w_fecha_arch = @mes_listado + @dia_listado + @anio_listado

/*Fusion archivos de cabecera y de datos*/
select @w_nombre = @w_arch_out + @w_fecha_arch

select
@w_archivo  = @w_path + @w_nombre +'.txt',
@w_comando = 'type ' + @w_destinoc + ' ' + @w_destino + ' > ' + @w_archivo

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo + ' ' + convert(varchar, @w_error)
   goto ERROR
end

/*Eliminacion Archivo de cabecera y de datos*/
select
@w_comando = 'rm ' + @w_destinoc

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo + ' '+ convert(varchar, @w_error)
   goto ERROR
end

select
@w_comando = 'rm ' + @w_erroresc

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo + ' ' + convert(varchar, @w_error)
   goto ERROR
end

select
@w_comando = 'rm ' + @w_destino

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo+ ' ' + convert(varchar, @w_error)
   goto ERROR
end

select
@w_comando = 'rm ' + @w_errores

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL '+@w_archivo+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

if exists (select 1 from sysobjects where name = 're_rep_acum_tarj_deb_cab')
    drop table re_rep_acum_tarj_deb_cab

if exists (select 1 from sysobjects where name = 're_rep_acum_tarj_deb_det')
    drop table re_rep_acum_tarj_deb_det

return 0

ERROR:
print @w_msg

exec @w_error = cobis..sp_errorlog
@i_fecha      = @w_fecha,
@i_error      = 22681,
@i_usuario    = 'op_batch',
@i_tran       = 4021,
@i_tran_name  = @w_msg,
@i_rollback   = 'N'
return 22681

go

