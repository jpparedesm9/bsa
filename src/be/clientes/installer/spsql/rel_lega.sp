/************************************************************************/
/*  Archivo:            rel_lega.sp                                     */
/*  Stored procedure:   sp_rel_lega                                     */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Sara Meza                                       */
/*  Fecha de escritura: 03-Dic-1996                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Permite realizar operaciones DML en la tabla cl_relacion,           */
/*  que es la tabla que contiene la descripcion de las relaciones       */
/*  genericas que pueden mantener dos instancias de cl_ente.            */
/*      Consultas de relacion                                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR      RAZON                                       */
/*  25-Nov-1996  S Meza     Emision inicial                             */
/*  05/May/2016  T. Baidal  Migracion a CEN                             */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_rel_lega')
           drop proc sp_rel_lega
go

create proc sp_rel_lega
(
  @s_ssn            int = null,
  @s_user           login = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @s_rol            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,
  @t_debug          char (1) = 'N',
  @t_file           varchar (14) = null,
  @t_from           varchar (30) = null,
  @t_trn            smallint = null,
  @t_show_version   bit = 0,
  @i_operacion      char (1),
  @i_modo           tinyint = null,
  @i_relacion       char(4) = null,
  @i_izquierda      int = null,
  @i_lado           varchar(6) = '%',/* En caso de buscar relaciones en  */
  @i_derecha        int = null /* Ambas direcciones se utiliza %'  */,
  @i_ente           int = null,
  @o_representante  char(1) = null out,
  @o_direccionrepre char(1) = null out,
  @o_telefonorepre  char(1) = null out,
  @o_accionistas    char(1) = null out,
  @o_mayoritarios   int = null out,
  @o_totalsociosm   int = null out
)
as
  declare
    @w_sp_name      varchar (30),
    @w_return       int,
    @w_relacion     int,
    @w_izquierda    int,
    @w_derecha      int,
    @w_atributo     int,
    @v_izquierda    int,
    @v_derecha      int,
    @w_cont_dir     int,
    @w_cont_tel     int,
    @w_bloqueado    char(1),
    @w_accnat       int,
    @w_accjur       int,
    @w_mayoritarios int,
    @w_rep          int,
    @w_siguiente    int

  /*  Captura nombre del Stored Procedure  */
  select
    @w_sp_name = 'sp_rel_lega'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_relacion is not null
  begin
    select
      @w_relacion = pa_smallint
    from   cl_parametro
    where  pa_nemonico = @i_relacion
       and pa_producto = 'MIS'
    if @@rowcount = 0
    begin
      /* No existe parametro */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101077
      return 101077
    end
  end
  else
  begin
    /* No existe parametro */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101077
    return 101077
  end

  /*  Validar que el Representante Legal tenga definido una direccion y un telefono*/
  if @t_trn = 117
  begin
    if @i_operacion = 'V'
    begin
      if @i_relacion = 'RL5'
      begin
        select
          @w_cont_dir = count(0)
        from   cobis..cl_direccion
        where  di_ente = @i_ente

        select
          @w_cont_tel = count(0)
        from   cobis..cl_telefono
        where  te_ente = @i_ente

        if @w_cont_dir = 0
            or @w_cont_tel = 0
        begin
          /* Representante Legal sin direccion y/o telefono */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107106
          return 1
        end
      end
    end
  end

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 117
    begin
      /** LLAMAR AL SP SP_INSTANCIA ***/
      exec @w_return = cobis..sp_instancia
        @t_debug     = @t_debug,
        @s_ssn       = @s_ssn,
        @t_trn       = 1367,
        @i_operacion = @i_operacion,
        @i_relacion  = @w_relacion,
        @i_derecha   = @i_derecha,
        @i_izquierda = @i_izquierda,
        @i_lado      = 'D'
      if @i_relacion = 'RL1'
          or @i_relacion = 'RL2'
      begin
        select
          @w_atributo = 1
        while @w_atributo <= 3
        begin
          exec cobis..sp_at_instancia
            @t_debug     = @t_debug,
            @s_ssn       = @s_ssn,
            /*@t_file    = @t_file,*/
            @t_trn       = 1161,
            @i_operacion = @i_operacion,
            @i_relacion  = @w_relacion,
            @i_ente_d    = @i_derecha,
            @i_ente_i    = @i_izquierda,
            @i_atributo  = @w_atributo,
            @i_valor     = '0'
          select
            @w_atributo = @w_atributo + 1
        end
      end

      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
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
        @i_ente      = @i_izquierda,
        @o_retorno   = @w_bloqueado output

      /* MGV Fin Buscar       */
      return 0
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 118
    begin
      /** LLAMAR AL SP SP_INSTANCIA ***/
      exec cobis..sp_instancia
        @t_debug     = @t_debug,
        @s_ssn       = @s_ssn,
        /* @t_file   = @t_file,*/
        @t_trn       = 1368,
        @i_operacion = @i_operacion,
        @i_relacion  = @w_relacion,
        @i_derecha   = @i_derecha,
        @i_izquierda = @i_izquierda,
        @i_lado      = 'D'

      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
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
        @i_ente      = @i_izquierda,
        @o_retorno   = @w_bloqueado output

      /* MGV Fin Buscar       */
      return 0
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

