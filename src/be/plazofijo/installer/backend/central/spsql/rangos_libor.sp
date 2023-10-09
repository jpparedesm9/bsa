/************************************************************************/
/*      Archivo:                rangolibor.sp                           */
/*      Stored procedure:       sp_rangos_libor                         */
/*      Base de datos:          cobpfijo                                */
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
/*                              PROPOSITO                               */
/*      Funcion que valida rangos para operaciones vigentes con tasa    */
/*      libor descontinuados.                                           */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      24-Oct-94  Juan Lam           Creacion                          */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_rangos_libor')
   drop proc sp_rangos_libor 
go

create proc sp_rangos_libor(
@s_ssn			        int         = NULL,
@s_user			        login       = NULL,
@s_term			        varchar(30) = NULL,
@s_date			        datetime    = NULL,
@s_srv			        varchar(30) = NULL,
@s_lsrv			        varchar(30) = NULL, 
@s_rol			        smallint    = NULL,
@s_ofi			        smallint    = NULL,
@s_org_err		        char(1)     = NULL,
@s_error		        int         = NULL,
@s_sev			        tinyint     = NULL,
@s_msg			        descripcion = NULL,
@s_org			        char(1)     = NULL,
@t_debug		        char(1)     = 'N',
@t_file			        varchar(14) = NULL,
@t_from			        varchar(32) = NULL,
@t_trn			        int         = NULL,
@i_batch                char(1)     = 'N',
@i_operacion            int,
@o_monto_min	        money       = NULL out, 
@o_plazo_min	        smallint    = NULL out)
with encryption
as
declare
@w_toperacion           catalogo,
@w_op_operacion         int,
@w_plazo_min            smallint,       
@w_monto_min            money,
@w_sp_name              varchar(32),
@w_moneda               int,
@w_plazo                int


select @w_sp_name = 'sp_rangos_libor'

----------------------------------
-- Verificacion de Transaccion  --
----------------------------------
if @t_trn <> 14996 
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 1
end
--print 'OPERACION  %1! ',@i_operacion
select @w_op_operacion = op_operacion,
       @w_toperacion   = op_toperacion,
       @w_moneda       = op_moneda,
       @w_plazo        = op_num_dias       
from   pf_operacion
where  op_operacion = @i_operacion        

----------------------------------------------------------------------------
-- Proceso para validar renovacion/inst, ren de operaciones libor tipo xxxA
----------------------------------------------------------------------------
if ((datalength(@w_toperacion) > 3) and (substring(@w_toperacion,4,1) = 'A') )
begin
    select @w_toperacion = substring(@w_toperacion,1,3)

    select @w_plazo_min = min(pl_plazo_min)
    from   pf_tipo_deposito, pf_auxiliar_tip, pf_plazo
    where  ((datalength(td_mnemonico) > 3) and (substring(td_mnemonico,4,1) <> 'A') and (substring(td_mnemonico,1,3) = @w_toperacion))
      and  td_estado = 'A'
      and  td_tipo_tasa_var  = 'P'
      and  td_tipo_deposito  = at_tipo_deposito
      and  at_tipo in('PLA')
      and  at_moneda = @w_moneda
      and  at_estado = 'A'
      and  pl_mnemonico = at_valor

     select @w_monto_min = min(mo_monto_min)
     from pf_tipo_deposito, pf_monto, pf_auxiliar_tip
     where ((datalength(td_mnemonico) > 3) and (substring(td_mnemonico,4,1) <> 'A') and (substring(td_mnemonico,1,3) = @w_toperacion))
       and td_estado = 'A'
       and td_tipo_tasa_var  = 'P'
       and td_tipo_deposito  = at_tipo_deposito
       and at_tipo in('MOT')
       and at_moneda = @w_moneda 
       and at_estado = 'A'
       and mo_mnemonico = at_valor

       if @i_batch = 'S'
          select @o_plazo_min = @w_plazo_min, 
                 @o_monto_min = @w_monto_min
       else
          select @w_plazo_min, @w_monto_min
end

return
go