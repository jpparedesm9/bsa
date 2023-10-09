/************************************************************************/
/*   Archivo:              genditmp.sp                                  */
/*   Stored procedure:     sp_genditmp                                  */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Fabian de la Torre                           */
/*   Fecha de escritura:   Jul. 1997                                    */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera los dividendos de la nueva operacion en tabla               */
/*   ca_dividendo_tmp.                                                  */
/*                              CAMBIOS                                 */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_genditmp')
   drop proc sp_genditmp
GO

create proc sp_genditmp
   @i_tabla_nueva             char(1) = 'S',
   @i_oficina                 smallint,
   @i_operacionca             int,
   @i_plazo                   int,
   @i_tplazo                  catalogo,
   @i_tdividendo              catalogo,
   @i_dias_gracia             smallint = 0,
   @i_fecha_pri_cuot          datetime = null,
   @i_periodo_cap             int,
   @i_periodo_int             int,
   @i_mes_gracia              int,
   @i_fecha_ini               datetime,
   @i_dia_fijo                int = 0,
   @i_evitar_feriados         char(1) = 'S',
   @i_base_calculo            char(1) = 'R',
   @i_recalcular              char(1) = 'N',
   @i_cuota                   money = 0,
   @i_ult_dia_habil           char(1) = 'N',
   @i_gracia_cap              smallint,
   @i_gracia_int              smallint,
   @i_reajusta_cuota_uno      char(1) = 'N',
   @i_reajuste                char(1) = 'N' ,
   @i_cuota_desde_cap         int     = null,
   @i_cambio_fecha            char(1) = 'N'

as declare
   @w_error                   int,
   @w_dias_op                 int,
   @w_dias_di                 int,
   @w_dias_di_aux             int,
   @w_dias_paso               int,
   @w_meses_di                int,
   @w_num_dividendos          int,
   @w_dividendo               int,
   @w_dividendo_vigente       int,
   @w_dias_cuota              int, --DAG
   @w_cont                    int,
   @w_dia_fijo                int,
   @w_di_de_cap               char(1),
   @w_di_de_int               char(1),
   @w_est_no_vigente          tinyint,
   @w_est_vigente             tinyint,
   @w_di_fecha_ini            datetime,
   @w_di_fecha_ven            datetime,
   @w_di_fecha_ven_aux        datetime,
   @w_di_fecha_ven_dfijo      datetime,
   @w_di_fecha_ini_dfijo      datetime,
   @w_fecha_inicio_aux        datetime,
   @w_aux                     smallint,
   @w_offset                  int,
   @w_tipo_rotativo           varchar(30),
   @w_tipo                    char(1),
   @w_cuota_fija_quincenal    char(1),
   @w_quincenal               catalogo,
   @w_dia                     int,
   @w_dias_prim_cuot_ven      int,
   @w_diff_mes                int,
   @w_mes                     int,
   @w_anio                    smallint,
   @w_dias_div_quin           smallint,
   @w_dias_div                smallint,
--   @w_num_dividendos      int,
   @w_di_fecha_ini_tmp        datetime,
   @w_resto                   tinyint,
   @w_prorroga                char(1),
   @w_dias_dividendo          smallint,
   @w_suma_cap                int,
   @w_suma_int                int,
   @w_di_fecha_ven_sinf       datetime,
   @w_contador_feriados       int,
   @w_toperacion              catalogo,
   @w_dias_gracia             int,
   @w_dias_gracia_disp        int,
   @w_dias_anio               int,
   @w_migrada                 cuenta,
   @w_corrimiento_cap         int,
   @w_mes_ini                 int,
   @w_rowcount                int,
   @w_nace_vencida            char(1),
   @w_dminc                   int,
   @w_dmaxc                   int,
   @w_pa_dimive               tinyint,
   @w_pa_dimave               tinyint,
   @w_dt_control_dia_pago     char(1),
   @w_dt_fecha_fija           char(1),
   @w_dt_dia_pago             int,
   @w_control_fecha           char(1),
   @w_div_mensuales           char(1),    ------REAM CAMBIO
   @w_tipo_amortizacion       varchar(10),
   @w_fecha_ini 			  datetime,        
   @w_fecha_fin               datetime,
   @w_ciudad_nacional         int ,
   @w_plazo                   int   
--print 'Imprimiendo  @i_dias_gracia'+ convert(varchar,@i_dias_gracia)

select @w_dias_gracia =  isnull(@i_dias_gracia,0)

select
@w_dias_gracia_disp  =  isnull(@i_dias_gracia,0),
@w_est_no_vigente    = 0,
@w_est_vigente       = 1,
@w_contador_feriados = 0,
@w_mes_ini           = 0


--CONTROL PARA MARCAR SI HAY CUOTA DE CAPITAL
if isnull(@i_gracia_cap, 0) = 0
   begin -- SIN GRACIA DE CAPITAL
      if  @i_cuota_desde_cap is null or (@i_periodo_cap = @i_periodo_int) or (@i_cuota_desde_cap >  (@i_periodo_cap / @i_periodo_int ) )
      select  @w_corrimiento_cap = 0
   else
      select  @w_corrimiento_cap = -(@i_periodo_cap / @i_periodo_int )+ @i_cuota_desde_cap
end
ELSE
begin
   if  @i_cuota_desde_cap is null or (@i_periodo_cap = @i_periodo_int)
      select  @w_corrimiento_cap = 0
   ELSE
      select  @w_corrimiento_cap = -(@i_periodo_cap / @i_periodo_int )+ @i_cuota_desde_cap
end


-- PARAMETRO GENERAL PARA DIAS MINIMOS CUOTA
select @w_dminc = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'DMINC'
and    pa_producto   = 'CCA'
set transaction isolation level read uncommitted

-- PARAMETRO GENERAL PARA DIAS MAXIMOS CUOTA
select @w_dmaxc = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'DMAXC'
and    pa_producto   = 'CCA'
set transaction isolation level read uncommitted

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'
set transaction isolation level read uncommitted
/* CONTROLAR DIA MINIMO DEL MES PARA FECHAS DE VENCIMIENTO */
select @w_pa_dimive = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DIMIVE'
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_error = 2101084 print 'NO SE ENCUENTRA EL PARAMETRO GENERAL DIMIVE DE CARTERA'
   goto ERROR
