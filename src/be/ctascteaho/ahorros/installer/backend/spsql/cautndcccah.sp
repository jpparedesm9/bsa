/*******************************************************************/
/*  Archivo:          cautndcccah.sp                               */
/*  Stored procedure: sp_tr_cautndc_ccah                           */
/*  Base de datos:    cob_remesas                                  */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Permite almacenar las notas de credito y debito de cuentas      */
/* de ahorros en una tabla de transaciones por autorizar.          */
/* Estas transacciones son realizadas desde el modulo de TADMIN    */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 08/Jul/2016          J. Tagle        Migración a CEN            */
/*******************************************************************/

use cob_interfase
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_tr_cautndc_ccah')
   drop proc sp_tr_cautndc_ccah
go

create proc sp_tr_cautndc_ccah 
(
    @s_ssn              int,
    @s_ssn_branch       int            = null, 
    @s_srv              varchar(30),
    @s_lsrv             varchar(30),
    @s_user             varchar(30),
    @s_sesn             int,
    @s_term             varchar(32),
    @s_date             datetime,
    @s_ofi              smallint,
    @s_rol              smallint       = 1,
    @s_org_err          char(1)        = null,
    @s_error            int            = null,
    @s_sev              tinyint        = null,
    @s_msg              varchar(255)   = null,  
    @s_org              char(1),       
    @t_debug            char(1)        = 'N',
    @t_file             varchar(14)    = null,
    @t_from             varchar(32)    = null,
    @t_rty              char(1)        = 'N',
    @t_show_version     bit            = 0,   
    @t_trn              smallint,      
    @t_ssn_corr         int            = null,
    @i_operacion        char(2),       
    @i_mon              tinyint        = null,
    @i_autorizante      varchar(30),   
    @i_funcionario      varchar(30)    = null,
    @i_producto         int            = null,
    @i_producto1        int            = 3,
    @i_cta              cuenta         = null,
    @i_cau              char(10)       = null,
    @i_val              money          = 0,
    @i_secuencial       int            = 0,
    @i_login            varchar(30)    = null,
    @i_trn              int            = null,
    @i_ssn_branch       int            = null,
    @i_concepto         varchar(50)    = null,
    @i_estado           char(1)        = 'I',
    @i_canal            smallint       = null,
    @i_idcaja           int            = 0,
    @i_dpto             tinyint        = 1,
    @i_codbanco         varchar(10)    = null,
    @i_tipchq           varchar(1)     = 'L',
    @i_nchq             int            = null,
    @i_ctachq           varchar(18)    = null,
    @i_filial           smallint       = 1,
    @i_sec_branch       int            = null,
    @i_ind              tinyint        = 0,   
    @i_tipo_trn         char(1)        = 'S',
    @i_origen_fon       varchar(100)   = null,
    @i_destino_fon      varchar(100)   = null,
    @o_genera_fac       char(1)        = 'S' out
)
as
declare
    @w_return           int,
    @w_sp_name          varchar(30)
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_tr_cautndc_ccah'

if @t_show_version = 1
   begin
      print 'Stored procedure sp_tr_cautndc_ccah, Version 4.0.0.1'
      return 0
   end

/*  Activacion del Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug 
	   @t_file=@t_file
    select '/** Store Procedure **/' = @w_sp_name,
       s_ssn          = @s_ssn,
       s_srv          = @s_srv,
       s_lsrv         = @s_lsrv,
       s_user         = @s_user,
       s_sesn         = @s_sesn,
       s_term         = @s_term,
       s_date         = @s_date,
       s_ofi          = @s_ofi,
       s_rol          = @s_rol,
       s_org_err      = @s_org_err,
       s_error        = @s_error,
       s_sev          = @s_sev,
       s_msg          = @s_msg,
       s_org          = @s_org,   
       t_from         = @t_from,
       t_file         = @t_file, 
       t_rty          = @t_rty,
       t_trn          = @t_trn,
       i_operacion    = @i_operacion,
       i_mon          = @i_mon,
       i_autorizante  = @i_autorizante,
       i_funcionario  = @i_funcionario,
       i_producto     = @i_producto,
       i_producto1    = @i_producto1,
       i_cta          = @i_cta,
       i_cau          = @i_cau,
       i_val          = @i_val,
       i_secuencial   = @i_secuencial,
       i_login        = @i_login,
       i_trn          = @i_trn,
       i_ssn_branch   = @i_ssn_branch,
       i_concepto     = @i_concepto,   
       i_estado       = @i_estado,
       i_canal        = @i_canal,
       i_idcaja       = @i_idcaja,
       i_dpto         = @i_dpto,
       i_codbanco     = @i_codbanco,
       i_tipchq       = @i_tipchq,
       i_nchq         = @i_nchq,
       i_ctachq       = @i_ctachq,
       i_filial       = @i_filial,
       i_sec_branch   = @i_sec_branch,
       i_ind          = @i_ind,
       i_tipo_trn     = @i_tipo_trn,
       i_origen_fon   = @i_origen_fon,
       i_destino_fon  = @i_destino_fon,
       o_genera_fac   = @o_genera_fac	   
    exec cobis..sp_end_debug
end

  exec @w_return = cob_remesas..sp_tr_autndc_ccah
       @t_from         = @t_from,
       @t_file         = @t_file,   
       @t_rty          = @t_rty,  
       @t_trn          = @t_trn,  
       @i_operacion    = @i_operacion,  
       @i_mon          = @i_mon,  
       @i_autorizante  = @i_autorizante,  
       @i_funcionario  = @i_funcionario,  
       @i_producto     = @i_producto,  
       @i_producto1    = @i_producto1,  
       @i_cta          = @i_cta,  
       @i_cau          = @i_cau,  
       @i_val          = @i_val,  
       @i_secuencial   = @i_secuencial,  
       @i_login        = @i_login,  
       @i_trn          = @i_trn,  
       @i_ssn_branch   = @i_ssn_branch,  
       @i_concepto     = @i_concepto,     
       @i_estado       = @i_estado,  
       @i_canal        = @i_canal,  
       @i_idcaja       = @i_idcaja,  
       @i_dpto         = @i_dpto,  
       @i_codbanco     = @i_codbanco,  
       @i_tipchq       = @i_tipchq,  
       @i_nchq         = @i_nchq,  
       @i_ctachq       = @i_ctachq,  
       @i_filial       = @i_filial,  
       @i_sec_branch   = @i_sec_branch,  
       @i_ind          = @i_ind,  
       @i_tipo_trn     = @i_tipo_trn,  
       @i_origen_fon   = @i_origen_fon,  
       @i_destino_fon  = @i_destino_fon,  
       @o_genera_fac   = @o_genera_fac 
  
  if @w_return <> 0
  begin
    return @w_return
  end
  return 0

go
