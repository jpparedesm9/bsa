/************************************************************************/
/*	Archivo: 		bancconc.sp 			        */
/*	Stored procedure: 	sp_banco_conciliado  			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Sandra Robayo                   	*/
/*	Fecha de escritura:     02-Dic-1999 				*/
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
/*	Este programa maneja las cuentas conciliadas para un banco      */
/*	en un mes determinado.                                          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	02/Dic/1999	Sandra Robayo   Emision Inicial                 */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_banco_conciliado')
	drop proc sp_banco_conciliado

go
create proc sp_banco_conciliado   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 605,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion    char(1) = null,
        @i_modo         tinyint = null,
        @i_empresa	tinyint = null,
	@i_banco 	varchar(3) = null,
        @i_cuenta       cuenta = null,
        @i_cuenta_siguiente       cuenta = null,
        @i_fecha        datetime = null,
        @i_formato_fecha	 smallint =null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_empresa	tinyint,
        @w_banco        varchar(3),
	@w_cuenta	cuenta,
        @w_existe       int,               /*Codigo existe = 1*/
        @w_fecha        datetime

select @w_today = getdate()
select @w_sp_name = 'sp_banco_conciliado'




/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6769 and @i_operacion = 'I') or
   (@t_trn <> 6770 and @i_operacion = 'D') or
   (@t_trn <> 6774 and @i_operacion = 'A') 
    
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1 
end
/************************************************/


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_empresa	= @i_empresa,
		i_banco 	= @i_banco,
		i_cuenta        = @i_cuenta,
                i_fecha         = @i_fecha  
	exec cobis..sp_end_debug
end


/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'A' 
begin
     
    select
         @w_empresa = bc_empresa,
         @w_cuenta = bc_cuenta,
         @w_banco = bc_banco    
    from cob_conta_tercero..ct_banco_conciliado
    where
         bc_empresa = @i_empresa and
         bc_cuenta = @i_cuenta and
         bc_banco = @i_banco   and
         datediff(dd,bc_fecha ,@i_fecha) = 0

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0

end                              
/********************************************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin   
	   if @@rowcount > 0
	   begin
		/* 'existe cuenta para la fecha dada ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603064
		return 1
	   end
   end
   else
   begin

       insert into cob_conta_tercero..ct_banco_conciliado 
         (bc_empresa,
          bc_fecha,
          bc_banco,
          bc_cuenta)
       values
         (@i_empresa,
          @i_fecha,
          @i_banco,
          @i_cuenta)

       if @@error <> 0  
       begin
	    /* 'Error en insercion del detalle del comprobante en la tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603020
       end
   
   end 

end


if @i_operacion = 'D' 
begin

    delete from cob_conta_tercero..ct_banco_conciliado
    where
         bc_empresa = @i_empresa and
         bc_cuenta = @i_cuenta and
         bc_banco = @i_banco   and
         bc_fecha = @i_fecha

end



if @i_operacion = 'A'
begin
    set rowcount 20

    if @i_modo = 0
    begin
  	select convert(char(10),bc_fecha,@i_formato_fecha),
	       bc_cuenta,
               ba_nombre
        from cob_conta_tercero..ct_banco_conciliado, cob_conta..cb_banco
   	where    bc_empresa   = @i_empresa and
                 ba_empresa = bc_empresa and
		 bc_banco     = @i_banco and
                 ba_banco = bc_banco and
                 ba_ctacte = bc_cuenta                                           
	order by bc_fecha, bc_cuenta

   	if @@rowcount = 0
   	begin
           	/*Registro no existe */
            	exec cobis..sp_cerror
        	   @t_debug = @t_debug,
        	   @t_file  = @t_file, 
        	   @t_from  = @w_sp_name,
         	   @i_num   = 603072
        	return 1 
        end
    end
    else 
    begin
  	select convert(char(10),bc_fecha,@i_formato_fecha),
	       bc_cuenta,
               ba_nombre
        from cob_conta_tercero..ct_banco_conciliado, cob_conta..cb_banco
   	where    bc_empresa   = @i_empresa and
                 ba_empresa = bc_empresa and
		 bc_banco     = @i_banco and
                 ba_banco = bc_banco and
                 ba_ctacte = bc_cuenta and
                 ((bc_fecha > @i_fecha and
                   bc_cuenta = @i_cuenta_siguiente) or
                  (bc_fecha > @i_fecha))
	order by bc_fecha, bc_cuenta

	
        if @@rowcount = 0
       	begin
       	    /*Registro no existe */
       	    exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 603072
        	return 1 
    	end
     end

     set rowcount 0

end


return 0
go
