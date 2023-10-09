/************************************************************************/
/*    Archivo:              perinsloc.sp                                */
/*    Stored procedure:     sp_persona_ins_local                        */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Oscar Saavedra                              */
/*    Fecha de escritura:   07-Nov-2013                                 */
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
/*  Este stored procedure procesa:                                      */
/*  Insercion de datos g@ierales de persona @i la tabla cl_@ite         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA        AUTOR           RAZON                                */
/*  07/Nov/13   O. Saavedra   Emision Inicial                           */
/*  02/May/16   T. Baidal             Migracion CEN                     */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_persona_ins_local')
   drop proc sp_persona_ins_local
go

create proc sp_persona_ins_local (
@s_ssn                  int            = null,
@s_user                 login          = null,
@s_term                 varchar(30)    = null,
@s_date                 datetime       = null,
@s_srv                  varchar(30)    = null,
@s_lsrv                 varchar(30)    = null,
@s_ofi                  smallint       = null,
@s_rol                  smallint       = null,
@s_org_err              char(1)        = null,
@s_error                int            = null,
@s_sev                  tinyint        = null,
@s_msg                  descripcion    = null,
@s_org                  char(1)        = null,
@t_debug                char(1)        = 'N',
@t_file                 varchar(10)    = null,
@t_from                 varchar(32)    = null,
@t_trn                  smallint       = null,
@t_show_version         bit            = 0,
@i_ente                 int            = null,
@i_nombre               varchar(64)    = null,
@i_tipo                 catalogo       = null,
@i_subtipo              char(1)        = null,
@i_filial               tinyint        = null,
@i_oficina              smallint       = null,
@i_ced_ruc              varchar(30)    = null,
@i_fecha_crea           datetime       = null,
@i_retencion            char(1)        = 'S',
@i_tipo_ced             char(2)        = null,
@i_p_apellido           varchar(16)    = null,
@i_s_apellido           varchar(16)    = null,
@i_sexo                 char(1)        = null,
@i_fecha_nac            datetime       = null,
@i_pasaporte            varchar(20)    = null,
@i_asosciada            varchar(10)    = null,
@i_accion               varchar(10)    = null,
@o_crea                 char(1)        = 'S' out
)
as
declare
@w_today                datetime,
@w_sp_name              varchar(32),
@w_return               int,
@w_msg                  varchar(254),
@w_nombre               varchar(32),
@w_p_apellido           varchar(16),
@w_s_apellido           varchar(16),
@w_ofi_func             int,
@w_tip_func             varchar(10),
@w_ofi_prod             int,
@w_retencion            char(1),
@w_error                int, 
@w_rowcount             int

select @w_sp_name = 'sp_persona_ins_local'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
  return 0
end

select @w_today         = getdate()
select @w_sp_name       = 'sp_persona_ins_local'
select @w_nombre        = @i_nombre
select @w_p_apellido    = ltrim(rtrim(@i_p_apellido)) 
select @w_s_apellido    = ltrim(rtrim(isnull(@i_s_apellido,' ')))

select @o_crea	

return 0

go

