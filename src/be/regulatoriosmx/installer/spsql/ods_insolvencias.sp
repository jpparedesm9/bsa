/*************************************************************************/
/*   Archivo:              ods_insolvencias.sp                           */
/*   Stored procedure:     sp_ods_insolvencias                           */
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
/*   Extraccion de datos para la generacion de archivo de interface ODS 5*/
/*   Insolvencias                                                        */
/*                              CAMBIOS                                  */
/*************************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_insolvencias')
    drop proc sp_ods_insolvencias
go

create proc sp_ods_insolvencias 
(
    @t_show_version     bit  =   0
)
as
declare
    @w_sp_name          varchar(20),
    @w_s_app            varchar(50),
    @w_path             varchar(255),
    @w_destino          varchar(2500),
    @w_msg              varchar(200),
    @w_error            int,
    @w_errores          varchar(1500),
    @w_comando          varchar(2500),
    @w_report_nombre    varchar(100),
    @w_reporte          varchar(10),
    @w_return           int,
    @w_existe_solicitud char (1) ,
    @w_ini_mes          datetime ,
    @w_fin_mes          datetime ,
    @w_fin_mes_hab      datetime ,
    @w_fin_mes_ant      datetime ,
    @w_fin_mes_ant_hab  datetime ,
    @w_ciudad_nacional  int,
    @w_dia              varchar(2),
    @w_mes              varchar(2),
   @w_anio              varchar(4),
    @w_ext_arch         varchar(6),
    @w_nom_arch         varchar(255),
    @w_nom_log          varchar(255),
    @w_fecha_proceso    datetime,
    @w_fecha_ini        datetime,
    @w_mensaje          varchar(150),
    @w_empresa          int,
	@w_cont             int,
    @w_fecha_piv        datetime,
    @w_ini_mov          datetime,
    @w_fin_mov          datetime,
	@w_formato_fecha    int,
	@w_batch            int,
	@w_param_conta_pro  varchar(10),
	@w_query            varchar(500)
	
		  
select @w_sp_name = 'sp_ods_insolvencias', @w_reporte = 'NINGUN'

select @w_formato_fecha = 112, @w_batch = 7515

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_fecha_ini = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fecha_proceso)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fecha_proceso)))

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1 
begin
   select @w_error = 70135
   goto ERROR_PROCESO
end

select @w_empresa = pa_tinyint 
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1 
begin
   select @w_error = 70135
   goto ERROR_PROCESO
end


select @w_param_conta_pro = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'PCPREP' and pa_producto = 'REC'

if @@error != 0 or @@rowcount != 1 
begin
   select @w_error = 70135
   goto ERROR_PROCESO
end


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


--El nombre del archivo sera COB_ODS_05<aaaa_mm_dd>.txt, donde la fecha corresponde a la fecha de fin de mes.
select @w_path = ba_path_destino,
       @w_report_nombre = ba_arch_resultado
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or 
   isnull(@w_path, '') = '' or 
   isnull(@w_report_nombre, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end


--Verificacion de Registro de Solicitud del Reporte
exec @w_return = cob_conta..sp_calcula_ultima_fecha_habil
     @i_reporte          = @w_reporte,
	 @i_fecha            = @w_fecha_ini,
     @o_existe_solicitud = @w_existe_solicitud  out,
     @o_ini_mes          = @w_ini_mes out,
     @o_fin_mes          = @w_fin_mes out,
     @o_fin_mes_hab      = @w_fin_mes_hab out,
     @o_fin_mes_ant      = @w_fin_mes_ant out,
     @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab out

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

SELECT
     '@i_reporte          ' = @w_reporte,
	  '@i_fecha            ' = @w_fecha_ini,
     '@o_existe_solicitud ' = @w_existe_solicitud  ,
     '@o_ini_mes          ' = @w_ini_mes ,
     '@o_fin_mes          ' = @w_fin_mes ,
     '@o_fin_mes_hab      ' = @w_fin_mes_hab ,
     '@o_fin_mes_ant      ' = @w_fin_mes_ant ,
     '@o_fin_mes_ant_hab  ' = @w_fin_mes_ant_hab 

if @w_existe_solicitud = 'N' goto SALIDA_PROCESO

	
--CONTROL PARA NO EJECUTAR SI NO ES EL 4TO DIA HABIL DEL MES
select 
@w_cont      = 0,
@w_fecha_piv = @w_fecha_proceso

while @w_fecha_piv >= @w_fecha_ini begin 
 if not exists (select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_piv) 
	select @w_cont = @w_cont +1

 select @w_fecha_piv = dateadd(dd, -1, @w_fecha_piv)  
end 
--select @w_fecha_ini, @w_fecha_piv, @w_cont
if @w_cont < 5 
BEGIN
	 print' SALE porque no debe ejecutarse antes del dia 4  DIA = ' + convert(VARCHAR, @w_cont )
    goto SALIDA_PROCESO
END 
  
if exists (select 1 from sb_ods_ult_ejec where ou_archivo = @w_report_nombre and ou_fecha = @w_fin_mov) 
BEGIN
   PRINT 'sale porque ya existe datos sb_ods_ult_ejec '
   goto SALIDA_PROCESO --Si ya esta generado el archivo ,no se genera
END

insert into sb_ods_ult_ejec values (@w_report_nombre, @w_fin_mov) --Tabla que lleva el registro de la ejecucion fin mes


--determinar fin mes anteriores habiles 

select
@w_fin_mes_ant_hab   = eomonth(dateadd(dd,1-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)),
@w_fin_mes_hab       = eomonth(dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)),
@w_fin_mes           = @w_fin_mes_hab 


while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fin_mes_hab ) 
   select @w_fin_mes_hab = dateadd(dd,-1,@w_fin_mes_hab)
   
while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fin_mes_ant_hab ) 
   select @w_fin_mes_ant_hab  = dateadd(dd,-1,@w_fin_mes_ant_hab)

     
select 
@w_dia      = right('00' + convert(varchar(2), datepart(dd, @w_fin_mes_hab)), 2),
@w_mes      = right('00' + convert(varchar(2), datepart(mm, @w_fin_mes_hab)), 2),
@w_anio     = 'M'+right(convert(varchar(4),   datepart(yyyy,@w_fin_mes_hab)),2),
@w_nom_arch = @w_report_nombre + '_' +@w_anio + @w_mes + @w_dia +'.' + 'txt',
@w_nom_log  = @w_report_nombre + '_' +@w_anio + @w_mes + @w_dia + '.err',
@w_ini_mov  = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fin_mes_hab)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fin_mes_hab))),
@w_fin_mov  = @w_fin_mes
	   
   
--Creacion de estructura temporal para resultados finales
select 
'cliente'     = convert(int, null),
'banco'       = convert(varchar(25), null),
'toperacion'  = convert(varchar(10), null),
'oficina'     = convert(smallint, null),
'area'        = convert(smallint, null),
'tinsolvencia'= convert(char(2), null),
'tprovision'  = convert(char(2), null),
'calificacion'= convert(varchar(10), null),
'cuenta'      = convert(varchar(25), null),
'saldo_mo'    = convert(money, null), 
'saldo_ml'    = convert(money, null) 
into #resultados 
from cob_conta_super..sb_ods_insolvencias
where 1=2

if @@error != 0
begin
   select @w_error = 70153
   goto ERROR_PROCESO
end


--Consultar informacion inicial para Ctas de Provisiones
select	
'cliente'      = do_codigo_cliente, 
'banco'        = do_banco, 
'fecha'	       = do_fecha,
'oficina'      = do_oficina,
'provision'    = -1*isnull(do_provision,0) 
into #datos_provisiones
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_ant_hab
and   do_tipo_operacion not in ('REVOLVENTE')
and do_aplicativo	= 7


if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end

--Consultar informacion inicial para Ctas de Provisiones
insert into #datos_provisiones
select 
'cliente'      = do_codigo_cliente, 
'banco'        = do_banco, 
'fecha'	       = do_fecha,
'oficina'      = do_oficina,
'provision'    = isnull(do_provision,0)
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_hab
and do_tipo_operacion not in ('REVOLVENTE')
and do_aplicativo	= 7

if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end


--Ingresar en resultados informacion para Ctas de Provisiones
insert into #resultados 
(
cliente,       banco,         toperacion,
oficina,       area,          tinsolvencia,  
tprovision,    calificacion,  cuenta,     
saldo_mo,      saldo_ml
)
select	
cliente,       banco,         null, 
oficina,       1090,          '03',  
'CO',          null,          null,        
sum(provision), sum(provision)
from #datos_provisiones
group by cliente, banco,  oficina

if @@error != 0
begin
   select @w_error = 70153
   goto ERROR_PROCESO
end

--Actualizar informacion complementaria para Ctas de Provisiones
update #resultados set  
cuenta = re_substring,
area   = 1090                              -- AREA COMERCIAL 
from cob_conta..cb_relparam
where re_empresa= @w_empresa
and re_parametro= @w_param_conta_pro
and re_clave	= (toperacion + '.' + calificacion)

if @@error != 0
begin
   select @w_error = 70142
   goto ERROR_PROCESO
end


--Consultar informacion inicial para Ctas de Quitas (Condonaciones)
insert into #resultados 
select 
'cliente'      = isnull(sa_ente, -999),
'banco'        = isnull(sa_documento, 'NO EXISTE'),
'toperacion'   = null, 
'oficina'      = sa_oficina_dest,
'area'         = sa_area_dest,
'tinsolvencia' = '06',
'tprovision'   = 'CD',
'calificacion' = null,
'cuenta'       = sa_cuenta,
'saldo_mo'     = sum(sa_debito -sa_credito),
'saldo_ml'     = sum(sa_debito -sa_credito)
from cob_conta_tercero..ct_sasiento
where sa_empresa	= @w_empresa
and sa_fecha_tran	between @w_ini_mov and @w_fin_mov
and sa_cuenta		in (select ca_cta_asoc from cob_conta..cb_cuenta_asociada where ca_proceso = 36419 and ca_condicion = 1)
group by sa_ente, sa_documento,  sa_oficina_dest, sa_area_dest, sa_cuenta

if @@error != 0
begin
   select @w_error = 70154
   goto ERROR_PROCESO
end


--Consultar informacion inicial para Ctas de Castigos

insert into    #resultados 
select 
'cliente'      = isnull(sa_ente, -999),
'banco'        = isnull(sa_documento, 'NO EXISTE'),
'toperacion'   = convert(varchar(10), 'NO EXISTE'),
'oficina'      = sa_oficina_dest,
'area'         = sa_area_dest,
'tinsolvencia' = '04',
'tprovision'   = 'CA',
'calificacion' = null,
'cuenta'       = sa_cuenta,
'saldo_mo'     = sum(sa_debito -sa_credito),
'saldo_ml'     = sum(sa_debito -sa_credito)
from cob_conta_tercero..ct_sasiento
where sa_empresa	= @w_empresa 
and sa_fecha_tran	between @w_ini_mov and @w_fin_mov
and sa_cuenta		in (select ca_cta_asoc from cob_conta..cb_cuenta_asociada where ca_proceso = 36419 and ca_condicion = 2)
group by sa_ente, sa_documento,  sa_oficina_dest, sa_area_dest, sa_cuenta

if @@error != 0
begin
   select @w_error = 70157
   goto ERROR_PROCESO
end



update #resultados set
calificacion = do_calificacion, 
toperacion   = do_tipo_operacion 
from cob_conta_super..sb_dato_operacion
where banco         = do_banco 
and do_aplicativo	= 7

update #resultados set  cliente = en_banco 
from cobis..cl_ente 
where en_ente = cliente 

select distinct(do_banco) 
into #op_borrar
from sb_dato_operacion where do_tipo_operacion = 'REVOLVENTE' and do_fecha between @w_ini_mov and @w_fin_mov

delete from #resultados
where banco in (select do_banco from #op_borrar)

--Registro de Informacion del Reporte en Estructura Final
truncate table sb_ods_insolvencias

insert into sb_ods_insolvencias 
(
 oi_idf_cto_ods,      
 oi_idf_pers_ods,        
 oi_cod_cta_cont,
 oi_cod_centro_cont,  
 oi_tip_sdo_insolvencia, 
 oi_cod_divisa,
 oi_idf_concepto,     
 oi_fec_data,            
 oi_cod_entidad,
 oi_cod_centro,       
 oi_cod_producto,        
 oi_cod_subprodu,
 oi_num_cuenta,       
 oi_tip_divisa,          
 oi_cod_tip_prov_mis,
 oi_cod_tip_prov_loc, 
 oi_ind_criterio_prov,   
 oi_cod_riesgo_local,
 oi_cod_cartera,      
 oi_imp_sdo_mo,          
 oi_imp_sdo_ml
)	  
select 
ltrim(rtrim(banco)), 
cliente,  
ltrim(rtrim(cuenta)),
oficina, 
tinsolvencia,
'MXP',
'',
convert(varchar(8), @w_fin_mes_hab, @w_formato_fecha),
78, 
area,         
96,
case toperacion
  when 'GRUPAL' then '1'
  when 'INDIVIDUAL' then '2'
  when 'INTERCICLO' then '3'
end, 
ltrim(rtrim(banco)), 
1,
'S',
tprovision, 
'S', 
calificacion,
'',
saldo_mo,
saldo_ml
from #resultados
		   
if @@error <> 0
begin
   select @w_error = 70144
   goto ERROR_PROCESO
end   	
 
--Actualizar linea de detalle del archivo
update sb_ods_insolvencias
set oi_registro_archivo = convert(varchar,isnull(oi_idf_cto_ods, ''))        +'|'+ 
                          convert(varchar,isnull(oi_idf_pers_ods, 0))        +'|'+ 
						  convert(varchar,isnull(oi_cod_cta_cont, ''))       +'|'+
                          convert(varchar,isnull(oi_cod_centro_cont, 0))     +'|'+ 
						  convert(varchar,isnull(oi_tip_sdo_insolvencia,0))  +'|'+ 
						  convert(varchar,isnull(oi_cod_divisa,''))          +'|'+
                          convert(varchar,isnull(ltrim(oi_idf_concepto),'')) +'|'+ 
						  convert(varchar,isnull(oi_fec_data,0))             +'|'+ 
						  '00'+convert(varchar,isnull(oi_cod_entidad,0))     +'|'+
                          convert(varchar,isnull(oi_cod_centro,0))           +'|'+ 
						  convert(varchar,isnull(oi_cod_producto,0))         +'|'+ 
						  convert(varchar,isnull(oi_cod_subprodu,0))         +'|'+
                          convert(varchar,isnull(oi_num_cuenta,0))           +'|'+ 
						  convert(varchar,isnull(oi_tip_divisa,0))           +'|'+ 
						  convert(varchar,isnull(oi_cod_tip_prov_mis, ''))   +'|'+
                          convert(varchar,isnull(oi_cod_tip_prov_loc, ''))   +'|'+ 
						  convert(varchar,isnull(oi_ind_criterio_prov, ''))  +'|'+ 
						  convert(varchar,isnull(oi_cod_riesgo_local, ''))   +'|'+   
                          convert(varchar,isnull(ltrim(oi_cod_cartera), '')) +'|'+ 
						  convert(varchar,isnull(oi_imp_sdo_mo, 0))          +'|'+ 
						  convert(varchar,isnull(oi_imp_sdo_ml, 0))   

if @@error <> 0
begin
   select @w_error = 724533
   goto ERROR_PROCESO
end						  

--Geneacion del BCP para creacion del archivo 
select @w_query   = 'select oi_registro_archivo from cob_conta_super..sb_ods_insolvencias order by oi_idf_cto_ods, oi_idf_pers_ods, oi_cod_cta_cont'

select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_05<aaaa_mm_dd>.txt
	   @w_errores = @w_path + @w_nom_log   -- COB_ODS_05<aaaa_mm_dd>.err
	   
select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

-- PRINT 'Comando: ' + @w_comando

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


