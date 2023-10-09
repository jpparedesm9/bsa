/************************************************************************/
/*      Archivo:                anula_op_ren.sp                         */
/*      Stored procedure:       sp_anulacion_op_ren                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ricardo Martinez                        */
/*      Fecha de documentacion: 28/sep/2009                             */
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
/*      Este script crea los procedimientos para las anulaciones de     */
/*      operaciones de plazos fijos.                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      28-Sep-2009  Ricardo Martinez   Creacion                        */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_anulacion_op_ren')
   drop proc sp_anulacion_op_ren
go
create proc sp_anulacion_op_ren (
      @s_ssn                  int            = NULL,
      @s_user                 login          = 'SYSTEM',
      @s_term                 varchar(30)    = 'CONSOLA',
      @s_date                 datetime       = NULL,
      @s_sesn                 int            = NULL,
      @s_srv                  varchar(30)    = NULL,
      @s_lsrv                 varchar(30)    = NULL,
      @s_ofi                  smallint       = NULL,
      @s_rol                  smallint       = NULL,
      @t_debug                char(1)        = 'N',
      @t_file                 varchar(10)    = NULL,
      @t_from                 varchar(32)    = NULL,
      @t_trn                  smallint       = NULL,
      @i_observacion          descripcion    = NULL,
      @i_empresa              tinyint        = 1,
      @i_en_linea             char(1)        = 'S',
      @i_login_captador       login          = NULL
)
with encryption
as
declare 
  @w_sp_name             varchar(32),
  @w_return              int,
  @w_secuencial          int,
  @w_ofi                 smallint ,
  @w_num_banco           cuenta,
  @w_historia		int,
  @w_operacionpf	int, 
  @w_valor		money,
  @w_re_estado		varchar(10)
  
select @w_sp_name = 'sp_anulacion_op_ren',
       @w_secuencial = @s_ssn

if @s_ssn is null
begin
  exec @w_secuencial=sp_gen_sec 
  select @s_ssn = @w_secuencial
end 

-- cursor que reversa DECREMENTOS

declare cursor_operacion_decre cursor
for  	select 	op_num_banco,re_oficina  
	from 	pf_emision_cheque,
		pf_operacion,
		pf_renovacion
	where 	op_operacion = ec_operacion
	and	op_operacion = re_operacion
	and	ec_fecha_mov 	= @s_date
	and	ec_tran     	= 14904
	and	ec_fpago 	in ('EFEC')
	and	ec_tipo 	= 'C'
	and	ec_caja 	= null
	and	ec_fecha_caja 	= null
        and     re_estado 	= 'A'
for update

open cursor_operacion_decre

/** LECTURA DEL PRIMER REGISTRO **/
fetch cursor_operacion_decre into
   @w_num_banco,@w_ofi

while (@@fetch_status = 0)
begin          


if @t_debug = 'S' print 'Entro a Reverso Decrementos op : ' + cast (@w_num_banco as varchar)

     exec @w_return=sp_reverso_renovacion
          @s_ssn        = @s_ssn,
          @s_user       = @s_user,
          @s_term       = @s_term,
          @s_date       = @s_date,
          @s_srv        = @s_srv,
          @s_lsrv       = @s_lsrv,
          @s_ofi        = @w_ofi,
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,   
          @i_num_banco  = @w_num_banco,
          @i_autorizado = @s_user,
          @t_trn        = 14929

     if @w_return <> 0
     begin       
        goto ERROR1       
     end       

     GOTO SIGUIENTE1  

ERROR1:
BEGIN TRAN
  exec sp_errorlog @i_fecha = @s_date,     
                   @i_error = @w_return, @i_usuario=@s_user,     
                   @i_tran=@t_trn,@i_operacion=@w_num_banco       
COMMIT TRAN                   
SIGUIENTE1:
   fetch cursor_operacion_decre into
       @w_num_banco,@w_ofi

end /*end del while*/    

close cursor_operacion_decre
deallocate cursor_operacion_decre

----------------------------------------------------------

-- cursor que reversa INCREMENTOS

declare cursor_operacion cursor
for  select op_num_banco, op_oficina  , op_historia, op_operacion, st_valor
     from   pf_operacion,pf_secuen_ticket
     where  st_operacion  =   op_operacion
     and    st_estado     = 'I'
     and    st_fpago      in('EFEC')
     and    op_estado     IN( 'ACT','VEN')
for update

open cursor_operacion

/** LECTURA DEL PRIMER REGISTRO **/
fetch cursor_operacion into
   @w_num_banco,@w_ofi, @w_historia, @w_operacionpf, @w_valor

