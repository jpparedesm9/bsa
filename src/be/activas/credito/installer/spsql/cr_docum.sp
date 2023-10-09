
/***********************************************************************/
/*	Archivo:			cr_docum.sp                                    */
/*	Stored procedure:		sp_documento                               */
/*	Base de Datos:			cob_credito                                */
/*	Producto:			Credito	                                       */
/*	Disenado por:			Myriam Davila                              */
/*	Fecha de Documentacion: 	15/Ago/95                              */
/***********************************************************************/
/*			IMPORTANTE		       		                               */
/*	Este programa es parte de los paquetes bancarios propiedad de      */
/*	"MACOSA",representantes exclusivos para el Ecuador de la           */
/*	AT&T							                                   */
/*	Su uso no autorizado queda expresamente prohibido asi como         */
/*	cualquier autorizacion o agregado hecho por alguno de sus          */
/*	usuario sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante	               */
/***********************************************************************/
/*			PROPOSITO				                                   */
/*	Este stored procedure permite realizar las siguientes 	           */
/*      operaciones: Insercion y Busqueda en la tabla de documentos    */
/*	de impresion de los tramites   	    		       	               */
/***********************************************************************/
/*			MODIFICACIONES				                               */
/*	FECHA		AUTOR			RAZON		                           */
/*	15/Ago/95	Ivonne Ordonez		Emision Inicial	                   */
/*	30/May/97	Myriam Davila		Correcciones                       */
/*  28/Feb/2018 D. Cumbal           LLamada a store procedure de       */
/*                                  actualizacion                      */  
/*  20/01/2021  JCASTRO             REQ#147999                         */
/***********************************************************************/

use cob_credito
go

if exists (select * from sysobjects where name = 'sp_documento')
    drop proc sp_documento
go
CREATE  proc sp_documento (
   @s_ssn                int      = null,
   @s_user               login    = null,
   @s_sesn               int    = null,
   @s_term               descripcion = null,
   @s_date               datetime = null,
   @s_srv		 		 varchar(30) = null,
   @s_lsrv	  	 		 varchar(30) = null,
   @s_rol				 smallint = null,
   @s_ofi                smallint  = null,
   @s_org_err		     char(1) = null,
   @s_error		         int = null,
   @s_sev		         tinyint = null,
   @s_msg		        descripcion = null,
   @s_org		        char(1) = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_tramite		     int = null,
   @i_modo               smallint = null,
   @i_documento          integer  = null
)
as
declare
   @w_today              datetime,     /* fecha del dia */
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tramite		     int,
   @w_documento          smallint,
   @w_numero		     integer,
   @w_fecha_impresion 	 datetime,
   @w_usuario 		     login,
   @w_toperacion		 VARCHAR(20)

select @w_today = @s_date
select @w_sp_name = 'sp_documento'
/* Debug */
/*********/
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file = @t_file
        select '/** Stored Procedure **/ ' = @w_sp_name,
		s_ssn			  = @s_ssn,
	 	s_user			  = @s_user,
		s_sesn			  = @s_sesn,
		s_term			  = @s_term,
		s_date			  = @s_date,
		s_srv			  = @s_srv,
		s_lsrv			  = @s_lsrv,
		s_rol			  = @s_rol,
		s_ofi			  = @s_ofi,
		s_org_err		  = @s_org_err,
		s_error			  = @s_error,
		s_sev			  = @s_sev,
		s_msg			  = @s_msg,
		s_org			  = @s_org,
		t_trn			  = @t_trn,
		t_file			  = @t_file,
		t_from			  = @t_from,
		i_operacion		  = @i_operacion,
		i_modo			  = @i_modo,
		i_tramite  		  = @i_tramite,
		i_documento		  = @i_documento
    exec cobis..sp_end_debug
end
/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 21034 and @i_operacion = 'I') or
   (@t_trn <> 21434 and @i_operacion = 'S') or
   (@t_trn <> 21334 and @i_operacion = 'Q')

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 2101006
    return 1
end
/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S'
begin
    
    
	select @w_toperacion = tr_toperacion
    from cob_credito..cr_tramite 
    where tr_tramite = @i_tramite
    
    if @w_toperacion = 'GRUPAL'
    begin
    	exec  @w_return = cob_cartera..sp_actualiza_grupal
        	  @i_tramite           = @i_tramite,       --cuenta grupal padre
          	  @i_desde_cca         = 'N'
    
    	if @w_return != 0 
    	begin
        	 exec cobis..sp_cerror
         	@t_debug = @t_debug,
         	@t_file  = @t_file,
         	@t_from  = @w_sp_name,
         	@i_num   = @w_return
    	end
    end
    select
         @w_tramite = do_tramite,
         @w_documento = do_documento,
	 @w_numero = do_numero,
         @w_fecha_impresion = do_fecha_impresion,
         @w_usuario = do_usuario
    from cob_credito..cr_documento
    where
	 do_tramite = @i_tramite and
         do_documento = @i_documento
    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end
/* Insert */
/**********/
if @i_operacion = 'I'
begin
   if @w_existe = 0
   begin
	 begin tran
         insert into cr_documento(
              do_tramite,
              do_documento,
              do_numero,
              do_fecha_impresion,
              do_usuario)
         values (
              @i_tramite,
              @i_documento,
	      1,
              @w_today,
              @s_user)
         if @@error <> 0
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103001
             return 1
         end
         /* Transaccion de Servicio */
         /***************************/
         insert into ts_documento
         values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @i_tramite,
         @i_documento,
	 1,
         @w_today,
         @s_user)
         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1
         end
         commit tran
   end
   else
   if @w_existe = 1
   begin
	 select @w_numero = @w_numero + 1
	 begin tran
         update cr_documento
	 set
	      do_numero = @w_numero,
	      do_usuario = @s_user,
	      do_fecha_impresion = @w_today
	 where
	      do_tramite = @i_tramite and
	      do_documento = @i_documento
         if @@error <> 0
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2105001
             return 1
         end
         /* Transaccion de Servicio */
         /***************************/
         insert into ts_documento
         values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @w_tramite,
         @w_documento,
	 @w_numero,
         @w_today,
         @s_user)
         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1
         end
	 /* Transaccion de Servicio */
         /***************************/
         insert into ts_documento
         values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @i_tramite,
         @i_documento,
	 @w_numero - 1,
         @w_today,
         @s_user)
         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1
         end
	 select @w_numero
         commit tran
   end
end
/* Search */
/**********/
if @i_operacion = 'S'
begin
    
	select @w_toperacion = tr_toperacion
    from cob_credito..cr_tramite 
    where tr_tramite = @i_tramite
	
	-- REQ#147999
	if exists (select 1 from cob_workflow..wf_inst_proceso where io_campo_3 = @i_tramite and io_codigo_proc = '10') 
	begin 		
	   select @w_toperacion = 'RENOVACION'
	end
	-- REQ#147999
	
	SELECT  "Documento" = convert(int,do_documento),
		"Mnemonico" = id_mnemonico,
		"Descripcion" = id_descripcion,
		"Numero" = convert(int,do_numero),
        "Impresion" = id_dato,
		'Plantilla' = id_template
	FROM
		cr_documento,
		cr_imp_documento
	WHERE id_documento = do_documento 
	and do_tramite = @i_tramite
	AND id_toperacion = @w_toperacion
end
/* Query */
/**********/
if @i_operacion = 'Q'
begin
	select
        count(*)
    from cob_credito..cr_documento
    where
	     do_tramite = @i_tramite

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

return 0
GO

