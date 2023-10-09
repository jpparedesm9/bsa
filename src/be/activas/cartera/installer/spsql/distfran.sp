/************************************************************************/
/*   Archivo:            distfran.sp                                    */
/*   Stored procedure:   sp_dist_francesa                               */
/*   Base de datos:      cob_cartera                                    */
/*   Producto:           Cartera                                        */
/*   Disenado por:       Fabian de la Torre                             */
/*   Fecha de escritura: Jul. 1997                                      */
/************************************************************************/
/*                               IMPORTANTE                             */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'Cobiscorp', representantes exclusivos para el Ecuador de la    */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de Cobiscorp o su representante.          */
/************************************************************************/ 
/*                          PROPOSITO                                   */
/*      Procedimiento  que distribuye el valor de la cuota en el        */
/*      sistema frances                                                 */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR           RAZON                                 */
/* julio-17-2001 Elcira Pelaez    calculo de @w_tipo_rubro = 'Q'        */
/* Ago  -06-2003 ELcira Pelaez    Personaliza BAC linea tipo 'V'        */
/* Dic  -01-2005 Elcira Pelaez    Revision calculo cuota CAP            */
/*               FQ               NR 293                                */
/*               FQ               NR 615                                */
/* Mayo-04-2001  Elcira Pelaez     NR-293 calculo comision fng          */
/* Oct-24-2008   R Garces         Calculo cuota uno rubro SEGDEUVEN     */
/* Jul-28-2009   G Alvis          Caso 235 - Interv - Asegura que se    */
/*                                genere amortizacion correspondiente   */
/*                                a todos los dividendos                */
/* May-08-2014   Luis Moreno      CCA 406 SEGDEUEM                      */
/* May-12-2017   Jorge Salazar    CGS-S112643 PARAMETRIZACIÓN BASE DE   */
/*                                CARTERA APF                           */
/* Jul-26-2017   Sandra Echeverri CGS-S126738 INCLUSION DEL IVA AL VLOR */
/*                                DE LA CUOTA FRANCESA TABLA AMORT      */
/* May-18-2020   ANDY GONZALEZ    DESPLAZAMIENTOS  FASE 2 REESTRUCTURA- */
/*                                  CION DE OPERACIONES POR PANDEMIA    */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_dist_francesa')
   drop proc sp_dist_francesa
go

create proc sp_dist_francesa
   @i_operacionca             int,
   @i_cuota                   float,
   @i_gracia_cap              int,
   @i_dist_gracia             char(1)   = 'S',
   @i_gracia_int              int,
   @i_dias_anio               int       = 360,
   @i_periodo_crecimiento     smallint  = 0,
   @i_tasa_crecimiento        float     = 0,
   @i_num_dec                 int,
   @i_opcion_cap              char(1)   = null,
   @i_tipo_crecimiento        char(1)   = null,
   @i_causacion               char(1)   = 'L',
   @i_debug                   char(1)   = 'N',
   @o_plazo                   int       = null out
