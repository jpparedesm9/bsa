/************************************************************************/
/*  Archivo               : icartera.sp                                 */
/*  Stored procedure      : sp_icartera                                 */
/*  Base de datos         : cob_interfase                               */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Alfredo Zuluaga                             */
/*  Fecha de documentacion: 29 de Noviembre de 2016                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa busca desacoplar el modulo de Credito con el modulo   */
/*  de plazo fijo                                                       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  29/Nov/2016    Alfredo Zuluaga    Emision Inicial DPF-H91368        */
/************************************************************************/

use cob_interfase
go

if exists (select 1 from sysobjects where  name = 'sp_icredito')
   drop proc sp_icredito
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

create proc sp_icredito (
       @s_ssn               int             = NULL,
       @s_date              datetime        = NULL,
       @s_term              varchar(30)     = NULL,
       @s_sesn              int             = NULL,
       @s_srv               varchar(30)     = NULL,
       @s_lsrv              varchar(30)     = NULL,
       @s_user              varchar(30)     = NULL,
       @s_ofi               smallint        = NULL,
       @s_rol               smallint        = NULL,
       @s_ssn_corr          int             = NULL,
       @s_org               char(1)         = NULL,
       @s_ssn_branch        int             = NULL,
       @t_debug             char(1)         = NULL,
       @t_file              varchar(14)     = NULL,
       @t_trn               smallint        = NULL,
       @t_corr              char(1)         = 'N', 
       @t_ssn_corr          int             = NULL, 
       @i_operacion         varchar(2)      = NULL,
       @i_tasa_ant          float           = NULL,
       @i_tasa_actual       float           = NULL,
       @i_num_operacion     varchar(24)     = NULL,
       @i_producto          int             = NULL,
       @i_modo              int             = NULL,
       @o_existe_credito    char(1)         = NULL OUT
) 
with encryption   
as

declare @w_error           int,
        @w_mensaje         varchar(255),
        @w_producto        int,
        @w_return          int,
        @w_sp_name         varchar(24),
        @w_sec             int,
        @w_cotizacion      float

select @w_sp_name = 'sp_icredito'

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from cobis..cl_producto 
where pd_producto = 21
  and pd_estado   = 'V'

if @w_producto = 0
begin
  /* MAPEO DE VARIBALES */
  select @o_existe_credito    = 'N' 
end

/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */

/*

if @w_producto > 0 
begin 
   
   select @o_existe_credito    = 'S'

   if @i_operacion = 'A'
   begin
      
      exec @w_return = cob_credito..sp_pignoracion_dpf
           @s_ssn            = @s_ssn, --CVA Abr-3-07
           @s_user           = @s_user,
           @s_term           = @s_term,
           @s_srv            = @s_srv,
           @s_ofi            = @s_ofi,
           @s_org            = @s_org,
           @s_lsrv           = @s_lsrv,
           @s_rol            = @s_rol,
           @s_date           = @s_date, 
           @i_modo           = @i_modo,
           @i_tasa_actual    = @i_tasa_actual,
           @i_tasa_ant       = @i_tasa_ant,
           @i_num_operacion  = @i_num_operacion,
           @i_producto       = @i_producto                               

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
end

*/

return 0

ERROR:

   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go