/************************************************************************/
/*      Archivo:                actdia.sp                               */
/*      Stored procedure:       sp_actdia                               */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               PLAZO FIJO                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de escritura:     22/Mar/99                               */
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
/*      Este script cambia las tasas y realiza los nuevos calculos de   */
/*      aquellas operaciones que fueron congeladas por el gobierno      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                   RAZON                   */
/*      30/Mar/99       Ximena Cartagena U      Emision                 */
/*      13/08/2009      JBQ                    Adaptacion SQLserver     */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_actdia')
   drop proc sp_actdia

go

create proc sp_actdia(
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_sesn                 int         = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_rol                  smallint    = NULL,
@s_ofi                  smallint    = NULL,
@s_org_err              char(1)     = NULL,
@s_error                int         = NULL,
@s_sev                  tinyint     = NULL,
@s_msg                  descripcion = NULL,
@s_org                  char(1)     = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(14) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint    = NULL,
@i_fecha_proceso        datetime    = NULL) 
with encryption
as
declare
@w_intereses_periodo    money,
@w_num_dias_periodo     int,
@w_numdeci              tinyint, --xca
@w_usadeci              char(1), --xca
@w_num_meses            tinyint,
@w_dias                 tinyint,
@w_contador_registros   int,

/* VARIABLES PF_OPERACION */

        @w_op_operacion                int,
        @w_op_int_provision            float,
        @w_op_int_estimado             money,
        @w_op_int_ganado               money,
        @w_op_total_int_ganados        money,
        @w_op_int_pagados              money,
        @w_op_total_int_pagados        money,
        @w_op_fecha_valor              datetime,
        @w_op_fecha_ven                datetime,
        @w_op_fecha_pg_int             datetime,
        @w_op_fecha_ult_pg_int         datetime,
        @w_fecha_ult_provision         datetime,
        @w_op_monto                    money,
        @w_op_tasa                     float,
        @w_op_ppago                    catalogo,
        @w_op_tipo_plazo               catalogo,
        @w_op_tipo_monto               catalogo,
        @w_op_toperacion               catalogo,
        @w_op_moneda                   tinyint,
        @w_op_base_calculo             smallint,
        @w_op_total_int_estimado       money,
        @w_op_num_dias                 smallint,
        @w_num_dias_pagados            int,
        @w_num_dias_provisionados      int,
        @w_num_dias_ganados            int,
        @w_int_dias_pagados            money,
        @w_int_dias_ganados            money,
        @w_total_int_dias_ganados      money,
        @w_total_int_estimado          money,
        @w_op_fpago                    catalogo,
        @w_op_ley                      char(1),
        @w_fecha_hoy                   datetime,
        @w_tot_dias                    int,
        @w_tot_int_estim_new           money,

/* VARIABLES TASA_NUEVA */
        @w_tasa_new                    float, 
        @w_op_ult_fecha_cal_tasa       datetime,

/* VARIABLES PF_DET_PAGO */
        @w_pt_tipo                     catalogo,
        @w_pt_secuencia                int,
        @w_pt_forma_pago               catalogo,
        @w_pt_cuenta                   cuenta,
        @w_pt_monto                    money,
        @w_pt_porcentaje               tinyint,
        @w_monto_mov                   money
 
/* INICIALIZACION DE VARIABLES */

select @w_contador_registros = 0
select @w_fecha_hoy = @i_fecha_proceso

declare cursor_operacion cursor
for select
  op_operacion, --1
  op_int_provision,
  op_int_estimado,
  op_int_ganado,
  op_total_int_ganados,
  op_int_pagados,
  op_total_int_pagados,
  op_total_int_estimado,
  op_fecha_valor,
  op_fecha_ven, --10
  op_fecha_pg_int,
  op_fecha_ult_pg_int,
  op_monto,
  op_tasa,
  op_ppago,
  op_tipo_plazo,
  op_tipo_monto,
  op_toperacion,
  op_moneda,
  op_base_calculo, --20
  op_ult_fecha_calculo,
  op_num_dias,
  op_fpago,
  --op_ult_fecha_cal_tasa,
  op_ley
from pf_operacion 
where op_estado = 'ACT'
  and op_ley in('C','S')
  and op_fecha_ingreso >= '03/15/1999'
  and op_ult_fecha_cal_tasa = @i_fecha_proceso --MALS solo los que se reprograman
 
for update
open cursor_operacion
fetch cursor_operacion into @w_op_operacion,@w_op_int_provision,
  @w_op_int_estimado, @w_op_int_ganado,@w_op_total_int_ganados,
  @w_op_int_pagados, @w_op_total_int_pagados, @w_op_total_int_estimado,
  @w_op_fecha_valor, @w_op_fecha_ven,@w_op_fecha_pg_int, @w_op_fecha_ult_pg_int,
  @w_op_monto, @w_op_tasa,@w_op_ppago,@w_op_tipo_plazo, @w_op_tipo_monto,
  @w_op_toperacion, @w_op_moneda, @w_op_base_calculo, @w_fecha_ult_provision,
  @w_op_num_dias, @w_op_fpago,/*@w_op_ult_fecha_cal_tasa,*/@w_op_ley

