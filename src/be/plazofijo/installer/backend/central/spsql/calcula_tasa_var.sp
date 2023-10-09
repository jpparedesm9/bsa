/************************************************************************/
/*      Archivo:                caltasav.sp                             */
/*      Stored procedure:       sp_calcula_tasa_var                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 05-Jun-2002                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script consulta la ultima tasa variable que se encuentra   */
/*      en la tabla pizarra de tesoreria. Fue creado en cob_tesoreria   */
/*      y se copio para utilizarlo en plazo fijo sin que los cambios    */
/*      que realice tesoreria afecten la consulta de pfijo.             */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      05-Jun-2002  N. Silva           Emision inicial                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from   sysobjects where name = 'sp_calcula_tasa_var' and    type = 'P')
   drop proc sp_calcula_tasa_var
go

create proc sp_calcula_tasa_var(
@s_ssn                   int         = null,
@s_user                  login       = null,
@s_sesn                  int = null,
@s_term                  varchar(30) = null,
@s_date                  datetime    = null,
@s_srv                   varchar(30) = null,
@s_lsrv                  varchar(30) = null,
@s_ofi                   smallint    = null,
@s_rol                   smallint    = NULL,
@t_trn                   smallint,
@t_debug                 char(1)     = 'N',
@t_file                  varchar(14) = null,
@t_from                  varchar(32) = null,
@i_vr_tasa_var           float,                     -- valor de la tasa a convertir
@i_periodo_tasa          smallint,                  -- cobis..te_pizarra..pi_periodo
@i_modalidad_tasa        char(3)        = null,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica
@i_descr_tasa            descripcion    = NULL,
@i_mnemonico_tasa        catalogo       = null,     -- DTF, TCC, IPC, PRIME
@i_operador              char(1)        = '+',      -- Operador de spread
@i_spread                float,                     -- Puntos de desplazamiento de la tasa
@i_base_calculo          smallint       = 360,      -- Base de calculo
@i_modalidad_prod        char(3),                   -- Forma de pago del producto PER, PRA
@i_per_pago              int,                       -- frecuencia o periodo de pago en meses  ej: si se le va a pagar mensualmente1 (por lo de 1M)
@i_en_linea              char(1)        = 'N',      -- Proceso en linea
@i_moneda                tinyint,                   -- moneda de la operacion
@i_monto                 money          = NULL,     -- GAR 25-feb-2005 DP00004 Control limites
@i_plazo                 int            = NULL,     -- GAR 25-feb-2005 DP00004 Control limites
@i_toperacion            catalogo       = NULL,     -- GAR 25-feb-2005 DP00004 Control limites -- E.Ochoa 26/02/2015 Inc 866 CC 455 CDT Tasa IBR Variable 
@i_inicio_periodo        char(1)        = 'N',
@i_fecha_valor           datetime       = null,     -- CVA Jun-13-06 Controlar plazos por periodos
@i_modifica              char(1)        = 'N',
@i_op_operacion          int            = null,
@o_tasa_EA               float          = NULL out,
@o_tasa_nom_reexp        float          = NULL out)
with encryption
as
/* Declaracion de variables de uso interno */
declare   @w_return                int,
@w_sp_name               varchar(30),
@w_num_per_anio          float,
@w_nom_tasa              char(5),
@w_tasa_tmp              float,
@w_tasa_EA               float,
@w_tasa_EA_aux		 float,
@w_tasa_nom_reexp        float,
@w_temp                  float,
@w_temp1                 float,
@w_temp2                 float,
@w_numdeci               tinyint,
@w_usadeci               char(1),
@w_modalidad_prod        char(1),
@w_vr_tasa_var           float,
@w_error                 int,
@w_tasa_min              float,    -- GAR 25-feb-2005 DP00004
@w_tasa_max              float,    -- GAR 25-feb-2005 DP00004
@w_tipo_monto            catalogo, -- GAR 25-feb-2005 DP00004
@w_tipo_plazo            catalogo, -- GAR 25-feb-2005 DP00004
@w_td_tipo_deposito      smallint,
@w_dif_dias              int,
@w_per_pago              int,
@w_codigo_ppago          varchar(10),
@w_plazo		 int


/* Asignacion del nombre del SP a variable */
select @w_sp_name = 'sp_calcula_tasa_var'
--select @t_debug = 'S'
select @w_per_pago = isnull(@i_per_pago,0)
select @w_plazo = @i_plazo
/*---------------------------------------------------*/
/*  VERIFICAR CODIGO DE TRANSACCION PARA EL CALCULO  */
/*---------------------------------------------------*/
if (@t_trn <> 14948 )
begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
      return 1
end




------------------------------------------------
-- Nueva validacion de limites para tasa DP0004
------------------------------------------------
/* Encuentra clave numerica de tipo de deposito */
select @w_td_tipo_deposito = td_tipo_deposito
from   cob_pfijo..pf_tipo_deposito
where  td_mnemonico = @i_toperacion

