/************************************************************************/
/*	Archivo:		contacal.sp				*/
/*	Stored procedure:	sp_contacal 				*/
/*	Base de datos:		cob_custodia				*/
/*	Producto: 		Garantias        			*/
/*	Disenado por:  		Milena Gonzalez 			*/
/*	Fecha de escritura:	Jul. 2003				*/
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
/*	Genera los tramsacciones contables de Garantias asociadas a ope */
/*	que tienen cambio de calificacion.                              */
/************************************************************************/  
/*                             MODIFICACIONES               		*/
/************************************************************************/  

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_contacal')
   drop proc sp_contacal
go
create proc sp_contacal
   @s_user		login    = null,
   @s_date              datetime = null,
   @s_ofi                smallint   = null,
   @s_term               descripcion = null,  
   @i_filial            int      = null,
   @i_tipo_trn    	catalogo = null,
   @i_fecha      	datetime   = null,
   @i_codigo_valor      int        = null
            
as 
declare 
   @w_error          	int,
   @w_return         	int,
   @w_sp_name        	descripcion,
   @w_money          	money,
   @w_clase_cartera     char(1),
   @w_codigo_externo	varchar(64),
   @w_today             datetime,
   @w_clase             catalogo,
   @w_calificacion      char(1),
   @w_garantia          varchar(64),
   @w_tramite           int,
   @w_operacion         int,
   @w_saldo_obl         money,
   @w_abierta_cerrada   char(1),
   @w_valor             money,
   @w_disponible        money,
   @w_porc_respaldo     float,
   @w_valor_respaldo    money,
   @w_secuencial        int,
   @w_secuencial_rev    int,
   @w_codigo_externo_rev  varchar(64),
   @w_valor_futuros  money,
   @w_codvalorx      int,
   @w_clase_custodia char(1),
   @w_valor_contab   money,
   @w_clase_carterai char(1),
   @w_codvalor      int,
   @w_sec_ini       int,
   @w_sec_fin       int


select 
@w_sp_name         = 'contacal.sp'
select @w_today=convert(varchar(10), getdate(),101)

        declare cur_tramites cursor for
        select  op_tramite
        from cob_credito..cr_calificacion_op,cob_cartera..ca_operacion
        where co_producto = 7
        and op_operacion = co_operacion
        and co_calif_ant <> co_calif_final 
        order by co_operacion
        open cur_tramites

        fetch cur_tramites into 
	@w_tramite

	while @@fetch_status = 0
             begin
	      	if @@fetch_status = -1
		begin
  		  close cur_tramites
		  deallocate cur_tramites
                            rollback
		  return 1
		end


   exec @w_return = cob_custodia..sp_activar_garantia
     @i_opcion         = 'C',
     @i_tramite        = @w_tramite,
     @i_modo           = 2,
     @i_operacion      = 'I',
     @s_date           = @i_fecha,
     @s_user           = "crebatch",
     @s_term           = @s_term,
     @s_ofi            = @s_ofi  ,
     @i_viene_modvalor = 'S'

    if @w_return != 0
    begin
       PRINT 'salio por error de cob_custodia..sp_activar_garantia ' + cast(@w_return as varchar)
       return @w_return
     end 


	fetch cur_tramites into   
        @w_tramite

 	end   	
     
        close cur_tramites
   	deallocate cur_tramites


return 0

ERROR: 
    return @w_error 

go