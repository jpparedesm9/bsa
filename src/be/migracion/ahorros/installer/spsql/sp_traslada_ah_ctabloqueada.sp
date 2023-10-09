/************************************************************************/
/*  Archivo:                    sp_traslada_ah_ctabloqueada.sp          */
/*  Stored procedure:           sp_traslada_ah_ctabloqueada             */
/*  Base de Datos:              cob_externos                            */
/*  Producto:                   AHORROS                                 */
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

if exists(select * from sysobjects where name = 'sp_traslada_ah_ctabloqueada')
    drop proc sp_traslada_ah_ctabloqueada
go

create proc sp_traslada_ah_ctabloqueada(
    @i_clave_i   int = null,
    @i_clave_f   int = null
)
as
declare @w_conteo   int

select @i_clave_i = @i_clave_i + 1

select @w_conteo = count(1)
from   ah_ctabloqueada_mig
where  cb_cuenta between @i_clave_i and @i_clave_f
and    cb_estado_mig = 'VE'
if @w_conteo = 0 return 0
   
-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------
insert into cob_ahorros..ah_ctabloqueada 
       (cb_cuenta,     cb_secuencial,     cb_tipo_bloqueo,    cb_fecha,
        cb_hora,       cb_autorizante,    cb_solicitante,     cb_oficina,
        cb_estado,     cb_causa,          cb_sec_asoc,        cb_observacion)
select  nc_cuenta,     cb_secuencial,     cb_tipo_bloqueo,    cb_fecha, 
        cb_hora,       cb_autorizante,    cb_solicitante,     cb_oficina, 
        cb_estado,     cb_causa,          cb_sec_asoc,        cb_observacion
from    ah_ctabloqueada_mig, ah_numero_cuenta
where   cb_cuenta = nc_cuenta_mig 
and     cb_cuenta between @i_clave_i and @i_clave_f
and     cb_estado_mig = 'VE'  

if @@error <> 0
begin                                               
    insert into ah_log_mig
    select top 1 convert(varchar, cb_cuenta),
           'ah_ctabloqueada',
           'sp_traslada_ah_ctabloqueada',
           'cb_cuenta',
           convert(varchar, cb_cuenta),
           137,
           cb_cuenta,
           null
    from   ah_ctabloqueada_mig  
end

update cobis..cl_seqnos set siguiente = (select isnull(max(cb_secuencial),0) + 1 from cob_ahorros..ah_ctabloqueada)
where  bdatos = 'cob_ahorros'
and    tabla  = 'ah_ctabloqueada' 

return  0
go
