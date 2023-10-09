/*****************************************************************************/
/*  ARCHIVO:         secuencial.sp                                           */
/*  NOMBRE LOGICO:   sp_secuencial                                           */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Generar los secuenciales propios de Plazo Fijo (y evitar contencion en la */
/* cobis..cl_seqnos y/o la ba_secuencial).                                   */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_secuencial')
   drop proc sp_secuencial
go

create proc sp_secuencial(
@i_operacionpf     int = null)
with encryption
as
declare
@w_secuencial      int

update pf_secuenciales with (rowlock)
set    @w_secuencial = se_secuencial + 1,
       se_secuencial = se_secuencial + 1
where  se_operacion  = isnull(@i_operacionpf, -1)

if @@rowcount = 0 begin
   insert into pf_secuenciales with (rowlock) values (isnull(@i_operacionpf, -1), 1)
   return 1
end

return @w_secuencial
go
