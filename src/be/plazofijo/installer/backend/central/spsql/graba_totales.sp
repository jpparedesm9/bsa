/*******************************************************************/
/* Archivo:            bt_total.sp                                 */
/* Stored procedure:   sp_graba_totales                            */
/* Base de datos:      cob_pfijo                                   */
/* Producto:           PLAZO FIJO                                  */
/* Disenado por:       Dolores Guerrero/Ximena Cartagena           */
/* Fecha de escritura: 02-Sep-1997                                 */
/*******************************************************************/
/*                          IMPORTANTE                             */
/* Este programa es parte de los paquetes bancarios propiedad de   */
/* 'MACOSA', representantes exclusivos para el Ecuador de la       */
/* 'NCR CORPORATION'.                                              */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado hecho por alguno de sus         */
/* usuarios sin el debido consentimiento por escrito de la         */
/* Presidencia Ejecutiva de MACOSA o su representante.             */
/*******************************************************************/
/*                          PROPOSITO                              */
/* Este programa actualiza diariamente la tabla pf_estadistica,    */
/* por funcionario,por oficina y ciudad; calcula tambien la tasa   */
/* promedio ponderada y el plazo promedio ponderado en base a los  */
/* registros que fueron acumulados de la tabla pf_operacion        */
/* La informacion se guarda a la fecha por mes que le corresponde  */
/* Esta tabla sera utilizada para las estadisticas                 */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/* FECHA        AUTOR            RAZON                             */
/* 04/ENE/2006  Luis Im          Recal. tasa y plazo ponderados    */
/* 06/SEP/2006  Clotilde Vargas  Incluir criterio por Vicepresi    */
/* 11/OCT/2006  Clotilde Vargas  Agregar cambios para almacena-    */
/*                               miento por anio                   */
/*******************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_graba_totales')
   drop proc sp_graba_totales
go

create proc sp_graba_totales
@i_param1   varchar(255)
with encryption
as
declare
@w_error                 int,
@w_msg                   descripcion,
@w_sp_name               varchar(32),
@w_fecha_proceso         datetime,
@w_monto                 money,
@w_nivel                 char(1),
@w_toperacion            catalogo,
@w_moneda                int,
@w_valor_nivel           varchar(10),
@w_plazo_pponderado      money,
@w_tasa_pponderada       float,
@w_op_num_dias           int,
@w_oficial               login,
@w_mes                   tinyint,
@w_plazo                 money,
@w_tasa                  money,
@w_difer                 money,
@w_op_monto              money,
@w_op_tasa               float,     --GES E021 06/08/1999 Cambio tipo de
@w_anio                  smallint,  --LIM 27/DIC/2005
@w_tot_reg               int,       --LIM 03/ENE/2006
@w_tot_monto             money,     --LIM 03/ENE/2006
@w_cantidad              int,       --LIM 03/ENE/2006
@w_tot_mon               money,     --LIM 04/ENE/2006
@w_toperacion_ant        catalogo,  --LIM 04/ENE/2006
@w_tasa_pponderada1      float,     --LIM 04/ENE/2006
@w_plazo_pponderado1     int,       --LIM 04/ENE/2006
@w_tot_registros         int,       --LIM 04/ENE/2006
@w_registros             int,       --LIM 04/ENE/2006
@w_plazo_pponderado_acum int,       --LIM 04/ENE/2006
@w_tasa_pponderada_acum  float      --LIM 04/ENE/2006


Set Ansi_Warnings Off

select   @w_sp_name = 'sp_graba_totales'

select @w_fecha_proceso = convert(datetime, @i_param1)

select 
@w_mes = datepart(mm,@w_fecha_proceso),
@w_anio= datepart(yy,@w_fecha_proceso)      --LIM 27/DIC/2005


delete pf_estadistica where es_mes = @w_mes and   es_anio = @w_anio

set rowcount 0

begin tran

/* INSERTA OFICIALES */
insert into pf_estadistica(
es_tipo_deposito,        es_moneda,               es_nivel,
es_valor_nivel,
es_mes,                  es_cantidad,             es_monto,
es_plazo_pponderado,     es_tasa_pponderada,      es_anio)
select
op_toperacion_apertura,  op_moneda,               'F',
isnull(op_oficial_apertura,'NULO'),
@w_mes,                  count(*),                sum(oh_monto),
0,                       0,                       @w_anio
from  pf_operacion, pf_operacion_his
where op_estado in ('ACT', 'XACT','CAN')
and   op_operacion = oh_operacion
and   datepart(mm,op_fecha_ingreso) = @w_mes
and   datepart(yy,op_fecha_ingreso) = @w_anio
group by op_toperacion_apertura, op_moneda, op_oficial_apertura
order by op_oficial_apertura,op_moneda,op_toperacion_apertura
if @@error <> 0
begin
   select
   @w_error = 143001,
   @w_msg   = 'Error en insercion de oficiales'
   goto ERROR
