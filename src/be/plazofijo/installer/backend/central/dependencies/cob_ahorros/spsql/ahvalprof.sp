/************************************************************************/
/*      Archivo:                ahvalprof.sp                            */
/*      Stored procedure:       sp_val_prodofi                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Cuentas Ahorros                         */
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
/*      Validación de producto habilitado para oficina                  */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_val_prodofi')
   drop proc sp_val_prodofi
go

create proc sp_val_prodofi(
@i_modulo   tinyint,
@i_oficina  smallint
)as

select @i_modulo = @i_modulo
from   ve_version where 
ve_producto = @i_modulo and
ve_oficina  = @i_oficina

if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @i_num = 257077,
   @i_msg = 'APLICATIVO NO HABILITADO PARA LA OFICINA'
   return 257077
end
return 0
go
