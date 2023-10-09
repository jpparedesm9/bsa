/* ********************************************************************* */
/*      Archivo:                sp_cons_est.sp                           */
/*      Stored procedure:       sp_cons_est                              */
/*      Base de datos:          cob_credito                              */
/*      Producto:               Credito                                  */
/*      Disenado por:           Karina Vizcaíno                          */
/*      Fecha de escritura:     02-Sep-2021                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Obtener y actualizar estados de modificacion de la pantalla      */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      02/Sep/2021     KVI       Version Inicial                        */
/* ********************************************************************* */

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_cons_est')
   drop proc sp_cons_est
go
IF OBJECT_ID ('dbo.sp_cons_est') IS NOT NULL
	DROP PROCEDURE dbo.sp_cons_est
GO

create proc sp_cons_est (
	@s_ssn			   int         = null,
	@s_user			   login       = null,
	@s_sesn			   int         = null,
	@s_term			   varchar(32) = null,
	@s_date			   datetime    = null,
	@s_srv			   varchar(30) = null,
	@s_lsrv			   varchar(30) = null, 
	@s_rol			   smallint    = null,
	@s_ofi			   smallint    = null,
	@s_org_err		   char(1)     = null,
	@s_error		   int         = null,
	@s_sev			   tinyint     = null,
	@s_msg			   descripcion = null,
	@s_org			   char(1)     = null,
	@t_debug		   char(1)     = 'N',
	@t_file			   varchar(14) = null,
	@t_from			   varchar(32) = null,
	@t_trn			   smallint    = null,
	@i_operacion 	   varchar(2), 
	@i_modo      	   tinyint     = null,
	@i_tipo      	   varchar(1)  = null,
	@i_ente            int         = null,
	@i_estado          varchar(1)  = null,
	@i_formato_fecha   int         = null
)

as

declare @w_return         int,
        @w_sp_name        varchar(32)

select @w_sp_name = 'sp_cons_est'


if @i_operacion = 'Q' 
begin
  if @t_trn = 21745
  begin
    if @i_tipo = 'C'
    begin
      if @i_modo = 0	
      begin    		    
        select 'ente'             = es_ente, 
  	           'estado_direccion' = es_estado_dir,
               'estado_mail'      = es_estado_mail,
               'fecha'            = convert(char(10), es_fecha, @i_formato_fecha)			   
  	    from   cob_credito..cr_estados_sol_mod_dat
        where  es_ente  = @i_ente
         
        if @@rowcount = 0
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001 /*'No existe dato solicitado'*/				
  	  end
  	end
    return 0
  end
  else
  begin
    exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 151051
      /*  'No corresponde codigo de transaccion' */
    return 1
  end
end

if @i_operacion = 'U' 
begin
  if @t_trn = 21745
  begin   
    if @i_tipo = 'D'
    begin  
	  if exists (select 1 from cob_credito..cr_estados_sol_mod_dat where es_ente = @i_ente)
      begin
        update cob_credito..cr_estados_sol_mod_dat
        set es_estado_dir = @i_estado
        where es_ente = @i_ente
        
	     if @@error <> 0
        begin
          exec cobis..sp_cerror
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 705066/* 'Error en la actualizacion de cambios de estado'*/      
          return 1
        end 
	  end 
      return 0
	end
	
	if @i_tipo = 'M'
    begin  
	  if exists (select 1 from cob_credito..cr_estados_sol_mod_dat where es_ente = @i_ente)
      begin
        update cob_credito..cr_estados_sol_mod_dat
        set es_estado_mail = @i_estado
        where es_ente = @i_ente
        
	     if @@error <> 0
        begin
          exec cobis..sp_cerror
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 705066/* 'Error en la actualizacion de cambios de estado'*/      
          return 1
        end 
	  end 
      return 0
	end
  end
  else
  begin
    exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 151051
      /*  'No corresponde codigo de transaccion' */
    return 1
  end
end

go

