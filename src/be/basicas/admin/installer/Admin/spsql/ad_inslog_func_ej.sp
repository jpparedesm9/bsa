/************************************************************************/
/*  Archivo:            ad_inslog_func_ej.sp                            */
/*  Stored procedure:   sp_ad_inslog_func_ej                            */
/*  Base de datos:      cobis                                           */
/*  Producto: 		Admin Batch                                     */
/*  Disenado por:  	Edison Andrade                                  */
/*  Fecha de escritura: 04-Jun-2012                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/* Este programa actualiza la consultas de funcionalidades de transacc. */
/* de servicio.                                                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  11-03-2016  BBO         Migracion Sybase-Sqlserver FALABELLA        */
/*  25-05-2016  ELO         Migracion Sybase-Sqlserver FALABELLA        */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_ad_inslog_func_ej')
   drop proc sp_ad_inslog_func_ej
go
create proc sp_ad_inslog_func_ej(
	@s_ssn          	int	    	= null,
	@s_user         	login       = null,
	@s_term         	varchar(30) = null,
	@s_date         	datetime    = null,
	@s_srv          	varchar(30) = null,
	@s_lsrv         	varchar(30) = null,
	@s_ofi          	smallint    = NULL,
	@s_rol          	smallint    = NULL,
	@s_org_err      	char(1)     = NULL,
	@s_error        	int         = NULL,
	@s_sev         		tinyint     = NULL,
	@s_msg          	descripcion = NULL,
	@s_org          	char(1)     = NULL,
	@t_from         	varchar(32) = null,
	@t_trn          	int         = null,
	@t_show_version		bit 	    = 0, 		-- Mostrar la version del programa
	@t_file			    varchar(14) = null,
  	@t_debug	        char(1)     = 'N',	
	@i_filial 		    tinyint		,
	@i_fecha 		    datetime 	,		
	@i_sarta 	        int 		= null,
	@i_batch 		    int 		= null,
	@i_secuencial 		int 		= null,
	@i_corrida 		    int 		= null,
	@i_intento 		    int 		= null

)
as
declare
	@w_sp_name      	varchar(32), -- Nombre stored proc
	@w_today      		DATETIME,     /* fecha del dia */ 
	@w_mensaje		VARCHAR(100),
	@w_retorno_ej		INT,
	@w_servidor		varchar(24),
	@w_ssn			INT,
	@w_af_fecha		DATETIME,
	@w_af_terminal		VARCHAR (64),
	@w_af_usuario		login,
	@w_af_oficina		SMALLINT,
	@w_af_rol		SMALLINT,
	@w_af_etiqueta		 VARCHAR (100),
	@w_af_componente	VARCHAR (255),
	@w_af_hora		DATETIME


select @w_today = getdate()
select @w_sp_name = 'sp_ad_inslog_func_ej'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_ad_inslog_func_ej, Version 4.0.0.0'
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


exec @w_ssn = ADMIN...rp_ssn
select @w_ssn = isnull(@w_ssn,0)

begin tran

--------- Cursor acceso funcionalidades CEN -----------
declare acc_func_cen cursor for
	SELECT af_fecha, af_terminal, af_usuario, af_oficina, af_rol, af_etiqueta, af_componente, af_hora
	FROM cobis..ad_acceso_func_cen
	where af_fecha = @i_fecha  

open acc_func_cen

fetch acc_func_cen into
	@w_af_fecha,
	@w_af_terminal,
	@w_af_usuario,
	@w_af_oficina,
	@w_af_rol,
	@w_af_etiqueta,
	@w_af_componente,
	@w_af_hora

--if (@@fetch_status = -1)   --sqlstatus: mig syb-sqls 11032016
--begin
--    close acc_func_cen          --mig syb-sqls 11032016
--    deallocate acc_func_cen     --mig syb-sqls 11032016
--    
--    -- Error al abrir un cursor --
--    exec cobis..sp_cerror
--             @t_debug = @t_debug,
--             @t_file  = @t_file, 
--             @t_from  = @w_sp_name,
--             @i_num   = 2101028
--    return 2101028
--end
    
while @@fetch_status = 0    --sqlstatus: mig syb-sqls 11032016
begin
	
	INSERT ts_acceso_func_cen(
	       secuencia,       tipo_transaccion, clase,            fecha,
	       oficina_s,       usuario,          terminal_s,       srv,
	       lsrv,            filial,           menu_visitado,    libreria,
	       hora_visita)
	VALUES(@w_ssn,          15298,            'N',              @w_af_fecha,
	       @w_af_oficina,   @w_af_usuario,    @w_af_terminal,   @w_servidor,
	       @w_servidor,     @i_filial,        @w_af_etiqueta,   @w_af_componente,
	       @w_af_hora)
      
	if @@error != 0
	BEGIN
         select @w_mensaje = 'ERROR EJECUCION: Error en inserción de transacción de servicio'
        
         exec @w_retorno_ej = cobis..sp_ba_error_log
			  @i_sarta      = @i_sarta,
			  @i_batch      = @i_batch,
			  @i_secuencial = @i_secuencial,
			  @i_corrida    = @i_corrida,
			  @i_intento    = @i_intento,
			  @i_error      = @@error,
			  @i_detalle    = @w_mensaje
	         
	    if @w_retorno_ej > 0
  	    BEGIN 
	        return @w_retorno_ej 
	    END
        ELSE
        BEGIN
            return 143005
        END
        
    END
	
	fetch acc_func_cen into
		@w_af_fecha,
		@w_af_terminal,
		@w_af_usuario,
		@w_af_oficina,
		@w_af_rol,
		@w_af_etiqueta,
		@w_af_componente,
		@w_af_hora

	select @w_ssn = @w_ssn + 1 
end --while

close acc_func_cen
deallocate acc_func_cen

------------- Fin de Cursor acc_func_cen ---------------------
DELETE cobis..ad_acceso_func_cen WHERE af_fecha = @i_fecha

commit tran

RETURN 0

go
