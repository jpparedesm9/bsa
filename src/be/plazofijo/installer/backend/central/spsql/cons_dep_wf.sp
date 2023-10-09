/************************************************************************/
/*      Archivo:                consdepwf.sp                            */
/*      Stored procedure:       sp_cons_dep_wf                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Olimpia Pancha                          */
/*      Fecha de documentacion: 11-May-2005                             */
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
/*      Busqueda de informacion de depositos a plazo                    */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      11-May-2005  Olimpia Pancha     Emision Inicial.                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_dep_wf')
   drop proc sp_cons_dep_wf
go

create proc sp_cons_dep_wf (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_cedula_cliente       varchar(30)     = NULL)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               int

select @w_sp_name = 'sp_cons_dep_wf'

/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/

if   @t_trn <> 14556
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141018
  return 1
end


/*----------------------------------*/
/*  Obtencion de la Informacion     */
/*----------------------------------*/

select 
   'Nro de Depositos a Plazo'= op_num_banco,
   'Principal' = case be_rol
       when 'T' then 'S'
       else 'N'
       end,
   'Estado'= op_estado,
   'Saldo Capital' = (isnull(op_monto, 0) - isnull(op_monto_blq, 0) - isnull(op_monto_pgdo, 0) - isnull(op_monto_blqlegal, 0)),
   'Fecha de Apertura' = convert(char(10),op_fecha_valor,101),
   'Fecha de Vencimiento' = convert(char(10),op_fecha_ven,101),
   'Tasa de Interes' = isnull(op_tasa,0),
   'Total de Intereses Deposito' = isnull(op_total_int_ganados, 0),
   'Total de Intereses Pagados' = isnull(op_total_int_pagados,0),
   'Interes por Pagar' = (isnull(op_total_int_estimado, 0) - isnull(op_total_int_pagados,0))
   
from cobis..cl_ente,
     cob_pfijo..pf_beneficiario,
     cob_pfijo..pf_operacion     
where en_ente = be_ente
   and be_operacion = op_operacion 
   and op_estado in ('CAN', 'VEN','ACT')
   and en_ced_ruc = @i_cedula_cliente


if @@rowcount = 0
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141030  
  return 1
end
go
