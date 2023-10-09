/************************************************************************/
/*      Archivo:                actmovmo.sp                             */
/*      Stored procedure:       sp_activa_mov_mon                       */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 07/Sep/95                               */
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
/*      Este procedimiento almacenado realiza las consultas             */
/*      de los movimientos monetarios de una operacion para activacion  */
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

if exists (select 1 from sysobjects where name = 'sp_activa_mov_mon')
   drop proc sp_activa_mov_mon 
go

create proc sp_activa_mov_mon  (
@s_ssn                     int         = null,
@s_user                    login       = null,
@s_sesn                    int         = null,
@s_term                    varchar(30) = null,
@s_date                    datetime    = null,
@s_srv                     varchar(30) = null,
@s_lsrv                    varchar(30) = null,
@s_ofi                     smallint    = null,
@s_rol                     smallint    = NULL,
@t_debug                   char(1)     = 'N',
@t_file                    varchar(10) = null,
@t_from                    varchar(32) = null,
@t_trn                     smallint,
@i_operacion               char(1),
@i_num_banco               cuenta)
with encryption
as
declare         
@w_sp_name                 varchar(32),
@w_codigo                  int,
@w_operacionpf             int

select @w_sp_name = 'sp_activa_mov_mon' 

if @t_trn <> 14642 and @i_operacion <> 'H'
begin
	exec cobis..sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 141112
	   /*  'Error en codigo de transaccion' */
  return 1
end

select 	@w_operacionpf  = op_operacion
from pf_operacion
where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from	 = @w_sp_name,
    @i_num	 = 141051
  return 1
end

If @i_operacion = 'H'
begin
  set rowcount 20
  select 	mo_descripcion,
          fp_descripcion,
          mm_valor,  
          mm_sub_secuencia 
  from pf_mov_monet,pf_fpago,cobis..cl_moneda            
	where mm_operacion = @w_operacionpf
		and mm_secuencia = 0            
		and mm_moneda = mo_moneda
		and mm_producto = fp_mnemonico
end
return 0   

go
