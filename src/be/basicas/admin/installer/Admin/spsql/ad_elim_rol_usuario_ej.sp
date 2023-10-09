
/************************************************************************/
/*  Archivo:            ad_elim_rol_usuario_ej.sp                       */
/*  Stored procedure:   sp_elim_rol_usuario_ej                          */
/*  Base de datos:      cobis                                           */      
/*  Producto:             Admin Batch                                   */
/*  Disenado por:          Edison Andrade                               */
/*  Fecha de escritura: 24-May-2012                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/* Este programa realiza la actualizacion masiva de fechas de caducidad */
/* a roles de funcionario HSBC Costa Rica                               */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  11-03-2016  BBO         Migracion Sybase-Sqlserver FAL              */
/*  25-05-2016  ELO         Migracion Sybase-Sqlserver FALABELLA        */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_elim_rol_usuario_ej')
   drop proc sp_elim_rol_usuario_ej
go
create proc sp_elim_rol_usuario_ej(
    @s_ssn              int            = null,
    @s_user             login       = null,
    @s_term             varchar(30) = null,
    @s_date             datetime    = null,
    @s_srv              varchar(30) = null,
    @s_lsrv             varchar(30) = null,
    @s_ofi              smallint    = NULL,
    @s_rol              smallint    = NULL,
    @s_org_err          char(1)     = NULL,
    @s_error            int         = NULL,
    @s_sev              tinyint     = NULL,
    @s_msg              descripcion = NULL,
    @s_org              char(1)     = NULL,
    @t_from             varchar(32) = null,
    @t_trn              int         = null,
    @t_show_version     bit         = 0,         -- Mostrar la version del programa
    @t_file             varchar(14) = null,
    @t_debug            char(1)     = 'N',    
    @i_filial           tinyint      ,
    @i_fecha            datetime     ,        
    @i_sarta            int         = null,
    @i_batch            int         = null,
    @i_secuencial       int         = null,
    @i_corrida          int         = null,
    @i_intento          int         = null
)
as
declare
    @w_sp_name          varchar(32), -- Nombre stored proc
    @w_today            datetime,     /* fecha del dia */ 
    @w_login            varchar(30),
    @w_rol              tinyint,
    @w_retorno          int,
    @w_retorno_ej       int,
    @w_servidor         varchar(24),
    @w_ssn              int,
	@w_fecha_ini_rol datetime,
	@w_fecha_cad_rol datetime


select @w_today = getdate()
select @w_sp_name = 'sp_elim_rol_usuario_ej'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_elim_rol_usuario_ej, Version 4.0.0.0'
    return 0
end

if not exists (select 1 from cobis..cl_filial 
               where fi_filial = @i_filial)
begin    
    exec @w_retorno_ej    = cobis..sp_ba_error_log
         @i_sarta         = @i_sarta,
         @i_batch         = @i_batch,
         @i_secuencial    = @i_secuencial,
         @i_corrida       = @i_corrida,
         @i_intento       = @i_intento,
         @i_error         = 101002,
         @i_detalle       = 'ERROR: No existe la filial'
	if @w_retorno_ej > 0
    begin        
        return @w_retorno_ej
    end
    else
    begin
        return 101002
    end
end

-- obtener el nombre del servidor de ejecucion 
select @w_servidor = ba_serv_destino
from  cobis..ba_batch
where ba_batch = @i_batch

--------- Obtener el secuencial del SSN ------
exec @w_ssn = ADMIN...rp_ssn
select @w_ssn = isnull(@w_ssn,0)


Begin tran
--------- Cursor roles de usuario -----------
declare user_rol cursor for
    select ur_login, ur_rol,
			ur_fecha_ini_rol ,ur_fec_cad_rol --Se agrega campo 08/OCT/2012
    from cobis..ad_usuario_rol
    where ur_fec_cad_rol <= @i_fecha

open user_rol

fetch user_rol into
    @w_login,    @w_rol,
	@w_fecha_ini_rol, @w_fecha_cad_rol

--if (@@fetch_status = -1)    --sqlstatus: mig syb-sqls 11032016
--Begin
--    close user_rol          --mig syb-sqls 11032016
--    deallocate user_rol     --mig syb-sqls 11032016
--    
--    exec cobis..sp_cerror
--             @t_debug = @t_debug,
--             @t_file  = @t_file, 
--             @t_from  = @w_sp_name,
--             @i_num   = 2101028 -- 'Error al abrir un cursor'
--    return 2101028
--End
    
while @@fetch_status = 0   --sqlstatus: mig syb-sqls 11032016
begin
    
		exec @w_retorno = cobis..sp_usuario_rol  
				 @s_ssn          = @w_ssn,
				 @s_user         = 'sa',
				 @s_term         = 'consola',
				 @s_date         = @i_fecha,
				 @s_srv          = @w_servidor,
				 @s_lsrv         = @w_servidor,
				 @s_ofi          = 1,
				 @t_trn          = 572,
				 @i_operacion    = 'D',
				 @i_login        = @w_login,
				 @i_rol          = @w_rol
			 
		 if @w_retorno > 0
		BEGIN        
					exec 	@w_retorno_ej = cobis..sp_ba_error_log
								 @i_sarta      = @i_sarta,
								 @i_batch      = @i_batch,
								 @i_secuencial = @i_secuencial,
								 @i_corrida    = @i_corrida,
								 @i_intento    = @i_intento,
								 @i_error      = @w_retorno,
								 @i_detalle    = 'ERROR EJECUCION: sp_usuario_rol'
			 
					IF @w_retorno_ej > 0
					BEGIN 
							return @w_retorno_ej 
					END
					ELSE
					BEGIN
							return @w_retorno
					END
		End
		Else
		Begin	
				exec @w_retorno = cobis..sp_usuario_rol_hsbc  --05/10/2012 se cambia de sp_usuario_rol a sp_usuario_rol_hsbc
						 @s_ssn          = @w_ssn,
						 @s_user         = 'sa',
						 @s_term         = 'consola',
						 @s_date         = @i_fecha,
						 @s_srv          = @w_servidor,
						 @s_lsrv         = @w_servidor,
						 @s_ofi          = 1,
						 @t_trn          = 572,
						 @i_operacion    = 'D',
						 @i_login        = @w_login,
						 @i_rol          = @w_rol,					 
						 @i_fecha_ini_rol  =  @w_fecha_ini_rol,   --08/OCT/2012 se agrega campo
						 @i_fec_cad_rol = @w_fecha_cad_rol 		--08/OCT/2012 se agrega campo					 
							 
				if @w_retorno > 0
				BEGIN        
						exec @w_retorno_ej = cobis..sp_ba_error_log
								 @i_sarta      = @i_sarta,
								 @i_batch      = @i_batch,
								 @i_secuencial = @i_secuencial,
								 @i_corrida    = @i_corrida,
								 @i_intento    = @i_intento,
								 @i_error      = @w_retorno,
								 @i_detalle    = 'ERROR EJECUCION: sp_usuario_rol_hsbc'
					 
						IF @w_retorno_ej > 0
						BEGIN 
								return @w_retorno_ej 
						END
						ELSE
						BEGIN
								return @w_retorno
						END
				End					
		End
		
		fetch user_rol into
				@w_login,  @w_rol,
				@w_fecha_ini_rol, @w_fecha_cad_rol
				
		select @w_ssn = @w_ssn + 1
    
end --while

close user_rol
deallocate user_rol

commit tran

return 0

go
