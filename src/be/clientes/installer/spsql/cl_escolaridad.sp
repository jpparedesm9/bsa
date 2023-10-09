/***********************************************************************/
/*     Archivo:                   cl_escolaridad.sp                    */
/*     Stored procedure:          sp_escolaridad                       */
/*     Base de Datos:             cobis                                */
/*     Producto:                  Clientes                             */
/*     Disenado por:              Edwin Rodriguez                      */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                         PROPOSITO                                   */
/*     Generar procedimiento de Creacion, Actualizacion y Consulta     */
/*     para detalles de Escolaridad                                    */
/***********************************************************************/
/*                    MODIFICACIONES                                   */
/*     FECHA          AUTOR               RAZON                        */
/*     22/Nov/2012    Edwin Rodriguez     Emision inicial              */
/*     02/May/2016    DFu                 Migracion CEN                */
/***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_escolaridad')
  drop proc sp_escolaridad
go

create proc sp_escolaridad
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         descripcion = null,
  @s_ofi          smallint = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_sesn         int = null,
  @t_rty          char(1) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_cliente      int = null,
  @i_edad         tinyint = null,
  @i_niv_edu      tinyint = null,
  @i_hijos        tinyint = null,
  @i_operacion    char(1) = null,
  @i_indice       smallint = 0,
  @i_ant_des      char(1) = null,
  @i_secuencial   int = 0,
  @i_modo         smallint = null
)
as
  declare
    /*Secci¢n de Variable s de Trabajo*/
    @w_existe       char(1),/* CARACTER QUE VALIDA LA EXISTENCIA*/
    @w_return       int,/* VALOR QUE RETORNA       */
    @w_sp_name      varchar(32),/* NOMBRE STORED PROCEDURE */
    @w_msg          varchar(200),
    @w_fecha_modif  datetime,
    @w_borrado      smallint,
    @w_hijos_actual smallint,
    @w_hijos_escola smallint

  select
    @w_sp_name = 'sp_escolaridad'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_modif = getdate()

  if exists (select
               1
             from   cl_educa_hijos
             where  eh_cliente = @i_cliente)
  begin
    select
      @w_existe = 'S'
  end
  else
  begin
    select
      @w_existe = 'N'
  end

  if @i_operacion = 'I'
  begin
    if @t_trn <> 1603
    begin
      select
        @w_return = 101183,
        @w_msg =
      'NO CORRESPONDE CODIGO DE TRANSACCION DE INSERCION DE ESCOLARIDAD'
      goto ERROR_FIN
    end

    exec @w_return = sp_escolaridad_log
      @s_user        = @s_user,
      @i_cliente     = @i_cliente,
      @i_edad        = @i_edad,
      @i_niv_edu     = @i_niv_edu,
      @i_hijos       = @i_hijos,
      @i_secuencial  = @i_indice,
      @i_fecha_modif = @w_fecha_modif

    insert into cobis..cl_educa_hijos
                (eh_secuencial,eh_cliente,eh_edad,eh_niv_edu,eh_hijos,
                 eh_fecha_modif)
    values      ( @i_indice,@i_cliente,@i_edad,@i_niv_edu,@i_hijos,
                  @w_fecha_modif )

    if @@error <> 0
    begin
      select
        @w_return = 103111
      goto ERROR_FIN /* Error al ingresar el registro en Escolaridad */
    end

    if @w_borrado > 0
    begin
      commit tran
    end
  end

  if @i_operacion = 'U'
  begin
    if @t_trn <> 1604
    begin
      select
        @w_return = 101183,
        @w_msg =
      'NO CORRESPONDE CODIGO DE TRANSACCION DE MODIFICACION DE ESCOLARIDAD'
      goto ERROR_FIN
    end
    else
    begin
      if @i_indice = 99
      begin
        begin tran
        select
          @w_borrado = 0
        delete from cobis..cl_educa_hijos
        where  eh_cliente = @i_cliente

        select
          @w_borrado = @@rowcount
      end

      --if isnull(@i_hijos,0) > 0
      exec @w_return = sp_escolaridad_log
        @s_user        = @s_user,
        @i_cliente     = @i_cliente,
        @i_edad        = @i_edad,
        @i_niv_edu     = @i_niv_edu,
        @i_hijos       = @i_hijos,
        @i_secuencial  = @i_indice,
        @i_fecha_modif = @w_fecha_modif

      if @i_indice <> 99
      begin
        if @i_hijos = 0
        begin
          delete cobis..cl_educa_hijos
          where  eh_cliente    = @i_cliente
             and eh_secuencial = @i_indice
        end
        else
        begin
          if not exists (select
                           1
                         from   cl_educa_hijos
                         where  eh_cliente    = @i_cliente
                            and eh_secuencial = @i_indice)
          begin
            insert into cobis..cl_educa_hijos
                        (eh_secuencial,eh_cliente,eh_edad,eh_niv_edu,eh_hijos,
                         eh_fecha_modif)
            values      ( @i_indice,@i_cliente,@i_edad,@i_niv_edu,@i_hijos,
                          @w_fecha_modif )

            if @@error <> 0
            begin
              select
                @w_return = 103111
              goto ERROR_FIN /* Error al ingresar el registro en Escolaridad */
            end
          end
          else
          begin
            update cobis..cl_educa_hijos
            set    eh_edad = @i_edad,
                   eh_niv_edu = @i_niv_edu,
                   eh_hijos = @i_hijos,
                   eh_fecha_modif = @w_fecha_modif
            where  eh_cliente    = @i_cliente
               and eh_secuencial = @i_indice

            if @@error <> 0
            begin
              if @w_borrado > 0
                rollback tran
              select
                @w_return = 103112
              goto ERROR_FIN /* Error al Modificar el registro en Escolaridad */
            end
          end
        end
      end

      if @w_borrado > 0
      begin
        commit tran
      end
    end
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn <> 1605
    begin
      select
        @w_return = 101183,
        @w_msg =
      'NO CORRESPONDE CODIGO DE TRANSACCION DE CONSULTA DE ESCOLARIDAD'
      goto ERROR_FIN
    end
    else
    begin
      if @i_modo = 0
      begin
        select
          @w_hijos_actual = isnull(p_num_hijos,
                                   0)
        from   cobis..cl_ente
        where  en_ente = @i_cliente

        select
          @w_hijos_escola = isnull(sum(eh_hijos),
                                   0)
        from   cobis..cl_educa_hijos
        where  eh_cliente = @i_cliente

        if @w_hijos_actual <> @w_hijos_escola
        begin
          print
'La sumatoria de datos ingresados, no corresponde con el Numero de Hijos registrado'
  select
    @w_return = 103113
  goto ERROR_FIN
  select
    1
end
else
  select
    0
end
  if @i_modo = 1
  begin
    select
      eh_edad,
      eh_niv_edu,
      eh_hijos
    from   cobis..cl_educa_hijos
    where  eh_cliente = @i_cliente

    if @@error <> 0
    begin
      select
        @w_return = 103113
      goto ERROR_FIN /* Error al Consultar el registro en Escolaridad */
    end
  end
end
end

  return 0

  ERROR_FIN:
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_return,
    @i_msg   = @w_msg

  return 1

go

