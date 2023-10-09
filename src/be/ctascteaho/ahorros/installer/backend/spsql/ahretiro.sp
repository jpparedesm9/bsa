/*******************************************************************/
/*  Archivo:          ahretiro.sp                                  */
/*  Stored procedure: sp_ahretiro                                  */
/*  Base de datos:    cob_interfase                                */
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
/* Realiza los retiros en una cuenta de ahorros                  */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 08/Jul/2016          I. Yupa        Emision Inicial             */
/*******************************************************************/

use cob_interfase
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_ahretiro')
   drop proc sp_ahretiro
go

create proc sp_ahretiro 
(
    @s_ssn              int            = null,
    @s_ssn_branch       int            = null, 
    @s_srv              varchar(30)    = null,
    @s_lsrv             varchar(30)    = null,
    @s_user             varchar(30)    = null,
    @s_sesn             int            = null,
    @s_term             varchar(32)    = null,
    @s_date             datetime       = null,
    @s_ofi              smallint       = null,
    @s_rol              smallint       = 1,
    @s_org_err          char(1)        = null,
    @s_error            int            = null,
    @s_sev              tinyint        = null,
    @s_msg              varchar(255)   = null,  
    @s_org              char(1)        = 'U',       
    @t_debug            char(1)        = 'N',
    @t_file             varchar(14)    = null,
    @t_from             varchar(32)    = null,
    @t_rty              char(1)        = 'N',
    @t_show_version     bit            = 0,   
    @t_trn              smallint       = 4171,      
    @t_ssn_corr         int            = null,    
    @i_cta              cuenta         = null,
    @i_cta_mig          cuenta         = null,
    @i_mon              tinyint        = null,
    @i_val              money          = null,
    @i_ActTot           char(1)        = 'N',
    @i_canal            tinyint        = 0,--4 CAJAS
    @o_ssn              int            = null out
)
as
declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_cuenta           cuenta
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_ahretiro'

if @t_show_version = 1
   begin
      print 'Stored procedure sp_ahretiro, Version 4.0.0.1'
      return 0
   end

   if @i_mon is null
   begin
   select @i_mon = pa_tinyint 
   from cobis..cl_parametro 
   where  pa_producto = 'ADM'
   and pa_nemonico = 'CMNAC' 
   if @@rowcount =0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101254
    return 101254
  end
   end
   
   
   if @i_cta is null and @i_cta_mig is null
   begin 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101127
      return 101127
   end
  
    if @i_cta is null
      begin
       select @w_cuenta = ca_cta_banco 
       from cob_ahorros..ah_cuenta_aux 
       where ca_cta_banco_mig =@i_cta_mig
       if @@rowcount =0
         begin
         exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101127
          return 101127
         end
      end
      else
        select @w_cuenta = @i_cta 
   
   if @t_trn <> 4171
  begin
    /* Error en codigo de transaccion */
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 201048
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
       i_cta          = @i_cta,        
       i_mon          = @i_mon,        
       i_val          = @i_val,        
       i_ActTot       = @i_ActTot,     
       i_canal        = @i_canal,      
       o_ssn          = @o_ssn        

    exec cobis..sp_end_debug
end

  exec @w_return = cob_ahorros..sp_ah_retirosl
      @s_ssn            = @s_ssn,            
      @s_ssn_branch     = @s_ssn_branch,     
      @s_srv            = @s_srv,            
      @s_lsrv           = @s_lsrv,           
      @s_user           = @s_user,           
      @s_sesn           = @s_sesn,           
      @s_term           = @s_term,           
      @s_date           = @s_date,           
      @s_ofi            = @s_ofi,           
      @s_rol            = @s_rol,            
      @s_org_err        = @s_org_err,        
      @s_error          = @s_error,          
      @s_sev            = @s_sev,            
      @s_msg            = @s_msg,            
      @s_org            = @s_org,            
      @t_debug          = @t_debug,          
      @t_file           = @t_file,           
      @t_from           = @t_from,           
      @t_rty            = @t_rty,            
      @t_show_version   = @t_show_version,   
      @t_trn            = 263,            
      @t_ssn_corr       = @t_ssn_corr,       
      @i_cta            = @w_cuenta,     
      @i_mon            = @i_mon,     
      @i_val            = @i_val,     
      @i_ActTot         = @i_ActTot,  
      @i_canal          = @i_canal,   
      @o_ssn            = @o_ssn     
  
  if @w_return <> 0
  begin
    return @w_return
  end
  return 0

go