as  
declare 
   @w_error                   int,
   @w_num_dividendos          int,
   @w_di_dias_cuota           int,
   @w_dividendo               int,
   @w_cont_int                int,
   @w_adicional               money,
   @w_saldo_cap               money,
   @w_capital_original        money,
   @w_valor_rubro             float,
   @w_ro_porcentaje           float,
   @w_ro_porcentaje_efa       float,
   @w_valor_calc              float,
   @w_valor_gr                money,
   @w_valor_cuota_cap         float,
   @w_valor_cuota_int         float,
   @w_valor_iva_int           float,      --CGS-S126738
   @w_di_fecha_ini            datetime,
   @w_di_fecha_ven            datetime,
   @w_concepto                catalogo,
   @w_estado                  tinyint,
   @w_tipo_rubro              char(1),
   @w_ro_fpago                char(1),
   @w_de_capital              char(1),
   @w_de_interes              char(1),
   @w_factor                  tinyint,
   @w_provisiona              char(1),
   @w_salir                   tinyint,
   @w_cuota_tot               money,
   @w_reajuste                char(1),
   @w_periodo_int             int,
   @w_div_vigente             int,
   @w_tipo                    char(1),
   @w_saldo_operacion         char(1),
   @w_saldo_insoluto          char(1),
   @w_div_final               int,   -- SI ESTE VALOR QUEDA NULO NO HAY REDUCCION EN EL PLAZO
   @w_valor_para_seg          money,
   @w_fecha_limite_fng        datetime,
   @w_concepto_base           catalogo,
   @w_valor_baser             money,
   @w_cto_fng_vencido         catalogo,
   @w_cto_fng_iva             catalogo,
   @w_rot_periodo             smallint,
   @w_rot_num_dec             tinyint,
   @w_contador_periodos_int   int,
   @w_contador_periodos_van   int,
   @w_parametro_segdeuven     varchar(30),
   @w_parametro_segdeuem      varchar(30),
   @w_int_iva                 varchar(30),   --CGS-S126738 
   @w_valor_acumulado         money,
   @w_dias_int                int,
   @w_ro_porcentaje_int       float,
   @w_aumento_cap             money,
   @w_dias_calculo            int,
   @w_nro_periodos            int,
   @w_capitalizado            money,                   -- REQ 175: PEQUEÑA EMPRESA
   @w_saldo_base              money,                   -- REQ 175: PEQUEÑA EMPRESA
   @w_toperacion              catalogo,
   @w_convertir_tasa          char(1),
   @w_moneda                  int,
   @w_ro_concepto_asociado     catalogo 

-- REQ 175 - PEQUEÑA EMPRESA
create table #rubro_op(
rot_concepto      catalogo    not null,
rot_gracia        money           null
)

--LECTURA DEL PARAMETRO CODIGO DEL RUBRO SEGURO DEUDORES VENCIDO
select @w_parametro_segdeuven = pa_char
from cobis..cl_parametro  with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'SEDEVE'

if @w_parametro_segdeuven is null begin
return 724651
end


--LECTURA DEL PARAMETRO RUBRO INTERES_IVA
select @w_int_iva = pa_char
from cobis..cl_parametro  with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'IVAINT'

if @w_int_iva is null begin
return 724652
end
---NR-293
select @w_cto_fng_vencido = rot_concepto,
       @w_rot_periodo     = isnull(rot_periodo,0)
from ca_rubro_op_tmp
where rot_operacion = @i_operacionca
and   rot_fpago in ('P','A')
and   rot_concepto in (select codigo
                       from cobis..cl_catalogo a
                       where a.tabla = (select codigo from cobis..cl_tabla  with (nolock)
                                        where tabla = 'ca_rubros_fng'))
if @@rowcount <> 0
begin
   select @w_cto_fng_iva = rot_concepto
   from ca_rubro_op_tmp
   where rot_operacion = @i_operacionca
   and   rot_concepto_asociado = @w_cto_fng_vencido
end


/*NUMERO DE PERIODOS PARA EL CALCULO DEL SEGURO DE VIDA (SEGDEUVEN)*/
select @w_nro_periodos = opt_periodo_int * td_factor /30 
from cob_cartera..ca_operacion_tmp,ca_tdividendo 
where opt_operacion = @i_operacionca
and   opt_tdividendo = td_tdividendo


select @w_contador_periodos_int = @w_rot_periodo,
       @w_contador_periodos_van  = 0

-- CARGA DE VARIABLES INICIALES
select @w_salir      = 0,  -- AUMENTADO 29/Ene/99
       @w_cuota_tot  = 0,   --VALOR DE LA CUOTA EN TABLAS PERIODO CAPITAL <> 1
       @w_div_final  = null,
       @w_valor_para_seg = 0

-- CALCULAR EL MONTO DEL CAPITAL TOTAL
select
@w_saldo_cap    = sum(rot_valor),
@w_capitalizado = sum(rot_base_calculo)
from   ca_rubro_op_tmp
where  rot_operacion  = @i_operacionca
and    rot_tipo_rubro = 'C'
and    rot_fpago      in ('P','A','T') -- PERIODICO VENCIDO 

select @w_capital_original = @w_saldo_cap

-- DETERMINAR EL NUMERO DE DIVIDENDOS EXISTENTES
select @w_num_dividendos = count (1)
from   ca_dividendo_tmp
where  dit_operacion  = @i_operacionca
and    dit_dividendo >= 1

