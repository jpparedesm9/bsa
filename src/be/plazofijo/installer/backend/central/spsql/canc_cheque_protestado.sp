/************************************************************************/
/*      Archivo:                canchepr.sp                             */
/*      Stored procedure:       sp_canc_cheque_protestado               */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
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
/*      Este programa realiza la devolucion de dinero si el deposito    */
/*      activo hasta un dia antes de ejecutar este programa. Ademas     */
/*      cambia el estado del deposito a ANULADO. Si hubo problemas se   */
/*      gera el movimiento monetario por el monto total de todos los    */
/*      problemas que tuvo el deposito. Este programa se usa cuando el  */
/*      cheque devuelto llega al Banco luego de que el deposito se      */
/*      activo                                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_canc_cheque_protestado') is not null
   drop proc sp_canc_cheque_protestado
go

create proc sp_canc_cheque_protestado(
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = 'PRSSRVP',
@s_lsrv                 varchar(30)     = 'PRSSRVP',
@s_ofi                  smallint        = 1,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = 14543,
@i_num_banco            cuenta,
@i_en_linea             char(1)         = 'S',
@i_observacion          descripcion     = NULL)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_string               varchar(30),
@w_descripcion          descripcion,
@w_s_ssn                int,
@w_trn                  int,
@w_vuelto               char(1),
@w_problema             char(1),
@w_movmonet             char(1),
@w_moneda_base          tinyint,
@w_moneda_pg            tinyint,
@w_transito             tinyint,
@w_intren               money,
@w_valor                money,
@w_valor_tran           money,
@w_valor_tot_tran       money, --acum. mm_valor de reg Tran xca
@w_valor_tran_ext       money,
@w_return               int,
@w_secuencial           int,
@w_secuencia            int,
@w_secuencia_ren        int,
@w_num_oficial          int,
@w_money                money,
@w_codval               varchar(20),    --cambia tipo de dato a varchar
@w_monto_cap            money,
@w_impuesto_capital     money,
@w_total_monet          money,
@w_max_ttransito        smallint,
@w_dia_pago             smallint,
@w_numdoc               smallint,
@w_base_calculo         smallint,
@w_dias                 int,
@w_sub_sec              tinyint,
@w_numdeci              tinyint,
@w_numdeci_pg           tinyint,
@w_usadeci              char(1),
/* VARIABLES NECESARIAS PARA PF_OPERACION */
@w_operacionpf          int,
@w_toperacion           catalogo,
@w_operacion            char(1),
@w_tplazo               catalogo,
@w_num_banco            cuenta,
@w_total_int_pagado     money,
@w_monto_pg_int         money,
@w_total_int_estimado   money,
@w_int_estimado         money,
@w_total_int_acumulado  money,
@w_total_pagar          money,
@w_total_pagar_pg       money,
@w_total_int            money,
@w_impuesto             money,
@w_impuesto_ren         money,
@w_impuesto_pg          money,
@w_factor               float,
@w_imp                  money,
@w_tasa                 float,
@w_tasa1                float,
@w_mon_sgte             int,
@w_historia             smallint,
@w_estado               catalogo,
@w_estado_ant           catalogo,
@w_fpago                catalogo,
@w_ppago                catalogo,
@w_error                int,
@w_fecha                datetime,
@w_fecha_mod            datetime,
@w_fecha_valor          datetime,
@w_fecha_pg_int         datetime,
@w_fecha_ven            datetime,
@w_causa_mod            catalogo,
@w_forma_pago           catalogo,
@w_fecha_hoy            datetime,
@w_imprime              char(1),
@w_tcapitalizacion      char(1),
@v_historia             smallint,
@v_estado               catalogo,
@v_fecha_mod            datetime,
@v_causa_mod            catalogo,
@v_mon_sgte             int,
@w_fecha_temp_hoy       datetime,
@w_cuenta_dias          smallint,
@w_oficina              smallint,           -- GAL 31/AGO/2009 - RVVUNICA
@w_producto             tinyint,
/* VARIABLES NECESARIAS PARA PF_MOV_MONET_PROB */
@w_sum_monto_problema   money,
@w_monto_dif            money,
@w_tipo                 varchar(1),
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
@w_mm_sub_secuencia     tinyint,
@w_mm_producto          catalogo,
@w_mm_cuenta            cuenta,
@w_mm_moneda            smallint,
@w_tran_ape             int,
@w_mm_valor             money,
@w_mm_valor_ext         money,
@w_pt_forma_pago        catalogo,
@w_pt_beneficiario      int,
@w_pt_secuencia         smallint,
@w_pt_cuenta            cuenta,
@w_pt_monto             money,
@w_tot_pt_monto         money, --xca
@w_pt_mont              money,
@w_pt_porcentaje        float,
@w_monto_mov            money,
@w_contor               smallint,
@w_sum_reversados       money,
@w_retienimp            char(1),
@w_retiene_imp_capital  char(1),
@w_ente                 int,
@w_num_dias             int,
@w_renova_todo          char(1),
@w_ndias                tinyint,
@w_anio_comercial       char(1),   --04/04/2000 Fecha Comercial
@w_op_dias_reales       char(1),
@w_beneficiario         varchar(254),
@w_dia_validar          datetime,
@w_dias_habiles         int,
@w_ciudad               int,
@w_msg                  varchar(140)

