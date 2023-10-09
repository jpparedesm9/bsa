/************************************************************************/
/* Archivo:                fecha.sp                                     */
/* Stored procedure:       sp_fecha                                     */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     30-Marzo-1994                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes exclusivos para el Ecuador de la         */
/*    'NCR CORPORATION'.                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento al catalogo de Cuentas de un tipo de plan           */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    30-Mar-1994    R. Garces       Emision Inicial                    */
/*    07-Jul-1999    D.Guerrero      CY2K-BATB203 U. @i_formato_fecha   */
/*    27-Ene-2011    S. Soto         Manejo de error en rp-exec, se     */
/*                                   omite manejo transaccional         */
/*    18/Mar/2011    X.Cahuenas      CFN - Cambio en fecha de cierre    */
/*    26/May/2011    S. Soto         Inclusion de parametro PTFCOB      */
/*    02/Ene/2013    I. Torres       Inclusion de parametro SRVCFP      */
/*    02/Abr/2013    D. Montenegro   Inclusion de parametro SRVCFP      */
/*    21/Sep/2017    J. Salazar      Paso de formato de fecha           */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_fecha_batch')
   drop proc sp_fecha_batch

go
create proc sp_fecha_batch  (
   @t_show_version   bit         = 0,    --show the version of the stored procedure
   @s_ssn            int         = null,
   @s_date           datetime    = null,
   @s_user           login       = null,
   @s_term           descripcion = null,
   @s_corr           char(1)     = null,
   @s_ssn_corr       int         = null,
   @s_ofi            smallint    = null,
   @t_rty            char(1)     = null,
   @t_trn            smallint    = 601,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @i_operacion      char(1),
   @i_fecha          datetime    = null,
   @i_formato_fecha  int         = null,
   @i_sarta          int         = null  --XCA: 1803/2011 Variable para control de sarta en F.Cierre 
)
as 
declare
   @w_sp_name     varchar(30),
   @w_today       datetime,
   @w_date        varchar(10),
   @w_terror      int, 
   @w_error       int, 
   @w_msg         varchar(100),
   @w_ptfcob      varchar(10),
   @w_srvcfp      varchar(10), --ITO: Inc-18239 Variable para el nombre del transerver del ambiente
   @w_proceso     varchar(25) 


select @w_today = getdate()
select @w_sp_name = 'sp_fecha_batch'

--------------------------------- VERSIONAMIENTO DE PROGRAMA ---------------------------------
if @t_show_version = 1
begin
   print 'Stored procedure sp_fecha_batch, Version 4.0.0.0'
   return 0
end
----------------------------------------------------------------------------------------------

--select @w_terror = 0

/************************************************/
/*  Tipo de Transaccion = 803          */


if (@t_trn <> 8069 and @i_operacion = 'U') or
   (@t_trn <> 8070 and @i_operacion = 'S') 
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 601077
   return 1
end
/************************************************/


/* Chequeo de Existencias */
/**************************/


/* Insercion de la fecha */
/*************************/

if @i_operacion = 'U'
begin

    /* Actualizacion del registro */
    /******************************/
   if exists (select 1
              from    ba_corrida
              where   co_estado in ('E', 'G', 'P', 'R', 'F'))
   begin
      /* Existen lotes activos */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 808051
      return 1
   end      

   /*ECA Validaciones requeridas por Usuario FNA */

   exec cobis..sp_cambio_fecha_pro
   @i_fecha         = @i_fecha,
   @i_formato_fecha = @i_formato_fecha,
   @o_terror        = @w_terror out

   if @w_terror = 0
   begin
      /* SSO 26/05/2011: Determinar parametro de plataforma */
      select @w_ptfcob  = pa_char
      from cl_parametro 
      where pa_nemonico = 'PTFCOB' 
      and   pa_producto = 'BAT' 
    
      if @@rowcount = 0
         select @w_ptfcob = 'KRN'  -- Kernel por defecto

      select @w_date = convert(char(10),@i_fecha,101)
           
  
      /* SSO 26/05/2011: Cambio de fecha Si es Solo Kernel o Convivencia */
      if @w_ptfcob = 'KRN' or @w_ptfcob = 'CON'  
      begin
         /* Cambio de Fecha de Proceso en Kernel */
         /****************************************/
         exec @w_error = ADMIN...rp_date_proc @i_fecha = @w_date
      
         if @w_error != 0
         begin
             select @w_msg = '[' + @w_sp_name + '] ' +  ' Error en la actualizacion de la fecha de proceso del Kernel: ' + convert(varchar(10), @w_error)
             /* 'Error en actualizacion'*/
             exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_sev     = 1,
             @i_msg     = @w_msg,
             @i_num     = 801085
             return 1
         end    
      end


      /* SSO 26/05/2011: Cambio de fecha Si es Solo CTS o Convivencia */
      if @w_ptfcob = 'CTS' or @w_ptfcob = 'CON'  
      begin
         /* Cambio de Fecha de Proceso en CTS */
         /*************************************/
         /*ITO: Inc-18239 Se remplaza el nombre del servidor quemado por el parametro SRVCFP
              Con la finalidad de hacer dinamico la ejecucion del proceso rp_date_proc*/
         --Se obtiene el nombre del transerver del ambiente
         select @w_srvcfp = pa_char 
         from cobis..cl_parametro 
         where pa_nemonico = 'SRVCFP' 
         and   pa_producto = 'BAT'
      
         select @w_proceso = @w_srvcfp + '...rp_date_proc'
      
         exec @w_error = @w_proceso @i_fecha = @w_date --ITO: Inc-18239 CTSSRV...rp_date_proc se remplaza por @w_proceso
      
         if @w_error != 0 
         begin
            select @w_msg = '[' + @w_sp_name + '] ' +  ' Error en la actualizacion de la fecha de proceso de CTS: ' + convert(varchar(10), @w_error)
            /* 'Error en actualizacion'*/
            exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_sev      = 1,
            @i_msg      = @w_msg,
            @i_num      = 801085
            return 1
         end    
      end

      /* Actualizacion de la Fecha de Proceso en la base de datos */
      /************************************************************/
      update cobis..ba_fecha_proceso
      set fp_fecha = @i_fecha

      if @@error <> 0 
      begin
         /* 'Error en insercion de la fecha  ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 805037
         return 1
      end
      return 0
   end   
end

/**** Search ****/
/****************/

if @i_operacion = 'S'

begin
   select convert(char(10),fp_fecha,@i_formato_fecha)
   from cobis..ba_fecha_proceso

   -- XCA: 18/03/2011 Inicio Validacion para control de Fecha Cierre

   /* if @i_sarta is null
         select convert(char(10),fp_fecha,@i_formato_fecha)
         from cobis..ba_fecha_proceso
      else
         select convert(char(10),fc_fecha_cierre,@i_formato_fecha)          
         from cobis..ba_sarta,cobis..ba_fecha_cierre          
         where sa_producto = fc_producto            
         and   sa_sarta = @i_sarta  */
              
         -- XCA: 18/03/2011 Fin Validacion para control de Fecha Cierre

   if @@rowcount = 0
   begin
      /* 'No existen parametros  '*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 801043 --801085
      return 1
   end
   set rowcount 0
   return 0
end
go
