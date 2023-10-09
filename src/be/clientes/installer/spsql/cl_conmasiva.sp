/************************************************************************/
/*    Archivo:              cl_conmasiva.sp                             */
/*    Stored procedure:     sp_consulta_masiva                          */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Giovanni White                              */
/*    Fecha de escritura:   19-Mar-2003                                 */
/************************************************************************/
/*                IMPORTANTE                                            */
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
/*                PROPOSITO                                             */
/*    Consulta en Linea Masiva Centralizada                             */
/*    Este programa hace la consulta de los clientes que tienen         */
/*    productos bancarios y envia el resultado al FrontEnd Clientes     */
/*    especificamente a la forma FconMasiva.frm                         */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*      FECHA       AUTOR              RAZON                            */
/*      19/Mar/03   Giovanni White     Emision Inicial                  */
/*      19/Sep/03   Diego Duran        Agrego Opcion Siguiente          */
/*      04/Mar/05   Diego Duran        Optimizacion consulta siguiente  */
/*      02/May/16   DFu                Migracion CEN                    */
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
           where  name = 'sp_consulta_masiva')
  drop proc sp_consulta_masiva
go

create proc sp_consulta_masiva
(
  @s_ssn          int,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime,
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
  @i_cedruc       numero = null,
  @i_cuenta       cuenta = null,
  @i_accion       char(1) = null,
  @i_archivo      varchar(50)
)
as
  declare
    @w_sp_name varchar(32),
    @w_codigo  int,
    @w_return  int

  select
    @w_sp_name = 'sp_consulta_masiva'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'S'
  begin
    if @t_trn = 1102
    begin
      if @i_accion = 'A'
      begin
        set rowcount 20

        select distinct
          'CODIGO' = convert(char(12), cm_ente),
          'IDENTIF.' = cm_ced_ruc,
          'TIPO DOC' = cm_tipo_ced,
          'N O M B R E' = cm_nomlar,
          'CUENTA NRO' = cm_cuenta,
          'ENCONTRADO' = cm_encontrado,
          'OFICINA' = convert(char(10), cm_oficina),
          -- 'SALDO'        = convert(char(20),cm_saldo),
          'ESTADO SER' = cm_estado_ser,
          'FECHA CAMBIO' = convert(char(10), cm_fecha_cambio, 101),
          'FECHA' = convert(char(10), cm_fecha, 101)
        from   cl_consulta_masiva
        where  cm_archivo = @i_archivo
        order  by cm_ced_ruc,
                  cm_cuenta

        if @@rowcount = 0
        begin
          /* No existe dato solicitado */
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001

          return 1
        end
      end
      ----dfd
      if @i_accion = 'B'
      begin
        set rowcount 20

        select distinct
          'CODIGO' = convert(char(12), cm_ente),
          'IDENTIF.' = cm_ced_ruc,
          'TIPO DOC' = cm_tipo_ced,
          'N O M B R E' = cm_nomlar,
          'CUENTA NRO' = cm_cuenta,
          'ENCONTRADO' = cm_encontrado,
          'OFICINA' = convert(char(10), cm_oficina),
          --  'SALDO'        = convert(char(20),cm_saldo),
          'ESTADO SER' = cm_estado_ser,
          'FECHA CAMBIO' = convert(char(10), cm_fecha_cambio, 101),
          'FECHA' = convert(char(10), cm_fecha, 101)
        from   cl_consulta_masiva
        where  cm_archivo = @i_archivo
           and ((cm_ced_ruc >= @i_cedruc
                 and cm_cuenta  > @i_cuenta)
                 or (cm_ced_ruc > @i_cedruc))
        order  by cm_ced_ruc,
                  cm_cuenta

        if @@rowcount = 0
        begin
          /* No existe dato solicitado */
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001

          return 1
        end

        set rowcount 0
      end

    end
    else
    begin
      -- No corresponde codigo de transaccion
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051

      return 1
    end

  end
  --else
  --return 1

  return 0

go