while @@fetch_status <> -1
begin
  if @@fetch_status = -2
  begin
    close cursor_operacion
    deallocate cursor_operacion
    raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
    return 0
  end

  select @w_usadeci = mo_decimales
  from cobis..cl_moneda
  where mo_moneda = @w_op_moneda

  if @w_usadeci = 'S'
  begin
    select @w_numdeci = isnull(pa_tinyint,0)
    from cobis..cl_parametro
    where pa_nemonico = 'DCI' 
      and pa_producto = 'PFI'
  end
  else
    select @w_numdeci = 0  


  /********************************************************/
  /*     PROCESO PARA LEER EL VALOR DE LA NUEVA TASA      */
  /********************************************************/
            
  /* GES 04/20/1999 Lee la nueva tasa de la tabla cl_parametro   */

  if @w_op_moneda = 0  
    select @w_tasa_new = pa_float
    from cobis..cl_parametro
    where pa_nemonico = 'TRS'            
      and pa_producto = 'PFI'

  if @w_op_moneda = 1  
    select @w_tasa_new = pa_float
    from cobis..cl_parametro
    where pa_nemonico = 'TRD'            
      and pa_producto = 'PFI'

  if @w_op_moneda = 32  
    select @w_tasa_new = pa_float
    from cobis..cl_parametro
    where pa_nemonico = 'TRU'            
      and pa_producto = 'PFI'

  /***************************************************************/
  /*    PROCESO PARA CALCULAR EL TOTAL INT. ESTIMADO NUEVO       */
  /***************************************************************/

  select @w_tot_dias  = datediff(dd,@w_fecha_hoy,@w_op_fecha_ven)
        
  select @w_tot_int_estim_new =
            round((((@w_tasa_new * @w_op_monto * @w_tot_dias) /
            (100 * @w_op_base_calculo)) + @w_op_total_int_ganados),@w_numdeci)  
        
  /****************************************************************/
  /*   PROCESO PARA CALCULAR EL INT. ESTIMADO DEL PERIODO         */
  /****************************************************************/
  if @w_op_fpago <> 'NNN' /* Operaciones Periodicas */
  begin
    select @w_num_dias_periodo = datediff(dd,@w_fecha_hoy,@w_op_fecha_pg_int)

    select @w_intereses_periodo =
                  round((((@w_tasa_new * @w_op_monto * @w_num_dias_periodo) /
                  (100 * @w_op_base_calculo)) + @w_op_int_ganado),@w_numdeci)
  end
  else /* Operaciones al vencimiento */
    select  @w_intereses_periodo = @w_tot_int_estim_new
  
  /****************************************************************/
  /*           PROCESO PARA ACTUALIZAR PF_OPERACION               */
  /****************************************************************/


  /****************************************************************/
  /*           PROCESO PARA ACTUALIZAR PF_OPERACION               */
  /****************************************************************/
  
  
  
  update pf_operacion 
  set op_tasa               = @w_tasa_new,
      op_int_estimado       = @w_intereses_periodo,
      op_total_int_estimado = @w_tot_int_estim_new,
      op_ult_fecha_cal_tasa = dateadd(dd,90,@w_fecha_hoy)
  where current of cursor_operacion

  /* Actualiza la tabla pf_cuotas MALS  06/15/1999 */
        update pf_cuotas
        set cu_valor_cuota =  @w_intereses_periodo
        where cu_operacion = @w_op_operacion 
          and cu_fecha_pago = @w_op_fecha_pg_int            

  select @w_contador_registros = @w_contador_registros + 1

   if @w_op_fpago <> 'NNN'
  begin
    /* GES 04/26/1999 Se actualiza la pf_det_pago*** 
    ***si tiene porcentaje se recalcula ************/
    select @w_pt_secuencia = 0
    
    while 2=2
    begin
      set rowcount 1
      select @w_pt_tipo = dp_tipo,
             @w_pt_secuencia = dp_secuencia,
            @w_pt_forma_pago = dp_forma_pago,
             @w_pt_cuenta = dp_cuenta,
             @w_pt_monto = dp_monto,
             @w_pt_porcentaje = dp_porcentaje
      from pf_det_pago
      where dp_operacion = @w_op_operacion 
        and dp_secuencia  > @w_pt_secuencia 
        and dp_tipo = 'INT'
        and dp_estado = 'I'      
        and dp_estado_xren = 'N'            
      order by dp_secuencia

      if @@rowcount = 0
        break

      set rowcount 0
      if @w_pt_monto is null
        select @w_monto_mov = @w_pt_porcentaje*@w_intereses_periodo /100
      else
        select @w_monto_mov = @w_intereses_periodo

      update pf_det_pago 
      set dp_monto = round(@w_monto_mov , @w_numdeci)
      where dp_operacion = @w_op_operacion
        and dp_secuencia = @w_pt_secuencia
        and dp_tipo = 'INT'
        and dp_estado = 'I'
        and dp_estado_xren = 'N'
    end -- While 2 = 2

    set rowcount 0 
  end
/*       end  Si existe en pf_renovacion Comentado GES 04/20/99    */
/*    end    Fin de @w_op_ult_fecha_cal_tasa = @w_fecha_hoy        */
/* end  Fin @w_op_ult_fecha_cal_tasa is not null                   */

  fetch cursor_operacion into @w_op_operacion,@w_op_int_provision,
    @w_op_int_estimado, @w_op_int_ganado,@w_op_total_int_ganados,
    @w_op_int_pagados,@w_op_total_int_pagados, @w_op_total_int_estimado,
    @w_op_fecha_valor,@w_op_fecha_ven,@w_op_fecha_pg_int,
    @w_op_fecha_ult_pg_int, @w_op_monto,@w_op_tasa,@w_op_ppago,
    @w_op_tipo_plazo, @w_op_tipo_monto, @w_op_toperacion, @w_op_moneda,
    @w_op_base_calculo, @w_fecha_ult_provision, @w_op_num_dias, 
    @w_op_fpago,/*@w_op_ult_fecha_cal_tasa,*/@w_op_ley 
end /* while @@fetch_status !2 */

close cursor_operacion
deallocate cursor_operacion 
return 0

go        

