use cob_ahorros
go

/************************************************************************/
/*      Archivo:                solicitud_apertura.sp                   */
/*      Stored procedure:       sp_solicitud_apertura                   */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Ramiro Garzon P.                        */
/*      Fecha de escritura:     14-Jun-1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de solicitud de apertura   */
/*      de cuenta de ahorros                                            */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      14/Jun/1995     R. Garzon       Version Original                */
/*      03/Ene/1996     M. Sanguino     Personalizacion B. Prestamos    */
/*      13/Ago/1998     V. Molina       Agregar @i_codigos1, @i_codigos2*/
/*      27/Ene/1999     J. Salazar      Creacion del parametro          */
/*                                      @i_categoria y su consideracion */
/*      30/Mar/2006     J. Suarez       Validacion producto 20          */
/*      26/Abr/2006     D. Vasquez      Elimina la validacion Prod 20   */
/*      12/Jun/2006     P. Coello       COMENTAR VALIDACION PARA LOS MENORES DE EDAD*/
/*      22/Dic/2006     R. Ramos        busqueda por rango de fecha     */
/*      04/Nov/2009     A. Correa       Grabar observacion de rechazo   */
/*      05/Mar/2010     C. Muñoz        Parametros Zona y Territorial   */
/*      02/May/2016     Walther Toledo  Migración a CEN                 */
/*      29/Jun/2016     E. Moran        Recursos para Operacion S       */
/*      20/JuL/2016     J. Tagle        Productos Dependientes          */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_solicitud_apertura')
  drop proc sp_solicitud_apertura
go

create proc sp_solicitud_apertura
(
  @s_ssn           int,
  @s_ssn_branch    int = null,--AFL
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           varchar(64) = null,
  @s_org           char(1),
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_numsol        int = null,
  @i_operacion     char(2),
  @i_modo          tinyint = null,
  @i_ofi           smallint = null,
  @i_estado        char(2) = null,
  @i_mon           tinyint = null,
  @i_tipo          char(2) = null,
  @i_depart        char(5) = null,
  @i_codigo        int = null,
  @i_tiptit        char(2) = null,
  @i_codigos1      char(50) = null,
  @i_codigos2      char(50) = null,
  @i_categoria     char(1) = null,
  @i_formato_fecha int=101,
  @i_fecha_desde   datetime = null,
  @i_fecha_hasta   datetime = null,
  @i_turno         smallint = null,
  @i_desc          varchar(255) = null,

  --INI CMU REQ023 BPT 04/03/2010
  @i_zona          int = null,
  @i_territorial   int = null,

  --FIN CMU REQ023 BPT 04/03/2010
  @o_solicitud     int = null out
)
as
  declare
    @w_return          int,
    @w_sp_name         varchar(30),
    @w_fecha           datetime,
    @w_ofi             smallint,
    @w_user            varchar(30),
    @w_estado          char(2),
    @w_mon             tinyint,
    @w_tipo            char(2),
    @w_depart          char(5),
    @w_feccal          datetime,
    @w_usercal         varchar(30),
    @w_codigo          int,
    @w_tiptit          char(2),
    @w_numsol          int,
    @w_ofi_solicitud   smallint,
    @w_codigos1        varchar(50),
    @w_codigos2        varchar(50),
    @w_clave           tinyint,
    @w_longitud        smallint,
    @w_ocurrencia      tinyint,
    @w_cod_ente        varchar(10),
    @w_ente            int,
    @w_ced_ruc         varchar(30),
    @w_fecha_nac       datetime,
    @w_mayor_edad      tinyint,
    @w_fecha_hoy       datetime,
    @w_dia_hoy         smallint,
    @w_num_anios       tinyint,
    @w_mes_hoy         tinyint,
    @w_mes_nac         tinyint,
    @w_dia_nac         smallint,
    @w_mensaje         varchar(100),
    @w_temp            varchar(100),
    @w_tipo_ente       char(1),
    @w_categoria       char(1),
    @w_referencia      char(1),
    @w_mala_referencia char(1),
    @v_fecha           datetime,
    @v_ofi             smallint,
    @v_user            varchar(30),
    @v_estado          char(2),
    @v_mon             tinyint,
    @v_tipo            char(2),
    @v_depart          char(5),
    @v_feccal          datetime,
    @v_usercal         varchar(30),
    @v_codigo          int,
    @v_tiptit          char(2),
    @v_numsol          int,
    @v_categoria       char(1),
    @w_c_apellido      varchar(20),
    @w_p_apellido      varchar(16),
    @w_s_apellido      varchar(16),
    @w_p_nombre        varchar(64),
    @w_s_nombre        varchar(20),
    @w_rep_legal       int,
    @w_pais            smallint,
    @w_sexo            char(1),
    @w_estado_civil    varchar(10),
    @w_nit             varchar(30),
    @w_num_hijos       tinyint,
    @w_num_cargas      tinyint,
    @w_direccion       tinyint,
    @w_telefono        tinyint,
    @w_desc_direc      varchar(254),
    @w_num_telef       varchar(16),
    @w_desc            varchar(255),
    @v_desc            varchar(255),
	@w_me_mercado      smallint,    --codigo de mercado
	@w_prod_fin_dep    smallint,    --producto final dependiente
	@w_producto_ban    smallint,    --producto bancario
	@w_producto        tinyint,     --producto cobis
    @w_cta             cuenta,      -- cta del cliente
    @w_sucursal        smallint,
    @w_subtipo         char(1)	

  /*  Captura nombre de Stored Procedure  */

  select
    @w_sp_name = 'sp_solicitud_apertura'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* inicializacion de variable  */
  select
    @w_mala_referencia = 'N'

  /*  Activacion del Modo de debug  */

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_operacion = @i_operacion,
      i_estado = @i_estado,
      i_mon = @i_mon,
      i_tipo = @i_tipo,
      i_depart = @i_depart,
      i_codigo = @i_codigo,
      i_tiptit = @i_tiptit,
      i_codigos1 = @i_codigos1,
      i_codigos2 = @i_codigos2,
      i_formato_fecha = @i_formato_fecha
    exec cobis..sp_end_debug
  end

  /* Valida el producto para la oficina */
  if isnull(@s_ofi,
            0) <> 0
  begin
    exec @w_return = cobis..sp_val_prodofi
      @i_modulo  = 4,
      @i_oficina = @s_ofi
    if @w_return <> 0
      return @w_return
  end