select @w_div_vigente = 0

-- DETERMINAR EL NUMERO DE DIVIDENDOS EXISTENTES
select @w_div_vigente = dit_dividendo
from   ca_dividendo_tmp
where  dit_operacion  = @i_operacionca
and    dit_estado = 1  --VIGENTE

-- DETERMINAR SI USA TASA EQUIVALENTE --DAG
select @w_reajuste  = isnull(opt_reajustable,'N'),
@w_periodo_int      = isnull(opt_periodo_int,0),
@w_tipo             = opt_tipo,
@w_fecha_limite_fng = opt_fecha_dex,
@w_toperacion       = opt_toperacion,
@w_moneda           = opt_moneda
from  ca_operacion_tmp
where opt_operacion  = @i_operacionca

--LECTURA DE CONVERTIR TASA

select @w_convertir_tasa  = dt_convertir_tasa
from  ca_default_toperacion 
where dt_toperacion = @w_toperacion 
and   dt_moneda = @w_moneda

-- LAZO PRINCIPAL DE DIVIDENDOS
select @w_cont_int        = 0,
       @w_valor_cuota_cap = 0,     
       @w_valor_cuota_int = 0,
       @w_valor_iva_int   = 0

declare 
cursor_dividendo cursor
for select dit_dividendo,  dit_fecha_ini,  dit_fecha_ven,
           dit_de_capital, dit_de_interes, dit_estado,
           cat_cuota,      dit_dias_cuota
    from   ca_dividendo_tmp, ca_cuota_adicional_tmp
    where  dit_operacion  = @i_operacionca
    and    cat_operacion  = @i_operacionca
    and    cat_dividendo  = dit_dividendo
    and    dit_dividendo >= 1
    order by dit_dividendo                  -- GAL 28/JUL/2009 - CASO 235 - INTERVENTORIA
for read only

open cursor_dividendo

fetch cursor_dividendo
into  @w_dividendo,  @w_di_fecha_ini, @w_di_fecha_ven,
      @w_de_capital, @w_de_interes,   @w_estado,
      @w_adicional,  @w_di_dias_cuota

while   @@fetch_status = 0
begin
   if (@@fetch_status = -1)
      return 710004

   -- CONTROL DE DIAS PARA ANIOS BISIESTOS
   exec @w_error = sp_dias_anio
   @i_fecha       = @w_di_fecha_ini,
   @i_dias_anio   = @i_dias_anio,
   @o_dias_anio   = @i_dias_anio out

   if @w_error != 0
      return @w_error

   select @w_contador_periodos_van = @w_contador_periodos_van + 1

   -- CONTAR DIVIDENDOS TIPO INTERES
   if @w_de_interes = 'S'
      select @w_cont_int = @w_cont_int + 1

   if @w_dividendo = @w_num_dividendos -- ULTIMO DIVIDENDO
      select @w_salir           = 1

   -- CURSOR DE RUBROS TABLA CA_RUBRO_OP_TMP
   declare cursor_rubros cursor
   for select rot_concepto,         rot_tipo_rubro,      rot_porcentaje,
              rot_valor,            rot_fpago,           rot_provisiona,
              rot_saldo_op,         rot_saldo_insoluto,
              rot_porcentaje_efa,   rot_num_dec,         rot_concepto_asociado
       from   ca_rubro_op_tmp
       where  rot_operacion  = @i_operacionca
       and    rot_fpago      in ('P','A','T') 
       and    rot_tipo_rubro in ('V', 'Q', 'O', 'I', 'C') 
       order by case when rot_tipo_rubro = 'I' then 1 
                     when rot_tipo_rubro = 'V' then 2
                     when rot_tipo_rubro = 'Q' then 3
                     when rot_tipo_rubro = 'O' then 4
                     when rot_tipo_rubro = 'C' then 5
                end
   for read only

   open  cursor_rubros

   fetch cursor_rubros
   into  @w_concepto,            @w_tipo_rubro,       @w_ro_porcentaje, 
         @w_valor_rubro,         @w_ro_fpago,         @w_provisiona,
         @w_saldo_operacion,     @w_saldo_insoluto,
         @w_ro_porcentaje_efa,   @w_rot_num_dec,      @w_ro_concepto_asociado

   while @@fetch_status = 0
   begin
      if @@fetch_status = -1
         return 710004

      select @w_valor_gr = 0
	  
	  if @w_ro_concepto_asociado is not null 
           and not exists (select 1 from ca_amortizacion_tmp 
           where amt_operacion = @i_operacionca 
           and amt_concepto    = @w_ro_concepto_asociado 
           and amt_dividendo   = @w_dividendo) GOTO NEXT_RUBRO



      -- RUBROS DE TIPO CAPITAL
      if @w_tipo_rubro = 'C' begin
        -- VALOR DE LA CUOTA DE CAPITAL                 
        select @w_valor_cuota_cap = (@i_cuota - @w_valor_cuota_int - @w_valor_iva_int)-- MENOS IVA INT CGS-S126738  
        
        if @i_debug = 'S' 
        begin
           PRINT 'SALDO CAP '   + cast (@w_valor_cuota_cap as varchar)
           PRINT 'CUOTA'        + cast (@i_cuota as varchar)
           PRINT 'VLOR CUOTA INT' + cast (@w_valor_cuota_int as varchar)
           PRINT 'VLOR IVA INT'   + cast (@w_valor_iva_int as varchar)
        end