end


/* INSERTA OFICINAS */
insert into pf_estadistica(
es_tipo_deposito,       es_moneda,              es_nivel,
es_valor_nivel,
es_mes,                 es_cantidad,            es_monto,
es_plazo_pponderado,    es_tasa_pponderada,     es_anio)
select
op_toperacion_apertura, op_moneda,              'O',
convert(char(6),op_oficina_apertura),
@w_mes,                 count(*),               sum(oh_monto),
0,                      0,                      @w_anio
from  pf_operacion, pf_operacion_his
where op_estado in ('ACT', 'XACT','CAN')
and   op_operacion = oh_operacion
and   datepart(mm,op_fecha_ingreso) = @w_mes
and   datepart(yy,op_fecha_ingreso) = @w_anio
group by op_toperacion_apertura,op_moneda,op_oficina_apertura
order by op_oficina_apertura,op_moneda,op_toperacion_apertura
if @@error <> 0
begin
   /* Error en insercion de estadistica */
   select
   @w_error = 143001,
   @w_msg   = 'Error en insercion de oficinas'

   goto ERROR
end

/* INSERTA CIUDADES */
insert into pf_estadistica(
es_tipo_deposito,       es_moneda,              es_nivel,
es_valor_nivel,
es_mes,                 es_cantidad,            es_monto,
es_plazo_pponderado,    es_tasa_pponderada,     es_anio)
select
op_toperacion_apertura, op_moneda,              'C',
convert(char(6),of_ciudad),
@w_mes,                 count(*),               sum(oh_monto),
0,                      0,                      @w_anio
from  pf_operacion,cobis..cl_oficina, pf_operacion_his
where op_estado in ('ACT', 'XACT','CAN')
and   op_operacion = oh_operacion
and   datepart(mm,op_fecha_ingreso) = @w_mes
and   datepart(yy,op_fecha_ingreso) = @w_anio
and   op_oficina_apertura  = of_oficina
group by op_toperacion_apertura,op_moneda,of_ciudad

if @@error <> 0
begin
   select
   @w_error = 143001,
   @w_msg   =  'Error en insercion de ciudades'
   goto ERROR
end


/* INSERTA NIVEL GENERAL AGRUPADO POR TIPO DE APLICACION*/
insert into pf_estadistica(
es_tipo_deposito,       es_moneda,              es_nivel,
es_valor_nivel,
es_mes,                 es_cantidad,            es_monto,
es_plazo_pponderado,    es_tasa_pponderada,     es_anio)
select
op_toperacion_apertura, op_moneda,              'T',
isnull(op_toperacion_apertura,'NULO'),
@w_mes,                 count(*),               sum(oh_monto),
0,                      0,                      @w_anio
from  pf_operacion, pf_operacion_his
where op_estado in ('ACT', 'XACT','CAN')
and   op_operacion = oh_operacion
and   datepart(mm,op_fecha_ingreso) = @w_mes
and   datepart(yy,op_fecha_ingreso) = @w_anio
group by op_toperacion_apertura, op_moneda
order by op_toperacion_apertura, op_moneda
if @@error <> 0
begin
   select
   @w_error = 143001,
   @w_msg   =  'Error en insercion de tipo de aplicacion'
   goto ERROR
end



