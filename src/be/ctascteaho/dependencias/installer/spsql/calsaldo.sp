/******************************************************************/
/*  Archivo:            calsaldo.sp                               */
/*  Stored procedure:   sp_calcula_saldo                          */
/*  Base de datos:      cob_cuentas                               */
/*  Producto:           COBIS Branch II                           */
/*  Disenado por:       Javier Bucheli                            */
/*  Fecha de escritura: 10-Sep-1998                               */
/******************************************************************/
/*                        IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA', representantes exclusivos para el Ecuador de la     */
/*  'NCR CORPORATION'.                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este stored procedure permite consultar los saldos y datos    */
/*  más importantes de una cuenta corriente, Debe ser usado para  */
/*  devolver todos los atributos requeridos de una cuenta         */
/******************************************************************/
/*                        MODIFICACIONES                          */
/*  FECHA              AUTOR              RAZON                   */
/*  22-Jul-2016        Tania Baidal    Sp dummy como dependencia  */
/******************************************************************/

use cob_cuentas
go

if exists (select * from sysobjects where id = object_id('sp_calcula_saldo'))
  drop procedure sp_calcula_saldo
go

create proc sp_calcula_saldo (
  @i_cuenta			char(24),
  @i_filial			tinyint,
  @i_fecha			datetime,
  @i_mon			tinyint = null,
  @i_fl_conslds			char(1) = 'N',
  @i_existe_cta			char(1) = null,
  @i_tipo_oper			char(1) = null,
  @i_sld_disp_host		money = null,
  @i_sld_12h_host		money = null,
  @i_sld_24h_host		money = null,
  @i_sld_48h_host		money = null,
  @i_sld_rem_host		money = null,
  @i_monto_blq_host		money = null,
  @i_monto_sob_host		money = null,
  @i_monto_conf_host		money = null,
  @i_monto_cons_host		money = null,
  @i_tipo_ejec			char(1) = null,  --Nuevo parametro , fecha getdate() del central
  @i_fecha_host                 datetime = null, --Nuevo parametro , fecha getdate() del central
  @o_saldo_para_girar		money  out,
  @o_saldo_contable		money  out,
  @o_sld_disp			money = 0 out,
  @o_sld_12h			money = 0 out,
  @o_sld_24h			money = 0 out,
  @o_sld_48h			money = 0 out,
  @o_sld_rem			money = 0 out,
  @o_monto_blq			money = 0 out,
  @o_monto_conf			money = 0 out,
  @o_monto_consumos		money = 0 out,
  @o_num_bloq			int = 0 out,
  @o_num_blqmonto		int = 0 out,
  @o_nombre			varchar(64) = null out,
  @o_oficial			smallint = null out,
  @o_estado			char(1) = null out,
  @o_dep_ini			tinyint = null out,
  @o_ofi_cta			smallint = null out,
  @o_monto_sob			money = 0 out,
  @o_ant_sld_disp		money = 0 out,
  @o_ant_sld_12h		money = 0 out,
  @o_ant_sld_24h		money = 0 out,
  @o_ant_sld_48h		money = 0 out,
  @o_ant_sld_rem		money = 0 out,
  @o_ant_monto_blq		money = 0 out,
  @o_ant_monto_sob		money = 0 out,
  @o_ant_monto_conf		money = 0 out,
  @o_ant_monto_cons		money = 0 out,
  @o_prom1			money = 0 out,
  @o_prom2			money = 0 out,
  @o_prom3			money = 0 out,
  @o_prom4			money = 0 out,
  @o_prom5			money = 0 out,
  @o_prom6			money = 0 out,
  @o_feculth			datetime = null out --BUG: MVE 22-Ene-2002
)
as

begin
    return 0
end

go

