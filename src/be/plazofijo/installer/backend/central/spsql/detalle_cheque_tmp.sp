/************************************************************************/
/*      Archivo:                detchtmp.sp                             */
/*      Stored procedure:       sp_detalle_cheque_tmp                   */
/*      Base de datos:          cob_pfijo                               */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 17/Ago/95                               */
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
/*      Este programa procesa las transacciones de INSERT y DELETE      */
/*      a la tabla temporal de detalles de cheques 'pf_det_cheque_tmp'  */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*  12/09/2001   MEMITO SABORIO    Nuevos campos de secuencia y subse-  */
/*                                 secuencia para division de orden de  */
/*                                 pago en varios cheques.              */
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

if object_id('sp_detalle_cheque_tmp') IS NOT NULL
   drop proc sp_detalle_cheque_tmp
go

create proc sp_detalle_cheque_tmp (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_sesn                 int             = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_operacion            char(1),
      @i_activacion           char(1)         = 'N',
      @i_num_banco            cuenta          =  NULL,
      @i_secuencial           int             = NULL,
      @i_banco                catalogo        = NULL,
      @i_cuenta               cuenta          = NULL,
      @i_cheque               int             = NULL,
      @i_descripcion          varchar(255)    = NULL,	--Se cambia longitud para SB
      @i_valor                money           = NULL,
      @i_nombre_banco	      	descripcion     = NULL,
      @i_secuencia            int             = NULL,
      @i_subsecuencia         int             = NULL
      )
with encryption
as
declare
      @w_sp_name        varchar(32),
      @w_totval 	      money,
			@w_operacionpf    int,
      @w_valor		      money

select @w_sp_name = 'sp_detalle_cheque_tmp'

/*** Activacion = 'Z' ***/
if @i_activacion = 'Z'
	select @i_secuencial = @s_ssn


/**  VERIFICAR CODIGO DE TRANSACCION   **/
if ( @i_operacion <> 'I' or @t_trn <> 14138 ) and
   ( @i_operacion <> 'D' or @t_trn <> 14338 ) 
begin
  exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 141040
  return 1
end

if @i_activacion = 'N'
begin
 	select @w_operacionpf = ot_operacion
 	from   pf_operacion_tmp
 	where ot_usuario =  @s_user
   	and ot_sesion =@s_sesn
   	and ot_num_banco =@i_num_banco
 	if @@rowcount = 0
 	begin
   	/**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
   	exec cobis..sp_cerror
          	@t_debug = @t_debug,
           	@t_file  = @t_file,
           	@t_from  = @w_sp_name,
           	@i_num   = 141051
   	return 1
 	end     
end
else
begin
	select @w_operacionpf = op_operacion
	from   pf_operacion
	where op_num_banco =@i_num_banco
	if @@rowcount = 0
	begin
		/**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
 		exec cobis..sp_cerror
       	@t_debug = @t_debug,
       	@t_file  = @t_file,
       	@t_from  = @w_sp_name,
       	@i_num   = 141051
 		return 1
	end     
end

/**  INSERCION DE DETALLE DE PAGOS EN TABLA TEMPORAL  **/
If @i_operacion in ('I')
begin
  /**  VERIFICAR EXISTENCIA DEL REGISTRO MONETARIO (REFERENCIA) **/
  if @i_activacion = 'N'
  begin
    if not exists ( select 1 from pf_mov_monet_tmp 
                    where mt_sub_secuencia = @i_secuencial)
    begin
      /**  ERROR : NO EXISTE REGISTRO MONETATIO  **/
      exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141128
      return 1
    end
  end
  else
  begin
  	if @i_activacion <> 'Z' begin
    	if not exists ( select 1 from pf_mov_monet 
      	              where mm_secuencia = 0  and
											    mm_sub_secuencia = @i_secuencial)
    	begin
      	/**  ERROR : NO EXISTE REGISTRO MONETATIO  **/
      	exec cobis..sp_cerror
        	    @t_debug = @t_debug,
          	  @t_file  = @t_file,
            	@t_from  = @w_sp_name,
            	@i_num   = 141128
      	return 1
    	end
    end
  end	

  begin tran
    /**  INSERCION DE DETALLES DE CHEQES EN LAS TABLAS           **/
    /**  TEMPORALES DE DETALLES DE CHEQUES                       **/
    insert pf_det_cheque_tmp     
          (ct_operacion, ct_secuencial,   ct_usuario,    ct_sesion,    
           ct_banco,        ct_cuenta,     ct_cheque,      
           ct_valor,        ct_fecha_crea, ct_fecha_mod,
	   ct_descripcion,  ct_nombre_banco, ct_secuencia, ct_subsecuencia)
    values (@w_operacionpf, @i_secuencial,   @s_user,       @s_sesn,      
           @i_banco,        @i_cuenta,     @i_cheque,     
           @i_valor,        @s_date,	 @s_date,
	   @i_descripcion,  @i_nombre_banco, @i_secuencia, @i_subsecuencia)                

    /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
    if @@error <> 0
    begin
      exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 143038
      return 1
    end

  commit tran
  return 0
end

/**  ELIMINACION DE BENEFICIARIOS  **/
If @i_operacion = 'D'
begin
  begin tran
    delete from pf_det_cheque_tmp 
    where ct_usuario   = @s_user
      and   ct_sesion    = @s_sesn 
  commit tran
  return 0
end         

go