/* INSERTA POR VICEPRESIDENCIA */
insert into pf_estadistica (
es_tipo_deposito,
es_moneda,           es_nivel,            es_valor_nivel,
es_mes,              es_cantidad,         es_monto,
es_plazo_pponderado, es_tasa_pponderada,  es_anio)
select
convert(varchar(10),op_oficina_apertura),
op_moneda,           'V',                 convert(varchar, isnull(of_zona, -1)),
@w_mes,              count(*),            sum(oh_monto),
0,                   0,                   @w_anio
from  pf_operacion,cobis..cl_oficina, pf_operacion_his
where op_estado in ('ACT', 'XACT','CAN')
and   op_operacion                  = oh_operacion
and   datepart(mm,op_fecha_ingreso) = @w_mes
and   datepart(yy,op_fecha_ingreso) = @w_anio
and   op_oficina_apertura  = of_oficina
group by convert(varchar(10),op_oficina_apertura),op_moneda,of_zona
if @@error <> 0
begin
   select
   @w_error = 143001,
   @w_msg   = 'Error en insercion de datos por vicepresidencia'
   goto ERROR
end


/* CALCULO DE TASA Y PLAZO PONDERADO POR OFICIAL */
declare cursor_oficial cursor for
select
es_nivel,         es_valor_nivel,   es_moneda,
es_tipo_deposito, es_monto
from  pf_estadistica
where es_mes   = @w_mes
and   es_anio  = @w_anio
and   es_nivel = 'F'
for read only
open cursor_oficial
fetch cursor_oficial into
@w_nivel,         @w_valor_nivel,   @w_moneda,
@w_toperacion,    @w_monto

while @@fetch_status <> -1 -- MCA 12-oct-99 SQLS65-E022
begin
   if @@fetch_status = -2
   begin
      close cursor_oficial
      deallocate  cursor_oficial
      raiserror ('200001 - Fallo lectura del cursor', 16, 1)
      return 0
   end

   select
   @w_plazo_pponderado = 0,
   @w_tasa_pponderada  = 0

   declare cursor_operacion cursor for
   select
   oh_monto,        oh_num_dias,     oh_tasa
   from  pf_operacion, pf_operacion_his    --LIM 04/ENE/2005
   where op_oficial_apertura  = @w_valor_nivel  --LIM 15/NOV/2005
   and   op_toperacion_apertura    = @w_toperacion   --LIM 15/NOV/2005
   and   op_moneda           = @w_moneda
   and   op_estado           in ('ACT', 'XACT','CAN')--LIM 04/ENE/2005
   and   datepart(mm,op_fecha_ingreso) = @w_mes  --LIM 27/DIC/2005
   and   datepart(yy,op_fecha_ingreso) = @w_anio --LIM 27/DIC/2005
   and   op_operacion       = oh_operacion       --LIM 04/ENE/2005
   for read only
   open cursor_operacion

   fetch cursor_operacion into
   @w_op_monto,    @w_op_num_dias, @w_op_tasa

   while @@fetch_status <> -1 -- MCA 12-oct-99 SQLS65-E022
   begin
      if @@fetch_status = -2
      begin
         close cursor_operacion
         deallocate  cursor_operacion
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end

      select
      @w_difer   = 0,
      @w_plazo   = 0,
      @w_tasa    = 0

      select @w_difer = @w_op_monto / @w_monto
      select @w_plazo = @w_difer * @w_op_num_dias
      select @w_tasa  = @w_op_monto * @w_op_tasa            --LIM 27/DIC/2005
      select @w_plazo = @w_op_monto * @w_op_num_dias        --LIM 27/DIC/2005
      select @w_plazo_pponderado = @w_plazo_pponderado+@w_plazo
      select @w_tasa_pponderada  = @w_tasa_pponderada +@w_tasa

      fetch cursor_operacion into
      @w_op_monto,    @w_op_num_dias, @w_op_tasa

   end /*while cursor_operacion*/

   select
   @w_tasa_pponderada  = @w_tasa_pponderada/@w_monto,      --LIM 27/DIC/2005
   @w_plazo_pponderado = @w_plazo_pponderado/@w_monto      --LIM 27/DIC/2005

   update pf_estadistica set
   es_plazo_pponderado = @w_plazo_pponderado,
   es_tasa_pponderada  = round(@w_tasa_pponderada,4)
   where es_valor_nivel   = @w_valor_nivel
   and   es_moneda        = @w_moneda
   and   es_nivel         = 'F'
   and   es_mes           = @w_mes
   and   es_anio          = @w_anio
   and   es_tipo_deposito = @w_toperacion
   
   if @@error <> 0
   begin
      select
      @w_error = 145001,
      @w_msg   = 'Error en actualizacion de estadistica de oficiales'
      goto ERROR
   end

   close cursor_operacion
   deallocate  cursor_operacion

   fetch cursor_oficial into
   @w_nivel,         @w_valor_nivel,   @w_moneda,
   @w_toperacion,    @w_monto

   select @w_plazo_pponderado=0, @w_tasa_pponderada = 0

