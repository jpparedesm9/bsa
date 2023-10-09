/************************************************************************/
/*      Archivo:                funcio.sp                               */
/*      Stored procedure:       sp_funcionario                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Admin                                   */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 15-Nov-1992                                 */
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
/*      Este programa procesa las transacciones del stored procedure    */
/*      Insercion de funcionario                                        */
/*      Actualizacion de funcionario                                    */
/*      Borrado de funcionario                                          */
/*                                                                      */
/*      Adicionalmente llama al stored procedure sp_cons_funcionario    */
/*      para las operaciones:                                           */
/*      Busqueda de funcionario                                         */
/*      Query de funcionario                                            */
/*      Help de funcionario                                             */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      15/Nov/92       S. Ortiz        Emision Inicial                 */
/*      14/Ene/93       L. Carvajal     Tabla de errores, variables     */
/*                                      de debug                        */
/*      10/Nov/93       P/ Mena         Help del funcionario cuyo rol   */
/*                                      sea oficial de cuenta y de      */
/*                                      credito.                        */
/*      09/Mar/94       F. Espinosa     Anular el envio del parametro   */ 
/*                                      i_dinero                        */
/*      11/Abr/94       F. Espinosa     Incluir campo nomina en las ope_*/
/*                                      operaciones con la tabla        */
/*                                      cl_funcionario                  */
/*      12/Abr/94       F. Espinosa     Division del stored procedure   */
/*                                      en dos partes por exeso en el   */
/*                                      tamanio del query               */
/*      25/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      08/Sep/94       C.Rodriguez     Considerar la oficina           */
/*	16/Nov/00	A.Rodríguez	Control de tamaño del Passwd	*/
/*					Control de repet. del Passwd	*/
/*	18/Ene/01	A.Rodríguez	Nuevo esquema encriptacion	*/
/*	24/Abr/01	A.Duque		Cambio de password NCS		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_funcionario')
   drop proc sp_funcionario
go

create proc sp_funcionario (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint =NULL,
	@t_offset		varbinary(32) =NULL,	-- ARO:18/01/2001   CRYPWD
	@t_tampwd		int =NULL,		-- ARO:18/01/2001   CRYPWD
	@i_chpass               char(1) = 'S',		-- ADU:24/04/2001   NCS
	@i_operacion            char(1),
	@i_modo                 tinyint = NULL,
	@i_tipo                 char(1) = NULL,
	@i_funcionario          smallint = NULL,
	@i_nombre               descripcion = NULL,
	@i_login                varchar(30) = NULL,
	@i_clave                varchar(30) = NULL,
	@i_sexo                 sexo = NULL,
	@i_nomina               smallint = NULL,
	@i_dinero               char(1) = 'N',
	@i_departamento         smallint = NULL,
	@i_oficina              smallint = NULL,
	@i_cargo                tinyint = NULL,
	@i_secuencial           tinyint = NULL,
	@i_jefe                 smallint = 0,
	@i_estado               varchar(1) = "V",
	@i_central_transmit     varchar(1) = null,
	@o_siguiente            int = NULL out

)
as
declare
	@w_today        datetime,
	@w_return       int,
	@w_cambio       char(1),
	@w_sp_name      varchar(32),
	@w_codigo       int,
	@w_funcionario  smallint,
	@w_nombre       descripcion,
	@w_login        varchar(30),
	@w_clave        varchar(30),
	@w_offset	varbinary(32),	-- ARO:18/01/2001	CRYPWD
	@w_sexo         sexo,
	@w_dinero       char(1),
	@w_nomina       smallint,
	@w_departamento smallint,
	@w_oficina      smallint,
	@w_cargo        tinyint,
	@ww_departamento smallint,
	@ww_oficina     smallint,
	@ww_cargo       tinyint,
	@w_jefe         smallint,
	@w_numero       tinyint,
	@w_secuencial   tinyint,
	@ww_secuencial   tinyint,
	@w_valor        descripcion,
	@w_nivel        tinyint,
	@v_funcionario  smallint,
	@v_nombre       descripcion,
	@v_sexo         sexo,
	@v_dinero       char(1),
	@v_nomina       smallint,
	@v_departamento smallint,
	@v_oficina      smallint,
	@v_cargo        tinyint,
	@v_clave        varchar(30),
	@v_offset	varbinary(32),	-- ARO:18/01/2001	CRYPWD
	@v_secuencial   tinyint,
	@v_jefe         smallint,
	@v_nivel        tinyint,
	@o_funcionario  smallint,
	@o_nombre       descripcion,
	@o_login        varchar(30),
	@o_sexo         sexo,
	@o_senombre     descripcion,
	@o_dinero       char(1),
	@o_nomina       smallint,
	@o_departamento smallint,
	@o_oficina      smallint,
	@o_denombre     descripcion,
	@o_cargo        tinyint,
	@o_canombre     descripcion,
	@o_secuencial   tinyint,
	@o_jefe         smallint,
	@o_jenombre     descripcion,
	@o_nivel        tinyint,
	@w_cmdtransrv       varchar(60),
	@w_nt_nombre        varchar(40),
	@w_num_nodos        smallint,
	@w_contador         smallint,
	@w_clave_int        int,
	@w_tmp		tinyint,
	@w_tp		tinyint,
        @w_npch			tinyint,
        @w_clave_his		varchar(30),
        @w_offset_his		varbinary(32),	-- ARO:18/01/2001 CRYPWD
        @w_contador_his		int,
        @w_sec_his		int,
	@w_tml		tinyint,
	@w_tl		tinyint


select @w_today = @s_date
select @w_sp_name = 'sp_funcionario'

/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D') and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1)
)
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 598
begin
 /* chequeo de claves foraneas */
 if @i_jefe = 0
  select @w_nivel = 0
 else 
 begin  
  select @w_nivel = isnull(fu_nivel,0)
    from cl_funcionario
    where fu_funcionario = @i_jefe
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101011
	   /*   'Jefe no existe'*/
     return 1
  end
  select @w_nivel = @w_nivel + 1
 end

 if not exists ( 
  select de_departamento
    from cl_departamento
   where de_departamento = @i_departamento
     and de_oficina = @i_oficina )
  begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101010
	 /*     'Departamento no existe'*/
     return 1
  end
  select @w_valor = convert(varchar(10), @i_cargo)
  exec @w_return = sp_catalogo
	@t_debug        = @t_debug,
	@t_file         = @t_file,
	@t_from         = @w_sp_name,
	@i_tabla        = 'cl_cargo',
	@i_operacion    = 'E',
	@i_codigo       =  @w_valor
  if @w_return != 0
  begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101012
	/*      'No existe cargo'*/
    return 1
  end

 if exists(
	   select fu_login
	     from cl_funcionario
	    where fu_login = @i_login)
 begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101062
	  /*   Login ya existe */
   return 1
 end

 select @w_secuencial = ds_secuencial
   from cl_distributivo
  where ds_departamento = @i_departamento
    and ds_oficina = @i_oficina
    and ds_cargo = @i_cargo
    and ds_secuencial = @i_secuencial 
    and ds_vacante = 'S' 
 if @@rowcount = 0
 begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101051
	 /*     'No existe vacante'*/
   return 1
 end

 /*** Chequeo de longitud minima de Login ***/
 /*** ARO: 16 de Noviembre ***/
 
 select @w_tml=isnull(pa_tinyint,0)
 from cl_parametro
 where pa_producto='ADM' and
 pa_nemonico='TML'
 
 if @@rowcount=0
 begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151126
	  /*   No existe Parámetro General  */
   return 1 
 end
 
 select @w_tl= isnull(datalength (@i_login),0)

  if @w_tl < @w_tml
  begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151127

    	print "Longitud  minima del Login es" + convert(varchar(5), @w_tml) + " caracteres"

	  /*   Tamanio de Login Incorrecto */  
   return 1
  end

 /**** FIN ARO ****/

 /*** Chequeo de longitud minima de Password ***/
 /*** ARO: 15 de Noviembre ***/
 
 
 select @w_tmp=isnull(pa_tinyint,0)
 from cl_parametro
 where pa_producto='ADM' and
 pa_nemonico='TMP'
 
 if @@rowcount=0
 begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151122
	  /*   No existe Parámetro General  */
   return 1 
 end

