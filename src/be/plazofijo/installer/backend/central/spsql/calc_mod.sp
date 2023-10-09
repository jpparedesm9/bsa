/************************************************************************/
/*      Archivo:                calc_mod.sp                             */
/*      Stored procedure:       sp_calcula_mod                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ricardo Alvarez                         */
/*      Fecha de documentacion: 11/15/2005                              */
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
/*      Calcula los valores de interes y fechas de pago cuando existen  */
/*      cambios en las condiciones pactadas previamente, ya sea con     */
/*      fecha valor o no.                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR              RAZON                        */
/*      11/15/2005      R. Alvarez    Emision Incial (GLobalBank)       */
/*      03/16/2007      R. Ramos      Permitir mod. en su dia de vencim */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_calcula_mod') is not null
   drop proc sp_calcula_mod
go

create proc sp_calcula_mod (
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_sesn                 int         = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint    = NULL,
 --*-*Nuevas condiciones del Certificado
@i_toperacion           catalogo    = NULL,
@i_categoria            catalogo    = NULL, 
@i_oficina              smallint    = NULL,  -- GAL 31/AGO/2009 - RVVUNICA
@i_num_dias             smallint    = NULL, --Nuevo plazo
@i_fecha_ven            datetime    = null, --Nueva Fecha de Vencimiento  
@i_monto                decimal(30,16)      = NULL, --- NYMVU% --Monto aplicado el incremento o decremento
@i_ppago                catalogo    = NULL, --Nuevo periodo de pago 
@i_fpago                catalogo    = NULL, --Nueva forma de pago
@i_dia_pago             tinyint     = NULL, --Dia de pago modificado
@i_tcapitalizacion      char(1)     = null, --Condicion de capitalizacion
@i_base_calculo         catalogo    = null, --Nueva Base de Calculo 
@i_fecha_valor          datetime    = null, --Nueva Fecha Valor de la operacion
@i_dias_reales          char(1)     = null, --Manejo de fechas comerciales o calendario     
@i_fecha_valor_cambio   datetime    = NULL, --Fecha valor de aplicacion del cambio de condiciones(INC/DEC/TASA)
@i_tasa                 float       = NULL, --Nueva tasa
@i_retienimp            char(1)     = 'N',  --No aplica para Panama pero se lo deja por defecto 
@i_num_banco            cuenta      = NULL,
@i_formato_fecha        int         = 0,   
@i_man_inc              char(1)     = null, --VAr para determinar si es llamado por Mantenimiento o INCDEC  
@i_tipo_monto           catalogo    = null,    
@i_tipo_plazo           catalogo    = null,     
@i_moneda               tinyint     = null,
--I. CVA Jun-27-06 Parametros para escalonado
@i_periodo_tasa         smallint    = NULL,       -- cobis..te_pizarra..pi_periodo
@i_modalidad_tasa       char(1)     = NULL,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
@i_descr_tasa           descripcion = NULL,
@i_mnemonico_tasa       catalogo    = NULL,     -- DTF, TCC, IPC, PRIME, ESC
@i_en_linea             char(1)     = NULL,
@i_modifica             char(1)     = 'N', --Solo para escalonados viene en S
--F. CVA Jun-27-06 Parametros para escalonado
@o_fecha_pg_int         datetime    = null out,
@o_int_ganado           money     = null out,
@o_int_estimado         money     = null out,
@o_total_int_estimado   decimal(30,16)      = null out, --- NYMVU%
@o_total_int_ganado     money     = null out,
@o_num_pagos            smallint    = null out  
)
with encryption
as
declare @w_sp_name        varchar(32),
  @w_return               int,
  @w_numdeci              tinyint,
  @w_usadeci              char(1),  
  @w_monto_e              money,
  @w_afec                 varchar(6),
  @w_fecha_incdis         datetime,   
  @w_num_banco            cuenta,
  @w_operacion_pf         int,
  @w_int_pagado_fe        money, --CVA May-08-06
  @w_int_ganado_i         decimal(30,16), --- NYMVU%
  @w_int_ganado1          money,  
  @w_int_ganado2          money,
  @w_int_ganado3          money,
  @w_int_ganado4          money, --CVA May-08-06
  @w_int_ganado           money,         
  @w_int_estimado         decimal(30,16),        --- NYMVU%
  @w_int_estimado_i       money,
  @w_fecha_ult_pg_int_i   datetime,
  @w_fecha_ven_i          datetime,
  @w_fecha_ven            datetime, 
  @w_fecha_pg_int_i       datetime, 
  @w_fecha_pg_int         datetime,
  @w_fecha_pago_fe        datetime,
  @w_dia_pago             tinyint,
  @w_dia_pago_ven         tinyint,
  @w_dia_pago_i           tinyint,
  @w_tot_int_pag_i        money,
  @w_acumulado_int_prov   money, --CVA May-08-06
  @w_toperacion           varchar(5),
  @w_toperacion_i         varchar(5),
  @w_tipo_plazo           varchar(5),
  @w_tipo_monto           varchar(5),
  @w_tipo_deposito        tinyint,
  @w_tipo_deposito_i      tinyint,
  @w_categoria            catalogo,
  @w_categoria_i          catalogo,
  @w_oficina_i            smallint,
  @w_base_calculo         smallint,
  @w_base_calculo_i       smallint,
  @w_monto_i              money,
  @w_capitalizacion       char(1),
  @w_capitalizacion_i     char(1),
  @w_num_dias             smallint,
  @w_num_dias_i           smallint, 
  @w_fpago                char(3),
  @w_ppago_i              char(3),
  @w_fpago_i              char(3),
  @w_fecha_valor          datetime,
  @w_fecha_valor_i        datetime,
  @w_dias_reales          char(1),
  @w_dias_reales_i        char(1),
  @w_fecha_ingreso        datetime,
  @w_fecha_ingreso_i      datetime,
  @w_tasa                 float,
  @w_tasa_i               float,
  @w_fecha_ini_per        datetime,
  @w_ult_fecha_cam_tasa   datetime,
  @w_ult_fecha_cam_monto  datetime,
  @w_fecha_ult_afec       datetime,
  @w_fecha_cambio_dia     datetime,
  @w_dias_res_per         int,
  @w_dias_res1            int,
  @w_dias_res2            int,
  @w_dias_res3            int,
  @w_factor_dias          int,
  @w_num_meses            int,
  @w_op_accion_sgte       catalogo,
  @w_op_bloqueo_legal     char(1),
  @w_fecha_cierre_fiscal  datetime,
  @w_incremento           money,
  @w_monto_pgdo           money,
  @w_monto_blq            money,
  @w_op_monto_blq_legal   money,
  @w_interes_n_dia        decimal(30,16), 
  @w_resto                decimal(30,16), 
  @w_interes              money,    
  @w_interes_1_dia        decimal(30,16), 
  @w_ult_dia_mes_pago     tinyint,  
  @w_total_int_estimado   decimal(30,16), --- NYMVU%
  @w_dias                 int,
  @w_dias_provisionados   int,          --+-+
  @w_dias_calc            int,          --+-+
  @w_fecha_pivote         datetime, --+-+
  @w_total_int_estimado_i money,          --+-+
  @w_fecha_migracion      datetime,
  @w_op_estado            catalogo,
  --Variables para escalonado
  @w_tasa_esc             float,
  @w_fecha_camb_tasa      datetime,
  @w_plazo_max            int,
  @w_plazo_min            int,
  @w_dias_res4            int,
  @w_dias_res5            int,
  @w_int_ganado5          money,
  @w_cambio_fecha_valor   char(1),
  @w_fecha_valor_cambio   datetime, /* CVA Mar-24-07 */
  @w_msg                  varchar(120)

   