end


/* CONTROLAR DIA MAXIMO DEL MES PARA FECHAS DE VENCIMIENTO */
select @w_pa_dimave = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DIMAVE'
and   pa_producto = 'CCA'


if @@rowcount = 0 begin
   select @w_error = 2101084 print 'NO SE ENCUENTRA EL PARAMETRO GENERAL DIMIVE DE CARTERA'
   goto ERROR
end


-- CUOTA QUINCENAL
select @w_quincenal = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'QUIN'
and    pa_producto   = 'CCA'
set transaction isolation level read uncommitted

-- DIAS DEL DIVIDENDO QUINCENAL
select @w_dias_div_quin = pa_smallint
from   cobis..cl_parametro
where  pa_nemonico = 'DQUIN'
and    pa_producto   = 'CCA'
set transaction isolation level read uncommitted

select
@w_toperacion       = opt_toperacion,
@w_dias_anio        = opt_dias_anio,
@w_tipo             = opt_tipo,
@w_migrada           = opt_migrada,
@w_tipo_amortizacion = opt_tipo_amortizacion,
@w_fecha_ini         = opt_fecha_ini,
@w_fecha_fin         = opt_fecha_fin,
@w_plazo             = opt_plazo
from   ca_operacion_tmp
where  opt_operacion = @i_operacionca

if @w_tipo_amortizacion  = 'ROTATIVA' begin    
--HASTA ENCONTRAR EL HABIL 
	select @w_dias_di = @i_periodo_int * td_factor
    from   ca_tdividendo
    where  td_tdividendo = @i_tdividendo
	
	select @w_dias_op =  case when @w_dias_di % 7 = 0 and td_factor = 30  then 28
                                    when @w_dias_di % 7 = 0 and td_factor = 60  then 28 * 2
                                    when @w_dias_di % 7 = 0 and td_factor = 90  then 28 * 3
                                    when @w_dias_di % 7 = 0 and td_factor = 120 then 28 * 4
                                    when @w_dias_di % 7 = 0 and td_factor = 150 then 28 * 5
                                    when @w_dias_di % 7 = 0 and td_factor = 180 then 28 * 6
                                    when @w_dias_di % 7 = 0 and td_factor = 210 then 28 * 7
                                    when @w_dias_di % 7 = 0 and td_factor = 240 then 28 * 8
                                    when @w_dias_di % 7 = 0 and td_factor = 270 then 28 * 9
                                    when @w_dias_di % 7 = 0 and td_factor = 300 then 28 * 10
                                    when @w_dias_di % 7 = 0 and td_factor = 330 then 28 * 11
                                    when @w_dias_di % 7 = 0 and td_factor = 360 then 52 * 7
                                    else td_factor
   end
   from   ca_tdividendo
   where  td_tdividendo = @i_tplazo
	
   if @w_dias_op%30 = 0 select @w_fecha_fin = dateadd(mm,@w_dias_op*@i_plazo/30 ,@w_fecha_ini)
   else select @w_fecha_fin = dateadd(dd,@w_dias_op*@i_plazo ,@w_fecha_ini)
   
   while @i_evitar_feriados = 'S' and exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_fin) 
      select @w_fecha_fin= dateadd(dd,1,@w_fecha_fin)
	  
	--INSERTAR REGISTRO
   insert into ca_dividendo_tmp(
   dit_operacion,   dit_dividendo,        dit_fecha_ini,
   dit_de_capital,  dit_de_interes,       dit_fecha_ven,
   dit_gracia,      dit_gracia_disp,      dit_estado,
   dit_intento,     dit_prorroga,         dit_dias_cuota,
   dit_fecha_can)
   values(
   @i_operacionca,    1, 				  @w_fecha_ini,
   'S',              'S',                 @w_fecha_fin,
    0,                0,				  @w_est_no_vigente, ---ABR-02-2003
    0,               'N',                 datediff(dd,@w_fecha_ini,@w_fecha_fin),
   '01/01/1900')
   
   if @@error <> 0
   begin
      select @w_error = 710001
      goto ERROR
   end
   
   insert into ca_cuota_adicional_tmp(
   cat_operacion,    cat_dividendo,           cat_cuota)
   values(
   @i_operacionca,   1,                       0.0      )
   
   if @@error <> 0
   begin
      select @w_error = 710001
      goto ERROR
   end
   
   
   update ca_operacion_tmp set 
   opt_fecha_fin       = @w_fecha_fin
   where opt_operacion = @i_operacionca
   
   if @@error <> 0
   begin
      select @w_error = 710001
      goto ERROR
   end
   
   update ca_dividendo_tmp set 
   dit_fecha_ven  = @w_fecha_fin,
   dit_dias_cuota = datediff(dd,@w_fecha_ini,@w_fecha_fin)
   where dit_operacion = @i_operacionca  
   
   if @@error <> 0
   begin
      select @w_error = 710001
      goto ERROR
   end   
   
   return 0
end 


exec @w_error = sp_verifica_fecha
         @i_toperacion = @w_toperacion,
         @i_dia_pago   = @i_dia_fijo
if @w_error <> 0
 goto ERROR


-- CUOTAS QUINCENALES CON DIA DE PAGO FIJO A 15 Y 30 SOLO BANCO ESTADO
if @w_quincenal = @i_tdividendo and @i_dia_fijo > 0
   select @w_cuota_fija_quincenal = 'S'
else
   select @w_cuota_fija_quincenal = 'N'

-- PARA TABLAS DE DESEMBOLSOS PARCIALES
if @i_tabla_nueva = 'D' return 0

select @w_offset = 0