/*** ARO:18/01/2001 CRYPWD ***/ 
-- select @w_tp=isnull(datalength(@i_clave),0)
select @w_tp=isnull(@t_tampwd,0)
/*** FIN ARO CRYPWD ****/


 if @w_tp<@w_tmp 
 begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151123

    	print "Longitud  minima del Password es " + convert(varchar(5),@w_tmp) + " caracteres"


	  /*   Longitud de Password incorrecta */
   return 1 
 end

/**** FIN ARO ****/

 begin tran
 exec sp_cseqnos
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_tabla        = 'cl_funcionario',
		@o_siguiente    = @o_siguiente out

  insert into cl_funcionario  (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,
			       fu_departamento, fu_oficina, fu_cargo, fu_secuencial, 
			       fu_jefe, fu_nivel, fu_fecha_ing, fu_login,
			       fu_nomina, fu_clave, fu_estado,
			       fu_offset)	-- ARO:18/01/2001	CRYPWD
	       values (@o_siguiente, @i_nombre, @i_sexo, @i_dinero,
		       @i_departamento, @i_oficina, @i_cargo, @w_secuencial,
		       @i_jefe, @w_nivel, @w_today, @i_login,
			       @i_nomina, @i_clave, 'V',
			       @t_offset)		-- ARO:18/01/2001	CRYPWD
  if @@error != 0
   begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 103046
      /* 'Error en creacion de funcionario'*/
    return 1
   end
  update cl_distributivo
     set ds_vacante = 'N'
   where ds_departamento = @i_departamento
     and ds_oficina = @i_oficina
     and ds_cargo = @i_cargo
     and ds_secuencial = @i_secuencial 
  /* transaccion de servicio - funcionario */

  insert into ts_funcionario (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s, srv, lsrv,
			      funcionario, nombre, sexo, dinero,
			      departamento, oficina, cargo, secuencia_f, jefe,
			      nivel, nomina, clave,
			      offset)	-- ARO:18/01/2001	CRYPWD
	       values (@s_ssn, 598, 'N', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,       
		       @o_siguiente, @i_nombre, @i_sexo, @i_dinero,
		       @i_departamento, @i_oficina, @i_cargo, @w_secuencial, @i_jefe,
			       @w_nivel, @i_nomina, @i_clave,
			       @t_offset)	-- ARO:18/01/2001	CRYPWD
  if @@error != 0
   begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 103005
	/*      'Error en creacion de transaccion de servicio'*/
    return 1
   end

    /**** ARO: 16 de Noviembre del 2000 ***/
    /*** Control Historico de Passwords (evitar repeticiones) ****/

    select @w_sec_his=isnull(max(ch_secuencial),0)+1
    from cl_clave_his
    where ch_login=@i_login
    
    insert into cl_clave_his (
    	ch_login,
    	ch_secuencial,
    	ch_fecha,
--    	ch_clave)		ARO:18/01/2001  CRYPWD
	ch_offset)
    values (
    	@i_login,
    	@w_sec_his,
    	getdate(),
--    	@i_clave)		ARO:18/01/2001  CRYPWD
	@t_offset)
    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153051
	   /*  'Error en insercion en CL_CLAVE_HIS' */
	return 1
    end

    /***** FIN ARO ******/


 select @o_siguiente
 commit tran

  /* Generacion del comando al transrv */
   select @w_cmdtransrv = @s_lsrv +'...sp_addlogin'
   exec @w_cmdtransrv
	@loginame = @i_login,
	@passwd   = @i_clave

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
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' +
 @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'

		set rowcount 0
		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre

		exec @w_return = @w_cmdtransrv
					@t_trn             = @t_trn,
					@i_operacion       = @i_operacion,
					@i_secuencial      = @i_secuencial,
					@i_funcionario     = @o_siguiente,
					@i_login           = @i_login,
					@i_nombre          = @i_nombre,
					@i_sexo            = @i_sexo,
					@i_dinero          = @i_dinero,
					@i_nomina          = @i_nomina,
					@i_departamento    = @i_departamento,
					@i_oficina         = @i_oficina,
					@i_cargo           = @i_cargo,
					@i_jefe            = @i_jefe,
					@i_estado          = @i_estado,
		    @i_nivel            = @w_nivel,
					@i_central_transmit = 'S',
					@o_clave           = @w_clave_int out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave_int,
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
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end


