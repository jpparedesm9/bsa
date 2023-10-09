/************************************************************************/
/*   Archivo               :        qroptmp.sp                          */
/*   Stored procedure      :        sp_qr_operacion_tmp                 */
/*   Base de datos         :        cob_cartera                         */
/*   Producto              :        Cartera                             */
/*   Disenado por          :        Sandra Ortiz                        */
/*   Fecha de escritura    :        10/30/1994                          */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA', representantes exclusivos para el Ecuador de la          */
/*   'NCR CORPORATION'.                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                                  PROPOSITO                           */
/*   Este programa ejecuta el query de operaciones de cartera           */
/*   llamado por el SP sp_operacion_qry.                                */
/************************************************************************/  
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR             RAZON                          */
/* 04/Jul/2017        M. Taco            Cargar la cuenta del cliente   */
/*                                       para flujos individuales       */
/************************************************************************/  
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_qr_operacion_tmp')
   drop proc sp_qr_operacion_tmp
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_qr_operacion_tmp
@s_date           datetime = null,
@i_codigo         cuenta   = null,
@i_formato_fecha  int      = null,
@i_operacion      CHAR(1)  = NULL

as
declare
   @w_sp_name                    varchar(32),
   @w_return                     int,
   @w_operacionca                int,
   @w_banco                      cuenta,
   @w_cliente                    int,
   @w_toperacion                 catalogo,
   @w_oficina                    smallint,
   @w_moneda                     tinyint,
   @w_oficial                    smallint,
   @w_fecha_ini                  datetime,
   @w_fecha_fin                  datetime,
   @w_monto                      money,
   @w_tplazo                     catalogo,
   @w_plazo                      smallint,
   @w_destino                    catalogo,
   @w_producto                   tinyint,
   @w_lin_credito                cuenta,
   @w_reajustable                char(1),
   @w_reajuste_periodo           tinyint,
   @w_reajuste_especial          char (1),
   @w_reajuste_fecha             datetime,
   @w_reajuste_num               tinyint,
   @w_ciudad                     int,
   @w_estado                     descripcion,
   @w_renovaciones               tinyint,
   @w_porcentaje                 float,
   @w_valor                      money,
   @w_nem_producto               catalogo,
   @w_cuenta                     cuenta,
   @w_cuota_completa             char(1),
   @w_anticipado_int             char(1),
   @w_reajuste_intereses         char(1),
   @w_reduccion                  char(1),
   @w_cuota_anticipada           char(1),
   @w_dias_anio                  smallint,
   @w_tipo_amortizacion          catalogo,
   @w_cuota_fija                 char(1),
   @w_cuota                      money,
   @w_cuota_capital              money,
   @w_periodos_gracia            tinyint,
   @w_periodos_gracia_int        tinyint,
   @w_dist_gracia                char(1),
   @w_tdividendo                 catalogo,
   @w_periodo_cap                smallint,
   @w_periodo_int                smallint,
   @w_dias_gracia                smallint,
   @w_dia_pago                   tinyint,
   @w_renovacion                 char(1),
   @w_num_renovacion             tinyint,
   @w_precancelacion             char(1),
   @w_tipo                       char(1),
   @w_porcentaje_fin             float,
   @w_tasa_fin                   float,
   @w_tramite                    int,
   @w_fecha_prox_pag             datetime,
   @w_dias_clausula              int,
   @w_direccion                  tinyint,
   @w_desc_toperacion            descripcion,
   @w_desc_reajuste              descripcion,
   @w_desc_tvencimiento          descripcion,
   @w_desc_tdividendo            descripcion,
   @w_desc_tplazo                descripcion,
   @w_desc_moneda                descripcion,
   @w_desc_ciudad                descripcion,
   @w_desc_destino               descripcion,
   @w_desc_producto              descripcion,
   @w_desc_ofi                   descripcion,
   @w_inicio                     varchar(10),
   @w_fin                        varchar(10),
   @w_nombre                     descripcion,
   @w_tasa                       float,
   @w_tasa_efa                   float,
   @w_num_dec_tasa               tinyint,
   @w_valint                     float,
   @w_referencial                catalogo,
   @w_desc_referencial           descripcion,
   @w_nom_oficial                descripcion,
   @w_sector                     catalogo,
   @w_des_sector                 descripcion,
   @w_anterior                   cuenta,
   @w_migrada                    cuenta,
   @w_desembolso                 money,
   @w_refer                      varchar(255),
   @w_fecha_liq                  datetime,
   @w_cuota_adic                 char(1),
   @w_fecha                      datetime,
   @w_monto_aprobado             money,
   @w_tipo_aplicacion            char(1), 
   @w_mes_gracia                 tinyint,
   @w_gracia_int                 tinyint,
   @w_num_dec                    tinyint,
   @w_fecha_fija                 char(1),
   @w_meses_hip                  tinyint,
   @w_evitar_feriados            char(1),
   @w_periodo_crecimiento        smallint,
   @w_tasa_crecimiento           float,
   @w_decrip_tipo                varchar(255),
   @w_desc_direccion             varchar(254), 
   @w_tipo_crecimiento           char(1),    
   @w_base_calculo               char(1),    
   @w_ult_dia_habil              char(1),    
   @w_recalcular                 char(1),    
   @w_tasa_equivalente           char(1),    
   @w_tipo_redondeo              tinyint,
   @w_fecha_pri_cuota            datetime,
   @w_causacion                  char(1), 
   @w_convierte_tasa             char(1), 
   @w_tramite_ficticio           int, 
   @w_grupo_fact                 int,
   @w_bvirtual                   char(1),
   @w_extracto                   char(1),
   @w_pago_caja                  char(1), 
   @w_nace_vencida               char(1),
   @w_calcula_devolucion         char(1),
   @w_oper_pas_ext               varchar(64),
   @w_mora_retroactiva           char(1),
   @w_prepago_desde_lavigente    char(1),
   @w_codigo_cli                 int,
   @w_nombre_cli                 char(64),
   @w_tipo_empresa               catalogo,
   @w_decr_tipo_empresa          char(50),
   @w_monto_capitalizacion       money

