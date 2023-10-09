/************************************************************************/
/*    Archivo:             cl_metricas_funcionales.sp                   */
/*    Stored procedure:    sp_cl_metricas_funcionales                   */
/*    Base de datos:       cobis                                        */
/*    Producto:            MIS                                          */
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
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cl_metricas_funcionales')
  drop proc sp_cl_metricas_funcionales
go

create proc sp_cl_metricas_funcionales
(
  @t_show_version bit = 0,
  @i_oficina      smallint,
  @i_data         char(1)
)
as
  declare @w_sp_name char(30)

  select
    @w_sp_name = 'sp_cl_metricas_funcionales'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  begin tran

  truncate table cl_metricas_clientes

  if @@error <> 0
  begin
    print 'Error al vaciar datos de la tabla temporal'
    rollback
  end

  delete from MIGRACION..co_metricas_clientes
  where  mc_oficina = @i_oficina

  if @@error <> 0
  begin
    print 'Error al vaciar datos de la tabla MIGRACION..co_metricas_clientes'
    rollback
  end

  insert into cl_metricas_clientes
    select
      'OFICINA' = en_oficina,'TIPO PERSONA' = en_subtipo,
      'TIPO DOCUMENTO' = en_tipo_ced,'IDENTIFICACION' = substring(en_ced_ruc,
                                   1,
                                   14),'NOMBRE' = substring(ltrim(rtrim((
                                                            en_nombre + ' ' +
                                                            p_p_apellido + ' ' +
                                                            p_s_apellido)
                                                                  )),
                           1,
                           60),
      'DIRECCION NEG.' = isnull(substring(di_descripcion,
                                          1,
                                          80),
                                ''),'BARRIO' = isnull((select
                           pq_descripcion
                         from   cobis..cl_parroquia
                         where  pq_parroquia = d.di_parroquia)
                        + '-'
                        + (select
                             convert(varchar(10), pq_ciudad)
                           from   cobis..cl_parroquia
                           where  pq_parroquia = d.di_parroquia),
                        ''),'ACTIVIDAD' = isnull(substring((en_actividad + '-'
                                      + (select
                                           valor
                                         from   cobis..cl_catalogo
                                         where  tabla in
                                                (select
                                                   codigo
                                                 from   cobis..cl_tabla
                                                 where  tabla = 'cl_actividad')
                                                and codigo = e.en_actividad)),
                                     1,
                                     50),
                           ''),'SEXO' = p_sexo,'FECHA NACIMIENTO'=
                                               isnull(
      convert(char(10), p_fecha_nac, 101),
                                 '01/01/1900'),
      'ESTADO CIVIL' = isnull(substring((p_estado_civil + '-'
                                         + (select
                                              valor
                                            from   cobis..cl_catalogo
                                            where  tabla in
                                                   (select
                                                      codigo
                                                    from   cobis..cl_tabla
                                                    where  tabla = 'cl_ecivil')
                                                   and codigo =
                              e.p_estado_civil)),
                                        1,
                                        30),
                              ''),'TIPO VINCULACION'= isnull(
                                  substring((en_tipo_vinculacion + '-'
                                            + (select
                                                 valor
                                               from   cobis..cl_catalogo
                                               where  tabla in
                                  (select
                                     codigo
                                   from   cobis..cl_tabla
                                   where  tabla = 'cl_tipo_vinculo')
                                  and codigo = e.en_tipo_vinculacion)),
                                           1,
                                           30),
                                 ''),'ESTRATO' = isnull(en_estrato,
                         ''),'DATA' = @i_data
    from   cobis..cl_ente e,
           cobis..cl_mig_ente,
           mig_cartera..ca_migracion_oficina
           left outer join cobis..cl_direccion d
                        on en_ente = di_ente
    where  di_tipo        = '011'
       and me_codigo_ente = en_ente
       and en_oficina     = @i_oficina
       and en_oficina     = mi_oficina
       and mi_estado      = 'R'

  if @@error <> 0
  begin
    print 'Error al insertar datos de la oficina ' + convert(varchar, @i_oficina
          )
    rollback
  end

  insert into MIGRACION..co_metricas_clientes with (rowlock)
    select
      *
    from   cobis..cl_metricas_clientes

  if @@error <> 0
  begin
    print 'Error al insertar en tabla metricas consolidada'
    rollback
  end

  commit tran

  return 0

go