select  @w_sp_name  = 'sp_calcula_mod',
  @w_incremento = 0,
  @w_dias_calc  = 0


create table #monto
(monto            money          null,
 fecha            datetime       null)

create table #tasa
(tasa             float          null,
 fecha            datetime       null)

create table  #prov
(fecha_proceso    datetime       null,
 operacion        int            null,
 oficina          smallint       null,
 toperacion       varchar(10)    null,
 monto            money          null,
 tasa             float          null,
 base_cal         smallint       null,
 valor            money          null,
 valor_calc       decimal(30,16) null)

CREATE CLUSTERED INDEX tmp_prov_fkey ON #prov (
        fecha_proceso,
        operacion) 


if @s_date is null
   select @s_date = fp_fecha from cobis..ba_fecha_proceso

select @w_cambio_fecha_valor = 'N'

--Obtiene parametro de fecha de migracion--
select @w_fecha_migracion = isnull(pa_datetime,@s_date)
from cobis..cl_parametro 
where pa_producto = 'PFI'
  and pa_nemonico = 'FMI'

------------------------------------
-- Encuentra parametro de decimales 
------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @i_moneda

if @w_usadeci = 'S'
begin
     select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
     where pa_nemonico = 'DCI'
       and pa_producto = 'PFI'
end
else
     select @w_numdeci = 0 


---Obtener condiciones actuales de la operacion---
select  @w_operacion_pf   = op_operacion,
  @w_num_banco    = op_num_banco,
  @w_int_ganado_i   = op_int_ganado,
  @w_int_pagado_fe        = isnull(op_int_pagados,0), --CVA May-08-06
  @w_int_estimado_i   = op_int_estimado,
  @w_total_int_estimado_i = op_total_int_estimado,
  @w_fecha_ult_pg_int_i = op_fecha_ult_pg_int,  
  @w_fecha_pg_int_i = op_fecha_pg_int,
  @w_fecha_pago_fe  = isnull(op_fecha_ult_pago_int_ant,'01/01/1900'),
  @w_dia_pago_i   = op_dia_pago,
  @w_toperacion_i   = op_toperacion,
  @w_capitalizacion_i = op_tcapitalizacion,
  @w_oficina_i    = op_oficina,
  @w_num_dias_i   = op_num_dias,
  @w_monto_i    = op_monto,
  @w_fpago_i    = op_fpago,
  @w_ppago_i    = op_ppago,
  @w_base_calculo_i = op_base_calculo,
  @w_fecha_valor_i  = op_fecha_valor,
  @w_dias_reales_i  = op_dias_reales,
  @w_fecha_ingreso_i  = op_fecha_ingreso,
  @w_fecha_ven_i    = op_fecha_ven,
  @w_tot_int_pag_i  = isnull(op_total_int_pagados,0),
  @w_tasa_i   = op_tasa,
  @w_op_accion_sgte = op_accion_sgte,
  @w_op_bloqueo_legal = op_bloqueo_legal,
     @w_monto_pgdo          = isnull(op_monto_pgdo,0),
     @w_monto_blq            = isnull(op_monto_blq,0),
     @w_op_monto_blq_legal   = isnull(op_monto_blqlegal,0),
  @w_op_estado            = op_estado           
from pf_operacion
where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 141051
  return 141051
end 

--CVA Ago-04-06 Para los depositos en estado XACT la fecha inicial de calculo debe ser la fecha valor del dpf
if @w_op_estado = 'XACT'
   select @s_date = @w_fecha_valor_i


