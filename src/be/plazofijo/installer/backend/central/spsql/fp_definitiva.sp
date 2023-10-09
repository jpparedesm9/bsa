/************************************************************************/
/*      Archivo:                fp_definitiva.sp                        */
/*      Stored procedure:       sp_fp_definitiva                        */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 07-Nov-94                               */
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
/*      Este programa mueve la informacion de las tablas temporales     */
/*      de operaciones de plazo fijo nuevas a las tablas definitivas    */
/*      realizando la funcion completa de modificar fp y condiciones    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      07-Nov-94  Ricardo Valencia   Creacion                          */
/*      25-Nov-94  Juan Jose Lam      Modificacion                      */
/*      22-Ago-95  Carolina Alvarado  Activacion Automatica             */
/*                               Grabacion de Condiciones y detalles    */
/*                               Grabacion de detalle de cheques        */
/*      17-Ago-01  Memito Saborio    Inclusion de un campo nuevo que    */
/*                                   lleva una instruccion especial.    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_fp_definitiva')
   drop proc sp_fp_definitiva
go

create proc sp_fp_definitiva (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_cuenta               cuenta,
@i_moneda_pg   	        char(2)         = NULL,
@i_autoriza_pago_otros  login           = NULL,
@i_instruccion_especial varchar(255)    = NULL)   -- Por JSA el 17/08/2001
with encryption
as
declare 
@w_sp_name              varchar(32),
@w_return               int,
@w_historia             int,
@w_operacionpf          int,
@w_estado_xren          char(1),
@w_pt_beneficiario	    int,
@w_sec1                 smallint,
@w_pt_tipo              catalogo,
@w_pt_forma_pago	    catalogo,
@w_pt_cuenta    	    cuenta,   
@w_pt_monto             money,
@w_pt_porcentaje	    float,
@w_pt_fecha_crea	    datetime, 
@w_pt_fecha_mod		    datetime,
@w_pt_moneda_pago       smallint,
@w_pt_oficina           int,
@w_pt_tipo_cliente      char(1),
@w_pt_tipo_cuenta_ach   char(1),
@w_pt_banco_ach         descripcion,
@w_co_condicion			smallint,
@w_co_comentario		varchar(60),
@w_co_fecha_crea		datetime,
@w_co_fecha_mod			datetime,
@w_dt_condicion			smallint,
@w_dt_ente			    int,
@w_dt_fecha_crea		datetime,
@w_dt_fecha_mod         datetime 	

select
@w_sp_name     = 'sp_fp_definitiva',
@w_estado_xren ='N'

/**  VERIFICAR CODIGO DE TRANSACCION DE CAMBIO  **/
if   @t_trn <> 14942 
begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
   return 1
end 


/**  LECTURA DE DATOS DE LA OPERACION DE PLAZO FIJO EN TABLA TEMPORAL  **/

select @w_operacionpf        = op_operacion,
       @w_historia	     = op_historia
from   pf_operacion
where  op_num_banco        = @i_cuenta

if @@rowcount = 0
  begin
     exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                           @t_from  = @w_sp_name, @i_num   = 141004
     return 1
  end

/*** Elimino registros anteriores ****/

