/************************************************************************/
/*	Archivo:		t_ho_tmp.sp				*/
/*	Stored procedure:	sp_tipo_horario_tmp			*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura:	24/Feb/94				*/
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
/*	Insercion de tipos de horario en la tabla temporal		*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Feb/1994	F.Espinosa	Emision inicial			*/
/*	04/May/95       S. Vinces	Admin Distribuido		*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tipo_horario_tmp')
   drop proc sp_tipo_horario_tmp







go
create proc sp_tipo_horario_tmp (
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
	@t_trn			smallint =NULL,
	@i_operacion		varchar(1),
	@i_descripcion		descripcion = NULL,	
	@i_fecha_ult_mod	datetime = NULL,	
	@i_creador		smallint = NULL,
	@i_conexion		smallint,
	@i_central_transmit	varchar(1) = null
)
as
declare
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_nt_nombre            varchar(32),
	@w_num_nodos        	smallint,    
	@w_contador          	smallint,
	@w_cmdtransrv		varchar(60),
	@w_clave		int

select @w_sp_name = 'sp_tipo_horario_tmp'


/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' ) and (@i_central_transmit is NULL)  
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1))
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 15096
begin
 /* chequeo de claves foraneas */
  if (@i_descripcion is NULL OR @i_fecha_ult_mod is NULL OR @i_creador is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
  end

  if not exists (
     select fu_funcionario
       from cl_funcionario
      where fu_funcionario = @i_creador)
  begin
/*  'No existe funcionario' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
        return 1
  end

  begin tran

    insert into ad_tipo_horario_tmp (tht_tipo, tht_descripcion,
			    tht_ult_secuencial, tht_fecha_ult_mod,
			    tht_creador, tht_estado, tht_conexion)
		    values (NULL , @i_descripcion,
			    0,@i_fecha_ult_mod,
			    @i_creador, 'V', @i_conexion)
    if @@error != 0
    begin
/*  'Error en insercion de tipo de horario en Tabla Temporal' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153029
        return 1
    end
  commit tran

  /******************************* Para   Unix  **************************/

	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
          from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             

	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	select @w_contador = 1
	while @w_contador <= @w_num_nodos
         begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'
	        
		set rowcount 0
		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv	
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_descripcion = @i_descripcion,
					@i_fecha_ult_mod = @i_fecha_ult_mod,
					@i_creador     = @i_creador,
					@i_conexion    = @i_conexion,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave,
				@i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
  /******************************* Para   Unix  **************************/
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
end
go