end /*while cursor_oficial*/

close cursor_oficial
deallocate  cursor_oficial


/* CALCULO DE TASA Y PLAZO PONDERADO POR OFICINA */
declare cursor_oficina cursor for
select
es_nivel,         es_valor_nivel,   es_moneda,
es_tipo_deposito, es_monto
from  pf_estadistica
where es_mes   = @w_mes
and   es_anio  = @w_anio
and   es_nivel ='O'
for read only
open cursor_oficina
fetch cursor_oficina into
@w_nivel,        @w_valor_nivel,  @w_moneda,
@w_toperacion,   @w_monto

while @@fetch_status <> -1  -- MCA 12-oct-99 SQLS65-E022
begin
   if @@fetch_status = -2
   begin
      close cursor_oficina
      deallocate  cursor_oficina
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      return 0
   end

   select
   @w_plazo_pponderado = 0,
   @w_tasa_pponderada  = 0

   declare cursor_operacion1 cursor for
   /*LIM 04/ENE/2005 Se traen datos del historico de operacion */
   select
   oh_monto,    oh_num_dias, oh_tasa
   from  pf_operacion, pf_operacion_his
   where op_oficina_apertura           = convert(int,@w_valor_nivel) --LIM 15/NOV/2005
   and   op_toperacion_apertura        = @w_toperacion               --LIM 15/NOV/2005
   and   op_moneda                     = @w_moneda
   and   op_estado                    in ('ACT', 'XACT','CAN')       --LIM 04/ENE/2006
   and   datepart(mm,op_fecha_ingreso) = @w_mes                      --LIM 27/DIC/2005
   and   datepart(yy,op_fecha_ingreso) = @w_anio                     --LIM 27/DIC/2005
   and   op_operacion                  = oh_operacion                --LIM 04/ENE/2005
   for read only

   open cursor_operacion1

   fetch cursor_operacion1 into
   @w_op_monto,    @w_op_num_dias, @w_op_tasa

   while @@fetch_status <> -1  -- MCA 12-oct-99 SQLS65-E022
   begin
      if @@fetch_status = -2
      begin
         close cursor_operacion1
         deallocate  cursor_operacion1
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end

      select
      @w_difer = 0,
      @w_plazo = 0,
      @w_tasa  = 0

      select @w_difer  = @w_op_monto / @w_monto
      select @w_tasa   = @w_op_monto * @w_op_tasa           --LIM 27/DIC/2005
      select @w_plazo  = @w_op_monto * @w_op_num_dias       --LIM 27/DIC/2005
      select @w_plazo_pponderado = @w_plazo_pponderado + @w_plazo
      select @w_tasa_pponderada  = @w_tasa_pponderada  + @w_tasa

      fetch cursor_operacion1 into @w_op_monto,@w_op_num_dias,@w_op_tasa

   end /*while cursor_operacion1*/

   select
   @w_tasa_pponderada  = @w_tasa_pponderada/@w_monto,    --LIM 27/DIC/2005
   @w_plazo_pponderado = @w_plazo_pponderado/@w_monto      --LIM 27/DIC/2005

   update pf_estadistica set
   es_plazo_pponderado    = @w_plazo_pponderado,
   es_tasa_pponderada     = round(@w_tasa_pponderada,4)
   where es_valor_nivel   = @w_valor_nivel
   and   es_moneda        = @w_moneda
   and   es_nivel         = 'O'
   and   es_mes           = @w_mes
   and   es_anio          = @w_anio
   and   es_tipo_deposito = @w_toperacion

   if @@error <> 0
   begin
      select
      @w_error = 145001,
      @w_msg   = 'Error en actualizacion de estadistica de operacion'
      goto ERROR
   end
   
   close cursor_operacion1
   deallocate  cursor_operacion1

   fetch cursor_oficina into
   @w_nivel,       @w_valor_nivel, @w_moneda,
   @w_toperacion,  @w_monto

   select
   @w_plazo_pponderado = 0,
   @w_tasa_pponderada  = 0

end /*while cursor_oficina*/

