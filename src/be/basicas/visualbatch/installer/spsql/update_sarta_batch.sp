/************************************************************************/
/*	Archivo: 		upgrade.sp 			        */
/*	Stored procedure: 	sp_update_sarta_batch      		*/
/*	Base de datos:  	cobis   				*/
/*	Producto:               cobis                    		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     3-Junio-2002 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa realiza las actualizaciones de los campos         */
/*      sb_left, sb_top, sb_lote_inicio de la tabla ba_sarta_batch      */
/*      para poder graficarlos en el modulo batch                       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		        RAZON			*/
/*	3/JUN/02	Geovanna Landazuri      Emision Inicial		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_update_sarta_batch')
	drop proc sp_update_sarta_batch

go

create proc sp_update_sarta_batch   (
    @t_show_version  bit = 0,    --show the version of the stored procedure
	@s_ssn		  int = null,
	@s_date		  datetime = null,
	@s_user		  varchar(14) = null,
	@s_term		  varchar(64) = null,
	@s_corr		  char(1) = null,
	@s_ssn_corr       int = null,
	@s_ofi		  smallint = null,
	@t_rty            char(1) = null,
	@t_trn		  smallint = 802,
	@t_debug	  char(1) = 'N',
	@t_file		  varchar(14) = null,
	@t_from		  varchar(30) = null

)
as 

declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* descripcion del stored procedure*/
	@w_sarta   	  int,
        @w_batch          int,
	@w_secuencial  	  int,
        @w_left           int,
	@w_top   	  int,
        @w_lote_inicio    int,

        @w_vlx            int,
        @w_vly            int,
        @w_contador       int          


select @w_today = getdate()
select @w_sp_name = 'sp_update_sarta_batch'

--------------------------------- VERSIONAMIENTO DE PROGRAMA ---------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure='+convert(varchar(30),@w_sp_name) + ' Version=4.0.0.0'
   return 0
end
----------------------------------------------------------------------------------------------

select @w_contador = 0

/* Actualizacion de los campos left, top y lote_inicio de los registros ya existentes*/
/** Upgrade tabla ba_sarta_batch **/

select @w_vlx = 500
select @w_vly = 550

print 'Recorriendo registros de sarta_batch'
declare cursor_sarta cursor for
select distinct
       sb_sarta
from cobis..ba_sarta_batch
for read only

open cursor_sarta

fetch cursor_sarta into
      @w_sarta


      while (@@fetch_status = 0)
      begin

      /*recorrer los registros de ese lote*/   

      print 'Actualizando campos del lote ' + convert(varchar(10),@w_sarta)

        declare cursor_upgrade cursor for
        select sb_secuencial,
               sb_left,
               sb_top,
               sb_lote_inicio  
	from cobis..ba_sarta_batch
        where sb_sarta = @w_sarta
        order by sb_secuencial   
	for read only

	open cursor_upgrade

	fetch cursor_upgrade into
	      @w_secuencial,
              @w_left,
              @w_top,
              @w_lote_inicio     

	      while (@@fetch_status = 0)
	      begin

              if @w_left is NULL or @w_top is NULL 
              begin
                update cobis..ba_sarta_batch 
                set sb_left = @w_vlx,
  		    sb_top = @w_vly,
		    sb_lote_inicio = @w_sarta
                where sb_sarta = @w_sarta
                  and sb_secuencial = @w_secuencial

                if @@rowcount = 1
                   select @w_contador = @w_contador + 1
                select @w_vlx = @w_vlx + 1500
                print convert(varchar(5),@w_contador) + ' Registro actualizado'
              end    
               
              
	fetch cursor_upgrade into
	      @w_secuencial,
              @w_left,
              @w_top,
              @w_lote_inicio     

	      end  --end de while

       close cursor_upgrade
       deallocate cursor_upgrade

      /* * * * */ 
      if @w_contador = 0
         print 'No existen registros para actualizar'

      select @w_vlx = 500
      select @w_contador = 0   
      print ''
fetch cursor_sarta into
      @w_sarta

      end  --end de while

      close cursor_sarta
      deallocate cursor_sarta

print 'fin'
--return 0

go

