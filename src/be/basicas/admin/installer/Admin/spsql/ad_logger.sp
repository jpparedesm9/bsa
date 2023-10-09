/************************************************************************/
/*	Archivo:		ad_log.sp				*/
/*	Stored procedure:	sp_ad_logger				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Patricio Martinez/Diego Hidalgo			*/
/*	Fecha de escritura: 20/jun/1995					*/
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
/*	Este programa procesa las transacciones logger de:		*/
/*	Busqueda de procedimientos logger bajo los siguientes criterios:*/
/*		codigo, nombre, base, usuario 				*/
/*	Busqueda de parametros de un procedimiento logger por :		*/
/*		codigo, usuario y nombre del procedimiento		*/
/*	Busqueda de mensajes de un procedimiento logger por :		*/
/*		codigo y usuario del procedimiento			*/
/*	Busqueda de alias de un procedimiento logger por :		*/
/*		nombre y nemonico del procedimiento			*/
/*	Actualizacion tablas del Logger:				*/
/*		lo_procedure, lo_parametro, lo_mensaje, lo_alias 	*/
/*	Eliminacion de registros de tablas del Logger:			*/
/*		lo_procedure, lo_parametro, lo_mensaje, lo_alias 	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	20/jun/1995	D.Hidalgo	Emision inicial			*/
/*  21/04/2016  BBO         Migracion Syb-SQL FAL                       */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_ad_logger')
   drop proc sp_ad_logger
