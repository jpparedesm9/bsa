 /************************************************************************/
/*      Archivo:                calcdint.sp                             */
/*      Stored procedure:       sp_calc_diario_int                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para los calculos diarios   */
/*      de intereses del Modulo de Plazo Fijo.                          */
/*      La provision de dias feriados se realiza el ult dia laborable   */
/*      previo al feriado                                               */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR              RAZON                            */
/*      11-Dic-94   Juan Lam           Creacion                         */
 /************************************************************************/
/*      25-Sep-95   Carolina Alvarado  Revision                         */
/*      01-Sep-1999 Dolores Guerrero   Cambio valor @w_area_des         */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_calc_diario_int' and type = 'P')
   drop proc sp_calc_diario_int
go

create proc sp_calc_diario_int (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14926,
@i_num_banco            cuenta          = '%', 
@i_dias_interes         int             = 1,
@i_batch                int             = 1,  --*-*
@i_fecha_proceso        datetime,
@i_tipo                 char(1)         = 'N',
@i_tipo_act             char(1)         = 'N',
@i_ejecuta_contable     char(1)         = 'S',   --*-*
@i_oficina              catalogo        = '%',
@i_ciudad               catalogo        = '%',
@i_en_linea             char(1)         = 'S' --I.CVA May-11-07 para controlar el retur del error
)
with encryption
as
declare 
@w_sp_name              descripcion,
@w_descripcion          descripcion,
@o_comprobante          int,
@w_return               tinyint,
@w_numdeci              tinyint,
@w_usadeci              char(1),
@w_empresa              tinyint,
@w_filial               tinyint,
@w_area_des             int,
@w_oficina              int,
@w_flag                 tinyint, 
@w_fecha_hoy            datetime,
@w_fecha                datetime,
@w_fecha_siguiente      datetime,
@w_ult_fecha_calculo    datetime,
@w_dias_interes         smallint,
@w_tproducto            tinyint,
@w_intereses            float,
@w_provision            float,
@w_tot_intereses        float,
@w_intereses_ret        float,
@w_intereses_dia        float,
@w_interes_n_dia        decimal(30,16),      --+-+
@w_resto                decimal(30,16),      --+-+
@w_money                money,
@w_valor_retenido       money,
@w_error                int,
@w_total_error          int,
@w_producto             catalogo,
/** VARIABLES PARA PF_PARAMETRO **/
@w_ret_paga_int         varchar(30),
/** VARIABLES PARA PF_OPERACION **/
@w_operacionpf          int,
@w_dias_anio            smallint,
@w_tasa                 float,
@w_monto_blq            money,
@w_monto_pg_int         money,
@w_estado               catalogo,
@w_fpago                catalogo,
@w_toperacion           catalogo,
@w_tplazo               catalogo,
@w_moneda               tinyint,
@w_residuo              float,
@w_afectacion           char(1),
/** VARIABLES PARA PF_RETENCION **/
@w_rt_secuencial        smallint,
@w_rt_valor             money,
@w_rt_int_retencion     money,
@w_rt_suspendida        catalogo,
@w_op_dias_reales       char(1), --04/04/2000 Fecha Comercial 
@w_interes              money,      --+-+
@w_interes_aux          money,      --+-+
@w_interes_1_dia        decimal(30,16),   --+-+
@w_interes_1_dia_aux    decimal(30,16),   --+-+
@w_fecha1               datetime,   --+-+
@w_contador             int,     --+-+
@w_dia_pago             int,     --+-+
@w_ult_dia_mes_pago     tinyint,  --*-*                          -- GAL 14/SEP/2009 - RVVUNICA
@w_dias_int_fcom	    smallint,	--*-*				RVVUNICA
@w_fecha_ult_final      datetime
/** DEBUG **/
select   
   @w_sp_name       = 'sp_calc_diario_int',
   @w_empresa       = 1,    
   @w_filial        = 1,
   @w_area_des      = 6100 , 
   @w_tot_intereses = 0,
   @w_contador      = 0,
   @w_dias_int_fcom = 1		--*-*

if @s_date = NULL
   select @s_date = fp_fecha from cobis..ba_fecha_proceso