-------------------------------------------------------------
-- Para el caso de apertura o renovacion, el plazo deber ser
-- uno para calcular siempre el primer periodo
-------------------------------------------------------------
if @i_inicio_periodo = 'S'
   select @i_plazo = 1

--I. CVA Jun-13-06
if @i_fecha_valor is not null
begin
   select @i_plazo = datediff(dd,@i_fecha_valor,@s_date)
   if @i_plazo = 0
      select @i_plazo = 1
end
--F. CVA Jun-13-06


/* Busqueda de limites en monto de la operacion */
select @w_tipo_monto = mo_mnemonico
from   pf_monto, pf_auxiliar_tip
where  @i_monto          >= mo_monto_min
and    @i_monto          <= mo_monto_max
and    mo_mnemonico      = at_valor
and    at_tipo           = 'MOT'
and    at_tipo_deposito  = @w_td_tipo_deposito
and    at_moneda         = @i_moneda
and    at_estado         = 'A'

/* Busqueda de limites en plazo de la operacion */
select @w_tipo_plazo = pl_mnemonico
from   pf_plazo, pf_auxiliar_tip
where  @i_plazo         >= pl_plazo_min
and    @i_plazo         <= pl_plazo_max
and    pl_mnemonico      = at_valor
and    at_tipo           = 'PLA'
and    at_tipo_deposito  = @w_td_tipo_deposito
and    at_moneda         = @i_moneda
and    at_estado         = 'A'

--2 '@w_tipo_monto %1!, @w_tipo_plazo %2!, @i_mnemonico_tasa %3!, @i_toperacion%4!', @w_tipo_monto,@w_tipo_plazo,@i_mnemonico_tasa,@i_toperacion
/* Encontrar los limites de la tasa */
select  @w_tasa_min = tv_tasa_min,
@w_tasa_max = tv_tasa_max
from   pf_tasa_variable
where  tv_tipo_monto        = @w_tipo_monto
and    tv_tipo_plazo        = @w_tipo_plazo
and    tv_mnemonico_tasa    = @i_mnemonico_tasa
and    tv_mnemonico_prod    = @i_toperacion


-------------------------------
-- Conversion de la tasa
-- inicializacion de variables
-------------------------------
select @w_num_per_anio   = 0,
@w_nom_tasa       = null,
@w_tasa_tmp       = 0,
@w_tasa_EA        = 0,
@w_tasa_nom_reexp = 0,
@w_temp           = 0,
@w_temp1          = 0,
@w_temp2          = 0



--------------------------------------------------------------------------
-- Frecuencia o periodo de pago para reexpresar la tasa en el periodo en
-- que se va a pagar, es decir numero de periodos al anio
-- ej: si se le va a pagar mensualmente, se lee 1M por lo que seria 12
--------------------------------------------------------------------------
if @i_per_pago = 0
   select @i_per_pago = 1

if @i_modalidad_prod = 'VEN'
   select @i_per_pago = 1

select @w_temp = (12 / @i_per_pago)
select @i_per_pago = @w_temp
select @w_temp = 0

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
from   cobis..cl_moneda
where  mo_moneda = @i_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from   cobis..cl_parametro
   where  pa_nemonico = 'DCI'
   and    pa_producto = 'PFI'
end
else
   select @w_numdeci = 0



----------------------------------
-- numero de periodos al anio (n)
----------------------------------
select @w_num_per_anio = @i_base_calculo / (@i_periodo_tasa * 30)

--------------------------------------------------------------------------
-- Frecuencia o periodo de pago para reexpresar la tasa en el periodo en
-- que se va a pagar, es decir numero de periodos al anio
-- ej: si se le va a pagar mensualmente, se lee 1M por lo que seria 12
--------------------------------------------------------------------------
select @w_temp = (12 / @i_per_pago)

select @i_per_pago = @w_temp
select @w_temp = 0

----------------------------------
-- numero de periodos al anio (n)
----------------------------------
if @i_modalidad_prod = 'VEN'
   select @w_num_per_anio = 12
else
   select @w_num_per_anio = @i_per_pago --@i_base_calculo / (@i_periodo_tasa * 30)


-- Analisis de modalidad para calculo de nominal reexpresada
if @i_modalidad_prod = 'PRA'
   select @w_modalidad_prod = 'A'
else
   select @w_modalidad_prod = 'V'


------------------------------------
-- Sumar spread al valor de la tasa
------------------------------------
--print '@i_operador '+ cast(  @i_operador   as varchar) +', @i_vr_tasa_var '+ cast(@i_vr_tasa_var as varchar)+', @i_spread ' + cast(  @i_spread as varchar)

if @i_operador = '+'
   select @w_vr_tasa_var = @i_vr_tasa_var + @i_spread
if @i_operador = '-'
   select @w_vr_tasa_var = @i_vr_tasa_var - @i_spread