close cursor_oficina
deallocate  cursor_oficina


/*LIM 04/ENE/2005*/
select
@w_plazo_pponderado      = 0,
@w_tasa_pponderada       = 0,
@w_tot_registros         = 0,
@w_plazo_pponderado_acum = 0,
@w_tasa_pponderada_acum  = 0


/* CALCULO DE TASA Y PLAZO PONDERADO POR CIUDAD */
declare cursor_ciudad cursor for
select
es_nivel,         es_valor_nivel,   es_moneda,
es_tipo_deposito, es_monto,         es_cantidad   --LIM 04/ENE/2005
from  pf_estadistica
where es_mes   = @w_mes
and   es_anio  = @w_anio
and   es_nivel = 'C'
for read only

open cursor_ciudad

fetch cursor_ciudad into
@w_nivel,       @w_valor_nivel, @w_moneda,
@w_toperacion,  @w_monto,       @w_registros

while @@fetch_status <> -1  -- MCA 12-oct-99 SQLS65-E022
begin
   if @@fetch_status = -2
   begin
      close cursor_ciudad
      deallocate  cursor_ciudad
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      return 0
   end

   select
   @w_plazo_pponderado1 = 0,
   @w_tasa_pponderada1  = 0


   /* Lim 04/ENE/2006 Se busca informacion de historico de operacion*/
   declare cursor_operacion2 cursor for
   select
   oh_monto,    oh_num_dias, oh_tasa
   from  pf_operacion,cobis..cl_oficina, pf_operacion_his
   where of_ciudad                     = convert(int,@w_valor_nivel)
   and   of_oficina                    = op_oficina_apertura      --LIM 15/NOV/2005
   and   op_operacion                  = oh_operacion             --LIM 04/ENE/2005
   and   op_toperacion_apertura        = @w_toperacion            --LIM 15/NOV/2005
   and   op_moneda                     = @w_moneda
   and   op_estado                    in ('ACT', 'XACT', 'CAN')   --LIM 04/ENE/2005
   and   datepart(mm,op_fecha_ingreso) = @w_mes                   --LIM 27/DIC/2005
   and   datepart(yy,op_fecha_ingreso) = @w_anio                  --LIM 27/DIC/2005
   for read only

   open cursor_operacion2

   fetch cursor_operacion2 into @w_op_monto,@w_op_num_dias,@w_op_tasa

   while @@fetch_status <> -1 -- MCA 12-oct-99 SQLS65-E022
   begin
      if @@fetch_status = -2
      begin
         close cursor_operacion2
         deallocate  cursor_operacion2
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end

      select
      @w_difer   = 0,
      @w_plazo   = 0,
      @w_tasa    = 0

      select @w_difer            = @w_op_monto / @w_monto
      select @w_tasa             = @w_op_monto*@w_op_tasa       --LIM 27/DIC/2005
      select @w_plazo            = @w_op_monto*@w_op_num_dias   --LIM 27/DIC/2005
      select @w_plazo_pponderado = @w_plazo_pponderado+@w_plazo
      select @w_tasa_pponderada  = @w_tasa_pponderada+@w_tasa
      --I.CVA Abr-29-06
      --select @w_plazo_pponderado_acum = @w_plazo_pponderado_acum + @w_plazo    --LIM 04/ENE/2006
      --select @w_tasa_pponderada_acum = @w_tasa_pponderada_acum + @w_tasa    --LIM 04/ENE/2006
      --F.CVA Abr-29-06
      fetch cursor_operacion2 into
      @w_op_monto,    @w_op_num_dias, @w_op_tasa

   end /*while cursor_operacion2*/

   select
   @w_tasa_pponderada1  = @w_tasa_pponderada/@w_monto,           --LIM 27/DIC/2005
   @w_plazo_pponderado1 = @w_plazo_pponderado/@w_monto           --LIM 27/DIC/2005

   select @w_tot_registros = @w_tot_registros + @w_registros            --LIM 04/ENE/2006

   update pf_estadistica set
   es_plazo_pponderado = @w_plazo_pponderado1,
   es_tasa_pponderada  = round(@w_tasa_pponderada1,4)
   where es_valor_nivel    = @w_valor_nivel
   and   es_moneda     = @w_moneda
   and   es_nivel      = 'C'
   and   es_mes     = @w_mes
   and   es_anio             = @w_anio
   and   es_tipo_deposito = @w_toperacion

      if @@error <> 0
   begin
      select
      @w_error = 145001,
      @w_msg   = 'Error en actualizacion de estadistica de operacion 2'
      goto ERROR
   end

   close cursor_operacion2
   deallocate  cursor_operacion2

   fetch cursor_ciudad into
   @w_nivel,       @w_valor_nivel, @w_moneda,
   @w_toperacion,  @w_monto,       @w_registros     --LIM 04/ENE/2005

   select @w_plazo_pponderado=0
   select @w_tasa_pponderada =0