/*  LGU para que no infle la primera cuota
         if @w_dividendo = 1 and @w_num_dividendos > 1 
         begin 
            select @w_dias_calculo = opt_periodo_int * td_factor 
            from   ca_operacion_tmp, ca_tdividendo
            where  opt_operacion  = @i_operacionca
            and    opt_tdividendo = td_tdividendo

            select @w_dias_int =  dit_dias_cuota - @w_dias_calculo
            from ca_dividendo_tmp
            where dit_operacion = @i_operacionca
            and   dit_dividendo  = 1

            if @w_dias_int <> 0  --calculo de interes en la primera cuota
            begin
               select @w_ro_porcentaje_int = rot_porcentaje
               from   ca_rubro_op_tmp
               where  rot_concepto  = 'INT'
               and    rot_operacion = @i_operacionca

               exec @w_error        = sp_calc_intereses -- DE UN DIA EXPONENCIAL
                    @tasa           = @w_ro_porcentaje_int,
                    @monto          = @w_saldo_cap,
                    @dias_anio      = 360,
                    @num_dias       = @w_dias_calculo,
                    @causacion      = 'L',
                    @causacion_acum = 0,
                    @intereses      = @w_aumento_cap out

               select @w_valor_cuota_cap  =  @w_valor_cuota_cap  + (@w_valor_cuota_int - @w_aumento_cap)
            end
         end
         */

         if @w_valor_cuota_cap < 0 select @w_valor_cuota_cap = 0

         -- FQ: SI ES UNA CUOTA QUE LE TOCARIA CAPITAL
         -- Y LA CUOTA YA PASO ALCANZO LAS CUOTAS DE GRACIA
         if @w_de_capital = 'S'  and @w_dividendo > @i_gracia_cap
            select @w_valor_cuota_cap = @w_valor_cuota_cap + @w_adicional
         else
            select @w_valor_cuota_cap = @w_adicional

         if (@w_valor_calc + @w_saldo_cap) > @w_capital_original
            select @w_valor_calc = @w_capital_original - @w_saldo_cap

         if @w_salir = 0 or (@w_dividendo = 1 and @w_num_dividendos > 1)
         begin
            if @w_de_capital = 'N'
               select @w_valor_calc = 0.00  
            else
               select @w_valor_calc = round(@w_valor_cuota_cap, @i_num_dec)
         end
         else
         begin
            select @w_valor_calc = @w_saldo_cap
         end
         ---AJUSTE DE LA ULTIMA CUOTA QUE SE DA CUANDO EL VALOR ES MENOR QUE EL 3% DE
         ---LA CUOTA PACTADA
         if ((@w_saldo_cap - @w_valor_calc)/@i_cuota) <= 0.03
         begin
            select @w_valor_calc = @w_saldo_cap
            select @w_div_final = @w_dividendo,
                   @w_salir     = 1
         end

         select @w_saldo_cap     = @w_saldo_cap - @w_valor_calc,
                @w_valor_cuota_int = 0
                         
      end

      -- RUBROS DE TIPO INTERES
      if @w_tipo_rubro = 'I'
      begin
         if @w_ro_porcentaje_efa = 0 -- INTERES TOTAL 0
            select @w_valor_calc = 0
         else
         begin
            if @w_ro_fpago in ('P', 'T')
               select @w_ro_fpago = 'V'

            -- CALCULAR LA TASA EQUIVALENTE
            if @w_convertir_tasa = 'S'
            begin
               exec @w_error           = sp_conversion_tasas_int
                    @i_periodo_o       = 'A',
                    @i_modalidad_o     = 'V',
                    @i_num_periodo_o   = 1,
                    @i_tasa_o          = @w_ro_porcentaje_efa,
                    @i_periodo_d       = 'D',
                    @i_modalidad_d     = @w_ro_fpago,
                    @i_num_periodo_d   = @w_di_dias_cuota,
                    @i_dias_anio       = @i_dias_anio,
                    @i_num_dec         = @w_rot_num_dec,
                    @o_tasa_d          = @w_ro_porcentaje output

               if @w_error != 0
                  return @w_error

            end

            -- INI - REQ 175: PEQUEÑA EMPRESA
            -- INI - REQ 175: PEQUEÑA EMPRESA
            if @i_dist_gracia = 'C' and @w_dividendo <= @i_gracia_int
               select @w_saldo_base = @w_saldo_cap - isnull(@w_capitalizado, 0)
            else
               select @w_saldo_base = @w_saldo_cap
            -- FIN - REQ 175: PEQUEÑA EMPRESA

            exec @w_error = sp_calc_intereses
            @tasa          = @w_ro_porcentaje,
            @monto         = @w_saldo_base,
            @dias_anio     = @i_dias_anio,
            @num_dias      = @w_di_dias_cuota,
            @causacion     = @i_causacion,
            @intereses     = @w_valor_calc out

            if @w_error != 0
               return @w_error

            select @w_valor_calc = round(@w_valor_calc , @i_num_dec)
            select @w_valor_cuota_int = @w_valor_calc -- PARA EL CALCULO DE LA CUOTA DE CAPITAL

         end
      end

      -- RUBROS DE TIPO PORCENTAJE, VALOR
      if @w_tipo_rubro in ('V','O')      
      begin
         select @w_valor_calc = round (@w_valor_rubro, @i_num_dec)
      end

      -- RUBROS CALCULADOS
      ---EPB ABR-03-2003 - 2003
      ---CONVENIOS
      if @w_tipo = 'V' and not exists (select 1 from cob_credito..cr_corresp_sib where tabla  = 'T115' and codigo = @w_toperacion)
      begin
         -- RUBROS CALCULADOS
         if (@w_tipo_rubro = 'Q'  and @w_saldo_operacion = 'S') or (@w_tipo_rubro = 'Q'  and @w_saldo_insoluto = 'S')
         begin
            ---EPB: EL valor inicial del rubro   para convenios se hace sobre cap + int
            ---     EL programa calsvid.sp lo recalcula para q que de un valor fijo
            select @w_valor_para_seg = @w_saldo_cap + @w_valor_cuota_int
            select @w_valor_rubro = @w_valor_para_seg * @w_ro_porcentaje/100.0/360.0*@w_di_dias_cuota
            select @w_valor_calc = round(@w_valor_rubro , @i_num_dec)
         end
      end
      else
      begin
         if @w_tipo_rubro = 'Q'  and @w_saldo_insoluto = 'S'         
         begin
            select @w_valor_rubro = 0                                 --- se calculara en otro proceso
            select @w_valor_calc = round(@w_valor_rubro , @i_num_dec)
         end  
         else if @w_tipo_rubro = 'Q'  and @w_saldo_operacion = 'S'
         begin
            if @w_concepto in (@w_parametro_segdeuven, @w_parametro_segdeuem)
            begin
               select @w_ro_porcentaje =  @w_ro_porcentaje * @w_nro_periodos
            end

            -- INI - REQ 175: PEQUEÑA EMPRESA
            if @i_dist_gracia = 'C' and @w_dividendo <= @i_gracia_int
               select @w_saldo_base = @w_saldo_cap - isnull(@w_capitalizado, 0)
            else
               select @w_saldo_base = @w_saldo_cap
            -- FIN - REQ 175: PEQUEÑA EMPRESA

            select @w_valor_rubro = @w_saldo_base * @w_ro_porcentaje/100.0
            select @w_valor_calc = round(@w_valor_rubro , @i_num_dec)

            if @i_debug = 'S'
            begin
               PRINT 'SALDO CAP '   + cast (@w_saldo_cap as varchar)
               PRINT 'DIVIDENDO '   + cast (@w_dividendo as varchar)
               PRINT 'CONCEPTO '    + cast (@w_concepto as varchar)
               PRINT 'VALOR CALC '  + cast (@w_valor_calc as varchar)
            end

            /* CONSIDERACION ESPECIAL PARA LA PRIMERA CUOTA DEL RUBRO SEGDEUVEN */
            /*if @w_parametro_segdeuven = @w_concepto and @w_dividendo = 1 and datediff (dd,@w_di_fecha_ini,@w_di_fecha_ven) > 30
            begin
               select @w_valor_rubro = @w_valor_rubro * 2,
                      @w_valor_calc  = @w_valor_calc * 2

               if @i_debug = 'S' 
               begin
                  PRINT "ENTRO"
                  PRINT "VALOR CALC "  + cast (@w_valor_calc as varchar)
                  PRINT "VALOR RUBRO "  + cast (@w_valor_rubro as varchar)
               end
            end*/


            if  @w_concepto in (@w_cto_fng_vencido, @w_cto_fng_iva)
            and @w_di_fecha_ven > isnull(@w_fecha_limite_fng, 'jan 1 2099')
            begin       
               select @w_valor_calc = 0.00
            end
            else if @w_rot_periodo > 0 and @w_contador_periodos_van > 1
            begin
               --LA PRIMERA CUOTA LLEVA VALOR y DESPUES SOLO CUANDO EL NUMERO DE PERIODOS SEA = AL @w_rot_periodo
               if (@w_contador_periodos_van = @w_contador_periodos_int)
               begin
                  select @w_valor_calc = @w_valor_calc
                  select @w_contador_periodos_int = @w_contador_periodos_int + @w_rot_periodo
               end
               else
                  select @w_valor_calc = 0.00
            end
         end
         else if @w_tipo_rubro = 'Q'
         begin
            select @w_valor_calc = round(@w_valor_rubro , @i_num_dec)
         end

         ---NR-293
         if  @w_tipo_rubro = 'O'
         begin                                                                 --NR-293
            select @w_concepto_base = rot_concepto_asociado
            from ca_rubro_op_tmp
            where rot_operacion = @i_operacionca
            and   rot_concepto  = @w_concepto

            select @w_valor_baser = isnull(amt_cuota,0)
            from ca_amortizacion_tmp
            where amt_operacion  = @i_operacionca
            and   amt_dividendo  = @w_dividendo
            and   amt_concepto   = @w_concepto_base

            if @w_valor_baser > 0
               select @w_valor_calc = round(@w_valor_baser * @w_ro_porcentaje / 100,@i_num_dec)
            else
               select @w_valor_calc = 0            
			   
            --CGS-S126738
			if @w_concepto = @w_int_iva begin
			   select @w_valor_iva_int = @w_valor_calc
			end
              
         
         end
      end---FIN NR-293
      ---(1)
      /*
      -- DISTRIBUCION DE LA GRACIA DE INTERES
      if @w_tipo_rubro not in ('C','Q','O') and @i_gracia_int > 0
      begin
         if @w_cont_int <= @i_gracia_int
         begin 
            update ca_rubro_op_tmp  with (rowlock)
            set    rot_gracia = isnull(rot_gracia,0) + isnull(@w_valor_calc,0)
            where  rot_operacion = @i_operacionca
            and    rot_concepto  = @w_concepto
            
            if @@error != 0
               return 710002
            select @w_valor_gr = @w_valor_calc * -1
        end
         ELSE
         begin
            select @w_valor_gr = rot_gracia
            from   ca_rubro_op_tmp
            where  rot_operacion = @i_operacionca
            and    rot_concepto = @w_concepto

            if @i_dist_gracia = 'S'
               select @w_valor_gr = @w_valor_gr / (@w_num_dividendos - @w_cont_int + 1)
            
            if @i_dist_gracia = 'M' -- PERIODOS MUERTOS
               select @w_valor_gr = 0   

            if @w_valor_gr != 0
            begin
               update ca_rubro_op_tmp  with (rowlock)
               set    rot_gracia = rot_gracia - isnull(@w_valor_gr,0)
               where  rot_operacion = @i_operacionca
               and    rot_concepto  = @w_concepto

               if @@error != 0
                  return 710002
            end
         end
      end
      */
      -- SI RUBRO NO PROVISIONA, ENTONCES ACUMULADO = CUOTA
      if @w_provisiona = 'S'
         select  @w_factor = 0
      else
         select  @w_factor = 1

      select @w_cuota_tot = @w_cuota_tot + @w_valor_calc
      -- select @w_valor_gr =  round(@w_valor_gr,@i_num_dec)            REQ 175 - PEQUEÑA EMPRESA - SE RECALCULA AL FINAL

      insert into ca_amortizacion_tmp  with (rowlock) (
      amt_operacion,             amt_dividendo,             amt_concepto,
      amt_cuota,                 amt_gracia,                amt_pagado,
      amt_acumulado,             amt_estado,                amt_periodo,
      amt_secuencia)
      values(
      @i_operacionca,            @w_dividendo,              @w_concepto,
      @w_valor_calc,             @w_valor_gr,               0,
      @w_valor_calc * @w_factor, @w_estado,                 0,
      1 )

      if (@@error <> 0)
         return 710001

      select @w_valor_baser     = 0
	  
      NEXT_RUBRO:
      fetch cursor_rubros
      into  @w_concepto,            @w_tipo_rubro,       @w_ro_porcentaje, 
            @w_valor_rubro,         @w_ro_fpago,         @w_provisiona,
            @w_saldo_operacion,     @w_saldo_insoluto,
            @w_ro_porcentaje_efa,   @w_rot_num_dec,      @w_ro_concepto_asociado
   end -- WHILE CURSOR RUBROS
   close cursor_rubros
   deallocate cursor_rubros

   if @w_de_capital = 'S'
   begin
      -- APLICAR CRECIMIENTO DE LA CUOTA
      if @i_periodo_crecimiento !=0
      begin
         if @i_opcion_cap = 'D'
            select @w_dividendo = @w_dividendo - @i_gracia_cap

         if @w_dividendo % @i_periodo_crecimiento = 0 and @w_dividendo > 1
         begin
            if @i_tipo_crecimiento = 'P'  --PORCENTAJE
               select @i_cuota = @i_cuota + @i_cuota * (@i_tasa_crecimiento/100.0)

            if @i_tipo_crecimiento = 'V'  -- POR VALOR
               select @i_cuota = @i_cuota + @i_tasa_crecimiento
         end

         if @i_opcion_cap = 'D'
            select @w_dividendo = @w_dividendo + @i_gracia_cap
      end

      select @w_cuota_tot     = 0
   end

   if @w_salir = 1
      break

   fetch cursor_dividendo
   into  @w_dividendo,  @w_di_fecha_ini, @w_di_fecha_ven,
         @w_de_capital, @w_de_interes,   @w_estado,
         @w_adicional,  @w_di_dias_cuota
