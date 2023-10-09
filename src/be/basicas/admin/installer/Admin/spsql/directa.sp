/************************************************************************/
/*	Archivo:		directa.sp				*/
/*	Stored procedure:	sp_directa				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 9-Dic-1992					*/
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
/*	Insercion de ruta directa					*/
/*	Actualizacion de ruta directa					*/
/*	Borrado de ruta directa						*/
/*	Busqueda de ruta directa					*/
/*	Query de ruta directa						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	9/Dic/1992	L. Carvajal	Emision inicial			*/
/*	7/Jun/1993	M. Davila	Search sin mensaje de erro      */
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_directa')
   drop proc sp_directa



go
create proc sp_directa (
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
	@i_operacion		char(1),
	@i_modo 		smallint = null,
	@i_filial_d		tinyint = null,
	@i_oficina_d		smallint = null,
	@i_nodo_d		tinyint = null,
	@i_filial_h		tinyint = null,
	@i_oficina_h		smallint = null,
	@i_nodo_h		tinyint = null,
	@i_protocolo		char(1) = NULL,
	@i_tlink		char(1) = NULL,
	@i_link			tinyint = NULL,
	@i_secuencial		tinyint = NULL,
	@i_prioridad		char(1) = NULL,
	@i_half_full		char(1) = 'H'
)
as
declare
	@w_sp_name		varchar(32),
	@w_today		datetime,
	@w_nombre_f_d		descripcion,
	@w_nombre_o_d		descripcion,
	@w_nombre_n_d		descripcion,
	@w_nombre_f_h		descripcion,
	@w_nombre_o_h		descripcion,
	@w_nombre_n_h		descripcion,
	@w_protocolo		char(1),
	@w_tlink		char(1),
	@w_link			tinyint,
	@w_secuencial		tinyint,
	@w_prioridad		char(1),
	@v_protocolo		char(1),
	@v_tlink		char(1),
	@v_link			tinyint,
	@v_secuencial		tinyint,
	@v_prioridad		char(1),
	@o_siguiente		int,
	@o_nombre_f_d		descripcion,
	@o_nombre_o_d		descripcion,
	@o_nombre_n_d		descripcion,
	@o_nombre_f_h		descripcion,
	@o_nombre_o_h		descripcion,
	@o_nombre_n_h		descripcion,
	@o_protocolo		char(1),
	@o_tlink		char(1),
	@o_link			tinyint,
	@o_secuencial		tinyint,
	@o_prioridad		char(1),
	@v_fecha_ult_mod	datetime,
	@w_fecha_ult_mod	datetime,
	@o_nombre_pr		descripcion,
	@o_nombre_tl		descripcion,
	@w_return		int