if exists (select 1
           from cob_pfijo..pf_cambio_oper
           where co_num_banco   = @i_num_banco 
             and co_fecha_valor > @i_fecha_valor_cambio
             and (co_fecha_valop      is not null      --asegura que exista un cambio real--
                  or co_base_calculo     is not null           
                  or co_tcapitalizacion  is not null           
                  or co_fecha_ven        is not null           
                  or co_tasa             is not null           
                  or co_fpago            is not null           
                  or co_ppago            is not null           
                  or co_dia_pago         is not null           
                  or co_num_dias         is not null           
                  or co_plazo_orig       is not null           
                  or co_dias_reales      is not null))
begin
     select @w_msg = '['+@w_sp_name+'] ' + 'Fecha Valor no puede ser menor que la ultima fecha de cambio'
     goto ERROR
end


--Obtener la maxima fecha de incrementos/disminuciones--
select @w_fecha_incdis = isnull(max(io_fecha_mod),'01/01/1900')
from pf_incre_op
where io_num_banco    = @i_num_banco
  and io_fecha_valor >= @w_fecha_valor_i --CVA Jul-13-06 para considerar solo las del plazo vigente no los anteriores
if @@rowcount > 0
begin
     if @i_fecha_valor_cambio < @w_fecha_incdis
     begin
        select @w_msg = '['+@w_sp_name+'] ' + 'Fecha de cambio no puede ser < fecha de ultimo incremento/disminucion'
        goto ERROR
    end
end

--------------------------------------------------------------------------
-- Controla si la operacion tiene instruccion de Renovacion o cancelacion
--------------------------------------------------------------------------
if @w_op_accion_sgte <> 'NULL'
begin
     select @w_msg = '['+@w_sp_name+'] ' + 'DPF tiene una instruccion a procesar, no se permite modificaciones'
     goto ERROR
end 

-------------------------------------------------------------------------
-- Controlar que el valor a reducir no sea mayor que el monto disponible
-------------------------------------------------------------------------
select @w_incremento = @i_monto - @w_monto_i
if @w_incremento < 0
begin
   if abs(@w_incremento) > (@w_monto_i - @w_monto_pgdo - @w_monto_blq - @w_op_monto_blq_legal)
   begin
         exec cobis..sp_cerror                
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 149066
         return 149066  
   end
end 

------------------------------------------------------------------------------------
-- Controla que la nueva fecha valor no sea mayor que la fecha original de apertura
------------------------------------------------------------------------------------
if  @w_fecha_valor_i < @i_fecha_valor
begin
   select @w_msg = '['+@w_sp_name+'] ' + 'La nueva fecha valor no puede ser mayor que la fecha valor original'
   goto ERROR
end

--------------------------------------------------------------
-- Mensaje de advertencia si la operacion tiene bloqueo legal
--------------------------------------------------------------
if @w_op_bloqueo_legal = 'S'
   print 'La operacion tiene Bloqueo legal...Favor Revisar.'

--Inicializa variables que por defecto estaban en null.
select  @i_toperacion       = isnull(@i_toperacion,@w_toperacion_i),
        @i_num_dias         = isnull(@i_num_dias,@w_num_dias_i),   --Nuevo plazo
        @i_monto            = isnull(@i_monto,@w_monto_i),     --Monto aplicado el incremento o decremento
        @i_ppago            = isnull(@i_ppago,@w_ppago_i),     --Nuevo periodo de pago 
        @i_fpago            = isnull(@i_fpago,@w_fpago_i),     --Nueva forma de pago
        @i_dia_pago         = isnull(@i_dia_pago,@w_dia_pago_i),   --Dia de pago modificado
        @i_tcapitalizacion  = isnull(@i_tcapitalizacion,@w_capitalizacion_i),
        @i_fecha_ven        = isnull(@i_fecha_ven,@w_fecha_ven_i),   --Nueva Fecha de Vencimiento
        @i_fecha_valor      = isnull(@i_fecha_valor,@w_fecha_valor_i),   --Nueva Fecha Valor de la operacion
        @i_dias_reales      = isnull(@i_dias_reales,@w_dias_reales_i),   --Manejo de fechas comerciales o calendario  
        @i_tasa             = isnull(@i_tasa,@w_tasa_i)            --Nueva tasa

select @w_fecha_ini_per = @w_fecha_ult_pg_int_i,
       @w_base_calculo = isnull(convert(int,substring (@i_base_calculo,1,3)),@w_base_calculo_i) 


--Aplica restriciones para cuando cambia la FECHA VALOR del certificado
--La fecha valor no puede cambiar si es que ya se ha realizado algun pago de interes.
--print 'TT @i_fecha_valor:%1!,@w_fecha_valor_i:%2!',@i_fecha_valor,@w_fecha_valor_i


if @i_fecha_valor <> @w_fecha_valor_i
begin

  if @w_fecha_ini_per > @w_fecha_valor_i or @w_fecha_pago_fe > @w_fecha_valor_i  --@w_fecha_ingreso_i 
  begin
            select @w_msg = '['+@w_sp_name+'] ' + 'No se puede modificar Fecha Valor porque ya se realizo un pago de interes'
            goto ERROR
  end
  
  select @w_fecha_ult_pg_int_i = @i_fecha_valor
  select @w_fecha_ini_per      = @i_fecha_valor
  select @w_cambio_fecha_valor = 'S'

end

select @w_int_ganado4 = 0  --May-08-06

--Busca fecha de ultimo pago de interes
if @w_fecha_pago_fe > @w_fecha_ult_pg_int_i
begin
  select @w_fecha_ini_per      = @w_fecha_pago_fe,
               @w_acumulado_int_prov = 0  

  --I. CVA May-08-06
  select @w_acumulado_int_prov = sum(isnull(pd_valor,0))
  from pf_prov_dia  
  where pd_operacion = @w_operacion_pf
          and pd_fecha_proceso between @w_fecha_ult_pg_int_i and dateadd(dd,-1,@w_fecha_pago_fe) --Fecha pago anticipado - dia provision noche 

  select @w_int_ganado4  = round(@w_acumulado_int_prov, @w_numdeci)    -- GAL 31/AGO/2009 - RVVUNICA
  
  --F. CVA May-08-06
