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
/*************************************************************************/
use 
cob_conta_super
go
IF NOT EXISTS ( SELECT 1 FROM sysobjects WHERE name = 'sb_banxico_lcr'  AND type = 'U')
begin
	create table sb_banxico_lcr
	(
		sb_id_producto      int, 
		sb_foliocredito		varchar(24),
		sb_limcredito		money,
		sb_saldotot			money,
		sb_pagongi			money,
		sb_saldorev			money,
		sb_interesrev       money,
		sb_saldopmsi        money,
		sb_meses            int,
		sb_pagomin          money,
		sb_tasarev          float,
		sb_saldopci         money,
		sb_interespci       money,
		sb_saldopagar       money,
		sb_pagoreal         money,
		sb_limcreditoa      money,
		sb_pagoexige        money,
		sb_impagosc         int,
		sb_impagosum        int,
		sb_mesapert         datetime,
		sb_saldocont        money,
		sb_situacion        int,
		sb_probinc			varchar(10),
		sb_sevper			varchar(10),
		sb_expinc           varchar(10),
		sb_mreserv          varchar(10),
		sb_relacion         int,
		sb_clascont         int,						 
		sb_cvecons          varchar(64),
		sb_limcreditocalif  money,
		sb_montopagarinst   money,
		sb_montopagarsic	varchar(1),
		sb_mesantig         varchar(1),
		sb_mesesic          varchar(1),
		sb_segmento         varchar(1),
		sb_gveces           varchar(1),
		sb_garantia         varchar(1),
		sb_catcuenta        float,
		sb_indicadorcat     varchar(1),
		sb_folio_cliente    int,
		sb_CP               int,     
		sb_comtotal         money,
		sb_comtardio        money,
		sb_pagongiinicio    money,
		sb_pagoexigepsi     money
	);
	CREATE nonclustered INDEX sb_banxico_lcr
		ON dbo.sb_banxico_lcr (sb_foliocredito)
	GO 
end 






