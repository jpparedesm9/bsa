/************************************************************************/
/*      Archivo:                bt_emitc.sp                             */
/*      Stored procedure:       sp_batch_emision_cheque                 */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gabriela Estupinan                      */
/*      Fecha de documentacion: 19/Sep/2000                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script invoca  la emision masiva de cheques de gerencia    */
/*      enviando la informacion de ordenes de pago generadas a          */
/*      Servicios Bancarios.                                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR               RAZON                          */
/*      19-Sep-2000  Gabriela Estupiñan  Emision Inicial BCA-053        */
/*      09-Oct-2000  D.Guerrero          Busca @w_oficina para Cifrados */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_batch_emision_cheque' and type = 'P')
   drop proc sp_batch_emision_cheque
go

create proc sp_batch_emision_cheque (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@s_sesn                 int             = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int,
@i_empresa              tinyint         = 1,
@i_fecha_proceso        datetime,
@i_formato_fecha        int,
@i_en_linea             char(1)         = 'S')
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               int,
        @w_cheque_ger           catalogo,
        @w_operacionpf          int,
        @w_fecha_emision        datetime,
        @w_caja                 char(1),
        @w_valor                money, 
        @w_mm_oficina           int,
        @w_mm_oficina_ant       int,
        @w_secuencia            int, 
        @w_sub_secuencia        int, 
        @w_secuencial           int, 
        @w_descripcion          varchar(255),	--Cambia longitud para SB
        @w_num_banco            cuenta,
        @w_error                int,
        @w_numero               int,
        @w_fpago                catalogo,
        @w_moneda               tinyint,
        @w_moneda_base          tinyint,
        @w_moneda_op            tinyint,
        @w_moneda_cotiz         smallint,
        @w_ente                 int,
        @w_oficina              smallint,
        @w_giro                 catalogo,
	@w_tipo_cotiza		char(1),
        @w_cotizacion           money,
        @w_cotizacion_conta     money, 
        @w_cotizacion_compra_b  money, 
        @w_cotizacion_venta_b   money, 
        @w_numero_giro          int,
        @w_idlote               int,
        @w_estado               char(1),
        @w_fpago_anterior       catalogo   -- GES 12/03/01        

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa

select @w_sp_name = 'sp_batch_emision_cheque'

if @t_trn <> 14955
begin
  exec cobis..sp_cerror 
	@t_debug=@t_debug,@t_file=@t_file,
        @t_from=@w_sp_name,   @i_num = 141040
  return 141040
end                  


select @w_cheque_ger = pa_char 
from cobis..cl_parametro
where pa_nemonico='NCHG'
  and pa_producto='PFI' 

select @w_fpago_anterior = '', @w_mm_oficina_ant = 0


/** SECCION DE BARRIDO DE PF_EMISION_CHEQUE **/
declare cursor_cheques cursor
for select 
      ec_operacion,
      ec_secuencia,
      ec_sub_secuencia,
      ec_secuencial,
      ec_valor,
      ec_descripcion,
      ec_fpago,
      ec_moneda
    from pf_emision_cheque , pf_fpago
    where ec_fecha_crea = @i_fecha_proceso
      and ec_caja 	is null
      and ec_fpago 	= fp_mnemonico  -- GES 12/03/01
      and fp_estado     = 'A'
      and fp_producto 	= 42         	-- GES 12/03/01
      and ec_tran     	in(14905,14903)      	-- CVA Oct-06-05
      and ec_estado     is null          
      order by ec_fpago   -- GES 12/03/01 Para control de seqnos de lotes
for read only

open cursor_cheques

fetch cursor_cheques into
  @w_operacionpf,
  @w_secuencia,
  @w_sub_secuencia,
  @w_secuencial,
  @w_valor,
  @w_descripcion,
  @w_fpago,
  @w_moneda

