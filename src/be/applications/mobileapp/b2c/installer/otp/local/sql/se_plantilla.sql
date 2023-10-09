/*****************************************************************************/
/*    Archivo:               se_plantilla.sql                                */
/*    Base de datos:         cob_bvirtual                                           */
/*    Producto:              BANCAMOVIL                                      */
/*    Disenado por:          Gelen Romero                                    */
/*    Fecha de escritura:    28-Octubre-2016                                 */
/*****************************************************************************/
/*                                 IMPORTANTE                                */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.  */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier      */
/* alteracion o agregado hecho por alguno de usuarios sin el debido          */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp       */
/* o su representante.                                                       */
/*****************************************************************************/
/*                                PROPOSITO                                  */
/*  Inserta la plantilla para notificación de  OTP                            */
/*****************************************************************************/
/*                              MODIFICACIONES                               */
/*****************************************************************************/
/*  FECHA        VERSION      AUTOR             RAZON                        */
/*****************************************************************************/
/*  28/10/2016   1.0.0.0     Gelen Romero     Notificacion de Banca Virtual  */
/*****************************************************************************/

use cob_bvirtual
go

delete bv_template  where te_nombre =  'Notif_otp.xslt'

declare @w_id int
select @w_id = isnull(max(te_id),0) + 1 from bv_template
insert into bv_template 
(te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
values (@w_id,'XSLT', 'NEUTRAL', 'Notif_otp.xslt', 'A', '1.0.0.0') 

update cobis..cl_seqnos 
set siguiente = isnull((select max(te_id) from cob_bvirtual..bv_template),1)
where tabla = 'bv_template'

go