/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 599
begin
 /* verificacion de claves foraneas */
 if @i_funcionario = @i_jefe
  begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101058
	 /*     'Debe haber un jefe diferente'*/
     return 1
  end

 if not exists (
    select fu_funcionario
    from cl_funcionario
    where fu_funcionario = @i_funcionario)
  begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101036
	   /*'Funcionario no existe'*/
     return 1
  end
 if @i_jefe = 0 or @i_jefe is null
  select @w_codigo = 0
 else
 begin
  select @w_codigo = fu_nivel
   from cl_funcionario
   where fu_funcionario = @i_jefe
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101011
	    /*  'Jefe no existe'*/
     return 1
  end
  select @w_codigo = @w_codigo + 1
 end

 if not exists ( 
  select de_departamento
   from cl_departamento
   where de_departamento = @i_departamento 
     and de_oficina = @i_oficina)
  begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101010
	 /*     'Departamento no existe'*/
     return 1
  end

  select @w_valor = convert(varchar(10), @i_cargo)
  exec @w_return = sp_catalogo
	@t_debug        = @t_debug,
	@t_file         = @t_file,
	@t_from         = @w_sp_name,
	@i_tabla        = 'cl_cargo',
	@i_operacion    = 'E',
	@i_codigo       =  @w_valor
  if @w_return != 0
  begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101012
	 /*     'No existe cargo'*/
    return 1
  end


 /*** Verifica si es cambio de Password ***/
 /************ ADU: 24/04/2001 ************/
