/************************************************************************/
/* Archivo:                ejec.sp                                      */
/* Stored procedure:       sp_ejecucion                                 */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     30-Marzo-1994                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
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
/*    25-Jun-2002    S. Soto         Cambios para ejecuci¢n desde       */
/*                                   distintos transervers (grafico)    */
/*    06-Jul-2009    F. Lopez        Retardar ejecucion de hilos (PRL)  */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_ejecucion')
   drop proc sp_ejecucion
go
create proc sp_ejecucion    (
   @s_ssn         int = null,
   @s_date        datetime = null,
   @s_user        login = null,
   @s_term        descripcion = null,
   @s_corr        char(1) = null,
   @s_ssn_corr    int = null,
   @s_ofi       smallint = null,
   @t_rty         char(1) = null,
   @t_trn       smallint = 601,
   @t_debug    char(1) = 'N',
   @t_file        varchar(14) = null,
   @t_from        varchar(30) = null,
   @i_operacion      char(1),
   @i_shell    varchar(255) = null,
   @i_param1      varchar(255) = null,
   @i_param2      varchar(255) = null,
   @i_param3    varchar(255) = null,
   @i_param4    varchar(255) = null,
   @i_param5    varchar(255) = null,
   @i_param6    varchar(255) = null, 
   @i_param7       varchar(255) = null, 
   @i_dstserver            varchar(64) = "", 
   @i_modo                 tinyint = 0,
   @i_ssn         int = null,
   @i_sarta    int = null,
   @i_fecha_proceso  datetime = null,  
   @i_corrida     smallint = null
)

as 
declare
   @w_sp_name        varchar(30),
   @w_today       datetime, 
   @w_comando                   varchar(255),
   @w_comando2                  varchar(255)

select @w_today = getdate()
select @w_sp_name = 'sp_ejecucion'

/************************************************/

if (@t_trn <> 8071 and @i_operacion = 'E')  or
   (@t_trn <> 8072 and @i_operacion = 'Q') 

begin

   /* 'Tipo de transaccion no corresponde' */

   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 601077
   return 1

end

/* ==============================

--' SE REALIZA LA SIGUIENTE ASIGNACION MIENTRAS NO SE VALIDA EL CORRECTO
--' FUNCIONAMIENTO DEL CONTROL DE CONCURRECIA EN LA EJECUCION DE LOTES
           

-- VALIDACION DE CONCURRENCIA DE CORRIDA
if exists (select 1 from
      ba_corrida
      where co_corrida_id = @i_corrida
      and   co_sarta = @i_sarta
      and   co_fecha_proceso = @i_fecha_proceso
      and   co_ssn = @i_ssn )
begin

============================== */
   if @i_modo = 0 
      begin      
         exec ADMIN...rp_exec @i_shell,@i_param1,@i_param2  ,@i_param3,@i_param4,@i_param5,@i_param6,@i_param7 
         waitfor delay '00:00:04:000'
         return 0
      end

   if @i_modo = 1 
      begin
--  		select @w_comando = @i_dstserver + "...rp_exec '"
--              select @w_comando = @w_comando + rtrim(ltrim(@i_shell)) + "', '"
--		select @w_comando = @w_comando + rtrim(ltrim(@i_param1)) + " "
--		select @w_comando = @w_comando + rtrim(ltrim(@i_param2)) + "'"

                      --EBA: MAYO 12 2005
 		select @w_comando = @i_dstserver + "...rp_exec '"
		select @w_comando = @w_comando + rtrim(ltrim(@i_shell)) + "'"
		select @w_comando2 =  ",'" + rtrim(ltrim(@i_param1)) + " "
		select @w_comando2 = @w_comando2 + rtrim(ltrim(@i_param2)) + "'"

         --Si se requiere pasar mas parametros completar la cadena @w_comando 

         exec (@w_comando + @w_comando2)
         waitfor delay '00:00:00:300'
         return 0
      end

/* ==============================

--' SE REALIZA LA SIGUIENTE ASIGNACION MIENTRAS NO SE VALIDA EL CORRECTO
--' FUNCIONAMIENTO DEL CONTROL DE CONCURRECIA EN LA EJECUCION DE LOTES
end
else
begin
   /* 'La corrida no esta activa para su SSN' */

   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 808050

  return 1
end
============================== */
go

