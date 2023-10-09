/************************************************************************/
/*  Archivo:            ah_cons_cabecera_ext.sp                         */
/*  Stored procedure:   sp_ah_cons_cabecera_ext                         */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Viviana Ramon                   				*/
/*  Fecha de escritura: 07-Sep-2016                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de consulta de estado de       */
/*  cuenta.                                                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR       RAZON                                   */
/*                                                                      */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_cons_cabecera_ext')
  drop proc sp_ah_cons_cabecera_ext
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_cons_cabecera_ext
(
  @i_cuenta           	int,/*Rango inicio*/
  @i_rango			  	int,/*Rango fin*/
  @i_fecha_proceso    	smalldatetime,
  @i_fecha_next_laboral  smalldatetime,
  @s_user          		varchar(30)=null,
  @s_srv           		varchar(30)=null,
  @s_lsrv          		varchar(30)=null,  
  @t_debug         		char(1) = 'N',
  @t_file          		varchar(14) = null,
  @t_from          		varchar(32) = null,
  @t_trn           		smallint=null,
  @t_show_version  bit = 0
)
as
  declare
    @w_sp_name   varchar(30)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_cons_cabecera_ext'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
	----CONSULTA EL ESTADO DE CUENTAS----
  begin
   if @i_rango is NULL
      select @i_rango = 20
	  
   set rowcount @i_rango
   if @i_cuenta =0
     select c.ec_cuenta,
			c.ec_cta_banco,
			c.ec_fecha_prx_corte,
			c.ec_fecha_ult_corte,
			c.ec_fecha_ult_mov,
			c.ec_fecha_ult_mov_int,
			o.of_nombre,
			c.ec_nombre,
			c.ec_descripcion_ec,
			c.ec_disponible,
			c.ec_saldo_contable,
			c.ec_saldo_ult_corte,
			c.ec_saldo_promedio,
			c.ec_ret_locales,
			c.ec_ret_plazas,
			c.ec_consumos,
			c.ec_monto_imp,
			c.ec_prom_semestral,
			c.ec_tasa_hoy
        from  cob_ahorros..ah_estado_cta c,cobis..cl_oficina o
       where  ec_cuenta > @i_cuenta and
	   ec_fecha_prx_corte = @i_fecha_proceso and
	   ec_fecha_prx_corte < @i_fecha_next_laboral and
	   c.ec_oficina = o.of_oficina
       order by c.ec_cuenta
   if @i_cuenta > 0
     select c.ec_cuenta,
			c.ec_cta_banco,
			c.ec_fecha_prx_corte,
			c.ec_fecha_ult_corte,
			c.ec_fecha_ult_mov,
			c.ec_fecha_ult_mov_int,
			o.of_nombre,
			c.ec_nombre,
			c.ec_descripcion_ec,
			c.ec_disponible,
			c.ec_saldo_contable,
			c.ec_saldo_ult_corte,
			c.ec_saldo_promedio,
			c.ec_ret_locales,
			c.ec_ret_plazas,
			c.ec_consumos,
			c.ec_monto_imp,
			c.ec_prom_semestral,
			c.ec_tasa_hoy
        from  cob_ahorros..ah_estado_cta c,cobis..cl_oficina o
       where  ec_cuenta > @i_cuenta and
	   ec_fecha_prx_corte = @i_fecha_proceso and
	   ec_fecha_prx_corte < @i_fecha_next_laboral and
	   c.ec_oficina = o.of_oficina
       order by c.ec_cuenta
   set rowcount 0
end

go

