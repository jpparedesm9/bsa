/*************************************************************************/
/*   Archivo:            base_A_0419.sp                                  */
/*   Stored procedure:   sp_base_A_0419                                  */
/*   Base de datos:      cob_conta_super                                 */
/*   Producto:           Cartera                                         */
/*   Disenado por:       DFu                                             */
/*   Fecha de escritura: 23/08/2017                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Genera el formato base para el reporte regulatorio A-0419           */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   23-08-2017          DFu                   Emision Inicial           */
/*************************************************************************/

use cob_conta_super
go

if object_id ('sp_base_A_0419') is not null
   drop procedure sp_base_A_0419
go

create procedure sp_base_A_0419

as

declare 
@w_mensaje          varchar(150),
@w_fecha_proceso    datetime,
@w_fin_mes_ant_hab  datetime,
@w_fin_mes_hab      datetime,
@w_ini_mes          datetime,
@w_fin_mes          datetime,
@w_corte_ini        int,
@w_corte_fin        int,
@w_periodo_ini      int,
@w_periodo_fin      int,
@w_error            int,
@w_return           int,
@w_empresa          tinyint,
@w_producto         tinyint,
@w_error_msg        varchar(255),
@w_tab              char(1),
@w_ruta_arch		varchar(255),
@w_nombre_arch		varchar(30),
@w_sp_name			varchar(30),
@w_sql_bcp          varchar(500),
@w_fecha_aux        datetime,
@w_feriado          char(1),
@w_ciudad           smallint,
@w_reporte          catalogo,
@w_solicitud        char(1)

declare @resultadobcp table (linea varchar(max))

select @w_tab           = char(9),
	   @w_empresa		= 1,
	   @w_producto		= 7,
       @w_sp_name       = 'sp_base_A_0419',
	   @w_reporte       = 'A0419'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


exec @w_return = cob_conta..sp_calcula_ultima_fecha_habil
@i_reporte			= @w_reporte,
@o_existe_solicitud = @w_solicitud out,
@o_ini_mes			= @w_ini_mes out,
@o_fin_mes			= @w_fin_mes out,
@o_fin_mes_hab      = @w_fin_mes_hab out,
@o_fin_mes_ant_hab  = @w_fin_mes_ant_hab out

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR
end

if @w_solicitud = 'N' goto SALIDA_PROCESO
	   
--obtiene la ruta del .lis
select 
@w_ruta_arch	= ba_path_destino,
@w_nombre_arch	= replace(ba_arch_resultado, '.', ('_' + replace(convert(varchar, @w_fin_mes, 106), ' ', '_') + '.'))
from cobis..ba_batch
where ba_batch = 36419

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR
end


--Consultar las provisiones
select 
'cliente'         = do_codigo_cliente,
'banco'           = do_banco,
'toperacion'      = do_tipo_operacion,
'provision_ini'   = isnull(do_provision,0),
'provision_fin'   = convert(money,0)
into #provisiones
from sb_dato_operacion
where do_aplicativo = @w_producto
and do_fecha		= @w_fin_mes_ant_hab

if @@error != 0-- or @@rowcount != 1
begin
   select @w_error = 70151
   goto ERROR
end

insert into #provisiones
select 
'cliente'         = do_codigo_cliente,
'banco'           = do_banco,
'toperacion'      = do_tipo_operacion,
'provision_ini'   = convert(money,0),
'provision_fin'   = isnull(do_provision,0)
from sb_dato_operacion
where do_aplicativo = @w_producto
and do_fecha		= @w_fin_mes_hab

if @@error != 0 or @@rowcount <= 0
begin
   select @w_error = 70152
   goto ERROR
end

select 
'cliente'         = cliente,
'banco'           = banco,
'toperacion'      = toperacion,
'provision_ini'   = sum(provision_ini),
's_quitas'        = convert(money,0), 
's_castigos'      = convert(money,0), 
's_bonificacion'  = convert(money,0),
's_daciones'      = convert(money,0),
's_var_provision' = convert(money,0), --(cambiar temporalmente a 0)
's_var_cambiaria' = convert(money,0),
'e_bonificacion'  = convert(money,0),
'e_daciones'      = convert(money,0),
'e_var_provision' = convert(money,0), --(cambiar temporalmente a 0)
'e_var_cambiaria' = convert(money,0),
'provision_fin'   = sum(provision_fin) 
into #resultados 
from #provisiones 
group by cliente, banco, toperacion