go
create proc sp_ad_logger       (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
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
	@i_operacion		char(1) = NULL,
	@i_tipo			char(2) = NULL,
	@i_modo			tinyint = NULL,
	@i_codigo		int = NULL,
	@i_login	      	varchar(30) = NULL,
	@i_server		varchar(30) = NULL,
	@i_base			varchar(30) = NULL,
	@i_nombre		varchar(30) = NULL,
	@i_fecha		datetime = NULL,
	@i_po_modo		char(1) = NULL,
	@i_estado		char(1) = NULL,
	@i_return		int = NULL,
	@i_ssn			int = NULL,
	@i_ssn_corr		int = NULL,
	@i_sec			int = NULL,
	@i_io			tinyint = NULL,
	@i_largo		int = NULL,
	@i_tipodato		tinyint = NULL,
	@i_char			char(255) = NULL,
	@i_varchar		varchar(255) = NULL,
	@i_int 			int = NULL,
	@i_smallint		smallint = NULL,
	@i_tinyint		tinyint = NULL,
	@i_float		float = NULL,
	@i_real			real = NULL,
	@i_money		money = NULL,
	@i_smallmoney		smallmoney = NULL,
	@i_datetime		datetime = NULL,
	@i_smalldatetime	smalldatetime = NULL,
	@i_numero		int = NULL,
	@i_severidad		tinyint = NULL,
	@i_me_tipo		char(1) = NULL,
	@i_mensaje		varchar(255) = NULL,
	@i_valor		varchar(30) = '%',
	@o_retorna		int=NULL out
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_mal			varchar(32)

select @w_today = @s_date
select @w_sp_name = 'sp_ad_logger'


/* ** Busqueda de stored procedure ** */
If @i_operacion = 'B'
begin

  set rowcount 20
  
  /* Busqueda de procedimientos bajo los siguientes criterios:*/

  /* Busqueda por Codigo */
  if @i_tipo = '1'
  begin
     if @i_modo = 0
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
 	 where  convert(varchar, po_proc) like @i_valor
         order  by po_proc
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
         where  po_proc > @i_codigo
           and	convert(varchar, po_proc) like @i_valor
         order  by po_proc 
        set rowcount 0
     end
  end

  /* Busqueda por Nombre del Procedimiento */ 
  if @i_tipo = '2'
  begin
     if @i_modo = 0
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
	 where	po_nom_proc like @i_valor
         order  by po_nom_proc, po_proc
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
         where  po_nom_proc like @i_valor
           and  (po_nom_proc > @i_nombre or
		 (po_nom_proc = @i_nombre and po_proc > @i_codigo))
         order  by po_nom_proc, po_proc 
        set rowcount 0
     end
  end
  
  /* Busqueda por Base */ 
  if @i_tipo = '3'
  begin
     if @i_modo = 0
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
	where	po_base like @i_valor
        order   by po_base, po_proc 
       set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
         where  po_base like @i_valor
          and   (po_base > @i_base or
		 (po_base = @i_base and po_proc > @i_codigo))
        order   by po_base, po_proc 
       set rowcount 0
     end
  end

  /* Busqueda por Usuario */
  if @i_tipo = '4'
  begin
     if @i_modo = 0
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
	 where	po_login like @i_valor
         order  by po_login, po_proc 
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'CODIGO'   = po_proc,
		'USUARIO'  = substring(po_login,1,10),
		'SERVIDOR' = substring(po_server,1,15),
		'BASE'     = substring(po_base,1,15),
		'NOMBRE'   = substring(po_nom_proc,1,15),
		'FECHA'    = po_fecha,
		'MODO'     = po_modo,
		'ESTADO'   = po_estado,
		'RETURN'   = po_return,
		'SSN'      = po_ssn,
		'SSN_CORR' = po_ssn_corr
          from  lo_procedure 
         where  po_login like @i_valor
           and  (po_login > @i_login or
		 (po_login = @i_login and po_proc > @i_codigo))
         order  by po_login, po_proc 
        set rowcount 0
     end
  end

  /* Busqueda de parametros de un procedimiento por : */

  /* Busqueda por codigo del procedimiento */
  if @i_tipo = '5'
  begin
     if @i_modo = 0
     begin
        select	'COD. PROC.'       = pm_proc,
		'USUARIO'          = substring(pm_login,1,10),
		'PARAMETRO' 	   = substring(pm_nomparam,1,15),
		'SECUENCIAL'       = pm_sec, 
		'I/O' 		   = pm_io,
		'LARGO'            = pm_largo,
		'TIPO DATO'        = pm_tipodato,
		'CHAR'             = substring(pm_char,1,15),
		'VARCHAR'          = substring(pm_varchar,1,15),
		'INT'              = isnull(pm_int,0),
		'SMALLINT'         = isnull(pm_smallint,0),
		'TINYINT'          = isnull(pm_tinyint,0),
		'FLOAT'            = isnull(pm_float,0.0),
		'REAL'             = isnull(pm_real,0.0),
		'MONEY'            = isnull(pm_money,0.0),
		'SMALLMONEY'       = isnull(pm_smallmoney,0.0),
		'DATETIME'         = isnull(pm_datetime,"01/01/1990"),
		'SMALLDATETIME'    = isnull(pm_smalldatetime,"01/01/1990")
          from  lo_parametro 
	 where	convert(varchar,pm_proc) like @i_valor
         order  by pm_proc, pm_nomparam
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'COD. PROC.'       = pm_proc,
		'USUARIO'          = substring(pm_login,1,10),
		'PARAMETRO' 	   = substring(pm_nomparam,1,15),
		'SECUENCIAL'       = pm_sec, 
		'I / O' 	   = pm_io,
		'LARGO'            = pm_largo,
		'TIPO DATO'        = pm_tipodato,
		'CHAR'             = substring(pm_char,1,15),
		'VARCHAR'          = substring(pm_varchar,1,15),
                'INT'              = isnull(pm_int,0),
                'SMALLINT'         = isnull(pm_smallint,0),
                'TINYINT'          = isnull(pm_tinyint,0),
                'FLOAT'            = isnull(pm_float,0.0),
                'REAL'             = isnull(pm_real,0.0),
                'MONEY'            = isnull(pm_money,0.0),
                'SMALLMONEY'       = isnull(pm_smallmoney,0.0),
                'DATETIME'         = isnull(pm_datetime,"01/01/1990"),
                'SMALLDATETIME'    = isnull(pm_smalldatetime,"01/01/1990")
          from  lo_parametro 
         where  pm_proc > @i_codigo 
	   and 	convert(varchar,pm_proc) like @i_valor
         order  by pm_proc, pm_nomparam
        set rowcount 0
     end
  end
  
  /* Busqueda por usuario del parametro */
  if @i_tipo = '6'
  begin
     if @i_modo = 0
     begin
        select	'COD. PROC.'       = pm_proc,
		'USUARIO'          = substring(pm_login,1,10),
		'PARAMETRO' 	   = substring(pm_nomparam,1,15),
		'SECUENCIAL'       = pm_sec, 
		'I / O'    	   = pm_io,
		'LARGO'            = pm_largo,
		'TIPO DATO'        = pm_tipodato,
		'CHAR'             = substring(pm_char,1,15),
		'VARCHAR'          = substring(pm_varchar,1,15),
                'INT'              = isnull(pm_int,0),
                'SMALLINT'         = isnull(pm_smallint,0),
                'TINYINT'          = isnull(pm_tinyint,0),
                'FLOAT'            = isnull(pm_float,0.0),
                'REAL'             = isnull(pm_real,0.0),
                'MONEY'            = isnull(pm_money,0.0),
                'SMALLMONEY'       = isnull(pm_smallmoney,0.0),
                'DATETIME'         = isnull(pm_datetime,"01/01/1990"),
                'SMALLDATETIME'    = isnull(pm_smalldatetime,"01/01/1990")
          from  lo_parametro 
	 where	pm_login like @i_valor
         order  by pm_login, pm_proc
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'COD. PROC.'       = pm_proc,
		'USUARIO'          = substring(pm_login,1,10),
		'PARAMETRO' 	   = substring(pm_nomparam,1,15),
		'SECUENCIAL'       = pm_sec, 
		'I / O'     	   = pm_io,
		'LARGO'            = pm_largo,
		'TIPO DATO'        = pm_tipodato,
		'CHAR'             = substring(pm_char,1,15),
		'VARCHAR'          = substring(pm_varchar,1,15),
                'INT'              = isnull(pm_int,0),
                'SMALLINT'         = isnull(pm_smallint,0),
                'TINYINT'          = isnull(pm_tinyint,0),
                'FLOAT'            = isnull(pm_float,0.0),
                'REAL'             = isnull(pm_real,0.0),
                'MONEY'            = isnull(pm_money,0.0),
                'SMALLMONEY'       = isnull(pm_smallmoney,0.0),
                'DATETIME'         = isnull(pm_datetime,"01/01/1990"),
                'SMALLDATETIME'    = isnull(pm_smalldatetime,"01/01/1990")
          from  lo_parametro 
         where  pm_login like @i_valor
	   and  (pm_login > @i_nombre or 
		 (pm_login = @i_nombre and pm_proc > @i_codigo) )
         order  by pm_login, pm_proc
        set rowcount 0
     end
  end
  
  /* Busqueda por nombre del parametro */
  if @i_tipo = '7'
  begin
     if @i_modo = 0
     begin
        select	'COD. PROC.'       = pm_proc,
		'USUARIO'          = substring(pm_login,1,10),
		'PARAMETRO'        = substring(pm_nomparam,1,15),
		'SECUENCIAL'       = pm_sec, 
		'I / O'   	   = pm_io,
		'LARGO'            = pm_largo,
		'TIPO DATO'        = pm_tipodato,
		'CHAR'             = substring(pm_char,1,15),
		'VARCHAR'          = substring(pm_varchar,1,15),
                'INT'              = isnull(pm_int,0),
                'SMALLINT'         = isnull(pm_smallint,0),
                'TINYINT'          = isnull(pm_tinyint,0),
                'FLOAT'            = isnull(pm_float,0.0),
                'REAL'             = isnull(pm_real,0.0),
                'MONEY'            = isnull(pm_money,0.0),
                'SMALLMONEY'       = isnull(pm_smallmoney,0.0),
                'DATETIME'         = isnull(pm_datetime,"01/01/1990"),
                'SMALLDATETIME'    = isnull(pm_smalldatetime,"01/01/1990")
          from  lo_parametro 
	 where	pm_nomparam like @i_valor
         order  by pm_nomparam, pm_proc
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'COD. PROC.'       = pm_proc,
		'USUARIO'          = substring(pm_login,1,10),
		'PARAMETRO' 	   = substring(pm_nomparam,1,15),
		'SECUENCIAL'       = pm_sec, 
		'I / O'  	   = pm_io,
		'LARGO'            = pm_largo,
		'TIPO DATO'        = pm_tipodato,
		'CHAR'             = substring(pm_char,1,15),
		'VARCHAR'          = substring(pm_varchar,1,15),
                'INT'              = isnull(pm_int,0),
                'SMALLINT'         = isnull(pm_smallint,0),
                'TINYINT'          = isnull(pm_tinyint,0),
                'FLOAT'            = isnull(pm_float,0.0),
                'REAL'             = isnull(pm_real,0.0),
                'MONEY'            = isnull(pm_money,0.0),
                'SMALLMONEY'       = isnull(pm_smallmoney,0.0),
                'DATETIME'         = isnull(pm_datetime,"01/01/1990"),
                'SMALLDATETIME'    = isnull(pm_smalldatetime,"01/01/1990")
          from  lo_parametro 
         where  pm_nomparam like @i_valor
	   and  (pm_nomparam > @i_nombre or 
		 (pm_nomparam = @i_nombre and pm_proc > @i_codigo) )
         order  by pm_nomparam, pm_proc
        set rowcount 0
     end
  end

  /* Busqueda de mensajes de un procedimiento por : */

  /* Busqueda por codigo del procedimiento */
  if @i_tipo = '8'
  begin
     if @i_modo = 0
     begin
        select	'COD. PROC.'       = me_proc,
		'USUARIO'          = substring(me_login,1,10),
		'NUMERO'     	   = me_numero, 
		'SEVERIDAD'	   = me_severidad,
		'TIPO' 		   = me_tipo,
		'MENSAJE'          = me_mensaje
          from  lo_mensaje 
	 where	convert(varchar,me_proc) like @i_valor
         order  by me_proc, me_login
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'COD. PROC.'       = me_proc,
		'USUARIO'          = substring(me_login,1,10),
		'NUMERO'     	   = me_numero, 
		'SEVERIDAD'	   = me_severidad,
		'TIPO' 		   = me_tipo,
		'MENSAJE'          = me_mensaje
          from  lo_mensaje 
         where  me_proc > @i_codigo 
	   and 	convert(varchar,me_proc) like @i_valor
         order  by me_proc, me_login
        set rowcount 0
     end
  end
  
  /* Busqueda por usuario del procedimiento */
  if @i_tipo = '9'
  begin
     if @i_modo = 0
     begin
        select	'COD. PROC.'       = me_proc,
		'USUARIO'          = substring(me_login,1,10),
		'NUMERO'     	   = me_numero, 
		'SEVERIDAD'	   = me_severidad,
		'TIPO' 		   = me_tipo,
		'MENSAJE'          = me_mensaje
          from  lo_mensaje 
	 where	me_login like @i_valor
         order  by me_login, me_proc
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'COD. PROC.'       = me_proc,
		'USUARIO'          = substring(me_login,1,10),
		'NUMERO'     	   = me_numero, 
		'SEVERIDAD'	   = me_severidad,
		'TIPO' 		   = me_tipo,
		'MENSAJE'          = me_mensaje
          from  lo_mensaje 
         where  me_login like @i_valor
	   and  (me_login > @i_nombre or 
		 (me_login = @i_nombre and me_proc > @i_codigo) )
         order  by me_login, me_proc
        set rowcount 0
     end
  end
  

  /* Busqueda de alias de un procedimiento por : */

  /* Busqueda por nombre del procedimiento */
  if @i_tipo = '10'
  begin
     if @i_modo = 0
     begin
        select	'TIPO'     = al_tipo,
		'NOMBRE'   = substring(al_nombre,1,26),
		'NEMONICO' = substring(al_nemonico,1,30)
          from  lo_alias 
	 where	al_nombre like @i_valor
         order  by al_nombre
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'TIPO'     = al_tipo,
		'NOMBRE'   = substring(al_nombre,1,26),
		'NEMONICO' = substring(al_nemonico,1,30)
          from  lo_alias 
	 where  al_nombre > @i_nombre 
           and  al_nombre like @i_valor
         order  by al_nombre 
        set rowcount 0
     end
  end
  
  /* Busqueda por nemonico del procedimiento */
  if @i_tipo = '11'
  begin
     if @i_modo = 0
     begin
        select	'TIPO'     = al_tipo,
		'NOMBRE'   = substring(al_nombre,1,26),
		'NEMONICO' = substring(al_nemonico,1,30)
          from  lo_alias 
	 where	al_nemonico like @i_valor
         order  by al_nemonico
        set rowcount 0
     end

     if @i_modo = 1
     begin
        select	'TIPO'     = al_tipo,
		'NOMBRE'   = substring(al_nombre,1,26),
		'NEMONICO' = substring(al_nemonico,1,30)
          from  lo_alias 
	 where  al_nemonico > @i_nombre 
           and  al_nemonico like @i_valor
         order  by al_nemonico
        set rowcount 0
     end
  end

end

/* ** Actualizacion de las tablas de Logger ** */
If @i_operacion = 'U'
begin
  /* Actualizacion de lo_procedure */
  if @i_tipo = '1'
  begin
 	/* chequeo de claves primarias y datos no NULL */
	if (@i_codigo = 0 OR @i_login is NULL OR @i_base is NULL
	    OR @i_nombre is NULL OR @i_fecha is NULL OR @i_po_modo is NULL)
	 begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select po_nom_proc
	     from lo_procedure
	    where po_proc  = @i_codigo
	      and po_login = @i_login)
	begin
	  /* No existe Procedimiento Logger */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151082
	  return 1
	end

	  Update cobis..lo_procedure
	     set po_server   = @i_server,
		 po_base     = @i_base,
		 po_nom_proc = @i_nombre,
		 po_fecha    = @i_fecha,
		 po_modo     = @i_po_modo,
		 po_estado   = @i_estado,
		 po_return   = @i_return,
		 po_ssn      = @i_ssn,
		 po_ssn_corr = @i_ssn_corr
	   where po_proc  = @i_codigo
	     and po_login = @i_login
	if @@error != 0
	begin
	  /* Error en la actualizacion de la tabla lo_procedure */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 155033
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end

  /* Actualizacion de lo_parametro */
  if @i_tipo = '2'
  begin
 	/* chequeo de claves primarias y datos no NULL */
	if (@i_codigo = 0 OR @i_login is NULL OR @i_nombre is NULL
	    OR @i_sec = 0 OR @i_io is NULL OR @i_tipodato = 0 OR @i_largo = 0)
	 begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select pm_nomparam
	     from lo_parametro
	    where pm_proc  = @i_codigo 
  	      and pm_nomparam = @i_nombre )	
	begin
	  /* No existe Procedimiento Logger */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151082
	  return 1
	end

	  Update cobis..lo_parametro
	     set pm_login    	  = @i_login,
		 pm_nomparam	  = @i_nombre,
		 pm_sec      	  = @i_sec,
		 pm_io	     	  = @i_io,
		 pm_tipodato 	  = @i_tipodato,
		 pm_largo    	  = @i_largo,
		 pm_char     	  = @i_char,
		 pm_varchar  	  = @i_varchar,
		 pm_int	     	  = @i_int,
		 pm_smallint 	  = @i_smallint,
		 pm_tinyint  	  = @i_tinyint,
		 pm_float    	  = @i_float,
		 pm_real     	  = @i_real,
		 pm_money    	  = @i_money,
		 pm_smallmoney 	  = @i_smallmoney,
		 pm_datetime   	  = @i_datetime,
		 pm_smalldatetime = @i_smalldatetime
	   where pm_proc  = @i_codigo
	     and pm_nomparam = @i_nombre
	if @@error != 0
	begin
	  /* Error en la actualizacion de la tabla lo_parametro */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 155034
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end

  /* Actualizacion de lo_mensaje */
  if @i_tipo = '3'
  begin
 	/* chequeo de claves primarias y datos no NULL */
	if (@i_codigo = 0 OR @i_login is NULL OR @i_numero = 0
	    OR @i_severidad = 0 OR @i_me_tipo is NULL) 
	begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select me_login
	     from lo_mensaje
	    where me_proc  = @i_codigo
	      and me_numero = @i_numero)
	begin
	  /* No existe Procedimiento Logger */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151082
	  return 1
	end

	  Update cobis..lo_mensaje
	     set me_login     = @i_login,
		 me_numero    = @i_numero,
		 me_severidad = @i_severidad,
	 	 me_tipo      = @i_me_tipo,
		 me_mensaje   = @i_mensaje 
	   where me_proc   = @i_codigo
	     and me_numero = @i_numero
	if @@error != 0
	begin
	  /* Error en la actualizacion de la tabla lo_mensaje */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 155035
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end

  /* Actualizacion de lo_alias */
  if @i_tipo = '4'
  begin
 	/* chequeo de claves primarias y datos no NULL */
	if (@i_codigo = 0 OR @i_nombre is NULL OR @i_varchar is NULL)
	begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select al_nemonico 
	     from lo_alias 
	    where al_nombre = @i_nombre ) 
	begin
	  /* No existe Alias */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151083
	  return 1
	end

	  Update cobis..lo_alias
	     set al_tipo     = @i_codigo,
		 al_nemonico = @i_varchar 
	   where al_nombre   = @i_nombre
	if @@error != 0
	begin
	  /* Error en la actualizacion de la tabla lo_alias */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 155036
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end
end