/* Operaciones */
  /* Insercion */

  if @i_operacion = 'I'
  begin
    if @t_trn <> 352
    begin
      /* Error en numero de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 201048
    end

    /* Vamos a revisar los entes que conforman la cuenta */

    select
      @w_fecha_hoy = @s_date

    if @i_codigos1 is not null
    begin --1
      select
        @w_codigos1 = @i_codigos1
      select
        @w_clave = 0
      while @w_clave = 0
      begin --2
        select
          @w_longitud = datalength(@w_codigos1)

        select
          @w_ocurrencia = charindex('|',
                                    @w_codigos1)

        if @w_ocurrencia <> 0
        begin --3
          select
            @w_cod_ente = substring(@w_codigos1,
                                    1,
                                    @w_ocurrencia - 1)

          /* Aqui va parte del select */
          select
            @w_ente = convert(int, @w_cod_ente)

          select
            @w_ced_ruc = en_ced_ruc,
            @w_fecha_nac = p_fecha_nac,
            @w_tipo_ente = en_subtipo,
            @w_referencia = isnull(en_mala_referencia,
                                   'N')
          from   cobis..cl_ente
          where  en_ente = @w_ente

          /* Validacion de que el cliente no sea una mala referencia */
          if @w_mala_referencia = 'N'
            select
              @w_mala_referencia = @w_referencia

        /* if exists (select 1
           from cobis..cl_mala_ref
          where mr_ente = @w_ente)
           begin --4
              select @w_mensaje    = 'EL CLIENTE ' + @w_cod_ente + ' TIENE MALAS REFERENCIAS'
         /* Cliente posee una mala referencia */
             exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num        = 201107,
               @i_msg       = @w_mensaje
             return 201107
            end  --4 */
          /* Carga los parametros para la mayoria de edad */

          if @w_tipo_ente = 'P'
          begin --4
            select
              @w_mayor_edad = pa_tinyint
            from   cobis..cl_parametro
            where  pa_nemonico = 'MDE'
               and pa_producto = 'ADM'

            if @@rowcount <> 1
            begin --5
              /* Error en lectura de SSN */
              exec cobis..sp_cerror
                @i_num = 111020,
                @i_msg = 'ERROR EN PARAMETRO DE MAYORIA DE EDAD'
              return 111020
            end --5

            select
              @w_dia_hoy = datepart(dd,
                                    @w_fecha_hoy)

            /* Valida la mayoria de edad */

            select
              @w_num_anios = datediff(yy,
                                      @w_fecha_nac,
                                      @w_fecha_hoy)
          /****** PEDRO COELLO JUNIO DEL 2006 SE COMENTA LA VALIDACIaN PARA LOS MENORES DE EDAD *****/
          --              if @w_num_anios < @w_mayor_edad
          --              begin --5
          --                  select @w_mensaje    = 'EL CLIENTE ' + @w_cod_ente + ' ES MENOR DE EDAD'
          --                exec cobis..sp_cerror
          --                        @t_debug     = @t_debug,
          --                        @t_file      = @t_file,
          --                        @t_from      = @w_sp_name,
          --                        @i_num       = 201083,
          --                        @i_msg       = @w_mensaje
          --                return 201083
          --              end --5
          --             else
          --              if @w_num_anios = @w_mayor_edad
          --              begin --5
          --                select @w_mes_hoy = datepart(mm,@w_fecha_hoy)
          --                select @w_mes_nac = datepart(mm,@w_fecha_nac)
          --                if @w_mes_hoy < @w_mes_nac
          --                begin --6
          --                  select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' ES MENOR DE EDAD'
          --                                exec cobis..sp_cerror
          --                                @t_debug     = @t_debug,
          --                                @t_file      = @t_file,
          --                                @t_from      = @w_sp_name,
          --                                @i_num       = 201083,
          --                                @i_msg       = @w_mensaje
          --                        return 201083
          --                end --6
          --                else
          --                if @w_mes_hoy = @w_mes_nac
          --                begin --6
          --                  select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' ES MENOR DE EDAD'
          --                        select @w_dia_nac = datepart(dd,@w_fecha_nac)
          --                        if @w_dia_hoy < @w_dia_nac
          --                        begin --7
          --                                exec cobis..sp_cerror
          --                                        @t_debug     = @t_debug,
          --                                        @t_file      = @t_file,
          --                                        @t_from      = @w_sp_name,
          --                                        @i_num       = 201083,
          --                                        @i_msg       = @w_mensaje
          --                                return 201083
          --                        end --7
          --        end --6
          --             end --5
          /****** PEDRO COELLO JUNIO DEL 2006 SE COMENTA LA VALIDACIaN PARA LOS MENORES DE EDAD *****/
          /* Validacion de que el cliente no sea un narco*/
          /*if exists (select 1
             from cobis..cl_narcos
            where na_cedula = @w_ced_ruc
               or na_pasaporte = @w_ced_ruc)
             begin
                 select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' ESTA EN LA TABLA DE NARCOS'
           /* Cliente posee mala reputacion en narcos */
               exec cobis..sp_cerror
                 @t_debug     = @t_debug,
                 @t_file      = @t_file,
                 @t_from      = @w_sp_name,
                 @i_num       = 208044,
                 @i_msg       = @w_mensaje
               return 208044
              end      */
          end --4
          select
            @w_codigos1 = substring(@w_codigos1,
                                    @w_ocurrencia + 1,
                                    @w_longitud - @w_ocurrencia)
        end --3
        else
        begin --3
          select
            @w_clave = 1
        end --3
      end --2
    end --1

    /* Para la segunda cadena de entes conformantes de la cuenta */

    if @i_codigos2 is not null
    begin
      select
        @w_codigos2 = @i_codigos2
      select
        @w_clave = 0
      while @w_clave = 0
      begin
        select
          @w_longitud = datalength(@w_codigos2)

        select
          @w_ocurrencia = charindex('|',
                                    @w_codigos2)

        if @w_ocurrencia <> 0
        begin
          select
            @w_cod_ente = substring(@w_codigos2,
                                    1,
                                    @w_ocurrencia - 1)
          /* Aqui va parte del select */

          select
            @w_ente = convert(int, @w_cod_ente)
          select
            @w_ced_ruc = en_ced_ruc,
            @w_fecha_nac = p_fecha_nac,
            @w_tipo_ente = en_subtipo,
            @w_referencia = isnull(en_mala_referencia,
                                   'N')
          from   cobis..cl_ente
          where  en_ente = @w_ente

          /* Validacion de que el cliente no sea una mala referencia */

          if @w_mala_referencia = 'N'
            select
              @w_mala_referencia = @w_referencia

          /*    if exists (select 1
               from cobis..cl_mala_ref
              where mr_ente = @w_ente)
               begin
               select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' TIENE MALAS REFERENCIAS'
             /* Cliente posee una mala referencia */
                 exec cobis..sp_cerror
                   @t_debug     = @t_debug,
                   @t_file      = @t_file,
                   @t_from      = @w_sp_name,
                   @i_num       = 201107,
                   @i_msg       = @w_mensaje
                 return 201107
                end */

          if @w_tipo_ente = 'P'
          begin
            /* Carga los parametros para la mayoria de edad */

            select
              @w_mayor_edad = pa_tinyint
            from   cobis..cl_parametro
            where  pa_nemonico = 'MDE'
               and pa_producto = 'ADM'

            if @@rowcount <> 1
            begin
              /* Error en lectura de SSN */
              exec cobis..sp_cerror
                @i_num = 111020,
                @i_msg = 'ERROR EN PARAMETRO DE MAYORIA DE EDAD'
              return 111020
            end

            select
              @w_dia_hoy = datepart(dd,
                                    @w_fecha_hoy)

            /* Valida la mayoria de edad */

            select
              @w_num_anios = datediff(yy,
                                      @w_fecha_nac,
                                      @w_fecha_hoy)
          /****** PEDRO COELLO JUNIO DEL 2006 SE COMENTA LA VALIDACIaN PARA LOS MENORES DE EDAD *****/
          --              if @w_num_anios < @w_mayor_edad
          --              begin
          --                select @w_mensaje  = 'EL CLIENTE ' + @w_cod_ente + ' ES MENOR DE EDAD'
          --                exec cobis..sp_cerror
          --                @t_debug     = @t_debug,
          --                        @t_file      = @t_file,
          --                        @t_from      = @w_sp_name,
          --                        @i_num       = 201083,
          --                        @i_msg       = @w_mensaje
          --                return 201083
          --              end
          --             else
          --              if @w_num_anios = @w_mayor_edad
          --              begin
          --                select @w_mes_hoy = datepart(mm,@w_fecha_hoy)
          --                select @w_mes_nac = datepart(mm,@w_fecha_nac)
          --                if @w_mes_hoy < @w_mes_nac
          --                begin
          --                 select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' ES MENOR DE EDAD'
          --                                exec cobis..sp_cerror
          --                                @t_debug     = @t_debug,
          --                                @t_file      = @t_file,
          --                                @t_from      = @w_sp_name,
          --                                @i_num       = 201083,
          --                                @i_msg       = @w_mensaje
          --                        return 201083
          --                end
          --                else
          --                if @w_mes_hoy = @w_mes_nac
          --                begin
          --                        select @w_dia_nac = datepart(dd,@w_fecha_nac)
          --                        if @w_dia_hoy < @w_dia_nac
          --                        begin
          --                         select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' ES MENOR DE EDAD'
          --                                exec cobis..sp_cerror
          --                                        @t_debug     = @t_debug,
          --                                        @t_file      = @t_file,
          --                                        @t_from      = @w_sp_name,
          --                                        @i_num       = 201083,
          --                                        @i_msg       = @w_mensaje
          --                                return 201083
          --                        end
          --                end
          --        end
          /****** PEDRO COELLO JUNIO DEL 2006 SE COMENTA LA VALIDACIaN PARA LOS MENORES DE EDAD *****/
          /* Validacion de que el cliente no sea un narco*/
          /*    if exists (select 1
               from cobis..cl_narcos
              where na_cedula = @w_ced_ruc
                 or na_pasaporte = @w_ced_ruc)
               begin
                   select @w_mensaje = 'EL CLIENTE ' + @w_cod_ente + ' ESTA EN LA TABLA DE NARCOS'
             /* Cliente posee mala reputacion en narcos */
                 exec cobis..sp_cerror
                   @t_debug     = @t_debug,
                   @t_file      = @t_file,
                   @t_from      = @w_sp_name,
                   @i_num       = 208044,
                   @i_msg       = @w_mensaje
                 return 208044
                end          */
          end
          select
            @w_codigos2 = substring(@w_codigos2,
                                    @w_ocurrencia + 1,
                                    @w_longitud - @w_ocurrencia)
        end
        else
        begin
          select
            @w_clave = 1
        end
      end
    end
	

	----------------------------------------------------------------------------------
	--Buscar Cuenta de cliente que sea de ese tipo de Prod. Final
	----------------------------------------------------------------------------------   
	select @w_producto = pd_producto 
	  from cobis..cl_producto 
	 where pd_abreviatura = 'AHO'
	----------------------------------------------------------------------------------
	--Buscar Producto Bancario Dependiente
	select @w_producto_ban = @i_tipo
	--Producto bancario
	if not exists (select 1 from cob_remesas..pe_pro_bancario
				   where pb_pro_bancario = @w_producto_ban
					 and pb_estado       = 'V')
	begin
		exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file,
		   @t_from  = @w_sp_name,
		   @i_num   = 351508 --No existe producto bancario    
		return 351508
	end
	--Mercado

	select @w_me_mercado = me_mercado
	from cob_remesas..pe_mercado
	where me_pro_bancario = @w_producto_ban
	  and me_tipo_ente    = @w_tipo_ente
	  and me_estado       = 'V'
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file,
		   @t_from  = @w_sp_name,
		   @i_num   = 351553 --No existe mercado para el producto bancario y el tipo de ente
		return 351553
	end

	select
	@w_subtipo = of_subtipo
	from   cobis..cl_oficina
	where  of_oficina = @s_ofi

	if @w_subtipo = 'O'
		select
		@w_sucursal = of_regional
		from   cobis..cl_oficina
		where  of_oficina = @s_ofi
	else
		select
		@w_sucursal = @s_ofi

	--Producto final y Dependiente
	select 
	@w_prod_fin_dep = pf_depende
	from cob_remesas..pe_pro_final
	where pf_mercado  = @w_me_mercado
	  and pf_moneda   = @i_mon
	  and pf_producto = @w_producto
	  and pf_sucursal = @w_sucursal
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file,
		   @t_from  = @w_sp_name,
		   @i_num   = 351553 --No existe mercado para el producto bancario y el tipo de ente
		return 351553
	end  
	if not (@w_prod_fin_dep is null) -- si tiene dependencia
	begin
		----------------------------------------------------------------------------------
		--Buscar Cuenta de cliente que sea de ese tipo de Prod. Final
		--Producto Dependiente como base
		select 
		@w_prod_fin_dep = pf_pro_final,
		@w_me_mercado   = pf_mercado,
		@w_producto     = pf_producto
		from cob_remesas..pe_pro_final
		where pf_pro_final = @w_prod_fin_dep
		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file  = @t_file,
			   @t_from  = @w_sp_name,
			   @i_num   = 357564 --NO EXISTE PRODUCTO FINAL DEPENDIENTE
			return 357564
		end  
		--Mercado
		select @w_producto_ban  = me_pro_bancario,
			   @w_tipo_ente     = me_tipo_ente
		from cob_remesas..pe_mercado
		where me_mercado = @w_me_mercado
		  and me_estado       = 'V'
		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file  = @t_file,
			   @t_from  = @w_sp_name,
			   @i_num   = 357565 --NO EXISTE MERCADO PARA PRODUCTO FINAL DEPENDIENTE
			return 357565
		end   	   
		--Producto bancario
		if not exists (select 1 from cob_remesas..pe_pro_bancario
					   where pb_pro_bancario = @w_producto_ban
						 and pb_estado       = 'V')
		begin
			exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file  = @t_file,
			   @t_from  = @w_sp_name,
			   @i_num   = 357566 --NO EXISTE PRODUCTO BANCARIO DEPENDIENTE
			return 357566
		end
		----------------------------------------------------------------------------------
		--Buscar Cuenta de ese tipo de Prod Bancario
		select
			  @w_cta = ah_cuenta
		 from cob_ahorros..ah_cuenta
		where ah_cliente   = @w_cod_ente
		  and ah_moneda    = @i_mon
		  and ah_prod_banc = @w_producto_ban
		  and ah_estado    = 'A'
		if @@rowcount < 1
		begin
			/* CLIENTE NO POSEE CUENTA CON PRODUCTO BANCARIO DEPENDIENTE ACTIVA */
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 357563
			return 357563
		end
	end -- if not (@w_prod_fin_dep is null)
	----------------------------------------------------------------------------------
	--FIN Buscar Cuenta de cliente que sea de ese tipo de Prod. Final
	----------------------------------------------------------------------------------  
		
	
    begin tran
    /* Busco un nuevo secuencial para la solicitud */
    exec @w_return=cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'ah_solicitud_cuenta',
      @o_siguiente = @w_numsol out
    if @w_return <> 0
      return @w_return

    /* Inserto nueva solicitud */
    insert into cob_ahorros..ah_solicitud_cuenta
                (sc_numsol,sc_fecha,sc_ofi,sc_user,sc_estado,
                 sc_moneda,sc_tipo,sc_depar,sc_feccal,sc_usercal,
                 sc_categoria,sc_mala_referencia)
    values      (@w_numsol,@s_date,@s_ofi,@s_user,@i_estado,
                 @i_mon,@i_tipo,@i_depart,@s_date,@s_user,
                 @i_categoria,@w_mala_referencia)

    /* Si no se pudo envio error */
    if @@error <> 0
    begin
      /* Error en creacion de solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203027
      return 203027
    end

    /* Grabo transaccion de servicio */
    insert into cob_ahorros..ah_tssolape
                (secuencial,ssn_branch,cod_alterno,clase,tipo_transaccion,
                 oficina,usuario,terminal,reentry,tsfecha,
                 origen,filial,fecha_aper,cliente,estado,
                 producto,tipo,moneda,propietario,autorizante,
                 categoria,turno)
    values      (@s_ssn,isnull(@s_ssn_branch,
                        @s_ssn),0,'N',@t_trn,
                 @s_ofi,@s_user,@s_term,@t_rty,@s_date,
                 @s_org,1,@s_date,@i_codigo,@i_estado,
                 3,@i_tipo,@i_mon,@i_tiptit,@s_user,
                 @i_categoria,@i_turno)

    /* Si no se pudo envio error */
    if @@error <> 0
    begin
      /* Error en grabacion transaccion de servicio creacion de solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 203005
    end

    commit tran

    /* Retorno el secuencial al frontend */
    select
      @w_numsol,
      @w_mala_referencia
    select
      @o_solicitud = @w_numsol
    return 0
  end

  if @i_operacion = 'I1'
  begin
    if @t_trn <> 353
    begin
      /* Error en numero de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 201048
    end

    begin tran
    /* Inserto clientes titular y alternantes solicitud */
    insert into cob_ahorros..ah_clicta_solicitud
                (cs_codigo,cs_tipo,cs_numsol)
    values      (@i_codigo,@i_tiptit,@i_numsol)

    /* Si no se pudo envio error */
    if @@error <> 0
    begin
      /* Error en creacion de titulares y alternantes */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203028
      return 203028
    end

    commit tran

    return 0
  end

  /* Actualizacion */
  if @i_operacion = 'U'
  begin
    if @t_trn <> 354
    begin
      /* Error en numero de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 201048
    end

    /* Busco la solicitud */
    select
      @w_fecha = sc_fecha,
      @w_ofi = sc_ofi,
      @w_user = sc_user,
      @w_estado = sc_estado,
      @w_mon = sc_moneda,
      @w_tipo = sc_tipo,
      @w_depart = sc_depar,
      @w_feccal = sc_feccal,
      @w_usercal = sc_usercal,
      @w_categoria = sc_categoria,
      @w_desc = sc_desc
    from   ah_solicitud_cuenta
    where  sc_numsol = @i_numsol
    if @@rowcount = 0
    begin
      /* No existe solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201144
      return 201144
    end

    select
      @v_fecha = @w_fecha,
      @v_ofi = @w_ofi,
      @v_user = @w_user,
      @v_estado = @w_estado,
      @v_mon = @w_mon,
      @v_tipo = @w_tipo,
      @v_depart = @w_depart,
      @v_feccal = @w_feccal,
      @v_usercal = @w_usercal,
      @v_categoria = @w_categoria,
      @v_desc = @w_desc

    if @w_fecha = @s_date
      select
        @w_fecha = null
    else
      select
        @w_fecha = @s_date

    if @w_ofi = @s_ofi
      select
        @w_ofi = null
    else
      select
        @w_ofi = @s_ofi

    if @w_user = @s_user
      select
        @w_user = null
    else
      select
        @w_user = @s_user

    if @w_estado = @i_estado
      select
        @w_estado = null
    else
      select
        @w_estado = @i_estado

    if @w_mon = @i_mon
      select
        @w_mon = null
    else
      select
        @w_mon = @i_mon

    if @w_tipo = @i_tipo
      select
        @w_tipo = null
    else
      select
        @w_tipo = @i_tipo

    if @w_depart = @i_depart
      select
        @w_depart = null
    else
      select
        @w_depart = @i_depart

    if @w_feccal = @s_date
      select
        @w_feccal = null
    else
      select
        @w_feccal = @s_date

    if @w_usercal = @s_user
      select
        @w_usercal = null
    else
      select
        @w_usercal = @s_user

    if @w_categoria = @i_categoria
      select
        @w_categoria = null
    else
      select
        @w_categoria = @i_categoria

    if @w_desc = @i_desc
      select
        @w_desc = null
    else
      select
        @w_desc = @i_desc

    begin tran
    /* Actualizacion datos de solicitud */
    update ah_solicitud_cuenta
    set    sc_estado = @i_estado,
           sc_moneda = @i_mon,
           sc_tipo = @i_tipo,
           sc_depar = @i_depart,
           sc_feccal = @s_date,
           sc_usercal = @s_user,
           sc_categoria = @i_categoria,
           sc_desc = @i_desc
    where  sc_numsol = @i_numsol

    /* Si no se pudo envio error */
    if @@rowcount <> 1
    begin
      /* Error en actualizacion de solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205025
      return 205025
    end

    /* Grabo transaccion de servicio registro previo */
    insert into cob_ahorros..ah_tssolape
                (secuencial,ssn_branch,cod_alterno,clase,tipo_transaccion,
                 oficina,usuario,terminal,reentry,tsfecha,
                 origen,filial,fecha_aper,cliente,estado,
                 producto,tipo,moneda,propietario,autorizante,
                 categoria,turno,observacion)
    values      (@s_ssn,isnull(@s_ssn_branch,
                        @s_ssn),10,'P',@t_trn,
                 @v_ofi,@v_user,@s_term,@t_rty,@v_fecha,
                 @s_org,1,@v_feccal,@v_codigo,@v_estado,
                 3,@v_tipo,@v_mon,@v_tiptit,@s_user,
                 @v_categoria,@i_turno,@v_desc)

    /* Si no se pudo envio error */
    if @@error <> 0
    begin
      /* Error en creacion de solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 203005
    end

    /* Grabo transaccion de servicio registro actual */
    insert into cob_ahorros..ah_tssolape
                (secuencial,ssn_branch,cod_alterno,clase,tipo_transaccion,
                 oficina,usuario,terminal,reentry,tsfecha,
                 origen,filial,fecha_aper,cliente,estado,
                 producto,tipo,moneda,propietario,autorizante,
                 categoria,turno,observacion)
    values      (@s_ssn,isnull(@s_ssn_branch,
                        @s_ssn),20,'A',@t_trn,
                 @s_ofi,@s_user,@s_term,@t_rty,@s_date,
                 @s_org,1,@s_date,@w_codigo,@w_estado,
                 3,@w_tipo,@w_mon,@w_tiptit,@s_user,
                 @w_categoria,@i_turno,@w_desc)

    /* Si no se pudo envio error */
    if @@error <> 0
    begin
      /* Error en creacion de solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 203005
    end

    commit tran
    return 0
  end

  /* Busqueda de 20 en 20 para seleccion */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 356
    begin
      /* Error en numero de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 201048
    end

    set rowcount 20
    if @i_modo = 0
      select
        '509035' = sc_numsol,
        /*
                      'Nombre del titular'  = substring(p_p_apellido, 1, 15) + ' ' +
                                              substring(p_s_apellido, 1, 15) + ' ' +
                                              substring(en_nombre, 1, 20),
        */
        '509036' = en_nomlar,
        '509037' = sc_moneda,
        -- 'Departamento'     = sc_depar, -- JCSA
        '503093' = (select pb_descripcion
                               from   cob_remesas..pe_pro_bancario
                               where  pb_pro_bancario = convert(smallint,
                              A.sc_tipo)), --Producto Bancario
        '509038' = convert(varchar(10), sc_fecha, @i_formato_fecha),
        '9017' = sc_usercal,
        '509039' = convert(varchar(10), sc_feccal, @i_formato_fecha)
        ,
        '9019' = sc_estado,
        '508762' = sc_categoria,
        '9923' = sc_desc
      from   ah_solicitud_cuenta A,
             ah_clicta_solicitud,
             cobis..cl_ente,
             --INI CMU REQ023 BPT 04/03/2010
             cobis..cl_oficina
      --FIN CMU REQ023 BPT 04/03/2010
      --where sc_numsol > @i_numsol
      where  (sc_ofi      = @i_ofi
               or @i_ofi is null)
         and ((@i_numsol   = 0
               and sc_numsol   > @i_numsol)
               or (@i_numsol   > 0
                   and sc_numsol   = @i_numsol))
         and sc_numsol   = cs_numsol
         and cs_codigo   = en_ente
         and sc_estado   = @i_estado
         and cs_tipo     = 'T'
         and sc_moneda   = @i_mon
         and sc_fecha between @i_fecha_desde and @i_fecha_hasta
         --INI CMU REQ023 BPT 04/03/2010
         and sc_ofi      = of_oficina
         and (of_zona     = @i_zona
               or @i_zona is null)
         and (of_regional = @i_territorial
               or @i_territorial is null)
      --FIN CMU REQ023 BPT 04/03/2010
      order  by sc_numsol

    if @i_modo = 1
      select
        '509035' = sc_numsol,
        /*
                      'Nombre del titular'  = substring(p_p_apellido, 1, 15) + ' ' +
                                              substring(p_s_apellido, 1, 15) + ' ' +
                                              substring(en_nombre, 1, 20),
        */
        '509036' = en_nomlar,
        '509037' = sc_moneda,
        -- 'Departamento'     = sc_depar, -- JCSA
        '503093' = (select pb_descripcion
                               from   cob_remesas..pe_pro_bancario
                               where  pb_pro_bancario = convert(smallint,
                              A.sc_tipo)), --Producto Bancario
        '509038' = convert(varchar(10), sc_fecha, @i_formato_fecha),
        '9017' = sc_usercal,
        '509039' = convert(varchar(10), sc_feccal, @i_formato_fecha)
        ,
        '9019' = sc_estado,
        '508762' = sc_categoria,
        '9923' = sc_desc
      from   ah_solicitud_cuenta A,
             ah_clicta_solicitud,
             cobis..cl_ente,
             --INI CMU REQ023 BPT 04/03/2010
             cobis..cl_oficina
      --FIN CMU REQ023 BPT 04/03/2010
      where  (sc_ofi      = @i_ofi
               or @i_ofi is null)
         and sc_numsol   > @i_numsol
         and sc_numsol   = cs_numsol
         and cs_codigo   = en_ente
         and sc_estado   = @i_estado
         and cs_tipo     = 'T'
         and sc_moneda   = @i_mon
         and sc_fecha between @i_fecha_desde and @i_fecha_hasta
         --INI CMU REQ023 BPT 04/03/2010
         and sc_ofi      = of_oficina
         and (of_zona     = @i_zona
               or @i_zona is null)
         and (of_regional = @i_territorial
               or @i_territorial is null)
      --FIN CMU REQ023 BPT 04/03/2010
      order  by sc_numsol

    set rowcount 0
    return 0
  end

  if @i_operacion = 'S1'
  begin
    if @t_trn <> 356
    begin
      /* Error en numero de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 201048
    end

    select
      cs_codigo,
      en_ced_ruc,
      p_pasaporte,
      en_subtipo,
      en_nomlar,
      cs_tipo,
      valor
    from   ah_clicta_solicitud,
           cobis..cl_ente,
           cobis..cl_tabla,
           cobis..cl_catalogo
    where  cs_numsol                 = @i_numsol
       and cs_codigo                 = en_ente
       and cobis..cl_tabla.tabla     = 'cl_rol'
       and cobis..cl_tabla.codigo    = cobis..cl_catalogo.tabla
       and cobis..cl_catalogo.codigo = cs_tipo
    order  by cs_tipo desc

    if @i_modo = 1
    begin
      select --@w_c_apellido = p_c_apellido,
        @w_p_apellido = p_p_apellido,
        @w_s_apellido = p_s_apellido,
        @w_p_nombre = en_nombre,
        --@w_s_nombre = p_s_nombre,
        @w_rep_legal = c_rep_legal,
        @w_pais = en_pais,
        @w_sexo = p_sexo,
        @w_estado_civil = p_estado_civil,
        @w_nit = en_nit,
        @w_fecha_nac = p_fecha_nac,
        @w_num_hijos = p_num_hijos,
        @w_num_cargas = p_num_cargas,
        @w_direccion = en_direccion,
        @w_ente = en_ente
      from   cobis..cl_ente,
             cob_ahorros..ah_clicta_solicitud
      where  cs_numsol = @i_numsol
         and cs_tipo   = 'T'
         and en_ente   = cs_codigo

      select
        @w_telefono = di_telefono,
        @w_desc_direc = di_descripcion
      from   cobis..cl_direccion
      where  di_ente      = @w_ente
         and di_direccion = @w_direccion

      select
        @w_num_telef = te_valor
      from   cobis..cl_telefono
      where  te_ente       = @w_ente
         and te_secuencial = @w_telefono

      select
        @w_c_apellido,
        @w_p_apellido,
        @w_s_apellido,
        @w_p_nombre,
        @w_s_nombre,
        @w_rep_legal,
        @w_pais,
        @w_sexo,
        @w_estado_civil,
        @w_nit,
        convert(varchar(10), @w_fecha_nac, 101),
        @w_num_hijos,
        @w_num_cargas,
        @w_desc_direc,
        @w_num_telef

    end

    return 0

  end

  /* Query */
  if @i_operacion = 'Q'
  begin
    if @t_trn <> 355
    begin
      /* Error en numero de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 201048
    end

    if @i_tipo = 'SI'
    begin
      select
        @w_ofi_solicitud = sc_ofi
      from   ah_solicitud_cuenta
      where  sc_numsol = @i_numsol

      if @@rowcount = 0
      begin
        /* No existe solicitud */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201144
        return 201144
      end

      if @i_ofi <> @w_ofi_solicitud
      begin
        /* Error sucursal de la solicitud diferente a la sucursal activa */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201180
        return 201180
      end
    end

    select
      'Numero de Solicitud' = sc_numsol,
      'Codigo del cliente' = cs_codigo,
      'Moneda' = sc_moneda,
      'Departamento' = sc_depar,
      'Producto Bancario' = A.sc_tipo,
      'Fecha solicitud' = convert(varchar(10), sc_fecha, @i_formato_fecha),
      'Usuario' = sc_usercal,
      'Fecha verificacion' = convert(varchar(10), sc_feccal, @i_formato_fecha),
      'Estado' = sc_estado,
      'Categoria' = sc_categoria,
      'Mala Referencia' = sc_mala_referencia
    from   ah_solicitud_cuenta A,
           ah_clicta_solicitud
    where  sc_numsol = @i_numsol
       and sc_numsol = cs_numsol
       and cs_tipo   = 'T'

    if @@rowcount = 0
    begin
      /* No existe solicitud */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201144
      return 201144
    end

    return 0
  end

go