/** CARGADO DE LOS PARAMETROS **/
select @w_ret_paga_int = ret_pag_int 
from pf_parametro

select @w_fecha_hoy = convert(datetime,convert(varchar,@i_fecha_proceso,101))

select   @w_total_error  = 0   

select   @w_operacionpf    = op_operacion,       
      @w_dias_anio      = op_base_calculo,
      @w_tasa           = op_tasa,
      @w_toperacion     = op_toperacion,
      @w_oficina        = op_oficina,
      @w_moneda      = op_moneda,
      @w_fpago       = op_fpago,
      @w_tplazo         = op_tipo_plazo,
      @w_residuo     = isnull(op_residuo,0),
      @w_monto_blq      = op_monto_blq,
      @w_monto_pg_int   = op_monto_pg_int,
      @w_tproducto      = op_producto,
      @w_estado         = op_estado,
      @w_dia_pago    = op_dia_pago, 
      @w_op_dias_reales = op_dias_reales,
      @w_fecha_ult_final  = op_ult_fecha_calculo
from pf_operacion 
where op_num_banco    = @i_num_banco    
  and op_estado in ('ACT','VEN') --I.CVA May-11-07 Agregar para los vencidos
if @@rowcount = 0  
begin
   select @w_error = 141051

   if @i_en_linea  = 'S'
   begin
  
      exec cobis..sp_cerror 
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = @w_error

      return @w_error
   end
   else
      return @w_error
end

set rowcount 0

