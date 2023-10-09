/************************************************************************/
/*	Archivo: 		    reingcar.sp                                     */
/*	Stored procedure: 	sp_rem_ingcar            		                */
/*	Base de datos:  	cob_remesas				                        */
/*	Producto: 		    Remesas 				                        */
/*	Disenado por:                                           	        */
/*	Fecha de escritura:     17/Ago/2016				                    */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la            	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/
/*				PROPOSITO				                                */
/*	Este programa es un sp cáscara creado por dependencia           	*/
/************************************************************************/
/*				MODIFICACIONES				                            */
/* FECHA	    AUTOR		     RAZON				                    */
/* 17/Ago/2016  T. Baidal   sp cascara por dependencia sp_detallecheque */
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rem_ingcar')
   drop proc sp_rem_ingcar
go

create proc sp_rem_ingcar (
	@s_ssn		int,
	@s_ssn_branch   int,
	@s_srv	        varchar(30),
	@s_lsrv	        varchar(30),
	@s_user		varchar(30) = 'sa',
	@s_sesn	        int=null,
	@s_term		varchar(32) = 'consola',
	@s_date		smalldatetime,
	@s_ofi		smallint,
	@s_rol		smallint = null,
	@s_org_err	char(1)	= null,	/* Origen de error: [A], [S] */
	@s_error	int	= null,
	@s_sev	        tinyint	= null,
	@s_msg		mensaje	= null,
	@s_org		char(1) = 'U',
	@t_corr   	char(1) = 'N',
	@t_ssn_corr	int = null,	/* Trans a ser reversada */
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(32) = null,
	@t_rty		char(1) = 'N',
	@t_trn		smallint,
	@t_ejec         char(1) = null,	
        @t_show_version       	bit             = 0, -- Mostrar la versión del programa			
	@p_lssn		int	= null,
	@p_rssn		int	= null,
	@p_rssn_corr	int	= null,
	@p_envio	char(1) = 'N',
	@p_rpta	        char(1) = 'N',
	@i_saldo_caja   money = null,
        @i_idcierre     int = null,
        @i_filial       tinyint = 1, -- ELI 29/11/2002
        @i_idcaja       int = 0,     -- ELI 29/11/2002
        @i_canal        smallint = null,
	@i_ctadep	cuenta=null,
	@i_ctagir	cuenta,
	@i_chq	        int,
	@i_val	        money,
	@i_prddep       char(3),
	@i_hablt        char(1) = 'C',
	@i_mon	        tinyint,
	@i_cau		varchar(3) = '',
	@i_referencia	varchar(40) = '',
	@i_cotizacion   float=null,
	@i_mon_chq      tinyint=null,
	@i_tipo_cheque  tinyint,
	@i_banco	descripcion=null,
	@i_turno	smallint = null,
	@i_alterno      int = 0,
        @i_origen       tinyint = 0,
        @o_ssn          int = null out,
        @o_carta	int = null out,
        @o_nombre	varchar(30) = null out,
        @o_fecha_term    datetime  = null out
 )
as
return 0
go