select   @w_sp_name = 'sp_qr_operacion_tmp'

select @w_producto = pd_producto
from   cobis..cl_producto
where  pd_abreviatura = 'CCA'
set transaction isolation level read uncommitted

select @w_fecha = convert(varchar(10),fc_fecha_cierre,101)
from   cobis..ba_fecha_cierre
where  fc_producto = @w_producto

select @w_operacionca       = opt_operacion,       
       @w_banco             = opt_banco,
       @w_fecha_ini         = opt_fecha_ini,
       @w_fecha_fin         = opt_fecha_fin,
       @w_toperacion        = opt_toperacion,
       @w_desc_toperacion   = cx.valor,
       @w_monto             = opt_monto,          
       @w_tplazo            = case when opt_tplazo = 'W' and opt_periodo_int = 2 and opt_periodo_cap = 2 then 'BW' else opt_tplazo end,        
       @w_plazo             = opt_plazo,
       @w_destino           = opt_destino,       
       @w_desc_destino      = (select valor
                              from   cobis..cl_catalogo y, cobis..cl_tabla t
                              where  t.tabla = 'cr_destino'
                              and    y.tabla   = t.codigo
                              and    y.codigo  = x.opt_destino),
       @w_oficina           = opt_oficina,       
       @w_moneda            = opt_moneda,
       @w_desc_moneda       = mo_descripcion,
       @w_oficial           = opt_oficial,       
       @w_lin_credito       = opt_lin_credito,   
       @w_nem_producto      = opt_forma_pago,
       @w_cuenta            = opt_cuenta,          
       @w_reajuste_fecha    = opt_fecha_reajuste,
       @w_reajuste_periodo  = opt_periodo_reajuste,
       @w_reajuste_especial = opt_reajuste_especial,
       @w_cliente           = opt_cliente,
       @w_ciudad            = opt_ciudad,
       @w_desc_ciudad       = ci_descripcion,
       @w_estado = substring(es_descripcion,1,15),
       @w_cuota_completa      = opt_cuota_completa,
       @w_anticipado_int      = opt_tipo_cobro,
       @w_reajuste_intereses  = opt_reajuste_especial,
       @w_reduccion           = opt_tipo_reduccion,
       @w_cuota_anticipada    = opt_aceptar_anticipos,
       @w_dias_anio           = opt_dias_anio,
       @w_tipo_amortizacion   = opt_tipo_amortizacion,
       @w_cuota               = opt_cuota,
       @w_cuota_capital       = 0,
       @w_periodos_gracia     = opt_gracia_cap,
       @w_periodos_gracia_int = opt_gracia_int,
       @w_dist_gracia         = opt_dist_gracia  ,
       @w_tdividendo          = case when opt_tdividendo = 'W' and opt_periodo_int = 2 and opt_periodo_cap = 2 then 'BW' else opt_tdividendo end,
       @w_periodo_cap         = opt_periodo_cap,
       @w_periodo_int         = opt_periodo_int,
       @w_dia_pago            = opt_dia_fijo,
       @w_renovacion          = opt_renovacion ,
       @w_num_renovacion      = opt_num_renovacion,
       @w_precancelacion      = opt_precancelacion,
       @w_tipo                = opt_tipo,
       @w_tramite             = opt_tramite,
       @w_fecha_prox_pag      = null,
       @w_desc_ofi            = (select of_nombre
                                  from cobis..cl_oficina
                                  where of_oficina = x.opt_oficina),
       @w_sector              = opt_sector,
       @w_anterior            = opt_anterior,
       @w_migrada             = opt_migrada,
       @w_refer               = opt_comentario,
       @w_desembolso          = 0,
       @w_fecha_liq           = opt_fecha_liq,
       @w_nombre              = opt_nombre,
       @w_monto_aprobado      = opt_monto_aprobado,
       @w_tipo_aplicacion     = opt_tipo_aplicacion,
       @w_gracia_int          = opt_gracia_int,
       @w_mes_gracia          = opt_mes_gracia,
       @w_evitar_feriados     = opt_evitar_feriados,
       @w_reajustable         = opt_reajustable,
       @w_dias_clausula       = opt_dias_clausula,
       @w_periodo_crecimiento = opt_periodo_crecimiento,
       @w_tasa_crecimiento    = opt_tasa_crecimiento, 
       @w_direccion           = opt_direccion,
       @w_tipo_crecimiento    = opt_tipo_crecimiento,  
       @w_base_calculo        = opt_base_calculo,  
       @w_ult_dia_habil       = opt_dia_habil,  
       @w_recalcular          = opt_recalcular_plazo,
       @w_tasa_equivalente    = opt_usar_tequivalente, 
       @w_fecha_pri_cuota     = opt_fecha_pri_cuot,
       @w_tipo_redondeo       = opt_tipo_redondeo,
       @w_causacion           = opt_causacion,    
       @w_convierte_tasa      = opt_convierte_tasa,
       @w_tramite_ficticio    = opt_tramite_ficticio,
       @w_grupo_fact          = opt_grupo_fact,
       @w_bvirtual            = opt_bvirtual,
       @w_extracto            = opt_extracto,
       @w_pago_caja          = opt_pago_caja,
       @w_nace_vencida          = opt_nace_vencida, 
       @w_oper_pas_ext        = opt_codigo_externo,
       @w_calcula_devolucion  = opt_calcula_devolucion,
       @w_mora_retroactiva    = opt_mora_retroactiva,
       @w_prepago_desde_lavigente    = opt_prepago_desde_lavigente,
       @w_tipo_empresa               = opt_tipo_empresa
