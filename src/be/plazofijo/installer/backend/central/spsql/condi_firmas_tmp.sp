/************************************************************************/
/*      Archivo:                condfirmas.sp                           */
/*      Stored procedure:       sp_condi_firmas_tmp                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 30-Mar-2005                             */
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
/*      a la tabla temporal de condiciones 'pf_condfirmas_tmp'.         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      30-Mar-05  Ximena Cartagena   Creacion                          */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_condi_firmas_tmp')
   drop proc sp_condi_firmas_tmp
go

create proc sp_condi_firmas_tmp (
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
@i_operacion            char(1)         = 'I',
@i_comentario           varchar(60)     = null,
@i_cuenta               cuenta          = NULL )
with encryption
as
declare
@w_sp_name              varchar(32),
@w_operacionpf          int,
@w_condicion            tinyint,
@o_condicion            tinyint

select @w_sp_name = 'sp_condi_firmas_tmp'

/**  VERIFICAR CODIGO DE TRANSACCION PARA INSERT  **/
if (@i_operacion = 'I') and ( @t_trn <> 14163 ) or
   (@i_operacion = 'D') and ( @t_trn <> 14346 ) 

begin
  /**  ERROR : CODIGO DE TRANSACCION PARA INSERT NO VALIDO  **/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
  return 1
end


/**  CONVERSION DEL NUMERO DE CUENTA AL NUMERO DE OPERACION  **/
if @i_operacion = 'I'
begin
  select @w_operacionpf = ot_operacion
  from   pf_operacion_tmp
  where  ot_num_banco = @i_cuenta

  if @@rowcount = 0
  begin
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
  where  op_num_banco = @i_cuenta

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
    return 1
  end
end   
/**  GENERAR EL NUMERO DE CONDICION  **/

select @w_condicion = 1

select	@w_condicion = isnull(ci_condicion , 0 ) + 1
from	pf_condfirmas_tmp
where	ci_operacion = @w_operacionpf	
and	ci_usuario   = @s_user
and	ci_sesion    = @s_sesn


			------------------------------------------------
			-- Insercion de Condiciones en tabla Temporal --
			------------------------------------------------
		
If @i_operacion = 'I'
begin
  begin tran
    insert pf_condfirmas_tmp 
           (ci_operacion,   ci_condicion, ci_fecha_crea,
            ci_fecha_mod,   ci_usuario,   ci_sesion)
    values (@w_operacionpf, @w_condicion, @s_date,
            @s_date,        @s_user,      @s_sesn)
  
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143028
      return 1
    end

  commit tran

  /**  ENVIO DE NUEVO NUMERO DE CONDICION  **/
  select @w_condicion

  return 0
end

		--------------------------------------------
		-- ELiminaci¢n de condiciones Temporales  --
		--------------------------------------------

If @i_operacion = 'D'
begin
  begin tran
    /**  ELIMINAR LA CONDICION  **/
	delete	from pf_condfirmas_tmp
	where	ci_usuario   = @s_user
      	and	ci_sesion    = @s_sesn
   
    /**  ELIMINAR LOS DETALLES DE CONDICION DE ESA CONDICION  **/
	delete	from pf_det_condfirmas_tmp
	where	di_usuario   = @s_user
	and	di_sesion    = @s_sesn
   
  commit tran
  return 0
end         
go