if @@error != 0 or @@rowcount <= 0
begin
   select @w_error = 70153
   goto ERROR
end

--Actualiza movimientos al debito por Quitas
select 
'ente'     = isnull(sa_ente, -999),
'banco'    = isnull(sa_documento, 'NO EXISTE'),
'toperacion'= convert(varchar(10), 'NO EXISTE'),
'fecha'	   = sa_fecha_tran,
'debitos'  = sum(sa_debito),
'creditos' = sum(sa_credito)
into #quitas 
from cob_conta_tercero..ct_sasiento
where sa_empresa	= @w_empresa
and sa_fecha_tran	between @w_ini_mes and @w_fin_mes 
and sa_cuenta		in (select ca_cta_asoc from cob_conta..cb_cuenta_asociada where ca_proceso = 36419 and ca_condicion = 1)
group by sa_ente, sa_documento, sa_fecha_tran

if @@error != 0
begin
   select @w_error = 70154
   goto ERROR
end

update #quitas
set toperacion = do_tipo_operacion
from sb_dato_operacion
where fecha			= do_fecha
and do_aplicativo	= 7
and banco			= do_banco

if @@error != 0
begin
   select @w_error = 70155
   goto ERROR
end

insert into #resultados (
cliente, banco, toperacion, 
provision_ini, s_quitas, s_castigos, 
s_bonificacion, s_daciones, s_var_provision, 
s_var_cambiaria, e_bonificacion, e_daciones, 
e_var_provision, e_var_cambiaria, provision_fin)
select	
ente, banco, toperacion, 
convert(money,0), sum(debitos - creditos), convert(money,0), 
convert(money,0), convert(money,0), convert(money,0), 
convert(money,0), convert(money,0), convert(money,0), 
convert(money,0), convert(money,0), convert(money,0)
from #quitas
group by ente, banco, toperacion

if @@error != 0
begin
   select @w_error = 70156
   goto ERROR
end

--Actualiza movimientos al debito por Castigos
select 
'ente'     = isnull(sa_ente, -999),
'banco'    = isnull(sa_documento, 'NO EXISTE'),
'toperacion'= convert(varchar(10), 'NO EXISTE'),
'fecha'	   = sa_fecha_tran,
'debitos'  = sum(sa_debito),
'creditos' = sum(sa_credito)
into #castigos 
from cob_conta_tercero..ct_sasiento
where sa_empresa	= @w_empresa 
and sa_fecha_tran	between @w_ini_mes and @w_fin_mes 
and sa_cuenta		in (select ca_cta_asoc from cob_conta..cb_cuenta_asociada where ca_proceso = 36419 and ca_condicion = 2)
group by sa_ente, sa_documento, sa_fecha_tran

if @@error != 0
begin
   select @w_error = 70157
   goto ERROR
end

update #castigos
set toperacion = do_tipo_operacion
from sb_dato_operacion
where fecha			= do_fecha
and do_aplicativo	= 7
and banco			= do_banco

if @@error != 0
begin
   select @w_error = 70158
   goto ERROR
end

insert into #resultados (
cliente, banco, toperacion, 
provision_ini, s_quitas, s_castigos, 
s_bonificacion, s_daciones, s_var_provision, 
s_var_cambiaria, e_bonificacion, e_daciones, 
e_var_provision, e_var_cambiaria, provision_fin
)
select	
ente, banco, toperacion, 
convert(money,0), convert(money,0), sum(debitos - creditos), 
convert(money,0), convert(money,0), convert(money,0), 
convert(money,0), convert(money,0), convert(money,0), 
convert(money,0), convert(money,0), convert(money,0)
from #castigos
group by ente, banco, toperacion

if @@error != 0
begin
   select @w_error = 70159
   goto ERROR
end

--Actualiza movimientos al debito y credito por Bonificaciones
select 
'ente'     = isnull(sa_ente, -999),
'banco'    = isnull(sa_documento, 'NO EXISTE'),
'toperacion'= convert(varchar(10), 'NO EXISTE'),
'fecha'	   = sa_fecha_tran,
'debitos'  = sum(sa_debito),
'creditos' = sum(sa_credito)
into #bonificaciones 
from cob_conta_tercero..ct_sasiento
where sa_empresa	= @w_empresa
and sa_fecha_tran	between @w_ini_mes and @w_fin_mes 
and sa_cuenta		in (select ca_cta_asoc from cob_conta..cb_cuenta_asociada where ca_proceso = 36419 and ca_condicion = 3)
group by sa_ente, sa_documento, sa_fecha_tran