from   ca_operacion_tmp x,
       cobis..cl_catalogo cx,
       cobis..cl_tabla tx,
       cobis..cl_moneda,
       cobis..cl_ciudad,
       ca_estado
where  x.opt_banco = @i_codigo
and    mo_moneda = opt_moneda
and    tx.tabla  = 'ca_toperacion'
and    cx.tabla  = tx.codigo
and    cx.codigo = opt_toperacion
and    ci_ciudad = opt_ciudad
and    es_codigo = opt_estado

print 'SRO>>1'
print @w_periodo_cap
print @w_periodo_int
print @w_tdividendo
print @w_tplazo
print 'SRO>>2'
--- DIAS DE GRACIA PARA MORA OPERACIONES NO VIGENTES 
select @w_dias_gracia =dit_gracia
from   ca_dividendo_tmp
where  dit_operacion = @w_operacionca
and    dit_dividendo = 1 

--- DECIMALES 
exec sp_decimales
     @i_moneda  = @w_moneda,
     @o_decimales = @w_num_dec out

select @w_desc_producto = cp_descripcion
from   ca_producto
where  cp_producto = @w_nem_producto

--- TIPO DE REAJUSTE 
select @w_desc_tplazo = case when @w_desc_tplazo is null then td_descripcion else @w_desc_tplazo end
from   ca_tdividendo
where  td_tdividendo = @w_tplazo

--- LINEA DE CREDITO  
select @w_inicio = NULL,
       @w_fin    = NULL

select @w_inicio = convert (varchar(10), li_fecha_inicio,@i_formato_fecha),
       @w_fin    = convert (varchar(10), li_fecha_vto,@i_formato_fecha)
from   cob_credito..cr_linea
where  li_num_banco = @w_lin_credito

---  TOTAL DE INTERES  
select @w_tasa     = isnull(rot_porcentaje, 0),
       @w_tasa_efa = isnull(rot_porcentaje_efa ,0),
       @w_num_dec_tasa = isnull(rot_num_dec, 6)
