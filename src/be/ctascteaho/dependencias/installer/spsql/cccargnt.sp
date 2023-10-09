/******************************************************************/
/*	Archivo:		cccargnt.sp			  */
/*	Stored procedure:	sp_carga_nt_cc			  */
/*	Base de datos:		cob_cuentas			  */
/*	Producto:		COBIS Branch III		  */
/*	Disenado por:		Mireya Velastegui		  */
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
/*  Este stored procedure actualiza o inserta los datos desde la  */
/*  tabla  cargada en cada actualizacion de archivos de saldos en */
/*  el NT (tabla de carga) a la tabla local o principal del NT    */
/*  para cuentas corrientes.                                      */
/******************************************************************/
/*                        MODIFICACIONES                          */
/*	FECHA		AUTOR		      	RAZON		  */
/*	03-Abr-2001	Mireya Velastegui   Emision Inicial	  */
/*	27-Sep-2001	Juan F. Cadena	    Version Base Int.  	  */
/*	21-Ene-2002	M.Velastegui  	    Bug: Reportado DVI    */
/*      06-Jul-2005     O.Velez             cc_protestos tiny->Int*/ 
/******************************************************************/
use cob_cuentas
go

if exists (select * from sysobjects where id = object_id('sp_carga_nt_cc'))
  drop procedure sp_carga_nt_cc
go

create proc sp_carga_nt_cc (
  @i_cuenta		char(24),
  @i_filial		tinyint,
  @i_fecha		datetime,
  @i_fecha_host		datetime,
  @i_opcion		tinyint  
)
as

return 0

go
