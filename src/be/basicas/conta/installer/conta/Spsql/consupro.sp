/************************************************************************/
/*	Archivo: 		consu.sp			        */
/*	Stored procedure: 	sp_consu_pro				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     					*/
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
/*	Este programa agrupa los comprobantes auxiliares y los pasa	*/
/*      a definitivos.                                                  */
/*	                                        			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

set nocount on
go

select sc_producto,		sc_fecha_tran,		sc_comprobante,
		 sc_oficina_orig,	sc_area_orig,		sc_perfil,
		 sa_oficina_dest,	sa_area_dest,
		 sa_cuenta,			sa_tipo_doc,
		 sa_debito,
		 sa_credito,
		 sa_debito_me,
		 sa_credito_me,
		 sa_concepto = '(%'+ convert(varchar(4),sc_producto) + '-' + convert(varchar(4),sc_automatico) + '%)'+sa_concepto,
		 sc_descripcion
into   #_tmp
from   cob_interfase..ct_scomprobante, cob_interfase..ct_sasiento 
where  1=2

if exists (select * from sysobjects where name = 'sp_consu_pro')
	drop proc sp_consu_pro
go

create proc sp_consu_pro (
	@i_empresa 	  tinyint	= null,
	@i_digitador	  descripcion	= null
)
as

declare 
	@w_return         	int,
	@w_producto		tinyint,
   	@w_producto_tmp		tinyint,
   	@w_producto_cont	tinyint,
	@w_fecha_tran		datetime,
   	@w_fecha_hoy		datetime

select @w_fecha_hoy = getdate()
       
select distinct sc_producto
into #producto
from #_tmp
declare producto cursor for
select sc_producto
from	#producto

FOR READ ONLY 

open producto

fetch producto into	
@w_producto_cont

while (@@fetch_status = 0)
begin
	exec @w_return = cob_conta..sp_consu 
      		@i_empresa     = @i_empresa,
      		@i_digitador   = @i_digitador,
      		@i_producto    = @w_producto_cont

      if @w_return <> 0 
          return 1
          
          
	fetch producto into 	@w_producto_cont	
end /*cursor producto*/
close producto
deallocate producto
return 0
go


