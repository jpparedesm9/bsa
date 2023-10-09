/************************************************************************/
/*  Archivo         :       evaobs.sp                                   */
/*  Stored procedure    :   sp_evaluar_obsequio                         */
/*  Base de datos       :   cobis                                       */
/*  Producto            :   Clientes                                    */
/*  Disenado por        :   Santiago Alban                              */
/*  Fecha de escritura  :   01/10/2008                                  */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*      Insercion, Borrado, Modificacion de las caracterisiticas        */
/*  que cumplen para entregar obsequios por cliente                     */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  01/10/2008    FSAP        EmisionInicial                            */
/*  04/28/2009    ELA         Correccion caso 186                       */
/*  04/May/2016   T. Baidal   Migracion a CEN                           */
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
           where  name = 'sp_evaluar_obsequio') 
           drop proc sp_evaluar_obsequio
go

create proc sp_evaluar_obsequio
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
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_contrato     int = null,--Long
  @i_reservado    int = null,--long
  @i_tipo_cta     char(2) = null,
  @i_fecha_ini    datetime = null,
  @i_fecha_fin    datetime = null,
  @i_en_ced_ruc   int = null,--long
  @i_tipo_id      char(2) = null,
  @i_nombre       varchar(65) = null,
  @i_apellidos    varchar(65) = null,
  @i_correo       varchar(30) = null,
  @i_telefono     varchar(12) = null,
  @i_ciudad       int = null,
  @i_ente         int = null,
  @i_modo         int = null,
  @i_obsequio     int = null,
  @o_msg          varchar(30) = null
)
as
  declare
    @w_sp_name    varchar(32),
    @w_return     int,
    @w_cod_carct  smallint,
    @w_obsequio   smallint,
    @w_estado     char(1),
    @w_contrato   int,--Long
    @w_reservado  int,--long
    @w_tipo_cta   char(2),
    @w_fecha_ini  datetime,
    @w_fecha_fin  datetime,
    @w_en_ced_ruc int,--long
    @w_tipo_id    char(2),
    @w_nombre     varchar(65),
    @w_apellidos  varchar(65),
    @w_correo     varchar(30),
    @w_telefono   varchar(12),
    @w_ciudad     int,
    @w_error      int

  select
    @w_sp_name = 'sp_evaluar_obsequio'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha_ini = getdate()
  select
    @i_fecha_fin = getdate(),
    @w_error = 0

  /*EVALUAR OBSEQUIO PARA ENTREGA*/
  if @i_operacion = 'E'
  begin
    exec @w_error = sp_verifica_entrega_obsequio
      @i_ente     = @i_ente,
      @i_obsequio = @i_obsequio,
      @i_debug    = @t_debug,
      @o_msg      = @o_msg output
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1014
    begin
      set rowcount 1
      select
        @w_contrato = en_ente,
        @w_reservado = 0,
        @w_en_ced_ruc = en_ced_ruc,
        @w_tipo_id = en_tipo_ced,
        @w_nombre = en_nombre,
        @w_apellidos = (p_p_apellido + ' ' + p_s_apellido),
        @w_telefono = te_valor
      from   cobis..cl_ente,
             cl_telefono
      where  en_ente = te_ente
         and en_ente = @i_ente

      if exists (select
                   1
                 from   cl_obseq_entrega
                 where  oe_en_ced_ruc = @w_en_ced_ruc
                    and oe_obsequio   = @i_obsequio)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @s_msg   = 'OBSEQUIO YA ENTREGADO AL CLIENTE ACTUAL',
          @i_num   = 101186

        /*  'Registro ya existe' */
        return 101186

      end

      if exists (select
                   1
                 from   cl_ente
                 where  en_ente = @i_ente)
      begin
        select
          @w_correo = di_descripcion,
          @w_ciudad = di_ciudad
        from   cobis..cl_direccion
        where  di_tipo = '001'
           and di_ente = @i_ente

        if @w_ciudad is null
          select
            @w_ciudad = '10000'

        /* insertar los datos */
        insert into cl_obseq_entrega
                    (oe_contrato,oe_reservado,oe_tipo_cta,oe_fecha_ini,
                     oe_fecha_fin,
                     oe_en_ced_ruc,oe_tipo_id,oe_nombre,oe_apellidos,oe_correo,
                     oe_telefono,oe_ciudad,oe_obsequio)
        values      (@w_contrato,@w_reservado,'CR',--@w_tipo_cta,
                     @i_fecha_ini,@i_fecha_fin,
                     @w_en_ced_ruc,@w_tipo_id,@w_nombre,@w_apellidos,@w_correo,
                     @w_telefono,@w_ciudad,@i_obsequio)

        /* si no se puede insertar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103084
          /* 'Error en creacion de otros ingresos'*/
          return 1
        end
        set rowcount 0
      end--ente
    end --trx
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
  if @i_operacion = 'S'
  begin
    if @t_trn = 1014
    begin
      if @i_modo = 0
      begin
        select
          'Codigo Caracteristica             ' = cc_descripcion,
          'Cumple (S/N)                      ' = ''
        from   cl_obsequio_caract,
               cr_caract_cli_prod
        where  oc_obsequio   = @i_obsequio
           and cc_cod_caract = oc_cod_caract
        order  by oc_cod_caract,
                  oc_obsequio
      end

      /*if @i_modo = 1
      begin
        select 'Nombre' = (en_nombre + ' ' + p_p_apellido + ' '+ p_s_apellido)
        from cobis..cl_ente
        where en_ente = @i_ente
      
        /*if @@_error <> 0
        begin
           print 'Cliente no existe'
          return 1
         end*/
      end*/

      if @i_modo = 2
      begin
        select
          'Contrato      ' = oe_contrato,
          'Obsequio      ' = (select
                                valor
                              from   cobis..cl_tabla A,
                                     cl_catalogo B
                              where  A.tabla  = 'cl_obsequios'
                                 and A.codigo = B.tabla
                                 and B.codigo = C.oe_obsequio),
          'Fecha entrega ' = oe_fecha_fin,
          'Cedula        ' = oe_en_ced_ruc,
          'Nombre        ' = oe_nombre,
          'Apellidos     ' = oe_apellidos,
          'Correo       ' = oe_correo
        from   cl_obseq_entrega C
        where  oe_contrato = @i_ente
      end
    end
  end
  return 0

go

