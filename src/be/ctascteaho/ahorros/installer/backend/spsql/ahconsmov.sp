/*******************************************************************/
/*  Archivo:          ahconsmov.sp                                 */
/*  Stored procedure: sp_ahconsmov                                 */
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
/* Consulta movimientos de una cuenta                              */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 03/Ago/2016           N. Guale        Emision Inicial           */
/*******************************************************************/

use cob_interfase
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_ahconsmov')
   drop proc sp_ahconsmov
go

create proc sp_ahconsmov 
(
    @s_ssn              int  = null,
    @s_srv              varchar(30)=null,
    @s_lsrv             varchar(30)= null,
    @s_user             varchar(30) = null,
    @s_sesn             int =null,
    @s_term             varchar(32) = null,
    @s_date             datetime   = null,
    @s_ofi              smallint  = null,
    @s_rol              smallint  = 3,
    @s_org_err          char(1)        = null,
    @s_error            int            = null,
    @s_sev              tinyint        = null,
    @s_msg              varchar(255)   = null,  
    @s_org              char(1)        ='U',
    @t_debug            char(1)        = 'N',
    @t_file             varchar(14)    = null,
    @t_show_version     bit            = 0,
    @t_trn              smallint       = 4168,
    @i_cta              cuenta         = null,
    @i_cta_mig          cuenta         = null,
    @i_mon              tinyint        = null,
    @i_fchdsde          datetime       = null,
    @i_fchhsta          datetime       = null,
    @i_sec              int            = 0,
    @i_sec_alt          int            = -1,
    @i_hora             smalldatetime  = '01/01/1900 12:00AM',
    @i_diario           tinyint        = 0,
    @i_frontn           char(1)        = 'N',
    @i_formato_fecha    tinyint        = 101,
    @i_escliente        char(1)        = 'N',
    @i_operacion        char(1)        = 'C',
    @o_hist             tinyint        = null  out
        
)
as
declare
    @w_return           int,
    @w_sp_name          varchar(30),
	@w_fecha_proceso   datetime,
	@w_max_dias        tinyint,
     @w_sec             int,
     @w_secalt          int,
     @w_hora            smalldatetime,
     @w_cuenta          cuenta 
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_ahconsmov'

if @t_show_version = 1
   begin
      print 'Stored procedure sp_ahconsmov, Version 4.0.0.1'
      return 0
   end

   if @i_mon is null
   begin
   select @i_mon = pa_tinyint 
   from cobis..cl_parametro 
   where  pa_producto = 'ADM'
   and pa_nemonico = 'CMNAC' 
   if @@rowcount = 0
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
   
   if @t_trn <> 4168
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
       t_file         = @t_file, 
       t_trn          = @t_trn,
       i_cta          = @i_cta,              
       i_mon          = @i_mon,              
       i_fchdsde      = @i_fchdsde,          
       i_fchhsta      = @i_fchhsta,          
       i_sec          = @i_sec,              
       i_sec_alt      = @i_sec_alt,         
       i_hora         = @i_hora,         
	   i_diario       = @i_diario,       
	   i_frontn       = @i_frontn,       
	   i_formato_fecha= @i_formato_fecha,
	   i_escliente    = @i_escliente,    
	   o_hist         = @o_hist            
    exec cobis..sp_end_debug
end

  /* Valida datos de entrada */
  
  select @w_max_dias = pa_tinyint 
  from cobis..cl_parametro 
  where pa_producto = 'AHO'
  and pa_nemonico = 'MVMXDD'
  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101254
    return 101254
  end
  
  if @i_fchdsde is null and @i_fchhsta is null
  begin
	select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	select @i_fchdsde = convert(datetime, cast(datepart(mm,@w_fecha_proceso) as char(2)) +'/01/'+ cast(datepart(yy,@w_fecha_proceso) as varchar(5)))
	select @i_fchhsta = @w_fecha_proceso  
  end
  else
  begin
    if @i_fchdsde > @i_fchhsta
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201065
      return 201065
    end
    
    if datediff(dd,@i_fchdsde,@i_fchhsta) > @w_max_dias
    begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 357560
      return 357560
    end
  end
 while 1=1
 begin
  exec @w_return = cob_ahorros..sp_tr_ahcoestcta
        @s_ssn           = @s_ssn,
	   @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv, 
	   @s_user          = @s_user, 
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
	   @s_ofi           = @s_ofi,   
        @s_rol           = @s_rol,   
        @s_org_err       = @s_org_err,
        @s_error         = @s_error,
        @s_sev           = @s_sev, 
        @s_msg           = @s_msg,   
        @s_org           = @s_org,   
        @t_trn           = 232,          
        @i_cta           = @w_cuenta,          
        @i_mon           = @i_mon,          
        @i_fchdsde       = @i_fchdsde,     
        @i_fchhsta       = @i_fchhsta,      
        @i_sec           = @i_sec,          
        @i_sec_alt       = @i_sec_alt,      
        @i_hora          = @i_hora,         
        @i_diario        = @i_diario,       
        @i_frontn        = @i_frontn,       
        @i_formato_fecha = @i_formato_fecha,
        @i_escliente     = @i_escliente,    
        @o_hist          = @o_hist out,
        @o_sec           =@w_sec out,  
        @o_secalt        =@w_secalt out,
        @o_hora          =@w_hora out
        
       if @w_return <> 0
       begin
         return @w_return
       end
       
     if @o_hist=0 
          select  @i_sec = @w_sec, @i_hora = @w_hora ,  @i_sec_alt =@w_secalt 
     else
      break
  end
  
  
 if @o_hist = 1 
  begin 
        select   @i_sec = '0' , @i_sec_alt ='0' , @i_hora ='01/01/1900 12:00AM'
  while 1= 1  
begin  
        exec @w_return = cob_ahorros..sp_tr_ahcoestcta
        @s_ssn           = @s_ssn,
	   @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv, 
	   @s_user          = @s_user, 
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
	   @s_ofi           = @s_ofi,   
        @s_rol           = @s_rol,   
        @s_org_err       = @s_org_err,
        @s_error         = @s_error,
        @s_sev           = @s_sev, 
        @s_msg           = @s_msg,   
        @s_org           = @s_org,   
        @t_trn           = @t_trn,          
        @i_cta           = @w_cuenta,          
        @i_mon           = @i_mon,          
        @i_fchdsde       = @i_fchdsde,     
        @i_fchhsta       = @i_fchhsta,      
        @i_sec           = @i_sec,          
        @i_sec_alt       = @i_sec_alt,      
        @i_hora          = @i_hora,         
        @i_diario        = @o_hist,       
        @i_frontn        = @i_frontn,       
        @i_formato_fecha = @i_formato_fecha,
        @i_escliente     = @i_escliente,    
        @o_hist          = @o_hist out ,
        @o_sec           =@w_sec out,  
        @o_secalt        =@w_secalt out,
        @o_hora          =@w_hora out
        
        if @w_return <> 0
         begin
          return @w_return
         end  
     if @o_hist=2 
          select  @i_sec = @w_sec, @i_hora = @w_hora, @i_sec_alt =@w_secalt 
     else
      break    
      end
  end                       
      
  
  
  return 0

go
