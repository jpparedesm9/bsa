/************************************************************************/
/*      Archivo:                reporte_aho.sp                          */
/*      Stored procedure:       sp_reporte_aho                          */
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
/*      Reporte Ahorros                                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reporte_aho')
   drop proc sp_reporte_aho
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reporte_aho (
@t_show_version  bit = 0,
@i_param1    datetime,      -- Fecha Corte
@i_param2    char(1) = 'N'  -- Req. 381 CB Red Posicionada
)
as
declare
@w_fecha             varchar(10),
@w_sp_name           varchar(30),
@w_s_app             varchar(255),
@w_path              varchar(255),
@w_nombre            varchar(255),
@w_nombre_cab        varchar(255),
@w_destino           varchar(2500),
@w_errores           varchar(1500),
@w_error             int,
@w_return            int,
@w_comando           varchar(3500),
@w_nombre_plano      varchar(2500),
@w_msg               varchar(255),
@w_col_id            int,
@w_columna           varchar(100),
@w_cabecera          varchar(2500),
@w_cont              int,
@w_nom_tabla         varchar(100),
@w_producto          int,
@w_tipo_atributo     varchar(10),
@w_filial            int,
@w_sucursal          int,
@w_oficina           int,
@w_nro_int_cta       int,
@w_producto_banc     int,
@w_moneda            int,
@w_tipo_cuenta       varchar(10),
@w_categoria         varchar(10),
@w_tasa_interes      float,
@w_disponible        money,
@w_fecha_inc         datetime,
@w_cuenta            varchar(20),
@w_corresponsal      char(1),
@w_prod_bancario     varchar(50) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_reporte_aho'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select
@w_cont          = 0,
@w_filial        = 1,
@w_producto      = 4,
@w_corresponsal  = @i_param2

select @w_fecha = convert(varchar(10), @i_param1, 101)

select @w_producto_banc = pa_int
from   cobis..cl_parametro
where  pa_producto = 'AHO'
and    pa_nemonico = 'PAHCT'

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from   cobis..ba_batch
where  ba_batch = 4263

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

if exists(select 1 from sysobjects where name = 'ah_reporte_aho')
   drop table ah_reporte_aho

create table ah_reporte_aho (
zona_oficina             varchar(255)  null,
territorial_oficina      varchar(255)  null,
cod_oficina              int           null,
nom_oficina              varchar(255)  null,
nro_cuenta               varchar(64)   null,
est_cuenta               varchar(15)   null,
cliente                  int           null,
cedula_cliente           varchar(24)   null,
nombre_cliente           varchar(255)  null,
genero                   varchar(10)   null,
edad                     int           null,
fecha_aper               varchar(10)   null,
actividad                varchar(25)   null,
nivel_educa              varchar(30)   null,
tel_residencia           varchar(50)   null,
ciu_residencia           varchar(25)   null,
segmento                 varchar(15)   null,
categoria                varchar(25)   null,
plazo_ahorro             int           null,
valor_mes_ahorro         money         null,
monto_final              money         null,
numero_cuota             int           null,
cumple_plan              varchar(2)    null,
num_cuo_cumple           int           null,
num_cuo_nocumple         int           null,
cuo_nocumple             int           null,
fecha_ult_incump         varchar(10)   null,
no_cumple                int           null,
saldo_plan_ahorro        int           null,
saldo_cuenta             int           null,
tasa_interes             float         null,
puntos_premio            float         null,
valor_total_canc         money         null,
valor_total_canc_in      money         null,
oficial                  varchar(20)   null
)

if exists (select 1 from sysobjects where name = 'cuentas_ORS405')
   drop table cuentas_ORS405

create table cuentas_ORS405(
cuota     numeric(10,0) identity not null,
saldo     money  not null,
fecha     datetime not null,
monto     money  null,cuenta    varchar(20) not null)

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @w_corresponsal = 'N' begin
   select
   zona_oficina        = isnull((select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_zona = b.of_oficina) from cobis..cl_oficina a where a.of_subtipo = 'O' and a.of_oficina = ah_oficina),''),
   territorial_oficina = (select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_regional = b.of_oficina) from cobis..cl_oficina a where a.of_oficina = ah_oficina),
   cod_oficina         = ah_oficina,
   nom_oficina         = (select of_nombre from cobis..cl_oficina where of_oficina = ah_oficina),
   nro_cuenta          = ah_cta_banco,
   est_cuenta          = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'ah_estado_cta' and a.codigo = b.tabla and b.codigo = ah_estado),
   cliente             = ah_cliente,
   cedula_cliente      = en_ced_ruc,
   nombre_cliente      = en_nomlar,
   genero              = p_sexo,
   edad                = datediff(yyyy, p_fecha_nac, getdate()),
   fecha_aper          = convert(varchar(10), ah_fecha_aper, 101),
   actividad           = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_actividad' and a.codigo = b.tabla and b.codigo = en_actividad),
   nivel_educa         = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_nivel_estudio' and a.codigo = b.tabla and b.codigo = isnull(p_nivel_estudio, '001')),
   tel_residencia      = (select isnull((select top 1 rtrim(isnull(te_prefijo,0)) + '-'+ isnull(te_valor,0) from cobis..cl_telefono, cobis..cl_direccion
                          where te_ente = di_ente and te_ente = Y.en_ente and di_tipo = '002' and te_direccion = di_direccion), '-No-')),
   ciu_residencia      = (select top 1 ci_descripcion from cobis..cl_ciudad, cobis..cl_direccion where ci_ciudad = di_ciudad and di_ente = Y.en_ente and (di_tipo = '002' or di_tipo = '011')),
   segmento            = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_segmento' and a.codigo = b.tabla and b.codigo = isnull((select top 1 mo_segmento from cobis..cl_mercado_objetivo_cliente where mo_ente = Y.en_ente), '01')),
   categoria           = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'pe_categoria' and a.codigo = b.tabla and b.codigo = ah_categoria),
   plazo_ahorro        = convert(int, 0),
   valor_mes_ahorro    = convert(money,0),
   monto_final         = convert(money,0),
   numero_cuota        = convert(int, 0),
   cumple_plan         = convert(varchar(2),''),
   num_cuo_cumple      = case when ah_estado = 'C' then datediff(mm, ah_fecha_aper, ah_fecha_ult_mov) else null end,
   num_cuo_nocumple    = convert(int, 0),
   cuo_nocumple        = convert(int, 0),
   fecha_ult_incump    = convert(varchar(10), '',101),
   no_cumple           = convert(int, 0),
   saldo_plan_ahorro   = convert(int,0),
   saldo_cuenta        = ah_disponible,
   tasa_interes        = convert(float,0,0),
   puntos_premio       = convert(float,0,0),
   valor_total_canc_in = (case when ah_estado = 'C' then (select hc_saldo from ah_his_cierre where hc_cuenta = ah_cuenta) else 0 end),
   valor_total_canc    = (case when ah_estado = 'C' then (select hc_saldo from ah_his_cierre where hc_cuenta = ah_cuenta) else 0 end),
   oficial             = (select fu_login from cobis..cc_oficial, cobis..cl_funcionario where oc_oficial = X.ah_oficial and oc_funcionario = fu_funcionario)
   into #cuentas_cb
   from ah_cuenta X, cobis..cl_ente Y
   where ah_cliente   = en_ente
   and   ah_prod_banc = @w_producto_banc
   and   ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   create index idx1 on #cuentas_cb (nro_cuenta)

   update #cuentas_cb set
   tel_residencia      = case when (len(tel_residencia) <= 10 and len(tel_residencia) >= 5) then '03' + tel_residencia  else tel_residencia end,
   plazo_ahorro        = cc_plazo,
   valor_mes_ahorro    = cc_cuota,
   monto_final         = cc_monto_final,
   numero_cuota        = datediff(mm, cc_fecha_crea, getdate()),
   cumple_plan         = case cc_periodos_incump when 0 then 'SI' else 'NO' end,
   puntos_premio       = cc_ptos_premio,
   num_cuo_cumple      = case when num_cuo_cumple = null then datediff(mm, cc_fecha_crea, getdate()) - isnull(cc_periodos_incump,0) else num_cuo_cumple end,
   num_cuo_nocumple    = isnull(cc_periodos_incump,0),
   valor_total_canc_in = (case when cc_periodos_incump <> 0 then valor_total_canc_in else 0 end),
   valor_total_canc    = (case when cc_periodos_incump = 0 then valor_total_canc else 0 end)
   from cob_remesas..re_cuenta_contractual
   where cc_cta_banco = nro_cuenta

   --hallar tasa interes e incumplimientos del cliente

   select nro_cuenta, ah_cuenta as nro_int_cta, cod_oficina, ah_moneda as moneda, ah_tipocta as tipo_cuenta, ah_categoria as categoria, ah_disponible as disponible
   into #temporal_cb
   from #cuentas_cb, ah_cuenta
   where nro_cuenta = ah_cta_banco
   and   ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   while 1 = 1 begin

      set rowcount 1

      select @w_cuenta = nro_cuenta, @w_nro_int_cta = nro_int_cta, @w_oficina = cod_oficina, @w_moneda = moneda, @w_tipo_cuenta = tipo_cuenta, @w_categoria = categoria, @w_disponible = disponible
      from #temporal_cb
      order by nro_cuenta

      if @@rowcount = 0 begin
         set rowcount 0
         break
      end

      delete #temporal_cb
      where nro_cuenta = @w_cuenta

      set rowcount 0

      /* temporal de detalle por transaccion*/
      insert into cuentas_ORS405 (saldo, fecha, monto, cuenta)
      select hs_saldo, hs_tsfecha, hs_monto, hs_cta_banco
      from   cob_ahorros_his..ah_his_servicio
      where  hs_tipo_transaccion = 4135 --ahorro contractual
      and    hs_cta_banco        = @w_cuenta
      and    hs_saldo is not null
      order by hs_tsfecha

      select @w_fecha_inc = (select top 1 fecha from cuentas_ORS405 where saldo < monto order by fecha)

      select @w_sucursal = isnull(of_sucursal, of_regional)
      from   cobis..cl_oficina
      where  of_oficina  = @w_oficina

      select @w_tipo_atributo = tipo_atributo
      from  tempdb..pe_tipo_atributo
      where filial          = @w_filial
      and   sucursal        = @w_sucursal
      and   producto        = @w_producto
      and   moneda          = @w_moneda
      and   pro_bancario    = @w_producto_banc
      and   tipo_cta        = @w_tipo_cuenta
      and   servicio        = 'PINT'
      and   rubro           = '18'

      select @w_tasa_interes = isnull(valor,0)
      from  tempdb..pint4
      where filial        = @w_filial
      and   sucursal      = @w_sucursal
      and   producto      = @w_producto
      and   moneda        = @w_moneda
      and   pro_bancario  = @w_producto_banc
      and   tipo_ente     = @w_tipo_cuenta
      and   servicio_dis  = 'PINT'
      and   rubro         = '18'
      and   tipo_atributo = @w_tipo_atributo
      and   categoria     = @w_categoria
      and   @w_disponible between rango_desde and rango_hasta

      update #cuentas_cb set
      no_cumple           = (select count (cuota) from cuentas_ORS405 where saldo >= monto and fecha >= @w_fecha_inc),
      cuo_nocumple        = isnull((select top 1 cuota from cuentas_ORS405 where saldo < monto order by cuota), 0),
      saldo_plan_ahorro   = isnull((select sum(saldo) from cuentas_ORS405), 0),
      fecha_ult_incump    = (select top 1 fecha from cuentas_ORS405 where saldo < monto order by fecha desc),
      tasa_interes        = round(@w_tasa_interes, 2)
      where nro_cuenta = @w_cuenta

      truncate table cuentas_ORS405

   end

   /*** CUENTAS CANCELADAS ANTES DEL PLAZO ***/

   select nro_cuenta as Cuenta
   into #no_cumple_cb
   from #cuentas_cb
   where num_cuo_cumple < plazo_ahorro
   and est_cuenta = 'CANCELADA'

   update #cuentas_cb set
   cumple_plan = 'NO',
   valor_total_canc_in = case when valor_total_canc_in = 0 then valor_total_canc else valor_total_canc_in end,
   valor_total_canc = 0
   where nro_cuenta in (select Cuenta from #no_cumple_cb)

   drop table cuentas_ORS405

   truncate table ah_reporte_aho

   insert into ah_reporte_aho
   select
   convert(varchar(255), zona_oficina),
   convert(varchar(255), territorial_oficina),
   convert(int, cod_oficina),
   convert(varchar(255), nom_oficina),
   convert(varchar(64),nro_cuenta),
   convert(varchar(15),est_cuenta),
   convert(int, cliente),
   convert(varchar(24), cedula_cliente),
   convert(varchar(255), nombre_cliente),
   convert(varchar(10), genero),
   convert(int, edad),
   convert(varchar(10), fecha_aper, 103),
   convert(varchar(25), actividad),
   convert(varchar(30), nivel_educa),
   convert(varchar(50), tel_residencia),
   convert(varchar(25), ciu_residencia),
   convert(varchar(15), segmento),
   convert(varchar(25), categoria),
   convert(int, plazo_ahorro),
   convert(money, valor_mes_ahorro),
   convert(money, monto_final),
   convert(int, numero_cuota),
   convert(varchar(2), cumple_plan),
   convert(int, num_cuo_cumple),
   convert(int, num_cuo_nocumple),
   convert(int, cuo_nocumple),
   convert(varchar(10),fecha_ult_incump, 101),
   convert(int, no_cumple),
   convert(int, saldo_plan_ahorro),
   convert(int, saldo_cuenta),
   convert(float, tasa_interes),
   convert(float, puntos_premio),
   convert(money, valor_total_canc),
   convert(money, valor_total_canc_in),
   convert(varchar(20), oficial)
   from #cuentas_cb
end
else
begin
   select
   zona_oficina        = isnull((select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_zona = b.of_oficina) from cobis..cl_oficina a where a.of_subtipo = 'O' and a.of_oficina = ah_oficina),''),
   territorial_oficina = (select (select ltrim(b.of_nombre) from cobis..cl_oficina b where a.of_regional = b.of_oficina) from cobis..cl_oficina a where a.of_oficina = ah_oficina),
   cod_oficina         = ah_oficina,
   nom_oficina         = (select of_nombre from cobis..cl_oficina where of_oficina = ah_oficina),
   nro_cuenta          = ah_cta_banco,
   est_cuenta          = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'ah_estado_cta' and a.codigo = b.tabla and b.codigo = ah_estado),
   cliente             = ah_cliente,
   cedula_cliente      = en_ced_ruc,
   nombre_cliente      = en_nomlar,
   genero              = p_sexo,
   edad                = datediff(yyyy, p_fecha_nac, getdate()),
   fecha_aper          = convert(varchar(10), ah_fecha_aper, 101),
   actividad           = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_actividad' and a.codigo = b.tabla and b.codigo = en_actividad),
   nivel_educa         = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_nivel_estudio' and a.codigo = b.tabla and b.codigo = isnull(p_nivel_estudio, '001')),
   tel_residencia      = (select isnull((select top 1 rtrim(isnull(te_prefijo,0)) + '-'+ isnull(te_valor,0) from cobis..cl_telefono, cobis..cl_direccion
                          where te_ente = di_ente and te_ente = Y.en_ente and di_tipo = '002' and te_direccion = di_direccion), '-No-')),
   ciu_residencia      = (select top 1 ci_descripcion from cobis..cl_ciudad, cobis..cl_direccion where ci_ciudad = di_ciudad and di_ente = Y.en_ente and (di_tipo = '002' or di_tipo = '011')),
   segmento            = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_segmento' and a.codigo = b.tabla and b.codigo = isnull((select top 1 mo_segmento from cobis..cl_mercado_objetivo_cliente where mo_ente = Y.en_ente), '01')),
   categoria           = (select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'pe_categoria' and a.codigo = b.tabla and b.codigo = ah_categoria),
   plazo_ahorro        = convert(int, 0),
   valor_mes_ahorro    = convert(money,0),
   monto_final         = convert(money,0),
   numero_cuota        = convert(int, 0),
   cumple_plan         = convert(varchar(2),''),
   num_cuo_cumple      = case when ah_estado = 'C' then datediff(mm, ah_fecha_aper, ah_fecha_ult_mov) else null end,
   num_cuo_nocumple    = convert(int, 0),
   cuo_nocumple        = convert(int, 0),
   fecha_ult_incump    = convert(varchar(10), '',101),
   no_cumple           = convert(int, 0),
   saldo_plan_ahorro   = convert(int,0),
   saldo_cuenta        = ah_disponible,
   tasa_interes        = convert(float,0,0),
   puntos_premio       = convert(float,0,0),
   valor_total_canc_in = (case when ah_estado = 'C' then (select hc_saldo from ah_his_cierre where hc_cuenta = ah_cuenta) else 0 end),
   valor_total_canc    = (case when ah_estado = 'C' then (select hc_saldo from ah_his_cierre where hc_cuenta = ah_cuenta) else 0 end),
   oficial             = (select fu_login from cobis..cc_oficial, cobis..cl_funcionario where oc_oficial = X.ah_oficial and oc_funcionario = fu_funcionario)
   into #cuentas
   from ah_cuenta X, cobis..cl_ente Y
   where ah_cliente   = en_ente
   and   ah_prod_banc = @w_producto_banc

   create index idx1 on #cuentas (nro_cuenta)

   update #cuentas set
   tel_residencia      = case when (len(tel_residencia) <= 10 and len(tel_residencia) >= 5) then '03' + tel_residencia  else tel_residencia end,
   plazo_ahorro        = cc_plazo,
   valor_mes_ahorro    = cc_cuota,
   monto_final         = cc_monto_final,
   numero_cuota        = datediff(mm, cc_fecha_crea, getdate()),
   cumple_plan         = case cc_periodos_incump when 0 then 'SI' else 'NO' end,
   puntos_premio       = cc_ptos_premio,
   num_cuo_cumple      = case when num_cuo_cumple = null then datediff(mm, cc_fecha_crea, getdate()) - isnull(cc_periodos_incump,0) else num_cuo_cumple end,
   num_cuo_nocumple    = isnull(cc_periodos_incump,0),
   valor_total_canc_in = (case when cc_periodos_incump <> 0 then valor_total_canc_in else 0 end),
   valor_total_canc    = (case when cc_periodos_incump = 0 then valor_total_canc else 0 end)
   from cob_remesas..re_cuenta_contractual
   where cc_cta_banco = nro_cuenta

   --hallar tasa interes e incumplimientos del cliente

   select nro_cuenta, ah_cuenta as nro_int_cta, cod_oficina, ah_moneda as moneda, ah_tipocta as tipo_cuenta, ah_categoria as categoria, ah_disponible as disponible
   into #temporal
   from #cuentas, ah_cuenta
   where nro_cuenta = ah_cta_banco

   while 1=1 begin

      set rowcount 1

      select @w_cuenta = nro_cuenta, @w_nro_int_cta = nro_int_cta, @w_oficina = cod_oficina, @w_moneda = moneda, @w_tipo_cuenta = tipo_cuenta, @w_categoria = categoria, @w_disponible = disponible
      from #temporal
      order by nro_cuenta

      if @@rowcount = 0 begin
         set rowcount 0
         break
      end

      delete #temporal
      where nro_cuenta = @w_cuenta

      set rowcount 0

      /* temporal de detalle por transaccion*/
      insert into cuentas_ORS405
      (saldo, fecha, monto, cuenta)
      select hs_saldo, hs_tsfecha, hs_monto, hs_cta_banco
      from cob_ahorros_his..ah_his_servicio
      where hs_tipo_transaccion = 4135 --ahorro contractual
      and hs_cta_banco = @w_cuenta
      and hs_saldo is not null
      order by hs_tsfecha

      select @w_fecha_inc = (select top 1 fecha from cuentas_ORS405 where saldo < monto order by fecha)

      select @w_sucursal = isnull(of_sucursal, of_regional)
      from cobis..cl_oficina
      where of_oficina = @w_oficina

      select @w_tipo_atributo = tipo_atributo
      from  tempdb..pe_tipo_atributo
      where filial          = @w_filial
      and   sucursal        = @w_sucursal
      and   producto        = @w_producto
      and   moneda          = @w_moneda
      and   pro_bancario    = @w_producto_banc
      and   tipo_cta        = @w_tipo_cuenta
      and   servicio        = 'PINT'
      and   rubro           = '18'

      select @w_tasa_interes = isnull(valor,0)
      from  tempdb..pint4
      where filial        = @w_filial
      and   sucursal      = @w_sucursal
      and   producto      = @w_producto
      and   moneda        = @w_moneda
      and   pro_bancario  = @w_producto_banc
      and   tipo_ente     = @w_tipo_cuenta
      and   servicio_dis  = 'PINT'
      and   rubro         = '18'
      and   tipo_atributo = @w_tipo_atributo
      and   categoria     = @w_categoria
      and   @w_disponible between rango_desde and rango_hasta

      update #cuentas set
      no_cumple           = (select count (cuota) from cuentas_ORS405 where saldo >= monto and fecha >= @w_fecha_inc),
      cuo_nocumple        = isnull((select top 1 cuota from cuentas_ORS405 where saldo < monto order by cuota), 0),
      saldo_plan_ahorro   = isnull((select sum(saldo) from cuentas_ORS405), 0),
      fecha_ult_incump    = (select top 1 fecha from cuentas_ORS405 where saldo < monto order by fecha desc),
      tasa_interes        = round(@w_tasa_interes, 2)
      where nro_cuenta = @w_cuenta

      truncate table cuentas_ORS405

   end

   /*** CUENTAS CANCELADAS ANTES DEL PLAZO ***/
   select nro_cuenta as Cuenta
   into #no_cumple
   from #cuentas
   where num_cuo_cumple < plazo_ahorro
   and est_cuenta = 'CANCELADA'

   update #cuentas set
   cumple_plan = 'NO',
   valor_total_canc_in = case when valor_total_canc_in = 0 then valor_total_canc else valor_total_canc_in end,
   valor_total_canc = 0
   where nro_cuenta in (select Cuenta from #no_cumple)

   drop table cuentas_ORS405

   truncate table ah_reporte_aho

   insert into ah_reporte_aho
   select
   convert(varchar(255), zona_oficina),
   convert(varchar(255), territorial_oficina),
   convert(int, cod_oficina),
   convert(varchar(255), nom_oficina),
   convert(varchar(64),nro_cuenta),
   convert(varchar(15),est_cuenta),
   convert(int, cliente),
   convert(varchar(24), cedula_cliente),
   convert(varchar(255), nombre_cliente),
   convert(varchar(10), genero),
   convert(int, edad),
   convert(varchar(10), fecha_aper, 103),
   convert(varchar(25), actividad),
   convert(varchar(30), nivel_educa),
   convert(varchar(50), tel_residencia),
   convert(varchar(25), ciu_residencia),
   convert(varchar(15), segmento),
   convert(varchar(25), categoria),
   convert(int, plazo_ahorro),
   convert(money, valor_mes_ahorro),
   convert(money, monto_final),
   convert(int, numero_cuota),
   convert(varchar(2), cumple_plan),
   convert(int, num_cuo_cumple),
   convert(int, num_cuo_nocumple),
   convert(int, cuo_nocumple),
   convert(varchar(10),fecha_ult_incump, 101),
   convert(int, no_cumple),
   convert(int, saldo_plan_ahorro),
   convert(int, saldo_cuenta),
   convert(float, tasa_interes),
   convert(float, puntos_premio),
   convert(money, valor_total_canc),
   convert(money, valor_total_canc_in),
   convert(varchar(20), oficial)
   from #cuentas
end

exec @w_return = cobis..sp_genera_bcp
@i_bd                = 'cob_ahorros',
@i_tabla_cabecera    = 'ah_reporte_aho_cab',
@i_tabla_detalle     = 'ah_reporte_aho',
@i_arch_salida       = 'REPORTE_AHO_CAB_',
@i_batch             = 4263

if @w_return <> 0 begin
   rollback tran
   select
   @w_error = @w_return,
   @w_msg   = 'ERROR GENERANDO REPORTE AHORROS'
   goto ERRORFIN
end

return 0

ERRORFIN:
select @w_msg = @w_sp_name + ' --> ' + @w_msg
print  @w_msg

return 1

go