if @w_usadeci = 'S'
begin
   ----------------------------------------------
   -- Obtener parametro de decimales para montos
   ----------------------------------------------
   select @w_numdeci = isnull(pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and pa_producto = 'PFI'
   
   if @@rowcount = 0
      select @w_numdeci = 0
end
else
   select @w_numdeci = 0

select @w_dias_interes = @i_dias_interes		--*-* 

select @t_debug = 'N' 

if @t_debug = 'S' print 'caldint @w_op_dias_reales  ' + cast(@w_op_dias_reales as varchar) + '@i_dias_interes  ' + cast(@i_dias_interes as varchar) 
if @t_debug = 'S' print 'caldint @w_fecha_hoy  ' + cast(@w_fecha_hoy as varchar) + '@w_fecha_siguiente  ' + cast(@w_fecha_siguiente as varchar) + '@w_dias_interes  ' + cast(@w_dias_interes as varchar)


/************************************************************************/
/**         AJUSTE DE VARIABLES E INICIALIZACION DE VARIABLES          **/
/************************************************************************/

if @w_fpago='ANT'
   select @w_producto='AMO'
else
   select @w_producto='PRO'

select @w_money         = @w_monto_pg_int - @w_monto_blq,
       @w_intereses     = 0,
       @w_intereses_ret = 0,
       @w_intereses_dia = 0,
       @w_interes_n_dia = 0,
       @w_valor_retenido= 0,
       @w_rt_secuencial = 0

/************************************************************************/
/**                      CALCULO DE INTERESES                          **/
/************************************************************************/
select   @w_intereses_dia = 0,
   @w_interes_n_dia = 0

select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

 
exec sp_calc_intereses 
   @monto     = @w_money,
   @dias_anio = @w_dias_anio,
   @tasa      = @w_tasa,
   @num_dias  = 1,
   @intereses = @w_interes_1_dia out

if @t_debug = 'S' print 'caldint @w_money  ' + cast(@w_money as varchar) + '@w_dias_anio  ' + cast(@w_dias_anio as varchar) + '@w_tasa  ' + cast(@w_tasa as varchar) 
if @t_debug = 'S' print 'caldint @w_fecha1  ' + cast(@w_fecha1 as varchar) + '@w_fecha_hoy  ' + cast(@w_fecha_hoy as varchar) + '@w_interes_1_dia  ' + cast(@w_interes_1_dia as varchar) 
if @t_debug = 'S' print 'caldint @w_numdeci  ' + cast(@w_numdeci as varchar)

select   @w_fecha1 = @w_fecha_hoy,
   @w_interes = round(@w_interes_1_dia,@w_numdeci)


select @w_interes_aux 		= @w_interes 
select @w_interes_1_dia_aux 	= @w_interes_1_dia


if @t_debug = 'S' print 'caldint @w_interes  ' + cast(@w_interes as varchar) + '@@w_contador  ' + cast(@w_contador as varchar) 

while @w_dias_interes > @w_contador    --*_* NUMERO DE DIAS SE CALCULA DE LA MISMA MANERA QUE LA PROVISION  -- GAL 14/SEP/2009 - RVVUNICA
begin
------------------------------------------------------------------------------------------------------------------------------------

if @t_debug = 'S' print 'CICLO caldint @w_dias_interes  ' + cast(@w_dias_interes as varchar) + '@@w_contador  ' + cast(@w_contador as varchar) 



   if @w_op_dias_reales = 'N'
   begin
	select @w_dias_int_fcom = 1
	--*-* SI ES UN 31 NO DEBE CALCULAR
	if datepart(dd,@w_fecha1) = 31            --*-*
	select @w_dias_int_fcom = 0
	
	--*-* SI ES ULTIMO DÍA DE FEBRERO CALCULA LOS DIAS QUE LE FALTAN PARA CUMPLIR 30 DIAS
	select @w_ult_dia_mes_pago = datepart(dd,dateadd(dd,datepart(dd,dateadd(mm,1,@w_fecha1))*(-1),dateadd(mm,1,@w_fecha1)))
	
	if datepart(mm,@w_fecha1) = 2 and datepart(dd,@w_fecha1) = @w_ult_dia_mes_pago
	select @w_dias_int_fcom = 30 - @w_ult_dia_mes_pago  + 1
	
	--*-* SI ES MARZO 1 DEBE PROVISIONAR SOLO UN DIA
	if datepart(mm,@w_fecha1) = 3 and datepart(dd,@w_fecha1) = 1
	select @w_dias_int_fcom = 1

	select @w_interes = @w_interes_aux * @w_dias_int_fcom
	select @w_interes_1_dia = @w_interes_1_dia_aux * @w_dias_int_fcom

	if datepart(dd,@w_fecha1) = 31            --*-*
	select @w_dias_int_fcom = 1
	
   end
------------------------------------------------------------------------------------------------------------------------------------
   
   select @w_intereses_dia = @w_intereses_dia + @w_interes  --interes a dos decimales
   select @w_interes_n_dia = @w_interes_n_dia + @w_interes_1_dia  --interes oon todos los decimales
   
   --+-+ Ajuste de provision para residuos
   select @w_resto = @w_interes_n_dia - @w_intereses_dia
   
   if abs(round(@w_resto,@w_numdeci)) >= 1/power(10, @w_numdeci)
   begin
      select   
         @w_intereses_dia = @w_intereses_dia + round(@w_resto,@w_numdeci),
         @w_interes       = @w_interes + round(@w_resto,@w_numdeci)
   end

if @t_debug = 'S' print 'caldint @w_interes  ' + cast(@w_interes as varchar) + '@@w_interes_1_dia  ' + cast(@w_interes_1_dia as varchar)
   
   
   
   --*_*Inserta registro de provision diaria en pf_prov_dia
   insert into pf_prov_dia
   values (@w_fecha1, @w_operacionpf, @w_oficina, @w_toperacion, @w_money, @w_tasa, @w_dias_anio, @w_interes, @w_interes_1_dia)

   select @w_fecha_ult_final = @w_fecha1
   
   
   if @w_op_dias_reales = 'S'
   begin
      select @w_contador = @w_contador + 1
      select @w_fecha1 = dateadd(dd,1,@w_fecha1)
      
   end
   else
   begin
      select @w_contador = @w_contador + @w_dias_int_fcom
      
      if @w_contador = @w_dias_interes
         select @w_ult_fecha_calculo = @w_fecha1
      else
         exec sp_funcion_1 @i_operacion = 'SUMDIA',   
              @i_fechai   = @w_fecha1,
              @i_dias     = 1,
              @i_dia_pago = @w_dia_pago, --*-*
              @i_batch = 0,
              @o_fecha    = @w_fecha1 out
   
   end    
      
end

/** ACTUALIZACION DE INTERESES GANADOS EN LA OPERACION **/
select @w_ult_fecha_calculo= @w_fecha_ult_final

if @i_tipo = 'R'  --reverso
   select @w_intereses_dia = -1 * @w_intereses_dia,
          @w_ult_fecha_calculo = '01/01/1900'

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda
   
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

select @w_intereses_dia = round(@w_intereses_dia, @w_numdeci)
select @w_provision = 0

if @w_intereses_dia > 0
   select @w_provision = @w_intereses_dia /@w_dias_interes


--   print 'caldint @w_provision  ' + cast(@w_provision as varchar) + '@@w_dias_interes  ' + cast(@w_dias_interes as varchar)
    
select @w_provision = round(@w_provision, @w_numdeci)         -- GAL 14/SEP/2009 - RVVUNICA - CONFIRMADO REDONDEO CON RICARDO ALVAREZ

if @i_ejecuta_contable = 'S'
begin
   update pf_operacion 
   set op_int_ganado          = isnull(op_int_ganado,0) + isnull(@w_intereses_dia,0),
       op_residuo          = @w_residuo,
       op_int_provision       = @w_provision,
       op_total_int_ganados   = op_total_int_ganados + @w_intereses_dia,
       op_fecha_mod           = @s_date,
       op_ult_fecha_calculo   = @w_ult_fecha_calculo
   where op_num_banco  = @i_num_banco  
   if @@error <> 0
   begin
      select @w_error = 145001
   
      if @i_en_linea  = 'S'
      begin
         exec cobis..sp_cerror 
                  @t_debug     = @t_debug,
                  @t_file      = @t_file,
                  @t_from      = @w_sp_name,
                  @i_num       = @w_error

         return @w_error
      end
      else
         return @w_error
   end
end

select @w_tot_intereses = abs(@w_intereses_dia)

select @w_fecha = convert(datetime,convert(varchar,@s_date,101))

if @i_tipo = 'N' and @i_ejecuta_contable = 'S'  -- NORMAL 
begin 
   if @w_producto = 'AMO' 
      select @w_descripcion = 'AMORTIZACION ('+@i_num_banco+')'
   else 
      select @w_descripcion = 'PROVISION ('+@i_num_banco+')'

   /*DGU comentado por prueba de migracion    */
   exec @w_return = cob_pfijo..sp_aplica_conta
      @s_ssn         = @s_ssn,
      @s_date        = @s_date,
      @s_user        = @s_user,
      @s_term        = @s_term,
      @s_ofi         = @s_ofi,
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @t_from,
      @t_trn            = 14937,
      @i_empresa        = 1,
      @i_fecha          = @w_fecha,
      @i_tran           = 14926,
      @i_producto       = @w_tproducto,   /* op_producto de pf_operacion */
      @i_oficina_oper   = @w_oficina,
      @i_oficina        = @w_oficina, 
      @i_toperacion     = @w_toperacion,/*op_toperacion de pf_operacion */
      @i_tplazo         = @w_tplazo, /* Nemonico del tipo de plazo */ 
      @i_operacionpf    = @w_operacionpf,
      @i_estado         = @w_estado ,
      @i_valor          = @w_tot_intereses, 
      @i_moneda         = @w_moneda, 
      @i_afectacion     = @i_tipo,  /* N=Normal,  R=Reverso  */
      @i_descripcion    = @w_descripcion,
      @i_codval         = '18',           /* Codigo de valor para el detalle */ --cambia el tipo de dato a varchar
      @i_movmonet       = '1',
      @i_debcred        = '1',           /* Si es debito = 1 o credito = 2 */ 
      @o_comprobante    = @o_comprobante out
   if @w_return <> 0
   begin

      if @i_en_linea  = 'S'
      begin
         exec cobis..sp_cerror 
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 143041
         rollback tran
         return 143041
      end
      else
         return 143041
   end

   insert into  pf_relacion_comp 
   values (@i_num_banco, @o_comprobante, 14926, 'PRVAMR', 'N', null, 0, @s_date)


end

return 0
/******************************************************************/
go
