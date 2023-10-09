/************************************************************************/
/*      Archivo:                consolid.sp                             */
/*      Stored procedure:       sp_consolidada                          */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           M.Segura                                */
/*      Fecha de escritura:     23-FEB-1999                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Maneja la asociaci¢n de las cuentas de una empresa consolidadora*/
/*	a una empresa subsidiaria.					*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        	AUTOR           RAZON                           */
/*      23/FEB/1999  	O. Escand¢n     Emision Inicial                 */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_consolidada')
	drop proc sp_consolidada  

go
create proc sp_consolidada   (
	@s_ssn			int 		= null,
	@s_date			datetime 	= null,
	@s_user			login 		= null,
	@s_term			descripcion 	= null,
	@s_corr			char(1) 	= null,
	@s_ssn_corr		int 		= null,
        @s_ofi			smallint 	= null,
	@t_rty			char(1) 	= null,
        @t_trn			smallint 	= 602,
	@t_debug        	char(1) 	= 'N',
	@t_file         	varchar(14) 	= null,
	@t_from         	varchar(30) 	= null,
	@i_modo			int		= null,
	@i_operacion    	char(1) 	= null,
	@i_empresa_consolidada  tinyint 	= null,
	@i_cuenta_consolidadora cuenta 	= null,
	@i_empresa_subsidiaria  tinyint 	= null,
	@i_cuenta_subsidiaria   cuenta 	= null
)
as 
declare
	@w_hoy          	datetime,
	@w_return       	int,
	@w_sp_name      	varchar(32),
	@w_cuenta_consolidadora cuenta,
	@w_cuenta_subsidiaria   cuenta,
        @w_nivel_consolidador   tinyint,
        @w_nivel_subsidiaria    tinyint,
	@w_padre_consolidador   varchar(20),
	@w_padre_subsidiaria    varchar(20),
	@temp_subsidiaria    varchar(20)



	

select @w_hoy = getdate()
select @w_sp_name = 'sp_consolidada'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6798 or @i_operacion <> 'I') and
   (@t_trn <> 6740 or @i_operacion <> 'D') and
   (@t_trn <> 6799 or @i_operacion <> 'Q') 
   
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_empresa_consolidada =  @i_empresa_consolidada,
		i_cuenta_consolidadora = @i_cuenta_consolidadora,
		i_empresa_subsidiaria =  @i_empresa_subsidiaria,
		i_cuenta_subsidiaria =   @i_cuenta_subsidiaria
	exec cobis..sp_end_debug
end


/* Insercion */
/*************************/

if @i_operacion = 'I'
begin
	if exists (select * from cb_cuentas_consolidado 
			where cc_empresa_consolidada = @i_empresa_consolidada
                          and cc_empresa_subsidiaria = @i_empresa_subsidiaria
			  and cc_cuenta_consolidadora = @i_cuenta_consolidadora
                          and cc_cuenta_subsidiaria = @i_cuenta_subsidiaria )
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601160
		return 1
	end
	


	begin tran

          insert into cb_cuentas_consolidado
	         (cc_empresa_consolidada,
	          cc_empresa_subsidiaria,
	          cc_cuenta_consolidadora,
                  cc_cuenta_subsidiaria)
          values (@i_empresa_consolidada,
                  @i_empresa_subsidiaria,
                  @i_cuenta_consolidadora,
                  @i_cuenta_subsidiaria)  

          if @@error <> 0 
	  begin
		/* 'Error en insercion de registro ' */
		--print 'primero'
		exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file,
		   @t_from  = @w_sp_name,
   		   @i_num   = 603059
		return 1
          end

       commit tran
       return 0
end


if @i_operacion = 'D'
   begin 
	select * from cb_cuentas_consolidado 
	 where cc_empresa_consolidada = @i_empresa_consolidada
           and cc_empresa_subsidiaria = @i_empresa_subsidiaria
	   and cc_cuenta_consolidadora = @i_cuenta_consolidadora
           and cc_cuenta_subsidiaria = @i_cuenta_subsidiaria 

   if @@rowcount = 0
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	/*  Eliminacion del registro  */
	/********************************/
        begin tran
        delete cb_cuentas_consolidado
	 where cc_empresa_consolidada = @i_empresa_consolidada
           and cc_empresa_subsidiaria = @i_empresa_subsidiaria
	   and cc_cuenta_consolidadora = @i_cuenta_consolidadora
           and cc_cuenta_subsidiaria = @i_cuenta_subsidiaria 

        commit tran 
       return 0
  end    

if @i_operacion = 'Q'
begin
-- 	if @i_modo = 0

	select cc_empresa_subsidiaria,
	       em_descripcion,
	       cc_cuenta_subsidiaria,
	       cu_nombre	
          from cb_cuentas_consolidado,
	       cb_empresa,
               cb_cuenta 
	 where cc_empresa_consolidada  = @i_empresa_consolidada
	   and cc_cuenta_consolidadora = @i_cuenta_consolidadora
	   and em_empresa = cc_empresa_subsidiaria
           and cu_cuenta = cc_cuenta_subsidiaria
           and cu_empresa = cc_empresa_subsidiaria
	   and cu_movimiento = 'S'

	if @@rowcount = 0
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
end
go

           
