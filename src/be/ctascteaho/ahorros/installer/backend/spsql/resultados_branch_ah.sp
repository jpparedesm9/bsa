/************************************************************************/
/*      Archivo:                resultados_branch_ah.sp                 */
/*      Stored procedure:       sp_resultados_branch_ah                 */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Corrientes                      */
/*      Disenado por:           Fabricio Velasco                        */
/*      Fecha de escritura:     16-Dic-1992                             */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*                               PROPOSITO                              */
/*      Este programa envia los resultados de la transaccion realizada  */
/*      en el servidor central, al servidor local de Branch.            */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      10/01/2002      CMO             Emision Inicial                 */
/*      02/Mayo/2016    Juan Tagle      Migración a CEN                 */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where id = object_id('sp_resultados_branch_ah'))
   drop procedure sp_resultados_branch_ah
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_resultados_branch_ah (
@s_ssn_host     int         = null,
@t_debug        char(1)     = 'N',
@t_file         varchar(14) = null,
@t_from         varchar(30) = null,
@t_show_version bit   = 0,
@i_cuenta       int,
@i_fecha        datetime,
@i_ofi          smallint,
@i_tipo_cuenta  char(1) = null,
@i_alerta       char(1) = null,
@i_comision     money = null,
@i_iva          money = null,
@i_gmf          money = null,
@i_cedula       varchar(12) = null,
@i_nombre       varchar(40) = null
)
as
declare
@w_return            int,
@w_sp_name           varchar(30),
@w_sld_disp          money,
@w_sld_girar         money,
@w_sld_cont          money,
@w_sld_12h           money,
@w_sld_24h           money,
@w_sld_rem           money,
@w_monto_blq         money,
@w_ofi_cta           smallint,
@w_estado            char(1),
@w_pro_ban           smallint,
@w_sld_48h           money,
@w_monto_conf        money,
@w_monto_consumos    money,
@w_num_bloq          int,
@w_num_blqmont       int,
@w_cedula            varchar(40),
@w_nombre            varchar(40),
@w_prod_bancario     varchar(1), --Req. 381 CB Red Posicionada
@w_corresponsal      varchar(1)  --Req. 381 CB Red Posicionada

/*  Captura nombre del stored procedure   */
select @w_sp_name = 'sp_resultados_branch_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

 /*  Consulta de datos de cuenta ahorro  */
select
@w_sld_disp      = ah_disponible,
@w_sld_12h       = ah_12h,
@w_sld_24h       = ah_24h,
@w_sld_rem       = ah_remesas,
@w_monto_blq     = ah_monto_bloq,
@w_ofi_cta       = ah_oficina,
@w_estado        = ah_estado,
@w_pro_ban       = ah_prod_banc,
@w_nombre        = ah_nombre,
@w_sld_48h       = ah_48h,
@w_monto_conf    = ah_monto_imp,
@w_monto_consumos= ah_monto_consumos,
@w_num_bloq      = ah_bloqueos,
@w_num_blqmont   = ah_num_blqmonto,
@w_cedula        = ah_ced_ruc
from  cob_ahorros..ah_cuenta  with (holdlock)
where ah_cuenta = @i_cuenta

if @w_prod_bancario = @w_pro_ban
   select @w_corresponsal = 'S'
else
   select @w_corresponsal = 'N'

exec @w_return = cob_ahorros..sp_ahcalcula_saldo
@t_debug            = @t_debug,
@t_file             = @t_file,
@t_from             = @w_sp_name,
@i_cuenta           = @i_cuenta,
@i_fecha            = @i_fecha,
@i_corresponsal     = @w_corresponsal,
@o_saldo_para_girar = @w_sld_girar out,
@o_saldo_contable   = @w_sld_cont out

if @w_return <> 0
   return @w_return

if @i_tipo_cuenta = 'O'
begin
      select 'results_submit_rpc',
      r_sld_disp      = @w_sld_disp,
      r_sld_cont      = @w_sld_cont,
      r_sld_girar     = @w_sld_girar,
      r_sld_12h       = @w_sld_12h,
      r_sld_24h       = @w_sld_24h,
      r_sld_rem       = @w_sld_rem,
      r_monto_blq     = @w_monto_blq,
      r_pro_ban       = @w_pro_ban,
      r_ofi_cta       = @w_ofi_cta,
      r_estado        = @w_estado,
      r_nombre        = @w_nombre,
      r_sld_48h       = @w_sld_48h,
      r_monto_conf    = @w_monto_conf,
      r_monto_consumos= @w_monto_consumos,
      r_num_bloq      = @w_num_bloq,
      r_num_blqmont   = @w_num_blqmont,
      r_ssn_host      = @s_ssn_host,
      r_cedula        = @w_cedula,
      r_comision      = @i_comision,
      r_iva           = @i_iva,
      r_gmf           = @i_gmf,
      r_alerta        = @i_alerta,
      r_nombre        = @w_nombre
end
else
begin
      select 'results_submit_rpc',
      r_sld_disp_2    = @w_sld_disp,
      r_sld_cont_2    = @w_sld_cont,
      r_sld_girar_2   = @w_sld_girar,
      r_sld_12h_2     = @w_sld_12h,
      r_sld_24h_2     = @w_sld_24h,
      r_sld_rem_2     = @w_sld_rem,
      r_monto_blq_2   = @w_monto_blq,
      r_pro_ban_2     = @w_pro_ban,
      r_ofi_cta_2     = @w_ofi_cta,
      r_estado_2      = @w_estado,
      r_nombre_2      = @w_nombre,
      r_ssn_host_2    = @s_ssn_host,
      r_cedula        = @w_cedula,
      r_comision      = @i_comision,
      r_iva           = @i_iva,
      r_gmf           = @i_gmf,
      r_alerta        = @i_alerta,
      r_nombre        = @w_nombre
end
return 0

go

