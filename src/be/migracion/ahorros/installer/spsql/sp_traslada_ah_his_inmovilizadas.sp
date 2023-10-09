/************************************************************************/
/*  Archivo:              sp_traslada_ah_his_inmovilizadas.sp           */
/*  Stored procedure:     sp_traslada_ah_his_inmovilizadas              */
/*  Base de Datos:        cob_externos                                  */
/*  Producto:             AHORROS                                       */
/************************************************************************/
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/* Realiza el traspaso de las tablas MIGs a las tablas definitivas      */
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_ah_his_inmovilizadas')
    drop proc sp_traslada_ah_his_inmovilizadas
go

create proc sp_traslada_ah_his_inmovilizadas(
    @i_clave_i  int = null,
    @i_clave_f  int = null
)
as
declare  @w_conteo int

select @i_clave_i = @i_clave_i + 1
 
select @w_conteo = count(1)
from   ah_his_inmovilizadas_mig, ah_numero_cuenta 
where  hi_cuenta = nc_cta_banco_mig
and    nc_cuenta_mig between @i_clave_i and @i_clave_f
and    hi_estado_mig = 'VE'

if @w_conteo = 0   return 0

-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------
insert into cob_ahorros..ah_his_inmovilizadas
      (hi_cuenta   ,  hi_saldo,   hi_fecha)
select nc_cta_banco,  hi_saldo,   hi_fecha
from   ah_his_inmovilizadas_mig, ah_numero_cuenta
where  hi_cuenta = nc_cta_banco_mig 
and    nc_cuenta_mig between @i_clave_i and @i_clave_f
and    hi_estado_mig = 'VE'

if @@error <> 0
begin
   insert into ah_log_mig
   select top 1 convert(varchar, hi_cuenta),
          'ah_his_inmovilizadas',
          'sp_traslada_ah_his_inmovilizadas',
          'INS',
          convert(varchar, hi_cuenta),
          163,
          convert(int, hi_cuenta),
          hi_cuenta
   from   ah_his_inmovilizadas_mig

end

return  0
go
