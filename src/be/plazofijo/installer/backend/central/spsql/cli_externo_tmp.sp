/************************************************************************/
/*      Archivo:                cliexttmp.sp                            */
/*      Stored procedure:       sp_cli_externo_tmp                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           José Gmo. Saborio Artavia               */
/*      Fecha de documentacion: 04-Sep-2001                             */
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
/*      a la tabla temporal de cliente externo 'pf_cliente_externo_tmp'.*/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      04-Sep-01  Memito Saborio   Creacion                            */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cli_externo_tmp')
   drop proc sp_cli_externo_tmp
go

create proc sp_cli_externo_tmp (
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
@i_secuencial           int             = null,
@i_nombre               varchar(255)     = NULL,
@i_direccion            descripcion     = null,
@i_cedula               numero          = null)
with encryption
as
declare
      @w_sp_name              varchar(32),
      @w_operacionpf          int,
      @w_ce_secuencial         int,
      @o_condicion            tinyint

select @w_sp_name = 'sp_cli_externo_tmp'

/**  VERIFICAR CODIGO DE TRANSACCION PARA INSERT  **/
if ( @i_operacion in ( 'I','C') ) and ( @t_trn <> 14153 ) or
   ( @i_operacion = 'D' ) and ( @t_trn <> 14342 )
begin
  /**  ERROR : CODIGO DE TRANSACCION PARA INSERT NO VALIDO  **/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
  return 1
end

/**  GENERAR EL NUMERO DE CONDICION  **/
select @w_ce_secuencial = 1

select @w_ce_secuencial = isnull (max(ct_secuencial) , 0 ) + 1
from pf_cliente_externo_tmp
where ct_usuario   = @s_user
  and ct_sesion    = @s_sesn

/**  INSERCION DE CONDICIONES EN TABLA TEMPORAL  **/
If @i_operacion in ('I','C','U')
begin
  begin tran
    insert pf_cliente_externo_tmp 
       (ct_usuario, ct_sesion, ct_secuencial, ct_nombre, ct_cedula, ct_direccion)
    values (@s_user, @s_sesn, @w_ce_secuencial, @i_nombre, @i_cedula, @i_direccion)
  
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 143052
      return 1
    end
  commit tran

  /**  ENVIO DE NUEVO NUMERO DE CONDICION  **/
  select @w_ce_secuencial

  return 0
end

/**  ELIMINACION DE CONDICIONES  **/
If @i_operacion = 'D'
begin
  begin tran

    /**  ELIMINAR LA CONDICION  **/
    delete from pf_cliente_externo_tmp
    where ct_secuencial   = @i_secuencial
      and ct_usuario   = @s_user
      and ct_sesion    = @s_sesn
      
  commit tran
  return 0
end         
go
