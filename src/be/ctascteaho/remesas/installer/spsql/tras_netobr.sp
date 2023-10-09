/************************************************************************/
/*      Archivo:                tras_netobr.sp                          */
/*      Stored procedure:       sp_tras_neto_br                         */
/*      Base de datos:          cob_remesas                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Fecha de escritura:     27-Jul-2016                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Este programa fue tomado de una versión base para ser agregado     */
/*   en el batch TRASLADO NETO BANREPUBLICA de la sarta diaria.         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR           RAZON                                 */
/*  27/Jul/2016   Tania Baidal Migración a CEN                       */
/************************************************************************/

use cob_remesas
go


set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tras_neto_br')
  drop proc sp_tras_neto_br
go

create proc sp_tras_neto_br (
    @s_ssn          int         = null, 
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_user         varchar(30) = null,
    @s_sesn         int         = null,
    @s_term         varchar(10) = null,
    @s_date         datetime    = null,
    @s_ofi          smallint    = null,    /* Localidad origen transaccion */
    @t_trn          smallint    = null,
    --@i_oficina      smallint,
    @o_banco        tinyint     = null out,
    @t_debug		char(1)     = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(32) = null,
     @i_param1      datetime    = null, 
	--@i_num		  int
	@i_dia_habil_ant smalldatetime = null
)
as

declare @w_sp_name      varchar(20),
        @i_tipo         varchar(1),   
        @i_valor        money,
        @w_causal       varchar(3)

select @w_sp_name = 'sp_tras_neto_br'


declare @w_caje_recibido       money,
        @w_caje_enviado        money,
        @w_Devolucion_recibido money,
        @w_calculo             money,
        @w_ssn                 int

  if (@s_date is null)
     and (@i_param1 is null)
    return 1

  if (@s_date is null)
    select
      @s_date = @i_param1      
--	Canje recibido/Devolución Enviada re_camara_hist (Centro de Canje – ca_oficina) 
-- o	- Canje recibido + Devolución enviada
     -- select  ca_oficina, ca_moneda , @w_caje_recibido = (sum(ca_valor) *(-1))
select  ca_oficina, ca_moneda,(sum(ca_valor) *(-1))
     from    cob_remesas_his..re_camara_hist
     where   ca_fecha = @i_dia_habil_ant
      and    isnull(ca_tipo_compensa, 'C') = 'C'
     group by ca_oficina, ca_moneda

--	Canje enviado
     select ca_oficina, lc_moneda , sum(lc_valor)
     from   cob_cuentas..cc_ofi_centro,
       cob_cuentas..cc_centro_canje,
       cob_remesas..pd_locales
     where  ca_sec = oc_centro
      and    oc_oficina = lc_oficina
      and    lc_fecha_ing= @i_dia_habil_ant
     group  by ca_oficina, lc_moneda

--	Devolución recibida
     select ca_oficina,  cr_moneda, SUM(cr_valor) * (-1)       
     from  cob_cuentas..cc_ofi_centro,
            cob_cuentas..cc_centro_canje,
            cob_remesas..re_cheque_rec       
     where ca_sec = oc_centro
      and   oc_oficina = cr_oficina_p --ó cr_oficina
      and   cr_fecha_ing     = @s_date -- FECHA PROCESO       
      and   cr_tipo_cheque   = 'L'       
      and   cr_estado        = 'P'
      and   isnull(cr_tipo_compensa, 'C') = 'C'       
     group by ca_oficina, cr_moneda

if @w_calculo<> 0 
   begin
       -- Para generar faltante grabar transacción de servicio 483 y para generar sobrante grabar trn  482
       if @w_calculo >0 
          begin
            select @t_trn    = 482
			select @i_tipo   = 'F'
            select @w_causal = 504
          end
       else
         begin
           select @t_trn    = 483
		   select @i_tipo   = 'S'
           select @w_causal = 553
         end

       exec @w_ssn = ADMIN...rp_ssn

       insert into cob_cuentas..cc_ts_trasnetobr
       ( secuencial, tipo_tran, oficina, usuario, terminal, origen, nodo,   fechaproceso, tipo,    valor,    causal )
       values 
       ( @w_ssn,     @t_trn,    @s_ofi,  @s_user, @s_term,  'L',    @s_srv, @s_date,      @i_tipo, @i_valor, @w_causal )

       if @@error != 0
         begin
          /* Error en creacion de transaccion de servicio */
          exec cobis..sp_cerror
               @t_from       = @w_sp_name,
               @i_num        = 203005
          return 203005
         end
  end  

return 0


GO

