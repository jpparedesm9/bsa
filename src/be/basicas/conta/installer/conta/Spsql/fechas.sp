/************************************************************************/
/*	Archivo: 		fechas.sp  				*/
/*	Stored procedure: 	sp_fechas  				*/
/*	Base de datos:  	cob_conta				*/
/*	Producto: 		contabilidad 				*/
/*	Disenado por:  		M. Suarez I.               		*/
/*	Fecha de documentacion:	29/mar/95				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*      Retornar un fecha en el formato solicitados                     */
/*                                                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_fechas')
	drop proc sp_fechas
go

create proc sp_fechas  (
	@i_fecha 	     datetime,
        @i_formato1          smallint=101,
	@o_fecha     		char(12)=null out
	)
as
declare @w_return       int,
        @w_fecha2       datetime,
        @w_sp_name      varchar(30)

select @w_fecha2=convert(smalldatetime,@i_fecha)
select @o_fecha=convert(char(12),@w_fecha2,@i_formato1)
go
