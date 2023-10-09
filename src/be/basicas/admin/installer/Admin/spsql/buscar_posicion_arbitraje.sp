/******************************************************************/ 
/*  Archivo         : b_refarb.sp                                 */
/*  Stored procedure: sp_buscar_posicion_arbitraje                */
/*  Base de datos   : cob_tesoreria                               */
/*  Producto        : TESORERIA                                   */
/*  Disenado por    : Santiago Garces G.                          */
/*  Fecha           : 25-Oct-96                                   */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este stored procedure permite la bœsqueda de los datos refe-  */
/*  renciales para la negociacion de divisas (compra, venta y     */
/*  arbitraje).                                                   */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*  25-Oct-96      S. Garces       Emision inicial                */
/*  03-jun-03      J. Olmedo       B.D.F formulas y campos        */
/*  03-jun-03      N. Silva        Cambios HSBC.                  */
/*  18-SEP-2012    jta             Consultar td_autorizado        */
/******************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_buscar_posicion_arbitraje')
        drop proc sp_buscar_posicion_arbitraje

go
create proc sp_buscar_posicion_arbitraje
(
    @t_show_version bit         = 0,
    @s_ssn          int         = null,
    @s_date         datetime    = null,
    @s_user         login       = null,
    @s_term         descripcion = null,
    @s_corr         char(1)     = null,
    @s_ssn_corr     int         = null,
    @s_ofi          smallint    = null,
    @t_rty          char(1)     = null,
    @t_trn          int         = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(30) = null,                    
    @i_suctes       smallint    = null,
    @i_fecha        datetime    = '12/31/2400',
    @i_coddolar     tinyint     = null,
    @i_codmn        tinyint     = null,
    @i_moneda1      tinyint     = null,
    @i_moneda2      tinyint     = null,
    @o_dolar_c      float       = 0   out,            -- cotizacion dolar compra
    @o_dolar_v      float       = 0   out,            -- cotizacion dolar venta 
    @o_rel_m1       float       = 0   out,            -- relacion dolar - moneda1
    @o_rel_m2       float       = 0   out,            -- relacion dolar - moneda2
    @o_costo_1      float       = 0   out,            -- costo posicion compra 
    @o_monto_1      money       = 0   out,            -- monto posicion compra 
    @o_costo_2      float       = 0   out,            -- costo posicion venta 
    @o_monto_2      money       = 0   out,            -- monto posicion venta 
    @o_mon1_c       float       = 0   out,            -- cotizacion compra moneda 1 
    @o_mon1_v       float       = 0   out,            -- cotizacion venta moneda 1 
    @o_mon2_c       float       = 0   out,            -- cotizacion compra moneda 2
    @o_mon2_v       float       = 0   out,            -- cotizacion venta moneda 2 
    @o_mercado      tinyint     = 1   out,            -- codigo de mercado
    @o_cambio_of    float       = 0   out,            -- cotizacion oficial
    @o_cambio_ofm1  float       = 0   out,
    @o_cambio_ofm2  float       = 0   out,
    @o_rd_operador  char(1)     = '+' out,            -- Operador para control de cotizacion. mon1
    @o_rd_cot_comp  float       = 0   out,            -- Cotizacion Compra
    @o_rd_cot_vent  float       = 0   out,            -- Cotizacion Venta
    @o_rd_operador2 char(1)     = '+' out,            -- Operador para control de cotizacion. mon2
    @o_rel_dolm1    float       = 1   out,            -- Relacion dolarizada moneda 1
    @o_rel_dolm2    float       = 1   out,            -- Relacion dolarizada moneda 2
    @o_factor       float       = 1   out,            -- Factor moneda 2 a multiplicar
    @o_cotis_fact   float       = 1   out             -- Factor moneda 2 a multiplicar
)
as 

/* Declaracion de variables de uso Interno */ 
declare @w_return         int,            -- valor que retorna 
        @w_sp_name        varchar(32),    -- nombre del stored procedure 
        @w_mercado        tinyint,        -- mercado monetario 
        @w_fechamax       datetime,       -- fecha maxima de busqueda
        @w_horamax        datetime,       -- hora maxima de busqueda
        @w_cod_fecha1     int,            -- codigo fecha cotizacion1
        @w_cod_fecha2     int,            -- codigo fecha cotizacion2
        @w_dolar_c        float,          -- cotizacion dolar compra 
        @w_dolar_v        float,          -- cotizacion dolar venta 
        @w_rel_m1         float,          -- relacion dolar - moneda1 
        @w_rel_m2         float,          -- relacion dolar - moneda2 
        @w_costo_1        float,          -- costo posicion compra 
        @w_monto_1        money,          -- monto posicion compra 
        @w_costo_2        float,          -- costo posicion venta 
        @w_monto_2        money,          -- monto posicion venta 
        @w_mon1_c         float,          -- cotizacion compra moneda1
        @w_mon1_v         float,          -- cotizacion venta moneda1 
        @w_mon2_c         float,          -- cotizacion compra moneda2
        @w_mon2_v         float,          -- cotizacion venta moneda2 
        @w_cambio_of      float,          -- cotizacion oficial banco central 
        @w_cambio_ofmon1  float,          -- cotizacion oficial moneda uno
        @w_cambio_ofmon2  float,          -- cotizacion oficial moneda dos
        @w_rd_operador    char(1),        -- Operador que define si se multiplica o divide moneda1
        @w_rd_operador2   char(1),        -- Operador que define si se multiplica o divide moneda2
        @w_rd_cot_comp    float,          -- Cotizacion Compra
        @w_rd_cot_vent    float,          -- Cotizacion Venta
        @w_rel_dolm1      float,          --
        @w_rel_dolm2      float,          --
        @w_factor         float,          -- Factor moneda 2 a multiplicar
        @w_cotis_fact     float,          -- Factor moneda 2 a multiplicar
        @w_monav          tinyint,        -- Moneda de Mantenimiento de valor
        @w_monufv         tinyint,        -- Moneda Unidad Financiera de valor
        @w_error          int             -- Control de error en busquedas

