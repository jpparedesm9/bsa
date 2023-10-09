/************************************************************************/
/*      Archivo:                conconf.sp                              */
/*      Stored procedure:       sp_consulta_confirma                    */
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
/*      Este script crea el procedimiento para las consultas de las     */
/*      transacciones contables por transaccion                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      23-Nov-94  Juan Lam           Creacion                          */
/*      04-Oct-05  Clotilde Vargas    Cambios en criterio renovacion    */
/*                                    Cambios en criterio confirmacion  */
/*                                    Cambios en criterio cancelacion   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_confirma' and type = 'P')
   drop proc sp_consulta_confirma
go

create proc sp_consulta_confirma (
   @s_ssn                  int             = NULL,
   @s_user                 login           = NULL,
   @s_ofi                  smallint        = NULL,
   @s_date                 datetime        = NULL,
   @s_srv                  varchar(30)     = NULL,
   @s_term                 varchar(30)     = NULL,
   @t_file                 varchar(10)     = NULL,
   @t_from                 varchar(32)     = NULL,
   @t_debug                char(1)         = 'N',
   @t_trn                  int,
   @i_fecha1               datetime        = NULL,
   @i_fecha2               datetime        = NULL,
   @i_tipo                 char(1),
   @i_num_banco            cuenta          = '0',
   @i_formato_fecha        int             = 0,
   @i_modo                 int             = 0,   --CVA Oct-4-05
   @i_fecha_sgte           datetime        = null --CVA Oct-4-05
 
)/*GESCY2K B210 */
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               tinyint,
        @w_fecha_mov            datetime

/** VARIABLES PARA PF_OPERACION **/

select @w_sp_name = 'sp_consulta_confirmacion'

/** DEBUG **/

if @t_trn <> 14811
begin
  exec cobis..sp_cerror 
   @t_debug=@t_debug,
   @t_file=@t_file,
        @t_from=@w_sp_name,   
   @i_num = 141043
  return 141043
end

set rowcount 20   

--CVA Oct-04-05 Correccion de criterio renovacion
if @i_tipo = 'R' /* renovaciones de operaciones */
begin

   if @i_modo = 0
   begin
      select distinct substring(a.or_num_banco,1,20) as or_num_banco,
                      td_descripcion,
                      a.or_tasa,
                      a.or_monto,
                      re_tasa,
                      (re_monto + re_incremento) as nuevo_monto, --CVA Oct-04-05
                      convert(varchar(10), re_fecha_mod, @i_formato_fecha) as re_fecha_mod_fmt,
                      re_fecha_mod
      into #renov_1
      from   pf_operacion_renov a, 
             pf_tipo_deposito,
             pf_renovacion, 
             pf_historia    
      where re_operacion_new                        = a.or_operacion
        and a.or_toperacion                         = td_mnemonico
        and re_operacion                            = a.or_operacion
        and re_estado                               = 'A'
        and hi_operacion                            = a.or_operacion   
        and hi_trn_code                             = 14104            
        and re_fecha_crea                           < re_fecha_mod     
        and datediff(dd, @i_fecha1, re_fecha_mod)  >= 0
        and datediff(dd, re_fecha_mod, @i_fecha2)  >= 0
        and a.or_num_banco                          > @i_num_banco
        and a.or_fecha_ult_renov                    = re_fecha_mod
      
      select 
         'No. de DPF'       = or_num_banco,
         'Tipo de DPF'      = td_descripcion,
         'Tasa'             = or_tasa,
         'Monto    '        = or_monto,
         'Nueva tasa'       = re_tasa,
         'Nuevo Monto'      = nuevo_monto,
         'Fecha Renovacion' = re_fecha_mod_fmt
      from #renov_1
      order by re_fecha_mod, or_num_banco
   end
   
   if @i_modo = 1
   begin
      select distinct substring(a.or_num_banco, 1, 20) as or_num_banco_corto,
                      td_descripcion,
                      a.or_tasa,
                      a.or_monto,
                      a.or_num_banco,
                      re_tasa,
                      (re_monto + re_incremento) as nuevo_monto, --CVA Oct-04-05
                      convert(varchar(10), re_fecha_mod, @i_formato_fecha) as re_fecha_mod_fmt,
                      re_fecha_mod
      into #renov_2
      from   pf_operacion_renov a, 
             pf_tipo_deposito,
             pf_renovacion, 
             pf_historia    
      where re_operacion_new                      = a.or_operacion
        and a.or_toperacion                       = td_mnemonico
        and re_operacion                          = a.or_operacion
        and re_estado                             = 'A'
        and hi_operacion                          = a.or_operacion   
        and hi_trn_code                           = 14104            
        and re_fecha_crea                         < re_fecha_mod     
        and datediff(dd,@i_fecha1,re_fecha_mod)  >= 0
        and datediff(dd,re_fecha_mod,@i_fecha2)  >= 0
        and ((    a.or_num_banco         > @i_num_banco
              and a.or_fecha_ult_renov   = @i_fecha_sgte 
              or  a.or_fecha_ult_renov   > @i_fecha_sgte))
        and a.or_fecha_ult_renov                  = re_fecha_mod
      
   
      select 
         'No. de DPF'       = or_num_banco_corto,
         'Tipo de DPF'      = td_descripcion,
         'Tasa'             = or_tasa,
         'Monto    '        = or_monto,
         'Nueva Operacion'  = or_num_banco,
         'Nueva tasa'       = re_tasa,
         'Nuevo Monto'      = nuevo_monto,
         'Fecha Renovacion' = re_fecha_mod_fmt
      from #renov_2
      order by re_fecha_mod, or_num_banco
   end