select @w_today = @s_date
select @w_sp_name = 'sp_directa'

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 543
begin
 /* chequeo de claves foraneas */
  /*if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
      OR @i_prioridad is NULL)
*/
  if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
      )
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

  if not exists (
	select nl_filial
	  from ad_nodo_oficina
	 where nl_oficina = @i_oficina_d
	   and nl_filial = @i_filial_d
	   and nl_nodo = @i_nodo_d
	   and nl_fecha_habil is not NULL
	   and nl_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	   /*  'No existe nodo oficina habilitado' */
	return 1
  end

  select @w_nombre_f_d = fi_nombre
    from cl_filial
   where fi_filial = @i_filial_d
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	   /*  'No existe filial' */
	return 1
  end

  select @w_nombre_o_d = of_nombre
    from cl_oficina
   where of_oficina = @i_oficina_d
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101016
	   /*  'No existe oficina' */
	return 1
  end

  select @w_nombre_n_d = nl_nombre
    from ad_nodo_oficina
   where nl_nodo = @i_nodo_d
     and nl_filial = @i_filial_d
     and nl_oficina = @i_oficina_d
     and nl_fecha_habil is not NULL
     and nl_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	   /*  'No existe nodo' */
	return 1
  end

  if not exists (
	select nl_filial
	  from ad_nodo_oficina
	 where nl_oficina = @i_oficina_h
	   and nl_filial = @i_filial_h
	   and nl_nodo = @i_nodo_h
	   and nl_fecha_habil is not NULL
	   and nl_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	   /*  'No existe nodo oficina habilitado' */
	return 1
  end

  select @w_nombre_f_h = fi_nombre
    from cl_filial
   where fi_filial = @i_filial_h
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	   /*  'No existe filial'*/
	return 1
  end

  select @w_nombre_o_h = of_nombre
    from cl_oficina
   where of_oficina = @i_oficina_h
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101016
	   /*  'No existe oficina' */
	return 1
  end

  select @w_nombre_n_h = nl_nombre
    from ad_nodo_oficina
   where nl_nodo = @i_nodo_h
     and nl_filial = @i_filial_h
     and nl_oficina = @i_oficina_h
     and nl_fecha_habil is not NULL
     and nl_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	   /*  'No existe nodo'  */
	return 1
  end

  if (@i_secuencial IS NOT NULL OR @i_tlink IS NOT NULL OR
	@i_link IS NOT NULL OR @i_protocolo IS NOT NULL)
  begin 
   if not exists (
	select xc_protocolo
	  from ad_x25_config
	 where xc_secuencial = @i_secuencial
	   and xc_tlink = @i_tlink
	   and xc_link = @i_link
	   and xc_protocolo = @i_protocolo
	   and xc_oficina = @i_oficina_d
	   and xc_filial = @i_filial_d
	   and xc_nodo = @i_nodo_d
	   and xc_estado = 'V')
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
	   /*  'No existe aplicacion' */
	return 1
   end
  end

   if exists ( select di_filial_d  from  ad_directa       
	        where di_filial_d  = @i_filial_d  
                  and di_oficina_d = @i_oficina_d and di_nodo_d    = @i_nodo_d
		  and di_filial_h  = @i_filial_h and di_oficina_h = @i_oficina_h
		  and di_nodo_h    = @i_nodo_h
		  and di_subtipo   = 'D' )                       
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151068
	   /*  'Ya existe ruta directa definida ' */
	return 1
   end

  begin tran
     insert into ad_directa    (di_filial_d, di_oficina_d, di_nodo_d,
				di_filial_h, di_oficina_h, di_nodo_h,
				di_tlink, di_link, di_protocolo,
				di_secuencial, di_subtipo, 
				di_prioridad, di_nombre_f_d, di_nombre_o_d,
				di_nombre_n_d, di_nombre_f_h, di_nombre_o_h,
				di_nombre_n_h, di_estado, di_fecha_ult_mod)
  	                values (@i_filial_d, @i_oficina_d, @i_nodo_d,
				@i_filial_h, @i_oficina_h, @i_nodo_h,
				@i_tlink, @i_link, @i_protocolo,
				@i_secuencial, 'D', @i_prioridad, @w_nombre_f_d,
				@w_nombre_o_d, @w_nombre_n_d, @w_nombre_f_h,
				@w_nombre_o_h, @w_nombre_n_h, 'V', @w_today)
     if @@error != 0
     begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153019
	   /*  'Error en insercion de ruta directa' */
	return 1
     end

     if @i_half_full = 'F'
     begin
     insert into ad_directa    (di_filial_d, di_oficina_d, di_nodo_d,
				di_filial_h, di_oficina_h, di_nodo_h,
				di_tlink, di_link, di_protocolo,
				di_secuencial, di_subtipo, 
				di_prioridad, di_nombre_f_d, di_nombre_o_d,
				di_nombre_n_d, di_nombre_f_h, di_nombre_o_h,
				di_nombre_n_h, di_estado, di_fecha_ult_mod)
  	                values (@i_filial_h, @i_oficina_h, @i_nodo_h,
				@i_filial_d, @i_oficina_d, @i_nodo_d,
				@i_tlink, @i_link, @i_protocolo,
				@i_secuencial, 'D', @i_prioridad, @w_nombre_f_h,
				@w_nombre_o_h, @w_nombre_n_h, @w_nombre_f_d,
				@w_nombre_o_d, @w_nombre_n_d, 'V', @w_today)
     if @@error != 0
     begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153019
	   /*  'Error en insercion de ruta directa' */
	return 1
     end
     end

   /* transaccion de servicio */
   insert into ts_directa (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   filial_d, oficina_d, nodo_d, filial_h, oficina_h,
			   nodo_h, tlink, link, protocolo, secuencial,
			   prioridad, nombre_f_d, nombre_o_d,
			   nombre_n_d, nombre_f_h, nombre_o_h, nombre_n_h,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 543, 'N', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			   @i_filial_d, @i_oficina_d, @i_nodo_d,
			   @i_filial_h, @i_oficina_h, @i_nodo_h,
			   @i_tlink, @i_link, @i_protocolo,
			   @i_secuencial, @i_prioridad, @w_nombre_f_d,
			   @w_nombre_o_d, @w_nombre_n_d, @w_nombre_f_h,
			   @w_nombre_o_h, @w_nombre_n_h, 'V', @w_today)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
        return 1
   end

   if @i_half_full = 'F'
   begin
   insert into ts_directa (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   filial_d, oficina_d, nodo_d, filial_h, oficina_h,
			   nodo_h, tlink, link, protocolo, secuencial,
			   prioridad, nombre_f_d, nombre_o_d,
			   nombre_n_d, nombre_f_h, nombre_o_h, nombre_n_h,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 543, 'N', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
  	               	   @i_filial_h, @i_oficina_h, @i_nodo_h,
			   @i_filial_d, @i_oficina_d, @i_nodo_d,
			   @i_tlink, @i_link, @i_protocolo,
			   @i_secuencial, @i_prioridad, @w_nombre_f_h,
		           @w_nombre_o_h, @w_nombre_n_h, @w_nombre_f_d,
			   @w_nombre_o_d, @w_nombre_n_d, 'V', @w_today)
     if @@error != 0
     begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153019
	   /*  'Error en insercion de ruta directa' */
	return 1
     end
   end
  commit tran
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


/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 1594
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Filial D' = di_filial_d,
		'Filial D' = substring(di_nombre_f_d, 1, 20),
		'Cod. Oficina D' = di_oficina_d,
		'Oficina D' = substring(di_nombre_o_d, 1, 20),
		'Cod. Nodo D' = di_nodo_d,
		'Nodo D' = substring(di_nombre_n_d,1,20),
		'Cod. Filial F' = di_filial_h,
		'Filial F' = substring(di_nombre_f_h, 1, 20),
		'Cod. Oficina F' = di_oficina_h,
		'Oficina F' = substring(di_nombre_o_h, 1, 20),
		'Cod. Nodo F' = di_nodo_h,
		'Nodo F' = substring(di_nombre_n_h,1,20),
		'Protocolo' = di_protocolo,
		'Tipo de link' = di_tlink,
		'No. Link' = di_link,
		'Secuencial' = di_secuencial,
		'Prioridad' = di_prioridad
	 from	ad_directa
	where	di_estado = 'V'
	order	by di_filial_d, di_oficina_d, di_nodo_d,
		di_filial_h, di_oficina_h, di_nodo_h, di_protocolo, di_tlink,
		di_link, di_secuencial, di_prioridad
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
       select	'Cod. Filial D' = di_filial_d,
		'Filial D' = substring(di_nombre_f_d, 1, 20),
		'Cod. Oficina D' = di_oficina_d,
		'Oficina D' = substring(di_nombre_o_d, 1, 20),
		'Cod. Nodo D' = di_nodo_d,
		'Nodo D' = substring(di_nombre_n_d,1,20),
		'Cod. Filial F' = di_filial_h,
		'Filial H' = substring(di_nombre_f_h, 1, 20),
		'Cod. Oficina F' = di_oficina_h,
		'Oficina F' = substring(di_nombre_o_h, 1, 20),
		'Cod. Nodo F' = di_nodo_h,
		'Nodo F' = substring(di_nombre_n_h,1,20),
		'Protocolo' = di_protocolo,
		'Tipo de link' = di_tlink,
		'No. Link' = di_link,
		'Secuencial' = di_secuencial,
		'Prioridad' = di_prioridad
	 from	ad_directa
	where	di_estado = 'V'
          and  ( 
		(di_filial_d > @i_filial_d)
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d > @i_oficina_d))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d > @i_nodo_d))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h > @i_filial_h))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h > @i_oficina_h))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h = @i_oficina_h) and (di_nodo_h >
		@i_nodo_h))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h = @i_oficina_h) and (di_nodo_h =
		@i_nodo_h) and (di_protocolo > @i_protocolo))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h = @i_oficina_h) and (di_nodo_h =
		@i_nodo_h) and (di_protocolo = @i_protocolo) and (di_tlink
		> @i_tlink))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h = @i_oficina_h) and (di_nodo_h =
		@i_nodo_h) and (di_protocolo = @i_protocolo) and (di_tlink
		= @i_tlink) and (di_link > @i_link))
	  or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h = @i_oficina_h) and (di_nodo_h =
		@i_nodo_h) and (di_protocolo = @i_protocolo) and (di_tlink
		= @i_tlink) and (di_link = @i_link) and (di_secuencial >
		@i_secuencial))
	 or	((di_filial_d = @i_filial_d) and (di_oficina_d = @i_oficina_d)
		and (di_nodo_d = @i_nodo_d) and (di_filial_h = @i_filial_h)
		and (di_oficina_h = @i_oficina_h) and (di_nodo_h =
		@i_nodo_h) and (di_protocolo = @i_protocolo) and (di_tlink
		= @i_tlink) and (di_link = @i_link) and (di_secuencial =
		@i_secuencial) and (di_prioridad > @i_prioridad))
	       )
	order	by di_filial_d, di_oficina_d, di_nodo_d,
		di_filial_h, di_oficina_h, di_nodo_h, di_protocolo, di_tlink,
		di_link, di_secuencial, di_prioridad
	set rowcount 0
	return 0
    end
    if @i_modo = 2
    begin
	set rowcount 20
	select 'C.F' = di_filial_h,
	       'Filial' = substring(di_nombre_f_h,1,20),
	       'C.O.' = di_oficina_h,
               'Oficina' = substring(di_nombre_o_h,1,20),
	       'C.N.' = di_nodo_h,
	       'Nodo' = substring(di_nombre_n_h, 1, 20)
	  from  ad_directa
         where di_estado = 'V'
           and di_filial_d = @i_filial_d
           and di_oficina_d = @i_oficina_d
           and di_nodo_d = @i_nodo_d
	order	by di_filial_d, di_oficina_d, di_nodo_d,
		di_filial_h, di_oficina_h, di_nodo_h, di_protocolo, di_tlink,
		di_link, di_secuencial, di_prioridad
       set rowcount 0
       return 0
       end
    if @i_modo = 3 
    begin
	select 'C.F' = di_filial_h,
	       'Filial' = substring(di_nombre_f_h,1,20),
	       'C.O.' = di_oficina_h,
               'Oficina' = substring(di_nombre_o_h,1,20),
	       'C.N.' = di_nodo_h,
	       'Nodo' = substring(di_nombre_n_h, 1, 20)
	  from  ad_directa
         where di_estado = 'V'
           and di_filial_d = @i_filial_d
           and di_oficina_d = @i_oficina_d
           and di_nodo_d = @i_nodo_d
	   and ((di_filial_h > @i_filial_h)
  	    or ((di_filial_h = @i_filial_h) and (di_oficina_h > @i_oficina_h))
   	    or ((di_filial_h = @i_filial_h) and (di_oficina_h = @i_oficina_h)
	  	and (di_nodo_h > @i_nodo_h))
               )
	order	by di_filial_d, di_oficina_d, di_nodo_d,
		di_filial_h, di_oficina_h, di_nodo_h, di_protocolo, di_tlink,
		di_link, di_secuencial, di_prioridad
    set rowcount 0
    return 0
    end
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


