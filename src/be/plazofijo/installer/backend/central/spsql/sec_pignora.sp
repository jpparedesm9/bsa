/************************************************************************/
/*      Archivo:                pf_spread_pignora.sp                    */
/*      Stored procedure:       sp_sec_pignora                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Clotilde Vargas                         */
/*      Fecha de documentacion: 12/Jul/06                               */
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
/*      Este script actualiza los secuenciales que se pusieron en nulos */
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

if exists (select 1 from sysobjects where name = 'sp_sec_pignora' and type = 'P')
   drop proc sp_sec_pignora
go
create proc sp_sec_pignora (
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = 'PRESRV',
@s_lsrv                 varchar(30)     = 'PRESRV',
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14921,
@i_fecha_proceso        datetime        = NULL)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               int,
@w_operacion            int,
@w_spread               float,
@w_cuenta               varchar(30),
@w_cuenta_gar           varchar(30),
@w_fecha_crea           datetime,
@w_valor                money,
@w_error                int,
@w_producto             catalogo,
@w_siguiente            int
                           
select @w_siguiente = 1


declare cursor_operacion cursor
for select  pi_operacion,
      pi_cuenta,
      pi_producto,
      pi_spread,
      pi_valor,
      pi_fecha_crea
      from pf_pignoracion
     where pi_fecha_crea >= '06/15/2006'
       and pi_spread is null
for read only  
open cursor_operacion
fetch cursor_operacion into 
   @w_operacion,  @w_cuenta,  @w_producto , @w_spread,   @w_valor, @w_fecha_crea

while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
     close cursor_operacion
     deallocate  cursor_operacion
     raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
     return 0
   end  

   select @w_siguiente = isnull(max(pi_spread),1)
   from pf_pignoracion
   where pi_operacion  = @w_operacion
   if @@rowcount = 0 
      select @w_siguiente = 1
   else
      select @w_siguiente = @w_siguiente + 1

   set rowcount 1

   print 'VA A ACTUALIZAR oper %1!, cta %2!, prod %3!, sec %4!'+' @w_operacion, @w_cuenta, @w_producto, @w_spread'

   update pf_pignoracion
      set pi_spread = @w_siguiente
   where pi_operacion = @w_operacion
     and pi_cuenta    = @w_cuenta
     and pi_producto  = @w_producto
     and pi_spread    = @w_spread

   set rowcount 0

   fetch cursor_operacion into 
   @w_operacion,  @w_cuenta,  @w_producto , @w_spread,   @w_valor, @w_fecha_crea
      
end /* fin del while de cursor operacion */

close cursor_operacion
deallocate  cursor_operacion    
return 0
go