-- PARA TABLAS DE REAJUSTES
if @i_tabla_nueva = 'N' begin
   -- COPIAR LAS CUOTAS ADICIONALES DE LA TABLA DEFINITIVA
   select @w_num_dividendos = count(1)
   from   ca_dividendo
   where  di_operacion      = @i_operacionca

   select @w_offset = di_dividendo
   from   ca_dividendo
   where  di_operacion = @i_operacionca
   and    di_estado    = @w_est_vigente

   if @w_num_dividendos = @w_offset -- NO EXISTEN MAS DIVIDENDOS
      return 0

   while 1=1 begin
      if exists (select 1
                 from   ca_dividendo
                 where  di_operacion = @i_operacionca
                 and    di_dividendo = @w_offset
                 and    di_de_capital= 'S')
         break
      else
         select @w_offset = @w_offset + 1
   end
   select @w_offset = @w_offset + 1

   if exists (select 1 from  ca_cuota_adicional_tmp
               where  cat_operacion = @i_operacionca)
   begin
      delete ca_cuota_adicional_tmp
      where  cat_operacion = @i_operacionca
   end

   insert into ca_cuota_adicional_tmp
         (cat_operacion, cat_dividendo, cat_cuota)
   select ca_operacion,ca_dividendo - @w_offset + 1,ca_cuota
   from   ca_cuota_adicional
   where  ca_operacion = @i_operacionca
   and    ca_dividendo>= @w_offset

   if @@error <> 0 begin--alguien ya esta modificando esta operacion
      PRINT 'genditmp.sp Error Insetardo datos en ca_cuota_adicional_tmp'
      select @w_error = 710001
      goto ERROR
   end

end


select
@w_dividendo           = 0,
@w_di_fecha_ini        = @i_fecha_ini,
@w_di_fecha_ini_tmp    = @i_fecha_ini,
@w_aux                 = 0,
@w_di_fecha_ven_sinf   = @i_fecha_ini

--print 'plazo:' + convert(varchar,@i_plazo) + ' ' + 'periodo_cap:' + convert(varchar,@i_periodo_cap) + ' ' + 'periodo_int:' + convert(varchar,@i_periodo_int)
--print 'dia_fijo:' + convert(varchar, @i_dia_fijo)
--print '@i_base_calculo: ' + convert(varchar, @i_base_calculo)
--print '@i_evitar_feriados: ' + convert(varchar, @i_evitar_feriados)



-- PARA TABLAS NUEVAS
if @i_plazo = 0 begin
   select @w_num_dividendos = 1
   goto CREAR
end

-- VALIDAR DATOS DE ENTRADA
if @i_periodo_cap < @i_periodo_int begin
   select @w_error = 710012
   goto ERROR
end

if @i_periodo_cap % @i_periodo_int <> 0 begin
   select @w_error = 710013
   goto ERROR
end

-- CALCULAR NUMERO DE DIVIDENDOS
select
@w_dias_op = 0,
@w_dias_di = 0


select @w_dias_div = @i_periodo_int * td_factor
from   ca_tdividendo
where  td_tdividendo = @i_tplazo

select @w_dmaxc = @w_dmaxc + @w_dias_div


select @w_dias_di = @i_periodo_int * td_factor
from   ca_tdividendo
where  td_tdividendo = @i_tdividendo

--FDELAT
select @w_dias_op = @i_plazo * case when @w_dias_di % 7 = 0 and td_factor = 7   then 7* @i_periodo_int
                                    when @w_dias_di % 7 = 0 and td_factor = 30  then 28
                                    when @w_dias_di % 7 = 0 and td_factor = 60  then 28 * 2
                                    when @w_dias_di % 7 = 0 and td_factor = 90  then 28 * 3
                                    when @w_dias_di % 7 = 0 and td_factor = 120 then 28 * 4
                                    when @w_dias_di % 7 = 0 and td_factor = 150 then 28 * 5
                                    when @w_dias_di % 7 = 0 and td_factor = 180 then 28 * 6
                                    when @w_dias_di % 7 = 0 and td_factor = 210 then 28 * 7
                                    when @w_dias_di % 7 = 0 and td_factor = 240 then 28 * 8
                                    when @w_dias_di % 7 = 0 and td_factor = 270 then 28 * 9
                                    when @w_dias_di % 7 = 0 and td_factor = 300 then 28 * 10
                                    when @w_dias_di % 7 = 0 and td_factor = 330 then 28 * 11
                                    when @w_dias_di % 7 = 0 and td_factor = 360 then 52 * 7
                                    else td_factor
                                 end
from   ca_tdividendo
where  td_tdividendo = @i_tplazo
--FDELAT

if @w_dias_op = 0 begin
   select @w_error = 710007
   goto ERROR
end

if @w_dias_di = 0 begin
   select @w_error = 710007
   goto ERROR
end

if @w_dias_op % @w_dias_di <> 0 begin
   select @w_error = 710008
   goto ERROR
end

--print 'tplazo:' + @i_tplazo + ' ' + 'tdividendo:' + @i_tdividendo + ' ' + 'dias_op:' + convert(varchar,@w_dias_op) + ' ' + 'dias_di:' + convert(varchar,@w_dias_di)
--print ' fecha primera cuota ' + convert(varchar, @i_fecha_pri_cuot)

select @w_dias_di_aux = @w_dias_di

--print '@i_fecha_pri_cuot ' + cast(@i_fecha_pri_cuot as varchar)


if @i_fecha_pri_cuot is not null begin -- and @w_migrada is null begin
   select @w_dias_prim_cuot_ven = datediff(dd,@w_di_fecha_ini,@i_fecha_pri_cuot)
   if datediff(dd,@w_di_fecha_ini,@i_fecha_pri_cuot) <= 0 begin
      select @w_error = 710145
      goto ERROR
   end
end
ELSE
   select @w_dias_prim_cuot_ven = 0

if @w_dias_prim_cuot_ven > 0 and @w_dias_op > @w_dias_prim_cuot_ven begin
	-- LGU para que no aumente un dividendo cuando el 1er div es igual al padre grupal
    if @w_dias_prim_cuot_ven = @w_dias_di_aux select  @w_dias_prim_cuot_ven = 0  
   select @w_num_dividendos = @w_dias_op / @w_dias_di
   select @w_dias_op = @w_dias_op + @w_dias_prim_cuot_ven