if @i_chpass='S'
begin
 /************ ADU: 24/04/2001 ************/

 /*** Chequeo de longitud minima de Password ***/
 /*** ARO: 15 de Noviembre ***/


 select @w_tmp=isnull(pa_tinyint,0)
 from cl_parametro
 where pa_producto='ADM' and
 pa_nemonico='TMP'
 
 if @@rowcount=0
 begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151122
	  /*   No existe Parámetro General  */
   return 1 
 end
 
/*** ARO:18/01/2001  CRYPWD ***/
--  select @w_tp=isnull(datalength(@i_clave),0)
    select @w_tp=isnull(@t_tampwd,0)
/*** FIN ARO CRYPWD ***/

 if @w_tp<@w_tmp 
 begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151123

    	print "Longitud  minima del Password es " + convert(varchar(5),@w_tmp) + " caracteres"

	  /*   Longitud de Password incorrecta */
   return 1 
 end

/**** FIN ARO ****/

 /************ ADU: 24/04/2001 ************/
end
 /********** FIN ADU: 24/04/2001 **********/


 /* verificacion de campos actualizados */
 select @w_nombre = fu_nombre,
	@w_sexo = fu_sexo,
	@w_dinero = fu_dinero,
	@w_nomina = fu_nomina,
	@w_departamento = fu_departamento,
	@w_oficina = fu_oficina,
	@w_cargo = fu_cargo,
	@w_secuencial = fu_secuencial,
	@w_jefe = fu_jefe,
	@w_nivel = fu_nivel,
	@w_clave = fu_clave,
	@w_offset = fu_offset	-- ARO:18/01/2001	CRYPWD
   from cl_funcionario
  where fu_funcionario = @i_funcionario

 select @v_nombre = @w_nombre,
	@v_sexo = @w_sexo,
	@v_dinero = @w_dinero,
	@v_nomina = @w_nomina,
	@v_departamento = @w_departamento,
	@ww_departamento = @w_departamento,
	@v_oficina = @w_oficina,
	@ww_oficina = @w_oficina,
	@v_cargo = @w_cargo,
	@ww_cargo = @w_cargo,
	@v_secuencial = @w_secuencial,
	@ww_secuencial = @w_secuencial,
	@v_jefe = @w_jefe,
	@v_nivel = @w_nivel,
	@v_clave = @w_clave,
	@v_offset = @w_offset	-- ARO:18/01/2001	CRYPWD