while @@fetch_status <> -1
begin
  if @@fetch_status = -2
  begin
    close cursor_cheques
    deallocate cursor_cheques
    raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
    return 0
  end     

  select @w_num_banco = op_num_banco,
         @w_oficina   = op_oficina, /*DGU*/
         @w_moneda_op = op_moneda
  from pf_operacion
  where op_operacion = @w_operacionpf   
  if @@rowcount <> 1
  begin
    select @w_error = 141004
    exec sp_errorlog 
	@i_fecha 	= @s_date, 
	@i_error 	= @w_error,
      	@i_usuario	= @s_user,
	@i_tran		= @t_trn,
	@i_operacion	= @w_num_banco,
      	@s_date 	= @s_date
  end                                 
  else
  begin 
    exec @s_sesn       = sp_gen_sec 
         @i_inicio_fin = 'F' 

    if @w_moneda <> @w_moneda_base or @w_moneda_op <> @w_moneda_base
    begin
      if @w_moneda <> @w_moneda_base
        select @w_moneda_cotiz = @w_moneda
      else
        select @w_moneda_cotiz = @w_moneda_op

      set rowcount 1
      select @w_cotizacion_conta = co_conta,
             @w_cotizacion_compra_b = co_compra_billete,
             @w_cotizacion_venta_b = co_venta_billete
      from cob_pfijo..pf_cotizacion
      where  co_moneda = @w_moneda_cotiz
        and co_fecha = @i_fecha_proceso
      order by co_hora desc
      set rowcount 0 

      if @w_moneda_op = @w_moneda
      begin
        select @w_cotizacion = @w_cotizacion_conta, @w_tipo_cotiza = 'N'
      end
      else
      begin
        if @w_moneda_op = @w_moneda_base    
        begin
          select @w_cotizacion = @w_cotizacion_venta_b, @w_tipo_cotiza = 'V'
        end
        else
        begin
          select @w_cotizacion = @w_cotizacion_compra_b, @w_tipo_cotiza = 'C'
        end
      end
    end
    else
      select @w_cotizacion = 0, @w_tipo_cotiza = 'N'

    select @w_ente 	     = mm_beneficiario,
           @w_mm_oficina     = mm_oficina
    from pf_mov_monet
    where mm_operacion 	   = @w_operacionpf
      and mm_secuencia 	   = @w_secuencia
      and mm_sub_secuencia = @w_sub_secuencia

    exec @w_return = sp_mov_monet_tmp
      @s_ssn 	= @s_ssn,
      @s_user 	= @s_user,
      @s_term 	= @s_term,
      @s_date 	= @i_fecha_proceso,
      @s_srv 	= @s_srv,
      @s_lsrv 	= @s_lsrv,
      @s_rol 	= @s_rol,
      @s_ofi 	= @w_mm_oficina,
      @s_sesn 	= @s_sesn,         
      @t_trn 	= 14127,
      @t_debug 		= 'N',
      @i_operacion 	= 'I',
      @i_valor 		= @w_valor,
      @i_valor_ext 	= @w_valor,
      @i_producto 	= @w_fpago,
      @i_num_banco 	= @w_num_banco,
      @i_sub_secuencia 	= @w_sub_secuencia,
      @i_tipo 		= 'C',
      @i_beneficiario 	= @w_ente,
      @i_cotizacion 	= @w_cotizacion,
      @i_tipo_cotiza 	= @w_tipo_cotiza,
      @i_moneda 	= @w_moneda
    if @w_return <> 0     
    begin
      select @w_error = 143022
      exec sp_errorlog 
	 @i_fecha 	= @s_date, 
         @i_error 	= @w_error,
         @i_usuario	= @s_user,
         @i_tran	= @t_trn,
         @i_operacion	= @w_num_banco,
         @s_date 	= @s_date
    end
    else
    begin
     /* GES 12/02/01 Genero un seqnos de lote por cada forma de pago a enviar */
     -- o cuando cambia de oficina para una misma operacion
      if @w_fpago <> @w_fpago_anterior or @w_mm_oficina <> @w_mm_oficina_ant 
         exec @w_return = cob_interfase..sp_isba_cseqnos          -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos 
              @i_tabla = 'sb_impresion_lotes',
              --@i_empresa = @i_empresa,                          -- BRON: 15/07/09 
              @o_siguiente = @w_idlote out                            

      exec @w_return = sp_emision_cheque
         @s_ssn 	= @s_ssn,
         @s_user 	= @s_user,
         @s_term 	= @s_term,
         @s_date 	= @i_fecha_proceso,
         @s_srv 	= @s_srv,
         @s_lsrv 	= @s_lsrv,
         @s_rol 	= @s_rol,
-- I.CVA May-05-06 Oficina del movimiento monetario
--         @s_ofi 	= @w_oficina,
         @s_ofi 	= @w_mm_oficina,
         @s_sesn 	= @s_sesn,         
         @t_trn 	= 14231,
         @t_debug 	= 'N',
         @i_operacion 	= 'U',
         @i_fecha_mov 	= @i_fecha_proceso,
         @i_forma_pago 	= @w_fpago,	--+-+
         @i_operacionpf = @w_operacionpf,
         @i_secuencia 	  = @w_secuencia,
         @i_sub_secuencia = @w_sub_secuencia,
         @i_numero 	  = @w_idlote,
         @i_descripcion   = @w_descripcion,
         @i_idlote 	  = @w_idlote,
         @i_formato_fecha = @i_formato_fecha,
         @i_en_linea 	  = @i_en_linea,
         @i_contabiliza   = 'S'           --CVA May-23-06 para que no genere comprobante contable
      if @w_return <> 0     
      begin
        select @w_error = 149030 
        exec sp_errorlog 
		@i_fecha     = @s_date, 
	        @i_error     = @w_error,
            	@i_usuario   = @s_user,
                @i_tran      = @t_trn,
                @i_operacion = @w_num_banco,
            	@s_date      = @s_date
      end
      select @w_fpago_anterior = @w_fpago,
             @w_mm_oficina_ant = @w_mm_oficina --CVA Dic-20-05
    end
 end          

 fetch cursor_cheques into
   @w_operacionpf,
   @w_secuencia,
   @w_sub_secuencia,
   @w_secuencial,
   @w_valor,
   @w_descripcion,
   @w_fpago,
   @w_moneda

--print 'siguiente @w_operacionpf: ' + cast( @w_operacionpf as varchar)
end /*while */

close cursor_cheques
deallocate cursor_cheques

return 0

go
