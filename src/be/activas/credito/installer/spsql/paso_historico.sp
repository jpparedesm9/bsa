
use cob_credito
go

/*************************************************************************/
/*   Archivo:            paso_historico.sp                               */
/*   Stored procedure:   sp_paso_historico                               */
/*   Base de datos:      cob_credito                                     */
/*   Producto:           Credito                                         */
/*   Disenado por:       Dario Cumbal                                    */
/*   Fecha de escritura: 11/06/2021                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBISCORP', representantes exclusivos para el Ecuador de NCR       */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa pasa tablas historicas la informacion de vigencia     */
/*   antigua                                                             */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 11/06/2021   Dario Cumbal                  Version Inicial            */
/*************************************************************************/

IF OBJECT_ID ('dbo.sp_paso_historico') IS NOT NULL
	DROP PROCEDURE dbo.sp_paso_historico
GO

create proc sp_paso_historico (
   @i_param1               datetime = null
)
as

declare 
@w_fecha         datetime,
@w_fecha_proceso datetime,
@w_parametro_vig int

select @w_fecha_proceso = isnull(@i_param1,fp_fecha) 
from cobis..ba_fecha_proceso

select @w_parametro_vig = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'NMVIGR'

select @w_fecha = dateadd(mm,(-1) * @w_parametro_vig,@w_fecha_proceso)


insert into cob_credito_his..cr_b2c_registro_his(
rbh_registro_id   , rbh_id_inst_proc,
rbh_cliente       ,	rbh_fecha_ingreso,
rbh_fecha_vigencia,	rbh_fecha_reg_exitoso)
select 
rb_registro_id    , rb_id_inst_proc,
rb_cliente        ,	rb_fecha_ingreso,
rb_fecha_vigencia ,	rb_fecha_reg_exitoso
from cr_b2c_registro
where rb_fecha_vigencia <= @w_fecha


delete cr_b2c_registro
where rb_fecha_vigencia <= @w_fecha

return 0
go