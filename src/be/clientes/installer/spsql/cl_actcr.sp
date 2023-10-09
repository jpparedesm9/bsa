/************************************************************************/
/*      Archivo:                cl_actcr.sp                             */
/*      Stored procedure:       sp_actualizacion_critica                */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Felipe Rivera                           */
/*      Fecha de escritura:     29-Ene-2007                             */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Permite Consulta de la información critica de un cliente            */
/* y Actualización de información critica de un cliente                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/* FECHA       AUTOR         RAZON                                      */
/* 24/Ene/12   L. Moreno     Se cambia fecha proceso por fecha sistema  */
/* 03/Abr/12   A. Muñoz      LLS 46781 - mala referencia                */
/* 02/May/16   DFu           Migracion CEN                              */
/* 14-Ago-2018 ACHP          Temp 'Control para CURP' se debe borrar    */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_actualizacion_critica')
  drop proc sp_actualizacion_critica
go

create proc sp_actualizacion_critica
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          int,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_nombre       varchar(250)= null,
  @i_p_apellido   varchar(250)= null,
  @i_s_apellido   varchar(250)= null,
  @i_sexo         char(1) = null,
  @i_ente         int,
  @i_tipo_ced     varchar(10),
  @i_cedula       varchar(30),
  @i_fecha_nac    datetime = null,
  @i_digito       int = null,
  @i_oficina_prod smallint = null,
  @i_subtipo      char(1),
  @i_fecha_emi    datetime = null,
  @i_comentario   varchar(30) = 'UPD DESDE ACTUALIZACION CRITICA',
  @i_validado     char(1) = null
)
as
  declare
    @w_return          int,
    @w_sp_name         varchar(32),
    @v_nombre          varchar(250),
    @v_p_apellido      varchar(250),
    @v_s_apellido      varchar(250),
    @v_cedula          varchar(30),
    @v_tipo_ced        char(2),
    @v_fecha_emi       datetime,
    @v_fecha_nac       datetime,
    @v_ruc             varchar(30),
    @v_tipo_nit        char(2),
    @v_comentario      varchar(30),
    @v_tipo            varchar(10),
    @w_today           datetime,
    @w_bloqueado       char(1),
    @v_oficina_prod    smallint,
    @w_oficial         smallint,
    @w_dif_oficial     tinyint,
    @w_documento       varchar(30),
    @w_tdn             catalogo,
    @w_catalogo        catalogo,
    @w_tipo_ced        varchar(10),
    @w_nombre1         varchar(32),
    @w_apellido1       varchar(16),
    @w_apellido2       varchar(16),
    @w_nombre_completo varchar(64),
    @w_ofi_func        int,
    @w_tip_func        varchar(10),
    @w_tipo_vin        catalogo,
	--Para identificar cambio de CURP
	@w_oficial_tmp     smallint,
	@w_oficina_tmp     smallint,
	@w_cedula_tmp      numero,
    @w_nit_tmp         numero,
	@i_nit             numero
	--FIN para identificar cambio de CURP
	
  select
    @w_sp_name = 'sp_actualizacion_critica'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Lectura Parametro Oficina-Empleados
  select
    @w_ofi_func = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'OFIFUN'

  select
    @w_tip_func = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TIPFUN'

  --Version 18

  select
    @w_today = getdate()
  if @t_trn not in (186, 187)
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

  select
    @w_tipo_vin = p_tipo_persona
  from   cl_ente
  where  en_ente = @i_ente

  select
    @w_nombre1 = @i_nombre
  select
    @w_apellido1 = ltrim(rtrim(@i_p_apellido))
  select
    @w_apellido2 = ltrim(rtrim(isnull(@i_s_apellido,
                                      ' ')))

  if @w_apellido2 in(null, ' ')
  begin
    select
      @w_nombre_completo = @w_apellido1 + ' ' + @w_nombre1
  end
  if @w_apellido2 not in(null, ' ')
  begin
    select
      @w_nombre_completo = @w_apellido1 + ' ' + @w_apellido2 + ' ' + @w_nombre1
  end

  if @i_operacion = 'Q'
  begin
    create table #datos
    (
      campo1 varchar(10) null,
      campo2 varchar(64) null,
      campo3 varchar(64) null,
      campo4 varchar(16) null,
      campo5 varchar(16) null,
      campo6 smallint null,
      campo7 int null
    )
    insert into #datos
      select
        a.p_sexo,c.valor,ltrim(rtrim(a.en_nombre)),ltrim(rtrim(a.p_p_apellido)),
        ltrim(
        rtrim(a.p_s_apellido)),
        a.en_oficina_prod,isnull((select
                  di_ciudad
                from   cl_direccion
                where  di_ente = a.en_ente
                   and di_tipo = '011'),
               0)
      from   cl_ente a,
             cl_catalogo c,
             cl_tabla b
      where  a.en_ente  = @i_ente
         and c.codigo   = a.p_sexo
         and b.tabla    = 'cl_sexo'
         and c.tabla    = b.codigo
         and en_subtipo = 'P'

    if @@rowcount = 0
    begin
      insert into #datos
        select
          '','',ltrim(rtrim(a.en_nombre)),'','',
          a.en_oficina_prod,isnull((select
                    di_ciudad
                  from   cl_direccion
                  where  di_ente = a.en_ente
                     and di_tipo = '011'),
                 0)
        from   cl_ente a
        where  en_ente    = @i_ente
           and en_subtipo = 'C'
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103001
        return 1 /*'Error en creacion de cliente'*/
      end
    end
    select
      *
    from   #datos
  end

  if @i_operacion = 'U'
  begin
    if @w_tipo_ced = 'NI'
        or @w_tipo_ced = 'N'
      select
        @w_documento = @i_cedula + isnull(convert(varchar(2), @i_digito), '')
    else
      select
        @w_documento = @i_cedula

    select
      @w_tipo_ced = ltrim(rtrim(@i_tipo_ced))

    /*** Verificar el tipo de identificacion del cliente*/
    if @i_tipo_ced is not null
    begin
      select
        @w_catalogo = convert(char(10), @w_tipo_ced)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_tipo_documento',
        @i_codigo    = @w_catalogo
      if @w_return != 0
      begin
        /* 'No existe Tipo de Documento'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101221
        return 1
      end
    end

    begin tran
    if @i_subtipo = 'P'
    begin
        /*Control para CURP*/
		select 
		@w_oficial_tmp = en_oficial,
		@w_oficina_tmp = en_oficina,
		@w_cedula_tmp  = en_ced_ruc,
		@w_nit_tmp     = en_nit,
		@i_nit         = en_nit -- se usa este valor, por que desde el sp no se sta enviado el nit(rfc)
		from cobis..cl_ente
		where en_ente= @i_ente
		
		
        if(@w_cedula_tmp <> @i_cedula)
        begin
            insert into cl_modificacion_curp_rfc (mcr_ente,       mcr_ssn_user    ,  mcr_ssn_oficina,
                                                  mcr_fecha,      mcr_oficial     ,  mcr_oficina    ,
        										  mcr_curp_ant,   mcr_rfc_ant     ,  mcr_curp       ,
        										  mcr_rfc,        mcr_operacion   ,  mcr_sp)
                                          values (@i_ente,        @s_user         ,  @s_ofi         ,
        								          getdate(),      @w_oficial_tmp  ,  @w_oficina_tmp     ,
        										  @w_cedula_tmp,  @w_nit_tmp      ,  @i_cedula,
        										  @i_nit,         @i_operacion    ,  @w_sp_name)
         if(len(@i_cedula) < 18)
		     select @i_cedula = @w_cedula_tmp
        end
        /*Fin Control para CURP*/

      /* seleccionar los datos anteriores de la persona */
      select
        @v_nombre = en_nombre,
        @v_p_apellido = p_p_apellido,
        @v_s_apellido = p_s_apellido,
        @v_cedula = en_ced_ruc,
        @v_tipo_ced = en_tipo_ced,
        @v_oficina_prod = en_oficina_prod,
        @v_fecha_emi = p_fecha_emision,
        @v_comentario = en_comentario,
        @v_fecha_nac = p_fecha_nac,
        @v_tipo = p_tipo_persona
      from   cl_ente
      where  en_ente = @i_ente
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /*  'No existe persona'*/
        rollback tran
        return 1
      end
      if @w_tip_func = @v_tipo
        select
          @i_oficina_prod = @w_ofi_func

      update cl_ente
      set    en_nombre = isnull(@i_nombre,
                                en_nombre),
             p_p_apellido = isnull(@i_p_apellido,
                                   p_p_apellido),
             p_s_apellido = @i_s_apellido,
             en_tipo_ced = isnull(@w_tipo_ced,
                                  en_tipo_ced),
             en_ced_ruc = isnull(@w_documento,
                                 en_ced_ruc),
             en_nomlar = @w_nombre_completo,
             en_mala_referencia = case
                                    when (@w_documento <> @v_cedula) then 'N'
                                    else en_mala_referencia
                                  end,--LLS 46781
             en_cont_malas = case
                               when (@w_documento <> @v_cedula) then 0
                               else en_cont_malas
                             end,--LLS 46781
             en_oficina_prod = isnull(@i_oficina_prod,
                                      en_oficina_prod),
             en_fecha_mod = @w_today,
             p_fecha_emision = isnull(@i_fecha_emi,
                                      p_fecha_emision),
             en_comentario = isnull(@i_comentario,
                                    en_comentario),
             en_doc_validado = isnull(@i_validado,
                                      en_doc_validado),
             p_fecha_nac = isnull(@i_fecha_nac,
                                  p_fecha_nac)
      where  en_ente = @i_ente
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105026
        /* 'Error en actualizacion de persona'*/
        rollback tran
        return 1
      end
	  
	  update cl_ente_aux
      set    ea_ced_ruc = isnull(@w_documento,ea_ced_ruc)
      where  ea_ente = @i_ente
	  
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105026
        /* 'Error en actualizacion de persona'*/
        rollback tran
        return 1
      end
	  
      exec sp_ente_bloqueado--FRI Def. 8268 06/14/2007
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_ente,
        @o_retorno   = @w_bloqueado output

      if @v_nombre <> @i_nombre
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_nombre',@v_nombre,
                     @i_nombre,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_p_apellido <> @i_p_apellido
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','p_p_apellido',@v_p_apellido,
                     @i_p_apellido,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_s_apellido <> @i_s_apellido
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','p_s_apellido',@v_s_apellido,
                     @i_s_apellido,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_cedula <> @i_cedula
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_ced_ruc',@v_cedula,
                     @i_cedula,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_tipo_ced <> @w_tipo_ced
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_tipo_ced',@v_tipo_ced,
                     @w_tipo_ced,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_fecha_emi <> @i_fecha_emi
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','p_fecha_emision',@v_fecha_emi,
                     @i_fecha_emi,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_fecha_nac <> @i_fecha_nac
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','p_fecha_nac',@v_fecha_nac,
                     @i_fecha_nac,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end

      if @i_oficina_prod is not null
      begin
        if @i_oficina_prod <> @v_oficina_prod
        begin
          exec @w_return = cobis..sp_funcionario_oficina
            @s_ssn         = @s_ssn,
            @s_date        = @s_date,
            @s_ofi         = @i_oficina_prod,
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_trn         = null,
            @i_operacion   = 'Q',
            @i_parcargo    = 'DOF',
            @o_funcionario = @w_oficial out
          if @w_return <> 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = @w_return
            return @w_return
          end
          /* Asignacion automatica de Oficial SIPLA */
          if @w_oficial is not null
          begin
            exec @w_return = cobis..sp_asesor_upd
              @s_ssn         = @s_ssn,
              @t_trn         = 1316,
              @i_tipo_cli    = 'P',
              @i_operacion   = 'U',
              @i_ente        = @i_ente,
              @i_filial      = 1,
              @i_oficina     = @i_oficina_prod,
              @i_oficial     = @w_oficial,
              @o_dif_oficial = @w_dif_oficial out
            if @w_return != 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = @w_return
              return @w_return
            end
          end
        end --null

        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_oficina_prod',
                     @v_oficina_prod
                     ,
                     @i_oficina_prod,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 103001 /*'Error en creacion de cliente'*/
        end

        select
          @w_tdn = pa_char
        from   cobis..cl_parametro
        where  pa_producto = 'MIS'
           and pa_nemonico = 'TDN'

        if @w_tdn is not null
        begin
          update cobis..cl_direccion
          set    di_zona = @i_oficina_prod
          where  di_ente = @i_ente
             and di_tipo = @w_tdn
        end
      end /*antes*/
      insert into ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,nombre,
                   p_apellido,s_apellido,tipo_ced,cedula,fecha_emision,
                   comentario,fecha_nac)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_nombre,
                   @v_p_apellido,@v_s_apellido,@v_tipo_ced,@v_cedula,
                   @v_fecha_emi,
                   @v_comentario,@v_fecha_nac)
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        rollback tran
        return 1
      end /*despues*/
      insert into ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,nombre,
                   p_apellido,s_apellido,tipo_ced,cedula,fecha_emision,
                   comentario,fecha_nac)
      values      (@s_ssn,@t_trn,'D',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_nombre,
                   @i_p_apellido,@i_s_apellido,@w_tipo_ced,@i_cedula,
                   @i_fecha_emi,
                   @i_comentario,@i_fecha_nac)
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end
    end--persona
    else
    begin--compania
      select
        @v_nombre = en_nombre,
        @v_ruc = en_ced_ruc,
        @v_tipo_nit = en_tipo_ced,
        @v_comentario = en_comentario,
        @v_fecha_emi = c_fecha_const
      from   cl_ente
      where  en_ente = @i_ente
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /*'No existe persona'*/
        rollback tran
        return 1
      end
      update cl_ente
      set    en_nombre = isnull(@i_nombre,
                                en_nombre),
             en_tipo_ced = isnull(@w_tipo_ced,
                                  en_tipo_ced),
             en_ced_ruc = isnull(@w_documento,
                                 en_ced_ruc),
             en_nomlar = isnull(@i_nombre,
                                en_nomlar),
             en_mala_referencia = case
                                    when (@w_documento <> @v_ruc) then 'N'
                                    else en_mala_referencia
                                  end,--LLS 46781
             en_cont_malas = case
                               when (@w_documento <> @v_ruc) then 0
                               else en_cont_malas
                             end,--LLS 46781
             c_fecha_const = isnull(@i_fecha_emi,
                                    c_fecha_const),
             en_fecha_mod = @w_today,
             en_comentario = @i_comentario,
             en_oficina_prod = isnull(@i_oficina_prod,
                                      en_oficina_prod),
             p_fecha_emision = isnull(@i_fecha_emi,
                                      p_fecha_emision),
             en_doc_validado = isnull(@i_validado,
                                      en_doc_validado)
      where  en_ente = @i_ente
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105026
        /* 'Error en actualizacion de persona'*/
        rollback tran
        return 1
      end
      exec sp_ente_bloqueado--FRI Def. 8268 06/14/2007
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_ente,
        @o_retorno   = @w_bloqueado output

      if @v_nombre <> @i_nombre
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_nombre',@v_nombre,
                     @i_nombre,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_ruc <> @i_cedula
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_ced_ruc',@v_ruc,
                     @i_cedula,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end
      if @v_tipo_nit <> @w_tipo_ced
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','en_tipo_ced',@v_tipo_nit,
                     @w_tipo_ced,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end /*antes*/
      if @v_fecha_emi <> @i_fecha_emi
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@i_ente,getdate(),'cl_ente','c_fecha_const',@v_fecha_emi,
                     @i_fecha_emi,'U')
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          rollback tran
          return 1 /*'Error en creacion de cliente'*/
        end
      end

      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,nombre,
                   ruc,tipo_nit,comentario)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_nombre,
                   @v_ruc,@v_tipo_nit,@v_comentario)
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        /* 'Error en la creacion de transaccion de servicio'*/
        return 1
      end /*despues*/
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,nombre,
                   ruc,tipo_nit,comentario)
      values      (@s_ssn,@t_trn,'D',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_nombre,
                   @i_cedula,@w_tipo_ced,@i_comentario)
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        /* 'Error en la creacion de transaccion de servicio'*/
        return 1
      end
    end--compania
    --ACTUALIZA CL_CLIENTE
    update cobis..cl_cliente
    set    cl_ced_ruc = isnull(@i_cedula,
                               cl_ced_ruc)
    where  cl_cliente = @i_ente
    if @@error != 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105026
      /* 'Error en actualizacion de persona'*/
      rollback tran
      return 1
    end

    if @w_tipo_vin in ('002', '004', '005')
    begin
      /*CARGA DE INFORMACION DEL CLIENTE PROVEEDORES HACIA DYNAMICS */

      exec @w_return=cobis..sp_cobis_dynamics
        @s_ssn   = @s_ssn,
        @s_user  = @s_user,
        @s_term  = @s_term,
        @s_date  = @s_date,
        @s_srv   = @s_srv,
        @s_lsrv  = @s_lsrv,
        @s_ofi   = @s_ofi,
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_ente  = @i_ente

      if @w_return <> 0
        return 1
    end

    commit tran
  end
  return 0

go

