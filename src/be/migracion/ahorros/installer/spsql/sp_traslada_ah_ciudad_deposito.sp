/************************************************************************/
/*  Archivo:              sp_traslada_ah_ciudad_deposito.sp             */
/*  Stored procedure:     sp_traslada_ah_ciudad_deposito                */
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
/*                      PROPOSITO                                       */
/* Realiza el traspaso de las tablas MIGs a las tablas definitivas      */
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_ah_ciudad_deposito')
    drop proc sp_traslada_ah_ciudad_deposito
go

create proc sp_traslada_ah_ciudad_deposito(
    @i_clave_i  int  = null,
    @i_clave_f  int  = null
)
as
declare @w_conteo   int

select @i_clave_i = @i_clave_i + 1

select @w_conteo = count(1)
from   ah_ciudad_deposito_mig
where  cd_cuenta between @i_clave_i and @i_clave_f
and    cd_estado_mig = 'VE'

if @w_conteo = 0  return 0

-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------
insert into cob_ahorros..ah_ciudad_deposito
      (cd_cuenta,        cd_ciudad,        cd_fecha_depo,   cd_fecha_efe,     cd_valor,
       cd_valor_efe,     cd_efectivizado)
select nc_cuenta,        cd_ciudad,        cd_fecha_depo,   cd_fecha_efe,     cd_valor,
       cd_valor_efe,     cd_efectivizado
from   ah_ciudad_deposito_mig, ah_numero_cuenta
where  cd_cuenta = nc_cuenta_mig 
and    cd_cuenta between @i_clave_i and @i_clave_f
and    cd_estado_mig = 'VE'

if @@error <> 0
begin
    insert into ah_log_mig
    select top 1 convert(varchar, cd_cuenta),
           'ah_ciudad_deposito',
           'sp_traslada_ah_ciudad_deposito',
           'INS',
           convert(varchar, cd_cuenta),
           158,
           cd_cuenta,
           null
    from   cob_externos..ah_ciudad_deposito_mig
end

return  0
go