end
 
if @i_tipo = 'C' /* Cancelaciones de operaciones */ 
begin
   if @i_modo = 0
   begin
      select distinct substring(op_num_banco,1,20) as op_num_banco,
                      td_descripcion,
                      op_tasa,
                      op_monto,
                      op_estado,
                      convert(varchar(10),op_fecha_cancela, @i_formato_fecha) as op_fecha_cancela_fmt, /* GESCY2K B208*/ 
                      op_fecha_cancela
      into #canc_1
      from   pf_operacion, 
             pf_tipo_deposito,
             pf_cancelacion,
             pf_historia --GAR GB-DP00077
      where op_toperacion                            = td_mnemonico
        and ca_operacion                             = op_operacion
        and ca_estado                                = 'A'
        and op_estado                                = 'CAN'
        and hi_operacion                             = op_operacion     --GAR GB-DP00077
        and hi_trn_code                              = 14140            --GAR GB-DP00077
        and ca_fecha_crea                            < ca_fecha_mod     --GAR GB-DP00077
        and datediff(dd,@i_fecha1,op_fecha_cancela) >= 0
        and datediff(dd,op_fecha_cancela,@i_fecha2) >= 0
        and op_num_banco                             > @i_num_banco
      order by op_fecha_cancela, op_num_banco
      
      select
         'No. de DPF'        = op_num_banco,
         'Tipo de DPF'       = td_descripcion,
         'Tasa'              = op_tasa,
         'Monto    '         = op_monto,
         'Estado'            = op_estado,
         'Fecha Cancelacion' = op_fecha_cancela_fmt
      from #canc_1
      order by op_fecha_cancela, op_num_banco
   end
   
   if @i_modo = 1
   begin
      select distinct substring(op_num_banco,1,20) as op_num_banco,
                      td_descripcion,
                      op_tasa,
                      op_monto,
                      op_estado,
                      convert(varchar(10), op_fecha_cancela, @i_formato_fecha) as op_fecha_cancela_fmt, /* GESCY2K B208*/ 
                      op_fecha_cancela
      into #canc_2
      from   pf_operacion, 
             pf_tipo_deposito,
             pf_cancelacion,
             pf_historia --GAR GB-DP00077
      where op_toperacion                            = td_mnemonico
        and ca_operacion                             = op_operacion
        and ca_estado                                = 'A'
        and op_estado                                = 'CAN'
        and hi_operacion                             = op_operacion     --GAR GB-DP00077
        and hi_trn_code                              = 14140            --GAR GB-DP00077
        and ca_fecha_crea                            < ca_fecha_mod     --GAR GB-DP00077
        and datediff(dd,@i_fecha1,op_fecha_cancela) >= 0
        and datediff(dd,op_fecha_cancela,@i_fecha2) >= 0
        and ((    op_num_banco      > @i_num_banco
              and op_fecha_cancela  = @i_fecha_sgte 
              or  op_fecha_cancela  > @i_fecha_sgte))
      order by op_fecha_cancela, op_num_banco
      
      select
         'No. de DPF'        = op_num_banco,
         'Tipo de DPF'       = td_descripcion,
         'Tasa'              = op_tasa,
         'Monto    '         = op_monto,
         'Estado'            = op_estado,
         'Fecha Cancelacion' = op_fecha_cancela_fmt
      from #canc_2
      order by op_fecha_cancela, op_num_banco
   end