if ((@ww_departamento <> @i_departamento) or
    (@ww_oficina <> @i_oficina) or
    (@ww_cargo <> @i_cargo) or
    (@ww_secuencial <> @i_secuencial))
begin

 select @w_secuencial = ds_secuencial
   from cl_distributivo
  where ds_departamento = @i_departamento
    and ds_vacante = 'S'
    and ds_oficina = @i_oficina 
    and ds_cargo = @i_cargo
    and ds_secuencial = @i_secuencial

 if @@rowcount = 0
 begin
   exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101051
	 /*     'No existe vacante'*/
   return 1
 end
end

 if @w_secuencial = @i_secuencial
   select @w_secuencial = null, @v_secuencial = null
  else
   select @v_secuencial = @w_secuencial

 if @w_nombre = @i_nombre
    select @w_nombre = null, @v_nombre = null
  else
   select @w_nombre = @i_nombre

 if @w_sexo = @i_sexo
   select @w_sexo = null, @v_sexo = null
 else
    select @w_sexo = @i_sexo
 
 if @w_dinero = @i_dinero
   select @w_dinero = null, @v_dinero = null
 else
    select @w_dinero = @i_dinero
 
 if @w_nomina = @i_nomina
   select @w_nomina = null, @v_nomina = null
 else
    select @w_nomina = @i_nomina

/*** Verifica si es cambio de Password ***/

 /************ ADU: 24/04/2001 ************/
if @i_chpass='S'
begin
 /************ ADU: 24/04/2001 ************/

/*** ARO:18/01/2001 CRYPWD  ***/

 if @w_clave = @i_clave
   select @w_clave = null, @v_clave = null
 else
    select @w_clave = @i_clave
 
 if @w_offset = @t_offset
   select @w_offset = null, @v_offset = null
 else
 /*** ARO: 16 de Noviembre del 2000 ***/
 /****** CONTROL DE PASSWORDS REPETIDOS *****/
 begin
	select @w_offset = @t_offset

    /*** Control  de Repeticion Historica de Passwords ***/
    /*** ARO: 16 de Noviembre ***/
    
     select @w_npch=isnull(pa_tinyint,0)
     from cl_parametro
     where pa_producto='ADM' and
     pa_nemonico='NPCH'
     
     if @@rowcount=0
     begin
       exec sp_cerror
    		@t_debug        = @t_debug,
    		@t_file         = @t_file,
    		@t_from         = @w_sp_name,
    		@i_num          = 151124
    	  /*   No existe Parámetro General  */
       return 1 
     end
     
     declare CUR_CLAVES cursor for
--   select ch_clave		ARO:18/01/2001 CRYPWD
     select ch_offset
     from cl_clave_his
     where ch_login=@i_login
     order by ch_secuencial desc
     
     open CUR_CLAVES
     
     select @w_contador_his=0
--     fetch CUR_CLAVES into @w_clave_his  ARO:18/01/2001 CRYPWD
     fetch CUR_CLAVES into @w_offset_his  
     
     while (@@fetch_status != -1) and (@w_contador_his < @w_npch)
     begin
--     	if @w_clave_his=@i_clave	ARO:18/01/2001 CRYPWD
	if @w_offset_his=@t_offset
     	begin
       		exec sp_cerror
    		@t_debug        = @t_debug,
    		@t_file         = @t_file,
    		@t_from         = @w_sp_name,
    		@i_num          = 151125
    	  	/*   No existe Parámetro General  */
       		return 1      	
     	end
	select @w_contador_his=@w_contador_his+1
