/************************************************************************/
/*      Archivo:                tranaut.sp                              */
/*      Stored procedure:       sp_pf_trn_aut                           */
/*      Base de datos:          cob_pfijo	                        */
/*      Producto:               Plazo fijo                              */
/*      Disenado por:           MPO                                     */
/*      Fecha de escritura:     18-sep-2001                             */
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
/*      Permite verificar si un usuario tiene autorizacion para         */
/*      cambio de valores en Rubros                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      18/sep/01       JSA             Emision Inicial                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_pf_trn_aut')
   drop proc sp_pf_trn_aut
go

create proc sp_pf_trn_aut (
   @s_ssn          int             = NULL,
   @s_user         login           = NULL,
   @s_term         varchar(30)     = NULL,
   @s_date         datetime        = NULL,
   @s_sesn         int             = NULL,
   @s_srv          varchar(30)     = NULL,
   @s_lsrv         varchar(30)     = NULL,
   @s_ofi          smallint        = NULL,
   @s_rol          smallint        = NULL,
   @t_debug        char(1)         = 'N',
   @t_file         varchar(10)     = NULL,
   @t_from         varchar(32)     = NULL,
   @t_trn          smallint        = NULL,
   @i_operacion    char(1),
   @i_login        varchar(30)     = NULL,
   @i_pass         varchar(30)     = NULL,
   @i_num_trn      smallint        = NULL
)
with encryption
as
declare
   @w_sp_name      varchar(32),
   @w_return       int,
   @w_error        int

if @t_trn <> 14753 and @i_operacion <> 'S'
begin
	exec cobis..sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 141040
	   /*  'Error en codigo de transaccion' */
  return 1
end

select @w_sp_name = 'sp_pf_trn_aut'

/* VERIFICACION DE CLAVE DE ACCESO */
if not exists(select 1 from cobis..cl_funcionario
              where fu_login = @i_login)
begin
   select @w_error = 149084
   goto ERROR
end                         

if not exists(select 1 from cobis..ad_usuario_rol,cobis..ad_tr_autorizada 
              where ur_login       = @i_login
              and   ta_transaccion = @i_num_trn
              and   ta_rol         = ur_rol) 
begin
   select @w_error = 149085
   goto ERROR
end

return 0

ERROR:

exec cobis..sp_cerror
	@t_debug='N',         
	@t_file = NULL,
	@t_from =@w_sp_name,   
	@i_num = @w_error,
	@i_cuenta= ' '
return @w_error

go
