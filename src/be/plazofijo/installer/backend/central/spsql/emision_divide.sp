/************************************************************************/
/*      Stored procedure:       sp_emision_divide                       */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 12/09/2001                              */
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
/*      Procedimiento que realiza la divisi=n de una orden de pago en   */
/*      varios cheques para varios beneficiarios.                       */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      12/09/2001 Memito Saborio A.  Creacion                          */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and
		name = 'sp_emision_divide')
	drop proc sp_emision_divide
go

create proc sp_emision_divide (
	@s_ssn                  int             = NULL,
	@s_user                 login           = NULL,
  @s_sesn                 int             = NULL,
	@s_term                 varchar(30)     = NULL,
	@s_date                 datetime        = NULL,
	@s_srv                  varchar(30)     = NULL,
	@s_lsrv                 varchar(30)     = NULL,
	@s_ofi                  smallint        = NULL,
	@s_org                  char(1)         = NULL,
	@s_rol                  smallint        = NULL,
	@t_debug                char(1)         = 'N',
	@t_file                 varchar(10)     = NULL,
	@t_from                 varchar(32)     = NULL,
	@t_trn                  smallint        = NULL,
	@i_operacion            char(1),
 	@i_operacionpf          int             = NULL,
	@i_fecha_mov            datetime	= NULL,
  	@i_secuencia            int		= 0,
	@i_sub_secuencia        int		= 0,
	@i_empresa              tinyint     = 1
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               int,
/** VARIABLES PF_EMISION_CHEQUE **/
        @w_moneda               tinyint,
        @w_numero               int,
        @w_descripcion          varchar(255),	--Se cambia longitud para SB
        @w_fecha_mod            datetime,
        @w_valor                money,
        @w_fecha_emision        datetime,
        @w_ec_secuencial        int,     -- GES 05/29/01 CUZ-013-017
        @w_ec_fecha_mov         datetime,  -- GES 06/01/01 CUZ-014-021
				@w_cheque_pro		catalogo,
				@w_cheque_ger		catalogo,
				@w_efectivo		catalogo,
				@w_fpago    		catalogo,
        @w_cupon                catalogo,    -- GES 06/01/01 CUZ-014-014
        @w_camara               catalogo,    -- GES 06/01/01 CUZ-014-022
        @w_ec_estado						char(1),
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
        @w_min_sub				              tinyint,
        @w_mt_sub_secuencia             tinyint,
        @w_mt_producto                  catalogo,
        @w_mt_cuenta                    cuenta,
        @w_mt_tipo                      char(1),
        @w_mt_beneficiario              int,
        @w_mm_beneficiario              int,
        @w_mt_impuesto                  money,
        @w_mt_moneda                    int,
        @w_mt_valor_ext                 money,
        @w_mt_fecha_crea                datetime,
        @w_mt_fecha_mod                 datetime,
        @w_mt_valor                     money, 
        @w_mt_tipo_cliente              char(1),
  			@w_mt_cotizacion     		money, 
				@w_mt_tipo_cotiza				char(1),
        @w_cont                         tinyint,
/** VARIABLES PARA PF_OPERACION **/
        @w_producto             tinyint,
        @w_estado               catalogo,
        @w_ofi_ing              smallint,
        @w_num_banco            cuenta,
        @w_moneda_base          tinyint  


select @w_sp_name = 'sp_emision_divide',
       @w_ofi_ing = @s_ofi

/**** OBTENIENDO LA MONEDA BASE ****/
select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0
begin
  exec cobis..sp_cerror
    @t_debug=@t_debug,
    @t_file=@t_file,
    @t_from=@w_sp_name, 
    @i_num = 601018
  return  1
end    

/**  VERIFICAR CODIGO DE TRANSACCION PARA DIVISION **/
if ( @i_operacion <> 'U' or  @t_trn <> 14751) 
begin
  exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         @t_from=@w_sp_name,   @i_num = 141040
  return 1
end

if @i_operacion = 'U'
begin
	begin tran
	select @w_ec_estado = ec_estado, 			 @w_numero = ec_numero,
				 @w_ec_fecha_mov = ec_fecha_mov, @w_fecha_emision = ec_fecha_emision,
    		 @w_fecha_mod = ec_fecha_mod
  from pf_emision_cheque
  where ec_sub_secuencia   = @i_sub_secuencia  
    and ec_secuencia       = @i_secuencia  
	  and ec_operacion       = @i_operacionpf
	  and ec_fecha_emision   is null
  if @@rowcount = 0
  begin
    print 'No se encuentran datos disponibles'
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         @t_from=@w_sp_name,   @i_num = 143005
    return 1
  end 

	update pf_emision_cheque
	set ec_estado = 'E',
		  ec_fecha_emision = @s_date,
	    ec_numero = @s_ssn
  from pf_emision_cheque
  where ec_sub_secuencia   = @i_sub_secuencia  
    and ec_secuencia       = @i_secuencia  
	  and ec_operacion       = @i_operacionpf
	  and ec_fecha_emision   is null
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 141095
    return 1
  end

  insert ts_emision_cheque (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, fecha,  operacion, numero, 
       estado, fecha_emision,  fecha_mod)
  values (@s_ssn, @t_trn,'P',
  		@s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_operacionpf, @w_numero, 
       @w_ec_estado, @w_fecha_emision, @w_fecha_mod)
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         @t_from=@w_sp_name,   @i_num = 143005
    return 1
  end 
  
  insert ts_emision_cheque (secuencial, tipo_transaccion, clase,
       usuario, terminal, srv, lsrv, fecha,
       operacion, numero, estado, fecha_emision,  fecha_mod)
  values (@s_ssn, @t_trn,'A',@s_user, @s_term, @s_srv, @s_lsrv,
       @s_date, @i_operacionpf, @s_ssn, 'E', @s_date, @s_date)     
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         									@t_from=@w_sp_name,   @i_num = 143005
    return 1
  end             

  select @w_min_sub = isnull(max(mt_sub_secuencia),0)
  from pf_mov_monet_tmp
  where mt_usuario = @s_user 
  	and mt_sesion = @s_sesn
    and mt_operacion = @i_operacionpf 
      
  select @w_mt_sub_secuencia = 0
  
  while @w_min_sub >= 1
  begin  	
		/*** Escoje el siguiente numero de secuencia ***/		
		--select @w_mt_sub_secuencia = @w_min_sub
		
    select @w_mt_producto           = mt_producto,
           @w_mt_beneficiario       = mt_beneficiario,
           @w_mt_valor              = mt_valor,
           @w_mt_valor_ext          = mt_valor_ext,
           @w_mt_moneda             = mt_moneda,
           @w_mt_fecha_crea         = mt_fecha_crea,
           @w_mt_tipo_cliente			  = mt_tipo_cliente,
           @w_mt_sub_secuencia      = mt_sub_secuencia
    from pf_mov_monet_tmp
    where mt_usuario = @s_user 
    	and mt_sesion = @s_sesn
      and mt_operacion = @i_operacionpf 
      and mt_sub_secuencia = @w_min_sub -- @w_mt_sub_secuencia
    order by mt_sub_secuencia

		if @w_mt_tipo_cliente = 'E' 
		begin
			select @w_descripcion = ct_nombre
 			from pf_cliente_externo_tmp
 			where ct_secuencial = @w_mt_beneficiario 
        and ct_usuario = @s_user 
        and ct_sesion = @s_sesn
    end
    else
    begin
			select @w_descripcion = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre) 
 			from cobis..cl_ente
 			where en_ente = @w_mt_beneficiario 
	  end

    if @w_mt_moneda = @w_moneda_base
      select @w_valor = @w_mt_valor
    else
      select @w_valor = @w_mt_valor_ext

	
		/**** SE INSERTA EN LA TABLA LOS NUEVOS DETALLES ****/
    insert pf_emision_cheque ( ec_fecha_mov,ec_secuencial,
        ec_secuencia,ec_sub_secuencia,ec_fpago,ec_estado, ec_tran,
        ec_operacion, ec_numero,ec_moneda, ec_valor,ec_tipo,
        ec_fecha_emision, ec_fecha_crea,ec_fecha_mod,ec_descripcion)
    values (@s_date,@s_ssn,
    		@w_mt_sub_secuencia, @i_sub_secuencia,@w_mt_producto,null,@t_trn, 
    		@i_operacionpf, null, @w_mt_moneda, @w_valor,'C', 
    		null, @w_mt_fecha_crea, @s_date,@w_descripcion) 
    if @@error <> 0
    begin
  	  exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         									@t_from=@w_sp_name,   @i_num = 143031
	    return 1
    end
    
		/*** Llamando al procedimiento para emitir el cheque ***/
  	exec @w_return = sp_emision_cheque
			@s_ssn = @s_ssn,
      @s_user = @s_user,
      @s_term = @s_term,
      @s_date = @s_date,
      @s_srv = @s_srv,
      @s_lsrv = @s_lsrv,
      @s_rol = @s_rol,
      @s_ofi = @w_ofi_ing,
      @s_sesn = @s_sesn,
      @t_trn = 14231,
      @t_debug = 'N',
      @i_operacion = 'U',      
      @i_fecha_mov = @s_date,
      @i_operacionpf = @i_operacionpf,
      @i_secuencia = @w_mt_sub_secuencia,       -- de pf_emission_cheque
      @i_sub_secuencia = @i_sub_secuencia,      -- de pf_emision_cheque
      @i_descripcion = @w_descripcion,          --  A nombre de quien
      @i_flag_divide = 1												-- Para hacer cheque por cheque de la misma operacion

    if @w_return <> 0
    begin
      exec sp_errorlog @i_fecha = @s_date, @i_error = 145043,
       	@i_usuario=@s_user,@i_tran=@t_trn,@i_operacion=@w_num_banco,
       	@s_date = @s_date
      return 1
    end
    select @w_min_sub = @w_min_sub - 1
  end   /** End del while **/   

  commit tran
end

return 0
go