select @w_sp_name = 'sp_canc_cheque_protestado'

/*---------------------------------------*/
/* Verificacion de codigo de transaccion */
/*---------------------------------------*/
if (@t_trn <> 14543 ) begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141112
   return 1
end

-------------------------------
-- Inicializacion de variables
-------------------------------
select
@w_secuencial          = @s_ssn,
@w_tran_ape            = 14901,
@w_vuelto              = 'N',
@w_problema            = 'N',
@w_valor_tran          = 0,
@w_valor_tot_tran      = 0,
@w_valor_tran_ext      = 0,
@w_factor              = 1,
@w_total_int_acumulado = 0,
@w_total_int_pagado    = 0,
@w_fecha_hoy           = @s_date,
@w_ndias               = 0,
@w_dias_habiles        = 0

---------------------------------------
-- Encontrar codigo de moneda nacional
---------------------------------------
select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa
where  em_empresa     = 1

---------------------------------------------------------------------
-- Obtener parametro de dias para la aceptacion de cheque protestado
---------------------------------------------------------------------
select @w_ndias = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'DCP'
and    pa_producto = 'PFI'

select @w_oficina     = op_oficina ,
       @w_fecha_valor = op_fecha_valor,
	   @w_dia_validar = op_fecha_valor
from   pf_operacion
where  op_num_banco = @i_num_banco

select @w_ciudad  = of_ciudad
from   cobis..cl_oficina
where  of_oficina = @w_oficina

select *
into   #feriados 
from   cobis..cl_dias_feriados 
where  df_ciudad = @w_ciudad 
and    df_fecha between @w_fecha_valor and @w_fecha_hoy

