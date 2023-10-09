/************************************************************************/
/*  Archivo:              icte_tr_tarjvisa.sp                           */
/*  Stored procedure: 	  sp_icte_tr_tarjvisa                           */
/*  Base de datos:  	  cob_interfase                                 */
/*  Producto:             PFIJO                                         */
/*  Disenado por:         Byron Ron                                     */
/*  Fecha de escritura:   15-Jul-2009                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                 PROPOSITO                                            */
/*  Sp interfase.                                                       */
/************************************************************************/ 
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  15-JUL-2009     B. RON          Emision Inicial                     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_icte_tr_tarjvisa') is not null
   drop procedure sp_icte_tr_tarjvisa
go

create proc sp_icte_tr_tarjvisa(
@s_ssn             int             = NULL,
@s_lsrv            varchar(30)     = NULL,
@s_date            datetime        = NULL,
@s_org             char(1)         = NULL,
@s_user            varchar(30)     = NULL,      
@s_ofi             smallint        = NULL,      
@s_srv             varchar(30)     = NULL,      
@s_ssn_branch      int             = NULL,
@s_term            varchar(10)     = NULL,
@s_rol             smallint        = NULL,
@t_corr            char(1)         = NULL,
@t_ssn_corr        int             = NULL,
@t_trn             smallint,		
@t_ejec            char(1)         = NULL,
@i_ActTot          char(1)         = NULL,           
@i_acredita        char(1)         = NULL,            
@i_total           money           = NULL,       
@i_tarjeta         cuenta          = NULL,              
@i_filial          smallint        = NULL,          
@i_mon             tinyint         = NULL,       
@i_mon_tarjeta     tinyint         = NULL,
@i_cod_alterno     int             = NULL,
@i_val             money           = NULL, 
@i_canal           tinyint         = NULL)
with encryption
as
return 0
go
