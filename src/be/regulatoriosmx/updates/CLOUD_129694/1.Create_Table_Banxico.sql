/*************************************************************************/  
/*   Archivo:              banxico.sp			                         */
/*   Stored procedure:     sp_banxico                                    */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Fecha de escritura:   Noviembre 2019                                */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Tabla fisica para almacenamiento de 								 */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/* 01/Noviembre/2019         JCH               emision inicial           */
/* 07/noviembre/2019         JCH  optimizacion de caso 122487 a 129694   */
/*************************************************************************/
use 
cob_conta_super
go

IF EXISTS (SELECT 1 FROM sysindexes WHERE name = 'index01' AND id=OBJECT_ID('sb_banxico_lcr'))
begin
    DROP INDEX sb_banxico_lcr.index01
end 


IF OBJECT_ID ('dbo.sb_banxico_lcr') IS NOT NULL
    DROP TABLE dbo.sb_banxico_lcr
GO
	create table sb_banxico_lcr
	(
		sb_id_producto      int, 
		sb_foliocredito		varchar(24),
		sb_limcredito		varchar(24),
		sb_saldotot			varchar(24),
		sb_pagongi			varchar(24),
		sb_saldorev			varchar(24),
		sb_interesrev       varchar(24),
		sb_saldopmsi        varchar(24),
		sb_meses            int,
		sb_pagomin          varchar(24),
		sb_tasarev          varchar(24),
		sb_saldopci         varchar(24),
		sb_interespci       varchar(24),
		sb_saldopagar       varchar(24),
		sb_pagoreal         varchar(24),
		sb_limcreditoa      varchar(24),
		sb_pagoexige        varchar(24),
		sb_impagosc         int,
		sb_impagosum        int,
		sb_mesapert         varchar(24),
		sb_saldocont        varchar(24),
		sb_situacion        int,
		sb_probinc			varchar(10),
		sb_sevper			varchar(10),
		sb_expinc           varchar(10),
		sb_mreserv          varchar(10),
		sb_relacion         int,
		sb_clascont         int,						 
		sb_cvecons          varchar(64),
		sb_limcreditocalif  varchar(24),
		sb_montopagarinst   varchar(24),
		sb_montopagarsic	varchar(1),
		sb_mesantig         varchar(1),
		sb_mesesic          varchar(1),
		sb_segmento         varchar(1),
		sb_gveces           varchar(1),
		sb_garantia         varchar(1),
		sb_catcuenta        varchar(24),
		sb_indicadorcat     varchar(1),
		sb_folio_cliente    int,
		sb_CP               int,     
		sb_comtotal         varchar(24),
		sb_comtardio        varchar(24),
		sb_pagongiinicio    varchar(24),
		sb_pagoexigepsi     varchar(24)
	)


CREATE CLUSTERED INDEX index01
	ON dbo.sb_banxico_lcr (sb_foliocredito)
GO