/* Asignar el nombre del stored procedure */
select @w_sp_name = 'sp_buscar_posicion_arbitraje'

if @t_show_version = 1
begin
   print 'Stored procedure sp_con_tipcambio, Version 4.0.0.3'
   return 0
end

select @w_dolar_c = 0,
       @w_dolar_v = 0,
       @w_rel_m1  = 0,
       @w_rel_m2  = 0,
       @w_costo_1 = 0,
       @w_monto_1 = 0,
       @w_costo_2 = 0,
       @w_monto_2 = 0,
       @w_mon1_c  = 0,
       @w_mon1_v  = 0,
       @w_mon2_c  = 0,
       @w_mon2_v  = 0

/*------------------------*/
/*  TIPO DE TRANSACCION   */
/*------------------------*/
if @t_trn <> 1640073
begin
   /* 'Tipo de transaccion no corresponde' */
   select @w_error = 1641019
   GOTO ERROR 
end

if @i_coddolar is null
begin
   select @i_coddolar = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = 'ADM'
      and pa_nemonico = 'CDOLAR' 

   if @@rowcount = 0 
   begin
      select @w_error = 1641187 
      GOTO ERROR 
   end
end

-----------------------
-- Busca monedas de MV
-----------------------
select @w_monav = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'CUVR' 
   and pa_producto = 'ADM'

select @w_monufv = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'CUVD' 
   and pa_producto = 'ADM'

----------------------------
-- Busqueda de cotizaciones       
----------------------------
/* buscar mercado */
select @w_mercado = om_mercado
  from te_oficina_mercado
 where om_oficina = @s_ofi

if @@rowcount = 0
   select  @w_mercado = 1
   
/* Si se trata de monedas nacionales se toma contizacion contable que no afecta la posicion */
if @i_moneda1 in (@w_monav, @w_monufv)
begin
   select @w_rd_operador = b.valor
     from cobis..cl_tabla a, 
          cobis..cl_catalogo b
    where a.tabla = 'te_media_dolar' 
      and a.codigo = b.tabla 
      and b.codigo = convert(char,@i_moneda1)

   select @w_mon1_c = ct_valor,
          @w_mon1_v = ct_valor
     from cob_conta..cb_cotizacion
    where ct_moneda  =  @i_moneda1
      and ct_fecha   = (select max(ct_fecha)
                          from cob_conta..cb_cotizacion
                         where ct_moneda  =  @i_moneda1
                           and ct_fecha   <= @i_fecha)
   if @@rowcount = 0 
   begin
      select @w_error = 141103
      GOTO ERROR
   end
   GOTO ENVIO
end

/* buscar fecha max en tabla cotizaciones */
select @w_fechamax = max(td_fecha)
  from te_tasa_divisas
 where td_moneda      = @i_coddolar
   and td_cod_mercado = @w_mercado
   and td_fecha       <= @i_fecha
   and td_autorizado   = 'A'
   
/* buscar hora max en tabla cotizaciones */
select  @w_horamax = max(td_hora)
  from  te_tasa_divisas
 where  td_moneda      = @i_coddolar
   and  td_fecha       = @w_fechamax
   and  td_cod_mercado = @w_mercado
   and td_autorizado   = 'A'
   