end

--CVA Oct-04-05 Correccion de criterio activacion
if @i_tipo = 'A' /* Activaciones de operaciones */
begin
   if @i_modo = 0
   begin
      select distinct substring(op_num_banco, 1, 20) as op_num_banco,
                      td_descripcion,
                      op_tasa,
                      op_monto,
                      convert(varchar(10), op_fecha_valor, @i_formato_fecha) as op_fecha_valor_fmt, /* GESCY2K B209 */
                      op_fecha_valor
      into #activ_1
      from pf_operacion, pf_tipo_deposito
      where op_toperacion                                    = td_mnemonico
        and op_estado                                        = 'ACT'
        and op_imprime                                       = 'S'
        and datediff(dd, op_fecha_ord_act, op_fecha_valor)  <> 0
        and datediff(dd, @i_fecha1, op_fecha_valor)         >= 0
        and datediff(dd, op_fecha_valor, @i_fecha2)         >= 0
        and op_num_banco                                     > @i_num_banco
      
      
      select 
         'No. de DPF'       = op_num_banco,
         'Tipo de DPF'      = td_descripcion,
         'Tasa'             = op_tasa,
         'Monto    '        = op_monto,
         'Fecha Activacion' = op_fecha_valor_fmt
      from #activ_1
      order by op_fecha_valor, op_num_banco
   end
   
   if @i_modo = 1
   begin
      select distinct substring(op_num_banco, 1, 20) as op_num_banco,
                      td_descripcion,
                      op_tasa,
                      op_monto,
                      convert(varchar(10), op_fecha_valor, @i_formato_fecha) as op_fecha_valor_fmt, /* GESCY2K B209 */
                      op_fecha_valor
      into #activ_2
      from pf_operacion, pf_tipo_deposito
      where op_toperacion                                  = td_mnemonico
        and op_estado                                      = 'ACT'
        and op_imprime                                     = 'S'
        and datediff(dd,op_fecha_ord_act,op_fecha_valor)  <> 0
        and datediff(dd,@i_fecha1,op_fecha_valor)         >= 0
        and datediff(dd,op_fecha_valor,@i_fecha2)         >= 0
        and ((    op_num_banco    > @i_num_banco
              and op_fecha_valor  = @i_fecha_sgte 
              or  op_fecha_valor  > @i_fecha_sgte))
      
      
      select 
         'No. de DPF'       = op_num_banco,
         'Tipo de DPF'      = td_descripcion,
         'Tasa'             = op_tasa,
         'Monto    '        = op_monto,
         'Fecha Activacion' = op_fecha_valor_fmt
      from #activ_2
      order by op_fecha_valor, op_num_banco
   end
end

return 0
go
