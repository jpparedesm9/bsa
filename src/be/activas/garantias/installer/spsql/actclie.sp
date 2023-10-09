/************************************************************************/
/*	Archivo:		actclie.sp        			*/
/*	Stored procedure:	sp_gar_actualiza_cliente                */
/*	Base de datos:		cob_csutodia                            */
/*	Producto: 		Custodia				*/
/*	Disenado por:  		Patricia Garzon                         */
/*	Fecha de escritura:	Agost 2000  				*/
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
/*	                                                                */ 
/*	Actualiza el nombre del cliente desde un proceso del Mis        */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_gar_actualiza_cliente')
	drop proc sp_gar_actualiza_cliente
go

create proc sp_gar_actualiza_cliente(
        @i_fecha		datetime = null,
        @o_num_reg              int = null out)
as
declare @w_sp_name		descripcion,
        @w_operacionca          int,
	@w_return		int,
        @w_error                int,
        @w_ente                 int,
        @w_fecha                datetime,
        @w_nombre               descripcion,
        @w_oficial              descripcion,
        @w_contador             int



/*  NOMBRE DEL SP Y FECHA DE HOY */
select	@w_sp_name = 'sp_gar_actualiza_cliente'
select  @w_contador = 0


declare actualiza cursor for
        select ac_ente,ac_fecha,ac_valor_nue
          from cobis..cl_actualiza
         where ac_tabla = 'cl_ente'
           and ac_campo = 'en_nomlar'
           and ac_transaccion = 'U'
           and ac_fecha = @i_fecha
           for read only
    
       open actualiza

       fetch actualiza into
       @w_ente,@w_fecha,@w_nombre


       while (@@fetch_status = 0 ) begin
       
       if @@fetch_status = -1 begin    /* error en la base */
          select @w_error = 1909001
          goto  ERROR
       end      

           update cob_custodia..cu_cliente_garantia
              set cg_nombre = @w_nombre
            where cg_ente   = @w_ente

	    if @@error <> 0 begin
             select @w_error = 1905001
             goto ERROR
            end

      select @w_contador = @w_contador +1
 
      fetch actualiza into
      @w_ente,@w_fecha,@w_nombre
     end

     close actualiza
     deallocate actualiza



--Cursor Actualizacion Oficial

declare actualiza_oficial cursor for
       select ac_ente,ac_fecha,ac_valor_nue
         from cobis..cl_actualiza
        where ac_tabla = 'cl_ente'
          and ac_campo = 'en_oficial'
          and ac_transaccion = 'U'
          and ac_fecha = @i_fecha
          for read only
    
       open actualiza_oficial

       fetch actualiza_oficial into
       @w_ente,@w_fecha,@w_oficial


       while (@@fetch_status = 0 ) begin
       
       if @@fetch_status = -1 begin    /* error en la base */
          select @w_error = 1909001
          goto  ERROR
       end      


           update cob_custodia..cu_cliente_garantia
              set  cg_oficial = isnull(convert(smallint,@w_oficial),cg_oficial)
            where cg_ente   = @w_ente

           if @@error <> 0 begin
            select @w_error = 1905001
            goto ERROR
           end


      select @w_contador = @w_contador +1

 
      fetch actualiza_oficial into
      @w_ente,@w_fecha,@w_oficial
     end

     close actualiza_oficial
     deallocate actualiza_oficial


select @o_num_reg = @w_contador

select @o_num_reg

return 0

ERROR:
exec cobis..sp_cerror
@t_debug = 'N',
@t_file  = null,
@t_from  = @w_sp_name,
@i_num   = @w_error
return @w_error         

go