if @@error != 0
begin
   select @w_error = 70160
   goto ERROR
end

update #bonificaciones
set toperacion = do_tipo_operacion
from sb_dato_operacion
where fecha			= do_fecha
and do_aplicativo	= 7
and banco			= do_banco

if @@error != 0
begin
   select @w_error = 70161
   goto ERROR
end

insert into #resultados (
cliente, banco, toperacion, 
provision_ini, s_quitas, s_castigos, 
s_bonificacion, s_daciones, s_var_provision, 
s_var_cambiaria, e_bonificacion, e_daciones, 
e_var_provision, e_var_cambiaria, provision_fin
)
select 
ente, banco, toperacion, 
convert(money,0), convert(money,0), convert(money,0), 
sum(debitos), convert(money,0), convert(money,0), 
convert(money,0), sum(creditos), convert(money,0), 
convert(money,0), convert(money,0), convert(money,0)
from #bonificaciones
group by ente, banco, toperacion

if @@error != 0
begin
   select @w_error = 70162
   goto ERROR
end

--Actualiza movimientos al debito y credito por daciones al pago
select 
'ente'     = isnull(sa_ente, -999),
'banco'    = isnull(sa_documento, 'NO EXISTE'),
'toperacion'= convert(varchar(10), 'NO EXISTE'),
'fecha'	   = sa_fecha_tran,
'debitos'  = sum(sa_debito),
'creditos' = sum(sa_credito)
into #daciones 
from cob_conta_tercero..ct_sasiento
where sa_empresa	= @w_empresa
and sa_fecha_tran	between @w_ini_mes and @w_fin_mes 
and sa_cuenta		in (select ca_cta_asoc from cob_conta..cb_cuenta_asociada where ca_proceso = 36419 and ca_condicion = 4)
group by sa_ente, sa_documento, sa_fecha_tran

if @@error != 0
begin
   select @w_error = 70163
   goto ERROR
end

update #daciones
set toperacion = do_tipo_operacion
from sb_dato_operacion
where fecha			= do_fecha
and do_aplicativo	= 7
and banco			= do_banco

if @@error != 0
begin
   select @w_error = 70164
   goto ERROR
end

insert into #resultados(
cliente, banco, toperacion, 
provision_ini, s_quitas, s_castigos, 
s_bonificacion, s_daciones, s_var_provision, 
s_var_cambiaria, e_bonificacion, e_daciones, 
e_var_provision, e_var_cambiaria, provision_fin)
select 
ente, banco, toperacion, 
convert(money,0), convert(money,0), convert(money,0), 
convert(money,0), sum(debitos), convert(money,0), 
convert(money,0), convert(money,0), sum(creditos), 
convert(money,0), convert(money,0), convert(money,0)
from #daciones
group by ente, banco, toperacion

if @@error != 0
begin
   select @w_error = 70165
   goto ERROR
end


update #resultados 
set   
s_var_provision = case when (provision_fin - provision_ini + (s_quitas + s_castigos + s_bonificacion + s_daciones + s_var_cambiaria) - (e_bonificacion + e_daciones + e_var_cambiaria)) < 0 
                     then abs((provision_fin - provision_ini + (s_quitas + s_castigos + s_bonificacion + s_daciones + s_var_cambiaria) - (e_bonificacion + e_daciones + e_var_cambiaria)))
                     else 0 
				  end,
e_var_provision = case when (provision_fin - provision_ini + (s_quitas + s_castigos + s_bonificacion + s_daciones + s_var_cambiaria) - (e_bonificacion + e_daciones + e_var_cambiaria)) > 0 
                     then abs((provision_fin - provision_ini + (s_quitas + s_castigos + s_bonificacion + s_daciones + s_var_cambiaria) - (e_bonificacion + e_daciones + e_var_cambiaria)))
                     else 0 
				  end

if @@error != 0
begin
   select @w_error = 70169
   goto ERROR
end


truncate table sb_base_A04219

