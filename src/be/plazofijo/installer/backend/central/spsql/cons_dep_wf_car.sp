/************************************************************************/
/*      Archivo:                consdepwfcar.sp                         */
/*      Stored procedure:       sp_cons_dep_wf_car                      */
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
/*      Busqueda de informacion del cliente en base a condiciones dadas */
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

if exists (select 1 from sysobjects where name = 'sp_cons_dep_wf_car')
   drop proc sp_cons_dep_wf_car
go

create proc sp_cons_dep_wf_car (
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
@i_cedula_cliente       numero          = NULL)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               int

select @w_sp_name = 'sp_cons_dep_wf_car'

/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/

if   @t_trn <> 14557
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
   'Nro de Cuenta'        = op_num_banco,
   'Tipo de Cuenta'       = 'DEPOSITO A PLAZO',
   'Saldo Disponible'     = (isnull(op_monto, 0) - isnull(op_monto_blq, 0) - isnull(op_monto_pgdo, 0) - isnull(op_monto_blqlegal, 0)),  
   'Oficial de la Cuenta' = op_oficial_principal,
   'Bloqueo'              = case 
                            when (isnull(op_monto_blq, 0) + isnull(op_monto_pgdo, 0) + isnull(op_monto_blqlegal, 0) = 0) then '0'
                            else '1'
                            end
from cobis..cl_ente,
    cob_pfijo..pf_beneficiario,
    cob_pfijo..pf_operacion     
where en_ente = be_ente
    and en_ente = op_ente
    and be_operacion = op_operacion 
    and op_toperacion not in ('409','453','509')
    and op_estado = 'ACT'
    and (isnull(op_monto, 0) - isnull(op_monto_blq, 0) - isnull(op_monto_pgdo, 0) - isnull(op_monto_blqlegal, 0)) > 0
    and en_ced_ruc = @i_cedula_cliente

go
