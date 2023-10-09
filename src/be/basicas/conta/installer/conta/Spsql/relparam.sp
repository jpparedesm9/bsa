/************************************************************************/
/*      Archivo:                relparam.sp                             */
/*      Stored procedure:       sp_relparam                             */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           M.Suarez                                */
/*      Fecha de escritura:     24-julio-1995                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*         Mantenimiento a la tabla de relaccion enter parametros       */
/*	   y su equivalente string contable.				*/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      25/Jul/1995     M.Suarez        Emision Inicial                 */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relparam')
	drop proc sp_relparam  

go
create proc sp_relparam   (
   @s_ssn          int         = null,
   @s_date         datetime    = null,
   @s_user         login       = null,
   @s_term         descripcion = null,
   @s_corr         char(1)     = null,
   @s_ssn_corr     int         = null,
   @s_ofi          smallint    = null,
   @t_rty          char(1)     = null,
   @t_trn          smallint    = 602,
   @t_debug        char(1)     = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   @i_operacion    char(1)     = null,
   @i_modo         smallint    = null,
   @i_empresa      tinyint     = null,
   @i_parametro    varchar(10) = null,
   @i_clave        varchar(20) = null,
   @i_substring    varchar(20) = null,
   @i_error        smallint    = null,
   @i_producto     tinyint     = null,
   @i_tipo_area    varchar(10) = null,
   @i_origen_dest  char(1)     = null
)
as 
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_existe       int,            /* codigo existe = 1 
					       no existe = 0 */
	@w_parametro    varchar(10),
	@w_clave        varchar(20),
	@w_substring    varchar(04),
        @w_producto     tinyint,
        @w_tipo_area    varchar(10),
        @w_origen_dest  char(1)

select @w_today = getdate()
select @w_sp_name = 'sp_relparam'


/************************************************/
/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6931 and @i_operacion = 'I') or
   (@t_trn <> 6932 and @i_operacion = 'U') or
   (@t_trn <> 6933 and @i_operacion = 'D') or
   (@t_trn <> 6934 and @i_operacion = 'Q') or
   (@t_trn <> 6935 and @i_operacion = 'S')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_parametro     = @i_parametro,
		i_clave         = @i_clave,
		i_substring     = @i_substring,
                i_producto      = @i_producto,
                i_tipo_area     = @i_tipo_area,
                i_origen_dest   = @i_origen_dest

	exec cobis..sp_end_debug
end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if      @i_empresa is NULL or 
		@i_clave is NULL or
		@i_substring is NULL or
		@i_parametro is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601001
		return 1
	end
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
begin
	select  
	@w_parametro = re_parametro,
	@w_clave = re_clave,
	@w_substring = re_substring,
    @w_producto = re_producto,
    @w_tipo_area = re_tipo_area,
    @w_origen_dest = re_origen_dest
	from cb_relparam
	where re_empresa   = @i_empresa 
    and   re_parametro = @i_parametro
    and   re_clave     = @i_clave
	if @@rowcount <> 0
		select @w_existe = 1
	else
		select @w_existe = 0
end

/* Insercion */
/*************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1 
   begin
      /* 'Codigo ya existe   ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601160
      return 1
   end

   /* Insercion del registro */
   /**************************/
   begin tran
   insert into cb_relparam
          (re_empresa,re_parametro,re_clave,re_substring,re_producto,re_tipo_area,re_origen_dest)
   values (@i_empresa,@i_parametro,@i_clave,@i_substring,@i_producto,@i_tipo_area,@i_origen_dest)
                    
   if @@error <> 0 
   begin
      /* 'Error en insercion de registro ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601161
      return 1
   end

   /****************************************/
   /* TRANSACCION DE SERVICIO		*/

   insert into ts_relparam
   values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
           @i_empresa,@i_parametro,@i_clave,@i_substring)

   if @@error <> 0
   begin
      /* 'Error en insercion de transaccion de servicio' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num	  = 603032
      return 1
   end
   commit tran
   return 0
end

/* Actualizacion de nivel_cuenta  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cb_relparam
		set  re_substring = @i_substring,
        re_producto  = @i_producto,
        re_tipo_area = @i_tipo_area,
        re_origen_dest = @i_origen_dest
		where   re_empresa = @i_empresa and
			  re_parametro = @i_parametro and
              re_clave     = @i_clave

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Registro '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601162
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_relparam
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_parametro,@i_clave,@i_substring)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
	commit tran
	return 0
end

/* Eliminacion */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'registro a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end

	begin tran

		delete cb_relparam
		where   re_empresa = @i_empresa and
			re_parametro = @i_parametro and
                        re_clave     = @i_clave

		if @@error <> 0
		begin
			/* 'Error en update de Registro '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601164
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_relparam
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_parametro,@i_clave,@i_substring)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end

	commit tran
	return 0
end


/**** query ****/
/****************/

if @i_operacion = 'Q'
begin
if @w_existe = 1
	select @w_substring
else
begin
	/* 'Registro no existe  '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601159
	return 1
end
return 0
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 begin
      select 	
      'PARAMETRO' = re_parametro,
      'CODIGO'   = re_clave,
      'SUBSTRING' = re_substring,
      'PRODUCTO'  = re_producto,
      'DESCRIPCION' = pd_descripcion,
      'TIPO.AREA' = re_tipo_area,
      'NOMBRE'= ta_descripcion,
      -- 'VALOR' = re_utiliza_valor,
      -- 'AREA' = re_area,
      -- 'NOM/AREA' = ar_descripcion,
      'ORIGEN/DEST/C' = re_origen_dest
      from cb_relparam
      left outer join cobis..cl_producto on
           re_producto = pd_producto
           left outer join cb_tipo_area on
               re_producto = ta_producto
               and re_tipo_area = ta_tiparea
               and re_empresa   = @i_empresa
               and ta_empresa   = @i_empresa
      where  (re_parametro = @i_parametro or @i_parametro is null)
      order by re_parametro,re_clave                

      if @@rowcount = 0
      begin
         if @i_error <> 1
         begin
            /* 'No existen registros '*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file	 = @t_file,
            @t_from	 = @w_sp_name,
            @i_num	 = 601153
         end
         set rowcount 0
         return 1
      end
      set rowcount 0
      return 0
   end
   if @i_modo = 1
   begin
      select 
      'PARAMETRO' = re_parametro,
      'CODIGO '   = re_clave,
      'SUBSTRING' = re_substring,
      'PRODUCTO'  = re_producto,
      'DESCRIPCION' = pd_descripcion,
      'TIPO.AREA' = re_tipo_area,
      'NOMBRE'= ta_descripcion,
      --'VALOR' = re_utiliza_valor,
      --'AREA' = re_area,
      --'NOM/AREA' = ar_descripcion,
      'ORIGEN/DEST/C' = re_origen_dest
      from cb_relparam
      left outer join cobis..cl_producto on
           re_producto = pd_producto
           left outer join cb_tipo_area on
               re_producto = ta_producto and
               re_tipo_area = ta_tiparea
      where  re_empresa = @i_empresa
      and (re_parametro = @i_parametro or @i_parametro is null)
      and ((re_parametro = @i_parametro and re_clave > @i_clave)
       or  (re_parametro > @i_parametro))
      and  ta_empresa = @i_empresa
      order by re_parametro,re_clave                  

      if @@rowcount = 0 begin
         if @i_error <> 1 begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
         end
         set rowcount 0
		 return 1
      end
      set rowcount 0
      return 0
   end
end
go
