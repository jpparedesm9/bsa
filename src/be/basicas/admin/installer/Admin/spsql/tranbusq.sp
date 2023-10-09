/************************************************************************/
/*	Archivo:		tranbusq.sp				*/
/*	Stored procedure:	sp_transacion_busq			*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 01/Mar/1994					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Busqueda del transaccion bajo los siguientes criterios:		*/
/*		Alfabetico						*/
/*		Mnemonico						*/
/*		Codigo							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	01/Mar/1994	F.Espinosa	Emision inicial			*/
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_transaccion_busq')
   drop proc sp_transaccion_busq







go
create proc sp_transaccion_busq (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint = null,
	@i_tipo			char(1) = null,
	@i_modo			tinyint = null,
	@i_transaccion		int = null,
	@i_descripcion		descripcion = NULL,
	@i_nemonico		char(6) = null,
	@i_valor		varchar(30) 
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)


select @w_today = @s_date
select @w_sp_name = 'sp_transaccion_busq'

If @t_trn = 15071
begin
/* ** search ** */
  set rowcount 20

  /* Busqueda Afabetica */ 
  if @i_tipo = '1'
  begin
     if @i_modo = 0
     begin
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 35),
		'Mnemonico' = tn_nemonico
         from   cl_ttransaccion
	where	tn_descripcion like @i_valor
        order   by tn_descripcion

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */
        
       set rowcount 0
     end

     if @i_modo = 1
     begin
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 35),
		'Mnemonico' = tn_nemonico
         from   cl_ttransaccion
        where   tn_descripcion > @i_descripcion
          and	tn_descripcion like @i_valor
        order   by tn_descripcion
        
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

        
       set rowcount 0
     end
  end
  
  /* Busqueda en base al Mnemonico */ 
  if @i_tipo = '2'
  begin
     if @i_modo = 0
     begin
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 35),
		'Mnemonico' = tn_nemonico
         from   cl_ttransaccion
	where	tn_nemonico like @i_valor
        order   by tn_nemonico
        
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

        
       set rowcount 0
     end

     if @i_modo = 1
     begin
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 35),
		'Mnemonico' = tn_nemonico
         from   cl_ttransaccion
        where   tn_nemonico > @i_nemonico
          and	tn_nemonico like @i_valor
        order   by tn_nemonico
        
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

        
       set rowcount 0
     end
  end

  /* Busqueda por Codigo */
  if @i_tipo = '3'
  begin
     if @i_modo = 0
     begin
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 35),
		'Mnemonico' = tn_nemonico
         from   cl_ttransaccion
	where	convert(varchar,tn_trn_code) like @i_valor
        order   by tn_trn_code
        
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

        
       set rowcount 0
     end

     if @i_modo = 1
     begin
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 35),
		'Mnemonico' = tn_nemonico
         from   cl_ttransaccion
        where   tn_trn_code > @i_transaccion
          and	convert(varchar, tn_trn_code) like @i_valor
        order   by tn_trn_code

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */
        
        
       set rowcount 0
     end
  end
return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end

go
