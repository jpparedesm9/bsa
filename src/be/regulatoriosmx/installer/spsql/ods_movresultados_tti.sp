/*************************************************************************/
/*   Archivo:              ods_movresultados_tti.sp                      */
/*   Stored procedure:     sp_ods_mov_resultados_tti                     */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Raúl Altamirano Mendez                        */
/*   Fecha de escritura:   Diciembre 2017                                */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Extraccion de datos para la generacion de archivo de interface ODS 3*/
/*   Movimientos Resultados                                              */
/*                              CAMBIOS                                  */
/* Sep-17-2019                 AGO             REQ 121717 ODS REVOLVENTE */
/* Oct-31-2019                 AGO             MEJORA 129414             */
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_mov_resultados_tti')
    drop proc sp_ods_mov_resultados_tti
go

create proc sp_ods_mov_resultados_tti
(
    @t_show_version     bit  =   0
)
as
declare
    @w_sp_name          varchar(20),
    @w_s_app            varchar(50),
    @w_path             varchar(255),
    @w_path_obj         varchar(255),
    @w_destino          varchar(2500),
    @w_msg              varchar(200),
    @w_error            int,
    @w_errores          varchar(1500),
    @w_comando          varchar(2500),
    @w_cadena           varchar (1000),
    @w_tipo_telef       varchar(10),
    @w_version          varchar(10),
    @w_report_nombre    varchar(100),
    @w_reporte          varchar(10),
    @w_return           int,
    @w_existe_solicitud char (1),
    @w_ini_mes          datetime,
    @w_fin_mes          datetime,
    @w_fin_mes_hab      datetime,
    @w_fin_mes_ant      datetime,
    @w_fin_mes_ant_hab  datetime,
    @i_ciudad           int,
    -- ----------------------------
    @w_dia              varchar(2),
    @w_mes              varchar(2),
   @w_anio              varchar(4),
    @w_ext_arch         varchar(6),
    @w_nom_arch         varchar(255),
    @w_nom_log          varchar(255),
    @w_fecha_proceso    datetime,
    @w_fecha_cuarto_dh  datetime,
    @w_solicitud        char(1),
    @w_mensaje          varchar(150),
    @w_periodo_ini      int,
    @w_corte_ini        int,
    @w_empresa          int,
    @w_ini_mov          datetime,
    @w_fin_mov          datetime,
    @w_fecha_corte        datetime,
    @w_ciudad_nacional  int,
    @w_formato_fecha    int,
    @w_batch            int,
    @w_param_conta_pro  varchar(10),
    @w_query            varchar(500)


select @w_sp_name = 'sp_ods_mov_resultados_tti'

select @w_formato_fecha = 112, @w_batch = 75231

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end

select @w_empresa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end


select @w_path = ba_path_destino,
       @w_report_nombre = ba_arch_resultado
from  cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or
   isnull(@w_path, '') = '' or
   isnull(@w_report_nombre, '') = ''
begin
   select @w_error = 807048
   goto ERROR_PROCESO
end


--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_corte = dateadd(dd, -1, @w_fecha_proceso)

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_corte) 
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end

select @w_dia = right('00' + convert(varchar(2), datepart(dd, @w_fecha_corte)), 2)
select @w_mes = right('00' + convert(varchar(2), datepart(mm, @w_fecha_corte)), 2)
select @w_anio = right(convert(varchar(4), datepart(yyyy, @w_fecha_corte)),4) -- caso#146729

select @w_nom_arch = @w_report_nombre + '_' +@w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_' +@w_anio + @w_mes + @w_dia + '.err'



select @w_ini_mov = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fecha_corte)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fecha_corte))),
       @w_fin_mov = @w_fecha_corte

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 710589
   goto ERROR_PROCESO
end


--Creacion de estructura temporal para resultados finales
select 
'banco'       = convert(varchar(25), null),
'cuenta'      = convert(varchar(25), null),
'oficina'     = convert(smallint, null),
'saldo_mo'    = convert(money, null),
'saldo_ml'    = convert(money, null)
into #resultados 
from cob_conta_super..sb_ods_movresultados_tti
where 1=2