end /*while cursor_ciudad*/

close cursor_ciudad
deallocate  cursor_ciudad


/* CALCULO DE TASA Y PLAZO PONDERADO POR TIPO APLICACION GENERAL */
declare cursor_general cursor for
select
es_nivel,         es_valor_nivel,   es_moneda,
es_tipo_deposito, es_monto
from  pf_estadistica
where es_mes   = @w_mes
and   es_anio  = @w_anio
and   es_nivel = 'T'
for read only
open cursor_general
fetch cursor_general into
@w_nivel,       @w_valor_nivel, @w_moneda,
@w_toperacion,  @w_monto

while @@fetch_status <> -1  -- MCA 12-oct-99 SQLS65-E022
begin
   if @@fetch_status = -2
   begin
      close cursor_general
      deallocate  cursor_general
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      return 0
   end

   select @w_plazo_pponderado=0
   select @w_tasa_pponderada =0

   declare cursor_operacion cursor for
   select
   oh_monto,        oh_num_dias,     oh_tasa
   from  pf_operacion, pf_operacion_his    --LIM 04/ENE/2005
   where op_toperacion_apertura  = @w_valor_nivel  --LIM 15/NOV/2005
   and   op_toperacion_apertura    = @w_toperacion   --LIM 15/NOV/2005
   and   op_moneda           = @w_moneda
   and   op_estado           in ('ACT', 'XACT','CAN')--LIM 04/ENE/2005
   and   datepart(mm,op_fecha_ingreso) = @w_mes  --LIM 27/DIC/2005
   and   datepart(yy,op_fecha_ingreso) = @w_anio --LIM 27/DIC/2005
   and   op_operacion       = oh_operacion       --LIM 04/ENE/2005
   for read only
   open cursor_operacion

   fetch cursor_operacion into
   @w_op_monto,     @w_op_num_dias,  @w_op_tasa

   while @@fetch_status <> -1  -- MCA 12-oct-99 SQLS65-E022
   begin
      if @@fetch_status = -2
      begin
         close cursor_operacion
         deallocate  cursor_operacion
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end

      select @w_difer   = 0, @w_plazo=0, @w_tasa =0
      select @w_difer   = @w_op_monto/@w_monto
      select @w_plazo  = @w_difer*@w_op_num_dias
      select @w_tasa = @w_op_monto*@w_op_tasa            --LIM 27/DIC/2005
      select @w_plazo  = @w_op_monto*@w_op_num_dias        --LIM 27/DIC/2005
      select @w_plazo_pponderado = @w_plazo_pponderado+@w_plazo
      select @w_tasa_pponderada  = @w_tasa_pponderada +@w_tasa

      fetch cursor_operacion into @w_op_monto,@w_op_num_dias,@w_op_tasa

   end /*while cursor_operacion*/
   select 
   @w_tasa_pponderada  = @w_tasa_pponderada/@w_monto,      --LIM 27/DIC/2005
   @w_plazo_pponderado = @w_plazo_pponderado/@w_monto      --LIM 27/DIC/2005

   update pf_estadistica set
   es_plazo_pponderado=@w_plazo_pponderado,
   es_tasa_pponderada= round(@w_tasa_pponderada,4)
   where es_valor_nivel =@w_valor_nivel
   and   es_moneda     =@w_moneda
   and   es_nivel      ='T'
   and   es_mes     =@w_mes
   and   es_anio             =@w_anio
   and   es_tipo_deposito =@w_toperacion

   if @@error <> 0
   begin
      select
      @w_error = 145001,
      @w_msg   = 'Error en actualizacion de estadistica de operacion'
      goto ERROR
   end
   
   close cursor_operacion
   deallocate cursor_operacion

   fetch cursor_general into 
   @w_nivel,       @w_valor_nivel, @w_moneda,      
   @w_toperacion,  @w_monto

   select 
   @w_plazo_pponderado = 0, 
   @w_tasa_pponderada  = 0