/* buscar cotizacion del dolar */
select  @w_dolar_c   = td_tasa_compra,
        @w_dolar_v   = td_tasa_venta,
        @w_cambio_of = td_costo_interno
  from  te_tasa_divisas
 where  td_moneda      = @i_coddolar
   and  td_fecha       = @w_fechamax
   and  td_hora        = @w_horamax
   and  td_cod_mercado = @w_mercado
   and td_autorizado   = 'A'
   
if @@rowcount = 0
   select @w_dolar_c = 0,
          @w_dolar_v = 0

/* Buscar cotizaciones moneda 1 */
if @i_moneda1 is not null
begin
    if @i_moneda1 != @i_codmn
    begin
       /* buscar fecha max en tabla cotizaciones para moneda 1 */
       select @w_fechamax = max(td_fecha)
         from te_tasa_divisas
        where td_moneda      =  @i_moneda1
          and td_cod_mercado =  @w_mercado
          and td_fecha       <= @i_fecha
          and td_autorizado   = 'A'

       if @@rowcount = 0
          return 1

       /* buscar hora max en tabla cotizaciones para moneda 1 */
       select @w_horamax = max(td_hora)
         from te_tasa_divisas
        where td_moneda      = @i_moneda1
          and td_fecha       = @w_fechamax
          and td_cod_mercado = @w_mercado
          and td_autorizado   = 'A'        
       if @@rowcount = 0
          return 1
       
       /* buscar cotizacion de la moneda 1 */
       select @w_mon1_c        = td_tasa_compra,
              @w_mon1_v        = td_tasa_venta,
              @w_cambio_ofmon1 = td_costo_interno,
              @w_cod_fecha1    = td_num_tasa
         from te_tasa_divisas
        where td_moneda       = @i_moneda1
          and td_fecha        = @w_fechamax
          and td_hora         = @w_horamax
          and td_cod_mercado  = @w_mercado
          and td_autorizado   = 'A'      
                   
       if @@rowcount = 0
          return 1
       select @w_cambio_of = @w_cambio_ofmon1
    end
    else
    begin
        select  @w_mon1_c = 1
        select  @w_mon1_v = 1
    end
end
      
/* Buscar cotizaciones moneda 2 */
if @i_moneda2 is not null
begin
   if @i_moneda2 != @i_codmn
   begin
      
      /* buscar fecha max en tabla cotizaciones para moneda 2 */
      select @w_fechamax = max(td_fecha)
        from te_tasa_divisas
       where td_moneda      =  @i_moneda2
         and td_cod_mercado =  @w_mercado
         and td_fecha       <= @i_fecha
         and td_autorizado   = 'A'      
      if @@rowcount = 0
         return 1
      
      /* buscar hora max en tabla cotizaciones para moneda 2 */
      select @w_horamax = max(td_hora)
        from te_tasa_divisas
       where td_moneda      = @i_moneda2
         and td_fecha       = @w_fechamax
         and td_cod_mercado = @w_mercado
         and td_autorizado   = 'A'
      if @@rowcount = 0
         return 1

      /* buscar cotizacion de la moneda 2 */
      select @w_mon2_c        = td_tasa_compra,
             @w_mon2_v        = td_tasa_venta,
             @w_cambio_ofmon2 = td_costo_interno,
             @w_cod_fecha2    = td_num_tasa
        from te_tasa_divisas
       where td_moneda       = @i_moneda2
         and td_fecha        = @w_fechamax
         and td_hora         = @w_horamax
         and td_cod_mercado  = @w_mercado
         and td_autorizado   = 'A'                          
      if @@rowcount = 0
         return 1               
                
    end
    else
    begin
        select  @w_mon2_c = 1
        select  @w_mon2_v = 1
    end
end

/* buscar relacion moneda1 - dolar */
if (@i_moneda1 != @i_coddolar) 
begin
   select @w_rel_m1      = rd_valor,
          @w_rd_operador = rd_operador,
          @w_rd_cot_comp = rd_cot_comp,
          @w_rd_cot_vent = rd_cot_vent
     from te_relacion_dolar
    where rd_secuencial  = @w_cod_fecha1
      and rd_cod_moneda  = @i_moneda1
      and rd_cod_mercado = @w_mercado

   if @@rowcount = 0 
   begin
      select @w_error = 1641193
      GOTO ERROR 
   end
end
else
   select @w_rel_m1      = 1,
          @w_rd_operador = b.valor
     from cobis..cl_tabla a,
          cobis..cl_catalogo b
    where a.tabla  = 'te_media_dolar'
      and b.tabla  = a.codigo
      and b.codigo = ltrim(rtrim(convert(varchar(3),@i_moneda1)))