while @w_dia_validar <= @w_fecha_hoy begin
   if datepart(dw,@w_dia_validar) <> 7 and not exists (select 1 from #feriados where df_fecha = @w_dia_validar)
      select @w_dias_habiles = @w_dias_habiles + 1
	  
   select @w_dia_validar = dateadd(day,1,@w_dia_validar)   
end

if @w_dias_habiles > @w_ndias begin
   exec cobis..sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 141154
   return 141154
end

select
@w_fecha_mod          = op_fecha_mod,
@w_fecha_valor        = op_fecha_valor,
@w_operacionpf        = op_operacion,
@w_estado             = op_estado,
@w_mon_sgte           = op_mon_sgte,
@w_causa_mod          = op_causa_mod,
@w_fecha_valor        = op_fecha_valor,
@w_monto_pg_int       = op_monto_pg_int,
@w_ppago              = op_ppago,
@w_fpago              = op_fpago,
@w_tcapitalizacion    = op_tcapitalizacion,
@w_tasa1              = op_tasa,
@w_base_calculo       = op_base_calculo,
@w_toperacion         = op_toperacion,
@v_historia           = op_historia,
@w_historia           = op_historia + 1,
@w_moneda_pg          = op_moneda,
@v_estado             = op_estado,
@v_fecha_mod          = op_fecha_mod,
@v_causa_mod          = op_causa_mod,
@v_mon_sgte           = op_mon_sgte,
@w_retienimp          = op_retienimp,
@w_total_int          = op_total_int_ganados - op_total_int_pagados,
@w_retiene_imp_capital= op_retiene_imp_capital,
@w_impuesto_capital   = op_impuesto_capital,
@w_ente               = op_ente,
@w_num_dias           = op_num_dias,
@w_fpago              = op_fpago,
@w_renova_todo        = op_renova_todo,
@w_anio_comercial     = op_anio_comercial,  -- Fecha Comercial
@w_op_dias_reales     = op_dias_reales
from  pf_operacion
where op_num_banco = @i_num_banco
and   op_estado    = 'ACT'

if @@rowcount = 0 begin
   select @w_msg = 'TRANSACCION NO PERMITIDA, PLAZO FIJO NUMERO ' + @i_num_banco + ' NO SE ENCUENTRA ACTIVO'
   exec cobis..sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_msg        = @w_msg,
   @i_num        = 141231
   return 141231
end

select @w_estado_ant = @v_estado

select @w_forma_pago = pa_char
from cobis..cl_parametro
where pa_nemonico = 'FPDE'
and pa_producto='PFI'
if @@rowcount = 0
return  141140

select @w_operacion = 'I'

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda_pg

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda_pg

if @w_usadeci = 'S'
begin
   select @w_numdeci_pg = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci_pg = 0

----------------------------------------------------------------------------
-- Validacion de movimiento monetario con tiempo de transito mayor que cero
----------------------------------------------------------------------------
select @w_max_ttransito  = max(fp_ttransito),
       @w_valor_tran     = isnull(sum(mm_valor),0),
       @w_valor_tran_ext = isnull(sum(mm_valor_ext),0)
  from pf_fpago,pf_mov_monet
 where fp_mnemonico  = mm_producto
   and fp_estado  = 'A'
   and mm_operacion  = @w_operacionpf
   and mm_secuencia  = 0
group by mm_operacion
if @@rowcount = 0
begin
   print 'error al obtener mov_monet'
   return 141000
end

-------------------------------------------------------------------
-- Valido que los dias de transito sean unicamente dias laborables
-------------------------------------------------------------------
select @w_cuenta_dias = 0,
       @w_fecha_temp_hoy = @w_fecha_valor


-- Sumatoria de movimientos monetarios
---------------------------------------
select @w_sum_monto_problema = sum(pr_valor)
from pf_mov_monet_prob
where pr_secuencia = 0
  and pr_operacion = @w_operacionpf
  and pr_estado = 'I'
group by  pr_operacion
if @@rowcount = 0
begin
   select @w_sum_monto_problema = 0
end

/*Controla que existan cheques devueltos LIM 13/OCT/2005*/
if @w_sum_monto_problema = 0
begin
   exec cobis..sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 141197
         return 141197

end


/* PROCESO PARA LEER TODOS LOS REGISTROS DE UNA OPERACION */
/* EN LA CUAL UNO DE ELLOS PUEDE TENER DIAS DE TRANSITO   */
/* PARA CONTABILIZAR EN LA CONFIRMACION TODOS A UNA SOLA  */
/* CUENTA xca                                             */

select @w_mm_sub_secuencia   = 0

while 1 = 1
begin
   set rowcount 1
   select @w_mm_sub_secuencia = mm_sub_secuencia,
          @w_mm_producto      = mm_producto,
     @w_mm_moneda          = mm_moneda,
          @w_mm_cuenta        = mm_cuenta,
          @w_mm_valor         = isnull(mm_valor,0),
          @w_mm_valor_ext     = isnull(mm_valor_ext,0)
   from pf_mov_monet
   where mm_operacion   = @w_operacionpf
     and mm_secuencia   = 0
     and mm_estado      = 'A'
     and mm_sub_secuencia > @w_mm_sub_secuencia
   order by mm_sub_secuencia
   if @@rowcount = 0
     break

   select @w_transito = fp_ttransito
   from cob_pfijo..pf_fpago
   where fp_mnemonico = @w_mm_producto
     and fp_estado = 'A'

   select @w_valor_tot_tran = @w_valor_tot_tran + @w_mm_valor
end /* WHile 1= 1  */

if @i_en_linea = 'S' begin tran

if @w_sum_monto_problema > 0    /*El deposito tuvo problemas*/
begin
   /* PROCESO PARA REVERSAR LOS MOVIMIENTOS DE DEBITOS */
   select @w_sum_reversados = 0
   select @w_mm_sub_secuencia = 0


/*LEVANTAMIENTO DE BLOQUEO AL REVERSAR POR CHEQUE PROTESTADO*/

	/*if exists(select 1 from cob_pfijo..pf_emision_cheque
				where ec_operacion = @w_operacionpf
				  and ec_fpago = 'CHQL'
				  and ec_tran = 14901
				  and @w_fecha_hoy < dateadd(dd,@w_ndias,ec_fecha_mov)) */		
            if exists (select 1 from cob_pfijo..pf_retencion where rt_operacion = @w_operacionpf)
            begin

		delete  cob_pfijo..pf_retencion
		where rt_operacion = @w_operacionpf
	    	
	    	update 	pf_operacion
	    	set	op_monto_blq = 0,
	    		op_retenido = 'N'
		where	op_operacion = @w_operacionpf
		
	    end
	    
   /* while 1 = 1
   begin
      set rowcount 1
      select @w_mm_sub_secuencia = mm_sub_secuencia,
             @w_mm_producto      = mm_producto,
             @w_mm_moneda        = mm_moneda,
             @w_mm_cuenta        = mm_cuenta,
             @w_mm_valor         = mm_valor,
             @w_mm_valor_ext     = mm_valor_ext
      from pf_mov_monet
      where mm_operacion   = @w_operacionpf
        and mm_secuencia   = 0
        and mm_estado      = 'A'
        and mm_sub_secuencia > @w_mm_sub_secuencia
        and mm_producto in ('AHO','CTE')
      order by mm_secuencia,mm_sub_secuencia
      if @@rowcount = 0
        break

      select @w_sum_reversados = @w_sum_reversados + @w_mm_valor

      set rowcount 0

      if @w_mm_moneda = @w_moneda_base
        select @w_mm_valor_ext = 0

      exec @w_return=sp_aplica_mov
           @s_ssn  = @s_ssn, @s_user = @s_user,
           @s_ofi = @s_ofi, @s_date = @s_date,
           @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
           @t_from = @w_sp_name, @t_debug = @t_debug,
           @t_trn = @w_tran_ape, @i_tipo = 'R',
           @i_operacionpf = @w_operacionpf,@i_secuencia = 0,
           @i_sub_secuencia= @w_mm_sub_secuencia
      if @w_return <> 0
      begin
        exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                    @t_from=@w_sp_name,   @i_num = @w_return
        return 1
      end
   end */ -- Para que todo lo por devolver se vaya a SUSPAG

    /* FIN DE PROCESO PARA REVERSAR LOS MOVIMIENTOS DE DEBITOS  */

   select @w_mm_sub_secuencia = 0

   select @w_tipo      = 'R',
          @w_imprime   = 'N',
          @w_estado    = 'CAN',@w_problema = 'S',
          @w_monto_dif = @w_monto_pg_int - @w_sum_monto_problema - @w_sum_reversados,
          @w_monto_cap = @w_monto_pg_int - @w_valor_tran

   select @w_monto_dif = round(@w_monto_dif, @w_numdeci)

      select @w_monto_cap = round(@w_monto_cap, @w_numdeci)

   /** GENERAR EL MOVIMIENTO DE DEVOLUCION DEL RESTO**/

   /** GENERAR EL MOVIMIENTO DE DEVOLUCION DEL RESTO**/
   if @w_monto_dif > 0
   begin
            insert pf_mov_monet(mm_operacion, mm_tran, mm_secuencia,
                 mm_secuencial, mm_sub_secuencia, mm_producto, mm_cuenta, mm_valor,
                      mm_fecha_crea, mm_fecha_mod, mm_tipo,mm_moneda,mm_estado,
                 mm_beneficiario,mm_fecha_aplicacion,mm_user,mm_usuario )
               values(@w_operacionpf, @t_trn, @w_mon_sgte,
                      0, 1, @w_forma_pago, @w_num_banco, @w_monto_dif,
                      @s_date, NULL, 'C',@w_moneda_pg,NULL,@w_ente,null, @s_user,
                      @s_user)
            if @@error <> 0
            begin
                 rollback tran
                 return 143022
            end

            select @w_secuencia = @w_mon_sgte

            select @w_beneficiario = en_nomlar
            from   cobis..cl_ente
            where  en_ente = @w_ente

                  exec @w_return=sp_aplica_mov
                @s_ssn  = @s_ssn, @s_user = @s_user,
                @s_ofi = @s_ofi, @s_date = @s_date,
                @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
                @t_from = @w_sp_name, @t_debug = @t_debug,
                @t_trn = @t_trn, @i_operacionpf = @w_operacionpf,
                @i_fecha_proceso = @w_fecha_hoy ,
                @i_secuencia = @w_mon_sgte ,
                 @i_tipo = 'N',
                @i_sub_secuencia= 1,
                @i_en_linea = @i_en_linea,
                @i_emite_orden ='S',
                @i_benefi = @w_beneficiario
            if @w_return <> 0
            begin
               rollback tran
               return @w_return
            end

           select @w_mon_sgte= @w_mon_sgte +1
   end  --monto_dif > 0

   /**Actualizo el estado de los registros de problema **/
      update pf_mov_monet_prob
      set pr_estado= 'A'
        where pr_secuencia = 0
          and pr_operacion = @w_operacionpf
         if @@error <> 0
      begin
          rollback tran
            return 145001
      end

        --CVA Ene-10-06 para que reverso la provision calculada
   if @w_estado_ant = 'ACT'
      select @w_tipo = 'C'

end
else /*El deposito debe ser activado no tuvo problemas*/
begin
   /** El deposito no tuvo problemas **/
   select @w_tipo            = 'C',
          @w_estado          = 'ACT',
          @w_problema           = 'N',
          @w_imprime         = 'S'

end /* fin del begin else */



select
   @w_producto   = op_producto ,
   @w_num_banco  = op_num_banco,
   @w_oficina    = op_oficina ,
   @w_toperacion = op_toperacion,
   @w_tplazo     = op_tipo_plazo,
   @w_dia_pago   = op_dia_pago
from pf_operacion
where op_operacion = @w_operacionpf

if @w_anio_comercial = 'N'  --04/04/2000 Fecha Comercial
   select @w_fecha_ven = dateadd(dd,@w_num_dias,@w_fecha_temp_hoy)
else
begin  --04/04/2000 Fecha Comercial
   exec sp_funcion_1
      @i_operacion = 'SUMDIA',
      @i_fechai    = @w_fecha_temp_hoy,
      @i_dias      = @w_num_dias,
      @i_dia_pago  = @w_dia_pago, --*-*
      @o_fecha     = @w_fecha_ven out
end --04/04/2000 Fecha Comercial

select @w_dia_pago = datepart(dd,@s_date)

-- if  @w_op_dias_reales = 'S'                                      GAL 14/SEP/2009 - RVVUNICA
-- begin
   exec sp_estima_int
      @i_fecha_inicio    = @w_fecha_temp_hoy,
      @s_ofi             = @s_ofi,
      @i_fecha_final     = @w_fecha_ven,
      @i_monto           = @w_monto_pg_int,
      @i_tasa            = @w_tasa1,
      @i_tcapitalizacion = @w_tcapitalizacion,
      @i_fpago           = @w_fpago,
      @i_ppago           = @w_ppago,
      @i_dias_anio       = @w_base_calculo,
      @i_dia_pago        = @w_dia_pago,
      @i_batch           = 'S',
      @i_ente            = @w_ente,
      @i_moneda          = @w_moneda_pg,
      @i_dias_reales     = @w_op_dias_reales,
      @o_fecha_prox_pg   = @w_fecha_pg_int out,
      @o_int_pg_pp       = @w_int_estimado out,
      @o_int_pg_ve       = @w_total_int_estimado out
/*end                                                                      GAL 14/SEP/2009 - RVVUNICA
else
begin  --04/04/2000 Fecha Comercial
   exec sp_estima_int_com
      @i_fecha_inicio    = @w_fecha_temp_hoy,
      @s_ofi             = @s_ofi,
      @i_fecha_final     = @w_fecha_ven,
      @i_monto           = @w_monto_pg_int,
      @i_tasa            = @w_tasa1,
      @i_tcapitalizacion = @w_tcapitalizacion,
      @i_fpago           = @w_fpago,
      @i_ppago           = @w_ppago,
      @i_dias_anio       = @w_base_calculo,
      @i_dia_pago        = @w_dia_pago,
      @i_batch           = 1,
      @i_num_dias        = @w_num_dias, --04/04/2000 Fecha Comercial
      @i_ente            = @w_ente,   -- GES 09/12/01 CUZ-031-029
      @o_fecha_prox_pg   = @w_fecha_pg_int out,
      @o_int_pg_pp       = @w_int_estimado out,
      @o_int_pg_ve       = @w_total_int_estimado out
end --04/04/2000 Fecha Comercial
*/

/* PAGO INTERESES SI ES TIPO ANTICIPADO -*/
select @w_impuesto = 0

if @w_estado = 'ACT' and @w_fpago = 'ANT'
 begin
    if @w_retienimp = 'S'
    begin
       select @w_tasa = pa_float
           from cobis..cl_parametro
       where pa_producto = 'PFI'
         and pa_nemonico = 'IMP'

       select @w_impuesto = @w_tasa * @w_total_int_estimado / 100
    end

    if @w_renova_todo = 'N'
    begin
          select @w_contor=1,
                 @w_pt_secuencia    = 0 ,
              @w_total_pagar = @w_total_int_estimado - @w_impuesto

         select @w_total_pagar_pg = @w_total_pagar * @w_factor,
              @w_impuesto_pg = @w_impuesto * @w_factor

          while 2=2
       begin
         set rowcount 1
         select @w_pt_beneficiario = dp_ente,
                 @w_pt_forma_pago = dp_forma_pago,
                 @w_pt_cuenta = dp_cuenta,
                 @w_pt_secuencia = dp_secuencia,
                 @w_pt_monto = dp_monto,
                 @w_pt_porcentaje = dp_porcentaje
       from pf_det_pago
       where dp_operacion = @w_operacionpf
         and dp_secuencia > @w_pt_secuencia
         and dp_tipo = 'INT'
         and dp_estado_xren='N'
       order by dp_tipo,dp_secuencia

         if @@rowcount = 0
            break

         set rowcount 0

         if @w_pt_monto is null
         begin
         select @w_monto_mov = @w_pt_porcentaje*@w_total_pagar_pg/100
           select @w_imp = @w_pt_porcentaje*@w_impuesto_pg/100
         end
         else
         begin
         select @w_monto_mov = @w_pt_monto
           select @w_imp=(@w_pt_monto*@w_impuesto_pg)/@w_total_pagar_pg
         end

         select @w_monto_mov = round(@w_monto_mov,@w_numdeci)

         select @w_imp = round(@w_imp,@w_numdeci)


            exec @w_return=sp_debita_int
                 @s_ssn  = @s_ssn, @s_user = @s_user,
                 @s_ofi = @s_ofi, @s_date = @s_date,
            @s_term = @s_term,
                 @s_srv = @s_srv, @t_debug = @t_debug,
                 @t_trn = 14905, @i_secuencia  = @w_mon_sgte,
                 @i_sub_secuencia = @w_contor,
            @i_num_banco  = @i_num_banco,
                 @i_monto = @w_monto_mov,
                 @i_moneda = @w_moneda_pg,
            @i_producto = @w_pt_forma_pago,
                 @i_fecha_proceso = @w_fecha_hoy,
                 @i_cuenta = @w_pt_cuenta,
                 @i_en_linea = @i_en_linea,
            @i_beneficiario = @w_pt_beneficiario,
            @i_pago_anticipado = 'S',
            @i_capital='N',@i_normal='S',
            @i_impuesto=@w_imp,
            @i_tot_impuesto=@w_imp, -- xca 04/15/98
            @i_tot_monto=@w_monto_mov, -- xca 04/15/98
            @i_tasa1=@w_tasa1 --xca --xca 04/15/98
            if @w_return <> 0
            begin
              rollback tran
              return @w_return
            end

          select @w_contor = @w_contor + 1
          end /* END WHILE 2 */
        select @w_mon_sgte=@w_mon_sgte + 1
     end
      else
          select @w_total_int_acumulado = @w_total_int_estimado - @w_impuesto
  end /* Anticipado    */


if @w_estado = 'ACT' or @w_estado = 'XACT'      --LIM 01/NOV/2005
    begin
      /*****  GENERACION DE VUELTO  *****/
      select @w_pt_secuencia   =0, @w_sub_sec=0
      while 3=3
      begin
        set rowcount 1
        select  @w_pt_beneficiario = dp_ente,
                @w_pt_forma_pago = dp_forma_pago,
                @w_pt_cuenta = dp_cuenta,
                @w_pt_secuencia = dp_secuencia,
                @w_pt_monto = dp_monto,
                @w_pt_porcentaje = dp_porcentaje
        from pf_det_pago
        where dp_operacion = @w_operacionpf
          and dp_secuencia > @w_pt_secuencia
          and dp_tipo = 'VUL'
          and dp_estado_xren='N'
        order by dp_tipo,dp_secuencia

        if @@rowcount = 0
          break

        select @w_vuelto = 'S'
        select @w_sub_sec=@w_sub_sec + 1
        select @w_pt_mont = round(@w_pt_monto, @w_numdeci)

        select  @w_beneficiario = en_nomlar
        from    cobis..cl_ente
        where   en_ente = @w_pt_beneficiario

        /***** JSA >>> 21/08/2001 >>> DP000078 ***/
        insert pf_mov_monet ( mm_operacion, mm_tran, mm_secuencia,
           mm_sub_secuencia, mm_producto, mm_cuenta, mm_valor, mm_valor_ext,
           mm_impuesto,
           mm_fecha_crea, mm_fecha_mod,mm_tipo,mm_secuencial,mm_beneficiario,
           mm_moneda,mm_estado,mm_fecha_aplicacion, mm_user,mm_usuario)
        values ( @w_operacionpf, 14928, @w_mon_sgte,
           @w_sub_sec, @w_pt_forma_pago, @w_pt_cuenta,  @w_pt_mont,@w_pt_mont,0,
           @s_date, @s_date,'C',0,@w_pt_beneficiario,@w_moneda_pg,null,null, @s_user,@s_user)

        if @@error <> 0
        begin
          rollback tran
          return 145000
        end

        exec @w_return=sp_aplica_mov
             @s_ssn  = @s_ssn, @s_user = @s_user,
             @s_ofi = @s_ofi, @s_date = @s_date,
             @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
             @t_from = @w_sp_name, @t_debug = @t_debug,
             @t_trn = 14928, @i_operacionpf = @w_operacionpf,
             @i_fecha_proceso = @w_fecha_hoy,
             @i_secuencia = @w_mon_sgte,
             @i_tipo = 'N',
             @i_benefi = @w_beneficiario,
             @i_sub_secuencia= @w_sub_sec, @i_capital='S',@i_normal='S'

        if @w_return <> 0
        begin
          print 'error luego de aplicamov'
          rollback tran
          return @w_return
        end

      end  /* while 3 */
    end /* generacion de vuelto para activo */

    /****** GENERO EL PAGO CUANDO ES ACTIVACION POR RENOVACION  *******/
    if @w_operacion = 'R' and (@w_estado = 'ACT' or @w_estado = 'XACT')       --LIM 01/NOV/2005
    begin
      select @w_mon_sgte = @w_mon_sgte+1
      select @w_pt_secuencia   =0,
              @w_sub_sec = 1

      while 3=3
      begin
        set rowcount 1
        select @w_pt_beneficiario = dp_ente,
               @w_pt_forma_pago = dp_forma_pago,
               @w_pt_cuenta = dp_cuenta,
               @w_pt_secuencia = dp_secuencia,
               @w_pt_monto = dp_monto,
               @w_pt_porcentaje = dp_porcentaje
        from pf_det_pago
        where dp_operacion = @w_operacionpf
          and dp_secuencia > @w_pt_secuencia
          and dp_tipo = 'REN'
          and dp_estado_xren='N'
        order by dp_secuencia
   if @@rowcount = 0
          break

        set rowcount 0

        select @w_pt_mont = round(@w_pt_monto, @w_numdeci_pg)

        /***** JSA >>> 21/08/2001 >>> DP000078 ***/
        insert pf_mov_monet ( mm_operacion, mm_tran, mm_secuencia,
                  mm_sub_secuencia, mm_producto, mm_cuenta, mm_valor,mm_valor_ext,
                    mm_impuesto,
                    mm_fecha_crea, mm_fecha_mod,mm_tipo,mm_secuencial,mm_beneficiario,
                  mm_moneda,mm_estado,mm_fecha_aplicacion, mm_user, mm_usuario)
           values ( @w_operacionpf, 14919, @w_mon_sgte,
               @w_sub_sec, @w_pt_forma_pago, @w_pt_cuenta,  @w_pt_mont,@w_pt_mont,0,
               @s_date, @s_date,'C',0,@w_pt_beneficiario,@w_moneda_pg,null,null, @s_user,@s_user)
        if @@error <> 0
        begin
          rollback tran
          return 143020
        end

        select @w_secuencia_ren = @w_mon_sgte

        exec @w_return=sp_aplica_mov
            @s_ssn  = @s_ssn, @s_user = @s_user,
            @s_ofi = @s_ofi, @s_date = @s_date,
            @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
            @t_from = @w_sp_name, @t_debug = @t_debug,
            @t_trn = 14919, @i_operacionpf = @w_operacionpf,
            @i_fecha_proceso = @w_fecha_hoy,
            @i_secuencia = @w_mon_sgte,
            @i_tipo = 'N',
            @i_sub_secuencia= @w_sub_sec
        if @w_return <> 0
        begin
          rollback tran
          return @w_return
        end
        select @w_sub_sec=@w_sub_sec + 1
      end  /* while 3 */

      /*DGU comentado por prueba de migracion  */
      if @w_sub_sec > 1 --Contabiliza el pago si existe movimiento
      begin
         select   @w_codval = '36',    --cambia tipo de dato a varchar
         @w_movmonet = '5',
                @w_descripcion='PAGO POR RENOVACION DE DPF ('+ @w_num_banco + ')'

         select @w_fecha = convert(datetime,convert(varchar,@s_date,101))
      end  -- if @w_sub_sec
    end /* @w_operacion = 'R' and @w_estado = 'ACT' */


    /*****************************************************************************/
    /******       CONTABILIZACION DE ACTIVACION O ANULACION       *******/
    /*****************************************************************************/
    select @w_trn = @t_trn
    if @w_problema = 'N'
    begin
      if @w_vuelto = 'S'
         select   @w_codval = '14',    --cambia tipo de dato a varchar
      @w_movmonet = '2'
      else
         select   @w_codval = '1',  --cambia tipo de dato a varchar
         @w_movmonet = '1'

      select @w_descripcion='CONFIRMACION DE ACTIVACION ('+@w_num_banco+')'
    end
    else
       select  @w_codval   = '14',  --cambia tipo de dato a varchar
         @w_movmonet    = '2',
                  @w_descripcion='CANCELACION X CHEQUE PROTESTADO ('+ @w_num_banco + ')'

    /***** PROCESO PARA TOMAR EL TOTAL DEL VUELTO EN EL CASO *****/
    /***** DE QUE HAYA MAS DE UNA FORMA DE PAGO PARA VUELTO  *****/
    select  @w_tot_pt_monto = sum(dp_monto)
    from pf_det_pago
    where dp_operacion = @w_operacionpf
      and dp_tipo = 'VUL'
      and dp_estado_xren='N'
    -- order by dp_secuencia

    if @w_vuelto = 'S'
      select @w_valor_tot_tran = @w_valor_tot_tran - @w_tot_pt_monto

    /***** FIN PROCESO PARA TOMAR EL TOTAL DEL VUELTO *****/
    /* CONTABILIZACION */

   if isnull(@w_total_int, 0) <> 0 begin
      /* PRIMERO CONTABILIZO EL REVERSO DE LA CAUSACION DE INTERESES */
      select @w_descripcion = 'REVERSA CAUSACION DE INTERESES'
   
      exec @w_return = cob_pfijo..sp_aplica_conta
      @s_date              = @s_date,
      @s_user              = @s_user,
      @s_term              = @s_term,
      @s_ofi               = @w_oficina,
      @i_fecha             = @s_date,
      @i_tran              = 14926,
      @i_operacionpf       = @w_operacionpf,
      @i_afectacion        = 'R',      /* N=Normal,  R=Reverso  */
      @i_descripcion       = @w_descripcion,
      @i_secuencia         = @w_mon_sgte,
      @i_oficina_oper      = @w_oficina,        /* op_oficina de pf_operacion */
      @i_valor             = @w_total_int      --VALOR INTERESES
   
      if @w_return <> 0
      begin
         rollback tran
         return 143041
      end
   end
   
   /* APLICO LA CANCELACION POR CHEQUE DEVUELTO */
   select @w_descripcion = 'CANCELACION POR CHEQUE DEVUELTO'
   
   exec @w_return = cob_pfijo..sp_aplica_conta
   @s_date              = @s_date,
   @s_user              = @s_user,
   @s_term              = @s_term,
   @s_ofi               = @w_oficina,
   @i_fecha             = @s_date,
   @i_tran              = @w_trn,
   @i_operacionpf       = @w_operacionpf,
   @i_afectacion        = 'N',      /* N=Normal,  R=Reverso  */
   @i_descripcion       = @w_descripcion,
   @i_secuencia         = @w_secuencia,
   @i_oficina_oper      = @w_oficina,        /* op_oficina de pf_operacion */
   @i_oficina           = @s_ofi,
   @i_monto_problema    = @w_sum_monto_problema,
   @i_monto             = @w_monto_pg_int   --VALOR CAPITAL

   if @w_return <> 0
   begin
      rollback tran
      return 143041
   end


    /* DGU comentado por prueba de migracion */
     if @w_sub_sec > 0
      select @w_mon_sgte=@w_mon_sgte+1

     if @w_estado ='ACT'
        if @w_fpago = 'ANT'
           select @w_total_int_pagado=@w_total_int_estimado

    /***** ACTUALIZACION DE LA OPERACION *******/
    update pf_operacion
    set op_estado          = @w_estado,
       op_imprime       = @w_imprime,
       op_total_int_acumulado    = round(@w_total_int_acumulado ,@w_numdeci),
       op_mon_sgte      = @w_mon_sgte,
       op_total_int_retenido  =  round(@w_impuesto,@w_numdeci),
       op_int_pagados      = round(@w_total_int_pagado,@w_numdeci),
       op_int_ganado    = op_int_ganado - round(@w_total_int_pagado,@w_numdeci),       op_total_int_pagados= round(@w_total_int_pagado,@w_numdeci),
       op_int_estimado     = round(@w_int_estimado,@w_numdeci),
       op_total_int_estimado  = round(@w_total_int_estimado, @w_numdeci),
       op_historia         = @w_historia,
       op_fecha_ven        = @w_fecha_ven,
       op_fecha_mod        = convert(datetime,convert(varchar,@s_date,101)),
       op_fecha_valor      = convert(datetime,convert(varchar,@w_fecha_temp_hoy,101)),
       op_fecha_ult_pg_int    =convert(datetime,convert(varchar, @w_fecha_pg_int,101)),
       op_ult_fecha_calculo   = '01/01/1900',
       op_causa_mod        = 'CACT',
       op_fecha_cancela    = @s_date -- GES 04/15/1999 Graba fecha de cancelacion
    where op_operacion = @w_operacionpf
    if @@error <> 0
    begin
      rollback tran
      return 145001
    end

    /**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/
    insert ts_operacion (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, fecha, num_banco,mon_sgte,
       operacion,  historia, estado, fecha_mod,imprime, causa_mod)
    values (@s_ssn, @t_trn,'P',
       @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_num_banco,@v_mon_sgte,
       @w_operacionpf,  @v_historia, @v_estado, @v_fecha_mod,'N', @v_causa_mod)
    if @@error <> 0
    begin
      rollback tran
      return 143005
    end

    /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/
    insert ts_operacion (secuencial, tipo_transaccion, clase,
         usuario, terminal, srv, lsrv, fecha, num_banco,mon_sgte,
         operacion,  historia, estado, fecha_mod,imprime, causa_mod)
         -- GES 05/12/99 Se envia el numero de sesion
         --             values (@w_s_ssn, @t_trn,'A',
    values (@s_ssn, @t_trn,'A',
         @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_num_banco,@w_mon_sgte,
         @w_operacionpf, @w_historia, @w_estado,@s_date,@w_imprime, 'CACT')

    if @@error <> 0
    begin
       rollback tran
       return 143005
    end

    /**  INSERCION HISTORICO **/
    insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
         hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
         hi_observacion, hi_fecha_crea, hi_fecha_mod)
    values (@w_operacionpf, @v_historia,@s_date,
         @t_trn,@w_monto_pg_int, @s_user, @s_ofi,
         @i_observacion, @s_date,@s_date)
    if @@error <> 0
    begin
      rollback tran
       return 143006
    end

    /** Ejecucion de pago de intereses para la operacion a la fecha de hoy **/

    /** Provisiono los intereses cuando es fecha retroactiva **/
     /*if @w_tipo = 'C'
     begin
       if @w_anio_comercial ='N'
       begin
          select @w_dias = datediff(dd,@w_fecha_temp_hoy,@w_fecha_hoy)
       end
       else
       begin
          exec sp_funcion_1 @i_operacion = 'DIFE30',
         @i_fechai   = @w_fecha_temp_hoy,
         @i_fechaf   = @w_fecha_hoy,
         @i_dia_pago = @w_dia_pago, --*-*
         @o_dias     = @w_dias out

       end
       if @w_dias > 0
       begin
              exec @w_return = sp_calc_diario_int
                      @s_ssn    = @s_ssn, @s_user   = @s_user,
                      @s_ofi    = @s_ofi, @s_date   = @s_date,
                      @s_srv    = @s_srv, @s_lsrv   = @s_lsrv,
                      @s_term   = @s_term,@s_rol    = @s_rol,
                      @t_debug  = @t_debug,@t_file   = @t_file,
                      @t_from   = @t_from,@t_trn    = 14926,
                      @i_fecha_proceso = @w_fecha_temp_hoy, @i_num_banco    = @i_num_banco ,
                      @i_tipo_act     = 'R',
                 @i_dias_interes = @w_dias
            if @w_return <> 0
              begin
                rollback tran
                return 149015
              end
       end
     end*/

if @i_en_linea = 'S' commit tran


return 0

go