end /*while cursor_general*/

close cursor_general
deallocate cursor_general


/* CALCULO DE TASA Y PLAZO PONDERADO POR VICEPRESIDENCIA */
declare cursor_vicepre cursor for
select   
es_nivel,        es_valor_nivel, es_moneda,      
es_tipo_deposito, --C¢digo de Oficina
es_monto,        es_cantidad
from  pf_estadistica
where es_mes   = @w_mes
and   es_anio   = @w_anio
and   es_nivel   ='V'
for read only

open cursor_vicepre

fetch cursor_vicepre into 
@w_nivel,       @w_valor_nivel, @w_moneda,      
@w_toperacion,  @w_monto,       @w_registros

while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
      close cursor_vicepre
      deallocate cursor_vicepre
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      return 0
   end

   select @w_plazo_pponderado1=0
   select @w_tasa_pponderada1 =0

   declare cursor_operacion3 cursor for
   select   
   oh_monto,      oh_num_dias,   oh_tasa        
   from  pf_operacion,cobis..cl_oficina, pf_operacion_his
   where of_zona          = @w_valor_nivel  -- NYMPSQL cambie of_area por of_zona
   and   of_oficina       = op_oficina_apertura
   and   op_operacion     = oh_operacion
   and   op_oficina_apertura    = convert(smallint,@w_toperacion)      --Oficina
   and   op_moneda        = @w_moneda
   and   op_estado        in ('ACT', 'XACT', 'CAN')
   and   datepart(mm,op_fecha_ingreso) = @w_mes
   and   datepart(yy,op_fecha_ingreso) = @w_anio
   for read only

   open cursor_operacion3

   fetch cursor_operacion3 into 
   @w_op_monto,    @w_op_num_dias, @w_op_tasa      

   while @@fetch_status <> -1
   begin
      if @@fetch_status = -2
      begin
         close cursor_operacion3
         deallocate cursor_operacion3
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end

      select @w_difer   =0, @w_plazo=0, @w_tasa =0
      select @w_difer   = @w_op_monto / @w_monto
      select @w_tasa   = @w_op_monto*@w_op_tasa
      select @w_plazo  = @w_op_monto*@w_op_num_dias
      select @w_plazo_pponderado=@w_plazo_pponderado+@w_plazo
      select @w_tasa_pponderada=@w_tasa_pponderada+@w_tasa
      
      fetch cursor_operacion3 into @w_op_monto,@w_op_num_dias,@w_op_tasa

   end /*while cursor_operacion3*/

   select 
   @w_tasa_pponderada1  = @w_tasa_pponderada /@w_monto,
   @w_plazo_pponderado1 = @w_plazo_pponderado/@w_monto
   
   select @w_tot_registros = @w_tot_registros + @w_registros

   update pf_estadistica set
   es_plazo_pponderado = @w_plazo_pponderado1,
   es_tasa_pponderada  = round(@w_tasa_pponderada1,4)
   where es_valor_nivel    = @w_valor_nivel
   and   es_moneda     = @w_moneda
   and   es_nivel      = 'V'
   and   es_mes     = @w_mes
   and   es_anio             = @w_anio
   and   es_tipo_deposito = @w_toperacion --Oficina

   if @@error <> 0
   begin
      select
      @w_error = 145001,
      @w_msg   = 'Error en actualizacion de estadistica de operacion'
      goto ERROR
   end
   
   close cursor_operacion3
   deallocate cursor_operacion3

   fetch cursor_vicepre into
   @w_nivel,       @w_valor_nivel, @w_moneda,      
   @w_toperacion,  @w_monto,       @w_registros

   select @w_plazo_pponderado=0
   select @w_tasa_pponderada =0

end /*while cursor_vicepre*/

close cursor_vicepre
deallocate cursor_vicepre

commit tran

return 0
ERROR:
   if @@trancount > 0 rollback tran
   print @w_msg
   
   exec sp_errorlog
   @i_fecha        = @w_fecha_proceso,
   @i_error        = @w_error,
   @i_usuario      = 'estadisticas',
   @i_tran         = 0,
   @i_descripcion  = @w_msg
   
   return @w_error

go



