/************************************************************************/
/*      Archivo:                iconimp.sp                              */
/*      Stored procedure:       sp_icon_impuestos                       */
/*      Base de datos:          cob_interfase                           */
/*      Producto:               Cuentas Ahorros                         */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza las transacciones de:                     */
/*      Excencion y Porcentaje de Impuestos                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR           RAZON                                 */
/*  02/Ago/2016   J. Salazar      Porcentaje de Impuesto IRS            */
/************************************************************************/

use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_icon_impuestos')
  drop proc sp_icon_impuestos
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc sp_icon_impuestos(
   @t_debug         char(1)     = 'N',
   @t_file          varchar(14)     = null,
   @t_from          varchar(30)     = null,
   @t_show_version  bit         = 0,
   @i_empresa       tinyint     = 1,
   @i_concepto      char(4),
   @i_debcred       char(1),
   @i_monto         money,    
   @i_impuesto      char(1),
   @i_ciudad        int = null,
   @i_oforig_admin  int,
   @i_ofdest_admin  int,
   @i_ente          int,
   @i_producto      tinyint,
   @o_exento        char(1)     = 'N' out,
   @o_porcentaje    float       out
)
as 
declare
   @w_sp_name        varchar(32),
   @w_return         int,
   @w_codigo_pais    char(2),
   @w_costo_isr      char(1),
   @w_porcentaje_isr float

select @w_sp_name = 'sp_icon_impuestos'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

select @w_codigo_pais = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico = 'ABPAIS' 
   and pa_producto = 'ADM'

if @@rowcount = 0
begin
   /** No existe parametro de pais local **/
   exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 101190
   return 101190
end

if @w_codigo_pais = 'CO' -- Colombia
begin
   exec @w_return = cob_conta..sp_impuestos
        @i_empresa      = 1,
        @i_concepto     = @i_concepto,
        @i_debcred      = @i_debcred,
        @i_monto        = @i_monto,
        @i_impuesto     = @i_impuesto,
        @i_oforig_admin = @i_oforig_admin,
        @i_ofdest_admin = @i_ofdest_admin,
        @i_ente         = @i_ente,
        @i_producto     = @i_producto,
        @i_ciudad       = @i_ciudad,
        @o_exento       = @o_exento  out,
        @o_porcentaje   = @o_porcentaje out     
   if @w_return <> 0
      return @w_return 
end         
else
begin
   select @w_costo_isr = pa_char
     from cobis..cl_parametro 
    where pa_nemonico = 'CIISR' 
      and pa_producto = 'AHO'

   if @@rowcount <> 1
      select @o_exento = @o_exento,
             @o_porcentaje = @o_porcentaje
   else
      if @w_costo_isr = 'S'
         select @w_porcentaje_isr = pa_float 
           from cobis..cl_parametro 
          where pa_nemonico = 'PANISR' 
            and pa_producto = 'AHO'
   
         if @@rowcount <> 1
            select @o_exento = @o_exento,
                   @o_porcentaje = @o_porcentaje
         else
            select @o_exento = @o_exento,
                   @o_porcentaje = @w_porcentaje_isr   
end

return 0


GO