end

--*-* Busca fecha de ultimo cambio de tasa o monto para tomar fecha tope de aplicacion de otros cambios de tasa o monto

insert into #monto
select distinct pd_monto, '01/01/1900'
from pf_prov_dia  
where pd_operacion      = @w_operacion_pf
  and pd_fecha_proceso >= @w_fecha_ini_per
  and pd_fecha_proceso  < @w_fecha_pg_int_i
  
insert into #tasa
select distinct pd_tasa,  '01/01/1900' 
from pf_prov_dia  
where pd_operacion      = @w_operacion_pf
  and pd_fecha_proceso >= @w_fecha_ini_per
  and pd_fecha_proceso  < @w_fecha_pg_int_i

update #monto 
set fecha = pd_fecha_proceso
from #monto,
     pf_prov_dia  
where pd_operacion      =  @w_operacion_pf
  and pd_fecha_proceso >= '01/01/1900'
  and pd_monto          = monto

update #tasa
set fecha = pd_fecha_proceso
from #tasa, 
     pf_prov_dia  
where pd_operacion  = @w_operacion_pf
  and pd_fecha_proceso >= '01/01/1900'
  and pd_tasa     = tasa

select @w_ult_fecha_cam_monto = isnull(max(fecha),'01/01/1900')
from #monto

select @w_ult_fecha_cam_tasa = isnull(max(fecha),'01/01/1900')
from #tasa

--Obtiene finalmente los valores de fechas de ultimos cambios de tasa o monto--
if @w_ult_fecha_cam_monto > @w_ult_fecha_cam_tasa
   select @w_fecha_ult_afec = @w_ult_fecha_cam_monto
else
   select @w_fecha_ult_afec = @w_ult_fecha_cam_tasa


if @w_ult_fecha_cam_monto = @w_ult_fecha_cam_tasa -- => no hubo cambios de tasa o monto
begin
  select @w_fecha_ult_afec = '01/01/1900'   -- => la fecha de ultima mod es nula

  --I.CVA Jul-13-06 Para cambios de fecha valor con dias provisiones
        select @w_ult_fecha_cam_monto = '01/01/1900'
        select @w_ult_fecha_cam_tasa  = '01/01/1900'
  --F.CVA Jul-13-06 Para cambios de fecha valor con dias provisiones
end

--Si la fecha de inicio de periodo es mayor que la fecha valor de ejecucion del cambio => ERROR!!!
--print '@w_fecha_ini_per:%1!,@i_fecha_valor_cambio:%2!',@w_fecha_ini_per,@i_fecha_valor_cambio
if datediff(dd,@w_fecha_ini_per,@i_fecha_valor_cambio) < 0
begin
     select @w_msg = '['+@w_sp_name+'] ' + 'La fecha valor del cambio no puede ser menor que la ultima fecha pago de intereses'
     goto ERROR
end

--Validar cambios de fecha valor
if @i_fecha_valor <> @w_fecha_valor_i
begin
  --Solo se puede cambiar fecha valor si el dpf no ha tenido incrementos/disminuciones
  if @i_fecha_valor < @w_ult_fecha_cam_monto 
  begin
             select @w_msg = '['+@w_sp_name+'] ' + 'No se puede modificar Fecha Valor porque se han realizado incrementos/disminuciones'
             goto ERROR
  end

  --Solo se puede cambiar fecha valor si el dpf no ha tenido incrementos/disminuciones
  if @i_fecha_valor < @w_ult_fecha_cam_tasa 
  begin
             select @w_msg = '['+@w_sp_name+'] ' + 'No se puede modificar Fecha Valor porque se han realizado cambio de tasas'
             goto ERROR
  end

end


if datediff(dd,@s_date,@i_fecha_valor_cambio) > 0
begin
      select @w_msg = '['+@w_sp_name+'] ' + 'La fecha del cambio no puede ser mayor que hoy'
      goto ERROR
end

if @i_ppago <> 'NNN'
begin
  select @w_num_meses   = pp_factor_en_meses,
         @w_factor_dias = pp_factor_dias
  from   pf_ppago
  where  ltrim(rtrim(pp_codigo)) = ltrim(rtrim(@i_ppago))
  
  select @w_dias = @w_num_meses * 30
end

--Obtiene nuevas fechas de pago de interes en caso de cambio de DIA DE PAGO o PERIODICIDAD--
if @i_fpago <> @w_fpago_i --Si cambia la forma de pago => analizar periodicidad
begin

  if @w_fpago_i = 'VEN' --Si tenia forma de pago al vencimiento => cambio a periodica
  begin     -- => se debe colocar un dia de pago y una fecha de proximo pago de interes
 
    --Como es un DPF al vencimiento  => la fecha de ultimo pago se la coloca = fecha ult provision + 1
    select  @w_fecha_ult_pg_int_i   = @s_date,
      @w_dia_pago_i     = datepart(dd,@s_date)    

    --Segun nuevo dia de pago coloca la nueva fecha de pago de interes en base a 
    --la cual se aplicara el periodo respectivo
    --select @w_fecha_cambio_dia  = dateadd(mm, @w_num_meses , @w_fecha_ini_per)      
    select @w_fecha_cambio_dia  = dateadd(dd, @w_factor_dias, @w_fecha_ini_per)     

    --Segun nuevo dia de pago coloca la nueva fecha de pago de interes en base a 
    --la cual se aplicara el periodo respectivo
    exec sp_dia_pago 
      @i_fecha               = @w_fecha_cambio_dia,
      @i_dia_pago            = @i_dia_pago,
      @o_fecha_proximo_pago  = @w_fecha_pg_int out

    select @w_fecha_cambio_dia = @w_fecha_pg_int 

    while @w_fecha_cambio_dia <= @s_date
                begin
      --select @w_fecha_cambio_dia  = dateadd(mm, @w_num_meses , @w_fecha_cambio_dia)     
      select @w_fecha_cambio_dia  = dateadd(dd, @w_factor_dias, @w_fecha_cambio_dia)      

      exec sp_dia_pago 
        @i_fecha               = @w_fecha_cambio_dia, 
        @i_dia_pago            = @i_dia_pago,
        @o_fecha_proximo_pago  = @w_fecha_pg_int out

      if @w_fecha_cambio_dia > @s_date
        break                                    
                end
  end
  else  -- Cambio de PER a VEN => ya no interesa el dia de pago, sino que se setean las fechas directamente
  begin
    select  @w_fecha_pg_int = @i_fecha_ven
  
  end
