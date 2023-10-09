/************************************************************************/
/*      Archivo:                conscuotas.sp                           */
/*      Stored procedure:       sp_consulta_cuotas                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Dolores Guerrero                        */
/*      Fecha de documentacion: 08/19/1997                              */
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
/*      Este script crea los procedimientos para la consulta de las     */
/*      cuotas de pago de los intereses especiales.                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      19-Ago-97  Romulo Marmolejo   Emision inicial                   */
/*      15-Mar-05  Katty Tamayo       Aumento fecha de inicio en base a */
/*                                    la fecha de pago y la fecha valor */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_cuotas')
   drop proc sp_consulta_cuotas
go

create proc sp_consulta_cuotas (
@s_ssn             int         = NULL,
@s_user            login       = NULL,
@s_term            varchar(30) = NULL,
@s_date            datetime    = NULL,
@s_srv             varchar(30) = NULL,
@s_lsrv            varchar(30) = NULL,
@s_ofi             smallint    = NULL,
@s_rol             smallint    = NULL,
@t_debug           char(1)     = 'N',
@t_file            varchar(10) = NULL,
@t_from            varchar(32) = NULL,
@t_trn             smallint    = NULL,
@i_formato_fecha   int         = 0,
@i_cuenta          cuenta,
@i_modo            smallint    = 0,
@i_retenido        char(1)     = '%',
@i_custodia        char(1)     = '%',
@i_cuota           tinyint     = NULL)
with encryption
as
declare
@w_sp_name         descripcion,
@w_return          tinyint,
@w_operacionpf     int    -- GES 04/23/01 CUZ-005-003

select @w_sp_name = 'sp_consulta_cuotas'

/**  VERIFICAR CODIGO DE TRANSACCION **/
/*Modificacion: Walter Solis  01/06/01  DP-00025-7 */
if @t_trn <> 14147  and @t_trn <> 14452
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141002
   return 1
end

if @i_cuenta  is null
begin
   print 'Operacion de plazo fijo no definida.'
   return 1
end

if not exists( select 1 from pf_operacion
                where op_num_banco = @i_cuenta )
begin
   print 'Operacion de plazo fijo no existe.'
   return 1
end

select @w_operacionpf = op_operacion
  from pf_operacion
 where op_num_banco = @i_cuenta   -- GES 04/23/01 CUZ-005-004

set rowcount 20
if @i_modo = 0
begin
   select /*Modificacion: Walter Solis  01/06/01  DP-00025-8 */
   '#PAGO '        = cu_cuota,
   '#PREIMPRESO'   = cu_preimpreso,
   'F.VENCIMIENTO' = convert(char(10),cu_fecha_pago,@i_formato_fecha),
   /* GESCY2K B243 */
   'VALOR'         = cu_valor_cuota,
   'F.CAJA'        = convert(char(10),cu_fecha_caja,@i_formato_fecha),
   'ESTADO'        = cu_estado,
   '#IMPRESIONES'  = cu_num_impr_orig,
   'RETENIDO'      = cu_retenido,
   'NUM. CUPON'    = cu_num_cupon,
   --cu_fecha_caja,
   'MONEDA'        = substring(mo_descripcion,1,7),  -- GES 10/25/01
   'VALOR NETO'    = cu_valor_neto,   -- WSM 12/06/01  DP-00024-23 
   'IMPUESTO'      = cu_retencion,     -- JSA 27/09/2001 
   'F.INICIO'      = convert(char(10),cu_fecha_ult_pago,@i_formato_fecha) -- CVA Nov-30-05
/*
          'F.INICIO'      = CASE 
                               WHEN op_fpago in ('PER','PRA') THEN
                                    case
                                       when dateadd(mm,pp_factor_en_meses*(-1) ,cu_fecha_pago) < op_fecha_valor then  convert(char(10),op_fecha_valor,@i_formato_fecha)
                                       else convert(char(10),dateadd(mm,pp_factor_en_meses*(-1),cu_fecha_pago),@i_formato_fecha)
                                    end
                               ELSE 
                                    convert(char(10),op_fecha_valor,@i_formato_fecha)
                               END
*/
   from pf_cuotas
   inner join cobis..cl_moneda on
      cu_moneda    = mo_moneda
      inner join pf_operacion on
         cu_operacion = op_operacion
         left outer join pf_ppago on
            op_ppago  = pp_codigo
   where cu_operacion = @w_operacionpf -- GES 04/23/01 CUZ-005-005      
end

if @i_modo = 1 
begin
   select /*Modificacion: Walter Solis  01/06/01  DP-00025-8 */
         '#PAGO '        = cu_cuota,
         '#PREIMPRESO'   = cu_preimpreso,
         'F.VENCIMIENTO' = convert(char(10),cu_fecha_pago,@i_formato_fecha),
         /* GESCY2K B243 */
         'VALOR'         = cu_valor_cuota,
         'F.CAJA'        = convert(char(10),cu_fecha_caja,@i_formato_fecha),
         'ESTADO'        = cu_estado,
         '#IMPRESIONES'  = cu_num_impr_orig,
         'RETENIDO'      = cu_retenido,
         'NUM. CUPON'    = cu_num_cupon,
         --cu_fecha_caja,
         'MONEDA'        = substring(mo_descripcion,1,7),  -- GES 10/25/01
         'VALOR NETO'    = cu_valor_neto,   -- WSM 12/06/01  DP-00024-23
         'IMPUESTO'      = cu_retencion,     -- JSA 27/09/2001
         'F.INICIO'      = convert(char(10),cu_fecha_ult_pago,@i_formato_fecha) -- CVA Nov-30-05
/*
          'F.INICIO'      = CASE 
                               WHEN op_fpago in ('PER','PRA') THEN
                                    case
                                       when dateadd(mm,pp_factor_en_meses*(-1) ,cu_fecha_pago) < op_fecha_valor then  convert(char(10),op_fecha_valor,@i_formato_fecha)
                                       else convert(char(10),dateadd(mm,pp_factor_en_meses*(-1),cu_fecha_pago),@i_formato_fecha)
                                    end
                               ELSE 
                                    convert(char(10),op_fecha_valor,@i_formato_fecha)
                               END
*/
   from pf_cuotas
   inner join cobis..cl_moneda on
      cu_moneda    = mo_moneda
      inner join pf_operacion on
         cu_operacion = op_operacion 
         left outer join pf_ppago on
            op_ppago     = pp_codigo
   where cu_operacion = 423  --@w_operacionpf -- GES 04/23/01 CUZ-005-005
   and cu_cuota     > 0 --@i_cuota     
end
   
set rowcount 0
return 0
go
