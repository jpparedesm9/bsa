/************************************************************************/
/*  Archivo:            ah_cons_detalle_ext.sp                         */
/*  Stored procedure:   sp_ah_cons_detalle_ext                         */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Viviana Ramon                   				*/
/*  Fecha de escritura: 08-Sep-2016                                     */
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
           where  name = 'sp_ah_cons_detalle_ext')
  drop proc sp_ah_cons_detalle_ext
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_cons_detalle_ext
(
  @i_cuenta           int,/*Rango inicio*/
  @i_rango			  int,/*Rango fin*/
  @i_fecha_proceso    	smalldatetime,
  @i_fecha_next_laboral  smalldatetime,
  @s_user          varchar(30)=null,
  @s_srv           varchar(30)=null,
  @s_lsrv          varchar(30)=null,  
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint=null,
  @t_show_version  bit = 0
)
as
  declare
    @w_sp_name   varchar(30),
	@w_cta_banco	char(16),
	@w_ec_cuenta	int,
	@w_fecha_prx_corte	smalldatetime,
	@w_fecha_ult_corte	smalldatetime,
	@w_fecha_ult_mov	smalldatetime,
	@w_fecha_ult_mov_int	smalldatetime,
	@w_oficina	varchar(64),
	@w_nombre	char(55),
	@w_descripcion_ec char(120),	
	@w_disponible	money,
	@w_saldo_contable	money,
	@w_saldo_ult_corte	money,
	@w_saldo_promedio	money,
	@w_ret_locales	money,
	@w_ret_plazas	money,								
	@w_consumos	money,
	@w_monto_imp	money,
	@w_prom_semestral	money,
	@w_tasa_hoy	real

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_cons_detalle_ext'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  SET NOCOUNT ON
  ----CREA TABLA TEMPORAL PARA CABECERA----
	create table #tmp_cabecera( tmp_ec_cuenta	int,
								tmp_ec_cta_banco	char(16),
								tmp_ec_fecha_prx_corte	smalldatetime,
								tmp_ec_fecha_ult_corte	smalldatetime,
								tmp_ec_fecha_ult_mov	smalldatetime,
								tmp_ec_fecha_ult_mov_int	smalldatetime,
								tmp_ec_oficina	 varchar(64),							
								tmp_ec_nombre	char(55),
								tmp_ec_descripcion_ec char(120),								
								tmp_ec_disponible	money,
								tmp_ec_saldo_contable	money,
								tmp_ec_saldo_ult_corte	money,
								tmp_ec_saldo_promedio	money,
								tmp_ec_ret_locales	money,
								tmp_ec_ret_plazas	money,								
								tmp_ec_consumos	money,
								tmp_ec_monto_imp	money,
								tmp_ec_prom_semestral	money,
								tmp_ec_tasa_hoy	real)
	----CREA TABLA TEMPORAL DETALLE----
	create table #tmp_general( tmp_de_fecha	varchar(12),
								tmp_de_cta_banco varchar(24),
								tmp_de_oficina	smallint,
								tmp_de_nombre varchar(15),						
								tmp_de_transaccion	varchar(326),
								tmp_de_signo	varchar(1),
								tmp_de_valor	money,
								tmp_de_saldo_contable	money,
								tmp_ec_cuenta	int,
								tmp_ec_fecha_prx_corte	smalldatetime,
								tmp_ec_fecha_ult_corte	smalldatetime,
								tmp_ec_fecha_ult_mov	smalldatetime,
								tmp_ec_fecha_ult_mov_int	smalldatetime,
								tmp_ec_oficina	varchar(64),							
								tmp_ec_nombre	char(55),
								tmp_ec_descripcion_ec char(120),								
								tmp_ec_disponible	money,
								tmp_ec_saldo_contable	money,
								tmp_ec_saldo_ult_corte	money,
								tmp_ec_saldo_promedio	money,
								tmp_ec_ret_locales	money,
								tmp_ec_ret_plazas	money,								
								tmp_ec_consumos	money,
								tmp_ec_monto_imp	money,
								tmp_ec_prom_semestral	money,
								tmp_ec_tasa_hoy	real)
	 
	----CONSUMIR SP CUENTAS---
	insert into #tmp_cabecera
	exec cob_ahorros..sp_ah_cons_cabecera_ext
	@i_cuenta = @i_cuenta ,
	@i_rango  =@i_rango,
	@i_fecha_proceso =@i_fecha_proceso,
	@i_fecha_next_laboral =@i_fecha_next_laboral
	
	----BARRER TABLA Y CONSULTAR DETALLES--
	DECLARE cur_tmp_cabecera CURSOR FOR
	SELECT tmp_ec_cuenta,tmp_ec_cta_banco,tmp_ec_fecha_prx_corte,
			tmp_ec_fecha_ult_corte,tmp_ec_fecha_ult_mov,
			tmp_ec_fecha_ult_mov_int,tmp_ec_oficina,tmp_ec_nombre,tmp_ec_descripcion_ec,								
			tmp_ec_disponible,tmp_ec_saldo_contable,tmp_ec_saldo_ult_corte,
			tmp_ec_saldo_promedio,tmp_ec_ret_locales,tmp_ec_ret_plazas,								
			tmp_ec_consumos,tmp_ec_monto_imp,tmp_ec_prom_semestral,tmp_ec_tasa_hoy	
	FROM #tmp_cabecera
	order by tmp_ec_cuenta
	
	OPEN  cur_tmp_cabecera
	FETCH cur_tmp_cabecera INTO 
	@w_ec_cuenta,@w_cta_banco,@w_fecha_prx_corte,@w_fecha_ult_corte,
	@w_fecha_ult_mov,@w_fecha_ult_mov_int,@w_oficina,@w_nombre,@w_descripcion_ec,								
	@w_disponible,@w_saldo_contable,@w_saldo_ult_corte,
	@w_saldo_promedio,@w_ret_locales,@w_ret_plazas,								
	@w_consumos,@w_monto_imp,@w_prom_semestral,@w_tasa_hoy	
	
	--WHILE @@sqlstatus = 0
	WHILE @@FETCH_STATUS = 0 
	begin
	   --if @@sqlstatus = 1
	   if @@FETCH_STATUS = 1
	   begin
		  --raiserror 21000 "Error en carga de datos" 
		  --rollback tran
		  CLOSE cur_tmp_cabecera
		  DEALLOCATE cur_tmp_cabecera
		  return 1
	   end
		---CONSULTA DETALLES E INSERTA EN ----
		insert into #tmp_general
		select de_fecha,de_cta_banco,de_oficina,de_nombre,de_transaccion,de_signo,
				de_valor,de_saldo_contable,@w_ec_cuenta,@w_fecha_prx_corte,
				@w_fecha_ult_corte,@w_fecha_ult_mov,@w_fecha_ult_mov_int,
				@w_oficina,@w_nombre,@w_descripcion_ec,@w_disponible,@w_saldo_contable,
				@w_saldo_ult_corte,@w_saldo_promedio,@w_ret_locales,@w_ret_plazas,								
				@w_consumos,@w_monto_imp,@w_prom_semestral,@w_tasa_hoy
        from  cob_ahorros..ah_det_estado_cuenta
       where  de_cta_banco = @w_cta_banco
       order by de_fecha
	 FETCH cur_tmp_cabecera INTO 
		@w_ec_cuenta,@w_cta_banco,@w_fecha_prx_corte,@w_fecha_ult_corte,
		@w_fecha_ult_mov,@w_fecha_ult_mov_int,@w_oficina,@w_nombre,@w_descripcion_ec,								
		@w_disponible,@w_saldo_contable,@w_saldo_ult_corte,
		@w_saldo_promedio,@w_ret_locales,@w_ret_plazas,								
		@w_consumos,@w_monto_imp,@w_prom_semestral,@w_tasa_hoy
	end
	CLOSE cur_tmp_cabecera
	DEALLOCATE cur_tmp_cabecera
	SET NOCOUNT OFF
	--RETURN DE GENERAL-- 
	 select	'de_fecha' = tmp_de_fecha,
			'de_cta_banco' = tmp_de_cta_banco,
			'de_oficina'	= tmp_de_oficina,
			'de_nombre'	= tmp_de_nombre,
			'de_transaccion'=	tmp_de_transaccion,
			'de_signo'=	tmp_de_signo,
			'de_valor'=	tmp_de_valor,
			'de_saldo_contable'=	tmp_de_saldo_contable,
			'ec_cuenta'=	tmp_ec_cuenta,
			'ec_fecha_prx_corte'=	tmp_ec_fecha_prx_corte,
			'ec_fecha_ult_corte'=	tmp_ec_fecha_ult_corte,
			'ec_fecha_ult_mov'=	tmp_ec_fecha_ult_mov,
			'ec_fecha_ult_mov_int'=	tmp_ec_fecha_ult_mov_int,
			'ec_oficina'=	tmp_ec_oficina,
			'ec_nombre'= tmp_ec_nombre,
			'ec_descripcion_ec' =tmp_ec_descripcion_ec,
			'ec_disponible'=	tmp_ec_disponible,
			'ec_saldo_contable'=	tmp_ec_saldo_contable,
			'ec_saldo_ult_corte'=	tmp_ec_saldo_ult_corte,
			'ec_saldo_promedio'=	tmp_ec_saldo_promedio,
			'ec_ret_locales'=	tmp_ec_ret_locales,
			'ec_ret_plazas'=	tmp_ec_ret_plazas,
			'ec_consumos'=	tmp_ec_consumos,
			'ec_monto_imp'=	tmp_ec_monto_imp,
			'ec_prom_semestral'=	tmp_ec_prom_semestral,
			'ec_tasa_hoy'=	tmp_ec_tasa_hoy

		from #tmp_general
go