end
else  --Si no cambio la forma de pago => para el caso de que la forma de pago sea PER => revisar si cambio dia de pago
begin
  if @w_fpago_i = 'PER'
  begin
    --Segun nuevo dia de pago coloca la nueva fecha de pago de interes en base a 
    --la cual se aplicara el periodo respectivo                   

    if @w_ppago_i <> @i_ppago or @w_dia_pago_i <> @i_dia_pago
    begin
      --select @w_fecha_cambio_dia  = dateadd(mm, @w_num_meses , @w_fecha_ini_per)      
      select @w_fecha_cambio_dia  = dateadd(dd, @w_factor_dias, @w_fecha_ini_per)     

      exec sp_dia_pago 
        @i_fecha               = @w_fecha_cambio_dia, 
        @i_dia_pago            = @i_dia_pago,
        @o_fecha_proximo_pago  = @w_fecha_cambio_dia out

      select @w_fecha_pg_int = @w_fecha_cambio_dia

      while @w_fecha_cambio_dia <= @s_date
                        begin
        --select @w_fecha_cambio_dia  = dateadd(mm, @w_num_meses , @w_fecha_cambio_dia)     
        select @w_fecha_cambio_dia  = dateadd(dd, @w_factor_dias, @w_fecha_cambio_dia)      

        exec sp_dia_pago 
          @i_fecha               = @w_fecha_cambio_dia, 
          @i_dia_pago            = @i_dia_pago,
          @o_fecha_proximo_pago  = @w_fecha_cambio_dia out

        if @w_fecha_cambio_dia > @s_date
        begin
          select @w_fecha_pg_int = @w_fecha_cambio_dia
          break                                    
                                end
                        end
    end
    else
      select @w_fecha_pg_int  = @w_fecha_pg_int_i


    if @w_fecha_pg_int > @i_fecha_ven
      select @w_fecha_pg_int = @i_fecha_ven  --Esta fecha de prox pago deberia ser igual a la fecha de ven
  end
  else  -- La forma de pago es al vencimiento
    select @w_fecha_pg_int = @i_fecha_ven  --Esta fecha de prox pago deberia ser igual a la fecha de ven

end


--RAL 11-24-2008 Ajuste para considerar operaciones periodicas con pagos anticipados de interes
--Si existio un pago anticipado por frontend y es periodico se debe recalcular la fecha de proximo pago de interes
--Segun nuevo dia de pago coloca la nueva fecha de pago de interes en base a 
--la cual se aplicara el periodo respectivo

if (@w_fecha_pago_fe is not null) and (@w_fecha_pago_fe > @w_fecha_pg_int ) and (@i_fpago = @w_fpago_i) and (@i_fpago = 'PER')
begin
   exec sp_dia_pago 
  @i_fecha               = @w_fecha_pago_fe,
  @i_dia_pago            = @i_dia_pago,
  @o_fecha_proximo_pago  = @w_fecha_pg_int out
end 

--RAL 11-24-2008

--Validar que el cambio en fechas de vencimiento no afecte al cambio en forma de pago o periodicidad
if @i_fecha_ven < @w_fecha_pg_int
begin
      select @w_msg = '['+@w_sp_name+'] ' + 'La fecha ven no puede ser menor a la fecha de proximo pago de interes'
      goto ERROR
end

if @s_date > @w_fecha_pg_int
begin
      select @w_msg = '['+@w_sp_name+'] ' + 'La fecha de prox pago de interes no puede ser menor que hoy'
      goto ERROR
end

--Fecha valor de cambio no puede ser menor que la fecha valor del DPF
if @i_fecha_valor_cambio < @w_fecha_ult_afec
begin
      select @w_msg = '['+@w_sp_name+'] ' + 'Fecha de cambio no puede ser menor fecha de ultimo pago o modificacion de tasa o monto'
      goto ERROR
end


--Verificar si fecha valor esta dentro periodo fiscal 
select @w_fecha_cierre_fiscal = max(pe_fecha_fin)
from cob_conta..cb_periodo
where pe_estado = 'C'

if datediff(dd,@w_fecha_cierre_fiscal,@i_fecha_valor_cambio) <= 0
begin
  exec cobis..sp_cerror
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @i_num          = 141175
  return 141175
end


if datediff(mm, @i_fecha_valor_cambio, @i_fecha_ven) <= 6 and @i_man_inc = 'I' and @i_num_dias > 180
   print 'No debe Incrementar/Disminuir la operacion porque tiene seis meses para vencer'

--*-* OOJJO CONSIDERAR EL CASO DE QUE AL CONVERTIR UNA OPERACION DE VEN A PER SE VALIDE QUE AL DEFINIR LA FECHA DE 
--*-* VENCIMIENTO MAYOR A LA FECHA DE PROXIMO PAGO Y QUE ESA FECHA NO ALCANCE A SER UN PERIODO => SEA UN ULTIMO PERIODO
--*-* RESIDUO