--print ' @w_tasa_min '+ cast( @w_tasa_min as varchar)+', @w_tasa_max ' + cast(  @w_tasa_max as varchar)

--------------------------------------------------------
-- Evaluacion de limites para la tasa variable (GLOBAL)
--------------------------------------------------------
if @w_tasa_min > @w_vr_tasa_var
   select @w_vr_tasa_var = @w_tasa_min

if @w_tasa_max < @w_vr_tasa_var
   select @w_vr_tasa_var = @w_tasa_max

-------------------------------------------------------------------
-- No se Realiza el calculo si se trata de una tasa Efectiva Anual
-------------------------------------------------------------------
select @w_tasa_EA = @w_vr_tasa_var
select @w_tasa_nom_reexp = @w_vr_tasa_var

-----------------------------------------------------
-- Calculos para tasa efectiva y nominal reexpresada
-----------------------------------------------------

--if @t_debug = 'S' print '*** @w_vr_tasa_var ' + cast( @w_vr_tasa_var as varchar)


   exec @w_return = sp_convierte_antven_efectiva
   @i_tasa                        = @w_vr_tasa_var,
   @i_modalidad                   = @i_modalidad_tasa,
   @i_periodo                     = @i_periodo_tasa, 
   @o_tasa_efectiva               = @w_tasa_EA out
   if @w_return <> 0
   begin
      select @w_error = @w_return
      goto ERROR
   end
   
--if @t_debug = 'S' print '*** @w_tasa_EA ' + cast( @w_tasa_EA as varchar)

/*
--------------------------------------------------------------
-- Convertir tasa Efectiva a la modalidad del producto de DPF
------------------------------ --------------------------------
exec @w_return = sp_convierte_efectiva_antven
@i_tasa_efectiva               = @w_tasa_EA,
@i_modalidad                   = @w_modalidad_prod,
@i_periodo                     = @w_num_per_anio, --@i_per_pago,
@o_tasa_convrndt               = @w_tasa_nom_reexp out
if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR
end


--print 'DOS @w_tasa_nom_reexp:%1!' + cast(@w_tasa_nom_reexp     as varchar)

*/
if @w_per_pago = 0
   select @w_codigo_ppago = 'NNN'
else
   select 	@w_codigo_ppago = pp_codigo 
   from 	pf_ppago
   where	pp_factor_en_meses = @w_per_pago 

--if @t_debug = 'S' print '*** @w_tasa_EA ' + cast( @w_tasa_EA as varchar)
--if @t_debug = 'S' print '*** @w_per_pago ' + cast( @w_per_pago as varchar)
--if @t_debug = 'S' print '@w_codigo_ppago ' + cast( @w_codigo_ppago as varchar)
--if @t_debug = 'S' print '@i_modalidad_prod ' + cast( @i_modalidad_prod as varchar)
--if @t_debug = 'S' print '@i_base_calculo ' + cast( @i_base_calculo as varchar)
--if @t_debug = 'S' print '@w_plazo ' + cast( @w_plazo as varchar)

select @w_tasa_EA_aux = @w_tasa_EA
exec @w_return = sp_tasa_nominal
@i_tasa_efectiva                = @w_tasa_EA_aux,
@i_op_ppago			= @w_codigo_ppago,
@i_op_fpago			= @i_modalidad_prod,
@i_td_base_calculo		= @i_base_calculo,
@i_op_num_dias			= @w_plazo,
@i_aper				= 'S',
@o_tasa_nominal			= @w_tasa_nom_reexp out
if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR
end

set rowcount 0

-----------------------------------
-- Devuelve valores al sp_paga_int
-----------------------------------
/* --*-*
if @i_en_linea = 'N'
begin
   select @o_tasa_EA = round(@w_tasa_EA,6),
   @o_tasa_nom_reexp = round(@w_tasa_nom_reexp,6)
end
else
   select round(@w_tasa_EA, 6),round(@w_tasa_nom_reexp , 6)

*/ --*-*


if @t_debug = 'S' print '***@w_tasa_EA ' + cast( @w_tasa_EA as varchar)
if @t_debug = 'S' print '@w_tasa_nom_reexp ' + cast( @w_tasa_nom_reexp as varchar)


if @i_en_linea = 'N'
begin
   select @o_tasa_nom_reexp    = round(@w_tasa_nom_reexp,6),
   @o_tasa_EA     = round(@w_tasa_EA,6)
end
else /* Devuelve valores para el front_end */
   select round(@w_tasa_nom_reexp , 6), round(@w_tasa_EA, 6)

return 0


-------------------
-- Manejo de Error
-------------------
ERROR:

   exec sp_errorlog @i_fecha   = @s_date,
   @i_error   = @w_error,
   @i_usuario = @s_user,
   @i_tran    = @t_trn,
   @i_cuenta  = ' '
   return @w_error
go