from   ca_rubro_op_tmp
where  rot_operacion  =  @w_operacionca
and    rot_tipo_rubro =  'I'
and    rot_fpago      in ('P','A','T') 

if @@rowcount = 0
   select @w_tasa = 0,
          @w_tasa_efa = 0,
          @w_num_dec_tasa = 6

select @w_desc_tdividendo = case when @w_desc_tdividendo is null then td_descripcion else @w_desc_tdividendo end
from   ca_tdividendo
where  td_tdividendo = @w_tdividendo

select @w_nom_oficial = fu_nombre 
from   cobis..cl_funcionario, cobis..cc_oficial   
where  oc_oficial= @w_oficial
and    fu_funcionario = oc_funcionario
set transaction isolation level read uncommitted

select @w_des_sector = ''

-- VERIFICAR SI PRESENTA CUOTAS ADICIONALES
if exists(select 1
          from   ca_cuota_adicional_tmp
          where  cat_operacion = @w_operacionca
          and    cat_cuota <> 0)
   select @w_cuota_adic = 'S'
else
   select @w_cuota_adic = 'N'

if isnull(@w_dia_pago,0) = 0
   select @w_fecha_fija = 'N'
else
   select @w_fecha_fija = 'S'   

if @w_tipo_amortizacion = 'FRANCESA'
   select @w_cuota_fija = 'S'

if @w_tipo_amortizacion = 'ALEMANA'
   select @w_cuota_fija = 'N'

if @w_tipo_amortizacion = 'MANUAL'
   select @w_cuota_fija = 'M'

select @w_decrip_tipo = valor                                
from   cobis..cl_catalogo y, cobis..cl_tabla t
where  t.tabla = 'ca_tipo_prestamo'                
and    y.tabla   = t.codigo
and    y.codigo  = @w_tipo 
set transaction isolation level read uncommitted

select @w_decr_tipo_empresa = valor                                
from   cobis..cl_catalogo y, cobis..cl_tabla t
where  t.tabla = 'ca_tipo_empresa'                
and    y.tabla   = t.codigo
and    y.codigo  = @w_tipo_empresa 
set transaction isolation level read uncommitted

-- OBTENIENDO DESCRIPCION DE LA DIRECCION DEL CLIENTE
select @w_desc_direccion = di_descripcion
from   cobis..cl_direccion
where  di_ente = @w_cliente
and    di_direccion = @w_direccion
set transaction isolation level read uncommitted

if 'S' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'VALAHO' and pa_producto = 'CCA')
begin
--- CON EL NUMERO DE CUENTA SE OBTIENE EL CODIGO DEL CLIENTE, QUE NO NECESARIAMENTE ES EL DUE¥O DEL CREDITO
--- SOLICITADO POR EL BAC 
    if @w_cuenta <> '' or @w_cuenta is not null
    begin
        exec cob_interfase..sp_verifica_cuenta_cte
                   @i_operacion  = 'VCTE',
                   @i_cuenta     = @w_cuenta,
                   @o_ah_cliente = @w_codigo_cli out,
                   @o_ah_nombre  = @w_nombre_cli out
       /*select @w_codigo_cli = cc_cliente,
              @w_nombre_cli = cc_nombre
       from   cob_cuentas..cc_ctacte
       where  cc_cta_banco = @w_cuenta
       and    cc_estado  = 'A'*/
       
       if @w_codigo_cli = null 
       begin
             select @w_codigo_cli = ah_cliente,
                    @w_nombre_cli = ah_nombre
             from  cob_ahorros..ah_cuenta
             where ah_cta_banco = @w_cuenta
             and   ah_estado    = 'A'
             exec cob_interfase..sp_verifica_cuenta_aho
                      @i_operacion  = 'VAHO',
                      @i_cuenta     = @w_cuenta,
                      @o_ah_cliente = @w_codigo_cli out,
                      @o_ah_nombre  = @w_nombre_cli out
       end
    end
end
select @w_monto_capitalizacion = isnull(sum(am_cuota - am_cuota),0)
from ca_amortizacion
where am_operacion = @w_operacionca
and   am_concepto  = 'CAP'

if @w_monto_capitalizacion > 0
   select @w_monto = @w_monto_capitalizacion 

--MTA Inicio Cuando el flujo es individual consulta la cuenta del cliente en las tablas del cliente
if (@w_toperacion = 'INDIVIDUAL')
begin
   select @w_cliente =  tr_cliente 
     from cob_credito..cr_tramite 
	where tr_tramite = @w_tramite
	
   select @w_cuenta = isnull(ea_cta_banco,0)
     from cobis..cl_ente_aux 
    where ea_ente = @w_cliente