end
else
begin
select @w_num_dividendos = @w_dias_op / @w_dias_di
end


-- LGU-INI 12/ABR/2017 CONTROL DE NUMERO DE CUOTAS DEL PRESTAMO - INTERCICLO
if @w_dias_prim_cuot_ven > 0 and @w_dias_prim_cuot_ven < @w_dminc
begin
	select @w_num_dividendos = @w_num_dividendos  - 1,
	       @w_dias_prim_cuot_ven = @w_dias_prim_cuot_ven + @w_dias_di_aux
end
--print ' 2.-====>>>>  w_num_dividendos  ' + convert(varchar,@w_num_dividendos )+ '  dias op  ' +  convert(varchar,@w_dias_op ) + ' DIAS PRI CUOTA ' + convert(varchar, @w_dias_prim_cuot_ven) + ' DIAS AUX ' + convert(varchar, @w_dias_di_aux)
-- LGU-FIN 12/ABR/2017 CONTROL DE NUMERO DE CUOTAS DEL PRESTAMO - INTERCICLO


if @w_num_dividendos > 555 begin
   select @w_error = 710147
   goto ERROR
end
-- LGU-INI 12/ABR/2017 CONTROL DE DIAS DE LA PRIMERA CUOTA - INTERCICLO

if @w_dias_prim_cuot_ven > 0
begin
   select @w_num_dividendos = @w_dias_op / @w_dias_di
   select @w_dias_op = @w_dias_op + @w_dias_prim_cuot_ven
end

-- LGU-FIN 12/ABR/2017 CONTROL DE DIAS DE LA PRIMERA CUOTA - INTERCICLO

-- PARA PRESTAMOS ROTATIVOS
select @w_tipo_rotativo = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'ROT'
and    pa_producto   = 'CCA'
set transaction isolation level read uncommitted

if @w_tipo = @w_tipo_rotativo begin
   update ca_operacion_tmp
   set    opt_divcap_original = @w_num_dividendos
   where  opt_operacion     = @i_operacionca

   if @@error != 0
      return 705079
end

/*PARA OPERACIONES CON LA MARCA "NACE VENCIDA" NO DEBE VALIDAR FECHA FIJA, OPERACIONES CON UN DIA DE VENCIMIENTO*/
select @w_nace_vencida = dt_nace_vencida
from ca_default_toperacion
where dt_toperacion  = @w_toperacion

---REAM CAMBIOS
select @w_div_mensuales = 'S'

if exists (select 1 from cobis..cl_catalogo
           where tabla = (select codigo from cobis..cl_tabla where tabla = 'ca_toper_sem')
           and   codigo = @w_toperacion)
    select @w_div_mensuales = 'N'

if exists (select 1 from cobis..cl_catalogo
           where tabla = (select codigo from cobis..cl_tabla where tabla = 'ca_toper_quin')
           and   codigo = @w_toperacion)
    select @w_div_mensuales = 'N'

---REAM CAMBIOS


if @w_div_mensuales = 'S'   ------REAM CAMBIO
BEGIN

-- CONTROL SOBRE TABLAS DE FECHA FIJA
if @i_dia_fijo > 0 and @w_cuota_fija_quincenal = 'N'
begin
   if @w_dias_di % 30 <> 0 and @w_nace_vencida = 'N'
   begin
      select @w_error = 710009
      goto ERROR
   end

   select @w_meses_di = @w_dias_di / 30

   if @w_meses_di is null
   select @w_meses_di = 0

   select @w_dias_paso = pa_tinyint
   from   cobis..cl_parametro
   where  pa_nemonico = 'NDO'
   and    pa_producto = 'CCA'

   if @@rowcount = 0
   begin
      select @w_error = 710010
      goto ERROR
   end
end

END

-- INSERTAR LOS DIVIDENDOS EN LA TABLA CA_DIVIDENDO_TMP
CREAR:

