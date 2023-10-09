/*************************************************************************/
/*  Archivo:                clinoruc.sp                                  */
/*  Stored procedure:       sp_persona_no_ruc                            */
/*  Base de datos:          cobis                                        */
/*  Producto:               MIS                                          */
/*  Disenado por:           Angela Ramirez                               */
/*  Fecha de escritura:     04/Jul/1996                                  */
/*************************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Este stored procedure inserta personas con datos incompletos         */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA       AUTOR       RAZON       NEMONICO                         */
/*  04/Jul/1996 A. Ramirez  Emision inicial                              */
/*  17/Dic/1996 J. Loyo     Se insertaron los campos tipo y No de Iden   */
/*  06/May/1998 J. Loyo     Se inserto el oficial INOFI                  */
/*  14/May/1998 N. Velasco  NVR03:cambio tipo vble ente para poder enviar*/
/*                          los datos a creacion rapida persona natural  */
/*  14/Ene/1999 J. Loyo     Se quita la parte de Estado Civil            */
/*  23/Sep/1999 C. Hernandez  Se coloca el numero de I.D. como NULL      */
/*                            cuando tipo doc @i_tipo_ced = 'EN'         */
/*  18/Sep/2001 E. Laguna     Validacion banca gerente                   */
/*  05/Nov/2002 D. Duran      Campo Regimen Fiscal                       */
/*  04/Feb/2005 D. Duran      Adiciono Tran Servicio                     */
/*  04/Jul/2006 Martha Gil V. Adicion dato en campo en_tipo_dp           */
/*  16/Jun/2007 E. Laguna     Desarrollo NR702                           */
/*  19/07/2007  F.Rivera      Def.8491                                   */
/*  09/Oct/2007 E. Laguna     Correccion defecto 8875                    */
/*  06/Nov/2007 E. Laguna     Paquete 001                                */
/*  09/Nov/2007 E. Laguna     Correccion defecto 1281                    */
/*  23/Nov/2007 E. Laguna     Correccion defecto 9049-producc            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/*************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_persona_no_ruc')
  drop proc sp_persona_no_ruc
go

create proc sp_persona_no_ruc
(
  @s_ssn            int,
  @s_user           login,
  @s_rol            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,
  @s_term           varchar (30),
  @s_date           datetime,
  @s_srv            varchar(30),
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(14) = null,
  @t_from           descripcion = null,
  @t_trn            smallint,
  @t_show_version   bit = 0,
  @i_operacion      char (1),
  @i_nombre         descripcion,
  @i_papellido      descripcion,
  @i_sapellido      descripcion = null,
  @i_filial         tinyint,
  @i_oficina        smallint = null,
  @i_tipo_ced       char(2),
  @i_cedula         numero = null,
  @i_oficial        smallint = null,
  @i_regimen_fiscal catalogo = null,
  @i_fecha_nac      datetime = null,
  @i_fecha_emi      datetime = null,
  @i_cod_central    varchar(10) = null,
  @i_doc_validado   char(1) = null,
  @i_dpto           smallint = null,
  @i_ciudad_exp     int = null,
  @i_procedencia    varchar(10) = null,
  @i_accion         varchar(10) = 'NIN',
  @i_sexo           char(10) = null,
  @i_ptipo          varchar(10) = null,
  @o_ente           int = null out,
  @o_tip_ente       int = null out
)
as
  declare
    @w_sp_name         descripcion,
    @w_return          int,
    @w_ente            int,
    @w_subtipo         char (1),
    @w_nombre_completo varchar (64),
    @w_fecha           datetime,
    @w_pais            catalogo,
    @w_sexo            char(10),
    @w_profesion       char(10),
    @w_ecivil          char(10),
    @w_ptipo           char(10),
    @w_actividad       char(10),
    @w_sectoreco       char(10),
    @w_tipo_vivienda   char(10),
    @w_depto           int,
    @w_ciudad          int,
    @w_ciudad_exp      int,
    @w_ciudad_nac      int,
    @w_oficial         smallint,
    @w_regimen_fiscal  catalogo,
    @w_nat_juridica    char(2),
    @w_dpto            smallint,
    @w_depa_nac        smallint,
    @w_dpto_exp        smallint,
    @w_fechacalculada  datetime,
    @w_bloqueado       char(1),
    @w_referido        smallint

  --Version /*  02/Abr/2009 E. Laguna     Pruebas tecnicas entrega version beta            */

  select
    @w_sp_name = 'sp_persona_no_ruc'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_nombre_completo = rtrim(ltrim(@i_papellido)) + ' ' + rtrim(ltrim(
                                      @i_sapellido )) + ' '
                         + rtrim(ltrim(@i_nombre))

  select
    @w_nat_juridica = 'PA'

  select
    @w_referido = fu_funcionario
  from   cobis..cl_funcionario
  where  fu_login = @s_user

  /* ** Insercion ** */
  if @i_operacion = 'I'
  begin
    if @t_trn <> 1288
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101147
      return 101147
    end

    if not exists (select
                     1
                   from   cl_tipo_documento
                   where  ct_subtipo = 'P'
                      and ct_codigo  = @i_tipo_ced)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101046
      return 101046
    end

    if @i_tipo_ced is null
        or @i_cedula is null
    begin
      print
  'Numero de Identificacion o Tipo de Identificacion con valores nulos'
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601001
      return 601001
    end

    if exists (select
                 1
               from   cl_ente
               where  en_subtipo  = 'P'
                  and en_tipo_ced = @i_tipo_ced
                  and en_ced_ruc  = @i_cedula)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101149
      return 101149
    end

    if @i_oficial is not null
    begin
      select
        @w_ente = oc_oficial
      from   cc_oficial
      where  oc_oficial = @i_oficial
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101036
        return 1
      end
      select
        @w_oficial = @i_oficial
    end
    else
    begin
      select
        @w_oficial = pa_smallint
      from   cl_parametro
      where  pa_nemonico = 'OPD'
         and pa_producto = 'MIS'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101199
        return 1
      end
    end

    select
      @w_subtipo = 'P',
      @w_fecha = getdate(),
      @w_pais = y.codigo
    from   cl_tabla x,
           cl_default y
    where  x.tabla   = 'cl_pais'
       and x.codigo  = y.tabla
       and y.oficina = @s_ofi
       and y.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101190
      return 1
    end

    if @i_sexo is null
    begin
      select
        @w_sexo = d.codigo
      from   cl_tabla t,
             cl_default d
      where  t.tabla   = 'cl_sexo'
         and t.codigo  = d.tabla
         and d.oficina = @s_ofi
         and d.srv     = @s_lsrv

      if @@rowcount = 0
      begin
        print 'NO EXISTE DEFAULT PARA SEXO'
        return 1
      end
    end
    else
      select
        @w_sexo = @i_sexo

    select
      @w_profesion = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_profesion'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA PROFESION '
      return 1
    end

    if @i_ptipo is null
    begin
      select
        @w_ptipo = d.codigo
      from   cl_tabla t,
             cl_default d
      where  t.tabla   = 'cl_ptipo'
         and t.codigo  = d.tabla
         and d.oficina = @s_ofi
         and d.srv     = @s_lsrv

      if @@rowcount = 0
      begin
        print 'NO EXISTE DEFAULT PARA TIPO DE PERSONA'
        return 1
      end
    end
    else
      select
        @w_ptipo = @i_ptipo

    select
      @w_actividad = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_actividad'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA ACTIVIDAD ECONOMICA'
      return 1
    end

    select
      @w_sectoreco = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_sectoreco'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA SECTOR ECONOMICO'
      return 1
    end

    select
      @w_tipo_vivienda = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_tipo_vivienda'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA TIPO DE VIVIENDA'
      return 1
    end

    select
      @w_dpto = convert(smallint, d.codigo)
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_provincia'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA DEPARTAMENTO'
      return 1
    end

    select
      @w_ciudad = convert(int, d.codigo)
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_ciudad'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA CIUDAD'
      return 1
    end

    select
      @w_depa_nac = @w_dpto
    select
      @w_ciudad_nac = @w_ciudad
    select
      @w_dpto_exp = @i_dpto
    select
      @w_ciudad_exp = @i_ciudad_exp

    if @i_dpto is null
        or @i_ciudad_exp is null
    begin
      select
        @w_dpto_exp = @w_dpto
      select
        @w_ciudad_exp = @w_ciudad
    end

    if @i_tipo_ced = 'CE'
    begin
      select
        @w_ciudad = convert(smallint, @w_pais)
    end

    if @i_tipo_ced = 'PA'
    begin
      select
        @w_ciudad = convert(smallint, @w_pais)
      select
        @w_ciudad_exp = convert(smallint, @w_pais)
    end

    if @i_tipo_ced = 'EN'
       and @i_cedula is null
    begin
      exec @w_return = sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_documento',
        @o_siguiente = @o_tip_ente out

      if @w_return <> 0
        return @w_return
      select
        @i_cedula = convert(varchar(30), @o_tip_ente)
    end

    exec @w_return = sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'cl_ente',
      @o_siguiente = @o_ente out

    if @w_return <> 0
      return @w_return

    begin tran
    /*********************************/
    insert into cl_ente
                (en_ente,en_subtipo,en_nombre,p_p_apellido,p_s_apellido,
                 p_sexo,en_tipo_ced,en_ced_ruc,p_pasaporte,en_pais,
                 p_profesion,p_estado_civil,p_num_cargas,p_nivel_ing,p_nivel_egr
                 ,
                 p_tipo_persona,en_fecha_crea,en_fecha_mod,
                 en_filial,en_oficina,
                 en_direccion,en_referencia,p_personal,p_propiedad,p_trabajo,
                 en_casilla,en_casilla_def,en_tipo_dp,p_fecha_nac,en_balance,
                 en_grupo,en_retencion,en_mala_referencia,en_comentario,
                 en_actividad
                 ,
                 en_oficial,p_fecha_emision,p_fecha_expira,
                 en_asosciada,en_referido,
                 en_sector,en_nit,p_depa_nac,p_ciudad_nac,p_lugar_doc,
                 p_nivel_estudio,p_tipo_vivienda,p_calif_cliente,en_doc_validado
                 ,
                 en_rep_superban,
                 en_nomlar,en_situacion_cliente,p_pais_emi,p_depa_emi,
                 c_tipo_compania,
                 en_procedencia,en_accion)
    values      (@o_ente,'P',@i_nombre,@i_papellido,@i_sapellido,
                 @w_sexo,@i_tipo_ced,@i_cedula,null,convert(smallint, @w_pais),
                 @w_profesion,@w_ecivil,0,0,0,
                 @w_ptipo,@w_fecha,@w_fecha,@i_filial,@i_oficina,
                 0,0,0,0,0,
                 0,null,'S',@i_fecha_nac,0,
                 null,'S','N',' ',@w_actividad,
                 @w_oficial,@i_fecha_emi,null,@i_regimen_fiscal,@w_referido,
                 @w_sectoreco,null,@w_depa_nac,@w_ciudad_nac,@w_ciudad_exp,
                 null,@w_tipo_vivienda,null,@i_doc_validado,'N',
                 @w_nombre_completo,'NOR',convert(smallint, @w_pais),@w_dpto_exp
                 ,
                 @w_nat_juridica,
                 @i_procedencia,@i_accion )

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 105066
      return 105066
    end

    select
      @o_ente,
      @i_nombre,
      @i_cedula,
      @i_tipo_ced,
      @i_papellido,
      @i_sapellido

    insert into cl_ejecutivo
                (ej_ente,ej_funcionario,ej_toficial,ej_fecha_asig)
    values      (@o_ente,@w_oficial,'P',getdate())

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101116
      return 101116
    end

    insert into cl_his_ejecutivo
                (ej_ente,ej_funcionario,ej_toficial,ej_fecha_asig,
                 ej_fecha_registro)
    values      (@o_ente,@w_oficial,'P',getdate(),getdate())

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101116
      return 101116
    end

    insert into ts_persona
                (secuencial,tipo_transaccion,clase,fecha,--1
                 usuario,
                 terminal,srv,lsrv,persona,nombre,
                 p_apellido,s_apellido,sexo,tipo_ced,cedula,
                 pasaporte,pais,profesion,estado_civil,num_cargas,
                 nivel_ing,nivel_egr,tipo,filial,oficina,
                 casilla_def,tipo_dp,fecha_nac,grupo,retencion,
                 mala_referencia,comentario,actividad,oficial,fecha_emision,
                 fecha_expira,asosciada,referido,sector,nit_per,
                 ciudad_nac,lugar_doc,nivel_estudio,tipo_vivienda,calif_cliente,
                 rep_superban,doc_validado,tipo_vinculacion,vinculacion,
                 exc_sipla,
                 exc_por2,digito,depa_nac,pais_emi,depa_emi,
                 categoria,pensionado,num_empleados,ts_procedencia,ts_accion)
    values      ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                  @s_term,@s_srv,@s_lsrv,@o_ente,@i_nombre,
                  @i_papellido,@i_sapellido,@w_sexo,@i_tipo_ced,@i_cedula,
                  null,convert(smallint, @w_pais),@w_profesion,@w_ecivil,0,
                  0,0,@w_ptipo,@i_filial,@i_oficina,
                  null,'S',@w_fecha,null,'S',
                  'N','CREACION RAPIDA CLIENTE',@w_actividad,@w_oficial,@w_fecha
                  ,
                  null,@i_regimen_fiscal,null,@w_sectoreco,
                  null,
                  @w_ciudad,@w_ciudad_exp,null,@w_tipo_vivienda,null,
                  'N','N',null,null,null,
                  null,null,null,convert(smallint, @w_pais),@w_dpto,
                  null,null,0,@i_procedencia,@i_accion )

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      return 103005
    end

    if @i_doc_validado = 'S'
    begin
      insert into cl_entes_validados
                  (ev_ente,ev_fecha,ev_usuario,ev_central,ev_origen)
      values      (@o_ente,@w_fecha,@s_user,@i_cod_central,
                   'CREACION RAPIDA CLIENTE'
      )

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107100
        return 1
      end
    end
    commit tran
    return 0
  end
  return 0

go

