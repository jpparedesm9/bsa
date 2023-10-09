/************************************************************************/
/*      Archivo:                detlotmp.sp                             */
/*      Stored procedure:       sp_detallelote_tmp                      */
/*      Base de datos:          cob_pfijo                               */
/*      Disenado por:           Gustavo Calderono                       */
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
/*      a la tabla temporal de detalles de lote 'pf_det_lote_tmp'       */
/*                                                                      */
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

if exists (select 1 from sysobjects where name = 'sp_detallelote_tmp')
   drop proc sp_detallelote_tmp
go
 
create proc sp_detallelote_tmp (
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
      @i_operacion            char(1)        = NULL,
      @i_num_banco            cuenta          = NULL,
      @i_cuenta_lote          cuenta	      = NULL,
      @i_preimpreso           int           = NULL)
with encryption
as
declare
      @w_sp_name              varchar(32),
      @w_totporc              float,  
      @w_fecha_crea           datetime,
      @w_fecha_mod            datetime

select @w_sp_name = 'sp_detallelote_tmp'


/**  VERIFICAR CODIGO DE TRANSACCION   **/
if ( @i_operacion <> 'I' or @t_trn <> 14542 )
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
      return 1
   end

/**  VERIFICAR EXISTENCIA DE LA OPERACION DE PLAZO FIJO  **/
 if @i_operacion = 'I' 
  begin
     select count(*)
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
If @i_operacion = 'I'
   begin
     begin tran 
       /**  INSERCION DE DETALLES DE LOTE  EN LAS TABLAS            **/
         /**  TEMPORALES DE DETALLES DE LOTE                         **/
         insert pf_det_lote_tmp     
		(dt_lote, dt_num_banco, dt_preimpreso,
		 dt_usuario,dt_sesion)
         values (@i_num_banco,  @i_cuenta_lote,@i_preimpreso,
		@s_user,       @s_sesn)

         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
         if @@error <> 0
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143037
               return 1
            end

      commit tran
      return 0
   end

/**  ELIMINACION DE BENEFICIARIOS  **/
/**If @i_operacion = 'D'
  begin
      begin tran
         /**  ELIMINAR LOS BENEFICIARIOS DE ESA OPERACION  **/
         delete from pf_det_lote_tmp 
         where dt_usuario   = @s_user
         and   dt_sesion    = @s_sesn 
      commit tran
      return 0
   end **/        
go
