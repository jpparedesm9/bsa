/************************************************************************/
/*      Archivo:                grupo.sp                                */
/*      Stored procedure:       sp_grupo                                */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     08-Nov-1992                             */
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
/*              PROPOSITO                                               */
/*  Permite crear y dar mantenimiento de la informacion de los          */
/*  Grupos Economicos ..                                                */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*  FECHA           AUTOR       RAZON                                   */
/*  9-May-1994      S. Ortiz    Emision inicial                         */
/*  13/Feb/2004     D. Duran    Modifico tipo_transaccion 7 y 8         */
/*                              por 107 y 108 para ts_grupo             */
/*  04/May/2016     T. Baidal   Migracion a CEN                         */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_grupo') 
    drop proc sp_grupo
go

create proc sp_grupo
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @s_rol           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_operacion     char(1),
  @i_modo          tinyint = null,
  @i_tipo          char(1) = null,
  @i_ente          int = null,
  @i_grupo         int = null,
  @i_nombre        descripcion = null,
  @i_representante int = null,
  @i_activo        money = null,
  @i_pasivo        money = null,
  @i_filial        tinyint = null,
  @i_oficina       smallint = null,
  @i_ruc           numero = null,
  @i_compania      int = null,
  @i_fecha_reg     datetime = null,
  @i_oficial       smallint = null
)
as
  declare
    @w_siguiente          int,
    @w_return             int,
    @w_ente               int,
    @w_num_cl_gr          int,
    @w_contador           int,
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_tipo               char(1),
    @w_nombre             descripcion,
    @w_representante      int,
    @w_ruc                numero,
    @w_compania           int,
    @w_oficial            smallint,
    @w_oficial_ant        smallint,
    @w_oficial_cia        smallint,
    @v_nombre             descripcion,
    @v_representante      int,
    @v_ruc                numero,
    @v_compania           int,
    @v_oficial            smallint,
    @v_oficial_ant        smallint,
    @o_grupo              int,
    @o_nombre             descripcion,
    @o_representante      int,
    @o_renombre           descripcion,
    @o_cedula             numero,
    @o_ruc                numero,
    @o_pasaporte          varchar(20),
    @o_compania           int,
    @o_oficial            smallint,
    @o_nombre_oficial     descripcion,
    @o_ccoficial          smallint,/* ADCC */
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime

  select
    @w_sp_name = 'sp_grupo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 107
    begin
      /* Verificar que exista el oficial */

      if not exists (select
                       1
                     from   cc_oficial
                     where  oc_oficial = @i_oficial)
         and @i_oficial is not null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101036
        /*'no existe oficial' */
        return 1
      end

      begin tran
      /* obtener un secuencial para el nuevo grupo */
      exec sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @i_tabla     = 'cl_grupo',
        @o_siguiente = @w_siguiente out

      /* insertar los datos de grupo */
      insert into cl_grupo
                  (gr_grupo,gr_nombre,gr_representante,gr_fecha_registro,
                   gr_fecha_modificacion,
                   gr_oficial,gr_ruc,gr_compania)
      values      (@w_siguiente,@i_nombre,@i_representante,@s_date,@s_date,
                   @i_oficial,@i_ruc,@i_compania)

      /* si no se puede insertar, error */
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103006
        /* 'Error en creacion de grupo'*/
        return 1

      end

      /* Transaccion servicio - cl_grupo */
      insert into ts_grupo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grupo,nombre,
                   representante,oficial,ruc,compania)
      values      (@s_ssn,107,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_siguiente,@i_nombre,
                   @i_representante,@i_oficial,@i_ruc,@i_compania)

      /* si no se puede insertar transaccion de servicio, error */
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end

      /* retornar el secuencial del grupo */
      select
        @w_siguiente
      commit tran
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /** Update **/
  if @i_operacion = 'U'
  begin
    /****** el representante no sera obligotorio
    if @i_representante = null
        select @i_representante = 0
    *******************************************/
    if @t_trn = 108
    begin
      /* Verificar que exista el grupo */
      select
        @w_nombre = gr_nombre,
        @w_representante = gr_representante,
        @w_ruc = gr_ruc,
        @w_oficial = gr_oficial /*******, ELCONI
                                     @w_compania       = gr_compania********/

      from   cl_grupo
      where  gr_grupo = @i_grupo

      /* Si no existen datos, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151029
        /*'No existe grupo'*/
        return 1
      end

    /* Verificar que exista el oficial */
      /*if not exists (select *
               from cl_funcionario
              where fu_funcionario = @i_oficial)
         and @i_oficial is not null*/

      if not exists (select
                       *
                     from   cc_oficial
                     where  oc_oficial = @i_oficial)
         and @i_oficial is not null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101036
        /*'no existe oficial' */
        return 1
      end

      /* Verificar que exista el representante */
      if @i_representante is not null
      begin
        select
          @w_codigo = null
        from   cl_ente
        where  en_ente = @i_representante
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101026
          /*'No existe representante legal'*/
          return 1
        end
      end

      /* guardar los datos anteriores que han cambiado */
      select
        @v_nombre = @w_nombre,
        @v_representante = @w_representante,
        /***       @v_ruc = @w_ruc,             ELCONI***************/
        @v_oficial = @w_oficial,
        @v_oficial_ant = @w_oficial

      if @w_nombre = @i_nombre
        select
          @w_nombre = null,
          @v_nombre = null
      else
        select
          @w_nombre = @i_nombre

      if @w_oficial = @i_oficial
        select
          @w_oficial = null,
          @v_oficial = null
      else
        select
          @w_oficial = @i_oficial

      if @w_representante = @i_representante
        select
          @w_representante = null,
          @v_representante = null
      else
        select
          @w_representante = @i_representante

      /********************* ELCONI    ***************************
          if @w_ruc = @i_ruc
          select @w_ruc = null, @v_ruc = null
          else
          begin
      
              /* Verificar que no exista otro grupo con igual
                 ruc */
              select @w_codigo = null
                from cl_grupo
               where gr_ruc = @i_ruc
      
              /* si no existe el grupo */
              if @@rowcount != 0 and @i_ruc is not null
                  begin
                     exec sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 101119
                  /*'ya existe ese grupo economico' */
                     return 1
                  end
      
              select @w_ruc = @i_ruc
          end
      *****************************************************************/
      begin tran

      /* modificar los datos anteriores */
      update cl_grupo
      set    gr_nombre = @i_nombre,
             gr_representante = @i_representante,
             gr_fecha_modificacion = @s_date,
             /******    gr_ruc = @i_ruc,     ELCONI   ********/
             gr_oficial = @i_oficial
      where  gr_grupo = @i_grupo

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        /* 'Error en actualizacion de grupo'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105007
        return 1
      end
    /***************************************************************
            Para hacer cambios de Oficial es por otra opcion,
            adicionalmente, una compania no puede ser grupo
            economico, entonces esta parte sobra
    ****************************************************************
          /* si el grupo es compania, modificar el oficial de compania */
          /****If @w_compania is not null and @w_oficial is not null
        ELCONI si el oficial es diferente se hacen cambios *********/
          If @w_oficial is not null
          begin
              /* capturar el oficial anterior de cia */
              select @w_oficial_cia = en_oficial
              from   cl_ente
              where  en_ente = @w_compania
    
              /* actualizar tabla de ejecutivos e historico */
              If exists( select * from cl_ejecutivo
                 where  ej_ente = @w_compania
                 and    ej_funcionario = @w_oficial_cia)
              begin
            insert into cl_his_ejecutivo( ej_ente,
                              ej_funcionario,
                              ej_toficial,
                              ej_fecha_asig,
                              ej_fecha_registro)
                         select   ej_ente,
                              ej_funcionario,
                              ej_toficial,
                              ej_fecha_asig,
                              @s_date
                           from   cl_ejecutivo
                          where   ej_ente = @w_compania
                        and   ej_funcionario = @w_oficial_cia
    
            if @@error != 0
                begin
                    exec sp_cerror  @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 101117
                    /*Error insercion historico ejecutivo */
                    return 1
                end
    
            delete cl_ejecutivo
            where  ej_ente = @w_compania
            and    ej_funcionario = @w_oficial_cia
            if @@rowcount != 1
                begin
                    exec sp_cerror  @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 101118
                    /* Error al eliminar ejecutivo */
                    return 1
                end
              end
              insert into cl_ejecutivo (ej_ente,
                        ej_funcionario,
                        ej_toficial,
                        ej_fecha_asig)
                      values   (@w_compania,
                        @i_oficial,
                        'G',
                        @s_date)
    
              if @@error != 0
                  begin
                      exec sp_cerror  @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 101116
                      /* Error en insercion de ejecutivo */
    
                      return 1
                  end
    
              update cl_ente
              set    en_oficial = @i_oficial
              where  en_ente = @w_compania
    
              /* si no se puede modificar, error */
              if @@rowcount = 0
              begin
             /* 'Error en actualizacion de grupo'*/
             exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 105006
             return 1
              end
          end
    
    /* entre estas lineas el algoritmo  de actualizacion del oficial de */
    /* los entes pertenecientes al grupo */
        if @i_oficial is not null and @w_oficial is not null
        begin
    
          /* modificar oficial a todos los entes integrantes de ese grupo*/
        if exists (select * from cl_cliente_grupo where cg_usuario = @s_user
                and cg_terminal = @s_term)
        begin
            delete cl_cliente_grupo
             where cg_usuario = @s_user
               and cg_terminal = @s_term
    
              if @@error != 0
              begin
             /* 'Error en actualizacion de grupo'*/
                 exec sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 105007
                 return 1
              end
        end
    
    
          insert into cl_cliente_grupo (cg_ente,cg_grupo,cg_oficial,
                    cg_usuario,cg_terminal)
    
          select en_ente,en_grupo,en_oficial,@s_user,@s_term
        from cl_ente
           where en_grupo = @i_grupo
         and en_oficial = @v_oficial_ant
    
          if @@error != 0
          begin
         /* 'Error en actualizacion de grupo'*/
         exec sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 105007
         return 1
          end
    
          select @w_num_cl_gr = count(*)
        from cl_cliente_grupo
           where cg_usuario = @s_user
         and cg_terminal = @s_term
    
        if @w_num_cl_gr > 0
        begin
            select @w_contador = 1
            while @w_contador <= @w_num_cl_gr
            begin
                set rowcount 1
                select  @w_oficial_ant = cg_oficial,
                    @w_ente = cg_ente
                  from  cl_cliente_grupo
                 where  cg_usuario = @s_user
                   and  cg_terminal = @s_term
    
                /* Si cambia de oficial o se le asigna oficial */
                if @w_oficial_ant != @i_oficial
                begin
                    /* Si ya tenia oficial */
                    if @w_oficial_ant is not null
                    begin
                        insert into cl_his_ejecutivo
                            (ej_ente,
                                ej_funcionario,
                            ej_toficial,
                            ej_fecha_asig,
                            ej_fecha_registro)
                        select ej_ente,
                               ej_funcionario,
                               ej_toficial,
                               ej_fecha_asig,
                               @s_date
                          from cl_ejecutivo
                         where ej_ente = @w_ente
                           and ej_funcionario = @w_oficial_ant
    
    
                        if @@error != 0
                        begin
                            exec sp_cerror
                                @t_debug = @t_debug,
                                @t_file  = @t_file,
                                @t_from  = @w_sp_name,
                                @i_num   = 101117
                        /* 'Error en insercion a historico'*/
                        /* 'de ejecutivo'*/
                            return 1
                        end
    
                        delete cl_ejecutivo
                         where ej_ente = @w_ente
                           and ej_funcionario = @w_oficial_ant
    
                        if @@rowcount != 1
                        begin
                            exec sp_cerror
                                @t_debug = @t_debug,
                                @t_file  = @t_file,
                                @t_from  = @w_sp_name,
                                @i_num   = 101118
                        /* 'Error al eliminar ejecutivo'*/
                            return 1
                        end
                    end
    
                    insert into cl_ejecutivo(ej_ente,
                                 ej_funcionario,
                                 ej_toficial,
                                 ej_fecha_asig)
                              values(@w_ente,
                                 @i_oficial,
                                 'G',
                                 @s_date)
    
                    if @@error != 0
                    begin
                        exec sp_cerror
                            @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      = 101116
                    /* 'Error en insercion de ejecutivo del ente'*/
                        return 1
    
                    end
    
                end
    
                delete cl_cliente_grupo
                 where cg_ente = @w_ente
                   and cg_usuario = @s_user
                   and cg_terminal = @s_term
    
                set rowcount 0
                select @w_contador = @w_contador + 1
            continue
            end  /* fin del lazo que procesa cada ente del grupo */
    
            /* Actualizo el oficial de todos los miembros del grupo */
            /* JAN MAY/01 Comentado por Pol¡tica de Banco de no modificar el oficial a los miembros del grupo
            update cl_ente
               set en_oficial = @i_oficial
             where en_grupo = @i_grupo
               and en_oficial = @v_oficial_ant
    
            if @@error != 0
            begin
                 /* 'Error en actualizacion de grupo'*/
                 exec sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 105007
                 return 1
            end
            */
    
        end     /* fin de la pregunta @w_num_nl_gr > 0 */
       end   /* fin de la pregunta @i_oficial is not null */
    
    /* entre estas lineas el algoritmo  de actualizacion del oficial de */
    /* los entes pertenecientes al grupo */
    ********************************************************
    ************* Esta parte se comentario puesto que ya no se
    ************* utiliza de esta forma *******************/
      /* Transaccion servicio - cl_grupo */
      insert into ts_grupo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grupo,nombre,
                   representante,oficial,ruc)
      values      (@s_ssn,108,'P',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_grupo,@v_nombre,
                   @v_representante,@v_oficial,@v_ruc)

      /* si no se puede insertar, error */
      if @@error != 0
      begin
        /* 'Error en creacion de transaccion de servicio'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end

      /* Transaccion servicio - cl_grupo */
      insert into ts_grupo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grupo,nombre,
                   representante,ruc,oficial)
      values      (@s_ssn,108,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_grupo,@w_nombre,
                   @w_representante,@w_ruc,@w_oficial)

      /* si no se puede insertar, error */
      if @@error != 0
      begin
        /* 'Error en creacion de transaccion de servicio'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end

      commit tran
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /** Query **/
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1184
    begin
      select
        @o_grupo = gr_grupo,
        @o_nombre = gr_nombre,
        @o_ccoficial = gr_oficial,
        @o_representante = gr_representante,
        @o_renombre = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' +
                      rtrim(
                      en_nombre),
        @o_cedula = en_ced_ruc,
        @o_fecha_registro = gr_fecha_registro,
        @o_fecha_modificacion = gr_fecha_modificacion
      /*****,
                @o_pasaporte=p_pasaporte  **********/
      from   cl_grupo
             left outer join cl_ente
                          on gr_representante = en_ente
      where  gr_grupo = @i_grupo

      /* from    cl_grupo,
           cl_ente    --, cl_cliente_grupo
          where  gr_grupo = @i_grupo
        and  gr_representante *= en_ente*/

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
      if @o_ccoficial is not null
      begin
        select
          @o_oficial = fu_funcionario,
          @o_nombre_oficial = convert(char(30), fu_nombre),
          @o_oficial = fu_funcionario
        from   cc_oficial,
               cl_funcionario
        where  @o_ccoficial   = oc_oficial
           and oc_funcionario = fu_funcionario
      end
      else
      begin
        select
          @o_nombre_oficial = null,
          @o_oficial = null

      end

      /* retornar los datos seleccionados */
      select
        'Grupo            ' = @o_grupo,
        'Nombre           ' = @o_nombre,
        /*********   'NIT' = @o_ruc,
            'Compania' = @o_compania, *******ELCONI *****/
        'Gerente          ' = @o_oficial,
        'Nombre del Gerente   ' = @o_nombre_oficial,
        'Cod. Repr.       ' = @o_representante,
        'Nombre del Representante ' = @o_renombre,
        'D.I.         ' = @o_cedula,
        'Fecha Reg.       ' = convert(varchar(10), @o_fecha_registro, 101),
        --MZS011
        'Fecha Modif.     ' =convert(varchar(10), @o_fecha_modificacion, 101)
      --MZS011
      /*****, 'Pasaporte '= @o_pasaporte ********/

      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