insert into sb_base_A04219 (
ba_cliente         ,ba_banco           ,ba_toperacion       ,ba_provision_ini    ,ba_s_quitas,
ba_s_castigos      ,ba_s_bonificacion  ,ba_s_daciones       ,ba_s_var_provision  ,ba_s_var_cambiaria,
ba_e_bonificacion  ,ba_e_daciones      ,ba_e_var_provision  ,ba_e_var_cambiaria  ,ba_provision_fin)
values (
'CODIGO CLIENTE',	'NO PRESTAMO',		'TOPERACION',		'PROVISION_INI',	'S_QUITAS',
'S_CASTIGOS',		'S_BONIFICACION',	'S_DACIONES',		'S_VAR_PROVISION',	'S_VAR_CAMBIARIA',
'E_BONIFICACION',	'E_DACIONES',		'E_VAR_PROVISION',	'E_VAR_CAMBIARIA',	'PROVISION_FIN'
)

if @@error != 0 or @@rowcount <= 0
begin
   select @w_error = 70170
   goto ERROR
end

insert into sb_base_A04219 (
ba_cliente         ,ba_banco           ,ba_toperacion       ,
ba_provision_ini   ,ba_s_quitas        ,ba_s_castigos       ,
ba_s_bonificacion  ,ba_s_daciones      ,ba_s_var_provision  ,
ba_s_var_cambiaria ,ba_e_bonificacion  ,ba_e_daciones       ,
ba_e_var_provision ,ba_e_var_cambiaria ,ba_provision_fin
)
select
convert(varchar, cliente), convert(varchar, banco), toperacion, 
convert(varchar, sum(provision_ini)),   convert(varchar, sum(s_quitas)),        convert(varchar, sum(s_castigos)), 
convert(varchar, sum(s_bonificacion)),  convert(varchar, sum(s_daciones)),      convert(varchar, sum(s_var_provision)), 
convert(varchar, sum(s_var_cambiaria)), convert(varchar, sum(e_bonificacion)),  convert(varchar, sum(e_daciones)), 
convert(varchar, sum(e_var_provision)), convert(varchar, sum(e_var_cambiaria)), convert(varchar, sum(provision_fin))
from #resultados
group by cliente, banco, toperacion
having sum(provision_ini) != 0 
	or sum(s_quitas) != 0 
	or sum(s_castigos) != 0 
	or sum(s_bonificacion) != 0 
	or sum(s_daciones) != 0 
	or sum(s_var_provision) != 0
    or sum(s_var_cambiaria) != 0 
	or sum(e_bonificacion) != 0 
	or sum(e_daciones) != 0 
	or sum(e_var_provision) != 0 
	or sum(e_var_cambiaria) != 0 
	or sum(provision_fin) != 0

if @@error != 0 or @@rowcount <= 0
begin
   select @w_error = 70170
   goto ERROR
end

--select @w_ruta    = '\\192.168.66.108\Regulatorios\listados\'
--select @w_archivo = 'Rep_A_0419_' + convert(varchar(8), @w_fecha_proceso, 112) + '.lis'

select  @w_sql_bcp = 'bcp "' + 'select * from cob_conta_super..sb_base_A04219' + '" queryout "' + @w_ruta_arch + @w_nombre_arch + '" -c -T'

delete from @resultadobcp
insert into @resultadobcp
exec @w_error = xp_cmdshell @w_sql_bcp;

if @w_error != 0 
begin
    select @w_error_msg = 'Error al intentar generar el archivo', @w_error = 70171
    goto ERROR
end

select * from @resultadobcp

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
if @w_mensaje is null
    select top 1 @w_mensaje =  linea 
         from @resultadobcp 
         where upper(linea) LIKE upper('%Error %')

if @w_mensaje is not null
begin
	select @w_error = 70170
	goto ERROR
end

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I' 

if @@error != 0
begin
	select @w_error = 710002
	goto ERROR
end

SALIDA_PROCESO:
   return 0

ERROR:
	select @w_error_msg = mensaje
		from cobis..cl_errores with (nolock)
		where numero = @w_error
		set transaction isolation level read uncommitted

	select @w_error_msg = isnull(@w_error_msg, @w_mensaje)

exec cob_conta_super..sp_errorlog 
		@i_operacion	= 'I',
		@i_fecha_fin	= @w_fecha_proceso,
		@i_origen_error = @w_error, 
		@i_fuente		= @w_sp_name,
		@i_descrp_error = @w_error_msg

   return @w_error
go