while @w_dividendo < @w_num_dividendos
begin
   select @w_dividendo = @w_dividendo + 1

      
   if @i_cambio_fecha = 'S' begin
      select @w_dividendo_vigente = di_dividendo
      from   cob_cartera..ca_dividendo
      where  di_operacion = @i_operacionca
      and    di_estado    = 1

      if @w_dividendo = @w_dividendo_vigente + 1 begin
         select @w_di_fecha_ini = di_fecha_ven
         from   cob_cartera..ca_dividendo
         where  di_operacion = @i_operacionca
         and    di_dividendo = @w_dividendo_vigente
      end
   end


   if @i_dia_fijo > 0 and @w_cuota_fija_quincenal='N' and @w_dias_prim_cuot_ven > 0
   begin
      --print 'condicion 1 cuota_fija_quincenal:' + @w_cuota_fija_quincenal 

      select @w_di_fecha_ven = @i_fecha_pri_cuot,
             @w_di_fecha_ini = @i_fecha_ini
      select @w_dias_prim_cuot_ven = 0
      select @w_di_fecha_ini_dfijo = @w_di_fecha_ven

      select @w_dias_dividendo = datediff(dd, @w_di_fecha_ini, @w_di_fecha_ven )

      if @w_dias_dividendo > @w_dmaxc begin
         print 'Numero de dias del primer dividendo excedido en: ' + cast( @w_dias_dividendo - @w_dmaxc as varchar ) + ' dia(s) - Maximo numero de dias permitidos para 1er Dividendo: ' + cast(@w_dmaxc as varchar)
         select @w_error = 724505
         goto ERROR
      end

      if @w_dias_dividendo < @w_dminc begin
         select @w_di_fecha_ven = dateadd(mm, 1, @w_di_fecha_ven)
         select @w_dias_dividendo = datediff(dd, @w_di_fecha_ini, @w_di_fecha_ven )
         select @w_di_fecha_ini_dfijo = @w_di_fecha_ven
      end

      if @w_dias_dividendo < @w_dminc and @w_nace_vencida = 'N' begin
         print '1 Numero de dias del primer dividendo inferior a: ' + cast( @w_dias_dividendo - @w_dminc as varchar ) + ' dia(s) - M¡nimo n£mero de dias permitidos para 1er Dividendo: ' + cast(@w_dminc as varchar)
         select @w_error = 724506
         goto ERROR
      end

   end
   ELSE
   begin ---(A)

      if @i_dia_fijo > 0 and @w_cuota_fija_quincenal='N' and @w_dias_prim_cuot_ven=0
      begin  --(B1)
         --print 'condicion 2 cuota_fija_quincenal:' + @w_cuota_fija_quincenal
         select @w_cont = 1
         while 2 = 2
         begin
            select @w_dia_fijo = @i_dia_fijo

	    if @w_meses_di is null select @w_meses_di = 0  ---REAM CAMBIO
            --INICIO PRIMERA CUOTA

            if @w_dividendo  = 1 and @w_meses_di = 1 -- Periodicidad = de mensual
               select @w_di_fecha_ini_dfijo =  dateadd(dd, -datepart(dd,@w_di_fecha_ini), @w_di_fecha_ini )
            else
               select @w_di_fecha_ini_dfijo = @w_di_fecha_ini

            select @w_di_fecha_ven_dfijo = dateadd (mm, @w_meses_di * @w_cont, @w_di_fecha_ini_dfijo)
            --print 'fecha_ven_dfijo:' + convert(varchar, @w_di_fecha_ven_dfijo, 101) + ' meses_di:' + convert(varchar,@w_meses_di) + ' cont:' + convert(varchar,@w_cont)
            -- VENCIMIENTO CON BASE EN EL DIA FIJO
            select @w_di_fecha_ven_aux = dateadd(dd, @w_dia_fijo - datepart(dd, @w_di_fecha_ven_dfijo), @w_di_fecha_ven_dfijo)

            -- SI EL DIA FIJO NO EXISTE EN EL MES SE TOMA EL ULTIMO DIA
            if datepart(mm, @w_di_fecha_ven_aux) <> datepart(mm, @w_di_fecha_ven_dfijo)
               select @w_di_fecha_ven_aux = dateadd(dd, -datepart(dd, @w_di_fecha_ven_aux), @w_di_fecha_ven_aux)

            --if datepart(dd, @w_di_fecha_ven_dfijo) > @w_dia_fijo and @w_dividendo = 1                                       -- REQ 175: PEQUEÑA EMPRESA
            if @w_dividendo = 1
            begin
               if @w_di_fecha_ven_dfijo < @w_di_fecha_ven_aux and datediff(dd, @w_di_fecha_ven_dfijo, @w_di_fecha_ven_aux) > datediff(dd, dateadd(mm, -1, @w_di_fecha_ven_dfijo), @w_di_fecha_ven_aux)
                  select @w_di_fecha_ven_dfijo = dateadd(mm, -1, @w_di_fecha_ven_dfijo)
               if @w_di_fecha_ven_dfijo > @w_di_fecha_ven_aux and datediff(dd, @w_di_fecha_ven_aux, @w_di_fecha_ven_dfijo) > datediff(dd, @w_di_fecha_ven_dfijo, dateadd(mm, 1, @w_di_fecha_ven_aux))
                  select @w_di_fecha_ven_dfijo = dateadd(mm, 1, @w_di_fecha_ven_dfijo)
            end

            select @w_di_fecha_ven_dfijo = dateadd(dd, -datepart(dd,@w_di_fecha_ven_dfijo), @w_di_fecha_ven_dfijo)
            select @w_di_fecha_ven_dfijo = dateadd(dd, @w_dia_fijo, @w_di_fecha_ven_dfijo)

            --if @w_dia_fijo > datepart(dd,@w_di_fecha_ven_dfijo)                                                             -- REQ 175: PEQUEÑA EMPRESA
            if @w_di_fecha_ven_dfijo < dateadd(dd, @w_dia_fijo - datepart(dd, @w_di_fecha_ven_dfijo), @w_di_fecha_ven_dfijo)
               select @w_di_fecha_ven_dfijo = dateadd(dd,-datepart(dd,@w_di_fecha_ven_dfijo),@w_di_fecha_ven_dfijo)

            /*Calcular dias del dividendo acorde a base de calculo*/
            if @i_base_calculo = 'E'
            begin
               exec @w_error = sp_dias_cuota_360
               @i_fecha_ini = @w_di_fecha_ini,
               @i_fecha_fin = @w_di_fecha_ven_dfijo,
               @o_dias      = @w_dias_dividendo out
               if @w_error != 0 goto ERROR

            end
            else
               select @w_dias_dividendo = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven_dfijo)

            --if @w_dias_dividendo > @w_dmaxc                                                                                 -- REQ 175: PEQUEÑA EMPRESA
            --   select @w_di_fecha_ven_dfijo = dateadd(dd, - (@w_dias_dividendo - @w_dmaxc) ,@w_di_fecha_ven_dfijo)

            /*BASE DE CALCULO E*/
            if @w_dias_dividendo < @w_dias_di and @w_dividendo = 1
            begin

               if @w_dias_dividendo < @w_dminc
                  select @w_di_fecha_ven_dfijo = dateadd (mm, @w_meses_di * @w_cont,@w_di_fecha_ven_dfijo)

               /* Calcular dias del dividendo acorde a base de calculo */
               if @i_base_calculo = 'E' begin
                  exec @w_error = sp_dias_cuota_360
                  @i_fecha_ini = @w_di_fecha_ini,
                  @i_fecha_fin = @w_di_fecha_ven_dfijo,
                  @o_dias      = @w_dias_dividendo out

                  if @w_error != 0 goto ERROR
               end
               else
                  select @w_dias_dividendo = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven_dfijo)
            end

            if @w_dias_dividendo > @w_dias_di + @w_dias_paso and @w_dividendo = 1
            begin

               select @w_di_fecha_ven_dfijo = dateadd(dd,-(@w_dias_dividendo - (@w_dias_dividendo + @w_dias_paso )),@w_di_fecha_ven_dfijo)

               /* Calcular dias del dividendo acorde a base de calculo */
               if @i_base_calculo = 'E'
               begin
                  exec @w_error = sp_dias_cuota_360
                  @i_fecha_ini = @w_di_fecha_ini,
                  @i_fecha_fin = @w_di_fecha_ven_dfijo,
                  @o_dias      = @w_dias_dividendo out
                  if @w_error != 0 goto ERROR
               end
               else
                  select @w_dias_dividendo = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven_dfijo)

             end

            if @w_dias_dividendo <=  @w_dias_paso and @w_dividendo = 1 and datepart(dd,@w_di_fecha_ven_dfijo) <> @i_dia_fijo
               select @w_di_fecha_ven_dfijo = dateadd(dd,-(@w_dias_dividendo - (@w_dias_di + 1)),@w_di_fecha_ven_dfijo)

            if @w_dias_dividendo > @w_dmaxc  and @w_dividendo = 1  begin
               print 'Numero de dias del primer dividendo excedido en: ' + cast( @w_dias_dividendo - @w_dmaxc as varchar ) + ' dia(s) - Maximo numero de dias permitidos para 1er Dividendo: ' + cast(@w_dmaxc as varchar) + '-' + cast(@w_dias_dividendo as varchar)
               select @w_error = 724505
               goto ERROR
            end

            if @w_dias_dividendo < @w_dminc begin
               select @w_di_fecha_ven_dfijo = dateadd (mm,@w_meses_di * @w_cont,@w_di_fecha_ven_dfijo)
               select @w_dias_dividendo = datediff(dd, @w_di_fecha_ini, @w_di_fecha_ven_dfijo )
               select @w_di_fecha_ini_dfijo = @w_di_fecha_ven
            end

            if @w_dias_dividendo < @w_dminc and @w_nace_vencida = 'N' begin
               print '2 Numero de dias del primer dividendo inferior a: ' + cast( @w_dias_dividendo - @w_dminc as varchar ) + ' dia(s) - Minimo numero de dias permitidos para 1er Dividendo: ' + cast(@w_dminc as varchar) + '-' + cast(@w_dias_dividendo as varchar)
               select @w_error = 724506
               goto ERROR
            end

            /* VALIDA SI ES REAJUSTABLE*/
            if @i_reajuste = 'S'
            begin
               if (datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven_dfijo) < @w_dias_paso and @w_dividendo = 1 and @i_reajusta_cuota_uno = 'S') or (datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven_dfijo) = 0 )
                  select @w_cont = @w_cont + 1
               else
                  break
            end  ----Reajuste
            else
               break

         end  ---while 2 = 2

         select @w_di_fecha_ven = @w_di_fecha_ven_dfijo
         select  @w_di_fecha_ini_dfijo = @w_di_fecha_ven

      end   ---(B1)
      ELSE
      begin ---(B2)

         --LPO INICIO. PARA DETERMINAR LOS DIAS DE LA PRIMERA CUOTA
         if @w_dividendo = 1 and @w_dias_prim_cuot_ven = 0
            select @w_dias_prim_cuot_ven = @w_dias_di_aux
         --LPO FIN. PARA DETERMINAR LOS DIAS DE LA PRIMERA CUOTA

	     	--print 'condicion 3 cuota_fija_quincenal:' + @w_cuota_fija_quincenal
         if @w_dividendo = 1 and @w_cuota_fija_quincenal = 'S'
            select @w_di_fecha_ven = dateadd(dd,@w_dias_div_quin * @w_dividendo,@i_fecha_ini)

         ELSE
         begin  /*PARA CALCULOS REALES*/
		        --print 'condicion 4 cuota_fija_quincenal:' + @w_cuota_fija_quincenal + ' ' + 'base_calculo:' + @i_base_calculo
            if @i_base_calculo = 'R'
            begin
               if @i_evitar_feriados = 'S'
               BEGIN
                  exec @w_error = sp_dias_cuota_real
                  @i_tdividendo = @i_tdividendo,
                  @i_fecha_ini  = @w_di_fecha_ini_tmp,
                  @i_dias_di    = @w_dias_di_aux,
                  @o_dias_di    = @w_dias_di out

                  if @w_error != 0
                     goto ERROR

                  select  @w_di_fecha_ven = dateadd(dd,@w_dias_di,@w_di_fecha_ini_tmp)
               end
               ELSE
               begin
                  exec @w_error = sp_dias_cuota_real
                  @i_tdividendo = @i_tdividendo,
                  @i_fecha_ini = @w_di_fecha_ini,
                  @i_dias_di   = @w_dias_di_aux,
                  @o_dias_di   = @w_dias_di out

                  if @w_error != 0
                     goto ERROR

                  select  @w_di_fecha_ven = dateadd(dd,@w_dias_di,@w_di_fecha_ini)
               end
            end
            ELSE
            begin  /*PARA CALCULOS COMERCIALES*/
               if @i_evitar_feriados = 'S'
               begin
                  select @w_di_fecha_ini_tmp = @w_di_fecha_ven_sinf

                  exec @w_error = sp_calculo_comercial
                  @i_tdividendo = @i_tdividendo,
                  @i_fecha_ini_op = @w_di_fecha_ini_tmp,
                  @i_di_fecha_ini = @w_di_fecha_ini_tmp,
                  @i_dias_interes = @w_dias_di,
                  @o_fecha_ven = @w_di_fecha_ven out

                  if @w_error != 0
                     goto ERROR

                  select @w_di_fecha_ven_sinf = @w_di_fecha_ven
               end
               ELSE
               begin

                  exec @w_error = sp_calculo_comercial
                  @i_tdividendo   = @i_tdividendo,
                  @i_fecha_ini_op = @w_di_fecha_ini,
                  @i_di_fecha_ini = @w_di_fecha_ini,
                  @i_dias_interes = @w_dias_di,
                  @o_fecha_ven    = @w_di_fecha_ven out

                  if @w_error != 0
                     goto ERROR
               end
            end  --/*PARA CALCULOS COMERCIALES*/

      --print 'fecha_ven:' + convert(varchar, @w_di_fecha_ven, 101) + ' ' + 'dias_di:' + convert(varchar,@w_dias_di) + ' div:' + convert(varchar,@w_dividendo)
	    --print 'fecha_ven_aux:' + convert(varchar, @w_di_fecha_ven_aux, 101)

            -- MANEJO DE DIVIDENDOS QUINCENALES
            if @w_cuota_fija_quincenal = 'S'
            begin
               if @w_dividendo = 1
               begin
                  select @w_mes  = datepart(month,@i_fecha_ini)
                  if @w_mes = 2
                     select @w_di_fecha_ven_aux = dateadd(dd,@w_dias_div_quin, @i_fecha_ini)
                  else
                     select @w_di_fecha_ven_aux = @w_di_fecha_ven
               end
               ELSE
               begin
                  select @w_mes  = datepart(month,@w_di_fecha_ven_aux)

                  if @w_mes = 2
                     select @w_di_fecha_ven_aux = dateadd(dd,@w_dias_div_quin,@w_di_fecha_ven_aux)
                  else
                     select @w_di_fecha_ven_aux = dateadd(dd,@w_dias_di, @w_di_fecha_ven_aux)
               end

               select @w_dia  = datepart(day,@w_di_fecha_ven_aux)
               select @w_mes  = datepart(month,@w_di_fecha_ven_aux)
               select @w_anio = datepart(year,@w_di_fecha_ven_aux)
               --print 'dia:'+convert(varchar,@w_dia)+' mes:'+convert(varchar,@w_mes)+' año:'+convert(varchar,@w_anio)
               if @w_dia > 30 or @w_dia <= 15
                  select @w_dia = 15
               else
               if (@w_dia > 15 or @w_dia <= 31 ) and @w_dia <> 15
               begin
                  if @w_mes = 2
                  begin
                     if @w_anio % 4 = 0
                        select @w_dia = 29
                     else
                        select @w_dia = 28
                  end
                  else
                     select @w_dia = 30
               end

               select
               @w_di_fecha_ven_aux = convert(datetime,
                                     convert(varchar(2),@w_mes) + '/' +
                                     convert(varchar(2),@w_dia) + '/' +
                                     convert(varchar(4),@w_anio),101)

               select @w_di_fecha_ven = @w_di_fecha_ven_aux
            end   --if @w_cuota_fija_quincenal = 'S'
         end      --if @w_dividendo = 1 and @w_cuota_fija_quincenal = 'S'
      end   --(B2)
   end   --(A)

   -- CONTROL PARA EVITAR DIAS FERIADOS
   select  @w_contador_feriados = 0,
           @w_dias_gracia       = 0
   --print 'control feriados:' + @i_evitar_feriados  + ' ult_dia_habil:' + @i_ult_dia_habil + ' base_calculo:' + @i_base_calculo
   while ( @i_evitar_feriados = 'S' and @w_cuota_fija_quincenal = 'N' and @i_base_calculo <> 'R')
   begin
      if exists(select 1 from  cobis..cl_dias_feriados,cobis..cl_oficina
                where  df_fecha   = @w_di_fecha_ven
                and    df_ciudad  = of_ciudad
                and    of_oficina = @i_oficina)
      begin
         if @i_ult_dia_habil = 'S'
            select  @w_di_fecha_ven = dateadd(dd, -1, @w_di_fecha_ven)
         ELSE
            select  @w_di_fecha_ven = dateadd(dd, 1, @w_di_fecha_ven)
      end
      else
         break
   end

   if @i_base_calculo = 'R' begin
      select @w_dias_cuota = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven)
      select @w_di_fecha_ini_tmp = @w_di_fecha_ven
   end

   if @i_base_calculo = 'E'  begin
      exec @w_error = sp_dias_cuota_360
      @i_fecha_ini = @w_di_fecha_ini,
      @i_fecha_fin = @w_di_fecha_ven,
      @o_dias      = @w_dias_cuota out

      if @w_error != 0 goto ERROR

      select @w_di_fecha_ini_tmp = @w_di_fecha_ven

   end

   -- VERIFICAR EL TIPO DEL DIVIDENDO
   select
   @w_di_de_cap = 'N',
   @w_di_de_int = 'N'

   if (@w_dividendo - @w_corrimiento_cap) % (@i_periodo_cap / @i_periodo_int) = 0
      select @w_di_de_cap = 'S'

   if (@w_dividendo ) % (@i_periodo_int / @i_periodo_int) = 0
      select @w_di_de_int = 'S'

   if datepart(mm,@w_di_fecha_ven) = @i_mes_gracia
      select @w_num_dividendos =  @w_num_dividendos + (@i_periodo_cap / @i_periodo_int)

   if @i_base_calculo = 'R' and @i_recalcular = 'N'
   begin
      if @i_evitar_feriados = 'N'
         select @w_dias_cuota = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven)
   end

   if @i_base_calculo = 'R' and @i_recalcular = 'S'
      select @w_dias_cuota = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven)