/* buscar relacion moneda2 - dolar */
if isnull(@i_moneda2,0) != @i_coddolar and isnull(@i_moneda2,0) != @i_codmn
begin
   select @w_rel_m2       = rd_valor_v,
          @w_rd_operador2 = rd_operador,
          @w_rd_cot_comp  = rd_cot_comp,
          @w_rd_cot_vent  = rd_cot_vent
     from te_relacion_dolar
    where rd_secuencial  = @w_cod_fecha2
      and rd_cod_moneda  = @i_moneda2
      and rd_cod_mercado = @w_mercado

   if @@rowcount = 0 
   begin
      select @w_error = 1641193
      GOTO ERROR 
   end
end
else
   select @w_rel_m2       = 1,
          @w_rd_operador2 = b.valor
     from cobis..cl_tabla a,
          cobis..cl_catalogo b
    where a.tabla  = 'te_media_dolar'
      and b.tabla  = a.codigo
      and b.codigo = ltrim(rtrim(convert(varchar(3),@i_moneda2)))
   
select @w_rd_cot_comp = isnull(@w_rd_cot_comp,1), 
       @w_rd_cot_vent = isnull(@w_rd_cot_vent,1)   
 
/* buscar costo / monto posicion moneda 1 */
select @w_costo_1 = pd_costo_posicion,
       @w_monto_1 = pd_saldo_final
  from te_posicion_divisa
 where pd_moneda      = @i_moneda1
   and pd_cod_oficina = @i_suctes
   and pd_fecha       = (select max(pd_fecha)
                           from te_posicion_divisa
                          where pd_moneda      =  @i_moneda1
                            and pd_cod_oficina =  @i_suctes
                            and pd_fecha       <= @i_fecha)

/* buscar costo / monto posicion moneda 2 */
select @w_costo_2 = pd_costo_posicion,
       @w_monto_2 = pd_saldo_final
  from te_posicion_divisa
 where pd_moneda       = @i_moneda2
   and pd_cod_oficina  = @i_suctes
   and pd_fecha        = (select  max(pd_fecha)
                            from te_posicion_divisa
                           where pd_moneda      =  @i_moneda2
                             and pd_cod_oficina =  @i_suctes
                             and pd_fecha       <= @i_fecha)

---------------------------------------------------------------------------------
-- Controlar el paso de relacion dolarizada para envio a SB y Forward de Divisas
---------------------------------------------------------------------------------
if @w_rd_operador = '*' 
   select @w_rel_dolm1 = round(1/@w_rel_m1,6)
else
   select @w_rel_dolm1 = round(@w_rel_m1,6)

if @w_rd_operador2 = '*'
   select @w_rel_dolm2 = round(1/@w_rel_m2,6)
else
   select @w_rel_dolm2 = round(@w_rel_m2,6)

select @w_factor = isnull(@w_cambio_ofmon2, 1) / isnull(@w_cambio_ofmon1, 1)
select @w_cotis_fact = isnull(@w_cambio_ofmon2, @w_cambio_ofmon1)

------------------------
--  Envio de datos a FE
------------------------
ENVIO:
select @o_dolar_c      = @w_dolar_c,
       @o_dolar_v      = @w_dolar_v,
       @o_rel_m1       = @w_rel_m1,
       @o_rel_m2       = @w_rel_m2,
       @o_costo_1      = @w_costo_1,
       @o_monto_1      = @w_monto_1,
       @o_costo_2      = @w_costo_2,
       @o_monto_2      = @w_monto_2,
       @o_mon1_c       = @w_mon1_c,
       @o_mon1_v       = @w_mon1_v,
       @o_mon2_c       = @w_mon2_c,
       @o_mon2_v       = @w_mon2_v,
       @o_mercado      = @w_mercado,
       @o_cambio_of    = @w_cambio_of,
       @o_cambio_ofm1  = @w_cambio_ofmon1,
       @o_cambio_ofm2  = @w_cambio_ofmon2,
       @o_rd_operador  = @w_rd_operador,
       @o_rd_cot_comp  = @w_rd_cot_comp,
       @o_rd_cot_vent  = @w_rd_cot_vent,
       @o_rd_operador2 = @w_rd_operador2,
       @o_rel_dolm1    = @w_rel_dolm1,
       @o_rel_dolm2    = @w_rel_dolm2,
       @o_factor       = @w_factor,            -- Factor moneda 2 a multiplicar
       @o_cotis_fact   = @w_cotis_fact
   
return 0

ERROR:
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_error     -- No existe el codigo de moneda Dolar
    return 1

go