/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 1595
begin
	select	@o_nombre_f_d = di_nombre_f_d,
		@o_nombre_o_d = di_nombre_o_d,
		@o_nombre_n_d = di_nombre_n_d,
		@o_nombre_f_h = di_nombre_f_h,
		@o_nombre_o_h = di_nombre_o_h,
		@o_nombre_n_h = di_nombre_n_h,
		@o_protocolo = di_protocolo,
		@o_tlink = di_tlink,
		@o_link = di_link,
		@o_secuencial = di_secuencial,
		@o_prioridad = di_prioridad
	 from	ad_directa
	where	di_estado = 'V'
	  and	di_filial_d = @i_filial_d
	  and	di_oficina_d = @i_oficina_d
	  and	di_nodo_d = @i_nodo_d
	  and	di_filial_h = @i_filial_h
	  and	di_oficina_h = @i_oficina_h
	  and	di_nodo_h = @i_nodo_h
       if @@rowcount = 0
       begin
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151018
	   /*  'No existe ruta directa' */
	 return 1
       end

	if @o_protocolo is not NULL
	begin
       select @o_nombre_pr = pr_descripcion
	 from ad_protocolo
	where pr_protocolo = @o_protocolo
       if @@rowcount = 0
       begin
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
	   /*  'No existe protocolo' */
	 return 1
       end
	end

	if @o_tlink is NOT NULL
	begin	
       select @o_nombre_tl = tl_descripcion
	 from ad_tlink
	where tl_tipo_link = @o_tlink
       if @@rowcount = 0
       begin
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151009
	   /*  'No existe tipo de link' */
	 return 1
       end
	end

       select @i_filial_d, @o_nombre_f_d, @i_oficina_d, @o_nombre_o_d,
	      @i_nodo_d, @o_nombre_n_d, @i_filial_h, @o_nombre_f_h,
	      @i_oficina_h, @o_nombre_o_h, @i_nodo_h, @o_nombre_n_h,
	      @o_protocolo, @o_nombre_pr, @o_tlink, @o_nombre_tl,
	      @o_link, @o_secuencial, @o_prioridad
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