/*
   if @i_base_calculo = 'E' and @i_recalcular = 'N'
   begin
      if @i_fecha_pri_cuot is null and @i_dia_fijo = 0
         select @w_dias_cuota = @w_dias_di
      else
         select @w_dias_cuota = @w_dias_di
   end
*/
   if @i_base_calculo = 'E' and @i_recalcular = 'S'
   begin
      --TENGO QUE OBTENER EL NUMERO DE DIAS DE LA CUOTA TOMANDO EN CUENTA
      --QUE CADA MES PUEDE TENER 30 DIAS

      exec @w_error = sp_dias_base_comercial
      @i_fecha_ini = @w_di_fecha_ini,
      @i_fecha_ven = @w_di_fecha_ven,
      @i_dividendo = @w_dividendo,
      @i_fecha_pri_cuota = @i_fecha_pri_cuot,
      @i_dia_fijo  = @i_dia_fijo,
      @i_opcion    = 'D',
      @o_dias_int  = @w_dias_cuota out

      if @w_error != 0
         goto ERROR
   end

   ----PARA LA PRIMERA CUOTA SI HAY DIA FIJO DE PAGO
   if @w_dividendo = 1 and @i_dia_fijo > 0  and  @i_base_calculo = 'E'
   begin
      select @w_dias_cuota = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven)

      if @w_dias_anio = 360
      begin
         exec sp_dias_cuota_360
         @i_fecha_ini = @w_di_fecha_ini,
         @i_fecha_fin = @w_di_fecha_ven,
         @o_dias      = @w_dias_cuota out
      end
   end
   --PARA LA PRIMERA CUOTA SI HAY DIA FIJO DE PAGO

   if datepart(mm,@w_di_fecha_ven) <> @i_mes_gracia
   begin
      if exists (select 1 from ca_prorroga
                 where pr_operacion = @i_operacionca
                 and   pr_nro_cuota = @w_dividendo+@w_aux)
         select @w_prorroga = 'S'
      else
         select @w_prorroga = 'N'