--	fetch CUR_CLAVES into @w_clave_his	ARO:18/01/2001 CRYPWD
	fetch CUR_CLAVES into @w_offset_his
     end
     close CUR_CLAVES
     deallocate CUR_CLAVES
    
    /***** FIN ARO ****/


    /**** ARO: 16 de Noviembre del 2000 ***/
    /*** Control Historico de Passwords (evitar repeticiones) ****/

    select @w_sec_his=isnull(max(ch_secuencial),0)+1
    from cl_clave_his
    where ch_login=@i_login
    
    insert into cl_clave_his (
    	ch_login,
    	ch_secuencial,
    	ch_fecha,
--    	ch_clave)	ARO:18/01/2001 CRYPWD
	ch_offset)
    values (
    	@i_login,
    	@w_sec_his,
    	getdate(),
--    	@i_clave)	ARO:18/01/2001 CRYPWD
	@t_offset)

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153051
	   /*  'Error en insercion en CL_CLAVE_HIS' */
	return 1
    end

    /***** FIN ARO ******/
    
    
 end
 /**** FIN ARO ****/
 
  /************ ADU: 24/04/2001 ************/
end
else
begin
   select @w_offset = null, @v_offset = null
end
 /********** FIN ADU: 24/04/2001 **********/

 
 if @w_departamento = @i_departamento and @w_oficina = @i_oficina
	begin
		select @w_departamento = null, @v_departamento = null
		select @w_oficina = null, @v_oficina = null
	end
 else
	begin
		select @w_departamento = @i_departamento
		select @w_oficina = @i_oficina
	end
 
 if @w_cargo = @i_cargo
    select @w_cargo = null, @v_cargo = null
 else
    select @w_cargo = @i_cargo
  
 if @w_jefe= @i_jefe
  begin
   select @w_jefe = null, @v_jefe = null
   select @w_nivel = null, @v_nivel = null
  end
 else
 begin
    select @w_jefe = @i_jefe
    select @w_nivel = @w_codigo
 end

 begin tran

 /*** Verifica si es cambio de Password ***/
 /************ ADU: 24/04/2001 ************/
if @i_chpass='S'
begin
 /************ ADU: 24/04/2001 ************/

  update cl_funcionario
  set    fu_nombre = @i_nombre,
	 fu_sexo = @i_sexo,
	 fu_dinero = @i_dinero,
	 fu_nomina = @i_nomina, 
	 fu_departamento = @i_departamento,
	 fu_oficina = @i_oficina,
	 fu_cargo = @i_cargo,
	 fu_secuencial = @i_secuencial,
	 fu_jefe = @i_jefe,
	 fu_nivel = @w_codigo,
	 fu_clave = @i_clave,
	 fu_estado = @i_estado,
	 fu_offset = @t_offset	-- ARO:18/01/2001 CRYPWD
  where  fu_funcionario = @i_funcionario
  if @@error != 0
  begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 105044
	 /*     'Error en actualizacion de funcionario'*/
    return 1
  end


 /************ ADU: 24/04/2001 ************/
end
else
   begin

  update cl_funcionario
  set    fu_nombre = @i_nombre,
	 fu_sexo = @i_sexo,
	 fu_dinero = @i_dinero,
	 fu_nomina = @i_nomina, 
	 fu_departamento = @i_departamento,
	 fu_oficina = @i_oficina,
	 fu_cargo = @i_cargo,
	 fu_secuencial = @i_secuencial,
	 fu_jefe = @i_jefe,
	 fu_nivel = @w_codigo,
	 fu_clave = fu_clave,
	 fu_estado = @i_estado,
	 fu_offset = fu_offset
  where  fu_funcionario = @i_funcionario
  if @@error != 0
  begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 105044
	 /*     'Error en actualizacion de funcionario'*/
    return 1
  end

end
 /********** FIN ADU: 24/04/2001 **********/

   
    update ad_usuario
       set us_fecha_ult_mod = @s_date
    where  us_login = @i_login

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155005
	   /*  'Error en actualizacion de usuario' */
	return 1
    end

