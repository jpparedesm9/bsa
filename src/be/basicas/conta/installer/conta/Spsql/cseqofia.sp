/************************************************************************/
/*	Archivo: 		cseqofia.sp				*/
/*	Stored procedure: 	sp_cseq_ofi_ar				*/
/*	Base de datos:  	cob_conta                               */
/*	Producto: 		Contabilidad				*/
/*	Disenado por:  		Gonzalo Jaramillo                       */
/*	Fecha de documentacion:	17/Nov/93				*/
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
/*      Retornar un nuevo secuencial para la fecha, oficina, area       */
/*      y proceso.                                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      02/Marz/2000    V.Narvaez       Emision Inicial                 */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cseq_ofi_ar')
	drop proc sp_cseq_ofi_ar
go

create proc sp_cseq_ofi_ar(
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@i_tabla 	        varchar(30) = null, 
	@i_empresa              tinyint,           
	@i_fecha                datetime,         
        @i_oficina              smallint,
        @i_area                 smallint,
        @i_proceso              int,
	@o_siguiente 		int=null out
	)
as
declare @w_return       int,
        @w_sp_name      varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cseq_ofi_ar'


begin tran
   if not exists (select co_siguiente
                    from cob_conta..cb_consecutivo
		   where co_empresa = @i_empresa
		     and co_fecha   = @i_fecha
		     and co_oficina = @i_oficina
		     and co_area    = @i_area
		     and co_proceso = @i_proceso)
   begin
      insert into cob_conta..cb_consecutivo (co_empresa, co_fecha, co_oficina, co_area, 
                                   co_proceso, co_siguiente)
      values (@i_empresa, @i_fecha, @i_oficina, @i_area,
              @i_proceso, 1)
    		select @o_siguiente = 1
   end
   else
   begin 
      /* retornar el nuevo secuencial */
      select @o_siguiente = co_siguiente + 1
        from cob_conta..cb_consecutivo
       where co_empresa = @i_empresa
	 and co_fecha   = @i_fecha
	 and co_oficina = @i_oficina
	 and co_area    = @i_area
	 and co_proceso = @i_proceso
        
      /* mensaje si secuencial llega al limite */
      if @o_siguiente = 2147483647
         print 'Secuencial llego al limite'

      /* sumar uno al secuencial de la tabla */
      update cob_conta..cb_consecutivo
	 set co_siguiente = @o_siguiente
       where co_empresa = @i_empresa
	 and co_fecha   = @i_fecha
	 and co_oficina = @i_oficina
	 and co_area    = @i_area
	 and co_proceso = @i_proceso

      /* si no se puede realizar la modificacion, error */
      if @@error != 0
      begin
        exec cobis..sp_cerror
        @t_debug = @t_debug,
   	@t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105001
       	return 1
      end

end
commit tran
return 0
go
