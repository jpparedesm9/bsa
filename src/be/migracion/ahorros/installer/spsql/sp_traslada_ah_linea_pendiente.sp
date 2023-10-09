/************************************************************************/
/*  Archivo:              sp_traslada_ah_linea_pendiente.sp             */
/*  Stored procedure:     sp_traslada_ah_linea_pendiente                */
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

if exists(select * from sysobjects where name = 'sp_traslada_ah_linea_pendiente')
    drop proc sp_traslada_ah_linea_pendiente
go

create proc sp_traslada_ah_linea_pendiente(
    @i_clave_i  int = null,
    @i_clave_f  int = null
)
as
declare @w_conteo int

select @i_clave_i = @i_clave_i + 1

select @w_conteo = count(1)
from   ah_linea_pendiente_mig
where  lp_cuenta between @i_clave_i and @i_clave_f
and    lp_estado_mig = 'VE'

if @w_conteo = 0 return 0

-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------
insert into cob_ahorros..ah_linea_pendiente 
      (lp_cuenta,     lp_linea,       lp_nemonico,    lp_valor,
       lp_fecha,      lp_control,     lp_signo,       lp_enviada)
select nc_cuenta,     lp_linea,       lp_nemonico,    lp_valor,
       lp_fecha ,     lp_control,     lp_signo,       lp_enviada
from   ah_linea_pendiente_mig, ah_numero_cuenta
where  lp_cuenta = nc_cuenta_mig 
and    lp_cuenta between @i_clave_i and @i_clave_f
and    lp_estado_mig = 'VE'

if @@error <> 0
begin
    insert into ah_log_mig
    select top 1 convert(varchar, lp_cuenta),
           'ah_linea_pendiente',
           'sp_traslada_ah_linea_pendiente',
           'INS',
           convert(varchar, lp_cuenta),
           204,
           lp_cuenta,
           null
    from   ah_linea_pendiente_mig
end

update cobis..cl_seqnos set siguiente = (select isnull(max(convert(int,lp_linea)),0) + 1 from cob_ahorros..ah_linea_pendiente)
where  bdatos = 'cob_ahorros'
and    tabla  = 'ah_linea_pendiente'

return  0
go