/* ** Eliminacion de registros de las tablas de Logger ** */
If @i_operacion = 'D'
begin
  /* Eliminacion de registros de la tabla lo_procedure */
  if @i_tipo = '1'
  begin
 	/* chequeo de claves primarias */
	if (@i_codigo = 0 OR @i_login is NULL) 
	 begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select po_nom_proc
	     from lo_procedure
	    where po_proc  = @i_codigo
	      and po_login = @i_login)
	begin
	  /* No existe Procedimiento Logger */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151082
	  return 1
	end

	  delete cobis..lo_procedure
	   where po_proc  = @i_codigo
	     and po_login = @i_login
	if @@error != 0
	begin
	  /* Error en la eliminacion de registros de la tabla lo_procedure */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 157059
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end

  /* Eliminacion de registros de la tabla lo_parametro */
  if @i_tipo = '2'
  begin
 	/* chequeo de claves primarias */
	if (@i_codigo = 0 OR @i_nombre is NULL)
	 begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select pm_nomparam
	     from lo_parametro
	    where pm_proc  = @i_codigo 
  	      and pm_nomparam = @i_nombre )	
	begin
	  /* No existe Procedimiento Logger */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151082
	  return 1
	end

	  delete cobis..lo_parametro
	   where pm_proc  = @i_codigo
	     and pm_nomparam = @i_nombre
	if @@error != 0
	begin
	  /* Error en la eliminacion de registros de la tabla lo_parametro */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 157060
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end

  /* Eliminacion de registros de la tabla lo_mensaje */
  if @i_tipo = '3'
  begin
 	/* chequeo de claves primarias */
	if (@i_codigo = 0 OR @i_numero = 0)
	begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select me_login
	     from lo_mensaje
	    where me_proc  = @i_codigo
	      and me_numero = @i_numero)
	begin
	  /* No existe Procedimiento Logger */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151082
	  return 1
	end

	delete cobis..lo_mensaje
	 where me_proc   = @i_codigo
	   and me_numero = @i_numero
	if @@error != 0
	begin
	  /* Error en la eliminacion de registros de la tabla lo_mensaje */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 157061
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end

  /* Eliminacion de registros de la tabla lo_alias */
  if @i_tipo = '4'
  begin
 	/* chequeo de claves primarias y datos no NULL */
	if (@i_nombre is NULL)
	begin
	  /* 'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151001
	  return 1
	end 
	if not exists (
	   select al_nemonico 
	     from lo_alias 
	    where al_nombre = @i_nombre ) 
	begin
	  /* No existe Alias */ 
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 151083
	  return 1
	end

	delete cobis..lo_alias
	 where al_nombre   = @i_nombre
	if @@error != 0
	begin
	  /* Error en la eliminacion de registros de la tabla lo_alias */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from 	= @w_sp_name,
		@i_num		= 157062
	  return 1
	end
	select @o_retorna = 1 
    return 0
  end
end

go