select  @w_int_ganado1 = 0,
  @w_int_ganado2 = 0,
  @w_int_ganado3 = 0,
  @w_int_ganado5 = 0,
  @w_dias_res1   = 0,
  @w_dias_res2   = 0,
  @w_dias_res3   = 0,
  @w_dias_res4   = 0,
  @w_dias_res5   = 0,
  @w_dias_res_per = 0


--*-* Obtener valor de interes ganado hasta la fecha valor de aplicacion del cambio

--Saca una copia de los registros de provision del periodo vigente
insert into #prov
select * 
from pf_prov_dia   
where pd_operacion     = @w_operacion_pf
  and pd_fecha_proceso between @w_fecha_ini_per and @s_date

--Modifica la base de Calculo que se desea cambiar,sin rango de fechas porque debe afectar todo el periodo en curso
update #prov
set base_cal  = @w_base_calculo
where operacion = @w_operacion_pf

if @i_monto <> @w_monto_i  or  @i_tasa <> @w_tasa_i
begin
     update #prov
     set monto = @i_monto,
         tasa  = case when @i_tasa <> @w_tasa_i then @i_tasa
                  else tasa
                 end  
     where operacion = @w_operacion_pf
       and fecha_proceso between @i_fecha_valor_cambio and @s_date
end 

--Obtiene el numero de dias provisionados
select @w_dias_provisionados = count(1)
from pf_prov_dia  
where pd_operacion = @w_operacion_pf
  and pd_fecha_proceso between @w_fecha_ini_per and dateadd(dd,-1,@i_fecha_valor_cambio) 

--Coloca valor de interes con nuevas condiciones de Monto o Tasa
update #prov
set valor   = round((monto * tasa)/(base_cal * 100.00), @w_numdeci),  --Provision de 1 dia --Redondeo RRB/CLO -- GAL 31/AGO/2009 - RVVUNICA 
    valor_calc  = ((monto * tasa)/(base_cal * 100.00))    --I. CVA May-05-06 Provision de 1 dia
where operacion = @w_operacion_pf 
  and fecha_proceso between @i_fecha_valor_cambio and @s_date

--Si cambia la base de calculo y es el primer periodo de pago desde que se migro la operacion
--Entonces no se puede realizar la modificacion porque no se sabe si hubieron cambios de monto o tasa en ese periodo
--y no se tiene el detalle de esos cambios

if @w_base_calculo_i <> @w_base_calculo 
begin
  if datediff(dd,@w_fecha_ini_per,@i_fecha_valor_cambio) <> @w_dias_provisionados
  begin
              select @w_msg = '['+@w_sp_name+'] ' + 'No puede cambiar base de calculo, OP en primer periodo desde la migracion'
              goto ERROR
  end
  else begin
    --Actualiza la base de calculo de todo el plazo
    update #prov
    set valor = ((monto * tasa * 1)/(base_cal * 100)) --Provision de 1 dia
    where operacion = @w_operacion_pf
      and fecha_proceso between @w_fecha_ini_per and dateadd(dd,-1,@i_fecha_valor_cambio) 
  end 
end


select @w_int_ganado1 = isnull(sum(valor_calc),0)
from #prov
where operacion = @w_operacion_pf
  and fecha_proceso between @w_fecha_ini_per and dateadd(dd,-1,@i_fecha_valor_cambio)

-- SI el titulo es nuevo y no tiene nada de provision o si tiene algo de prov pero no desde
--    la ultima fecha de inicio de periodo
if @w_int_ganado1 = 0 
begin
        -------------------------------------------------------------------------------------------
        --CVA Mar-24-07 Si se realiza un cambio de fecha valor y ademas se hace un cambio de tasa
        --              fecha valor a la misma fecha valor del dpf entonces @w_int_gandado1 es cero
        -------------------------------------------------------------------------------------------
        select @w_fecha_valor_cambio = @i_fecha_valor_cambio

        if @w_cambio_fecha_valor = 'S'
        begin
          if datediff(dd,@w_fecha_ini_per,@i_fecha_valor_cambio) = 0
             select @w_fecha_valor_cambio = @w_fecha_valor_i
        end
        -- CVA Mar-24-07

  if @i_dias_reales = 'S'
    select @w_dias_res1 = datediff(dd,convert(datetime,@w_fecha_ini_per),convert(datetime,@w_fecha_valor_cambio)) 
  else
  begin
        exec sp_funcion_1 
                   @i_operacion = 'DIFE30',
         @i_fechai  = @w_fecha_ini_per,
       @i_fechaf  = @w_fecha_valor_cambio,
             @i_dia_pago  = @i_dia_pago,
             @o_dias      = @w_dias_res1 out
        end 
  
  select  @w_dias_res_per = @w_dias_res_per + @w_dias_res1

  select @w_int_ganado1 = (@i_monto * @i_tasa * @w_dias_res1 ) / (@w_base_calculo * 100.00) 
end
--I. CVA Jul-13-06 Cuando se cambia la fecha valor y ya se tiene dias de provision
else  
begin 
  if @w_cambio_fecha_valor = 'S'
  begin
       if datediff(dd,@w_fecha_ini_per,@i_fecha_valor_cambio) <> @w_dias_provisionados
       begin
    if @i_dias_reales = 'S'
       select @w_dias_res1 = datediff(dd,convert(datetime,@w_fecha_ini_per),convert(datetime,@w_fecha_valor_i)) 
    else
       exec sp_funcion_1  
                        @i_operacion  = 'DIFE30',
      @i_fechai = @w_fecha_ini_per,
      @i_fechaf = @w_fecha_valor_i,
      @i_dia_pago = @i_dia_pago,
      @o_dias   = @w_dias_res1 out

    select @w_int_ganado1 = @w_int_ganado1 + (@i_monto * @i_tasa * @w_dias_res1 ) / (@w_base_calculo * 100.00)  

      end
  end