end -- WHILE CURSOR DIVIDENDOS

close cursor_dividendo
deallocate cursor_dividendo

/*ACTUALIZA ACUMULADO = 0 RUBROS PROVISIONA = S DE DIVIDENDOS NO VIGENTES*/
select @w_dividendo = min(dit_dividendo)
from   ca_dividendo_tmp
where  dit_operacion  = @i_operacionca
and    dit_estado = 0

select  @w_dividendo = isnull(@w_dividendo,0)

update ca_amortizacion_tmp  with (rowlock) set
amt_acumulado = 0
from ca_rubro_op_tmp
where amt_operacion = rot_operacion
and   amt_concepto  = rot_concepto
and   rot_provisiona = 'S'
and   rot_operacion  = @i_operacionca
and   amt_dividendo  >= @w_div_vigente
if @@error != 0
   return 710002

update ca_amortizacion_tmp  with (rowlock) set
amt_acumulado = 0
from ca_rubro_op_tmp
where amt_operacion = rot_operacion
and   amt_concepto  = rot_concepto
and   rot_provisiona = 'N'
and   rot_operacion  = @i_operacionca
and   amt_concepto not in ('CAP')
and   amt_dividendo  >= @w_dividendo
if @@error != 0
   return 710002

if @w_div_final is not null
   select @w_num_dividendos = @w_div_final,
   @w_salir          = 1

