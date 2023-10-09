/*************************************************************************/
/*   Archivo:              base_A_0420.sp                                */
/*   Stored procedure:     sp_base_A_0420                                */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Raúl Altamirano Mendez                        */
/*   Fecha de escritura:   Agosto 2017                                   */
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
/*   Extraccion de datos para la generacion del Reporte Base para Regula */
/*   torio A0420                                                         */
/*                              CAMBIOS                                  */
/*************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_base_A_0420')
   drop proc sp_base_A_0420
go

create proc sp_base_A_0420

as

declare 
        @w_error                int,
        @w_return               int,
        @w_mensaje              varchar(150),
        @w_sql                  varchar(5000),
        @w_sql_bcp              varchar(5000),
        @w_fecha_proceso        datetime,
        @w_fecha_real           datetime,
        @w_fecha_proceso_aux    datetime,
        @w_fecha_proceso_aux1   datetime,
        @w_formato_fecha        int,
		@w_ini_mes              datetime,
		@w_fin_mes_ori          datetime, 
		@w_fin_mes_ant_ori      datetime,
        @w_fin_mes_ant_hab      datetime,
        @w_fin_mes_hab          datetime,
        @w_ini_mov              datetime,
        @w_fin_mov              datetime,
        @w_ruta_arch            varchar(255),
        @w_nombre_arch          varchar(30),
        @w_sp_name              varchar(30),
        @w_msg                  varchar(255),
        @w_ciudad_nacional      int,
        @w_periodo_fma          int,
        @w_corte_fma            int,
        @w_periodo_fin          int,
        @w_corte_fin            int,
        @w_batch                int,
        @w_empresa              int,
		@w_reporte              catalogo,
		@w_solicitud            char(1)


select @w_sp_name = 'sp_base_A_0420', @w_reporte = 'A0420'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

declare @resultadobcp table (linea varchar(max))


exec @w_return = cob_conta..sp_calcula_ultima_fecha_habil
@i_reporte			= @w_reporte,
@o_existe_solicitud = @w_solicitud out,
@o_ini_mes			= @w_ini_mes out,
@o_fin_mes          = @w_fin_mes_ori out,
@o_fin_mes_hab		= @w_fin_mes_hab out,
@o_fin_mes_ant	    = @w_fin_mes_ant_ori out,
@o_fin_mes_ant_hab  = @w_fin_mes_ant_hab out

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

if @w_solicitud = 'N' goto SALIDA_PROCESO


select @w_empresa = pa_tinyint from cobis..cl_parametro 
where pa_nemonico = 'EMP' and pa_producto = 'ADM'

select @w_formato_fecha = 111, @w_batch = 36420

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = replace(ba_arch_resultado, '.', ('_' + replace(convert(varchar, @w_fin_mes_ori, 106), ' ', '_') + '.'))
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end

select @w_ini_mov = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fin_mes_ori)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fin_mes_ori))),
       @w_fin_mov = @w_fin_mes_ori


select
@w_periodo_fma  = co_periodo,
@w_corte_fma    = co_corte
from cob_conta..cb_corte
where co_fecha_fin  = @w_fin_mes_ant_ori
and co_empresa      = @w_empresa

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 70136
   goto ERROR_PROCESO
end

select 
@w_periodo_fin  = co_periodo,
@w_corte_fin    = co_corte
from cob_conta..cb_corte
where co_fecha_fin  = @w_fin_mes_ori
and co_empresa      = @w_empresa

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 70136
   goto ERROR_PROCESO
end

select cu_cuenta, cu_cuenta_padre, cp_texto
into #cuentas
from cob_conta..cb_cuenta, cob_conta..cb_cuenta_proceso
where cu_movimiento = 'S'
and cu_cuenta_padre = cp_cuenta
and cp_proceso      = 36411
and cu_empresa      = @w_empresa
and cp_texto        like '%VEN%'

if @@error != 0 or @@rowcount = 0
begin
   select @w_error = 70137
   goto ERROR_PROCESO
end


select
si_cliente      = st_ente,
si_banco        = convert(varchar(24), null),
si_toperacion   = convert(varchar(10), null),
si_fecha_tran   = @w_fin_mes_ant_ori,
'CAP_VEN_NE_INI' = sum(case when cp_texto = 'CAP VEN NE' then st_saldo else 0 end),
'CAP_VEN_EX_INI' = sum(case when cp_texto = 'CAP VEN EX' then st_saldo else 0 end),
'INT_VEN_EX_INI' = sum(case when cp_texto = 'INT VEN EX' then st_saldo else 0 end)
into #saldos_ini
from cob_conta_tercero..ct_saldo_tercero, #cuentas
where st_cuenta = cu_cuenta
and st_empresa  = @w_empresa
and st_corte    = @w_corte_fma
and st_periodo  = @w_periodo_fma
group by st_ente

if @@error != 0  begin
   select @w_error = 70138
   goto ERROR_PROCESO
end

select
sf_cliente      = st_ente,
sf_banco        = convert(varchar(24), null),
sf_toperacion   = convert(varchar(10), null),
sf_fecha_tran   = @w_fin_mes_ori,
'CAP_VEN_NE_FIN' = sum(case when cp_texto = 'CAP VEN NE' then st_saldo else 0 end),
'CAP_VEN_EX_FIN' = sum(case when cp_texto = 'CAP VEN EX' then st_saldo else 0 end),
'INT_VEN_EX_FIN' = sum(case when cp_texto = 'INT VEN EX' then st_saldo else 0 end)
into #saldos_fin
from cob_conta_tercero..ct_saldo_tercero, #cuentas
where st_cuenta = cu_cuenta
and st_empresa  = @w_empresa
and st_corte    = @w_corte_fin
and st_periodo  = @w_periodo_fin
group by st_ente

if @@error != 0 begin
   select @w_error = 70138
   goto ERROR_PROCESO
end


select
mv_cliente     = sa_ente,
mv_banco       = convert(varchar(24), null),
mv_toperacion  = convert(varchar(10), null),
mv_causal      = cp_texto,
mv_fecha       = sc_fecha_tran,
E_vcto_cartera = sum(case when sc_perfil = ('CCA_EST') then (sa_debito) else 0 end),
E_comp_cartera = sum(case when sc_perfil = ('CCA_COM') then (sa_debito - sa_credito) else 0 end),
S_vcto_cuota   = sum(case when sc_perfil = ('CCA_VEN') then (sa_credito - sa_debito) else 0 end),
S_regr_vigente = sum(case when sc_perfil = ('CCA_EST') then (sa_credito) else 0 end),
S_cast_quitas  = sum(case when sc_perfil = ('CCA_CAS') then (sa_credito - sa_debito) else 0 end),
S_pago         = sum(case when sc_perfil = ('CCA_PAG') then (sa_credito - sa_debito) else 0 end)
into #movimientos
from cob_conta_tercero..ct_scomprobante,
     cob_conta_tercero..ct_sasiento, #cuentas
where sc_fecha_tran  between @w_ini_mov and @w_fin_mov
and   sc_producto    = 7
and   sc_empresa     = @w_empresa
and   sa_comprobante = sc_comprobante
and   sa_fecha_tran  = sc_fecha_tran
and   sa_producto    = sc_producto
and   sa_asiento     > 0
and   sa_cuenta      = cu_cuenta  --in (select cu_cuenta from #cuentas)
--group by sa_ente, sa_documento
group by sa_ente, cp_texto, sc_fecha_tran

select 
cliente    = si_cliente,
banco      = si_banco,
toperacion = si_toperacion,

CAP_VEN_NE_INI,
CAP_VEN_EX_INI,
INT_VEN_EX_INI,

E_vcto_cartera_cap_ven_ne = convert(money, 0),
E_comp_cartera_cap_ven_ne = convert(money, 0),
S_vcto_cuota_cap_ven_ne   = convert(money, 0),
S_regr_vigente_cap_ven_ne = convert(money, 0),
S_cast_quitas_cap_ven_ne  = convert(money, 0),
S_pago_cap_ven_ne         = convert(money, 0),

E_vcto_cartera_cap_ven_ex = convert(money, 0),
E_comp_cartera_cap_ven_ex = convert(money, 0),
S_vcto_cuota_cap_ven_ex   = convert(money, 0),
S_regr_vigente_cap_ven_ex = convert(money, 0),
S_cast_quitas_cap_ven_ex  = convert(money, 0),
S_pago_cap_ven_ex         = convert(money, 0),

E_vcto_cartera_int_ven_ex = convert(money, 0),
E_comp_cartera_int_ven_ex = convert(money, 0),
S_vcto_cuota_int_ven_ex   = convert(money, 0),
S_regr_vigente_int_ven_ex = convert(money, 0),
S_cast_quitas_int_ven_ex  = convert(money, 0),
S_pago_int_ven_ex         = convert(money, 0),

CAP_VEN_NE_FIN = convert(money, 0),
CAP_VEN_EX_FIN = convert(money, 0),
INT_VEN_EX_FIN = convert(money, 0)
into #resultado
from #saldos_ini

insert into #resultado
select
cliente    = mv_cliente,
banco      = mv_banco,
toperacion = mv_toperacion,

CAP_VEN_NE_INI = convert(money, 0),
CAP_VEN_EX_INI = convert(money, 0),
INT_VEN_EX_INI = convert(money, 0),

E_vcto_cartera_cap_ven_ne = sum(case when mv_causal = 'CAP VEN NE' then E_vcto_cartera else 0 end),
E_comp_cartera_cap_ven_ne = sum(case when mv_causal = 'CAP VEN NE' then E_comp_cartera else 0 end),
S_vcto_cuota_cap_ven_ne   = sum(case when mv_causal = 'CAP VEN NE' then S_vcto_cuota   else 0 end),
S_regr_vigente_cap_ven_ne = sum(case when mv_causal = 'CAP VEN NE' then S_regr_vigente else 0 end),
S_cast_quitas_cap_ven_ne  = sum(case when mv_causal = 'CAP VEN NE' then S_cast_quitas  else 0 end),
S_pago_cap_ven_ne         = sum(case when mv_causal = 'CAP VEN NE' then S_pago         else 0 end),

E_vcto_cartera_cap_ven_ex = sum(case when mv_causal = 'CAP VEN EX' then E_vcto_cartera else 0 end),
E_comp_cartera_cap_ven_ex = sum(case when mv_causal = 'CAP VEN EX' then E_comp_cartera else 0 end),
S_vcto_cuota_cap_ven_ex   = sum(case when mv_causal = 'CAP VEN EX' then S_vcto_cuota   else 0 end),
S_regr_vigente_cap_ven_ex = sum(case when mv_causal = 'CAP VEN EX' then S_regr_vigente else 0 end),
S_cast_quitas_cap_ven_ex  = sum(case when mv_causal = 'CAP VEN EX' then S_cast_quitas  else 0 end),
S_pago_cap_ven_ex         = sum(case when mv_causal = 'CAP VEN EX' then S_pago         else 0 end),

E_vcto_cartera_int_ven_ex = sum(case when mv_causal = 'INT VEN EX' then E_vcto_cartera else 0 end),
E_comp_cartera_int_ven_ex = sum(case when mv_causal = 'INT VEN EX' then E_comp_cartera else 0 end),
S_vcto_cuota_int_ven_ex   = sum(case when mv_causal = 'INT VEN EX' then S_vcto_cuota   else 0 end),
S_regr_vigente_int_ven_ex = sum(case when mv_causal = 'INT VEN EX' then S_regr_vigente else 0 end),
S_cast_quitas_int_ven_ex  = sum(case when mv_causal = 'INT VEN EX' then S_cast_quitas  else 0 end),
S_pago_int_ven_ex         = sum(case when mv_causal = 'INT VEN EX' then S_pago         else 0 end),

CAP_VEN_NE_FIN = convert(money, 0),
CAP_VEN_EX_FIN = convert(money, 0),
INT_VEN_EX_FIN = convert(money, 0)
from #movimientos
group by mv_cliente, mv_banco, mv_toperacion

insert into #resultado
select 
cliente    = sf_cliente,
banco      = sf_banco,
toperacion = sf_toperacion,

CAP_VEN_NE_INI = convert(money, 0),
CAP_VEN_EX_INI = convert(money, 0),
INT_VEN_EX_INI = convert(money, 0),

E_vcto_cartera_cap_ven_ne = convert(money, 0),
E_comp_cartera_cap_ven_ne = convert(money, 0),
S_vcto_cuota_cap_ven_ne   = convert(money, 0),
S_regr_vigente_cap_ven_ne = convert(money, 0),
S_cast_quitas_cap_ven_ne  = convert(money, 0),
S_pago_cap_ven_ne         = convert(money, 0),

E_vcto_cartera_cap_ven_ex = convert(money, 0),
E_comp_cartera_cap_ven_ex = convert(money, 0),
S_vcto_cuota_cap_ven_ex   = convert(money, 0),
S_regr_vigente_cap_ven_ex = convert(money, 0),
S_cast_quitas_cap_ven_ex  = convert(money, 0),
S_pago_cap_ven_ex         = convert(money, 0),

E_vcto_cartera_int_ven_ex = convert(money, 0),
E_comp_cartera_int_ven_ex = convert(money, 0),
S_vcto_cuota_int_ven_ex   = convert(money, 0),
S_regr_vigente_int_ven_ex = convert(money, 0),
S_cast_quitas_int_ven_ex  = convert(money, 0),
S_pago_int_ven_ex         = convert(money, 0),

CAP_VEN_NE_FIN,
CAP_VEN_EX_FIN,
INT_VEN_EX_FIN
from #saldos_fin

truncate table cob_conta_super..sb_base_A0420

if @@error != 0
begin
   select @w_error = 70143
   goto ERROR_PROCESO
end

--Insertar Cabeceras del Reporte
insert into cob_conta_super..sb_base_A0420
(
 cliente,                 banco,                   toperacion,

 sal_ini_cap_ven_nex,     sal_ini_cap_ven_exi,     sal_ini_int_ven_exi,

 e_vcto_cart_cap_ven_nex, e_comp_cart_cap_ven_nex, s_vcto_cuot_cap_ven_nex,
 s_regr_vige_cap_ven_nex, s_cast_quit_cap_ven_nex, s_pagos_cap_ven_nex,

 e_vcto_cart_cap_ven_exi, e_comp_cart_cap_ven_exi, s_vcto_cuot_cap_ven_exi,
 s_regr_vige_cap_ven_exi, s_cast_quit_cap_ven_exi, s_pagos_cap_ven_exi,

 e_vcto_cart_int_ven_exi, e_comp_cart_int_ven_exi, s_vcto_cuot_int_ven_exi,
 s_regr_vige_int_ven_exi, s_cast_quit_int_ven_exi, s_pagos_cap_int_exi,

 sal_fin_cap_ven_nex,     sal_fin_cap_ven_exi,     sal_fin_int_ven_exi
)
values 
(
'CODIGO CLIENTE',          'NO PRESTAMO',             'TIPO PRESTAMO',

'SAL_INI_CAP_VEN_NEX',     'SAL_INI_CAP_VEN_EXI',     'SAL_INI_INT_VEN_EXI',

'E_VCTO_CART_CAP_VEN_NEX', 'E_COMP_CART_CAP_VEN_NEX', 'S_VCTO_CUOT_CAP_VEN_NEX',
'S_REGR_VIGE_CAP_VEN_NEX', 'S_CAST_QUIT_CAP_VEN_NEX', 'S_PAGOS_CAP_VEN_NEX',

'E_VCTO_CART_CAP_VEN_EXI', 'E_COMP_CART_CAP_VEN_EXI', 'S_VCTO_CUOT_CAP_VEN_EXI',
'S_REGR_VIGE_CAP_VEN_EXI', 'S_CAST_QUIT_CAP_VEN_EXI', 'S_PAGOS_CAP_VEN_EXI', 

'E_VCTO_CART_INT_VEN_EXI', 'E_COMP_CART_INT_VEN_EXI', 'S_VCTO_CUOT_INT_VEN_EXI',
'S_REGR_VIGE_INT_VEN_EXI', 'S_CAST_QUIT_INT_VEN_EXI', 'S_PAGOS_INT_VEN_EXI',

'SAL_FIN_CAP_VEN_NEX',     'SAL_FIN_CAP_VEN_EXI',     'SAL_FIN_INT_VEN_EXI'
)

if @@error != 0
begin
   select @w_error = 70144
   goto ERROR_PROCESO
end

--Insertar Detalles del Reporte
insert into cob_conta_super..sb_base_A0420
(cliente,
 banco,
 toperacion,

 sal_ini_cap_ven_nex,
 sal_ini_cap_ven_exi,
 sal_ini_int_ven_exi,

 e_vcto_cart_cap_ven_nex,
 e_comp_cart_cap_ven_nex,
 s_vcto_cuot_cap_ven_nex,
 s_regr_vige_cap_ven_nex,
 s_cast_quit_cap_ven_nex,
 s_pagos_cap_ven_nex,

 e_vcto_cart_cap_ven_exi,
 e_comp_cart_cap_ven_exi,
 s_vcto_cuot_cap_ven_exi,
 s_regr_vige_cap_ven_exi,
 s_cast_quit_cap_ven_exi,
 s_pagos_cap_ven_exi,

 e_vcto_cart_int_ven_exi,
 e_comp_cart_int_ven_exi,
 s_vcto_cuot_int_ven_exi,
 s_regr_vige_int_ven_exi,
 s_cast_quit_int_ven_exi,
 s_pagos_cap_int_exi,

 sal_fin_cap_ven_nex,
 sal_fin_cap_ven_exi,
 sal_fin_int_ven_exi
)
select
convert(varchar(30), isnull(cliente, 0)),
convert(varchar(30), isnull(banco, 0)),
convert(varchar(30), isnull(toperacion, '')),

convert(varchar(30), sum(CAP_VEN_NE_INI)),
convert(varchar(30), sum(CAP_VEN_EX_INI)),
convert(varchar(30), sum(INT_VEN_EX_INI)),

convert(varchar(30), sum(E_vcto_cartera_cap_ven_ne)),
convert(varchar(30), sum(E_comp_cartera_cap_ven_ne)),
convert(varchar(30), sum(S_vcto_cuota_cap_ven_ne)),
convert(varchar(30), sum(S_regr_vigente_cap_ven_ne)),
convert(varchar(30), sum(S_cast_quitas_cap_ven_ne)),
convert(varchar(30), sum(S_pago_cap_ven_ne)),

convert(varchar(30), sum(E_vcto_cartera_cap_ven_ex)),
convert(varchar(30), sum(E_comp_cartera_cap_ven_ex)),
convert(varchar(30), sum(S_vcto_cuota_cap_ven_ex)),
convert(varchar(30), sum(S_regr_vigente_cap_ven_ex)),
convert(varchar(30), sum(S_cast_quitas_cap_ven_ex)),
convert(varchar(30), sum(S_pago_cap_ven_ex)),

convert(varchar(30), sum(E_vcto_cartera_int_ven_ex)),
convert(varchar(30), sum(E_comp_cartera_int_ven_ex)),
convert(varchar(30), sum(S_vcto_cuota_int_ven_ex)),
convert(varchar(30), sum(S_regr_vigente_int_ven_ex)),
convert(varchar(30), sum(S_cast_quitas_int_ven_ex)),
convert(varchar(30), sum(S_pago_int_ven_ex)),

convert(varchar(30), sum(CAP_VEN_NE_FIN)),
convert(varchar(30), sum(CAP_VEN_EX_FIN)),
convert(varchar(30), sum(INT_VEN_EX_FIN))
from #resultado
group by cliente, banco, toperacion
having sum(CAP_VEN_NE_INI) != 0
or sum(CAP_VEN_EX_INI) != 0
or sum(INT_VEN_EX_INI) != 0

or sum(E_vcto_cartera_cap_ven_ne) != 0
or sum(E_comp_cartera_cap_ven_ne) != 0
or sum(S_vcto_cuota_cap_ven_ne) != 0
or sum(S_regr_vigente_cap_ven_ne) != 0
or sum(S_cast_quitas_cap_ven_ne) != 0
or sum(S_pago_cap_ven_ne) != 0

or sum(E_vcto_cartera_cap_ven_ex) != 0
or sum(E_comp_cartera_cap_ven_ex) != 0
or sum(S_vcto_cuota_cap_ven_ex) != 0
or sum(S_regr_vigente_cap_ven_ex) != 0
or sum(S_cast_quitas_cap_ven_ex) != 0
or sum(S_pago_cap_ven_ex) != 0

or sum(E_vcto_cartera_int_ven_ex) != 0
or sum(E_comp_cartera_int_ven_ex) != 0
or sum(S_vcto_cuota_int_ven_ex) != 0
or sum(S_regr_vigente_int_ven_ex) != 0
or sum(S_cast_quitas_int_ven_ex) != 0
or sum(S_pago_int_ven_ex) != 0

or sum(CAP_VEN_NE_FIN) != 0
or sum(CAP_VEN_EX_FIN) != 0
or sum(INT_VEN_EX_FIN) != 0

if @@error != 0
begin
   select @w_error = 70144
   goto ERROR_PROCESO
end

select	
do_codigo_cliente		   as fin_cliente, 
max(do_banco)			   as fin_banco,
convert(varchar, null)	as fin_toperacion
into #datos_prestamo_fin_mes
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_hab
and do_aplicativo	= 7
group by do_codigo_cliente

update #datos_prestamo_fin_mes set
fin_toperacion = do_tipo_operacion
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_hab
and do_aplicativo	= 7
and do_banco      = fin_banco

select	
do_codigo_cliente		   as ini_cliente, 
max(do_banco)			   as ini_banco,
convert(varchar, null)	as ini_toperacion
into #datos_prestamo_ini_mes
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_ant_hab
and do_aplicativo	= 7
group by do_codigo_cliente

update #datos_prestamo_ini_mes set
ini_toperacion = do_tipo_operacion
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_ant_hab
and do_aplicativo	= 7
and do_banco      = ini_banco

update cob_conta_super..sb_base_A0420 set 
banco       = fin_banco,
toperacion  = fin_toperacion
from #datos_prestamo_fin_mes
where fin_cliente = convert(int, cliente)
and cliente != 'CODIGO CLIENTE'

update cob_conta_super..sb_base_A0420 set 
banco       = ini_banco,
toperacion  = ini_toperacion
from #datos_prestamo_ini_mes
where ini_cliente = convert(int, cliente)
and cliente != 'CODIGO CLIENTE'
and banco         is null

select @w_sql = 'select * from cob_conta_super..sb_base_A0420'

select @w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_nombre_arch + '" -C -c -t\t -T'

delete from @resultadobcp

insert into @resultadobcp
exec xp_cmdshell @w_sql_bcp;

select * from @resultadobcp

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
if @w_mensaje is null
    select top 1 @w_mensaje = linea
    from  @resultadobcp 
    where upper(linea) like upper('%Error %')

if @w_mensaje is not null
begin
    select @w_error = 70146
    goto ERROR_PROCESO
end

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I' 

if @@error != 0
begin
	select @w_error = 710002
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