end
--F. CVA Jul-13-06 Cuando se cambia la fecha valor y ya se tiene dias de provision


-- Verifica si la operacion es migrada y se esta tratando de hacer una modificacion durante el periodo en curso
-- de operacion calculada con dias reales a dias comerciales.
if @w_dias_reales_i <> @i_dias_reales
begin
     select @w_int_ganado1   = 0,
        @w_interes_n_dia = 0,
            @w_interes_1_dia = 0,
            @w_interes       = 0
      
     --Calcular provision correcta de acuerdo a los cambios solicitados
     -- de monto, base de calculo, etc.
     select @w_fecha_pivote = @w_fecha_ini_per

     while datediff(dd,@w_fecha_pivote,@i_fecha_valor_cambio) > 0 --AQUI CONSIDERAR PARA EL CASO DE FECHAS COMERCIALES
     begin
       --Evalua los dias a calcular interes
         select @w_dias_calc  = 1
         if @i_dias_reales = 'N'
       begin
    --*-*Si es un 31 no debe provisionar
    if datepart(dd,@w_fecha_pivote) = 31      --*-*
       select @w_dias_calc = 0
  
    --*-*Si es febrero provisiona los dias que le faltan para cumplir 30 dias
      select @w_ult_dia_mes_pago = datepart(dd,dateadd(dd,datepart(dd,dateadd(mm,1,@w_fecha_pivote))*(-1),dateadd(mm,1,@w_fecha_pivote)))
    
    if datepart(mm,@w_fecha_pivote) = 2 and datepart(dd,@w_fecha_pivote) = @w_ult_dia_mes_pago
       select @w_dias_calc = 30 - @w_ult_dia_mes_pago  + 1
    
    --*-*Si es marzo 1 debe provisionar solo un dia
    if datepart(mm,@w_fecha_pivote) = 3 and datepart(dd,@w_fecha_pivote) = 1
       select @w_dias_calc = 1  
      end

      select @w_interes_1_dia = (monto * tasa * @w_dias_calc)/(base_cal * 100.00)
      from #prov
          where fecha_proceso = @w_fecha_pivote
          and operacion     = @w_operacion_pf

      select @w_interes = round(@w_interes_1_dia, @w_numdeci)       -- GAL 31/AGO/2009 - RVVUNICA
      
        select @w_int_ganado1   = @w_int_ganado1   + @w_interes       --interes a dos decimales
      select @w_interes_n_dia = @w_interes_n_dia + @w_interes_1_dia --interes con todos los decimales
      
      --+-+ Ajuste de provision para residuos
      select @w_resto = @w_interes_n_dia - @w_int_ganado1
      
      if abs(round(@w_resto, @w_numdeci)) >= 1/power(10.0, @w_numdeci)    -- GAL 31/AGO/2009 - RVVUNICA
        begin
      select  
         @w_int_ganado1 = @w_int_ganado1 + round(@w_resto, @w_numdeci),    -- GAL 31/AGO/2009 - RVVUNICA
         @w_interes     = @w_interes     + round(@w_resto, @w_numdeci)     -- GAL 31/AGO/2009 - RVVUNICA
      end
      
      --Actualiza tabla temporal de provision
        update #prov
      set valor      = @w_interes,
                valor_calc = @w_interes_1_dia
      where fecha_proceso = @w_fecha_pivote
        and operacion     = @w_operacion_pf

      select @w_fecha_pivote  = dateadd(dd,1,@w_fecha_pivote),
         @w_interes_1_dia = 0,
           @w_interes       = 0
     end

     --Tomar el valor con la mayor cantidad de decimales para la sumatoria del int estimado
     select @w_int_ganado1 = isnull(sum(valor_calc),0)
     from #prov
     where operacion = @w_operacion_pf  
       and fecha_proceso between @w_fecha_ini_per and dateadd(dd,-1,@i_fecha_valor_cambio)
  
end

--Obtiene valor afectado por los cambios de tasa o monto
select @w_int_ganado2 = isnull(sum(valor_calc),0)
from #prov
where operacion     = @w_operacion_pf
  and fecha_proceso between @i_fecha_valor_cambio and @s_date


if @w_int_ganado2 = 0  -- => el titulo es nuevo y no tiene nada de provision
begin
  if @i_dias_reales = 'S'
       select @w_dias_res2 = datediff(dd,@i_fecha_valor_cambio,@s_date)
  else
         exec sp_funcion_1  
                  @i_operacion = 'DIFE30',
            @i_fechai    = @i_fecha_valor_cambio,
      @i_fechaf    = @s_date,
      @i_dia_pago  = @i_dia_pago,
      @o_dias      = @w_dias_res2 out 
  
  select @w_dias_res_per = @w_dias_res_per + @w_dias_res2
  select @w_int_ganado2 = (@i_monto * @i_tasa * @w_dias_res2 ) / (@w_base_calculo * 100.00) 
end

-------------------------------------------------------------------------------------------
-- Calculo de d-as a partir de la fecha de proceso a la siguiente fecha de pago de interes
-------------------------------------------------------------------------------------------
if @i_dias_reales = 'S'
   select @w_dias_res3 = datediff(dd,@s_date,@w_fecha_pg_int)
else begin
   exec sp_funcion_1
        @i_operacion = 'DIFE30',
        @i_fechai    = @s_date,
        @i_fechaf    = @w_fecha_pg_int,
        @i_dia_pago  = @i_dia_pago,
        @o_dias      = @w_dias_res3     out 
end   

