/*************************************************************************/
/*   Archivo:              ods_movresultados_ttj.sp                      */
/*   Stored procedure:     sp_ods_mov_resultados_ttj                     */
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
/* Mar-05-2020      AOR         MEJORA 135888                            */
/* Ago-17-2020    	ACHP        Caso #143664 - cambio de nombre          */
/* Ene-19-2020    	SRS         Caso #152525 - Ajuste saldos intereses   */
/* Ene-12-2022    	KVI         R.#173512-Archivo tome ultimo dia natural*/
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_mov_resultados_ttj')
    drop proc sp_ods_mov_resultados_ttj
go

create proc sp_ods_mov_resultados_ttj
(
    @i_param1           datetime = null,   --FECHA   
    @t_show_version     bit      =   0
     
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
    @w_comando          varchar(8000),
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
    @w_fecha_corte      datetime,
    @w_ciudad_nacional  int,
    @w_formato_fecha    int,
    @w_batch            int,
    @w_param_conta_pro  varchar(10),
    @w_query            varchar(500),
	@w_columna          varchar(50),
	@w_col_id           int,
	@w_cabecera         varchar(8000),
	@w_nom_cabecera     varchar(8000), 
	@w_nom_columnas     varchar(8000),
	@w_cont_columnas    int,
	@w_sql              varchar(5000),
	@w_es_fin_mes       char(1),
	@w_fecha_fin_mes_hab datetime,
	--Caso #173512 Ini
	@w_fecha_fin_mes     datetime, 
	@w_dia_m             varchar(2),
    @w_mes_m             varchar(2),
    @w_anio_m            varchar(4)
	--Caso #173512 Fin


select @w_sp_name = 'sp_ods_mov_resultados_ttj'

select @w_formato_fecha = 112, @w_batch = 75232
select @w_es_fin_mes = 'N'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end


if @i_param1 is null 
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else 
   select @w_fecha_proceso = @i_param1

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
select @w_anio = right(convert(varchar(4), datepart(yyyy, @w_fecha_corte)),4)

-------------------------------------------Caso #143664 Ini
SELECT @w_fecha_fin_mes_hab = dateadd(d, -1, dateadd(m, DATEDIFF(m, 0, @w_fecha_corte) + 1, 0))

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_fin_mes_hab) 
begin
   if datepart(dd, @w_fecha_fin_mes_hab) != 1 select @w_fecha_fin_mes_hab = dateadd(dd, -1, @w_fecha_fin_mes_hab) else break
end

if(convert(VARCHAR(10),@w_fecha_fin_mes_hab, @w_formato_fecha) = convert(VARCHAR(10),@w_fecha_corte, @w_formato_fecha))
    select @w_es_fin_mes = 'S'
-------------------------------------------Caso #143664 Fin

select @w_ini_mov = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fecha_corte)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fecha_corte))),
       @w_fin_mov = @w_fecha_corte

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 710589
   goto ERROR_PROCESO
end

if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_movresultados' and type = 'U')
   drop table sb_tmp_cabecera_movresultados

create table sb_tmp_cabecera_movresultados
(
    cabecera01  varchar(50),
    cabecera02  varchar(50),
    cabecera03  varchar(50),
    cabecera04  varchar(50),
    cabecera05  varchar(50),
    cabecera06  varchar(50),
    cabecera07  varchar(50),
    cabecera08  varchar(50),
    cabecera09  varchar(50)
)

--Creacion de estructura temporal para resultados finales
select 
'banco'       = convert(varchar(25), null),
'cuenta'      = convert(varchar(25), null),
'oficina'     = convert(smallint, null),
'saldo_mo'    = convert(money, null),
'saldo_ml'    = convert(money, null)
into #resultados 
from cob_conta_super..sb_ods_movresultados_ttj
where 1=2

if @@error != 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end


--Consultar informacion inicial para
select
'banco'        = replace(convert(varchar(12),isnull(sa_documento,'')),' ','0'), ---isnull(sa_documento, 'NO EXISTE'),
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
truncate table sb_ods_movresultados_ttj

insert into sb_ods_movresultados_ttj
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
convert(varchar(50),ltrim(rtrim(banco))),
convert(varchar(50),replicate ('0',(15 - len(ltrim(rtrim(cuenta))))) + convert(varchar,ltrim(rtrim(cuenta)))),
'MXP',
convert(varchar(8), @w_fecha_corte, @w_formato_fecha),
convert(varchar(50),52),
convert(varchar(50),isnull(oficina,0)),
convert(varchar(50),'0078'),
dbo.fn_formato_num_txt(saldo_mo, 20, 3),
--convert(varchar(50),saldo_mo),
dbo.fn_formato_num_txt(saldo_ml, 20, 3)
--convert(varchar(50),saldo_ml)
from #resultados
where saldo_mo != 0 and saldo_ml != 0
        
