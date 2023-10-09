/******************************************************************/
/*	Archivo:		ccsinsld.sp			  */
/*	Stored procedure:	sp_sincroniza_saldo_cc		  */
/*	Base de datos:		cob_cuentas			  */
/*	Producto:		COBIS Branch III		  */
/*	Disenado por:		Javier Bucheli			  */
/*	Fecha de escritura:	03-Abr-2001			  */
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
/*  Este stored procedure permite sincronizar los saldos en el NT */
/*  considerando como validos los saldos mas cercanos a los saldos*/
/*  del central . Estos saldos se comparan entre las tablas del NT*/
/*  principal y de carga de cuentas corrientes.                   */
/******************************************************************/
/*                        MODIFICACIONES                          */
/*  FECHA              AUTOR              RAZON                   */
/*  22-Mar-2001      Mireya Velastegui   Emision Inicial          */
/*  20-Sep-2001      Mireya Velastegui   Optimizacion. NCA Tequen.*/
/*  27-Sep-2001      Juan F. Cadena	 Version Base Int.	  */
/******************************************************************/
use cob_cuentas
go

if exists (select * from sysobjects where id = object_id('sp_sincroniza_saldo_cc'))
  drop procedure sp_sincroniza_saldo_cc
go

create proc sp_sincroniza_saldo_cc (
  @s_date		datetime,
  @i_cuenta		char(24),
  @i_filial		tinyint,
  @i_fl_conslds		char(1) = 'N',
  @i_fecha_host		datetime,
  @o_existe_cta		char(1) = null out


)
as
         
return 0

go