/* 'Disponer de la vacante actualizada'*/ 
    Update cl_distributivo
       set ds_vacante = 'S'
     where ds_departamento = @ww_departamento
       and ds_oficina = @ww_oficina
       and ds_cargo = @ww_cargo
       and ds_secuencial = @ww_secuencial
    if @@error != 0
    begin
	  exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 105044
	   /*'Error en actualizacion de funcionario'*/
	  return 1
    end
    update cl_distributivo
       set ds_vacante = 'N'
     where  ds_departamento = @i_departamento
       and  ds_oficina = @i_oficina
       and  ds_cargo = @i_cargo
       and  ds_secuencial = @i_secuencial

 /* transaccion de servicio - funcionario */
  insert into ts_funcionario (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s, srv, lsrv,
			      funcionario, nombre, sexo, dinero,
			      departamento, oficina, cargo, secuencia_f, jefe,
			      nivel, nomina, clave,
			      offset)	-- ARO:18/01/2001 CRYPWD
	       values (@s_ssn, 599 , 'P', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,       
		       @i_funcionario, @v_nombre, @v_sexo, @v_dinero,
		       @v_departamento, @v_oficina, @v_cargo, @v_secuencial, 
		       @v_jefe, @v_nivel, @v_nomina, @v_clave,
		       @v_offset)	-- ARO:18/01/2001 CRYPWD
  if @@error != 0
  begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 103005
	   /* 'Error en creacion de transaccion de servicio'*/
    return 1
  end
  insert into ts_funcionario (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s, srv, lsrv,
			      funcionario, nombre, sexo, dinero,
			      departamento, oficina, cargo, secuencia_f, jefe,
			      nivel, nomina, clave,
			      offset)	-- ARO:18/01/2001 CRYPWD
	       values (@s_ssn, 599, 'A', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,       
		       @i_funcionario, @w_nombre, @w_sexo, @w_dinero,
		       @w_departamento, @w_oficina, @w_cargo, @w_secuencial, 
		       @w_jefe, @w_nivel, @w_nomina, @w_clave,
		       @w_offset)	-- ARO:18/01/2001 CRYPWD
  if @@error != 0
  begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 103005
	/*      'Error en creacion de transaccion de servicio'*/
    return 1
  end
 commit tran
 
/************ ADU: 26/06/2001 ************/
if @i_chpass='S'
begin

   select @w_cmdtransrv = @s_lsrv +'...sp_droplogin'
   exec @w_cmdtransrv
	@loginame = @i_login

   select @w_cmdtransrv = @s_lsrv +'...sp_addlogin'
   exec @w_cmdtransrv
	@loginame = @i_login,
	@passwd   = @i_clave
end
 /********** FIN ADU: 26/06/2001 **********/

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
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' +
		       @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'

		set rowcount 0
		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre

		exec @w_return = @w_cmdtransrv
					@t_trn             = @t_trn,
					@i_operacion       = @i_operacion,
					@i_secuencial      = @i_secuencial,
					@i_funcionario     = @i_funcionario,
					@i_login           = @i_login,
					@i_clave           = @i_clave,
					@i_nombre          = @i_nombre,
					@i_sexo            = @i_sexo,
					@i_dinero          = @i_dinero,
					@i_nomina          = @i_nomina,
					@i_departamento    = @i_departamento,
					@i_oficina         = @i_oficina,
					@i_cargo           = @i_cargo,
					@i_jefe            = @i_jefe,
					@i_nivel           = @w_codigo,
					@i_estado          = @i_estado,
					@i_central_transmit = 'S',
					@o_clave           = @w_clave_int out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave_int,
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
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end


/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 1510
begin
/* chequeo de referencias */
if not exists ( 
 select fu_funcionario
   from cl_funcionario
   where fu_funcionario = @i_funcionario)
 begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101036
	 /*     'Funcionario no existe'*/
     return 1
 end

if exists ( 
 select fu_funcionario
   from cl_funcionario
   where fu_jefe = @i_funcionario)
 begin
     exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151058
	 /*     'Existen funcionarios subalternos a este'*/
     return 1
 end

select @w_login = fu_login 
 from  cl_funcionario
 where fu_funcionario = @i_funcionario

/* referencia en ad_usuario */
if exists (
	select us_login
	  from ad_usuario
	 where us_login = @w_login
	  )
begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101064
	/* Existe referencia en ad_usuario */
	return 1
end

/* referencia en ad_usuario_rol */
if exists(
	select ur_login
	  from ad_usuario_rol
	 where ur_login = @w_login
	 )
begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101063
	/* Existe referencia en ad_usuario_rol */
	return 1
end

/* referencia en cc_oficial */
if exists(
	select oc_funcionario
	  from cc_oficial
	 where oc_funcionario = @i_funcionario
	 )
begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151090
	/* Oficial tiene subordinados, no puede eliminarse */
	return 1
end

/* referencia en cc_oficial */
if exists(
	select oc_funcionario
	  from cc_oficial
	 where oc_funcionario = @i_funcionario
	 )
begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151090
	/* Oficial tiene subordinados, no puede eliminarse */
	return 1
end

select  @w_funcionario = fu_funcionario,
	@w_nombre = fu_nombre,
	@w_sexo = fu_sexo,
	@w_dinero = fu_dinero,
	@w_nomina = fu_nomina,
	@w_departamento = fu_departamento,
	@w_oficina = fu_oficina,
	@w_cargo = fu_cargo,
	@w_secuencial = fu_secuencial,
	@w_jefe = fu_jefe,
	@w_nivel = fu_nivel,
	@w_clave = fu_clave,
	@w_offset = fu_offset	-- ARO:18/01/2001 CRYPWD
   from cl_funcionario
  where fu_funcionario = @i_funcionario

 begin tran
 delete cl_funcionario
  where fu_funcionario = @i_funcionario
 if @@error != 0
 begin
       exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 107046
	  /*    'Error en borrado de funcionario'*/
       return 1
 end

 update cl_distributivo
    set ds_vacante = 'S'
  where ds_departamento = @w_departamento
    and ds_oficina = @w_oficina
    and ds_cargo = @w_cargo
    and ds_secuencial = @w_secuencial
 if @@error != 0
 begin
       exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 107046
	   /*'Error en borrado de funcionario'*/
       return 1
 end

  /* transaccion de servicio - funcionario */
  insert into ts_funcionario (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s, srv, lsrv,
			      funcionario, nombre, sexo, dinero,
			      departamento, oficina, cargo, secuencia_f, jefe,
			      nivel, nomina, clave,
			      offset)	-- ARO:18/01/2001 CRYPWD
	       values (@s_ssn, 1510, 'B', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,       
		       @w_funcionario, @w_nombre, @w_sexo, @w_dinero,
		       @w_departamento, @w_oficina, @w_cargo, @w_secuencial, 
		       @w_jefe, @w_nivel, @w_nomina, @w_clave,
		       @w_offset)	-- ARO:18/01/2001 CRYPWD
  if @@error != 0
   begin
    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 103005
	/*      'Error en creacion de transaccion de servicio'*/
    return 1
   end 
 commit tran
   select @w_cmdtransrv = @s_lsrv +'...sp_droplogin'
   exec @w_cmdtransrv
	@loginame = @i_login

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
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' +
 @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'

		set rowcount 0
		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre

		exec @w_return = @w_cmdtransrv
					@t_trn             = @t_trn,
					@i_operacion       = @i_operacion,
					@i_funcionario     = @i_funcionario,
					@i_central_transmit = 'S',
					@o_clave           = @w_clave_int out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave_int,
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
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end



/* LLamada al stored procedure sp_cons_funcionario */
/* para operaciones de consulta                    */

if @i_operacion = 'S' or @i_operacion = 'Q' or @i_operacion = 'H'
begin
	exec @w_return = sp_cons_funcionario
		@t_file                 = @t_file,
		@t_from                 = @t_from,
		@t_trn                  = @t_trn,
		@i_operacion            = @i_operacion,
		@i_tipo                 = @i_tipo,
		@i_modo                 = @i_modo,
		@i_funcionario          = @i_funcionario, 
		@i_nombre               = @i_nombre,    
		@i_login                = @i_login
	    /*  @i_estado               = @i_estado   RLA 2000-feb-16 */
	if @w_return != 0
		return @w_return
end 

go
