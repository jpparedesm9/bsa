/************************************************************************/
/*   Archivo:             cco_ingopera.sp                               */
/*   Stored procedure:    sp_ing_opera                                  */
/*   Base de datos:       Contabilidad                                  */
/*   Producto:            Plazo Fijo                                    */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  19 de Julio de 2016                           */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA". Su uso no autorizado queda expresamente prohibido asi    */
/*   como cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Creacion Stored Procedure Cascara para instalacion de Plazo Fijo   */
/*   Version Davivienda                                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   19/Jul/2016        Oscar Saavedra    Instalador Version Davivienda */
/************************************************************************/
use cob_ccontable
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_ing_opera')
   drop proc sp_ing_opera
go

create proc sp_ing_opera(
@s_ssn                                     int              = null,
@s_date                                    datetime         = null,
@s_user                                    login            = null,
@s_term                                    descripcion      = null,
@s_corr                                    char(1)          = null,
@s_ssn_corr                                int              = null,
@s_ofi                                     smallint         = null,
@t_rty                                     char(1)          = null,
@t_trn                                     int              = null,
@t_debug                                   char(1)          = 'N',
@t_file                                    varchar(14)      = null,
@t_from                                    varchar(30)      = null,
@i_empresa                                 tinyint          = null,
@i_operacion                               char(1)          = null,
@i_producto                                tinyint          = null,
@i_fecha                                   datetime         = null,
@i_cuenta                                  cuenta_contable  = null,
@i_oficina                                 smallint         = null,
@i_area                                    smallint         = null,
@i_moneda                                  tinyint          = null,
@i_val_opera_mn                            money            = 0,
@i_val_opera_me                            money            = 0,
@i_val_conta_mn                            money            = 0,
@i_val_conta_me                            money            = 0,
@i_diferencia_mn                           money            = 0,
@i_diferencia_me                           money            = 0,
@i_tipo                                    char(1)          = null)
as
declare
@w_today                                   datetime,
@w_sp_name                                 varchar(32),
@w_cuenta                                  cuenta,
@w_moneda                                  tinyint,
@w_oficina                                 smallint,
@w_categoria                               char(1)

select @w_sp_name = 'sp_ing_opera'

if (@t_trn <> 60032 and @i_operacion = 'I') or
   (@t_trn <> 60033 and @i_operacion = 'D') begin
   return 6000009
end

if @i_operacion = 'I' begin
   select @w_oficina    = of_oficina
   from   cob_conta..cb_oficina
   where  of_empresa    = @i_empresa
   and    of_oficina    = @i_oficina
   and    of_movimiento = 'S'
   and    of_estado     = 'V'
   
   if @@rowcount = 0
      return 6000017
   
   select
   @w_moneda    = cu_moneda,
   @w_categoria = cu_categoria
   from  cob_conta..cb_cuenta
   where cu_empresa    = @i_empresa
   and   cu_cuenta     = @i_cuenta
   and   cu_movimiento = 'S'
   and   cu_estado     = 'V'
   
   if @@rowcount = 0
      return 6000011
   
   if @w_categoria = 'C' and @i_tipo <> 'P' begin
      select @i_val_opera_mn = @i_val_opera_mn  * (-1)
      select @i_val_opera_me = @i_val_opera_me  * (-1)
   end
   
   if @w_moneda <> @i_moneda
      return 6000018
   
   if exists (select 1 from cob_ccontable..cco_boc where bo_empresa = @i_empresa and bo_producto = @i_producto and bo_fecha = @i_fecha and bo_cuenta = @i_cuenta and bo_oficina = @i_oficina and bo_area = @i_area and bo_tipo = @i_tipo) begin
      update cob_ccontable..cco_boc
      set    bo_val_opera_mn  = bo_val_opera_mn  + @i_val_opera_mn,
             bo_val_opera_me  = bo_val_opera_me  + @i_val_opera_me,
             bo_val_conta_mn  = bo_val_conta_mn  + @i_val_conta_mn,
             bo_val_conta_me  = bo_val_conta_me  + @i_val_conta_me,
             bo_diferencia_mn = bo_diferencia_mn + @i_diferencia_mn,
             bo_diferencia_me = bo_diferencia_me + @i_diferencia_me
      where  bo_empresa       = @i_empresa
      and    bo_producto      = @i_producto
      and    bo_fecha         = @i_fecha
      and    bo_cuenta        = @i_cuenta
      and    bo_oficina       = @i_oficina
      and    bo_area          = @i_area
      and    bo_tipo          = @i_tipo
      
      if @@error <> 0
         return 6000015
   end
   else begin
      insert into cob_ccontable..cco_boc (
      bo_empresa,       bo_producto,       bo_fecha,          bo_cuenta,        bo_oficina,
      bo_area,          bo_moneda,         bo_val_opera_mn,   bo_val_opera_me,  bo_val_conta_mn,
      bo_val_conta_me,  bo_diferencia_mn,  bo_diferencia_me,  bo_tipo)
      values (
      @i_empresa,       @i_producto,       @i_fecha,          @i_cuenta,        @i_oficina,
      @i_area,          @i_moneda,         @i_val_opera_mn,   @i_val_opera_me,  @i_val_conta_mn,
      @i_val_conta_me,  @i_diferencia_mn,  @i_diferencia_me,  @i_tipo)
      
      if @@error <> 0 begin
         update cob_ccontable..cco_boc
         set    bo_val_opera_mn  = bo_val_opera_mn  + @i_val_opera_mn,
                bo_val_opera_me  = bo_val_opera_me  + @i_val_opera_me,
                bo_val_conta_mn  = bo_val_conta_mn  + @i_val_conta_mn,
                bo_val_conta_me  = bo_val_conta_me  + @i_val_conta_me,
                bo_diferencia_mn = bo_diferencia_mn + @i_diferencia_mn,
                bo_diferencia_me = bo_diferencia_me + @i_diferencia_me
         where  bo_empresa       = @i_empresa
         and    bo_producto      = @i_producto
         and    bo_fecha         = @i_fecha
         and    bo_cuenta        = @i_cuenta
         and    bo_oficina       = @i_oficina
         and    bo_area          = @i_area
         and    bo_tipo          = @i_tipo
      
         if @@error <> 0
          return 6000014
      end
   end
end


if @i_operacion = 'D' begin
   delete cob_ccontable..cco_boc
   where  bo_empresa  = @i_empresa
   and    bo_producto = @i_producto
   and    bo_fecha    = @i_fecha
   and    bo_tipo in ('S','M')

   if @@error <> 0
      return 6000013

   delete cob_ccontable..cco_boc_det
   where  bo_empresa  = @i_empresa
   and    bo_fecha    = @i_fecha
   and    bo_producto = @i_producto
   
   if @@error <> 0
      return 6000013
end

return 0
go