-- SOP 152525
UPDATE 	sb_ods_movresultados_ttj 
SET		om_imp_ie_mo = '-' + om_imp_ie_mo,
		om_imp_ie_ml = '-' + om_imp_ie_ml
WHERE 	om_cod_cta_cont = '000007711900101'
-- SOP 152525
   
if @@error <> 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end

print 'Generando Cabeceras'
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = '',
       @w_nom_cabecera = '', 
       @w_nom_columnas = '',
       @w_cont_columnas = 0
       
while 1 = 1 begin
   set rowcount 1 
   select @w_columna = lower(substring(ltrim(rtrim(c.name)), 4, len(ltrim(rtrim(c.name))) - 3)),
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_ods_movresultados_ttj'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
   
   set rowcount 0 
   select @w_cont_columnas = @w_cont_columnas + 1

   select @w_nom_cabecera = @w_nom_cabecera + 'cabecera' + right('00' + convert(varchar(2), @w_cont_columnas), 2) + char(44)
   select @w_cabecera = @w_cabecera + char(39) + @w_columna + char(39) + char(44)
   select @w_nom_columnas = @w_nom_columnas +'om_' + lower(@w_columna) + char(44)   
   
end

select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

--Escribir Cabecera
select    @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_movresultados '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_nom_cabecera
select    @w_sql = @w_sql + ')'
select    @w_sql = @w_sql + ' values '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_cabecera
select    @w_sql = @w_sql + ')'

exec (@w_sql)

if @@ERROR <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_sql
   select
   @w_error = 2108048,
   @w_mensaje = 'Error generando Archivo de Cabeceras'
   goto ERROR_PROCESO
end

--Geneacion del BCP para creacion del archivo

select @w_sql = 'select '
select @w_sql = @w_sql + @w_nom_cabecera
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_movresultados '
select @w_sql = @w_sql + ' union all ' 
select @w_sql = @w_sql + 'select '
select @w_sql = @w_sql + @w_nom_columnas
select @w_sql = @w_sql + ' from cob_conta_super..sb_ods_movresultados_ttj '

-------------------------------------------Caso #143664 Ini
print 'borrar-w_fecha_corte: ' + convert(varchar(30),@w_fecha_corte)
print 'borrar-w_fecha_fin_mes_hab: ' + convert(varchar(30), @w_fecha_fin_mes_hab)
print 'borrar-w_es_fin_mes:' + @w_es_fin_mes

if(@w_es_fin_mes = 'S')
begin
    print 'borrar-Se van a crear archivos con D y M'
	
    -------------------------------------------Caso #173512 Ini
	select @w_fecha_fin_mes = dateadd(d, -1, dateadd(m, DATEDIFF(m, 0, @w_fecha_corte) + 1, 0))
	print 'borrar-w_fecha_fin_mes: ' + convert(varchar(30), @w_fecha_fin_mes)
	select @w_dia_m = right('00' + convert(varchar(2), datepart(dd, @w_fecha_fin_mes)), 2) 
    select @w_mes_m = right('00' + convert(varchar(2), datepart(mm, @w_fecha_fin_mes)), 2) 
    select @w_anio_m = right(convert(varchar(4), datepart(yyyy, @w_fecha_fin_mes)),4)      
	-------------------------------------------Caso #173512 Fin
	
    select @w_nom_arch = @w_report_nombre + '_M_' +@w_anio_m + @w_mes_m + @w_dia_m +'.' + 'txt'
    select @w_nom_log  = @w_report_nombre + '_M_' +@w_anio_m + @w_mes_m + @w_dia_m + '.err'
    
    select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_03_TTI<aaaa_mm_dd>.txt
           @w_errores = @w_path + @w_nom_log   -- COB_ODS_03_TTI<aaaa_mm_dd>.err
    
    select @w_comando = 'bcp "' + @w_sql + '" queryout "'
    select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '
    
    exec @w_error = xp_cmdshell @w_comando
    
    if @w_error <> 0 begin
      select @w_error = 70146
      goto ERROR_PROCESO
    end
end

select @w_nom_arch = @w_report_nombre + '_D_' +@w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_D_' +@w_anio + @w_mes + @w_dia + '.err'
-------------------------------------------Caso #143664 Fin

select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_03_TTI<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_03_TTI<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_sql + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

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


