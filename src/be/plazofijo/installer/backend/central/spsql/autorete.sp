/************************************************************************/
/*      Archivo:                autorete.sp                             */
/*      Stored procedure:       sp_autoretenedor                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 10-Abr-2001                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa actualiza pf_operacion..op_autoretenedor y        */
/*      pf_operacion..op_fecha_autoret, con el fin de conocer si el     */
/*      cliente es autoretenedor para no descontar de los intereses     */
/*      el valor establecido para la retencion en la fuente.            */
/*      Este programa procesara la transaccion de Update a pf_operacion */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR                RAZON                           */
/*      15/Jul/2009 Y. Martinez		Creación                        */  
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_autoretenedor')
   drop proc sp_autoretenedor
go

create proc sp_autoretenedor (
		@s_ssn                  int = null,
		@s_user                 login = null,
		@s_term                 varchar(30) = null,
		@s_date                 datetime = null,
		@s_srv                  varchar(30) = null,
		@s_lsrv                 varchar(30) = null,
		@s_ofi                  smallint = null,
		@s_rol                  smallint = NULL,
		@t_debug                char(1) = 'N',
		@t_file                 varchar(10) = null,
		@t_from                 varchar(32) = null,
		@t_trn                  smallint = null,
                @i_num_banco            cuenta,  
		@i_operacion            char(1), --'U' update
		@i_autoretenedor        char(1)
)
with encryption
as
declare         @w_sp_name              varchar(32),
		@w_autoretenedor        char(1),  
		@w_fecha_autoret        datetime,
                @w_num_banco            cuenta,  
                @w_error                int,
                @w_operacionpf          int,
                @w_int_estimado         money,
                @w_retieneimp           char(1),
                @w_fpago                catalogo,
                @w_fecha_ult_pg_int     datetime,
                @w_fecha_pg_int         datetime,
/* VARIABLES PARA PF_DET_PAGO */
                @w_count                int,
                @w_contador             int,
                @w_dp_secuencia         int,
                @w_dp_monto             money,
                @w_sum_dp_monto         money,
                @w_porcent              numeric(20,2),
                @w_new_valor            money,
                @w_op_ente		int,
		@w_op_num_cta		cuenta,
		@w_retienimp		varchar(5)	

select @w_sp_name = 'sp_autoretenedor'

if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file = @t_file
	 select '/** Stored Procedure **/ '= @w_sp_name,
		s_ssn                      = @s_ssn,
		s_user                     = @s_user,
		s_term                     = @s_term,
		s_date                     = @s_date,
		s_srv                      = @s_srv,
		s_lsrv                     = @s_lsrv,
		s_ofi                      = @s_ofi,
		s_rol                      = @s_rol,
		t_trn                      = @t_trn,
		t_file                     = @t_file,
		t_from                     = @t_from,
                i_num_banco                = @i_num_banco,
                i_operacion                = @i_operacion,
                i_autoretenedor            = @i_autoretenedor 

    exec cobis..sp_end_debug
end

if (@t_trn <> 14246 or @i_operacion <> 'U') 

begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
          return 1
end

select @w_fecha_autoret = @s_date

/** Update **/
If @i_operacion = 'U'
  begin

    select @w_operacionpf        = op_operacion,
           @w_retieneimp         = op_retienimp,
           @w_int_estimado       = op_int_estimado,
           @w_fpago              = op_fpago,
           @w_fecha_ult_pg_int   = op_fecha_ult_pg_int, 
           @w_fecha_pg_int       = op_fecha_pg_int,
           @w_op_ente		 = op_ente,
	   @w_op_num_cta	 = op_num_banco 
    from pf_operacion
    where  op_num_banco = @i_num_banco 
    
    /* Si no existe, error */ 

    if @@rowcount = 0
       begin
           exec cobis..sp_cerror 
                @t_debug = @t_debug, 
                @t_file  = @t_file,
                @t_from  = @w_sp_name, 
                @i_num   = 141004
           return 1
       end  
      
     begin tran

     /* Modificacion de los datos de pf_operacion */
     
     if @i_autoretenedor = 'S'
     	select @w_retienimp = 'N'
     else
     	select @w_retienimp = 'S'
     
     update pf_operacion
     set    op_autoretenedor   = @i_autoretenedor,
            op_fecha_autoret   = @w_fecha_autoret,
            op_retienimp       = @w_retienimp
     where  op_operacion = @w_operacionpf
     
     /* Si no se puede modificar,error */

        if @@error <> 0
          begin
            select @w_error = 145001
            goto ERROR
          end 
     /* Fin modificacion de los datos de pf_operacion */

	insert into ts_autoretenedor (
				secuencial, 		tipo_transaccion, 	clase, 
			      	fecha,			usuario,		terminal,	
				srv,			lsrv,			autoretenedor,   		
				fecha_autoret,   	retienimp,       	monto,
				ente,			num_cuenta)		
			values	(@s_ssn,		@t_trn,			'N',
				@s_date,		@s_user,		@s_term,
				@s_srv,  		@s_lsrv,		@i_autoretenedor,
				@w_fecha_autoret,	'N',			@w_new_valor,
				@w_op_ente,		@w_op_num_cta)

      	if @@error <> 0          
      	begin                    
	 	exec cobis..sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          =143005
		/*'Error en creacon de transaccion de servicio'*/
	  	return 1         
      	end                      


  commit tran
end /* fin de if @i_operacion = U */   

return 0
ERROR:
      exec cobis..sp_cerror 
           @t_debug=@t_debug,
           @t_file=@t_file,
           @t_from=@w_sp_name,
           @i_num = @w_error
      return 1
go  

