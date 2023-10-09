/************************************************************************/
/*   Archivo:              sp_var_nivel_riesgo_1.sp                     */
/*   Stored procedure:     sp_var_nivel_riesgo_1.sp                     */
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
/*   Consulta el Nivel de Riesgo 1 - Calificacion(A,B,C,D,E,F)          */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA         AUTOR                   RAZON                        */
/*   17/03/2023    KVI         Emision Inicial                          */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_nivel_riesgo_1')
   drop proc sp_var_nivel_riesgo_1
go

create proc sp_var_nivel_riesgo_1
(
    @s_ssn                int         = null,
    @s_user               login       = null,
    @s_sesn               int         = null,
    @s_term               varchar(30) = null,
    @s_date               datetime    = null,
    @s_srv                varchar(30) = null,
    @s_lsrv               varchar(30) = null,
    @s_ofi                smallint    = null,
    @s_servicio           int         = null,
    @s_cliente            int         = null,
    @s_rol                smallint    = null,
    @s_culture            varchar(10) = null,
    @s_org                char(1)     = null,
    @i_ente               int,
	@i_tipo_calif_eva_cli varchar(10) = null,
    @i_dias_vig_buro      int         = null, -- Req.203112
	@i_evaluar_reglas     char(1)     = null, -- S evalua nuevamente las reglas si no regresa los valores en base
    @o_resultado          char(1)     = null out
)
as
declare
    @w_sp_name          varchar(100),
	@w_return        	int,
    @w_error            int,
    @w_msg_error        varchar(255),
    @w_nivel            varchar(4)
	

select @w_sp_name    = 'sp_var_nivel_riesgo_1'

if @i_ente is null return 0

print 'Ingreso Nivel Riesgo 1'

exec @w_return             = cobis..sp_riesgo_ind_externo
     @i_ente               = @i_ente,
	 @i_tipo_calif_eva_cli = @i_tipo_calif_eva_cli,
     @i_dias_vig_buro	   = @i_dias_vig_buro,
	 @i_evaluar_reglas     = @i_evaluar_reglas,
     @o_nivel              = @w_nivel output 

select @o_resultado = @w_nivel

print 'calificacion riesgo 1: ' + @w_nivel

return 0

go