/*  Search  */
  /* Encontrar todas las relaciones definidas */

  if @i_operacion = 'S'
  begin
    if @t_trn = 1312
    begin
      select
        'Consec.Clte' = in_ente_d,
        'Nombre' = en_nomlar,
        'Tpo. D.I.' = en_tipo_ced,
        'Nro. D.I.' = en_ced_ruc
      from   cl_ente,
             cl_instancia
      where  in_ente_i   = @i_izquierda
         and in_ente_d   = cl_ente.en_ente
         and in_relacion = @w_relacion
         and in_lado like @i_lado
      order  by in_ente_d

      if @i_relacion = 'RL5'
         and @@rowcount = 0
      begin
        /* Ente Juridico sin Representante Legal */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107107
        return 107107
      end

      return 0
    end

    if @t_trn = 1346 /*relaciones tipo RL3 y RL4  *NVR */
    begin
      select
        'Consec.Clte' = in_ente_d,
        'Nombre' = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
        'Nro. D.I.' = en_ced_ruc,
        'Atributo' = substring(ar_descripcion,
                               1,
                               30 * (sign(isnull(ai_ente_i,
                                                 0))))
      from   cl_instancia
             left outer join cl_at_instancia
                          on ai_relacion = in_relacion
                             and ai_ente_d = in_ente_d
                             and ai_ente_i = in_ente_i
             left outer join cl_at_relacion
                          on ai_atributo = ar_atributo
                             and in_relacion = ar_relacion
             inner join cl_ente
                     on in_ente_d = en_ente
      where  in_relacion = @w_relacion
         and in_ente_i   = @i_izquierda
      group  by in_ente_d,
                en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                en_ced_ruc,
                substring(ar_descripcion,
                          1,
                          30 * (sign(isnull(ai_ente_i,
                                            0))))

      return 0

    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

/*  Query  */
  /* encontrar los datos de una relacion especifica */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1313
    begin
      select
        in_relacion,
        in_ente_d,
        p_p_apellido,
        p_s_apellido,
        en_nombre,
        en_tipo_ced,
        en_ced_ruc
      from   cl_instancia,
             cl_ente
      where  in_relacion = @w_relacion
         and in_ente_i   = @i_izquierda
         and in_ente_d   = @i_derecha
         and in_ente_d   = en_ente

      /* si no existen datos, error */
      if @@rowcount = 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101087
      end
      return 0

    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

/*  Help  */
  /*  Mostrar los datos de relaciones */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1315
    begin
      select distinct
        'Nombre' = en_nomlar,
        'Numero D.I.' = en_ced_ruc,
        'Valor Part.' = ai1.ai_valor,
        'Porcentaje Part.' = ai2.ai_valor,
        'Num Cuotas/Acciones' = ai3.ai_valor
      from   cl_at_instancia ai1,
             cl_at_instancia ai2,
             cl_at_instancia ai3,
             cl_instancia,
             cl_ente
      where  ai1.ai_ente_i   = @i_izquierda
         and ai2.ai_ente_i   = @i_izquierda
         and ai3.ai_ente_i   = @i_izquierda
         and ai1.ai_ente_i   = in_ente_i
         and ai1.ai_relacion = in_relacion
         and (in_relacion     = 201
               or in_relacion     = 202)
         and (ai1.ai_relacion = 201
               or ai1.ai_relacion = 202)
         and ai2.ai_relacion = ai1.ai_relacion
         and ai3.ai_relacion = ai1.ai_relacion
         and (in_lado = 'D')
         and ai1.ai_atributo = 1
         and ai2.ai_atributo = 2
         and ai3.ai_atributo = 3
         and in_ente_d       = en_ente
         and ai1.ai_ente_d   = en_ente
         and ai1.ai_ente_d   = ai2.ai_ente_d
         and ai1.ai_ente_d   = ai3.ai_ente_d
      order  by en_ced_ruc
    end
  end

/*  Query especifico  */
  /*  Mostrar los totales para habilitar boton salir */

  if @i_operacion = 'X'
  begin
    if @t_trn = 1312
    begin
      select
        @w_rep = in_ente_d
      from   cl_ente,
             cl_instancia
      where  in_ente_i   = @i_izquierda
         and in_ente_d   = cl_ente.en_ente
         and in_relacion = 205
         and in_lado like @i_lado

      if @w_rep > 0
      begin
        select
          @o_representante = "S"
      end
      else
      begin
        select
          @o_representante = "N"
      end

      select
        @w_cont_dir = isnull(count(0),
                             0)
      from   cobis..cl_direccion
      where  di_ente = @w_rep

      if @w_cont_dir > 0
      begin
        select
          @o_direccionrepre = "S"
      end
      else
      begin
        select
          @o_direccionrepre = "N"
      end

      select
        @w_cont_tel = isnull(count(0),
                             0)
      from   cobis..cl_telefono
      where  te_ente = @w_rep

      if @w_cont_dir > 0
      begin
        select
          @o_telefonorepre = "S"
      end
      else
      begin
        select
          @o_telefonorepre = "N"
      end

      --Validar accionistas mayoritarios

      select
        @w_accnat = isnull(count(0),
                           0)
      from   cobis..cl_instancia
      where  in_relacion = 201
         and in_ente_i   = @i_izquierda

      select
        @w_accjur = isnull(count(0),
                           0)
      from   cobis..cl_instancia
      where  in_relacion = 202
         and in_ente_d   = @i_izquierda

      select
        @w_mayoritarios = 0-- isnull(en_partisocio,0)
      --      from cobis..cl_ente
      --    where en_ente = @i_izquierda

      if @w_mayoritarios <> (@w_accnat + @w_accjur)
      begin
        select
          @o_accionistas = "N"
      end
      else
      begin
        select
          @o_accionistas = "S"
      end

      select
        @o_mayoritarios = @w_mayoritarios
      select
        @o_totalsociosm = (@w_accnat + @w_accjur)

      select
        @o_representante
      select
        @o_direccionrepre
      select
        @o_telefonorepre
      select
        @o_accionistas
      select
        @o_mayoritarios
      select
        @o_totalsociosm

    end
  end

go

