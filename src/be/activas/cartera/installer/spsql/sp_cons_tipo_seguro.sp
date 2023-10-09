/*************************************************************/
/*   ARCHIVO:         	sp_cons_tipo_seguro.sp               */
/*   NOMBRE LOGICO:   	sp_cons_tipo_seguro.sp               */
/*   PRODUCTO:        		CARTERA                          */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Este procedimiento permite actualizar el tipo de seguro */
/*   de seguro por cada uno de los clientes                  */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*  FECHA          AUTOR    RAZON                            */
/*  10-Dic-2019    DCU      Req. 126891                      */
/*  10-Jun-2022    SRO      Req. 185234                      */
/*************************************************************/
use cob_cartera
go


IF OBJECT_ID ('dbo.sp_cons_tipo_seguro') IS NOT NULL
	DROP PROCEDURE dbo.sp_cons_tipo_seguro
GO

CREATE PROCEDURE sp_cons_tipo_seguro (	
   @s_ssn            int           = null,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   @i_tipo_seguro    varchar(16)   = null,
   @i_operacion      char(1)       = null,
   @i_producto       varchar(20)   = 'GRUPAL'   
)
as 

if @i_operacion = 'H'
begin
    select distinct 
	se_paquete,
    se_descripcion 
    from cob_cartera..ca_param_seguro_externo
    where se_estado   = 'V'
	and   se_producto = @i_producto 
end

if @i_operacion = 'Q'
begin
    select distinct 
	se_paquete,
    se_descripcion 
    from cob_cartera..ca_param_seguro_externo
    where  se_paquete  = @i_tipo_seguro 
    and    se_producto = @i_producto 	
end

return 0

go
