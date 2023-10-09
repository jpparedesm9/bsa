/************************************************************************/
/*      Stored procedure:       sp_emision_consolida                    */
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
/*      Procedimiento que realiza la consolidacion de varias ordenes de */
/*      pago en un cheque.                                              */
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
		name = 'sp_emision_consolida')
	drop proc sp_emision_consolida
go

create proc sp_emision_consolida (
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
 	@i_valor        	    money           = NULL,
	@i_moneda	        tinyint		= NULL,
	@i_fpago		     catalogo	= NULL,
	@i_beneficiario         descripcion    	= ' ',
    @i_empresa              tinyint    	= 1,
    @i_toperacion           catalogo   -- GES 12/14/01 
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               int,
	@w_giro			catalogo,
/** VARIABLES PARA ENVIO A MOVMIENTOS BANCARIOS **/
	@w_idlote	  int,        
	@w_numero   		int,
        @w_parametro		char(6),
	@w_instrumento_subtipo	varchar(30),
	@w_instrumento		tinyint,
	@w_subtipo		tinyint,
	@w_campo1		varchar(20),
	@w_cheque_ger		catalogo,
	@w_campo40		char(1),
	@w_secuencial_cheque	int,
/** VARIABLES PF_EMISION_CHEQUE **/
	@w_secuencia    	int,
	@w_subsecuencia 	int,
        @w_producto             tinyint,
        @w_operacionpf          int,
        @w_estado               catalogo,
        @w_ofi_ing              smallint,
        @w_num_banco            cuenta,
        @w_moneda_base          tinyint, 
        @w_area_contable        int,
        @w_letra_internacional_CIB  catalogo,  -- GES 12/13/01 DP-000054
        @w_letra_internacional_1013 catalogo,  -- GES 12/13/01 DP-000054
        @w_producto_fpago       tinyint       -- GES 12/14/01


select @w_sp_name = 'sp_emision_consolida',
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

/** SECCION DE QUERY **/
select @w_cheque_ger = pa_char 
from cobis..cl_parametro 
where pa_nemonico='NCHG'
and pa_producto='PFI'

/* GES 12/13/01 DP-000054 */
select @w_letra_internacional_1013 = pa_char from cobis..cl_parametro
where pa_nemonico = 'NLI1'
  and pa_producto = 'PFI'

select @w_letra_internacional_CIB = pa_char from cobis..cl_parametro
where pa_nemonico = 'NLIC'
  and pa_producto = 'PFI'
                                      

/**  VERIFICAR CODIGO DE TRANSACCION PARA DIVISION **/
if ( @i_operacion <> 'U' or  @t_trn <> 14752) 
begin
  exec cobis..sp_cerror 
  @t_debug=@t_debug,
  @t_file=@t_file,
  @t_from=@w_sp_name,   
  @i_num = 141040
  return 1
end

if @i_operacion = 'U'
begin
   begin tran

      select @w_area_contable = fp_area_contable,
      @w_producto_fpago = fp_producto
      from pf_fpago
      where fp_mnemonico = @i_fpago
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 141111
         return 1
      end                            

      if @w_area_contable IS NULL
      begin
         select @w_area_contable = td_area_contable
         from pf_tipo_deposito
         where td_mnemonico = @i_toperacion
         if @@error <> 0
         begin
            exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 141115
            return 1
         end
      end    
      exec @w_idlote = cob_sbancarios..sp_cseqnos
      @i_tabla = 'sb_impresion_lotes',
      @o_siguiente = @w_numero out
      if @w_idlote <> 0
      begin
         exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
         @t_from=@w_sp_name,   @i_num = 141157
         return 1
      end

      /* GES 09/05/01 DP-000054 INFORMACION DE PARAMETRIZACION */
      if @i_fpago = @w_cheque_ger
         if @i_moneda = @w_moneda_base
           select @w_parametro = 'CHQML'
         else
           select @w_parametro = 'CHQME'

      if @i_fpago = @w_letra_internacional_1013
         select @w_parametro = 'CGBCDI'

      if @i_fpago = @w_letra_internacional_CIB
         select @w_parametro = 'EMGCID'       

      if @w_parametro IS NULL
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 141169
         return 1
      end      
		
      select @w_instrumento_subtipo = pa_char
      from cobis..cl_parametro
      where pa_producto = 'SBA'
      and pa_nemonico = @w_parametro
      if @@rowcount <> 1
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 141140
         return 1
      end                                        

      select @w_instrumento = convert(tinyint,(substring(@w_instrumento_subtipo
             , 1, (charindex('-', @w_instrumento_subtipo)-1))))

      select @w_subtipo = convert(tinyint, rtrim((substring(
         @w_instrumento_subtipo, charindex('-', @w_instrumento_subtipo)+1,5))))

      select @w_campo1 = convert(varchar,@i_valor)

      select @w_campo1 = '**' + @w_campo1 + '**'

      if @i_fpago = @w_cheque_ger
         select @w_campo40 = 'E'
      else
         if @i_fpago = @w_giro
            select @w_campo40 = 'O'

      exec @w_return = cob_sbancarios..sp_imprimir_lotes
          @s_ssn   = @s_ssn,
          @s_user  = @s_user,
          @s_term  = @s_term,
          @s_date  = @s_date,
          @s_srv   = @s_srv,
          @s_lsrv  = @s_lsrv,
          @s_rol   = @s_rol,
          @s_ofi   = @s_ofi,
          @s_sesn  = @s_sesn,
          @t_debug = @t_debug,
          @t_trn   = 29334,
          @i_oficina_origen = @s_ofi,
          @i_ofi_destino = @s_ofi,
          @i_area_origen = 90,
          @i_func_solicitante = 0,
          @i_fecha_solicitud = @s_date,
          @i_producto = 4,
          @i_instrumento = @w_instrumento,
          @i_subtipo = @w_subtipo,
          @i_valor = @i_valor,
          @i_beneficiario = @i_beneficiario,
          --@i_referencia = @i_operacionpf,
          @i_campo1 = @w_campo1,
          --@i_campo2 = @w_concepto,
          @o_idlote = @w_idlote out,
          --@i_archivo  = @w_archivo,
          @i_estado = 'D',
          @i_campo47 = 'PAGOS VARIOS DE INVERSIONES',
          @i_campo48 = '',
          @i_campo40 = 'CONSOLIDACION DE ORDENES DE PAGO',           
          @i_llamada_ext = 'S',
          @i_area_cont = @w_area_contable,
          @i_concepto = 2,
          @o_secuencial = @w_secuencial_cheque out  

      if @w_return <>0
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 141095
         return 1
      end
												
/***** Se leen los datos de la tabla temporal y se realiza la emision *****
****** de los cheques.                                                ****/
      while 1=1
      begin
         set rowcount 1
         select @w_operacionpf = ct_operacion, @w_secuencia = ct_secuencia, 
    	 @w_subsecuencia =ct_subsecuencia
         from pf_det_cheque_tmp
         where ct_usuario = @s_user 
    	 and ct_sesion = @s_sesn
         if @@rowcount = 0 
	 begin
            set rowcount 0
            break
	 end
	 set rowcount 0

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
         @i_operacionpf = @w_operacionpf,
         @i_secuencia = @w_secuencia,            -- de pf_emission_cheque
         @i_sub_secuencia = @w_subsecuencia,     -- de pf_emision_cheque
         @i_descripcion = @i_beneficiario,       --  A nombre de quien
         @i_flag_sbancarios = 1,	-- No utilize para el cheque bancos
         @i_forma_pago = @i_fpago,              -- GES 12/14/01  
         @i_producto_fpago = @w_producto_fpago, -- GES 12/14/01
         @i_numero = @w_secuencial_cheque       -- GES 12/15/01

         if @w_return <> 0
         begin
            exec sp_errorlog @i_fecha = @s_date, @i_error = 145043,
       	    @i_usuario=@s_user,@i_tran=@t_trn,@i_operacion=@w_num_banco,
            @s_date = @s_date
            return 1
         end

	/** Se borra el detalle para continuar con el siguiente **/
         delete pf_det_cheque_tmp
         where ct_usuario = @s_user 
    	 and ct_sesion = @s_sesn
    	 and ct_secuencia = @w_secuencia
	 and ct_subsecuencia = @w_subsecuencia
	 and ct_operacion = @w_operacionpf
      end   /** End del while **/   
   commit tran
end

return 0
go