--print '@i_operacionca ' + cast(@i_operacionca as varchar)
--print '@w_dividendo ' + cast(@w_dividendo as varchar)
--print '@w_aux ' + cast(@w_aux as varchar)

      --INSERTAR REGISTRO
      insert into ca_dividendo_tmp
            (dit_operacion,   dit_dividendo,        dit_fecha_ini,
             dit_fecha_ven,   dit_de_capital,       dit_de_interes,
             dit_gracia,      dit_gracia_disp,      dit_estado,
             dit_dias_cuota,  dit_intento,          dit_prorroga,
             dit_fecha_can)
      values(@i_operacionca,   @w_dividendo+@w_aux, @w_di_fecha_ini,
             @w_di_fecha_ven,  @w_di_de_cap,        @w_di_de_int,
             @w_dias_gracia,   @w_dias_gracia_disp, @w_est_no_vigente, ---ABR-02-2003
             isnull(@w_dias_cuota,0),    0,                   @w_prorroga,
             '01/01/1900')
      if @@error <> 0
      begin
         select @w_error = 710001
         goto ERROR
      end
	  
      -- INSERTAR REGISTRO EN CASO DE NO EXISTIR
      if not exists (select 1 from ca_cuota_adicional_tmp
                     where cat_operacion = @i_operacionca
                     and   cat_dividendo = @w_dividendo+@w_aux)
      begin
         insert into ca_cuota_adicional_tmp
               (cat_operacion,    cat_dividendo,           cat_cuota)
         values(@i_operacionca,   @w_dividendo + @w_aux,   0.0      )

         if @@error <> 0
         begin
            select @w_error = 710001
            goto ERROR
         end
      end
      select @w_di_fecha_ini = @w_di_fecha_ven
   end
   ELSE
      select @w_aux = @w_aux - 1, @w_di_fecha_ini = @w_di_fecha_ven