delete pf_det_pago where dp_operacion = @w_operacionpf and dp_tipo = 'INT'


     select @w_sec1 = isnull(max(dp_secuencia),0)+1 from pf_det_pago
		where dp_operacion = @w_operacionpf
     select @w_pt_beneficiario = 0
     while 6=6
	   begin
	set rowcount 1 
	select @w_pt_beneficiario     = dt_beneficiario,
		@w_pt_tipo            = dt_tipo,
		@w_pt_forma_pago      = dt_forma_pago,
		@w_pt_cuenta          = dt_cuenta,
		@w_pt_monto           = dt_monto,
		@w_pt_porcentaje      = dt_porcentaje,
		@w_pt_fecha_crea      = dt_fecha_crea,
		@w_pt_fecha_mod       = dt_fecha_mod,
                @w_pt_moneda_pago     = dt_moneda_pago,  -- GES 04/03/01 CUZ-002-080
                @w_pt_oficina         = dt_oficina,--GAR 18-mar-2005 GB-DP00008 DP00057
                @w_pt_tipo_cliente    = dt_tipo_cliente,--GAR 18-mar-2005 GB-DP00008 DP00057
                @w_pt_tipo_cuenta_ach = dt_tipo_cuenta_ach,
                @w_pt_banco_ach       = dt_banco_ach
	from pf_det_pago_tmp
	where dt_usuario = @s_user 
	  and dt_sesion = @s_sesn 
	  and	dt_beneficiario >= @w_pt_beneficiario 
	  and	dt_operacion = @w_operacionpf
	order by dt_beneficiario	
	if @@rowcount = 0
		break
	
	set rowcount 0

	insert pf_det_pago (
                dp_operacion,          dp_ente,            dp_tipo,          dp_secuencia,         dp_forma_pago,    
                dp_cuenta,             dp_monto,           dp_porcentaje,    dp_fecha_crea,        dp_fecha_mod,
                dp_estado_xren,        dp_estado,          dp_moneda_pago,   dp_oficina,           dp_tipo_cliente,
                dp_tipo_cuenta_ach,    dp_banco_ach)
	  values(
                @w_operacionpf,        @w_pt_beneficiario, @w_pt_tipo,        @w_sec1,              @w_pt_forma_pago,
                @w_pt_cuenta,          @w_pt_monto,        @w_pt_porcentaje,  @s_date,              @s_date,
                @w_estado_xren,        'I',                @w_pt_moneda_pago, @w_pt_oficina,        @w_pt_tipo_cliente,
                @w_pt_tipo_cuenta_ach, @w_pt_banco_ach)

	if @@error <> 0
         begin
           exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
             @t_from=@w_sp_name,   @i_num = 143038
           select @w_return = 1
           goto borra
         end   
	
	 insert into ts_det_pago (secuencial, tipo_transaccion,clase,fecha,
			usuario,terminal,srv,lsrv,operacion,ente,tipo,
			forma_pago,cuenta,monto,porcentaje,fecha_crea,
                        fecha_mod, moneda_pago, oficina)
                values  (@s_ssn, @t_trn, 'N', @s_date, @s_user, @s_term,
                        @s_srv,@s_lsrv,@w_operacionpf,@w_pt_beneficiario,
			@w_pt_tipo,@w_pt_forma_pago,@w_pt_cuenta,
			@w_pt_monto,
			@w_pt_porcentaje,@s_date,@s_date, @w_pt_moneda_pago, @w_pt_oficina)                 

   	/* Si no se puede insertar error */
    	if @@error <> 0
     		begin
       		exec cobis..sp_cerror
         	@t_debug       = @t_debug,
         	@t_file        = @t_file,
         	@t_from        = @w_sp_name,
         	@i_num         = 143005
                select @w_return = 1
        	goto borra
     		end

        delete pf_det_pago_tmp
	   where dt_usuario = @s_user and
                dt_sesion = @s_sesn and
                dt_beneficiario = @w_pt_beneficiario and
                dt_operacion = @w_operacionpf and
		dt_forma_pago = @w_pt_forma_pago and
		dt_cuenta = @w_pt_cuenta and
 	/*      dt_monto = @w_pt_monto and    */
		dt_tipo = @w_pt_tipo and
		dt_porcentaje = @w_pt_porcentaje

	  if @@error <> 0
                begin
                exec cobis..sp_cerror
                @t_debug       = @t_debug,
                @t_file        = @t_file,
                @t_from        = @w_sp_name,
                @i_num         = 145005
                select @w_return = 1
                goto borra
                end  
	set rowcount 0 
	select @w_sec1 = @w_sec1 + 1 
      end /*  While 6  */
  update pf_operacion set op_moneda_pg = @i_moneda_pg,
		          op_historia = op_historia +1,
			  op_fecha_mod = @s_date
			where op_operacion = @w_operacionpf
  if @@rowcount = 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      select @w_return = 1
      goto borra
    end
  insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco, operacion)
                   values (@s_ssn, @t_trn,'A',
     @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_cuenta, @w_operacionpf)

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
      select @w_return = 1
      goto borra
    end

  	insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
         	hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
         	hi_fecha_crea, hi_fecha_mod) 
              	values (@w_operacionpf, @w_historia,@s_date,
         	14942,0, @s_user, @s_ofi,
         	@s_date,@s_date)
	
  	if @@error <> 0
    	begin
      		exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
       	    	@t_from=@w_sp_name,   @i_num = 143006
      		select @w_return = 1
      		goto borra
    	end

        if @i_autoriza_pago_otros IS  NOT NULL
           begin
              insert pf_autorizacion (au_operacion,au_autoriza,au_oficina,
                     au_tautorizacion,au_fecha_crea,au_num_banco,au_oficial)
              values (@w_operacionpf,@i_autoriza_pago_otros,@s_ofi,'PGOC',
                     @s_date, @i_cuenta,@s_user)
              if @@error <> 0
              begin
                 exec cobis..sp_cerror @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 143040
                    select @w_return = 1
                    goto borra
              end
        end

  /*** Se inserta las instrucciones en la tabla de instrucciones de la operaci=n ***
   *** JSA >>>>>>>> 18-ago-2001, segun DP-000073                                 ***/
  if @i_instruccion_especial is not null 
  begin 
  	if exists(select * from pf_instruccion where in_operacion = @w_operacionpf and isnull(in_estadoxren,'N') = 'N') 
  	begin
	    update pf_instruccion
  	  set in_instruccion = @i_instruccion_especial,
		in_fecha_mod	= @s_date
    	where in_operacion = @w_operacionpf
      	and isnull(in_estadoxren,'N') = 'N'    
      
    	if @@error <> 0 
    	begin
      	--print 'error inspfdef'
	      exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                            @t_from  = @w_sp_name, @i_num   = 145045
  	    select @w_return = 1
    	  goto borra
	    end

  	  insert into ts_instruccion (secuencial, tipo_transaccion,clase,fecha,
    	      usuario,terminal,srv,lsrv,operacion,instruccion)
	    values  (@s_ssn, 14238, 'N', @s_date, @s_user, @s_term,
  	        @s_srv,@s_lsrv,@w_operacionpf,@i_instruccion_especial)
    	/* Si no se puede insertar error */
	    if @@error <> 0
  	  begin
    	  exec cobis..sp_cerror
      	   @t_debug       = @t_debug,
        	 @t_file        = @t_file,
	         @t_from        = @w_sp_name,
  	       @i_num         = 143005
    	  select @w_return = 1
      	goto borra
	    end   
  	end
  	else 
  	begin
    	insert pf_instruccion(in_operacion, in_instruccion, in_estadoxren,
				in_fecha_crea,	in_fecha_mod)
    	values(@w_operacionpf, @i_instruccion_especial, 'N',
				@s_date,	@s_date)
    
    	if @@error <> 0 begin
      	--print 'error inspfdef'
	      exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                            @t_from  = @w_sp_name, @i_num   = 143053
  	    select @w_return = 1
    	  goto borra
	    end
    
  	  insert into ts_instruccion (secuencial, tipo_transaccion,clase,fecha,
          usuario,terminal,srv,lsrv,operacion,instruccion)
    	values  (@s_ssn, 14151, 'N', @s_date, @s_user, @s_term,
          @s_srv,@s_lsrv,@w_operacionpf,@i_instruccion_especial)
	    /* Si no se puede insertar error */
	    if @@error <> 0 begin
  	    exec cobis..sp_cerror
    	     @t_debug       = @t_debug,
      	   @t_file        = @t_file,
        	 @t_from        = @w_sp_name,
	         @i_num         = 143005
  	    select @w_return = 1
    	  goto borra
	    end   
  	end /*** revision de que exista      ***/
  end /*** revision de que no sea null ***/
  /****** Fin de cambio DP-000073 realizado por memito ***********/

select @w_return = 0
/**  ELIMINACION DE TEMPORALES **/
  borra:
  set rowcount 0
  delete pf_operacion_tmp where
         ot_usuario = @s_user and ot_sesion = @s_sesn
  delete pf_mov_monet_tmp where
         mt_usuario = @s_user and mt_sesion = @s_sesn
  delete pf_beneficiario_tmp where
         bt_usuario = @s_user and bt_sesion = @s_sesn
  delete pf_det_pago_tmp where
         dt_usuario = @s_user and dt_sesion = @s_sesn
  delete pf_det_cheque_tmp where
         ct_usuario = @s_user and ct_sesion = @s_sesn
return @w_return 
go
