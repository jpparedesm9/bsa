/************************************************************************/
/*      Archivo:                b_opeben.sp                             */
/*      Stored procedure:       sp_busca_ope_benef                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Olimpia Pancha                          */
/*      Fecha de documentacion: 19-May-2005                             */
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
/*      Stored Procedure que muestra informaci=n de consultas de        */
/*      oficios con workflow                                            */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      19-May-2005     Olimpia Pancha     Emision Inicial              */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_busca_ope_benef')
   drop proc sp_busca_ope_benef
go
create proc sp_busca_ope_benef(
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
@t_trn                  smallint,
@i_cedula_cliente       int             = NULL
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               tinyint
       
select @w_sp_name = 'sp_busca_ope_benef'


/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14558
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018
   return 1
end

/*----------------------------------*/
/*  Obtencion de la Informacion     */
/*----------------------------------*/


  Select 'No Inversi¢n' = op_num_banco,
         'No Cliente' =  op_ente,
         'Estado' = op_estado,
         'Capital Disponible' = (op_monto - op_monto_blq - op_monto_pgdo - op_monto_blqlegal),
         'Fecha Apertura' = op_fecha_valor,
         'Fecha Vencimiento'= op_fecha_ven,
         'Tasa Interes' = op_tasa,
         'Total Inversi¢n' = op_monto, 
         'Total Interes Pagado' = op_total_int_pagados,
         'Interes por pagar' = (op_total_int_estimado - op_total_int_pagados)
       
  from cobis..cl_ente,
       cob_pfijo..pf_operacion,
       cob_pfijo.. pf_beneficiario

  where en_ced_ruc = @i_cedula_cliente
    and op_ente = en_ente
    and op_ente = be_ente
    and be_estado = 'I'
    and op_estado = 'ACT'
    and be_tipo = 'T'
  order by op_operacion  


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

