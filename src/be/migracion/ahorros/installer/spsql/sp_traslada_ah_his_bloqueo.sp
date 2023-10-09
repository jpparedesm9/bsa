/************************************************************************/
/*  Archivo:                 sp_traslada_ah_his_bloqueo.sp              */
/*  Stored procedure:        sp_traslada_ah_his_bloqueo                 */
/*  Base de Datos:           cob_externos                               */
/*  Producto:                AHORROS                                    */
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

if exists(select * from sysobjects where name = 'sp_traslada_ah_his_bloqueo')
    drop proc sp_traslada_ah_his_bloqueo
go

create proc sp_traslada_ah_his_bloqueo(
    @i_clave_i  int = null,
    @i_clave_f  int = null
)
as
declare @w_conteo int

select @i_clave_i = @i_clave_i + 1
 
select @w_conteo = count(1)
from   ah_his_bloqueo_mig
where  hb_cuenta between @i_clave_i and @i_clave_f
and    hb_estado_mig = 'VE'

if @w_conteo = 0   return 0
   
-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------

 insert into cob_ahorros..ah_his_bloqueo
      (hb_cuenta,     hb_secuencial,        hb_valor,           hb_monto_bloq,      hb_fecha,           hb_fecha_ven,   
       hb_hora  ,     hb_autorizante,       hb_solicitante,     hb_oficina,         hb_causa,           hb_saldo,
       hb_accion,     hb_levantado,         hb_sec_asoc,        hb_observacion,     hb_ngarantia,       hb_nlinea_sob,
       hb_numcte)   
select nc_cuenta,     hb_secuencial,        hb_valor,           hb_monto_bloq,      hb_fecha,           hb_fecha_ven,
       hb_hora,       hb_autorizante,       hb_solicitante,     hb_oficina,         hb_causa,           hb_saldo,
       hb_accion,     hb_levantado,         hb_sec_asoc,        hb_observacion,     hb_ngarantia,       hb_nlinea_sob,
       hb_numcte 
from   ah_his_bloqueo_mig, ah_numero_cuenta
where  hb_cuenta = nc_cuenta_mig 
and    hb_cuenta between @i_clave_i and @i_clave_f
and    hb_estado_mig = 'VE'

if @@error <> 0
begin                                                
    insert into ah_log_mig
    select top 1 convert(varchar, cb_cuenta),
           'ah_his_bloqueo',
           'sp_traslada_ah_his_bloqueo',
           'INS',
           convert(varchar, cb_cuenta),
           150,
           cb_cuenta,
           null
    from   ah_ctabloqueada_mig
end
update cobis..cl_seqnos set siguiente = (select isnull(max(hb_secuencial),0) + 1 from cob_ahorros..ah_his_bloqueo)
where  bdatos = 'cob_ahorros'
and    tabla  = 'ah_his_bloqueo' 

return  0
go
