/************************************************************************/
/*   Archivo:              sp_var_val_score_buro.sp                     */
/*   Stored procedure:     sp_var_val_score_buro.sp                     */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         KVI                                          */
/*   Fecha de escritura:   Marzo 2023                                   */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Consulta el Valor del Score Buro de un cliente                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA         AUTOR                   RAZON                        */
/*   16/03/2023    KVI         Emision Inicial                          */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_val_score_buro')
   drop proc sp_var_val_score_buro
go

create proc sp_var_val_score_buro
(
    @s_ssn        int         = null,
    @s_user       login       = null,
    @s_sesn       int         = null,
    @s_term       varchar(30) = null,
    @s_date       datetime    = null,
    @s_srv        varchar(30) = null,
    @s_lsrv       varchar(30) = null,
    @s_ofi        smallint    = null,
    @s_servicio   int         = null,
    @s_cliente    int         = null,
    @s_rol        smallint    = null,
    @s_culture    varchar(10) = null,
    @s_org        char(1)     = null,
    @i_ente       int,
    @o_resultado  int         = null out
)
as
declare
    @w_sp_name          varchar(100),
    @w_error            int,
    @w_msg_error        varchar(255),
    @w_ib_secuencial    int,
    @w_valor            varchar(4)
	

select @w_sp_name    = 'sp_var_val_score_buro'

if @i_ente is null return 0

print 'Ingreso a Consultar Valor Score Buro'

select @w_ib_secuencial = ib_secuencial 
from cob_credito..cr_interface_buro 
where ib_cliente = @i_ente

select @w_valor = sb_valor 
from cob_credito..cr_score_buro 
where sb_ib_secuencial = @w_ib_secuencial

select @o_resultado  = convert(int, @w_valor)

print 'valor score: ' + @w_valor

return 0

go
