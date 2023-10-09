/************************************************************/
/*   ARCHIVO:         sp_valida_cuenta_ahorros.sp           */
/*   NOMBRE LOGICO:   sp_valida_cuenta_ahorros              */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*   Este procedimiento permite validar que un Proceso,     */
/*   en el Editor de WorkFlow, cumpla ciertos esquemas      */
/*   antes de ponerlo en Produccion.  Los esquemas son:     */
/*      - Un proceso debe tener ACTIVIDADES.                */
/*      - Un Proceso debe tener la actividad INICIO.        */
/*      - Cada actividad, excepto la Fin, Lanzadora,        */
/*        y la Informativa deben tener ENLACES que          */
/*        partan de ellas.                                  */
/*      - Las actividades Fin, Lanzadora e Informativa      */
/*        deben tener ENLACES que lleguen a ellas.          */
/*      - Que cada Actividad tenga asociada a ella,         */
/*        informacion relacionada con:                      */
/*          => RESULTADOS.                                  */
/*          => DESTINATARIO.                                */
/*          => Informacion adicional.                       */
/*      - Que cada enlace tenga asociado a el:              */
/*          => CONDICIONES.                                 */
/*   NOTA: Los codigos de error son diferentes para cada    */
/*         tipo de objeto, estos codigos son numericos y    */
/*         estan expresados como una potencia de 2.         */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/*   28-Mar-2017   Sonia Rojas         Emision Inicial.     */
/************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_valida_cuenta_ahorros')
   drop proc sp_valida_cuenta_ahorros
go

create proc [dbo].[sp_valida_cuenta_ahorros] (
	@s_ssn                int         = null,
	@s_user               varchar(30) = null,
	@s_sesn               int         = null,
	@s_term               varchar(30) = null,
	@s_date               datetime    = null,
	@s_srv                varchar(30) = null,
	@s_lsrv               varchar(30) = null,
	@s_ofi                smallint    = null,
	@t_trn                int         = null,
	@t_debug              char(1)     = 'N',
	@t_file               varchar(14) = null,
	@t_from               varchar(30) = null,
	@s_rol                smallint    = null,
	@s_org_err            char(1)     = null,
	@s_error				int       = null,
	@s_serv               tinyint     = null,
	@s_msg                descripcion = null,
	@s_org                char(1)     = null,
	@t_rty                char(1)     = null,
	@i_version            smallint    = null,
	@i_id_proceso         smallint    = null,
	@i_cliente	  		  int,
	@i_monto_solicitado	  money,
	@o_valida_monto		  smallint out
)
as
declare
	@w_monto_parcial money,
	@w_disponible money,
	@w_porcentaje float,
	@w_grupo int,
	@w_representante int

-- LGU-ini: control para validar o no con cobis-ahorros
if 'S' != (select pa_char from cobis..cl_parametro where pa_nemonico = 'VALAHO' -- existe validacion con cobis-ahorros
         and pa_producto = 'CCA')
begin
	select @o_valida_monto = 1
   return 0
end
-- LGU-fin: control para validar o no con cobis-ahorros


	--Porcentaje 50%
	select @w_porcentaje = 50

	--Monto en base al porcentaje definido
	select @w_monto_parcial = @i_monto_solicitado / (100/@w_porcentaje)

	--Se obtiene el grupo
	select @w_grupo = cg_grupo
	from cobis..cl_cliente_grupo
	where cg_ente = @i_cliente

	--Se obtiene representante del grupo
	select @w_representante = gr_representante
	from cobis..cl_grupo
	where gr_grupo = @w_grupo


	if @w_representante = @i_cliente
	begin
		select @w_disponible = isnull(sum(ah_disponible),0)
		from cob_ahorros..ah_cuenta
		where ah_cliente = @i_cliente
		and ah_estado = 'A'
	end
	else
	begin
		select @w_disponible = isnull(sum(ah_disponible),0)
		from cob_ahorros..ah_cuenta
		where ah_cliente in (@i_cliente, @w_representante)
		and ah_estado = 'A'
	end


	if @w_disponible >= @w_monto_parcial
		select @o_valida_monto = 1
	else
		select @o_valida_monto = 0


return 0
go