/** Search **/
  /* consultar todos los grupos registrados, de 20 en 20 */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1191
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Codigo Grupo' = gr_grupo,
          'Nombre' = gr_nombre,
          'Representante' = gr_representante,
          'Nombre Rep' = (p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre),
          'Ejecutivo de Cuenta' = gr_oficial,
          'Nombre del Ejecutivo' = convert(char(30), fu_nombre),
          'Compania' = gr_compania
        from   cl_ente,
               cl_grupo
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_representante = en_ente
           and gr_grupo         > 0

      /* from cl_grupo, cl_ente, cl_funcionario
      where gr_representante = en_ente
        and gr_oficial *= fu_funcionario
        and gr_grupo > 0*/

      if @i_modo = 1
        select
          'Codigo Grupo' = gr_grupo,
          'Nombre' = gr_nombre,
          'Representante' = gr_representante,
          'Nombre Rep' = (p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre),
          'Ejecutivo de Cuenta' = gr_oficial,
          'Nombre del Ejecutivo' = convert(char(30), fu_nombre),
          'Compania' = gr_compania
        from   cl_ente,
               cl_grupo
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_representante = en_ente
           and gr_grupo         > @i_grupo

      /*from cl_grupo, cl_ente, cl_funcionario
      where gr_representante = en_ente
       and gr_oficial *= fu_funcionario
       and gr_grupo > @i_grupo*/

      set rowcount 0
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  if @i_operacion = 'H'
  /* Query especifico */
  begin
    if @t_trn = 1238
    begin
      /* si el ente es persona, retorna el grupo para el que trabaja
      se es compania, retorna el grupo al que pertenece */
      if @i_tipo = 'A'
      begin
        select
          @w_tipo = en_subtipo
        from   cl_ente
        where  en_ente = @i_ente

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end

        if @w_tipo = 'P'
        begin
          select
            gr_grupo,
            substring(gr_nombre,
                      1,
                      20)
          from   cl_grupo,
                 cl_compania,
                 cl_trabajo
          where  tr_persona = @i_ente
             and tr_empresa = compania
             and grupo      = gr_grupo

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
          return 0
        end

        if @w_tipo = 'C'
        begin
          select
            gr_grupo,
            substring(gr_nombre,
                      1,
                      20)
          from   cl_grupo,
                 cl_compania
          where  compania = @i_ente
             and grupo    = gr_grupo
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
          return 0
        end
      end

      /* Dado el ente y el grupo:
      si el ente es persona, retorna el grupo si persona trabaja en el grupo
      se es compania, retorna el grupo si la compania pertenece al grupo*/
      if @i_tipo = 'V'
      begin
        select
          @w_tipo = en_subtipo
        from   cl_ente
        where  en_ente = @i_ente
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end

        if @w_tipo = 'P'
        begin
          select
            substring(gr_nombre,
                      1,
                      20)
          from   cl_grupo,
                 cl_compania,
                 cl_trabajo
          where  tr_persona = @i_ente
             and tr_empresa = compania
             and grupo      = @i_grupo
             and grupo      = gr_grupo
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
          return 0
        end

        if @w_tipo = 'C'
        begin
          select
            substring(gr_nombre,
                      1,
                      20)
          from   cl_grupo,
                 cl_compania
          where  compania = @i_ente
             and grupo    = @i_grupo
             and grupo    = gr_grupo
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 1
          end
          return 0
        end
      end

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

go

