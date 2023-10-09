/****************************************************************************/
/*     Archivo:     re_rechazos.sp                                          */
/*     Stored procedure: sp_re_rechazos                                     */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_re_rechazos')
  drop proc sp_re_rechazos
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
CREATE proc sp_re_rechazos (
@s_ofi          smallint,
@t_trn          int,
@t_debug        char(1) = 'N',
@t_file         varchar(14) = null,
@i_cta          cuenta,
@i_modulo       int,
@i_vlr_comi     money,
@i_vlr_iva      money,
@i_causal       int

)as
declare
@w_id_cliente   numero,
@w_nom_cliente  descripcion,
@w_sp_name		varchar(30),
@w_error        int,
@w_ente         varchar(15), 
@w_cliente      int      

select @w_sp_name  = 'sp_re_rechazos'

/* OBTIENE DATOS DEL CLIENTE */
select @w_ente = ah_cliente 
from cob_ahorros..ah_cuenta
where ah_cta_banco = @i_cta

select
@w_id_cliente  = en_ced_ruc, 
@w_nom_cliente = en_nombre,
@w_cliente     = en_ente
from cobis..cl_ente with (nolock)
where en_ente = @w_ente

if @@rowcount = 0
begin
   select @w_error = 101042
   goto ERROR
end

insert into cob_ahorros..ah_tran_rechazos(
tr_fecha,         tr_oficina,             tr_cod_cliente,         tr_id_cliente,
tr_nom_cliente,   tr_cta_banco,           tr_tipo_tran,
tr_nom_tran,      tr_vlr_comision,        tr_vlr_iva,
tr_modulo,        tr_causal_rech)
values(
getdate(),        @s_ofi,                 @w_cliente,             @w_id_cliente,
@w_nom_cliente,   @i_cta,                 @t_trn,
'',               @i_vlr_comi,            @i_vlr_iva,
@i_modulo,        @i_causal)

if @@error <> 0
begin
   select @w_error = 251070
   goto ERROR
end

return 0
ERROR:
	exec cobis..sp_cerror
		   @t_debug        = @t_debug,
		   @t_file         = @t_file,
		   @t_from         = @w_sp_name,
		   @i_num          = @w_error
	return @w_error


go