select @w_dias_res_per = @w_dias_res_per + @w_dias_res3
select @w_int_ganado3  = @w_int_ganado5 + (@i_monto * @i_tasa * @w_dias_res3 ) / (@w_base_calculo * 100.00)

------------------------------------------------------------------------------
-- Obtiene el nuevo valor de interes ganado que se va guardar en pf_operacion
------------------------------------------------------------------------------
if @w_fecha_valor_i < @s_date and @w_fecha_valor_i = @i_fecha_valor and isnull(@w_incremento,0) = 0  --Calculo solo pantalla mantenimiento
begin
     if @i_fecha_valor_cambio < @s_date   -- si la fecha valor del cambio es menor que hoy(fecha de proceso)
     begin
        select @w_int_estimado = --@w_int_ganado_i +                                                                                 /* ganado actual */
                                 (@i_monto * @i_tasa * @w_dias_res3)/(@w_base_calculo * 100) +                                     /* nuevo estimado dias restantes */ 

                                 (@i_monto * @i_tasa * datediff(dd,@i_fecha_valor_cambio,@s_date))/(@w_base_calculo * 100)       /* ajuste ganado actual */
                                --*-*  - (@i_monto*@w_tasa_i * datediff(dd,@i_fecha_valor_cambio,@s_date))/(@w_base_calculo * 100)    
     end                                     
     else 
     begin
        select @w_int_estimado = (@i_monto * @i_tasa * @w_dias_res3)/(@w_base_calculo * 100.00)
        select @w_int_estimado = @w_int_ganado_i  + @w_int_estimado + (@w_int_ganado1 - @w_int_ganado_i)
     end
end
else 
begin

   select @w_int_estimado = isnull(@w_int_ganado1,0) + isnull(@w_int_ganado2,0) + isnull(@w_int_ganado3,0) + isnull(@w_int_ganado4,0)   --CVA May-08-06
end


select @w_int_ganado = isnull(@w_int_ganado1,0) + isnull(@w_int_ganado2,0) + isnull(@w_int_ganado4,0) --CVA May-08-06

--*-* Obtiene el valor del interes total ganado a la fecha

select @o_total_int_ganado = @w_tot_int_pag_i + @w_int_ganado - @w_int_pagado_fe --CVA May-10-06 Si existen pagos anticipados

--*-* Obtiene valor de total int estimado => llamar a estimint OOJJJOOO!!!

--Aplica restriciones para cuando cambia la FECHA DE VENCIMIENTO del certificado y el numero de dias--
if @i_fecha_ven < @w_fecha_pg_int
begin
      select @w_msg = '['+@w_sp_name+'] ' + 'Fecha de vencimiento no puede ser menor que fecha de prox pago de interes'
      goto ERROR
end
else
      select @w_fecha_ven = @i_fecha_ven

select @w_dia_pago = datepart(dd,@w_fecha_pg_int)

--*-* APLICA CONDICIONES DE CAPITALIZACION AL MONTO PARA PROYECCION DE INTERES AL VENCIMIENTO

select @w_monto_e = 0

if @i_tcapitalizacion = 'S'
   select @w_monto_e = @i_monto + @w_int_estimado
else
   select @w_monto_e = @i_monto 

exec @w_return = sp_estima_int
     @s_ofi             = @s_ofi,
     @s_date            = @s_date,
     @i_fecha_inicio    = @w_fecha_pg_int,
     @i_cambia_dia_pago = 'S', --CVA May-22-06 siempre es S
     @i_fecha_final     = @w_fecha_ven,
     @i_monto           = @w_monto_e,
     @i_tasa            = @i_tasa,
     @i_tcapitalizacion = @i_tcapitalizacion,
     @i_fpago           = @i_fpago,
     @i_ppago           = @i_ppago,
     @i_dias_anio       = @w_base_calculo,
     @i_dia_pago        = @w_dia_pago,
     @i_dias_reales     = @i_dias_reales, --+-+
     @i_moneda          = @i_moneda,       
     --I. CVA Jun-27-06 Parametros para escalonado
     @i_modifica        = @i_modifica, 
     @i_toperacion      = @i_toperacion,
     @i_op_operacion    = @w_operacion_pf,
     @i_periodo_tasa    = @i_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
     @i_modalidad_tasa  = @i_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
     @i_descr_tasa      = @i_descr_tasa,
     @i_mnemonico_tasa  = @i_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
     @i_tipo_plazo      = @i_tipo_plazo, 
     @i_en_linea        = 'S',
     @i_batch           = 'S',
     @i_calc_mod        = 'S',
     --F. CVA Jun-27-06 Parametros para escalonado 
     @o_int_pg_ve       = @w_total_int_estimado out,
     @o_num_pagos       = @o_num_pagos out

if @w_return <> 0
begin
     select @w_msg = '['+@w_sp_name+'] ' + 'Error en proceso de calculo de interes (Cambios Certificado)'
     goto ERROR
end

select @o_num_pagos = case @i_ppago 
                        when 'NNN' then @o_num_pagos
                        else @o_num_pagos + 1
                      end
  
select @o_fecha_pg_int       = @w_fecha_pg_int,
       @o_int_ganado       = round(@w_int_ganado,@w_numdeci),
       @o_int_estimado       = round(@w_int_estimado,@w_numdeci),
       @o_total_int_estimado = round(((@w_tot_int_pag_i - @w_int_pagado_fe) + isnull(@w_total_int_estimado,0) + isnull(@w_int_estimado,0)) , @w_numdeci)

drop table #monto
drop table #tasa
drop table #prov

return 0


ERROR:

   if isnull(@w_msg,'') = '' 
      select @w_msg = '['+@w_sp_name+'] ' + 'Error en el proceso'

   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_msg,
        @i_num   = 141190
   return 141190

go