if @@error != 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end


--Consultar informacion inicial para
select
'banco'        = isnull(sa_documento, 'NO EXISTE'),
'cuenta'       = sa_cuenta,
'fecha'        = sa_fecha_tran,
'oficina'      = convert(smallint, null),
'debitos'      = sum(sa_debito),
'creditos'     = sum(sa_credito)
into #datos_movimientos
from cob_conta_tercero..ct_sasiento
where sa_empresa    = @w_empresa
and sa_fecha_tran   between @w_ini_mov and @w_fin_mov
and sa_cuenta       in (select distinct re_substring from cob_conta..cb_relparam where re_producto = 7 and (re_substring like '5%' or re_substring like '6%'))
group by sa_ente, sa_documento, sa_fecha_tran, sa_cuenta

if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end

--select distinct(do_banco) 
--into #op_borrar
--from sb_dato_operacion where do_tipo_operacion = 'REVOLVENTE' and do_fecha between @w_ini_mov and @w_fin_mov

--delete from #datos_movimientos
--where banco in (select do_banco from #op_borrar)


--Actualizar informacion complementaria para
update #datos_movimientos
set oficina      = do_oficina
from sb_dato_operacion
where fecha         = do_fecha
and do_aplicativo   = 7
and banco           = do_banco

if @@error != 0
begin
   select @w_error = 724533
   goto ERROR_PROCESO
end


--Ingresar en resultados informacion
insert into #resultados
(
banco,      cuenta,   oficina,
saldo_mo,   saldo_ml
)
select
banco,      cuenta,   oficina,
sum(creditos - debitos),   sum(creditos - debitos)
from  #datos_movimientos
group by banco, cuenta, oficina

if @@error != 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end


--Registro de Informacion del Reporte en Estructura Final
truncate table sb_ods_movresultados_tti

insert into sb_ods_movresultados_tti
(
 om_num_cuenta,
 om_cod_cta_cont,
 om_cod_divisa,
 om_fec_data,
 om_cod_pais,
 om_cod_centro_cont,
 om_cod_entidad,
 om_imp_ie_mo,
 om_imp_ie_ml
)
select 
ltrim(rtrim(banco)),
ltrim(rtrim(cuenta)),
'MXP',
convert(varchar(8), @w_fecha_corte, @w_formato_fecha),
52,
oficina,
78,
saldo_mo,
saldo_ml
from #resultados
where saldo_mo != 0 and saldo_ml != 0
           
if @@error <> 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end

--Actualizar linea de detalle del archivo
update sb_ods_movresultados_tti
set om_registro_archivo = convert(varchar,isnull(om_num_cuenta, ''))        +'|'+
                          convert(varchar,isnull(om_cod_cta_cont, ''))      +'|'+
                          convert(varchar,isnull(om_cod_divisa,''))         +'|'+
                          convert(varchar,isnull(om_fec_data,0))            +'|'+
                          convert(varchar,isnull(om_cod_pais,0))            +'|'+
                          convert(varchar,isnull(om_cod_centro_cont, 0))    +'|'+
                          '00'+convert(varchar,isnull(om_cod_entidad,0))    +'|'+
                          convert(varchar,isnull(om_imp_ie_mo, 0))          +'|'+
                          convert(varchar,isnull(om_imp_ie_ml, 0))

if @@error <> 0
begin
   select @w_error = 724533
   goto ERROR_PROCESO
end

--Geneacion del BCP para creacion del archivo
select @w_query   = 'select om_registro_archivo from cob_conta_super..sb_ods_movresultados_tti order by om_num_cuenta, om_cod_cta_cont'

select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_03_TTI<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_03_TTI<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_query + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

--PRINT 'Comando: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  goto ERROR_PROCESO
end


SALIDA_PROCESO:
return 0

ERROR_PROCESO:
select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

select @w_msg = isnull(@w_msg, @w_mensaje)

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go