end
--MTA Fin

select 
@w_operacionca, --0
rtrim(ltrim(@w_banco)),---1
@w_tramite,--2
@w_lin_credito,--3
@w_estado, --4
@w_cliente,--5
rtrim(ltrim(@w_toperacion)),--6
@w_desc_toperacion,--7
@w_moneda,--8
@w_desc_moneda,  ---9
@w_oficina, --10
@w_oficial,--11
convert(varchar(10),@w_fecha_ini,@i_formato_fecha),--12
convert(varchar(10),@w_fecha_fin,@i_formato_fecha),--13
convert(varchar(10),@w_fecha_prox_pag,@i_formato_fecha),--14
@w_monto,--15
rtrim(ltrim(@w_tplazo)),--16
@w_desc_tplazo,--17
@w_plazo,--18
rtrim(ltrim(@w_tdividendo)),  --19
@w_desc_tdividendo,--20
@w_periodo_cap,--21
@w_periodo_int,--22
@w_periodos_gracia,--23
@w_periodos_gracia_int,--24
@w_dist_gracia  ,--25
rtrim(ltrim(@w_destino)),--26
rtrim(ltrim(@w_desc_destino)), --27
@w_ciudad,--28
@w_desc_ciudad, --29
@w_nem_producto,--30
@w_desc_producto,--31
@w_cuenta,--32
@w_reajuste_periodo,--33
convert(varchar(10),@w_reajuste_fecha,@i_formato_fecha),--34
@w_reajuste_num,--35
@w_renovacion,--36
@w_num_renovacion,--37
@w_precancelacion, --38
@w_tipo, -- 39
@w_porcentaje_fin,--40
@w_tasa_fin, --41
@w_cuota_completa,--42
@w_anticipado_int,--43
@w_reajuste_intereses,--44
@w_reduccion,  --45
@w_cuota_anticipada,--46
@w_dias_anio,--47
rtrim(ltrim(@w_tipo_amortizacion)),--48
@w_cuota_fija, -- 49
@w_cuota,--50
@w_cuota_capital,--51
@w_dias_gracia,--52
@w_dia_pago, --53
@w_desc_ofi,
@w_inicio,
@w_fin,
@w_nombre,
@w_tasa,--58
@w_referencial, -- 59
@w_desc_referencial,
@w_nom_oficial,
0, -- ANTERIOR PERIODO DE CALCULO
@w_reajuste_especial,--63
rtrim(ltrim(@w_sector)),
@w_des_sector,
@w_anterior,
@w_migrada,
@w_refer,
convert(float, @w_desembolso), -- 69
convert(varchar(10),@w_fecha_liq,@i_formato_fecha), --70
@w_cuota_adic,
@w_meses_hip,
convert(float, @w_monto_aprobado),--73
@w_tipo_aplicacion,--74
@w_gracia_int,
@w_mes_gracia,--76
@w_num_dec,
@w_fecha_fija, --78
@w_reajustable, -- 79
@w_evitar_feriados,--80      
@w_dias_clausula,
@w_periodo_crecimiento, 
@w_tasa_crecimiento,
@w_decrip_tipo,
@w_direccion,
@w_desc_direccion,
@w_tipo_crecimiento,  
@w_causacion, --rtrim(ltrim(@w_base_calculo)),  
@w_ult_dia_habil, 
@w_recalcular,    --90
@w_tasa_equivalente,
@w_tipo_redondeo,   
'N',--convert(varchar(12),@w_fecha_pri_cuota,@i_formato_fecha),--93
rtrim(ltrim(@w_base_calculo)), --@w_causacion, --94          
@w_convierte_tasa,      
@w_tramite_ficticio, 
@w_grupo_fact,
@w_bvirtual,
@w_extracto,
@w_pago_caja, 
@w_nace_vencida, --101
@w_calcula_devolucion,
@w_oper_pas_ext,
@w_mora_retroactiva,
@w_prepago_desde_lavigente,
@w_codigo_cli,--@w_codigo_cli,--106
@w_nombre_cli,
@w_tasa_efa,--@w_tipo_empresa, --108
@w_decr_tipo_empresa, --109
@w_tasa_efa,          --110,
@w_num_dec_tasa,       --111
'',
@w_reajuste_intereses,  --113
''

select rtrim(ltrim(td_tdividendo)), td_factor
from   ca_tdividendo   --DAG

return 0

GO