if @i_operacion = 'U' OR @i_operacion = 'D'
begin
	exec @w_return = sp_directa2 
		@s_ssn		= @s_ssn,		
		@s_user		= @s_user,	
		@s_sesn		= @s_sesn,
		@s_term		= @s_term,	
		@s_date	 	= @s_date,
		@s_srv		= @s_srv,
		@s_lsrv		= @s_lsrv,	
		@s_rol		= @s_rol,
		@s_ofi		= @s_ofi,	
		@s_org_err	= @s_org_err,
		@s_error	= @s_error,
		@s_sev		= @s_sev,
		@s_msg		= @s_msg,
		@s_org		= @s_org,
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@t_trn		= @t_trn, 	
		@i_operacion		   = @i_operacion,
		@i_modo			   = @i_modo,
		@i_filial_d		   = @i_filial_d,
		@i_oficina_d		   = @i_oficina_d,
		@i_nodo_d		   = @i_nodo_d,
		@i_filial_h		   = @i_filial_h,
		@i_oficina_h		   = @i_oficina_h,
		@i_nodo_h		   = @i_nodo_h,
		@i_protocolo		   = @i_protocolo,
		@i_tlink 		   = @i_tlink,
		@i_link			   = @i_link,
		@i_secuencial		   = @i_secuencial,
		@i_prioridad		   = @i_prioridad,
		@i_half_full		   = @i_half_full
	if @w_return != 0
		return @w_return
end

/* Search para administrador de Red */

if @i_operacion = 'R'
begin
	select x.nl_nombre, y.nl_nombre
	  from ad_directa, ad_nodo_oficina x, ad_nodo_oficina y
	 where x.nl_filial = di_filial_d
	   and x.nl_oficina = di_oficina_d
	   and x.nl_nodo = di_nodo_d
	   and y.nl_filial = di_filial_h
	   and y.nl_oficina = di_oficina_h
	   and y.nl_nodo = di_nodo_h
	return 0
end
go

