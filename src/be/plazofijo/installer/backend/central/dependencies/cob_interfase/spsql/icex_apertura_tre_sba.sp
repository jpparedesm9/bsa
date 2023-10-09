/************************************************************************/
/*  Archivo:              icex_apertura_tre_sba.sp                      */
/*  Stored procedure: 	  sp_icex_apertura_tre_sba                      */
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
/*  Sp interfase                                                        */
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

if object_id('sp_icex_apertura_tre_sba') is not null
   drop procedure sp_icex_apertura_tre_sba
go

create proc sp_icex_apertura_tre_sba(
@s_ssn             int             = NULL,
@s_rol             smallint        = NULL,
@s_user            login           = NULL,
@s_ofi             smallint        = NULL,
@s_date            datetime        = NULL,
@s_srv             varchar(30)     = NULL,
@s_org             char(1)         = NULL,
@s_term            varchar(30)     = NULL,
@s_sesn            int             = NULL,
@s_lsrv            varchar(30)     = NULL,      
@t_trn             int,		                                          
@i_operacion       char(1)         = NULL,
@i_tope            varchar(4)      = NULL,
@i_concep          varchar(3)      = NULL,
@i_opesba          int             = NULL,
@i_secsba          int             = NULL,
@i_modulo          tinyint         = NULL,
@i_catego          varchar(3)      = NULL,
@i_oforig          smallint        = NULL,
@i_notifi          varchar(255)    = NULL,
@i_fechem          datetime        = NULL,
@i_fechac          datetime        = NULL,      
@i_ordena          int             = NULL,
@i_nomord          varchar(64)     = NULL,
@i_porcde          descripcion     = NULL,
@i_dirpcd          direccion       = NULL,
@i_dirord          tinyint         = NULL,
@i_cedruc          varchar(30)     = NULL,
@i_import          money           = NULL,
@i_moneda          tinyint         = NULL,
@i_benefi          descripcion     = NULL,
@i_dirben          direccion       = NULL,
@i_ref_opc         varchar(34)     = NULL,
@i_conben          varchar(3)      = NULL,
@i_paiben          smallint        = NULL,
@i_ciuben          smallint        = NULL,
@i_bcoben          smallint        = NULL,
@i_ofiben          smallint        = NULL,
@i_tdirben         char(2)         = NULL,
@i_instruccion1    varchar(255)    = NULL,
@i_nomben          varchar(255)    = NULL,
@i_bcoint          smallint        = NULL,
@i_ofiint          smallint        = NULL,
@i_tdirint         char(1)         = NULL,
@i_nomint          varchar(255)    = NULL)
with encryption
as
return 0
go
