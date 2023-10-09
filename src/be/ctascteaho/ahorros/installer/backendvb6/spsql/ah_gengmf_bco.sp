/************************************************************************/
/*   Archivo:             ah_gengmf_bco.sp                              */
/*   Stored procedure:    sp_ah_genera_gmf_bco                          */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            cartera                                       */
/*   Disenado por:        Luis Carlos Moreno C.                         */
/*   Fecha de escritura:  Noviembre/2011                                */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*                           PROPOSITO                                  */
/*  Generar registro contable de GMF a cargo del banco                  */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR             RAZON                              */
/*  14-02-13       L.Moreno          Emisión Inicial - Req: 355         */
/*  02/Mayo/2016   Ignacio Yupa      Migración a CEN                    */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_ah_genera_gmf_bco')
   drop proc sp_ah_genera_gmf_bco
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_ah_genera_gmf_bco (
@s_ssn               int,
@s_ssn_branch        int = null,
@s_user              varchar(30) = 'opbatch',
@s_term              varchar(10) = 'consola',
@s_ofi               smallint,
@t_trn               int,
@t_corr              char(1) = null, 
@t_ssn_corr          int = null,
@t_show_version      bit = 0,
@i_alt               int = 0,
@i_cta_banco         cuenta,
@i_fecha             smalldatetime = null,
@i_prod_banc         smallint,
@i_categoria         char(1),
@i_tipocta_super     char(1),
@i_turno             smallint=null,
@i_valor             money,
@i_causal            char(3),
@i_moneda            tinyint,
@i_clase_clte        char(1),
@i_cliente           int = null,
@i_oficina           int = null
)

as

Declare @w_tasagmf   float,
@w_error             int,
@w_gmfbco            money,
@w_numdeci_imp       tinyint,
@w_trngmf            int,
@w_estado            char(1),
@w_sp_name          varchar(30)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name   = 'sp_ah_genera_gmf_bco'
       
---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
print 'Stored Procedure= ' + @w_sp_name +  ' Version=' + '4.0.0.0'
return 0
end
-- PARAMETRO DE DECIMALES PARA IMPUESTOS
select @w_numdeci_imp = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'AHO'
and    pa_nemonico = 'DIM'

if @@rowcount = 0 begin
   select @w_error = 2600124
   goto ERRORFIN 
end

/* TASA GRAVAMEN A LOS MOVIMIENTOS FINANCIEROS */
select @w_tasagmf = pa_float
from  cobis..cl_parametro
where pa_producto = 'AHO'
and   pa_nemonico = 'IGMF'

if @@rowcount = 0 begin
   select @w_error = 2600093
   goto ERRORFIN
end

/* CODIGO DE TRANSACCION PARA GENERACION DE GMF */
select @w_trngmf = pa_int
from  cobis..cl_parametro
where pa_producto = 'AHO'
and   pa_nemonico = 'TGMFBA'

if @@rowcount = 0 begin
   select @w_error = 251110
   goto ERRORFIN
end

/* CALCULA VALOR DE COBRO DE GMF */
select @w_gmfbco = round((isnull(@i_valor,0) * isnull(@w_tasagmf,0)), @w_numdeci_imp)

if @t_corr = 'S'
begin
   select @w_estado = 'R'

   update ah_tran_servicio
   set ts_estado = @w_estado
   where ts_ssn_branch = @t_ssn_corr
   and    ts_cta_banco  = @i_cta_banco
   and    ts_cod_alterno= @i_alt
   and    ts_valor      = @w_gmfbco
   and    ts_causa      = @i_causal
   and    ts_moneda     = @i_moneda
   and    ts_estado     is null

    
end

/* INSERTA TRANSACCION DE SERVICIO CON EL COBRO ESTABLECIDO */
insert into cob_ahorros..ah_tran_servicio(
ts_secuencial,           ts_ssn_branch,          ts_cod_alterno,
ts_tipo_transaccion,     ts_tsfecha,             ts_usuario,
ts_terminal,             ts_oficina,             ts_reentry,
ts_origen,               ts_cta_banco,           ts_valor,
ts_causa,                ts_moneda,              ts_oficina_cta,
ts_prod_banc,            ts_categoria,           ts_tipocta_super,
ts_turno,                ts_clase_clte,          ts_cliente,
ts_interes,              ts_correccion,          ts_ssn_corr,
ts_estado)
select 
@s_ssn,                  @s_ssn_branch,          @i_alt,
@w_trngmf,               @i_fecha,               @s_user,
@s_term,                 @s_ofi,                 'N',
'U',                     @i_cta_banco,           @w_gmfbco,
@i_causal,               @i_moneda,              @i_oficina,
@i_prod_banc,            @i_categoria,           @i_tipocta_super,
@i_turno,                @i_clase_clte,          @i_cliente,
@i_valor,                @t_corr,                @t_ssn_corr,
@w_estado

if @@error <> 0 begin
   select @w_error = 251112
   goto ERRORFIN 
end

return 0

ERRORFIN:
   return @w_error


go