-- ELIMINACION DE DIVIDENDOS SOBRANTES
if @w_salir =  1
begin
   delete ca_dividendo_tmp  with (rowlock)
   where  dit_operacion = @i_operacionca
   and    dit_dividendo > @w_num_dividendos

   if @@error != 0
      return 710003

   delete ca_amortizacion_tmp  with (rowlock)
   where  amt_operacion = @i_operacionca
   and    amt_dividendo > @w_num_dividendos

   if @@error != 0
      return 710003
end

-- INI - REQ 173: PEQUEÑA EMPRESA
insert into #rubro_op
select 
rot_concepto,
rot_gracia
from ca_rubro_op_tmp
where rot_operacion  = @i_operacionca
and   rot_fpago      in ('P','A','T') 
and   rot_tipo_rubro in ('V', 'Q', 'O', 'I', 'C')

if @i_gracia_int > 0 or exists(select 1 from #rubro_op where rot_gracia > 0)
begin
   select @w_dividendo = 0
         
   while 1=1
   begin
      select top 1
      @w_dividendo = dit_dividendo
      from   ca_dividendo_tmp
      where  dit_operacion = @i_operacionca
      and    dit_dividendo > @w_dividendo
      order by dit_dividendo

      if @@rowcount = 0
         break

      select @w_concepto = ''

      while 1=1
      begin
         select top 1
         @w_concepto   = rot_concepto,
         @w_tipo_rubro = rot_tipo_rubro
         from   ca_rubro_op_tmp
         where  rot_operacion   = @i_operacionca
         and    rot_fpago      in ('P','A','T') 
         and    rot_tipo_rubro in ('V', 'Q', 'O', 'I')
         and    rot_concepto    > @w_concepto
         order by rot_concepto

         if @@rowcount = 0
            break

         select @w_valor_calc = amt_cuota
         from ca_amortizacion_tmp
         where amt_operacion = @i_operacionca
         and   amt_dividendo = @w_dividendo
         and   amt_concepto  = @w_concepto

         -- DISTRIBUCION DE LA GRACIA DE INTERES
         if @w_dividendo <= @i_gracia_int
         begin
            update #rubro_op
            set    rot_gracia = isnull(rot_gracia, 0) + @w_valor_calc
            where  rot_concepto  = @w_concepto

            if @@error != 0
               return 710002

            select @w_valor_gr = @w_valor_calc * -1

            if @w_tipo_rubro = 'I' and @i_dist_gracia = 'C'
               select @w_valor_gr = 0                  
         end
         else
         begin
            select @w_valor_gr = rot_gracia
            from   #rubro_op
            where  rot_concepto  = @w_concepto

            if @w_tipo_rubro = 'I'
            begin
               if @i_dist_gracia = 'S'
                  select @w_valor_gr = @w_valor_gr / (@w_num_dividendos - @w_dividendo + 1)

               if @i_dist_gracia in ('M', 'C')
                  select @w_valor_gr = 0
            end

            select @w_valor_gr = round(@w_valor_gr, @i_num_dec)

            if @w_valor_gr != 0
            begin
               update #rubro_op
               set rot_gracia = rot_gracia - isnull(@w_valor_gr,0)
               where rot_concepto = @w_concepto

               if @@error != 0
                  return 710002
            end
         end

         update ca_amortizacion_tmp
         set amt_gracia = @w_valor_gr
         where amt_operacion = @i_operacionca
         and   amt_dividendo = @w_dividendo
         and   amt_concepto  = @w_concepto
      end -- WHILE CURSOR RUBROS
   end -- WHILE CURSOR DIVIDENDOS
end
-- FIN - REQ 173: PEQUEÑA EMPRESA

select @o_plazo = @w_num_dividendos

return 0

ERROR:
return @w_error
go