while (@@fetch_status = 0)
begin          


if @t_debug = 'S' print 'Entro a Reverso Incrementos  op : ' + cast (@w_num_banco as varchar)


	select @w_re_estado = ''
	
	select @w_re_estado = isnull(re_estado,'')
		from	pf_renovacion
		where	re_operacion 	= @w_operacionpf
		and	re_estado 	in ( 'I','A')
		and	re_fecha_crea 	= @s_date

if @t_debug = 'S' print 'w_re_estado : ' + cast (@w_re_estado as varchar)

	
	if @w_re_estado = 'I'	
	begin		
		
	
		/* Insercion en pf_historia*/
		insert pf_historia (hi_operacion,     hi_secuencial, hi_fecha,
	                          hi_trn_code,      hi_funcionario, hi_oficina,
	                          hi_observacion,   hi_fecha_crea, hi_fecha_mod, 
	                          hi_valor)
	                  values (@w_operacionpf,     @w_historia,   @s_date,
	                          14995,      @s_user,       @s_ofi, 
	                          'REVERSO DE INCREMENTO',   @s_date,       @s_date, 
	                           @w_valor) 
	        if @@error <> 0
	        	goto ERROR       
	
	      	update 	pf_operacion
		    set     op_historia    = @w_historia + 1,
			        op_accion_sgte = null,
			        op_causa_mod   = 'ING'
	      	where 	op_operacion   = @w_operacionpf
	
	      	if @@error <>0
	        	goto ERROR       
	
		delete	pf_secuen_ticket
		from   	pf_operacion,pf_secuen_ticket
		where  	st_operacion  	=   op_operacion
		and    	st_estado     	= 'I'
		and    	st_fpago      	in('EFEC')
		and    	op_estado     	in('ACT','VEN')
		and	op_operacion	= @w_operacionpf	
	
	      	if @@error <>0
	        	goto ERROR       
	
	
		update	pf_mov_monet
		set	mm_estado  =  'R'
		where 	mm_operacion 	= @w_operacionpf
		and	mm_tran 	= 14904
		and	mm_estado  	= NULL
		--and	mm_producto 	in ('EFEC')
		--and	mm_valor 	= @w_valor
		and	mm_fecha_crea   = @s_date
		and	mm_tipo 	= 'B'
		
	      	if @@error <>0
	        	goto ERROR       
		
		
		update	pf_renovacion
		set	re_estado 	= 'R'
		where	re_operacion 	= @w_operacionpf
		and	re_estado 	= 'I'
		and	re_fecha_crea 	= @s_date
	
	      	if @@error <>0
	        	goto ERROR       
	
	
		update	pf_det_pago
		set	dp_estado 	= 'R',
			dp_estado_xren  = 'S'
		where 	dp_operacion 	= @w_operacionpf
		and 	dp_estado_xren 	= 'S'
		and	dp_estado 	= 'I'
		and	dp_fecha_crea   = @s_date
	
	      	if @@error <>0
	        	goto ERROR       
	
		
	
	
		update	pf_beneficiario
		set	be_estado_xren 	= 'R',
			be_estado 	= 'E'
		where be_operacion 	= @w_operacionpf
		and	be_estado_xren 	= 'S'
		and	be_estado 	= 'I'
		and	be_fecha_crea 	= @s_date
	
	      	if @@error <>0
	        	goto ERROR       
	
	
	end

	if @w_re_estado = 'A'	
	begin		

		exec @w_return=sp_reverso_renovacion
			@s_ssn        = @s_ssn,
			@s_user       = @s_user,
			@s_term       = @s_term,
			@s_date       = @s_date,
			@s_srv        = @s_srv,
			@s_lsrv       = @s_lsrv,
			@s_ofi        = @w_ofi,
			@t_debug      = @t_debug,
			@t_file       = @t_file,
			@t_from       = @w_sp_name,   
			@i_num_banco  = @w_num_banco,
			@i_autorizado = @s_user,
			@t_trn        = 14929
		
		if @w_return <> 0
		begin       
			goto ERROR       
		end       

	end

     	GOTO SIGUIENTE  

ERROR:
BEGIN TRAN
  exec sp_errorlog @i_fecha = @s_date,     
                   @i_error = @w_return, @i_usuario=@s_user,     
                   @i_tran=@t_trn,@i_operacion=@w_num_banco       
COMMIT TRAN                   
SIGUIENTE:
   fetch cursor_operacion into
   @w_num_banco,@w_ofi, @w_historia, @w_operacionpf, @w_valor

end /*end del while*/    

close cursor_operacion
deallocate cursor_operacion
return 0
go