end --Lazo de dividendos

if @i_base_calculo = 'R' and @i_evitar_feriados = 'S'
begin


   select @w_num_dividendos = max(dit_dividendo)
   from   ca_dividendo_tmp
   where  dit_operacion = @i_operacionca

   select @w_cont = 1

   while @w_cont <= @w_num_dividendos
   begin
      select @w_di_fecha_ini     = dit_fecha_ini,
             @w_di_fecha_ven     = dit_fecha_ven,
             @w_di_fecha_ven_aux = dit_fecha_ven
      from   ca_dividendo_tmp
      where  dit_operacion = @i_operacionca
      and    dit_dividendo = @w_cont

      while 1=1
      begin
         if exists (select 1 
                    from   cobis..cl_dias_feriados,cobis..cl_oficina
                    where  df_fecha   = @w_di_fecha_ven_aux
                    and    df_ciudad  = of_ciudad
                    and    of_oficina = @i_oficina)
         begin           
            if @i_ult_dia_habil = 'S'
               select  @w_di_fecha_ven_aux = dateadd(dd, -1, @w_di_fecha_ven_aux)
            else
              select  @w_di_fecha_ven_aux = dateadd(dd, 1, @w_di_fecha_ven_aux)
         end
         else
            break
      end
      
      select @w_cont = @w_cont + 1   
      
      if @w_cont < @w_num_dividendos
      begin
         select @w_di_fecha_ven = dit_fecha_ven
         from   ca_dividendo_tmp
         where  dit_operacion = @i_operacionca
         and    dit_dividendo = @w_cont
         
         if @w_di_fecha_ven_aux >= @w_di_fecha_ven
            select @w_di_fecha_ven_aux = dateadd(dd, -1, @w_di_fecha_ven)
      end
       
      if @w_di_fecha_ven_aux <> @w_di_fecha_ven
      begin
         select @w_dias_cuota = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven_aux)

         update ca_dividendo_tmp
         set    dit_fecha_ven  = @w_di_fecha_ven_aux,
                dit_dias_cuota = isnull(@w_dias_cuota,0)
         where  dit_operacion = @i_operacionca
         and    dit_dividendo = @w_cont - 1

         if @@error <> 0
         begin
            select @w_error = 710001
            goto ERROR
         end

         update ca_dividendo_tmp
         set    dit_fecha_ini = @w_di_fecha_ven_aux
         where  dit_operacion = @i_operacionca
         and    dit_dividendo = @w_cont                  
         
         if @@error <> 0
         begin
            select @w_error = 710001
            goto ERROR
         end
      END
      ELSE
      BEGIN
         select @w_dias_cuota = datediff(dd,@w_di_fecha_ini,@w_di_fecha_ven)

         update ca_dividendo_tmp
         set    dit_dias_cuota = isnull(@w_dias_cuota,0)
         where  dit_operacion = @i_operacionca
         and    dit_dividendo = @w_cont - 1

         if @@error <> 0
         begin
            select @w_error = 710001
            goto ERROR
         end
      end
   end
end
     
return 0

ERROR:
return @w_error
GO

