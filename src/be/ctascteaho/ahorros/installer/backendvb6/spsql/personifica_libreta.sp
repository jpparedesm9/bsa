/************************************************************************/
/*  Archivo:            personifica_libreta.sp                          */
/*  Stored procedure:   sp_personifica_libreta                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 25-Feb-1993                                     */
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
/*  Este programa personifica la libreta, imprime la cuenta, nombre,    */
/*  e identicacion del cliente                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  04/Oct/1995   V. Mafla    Emision inicial                           */
/*  21/Nov/1998   A Machado   Adicion del parametro @o_ssn              */
/*  02/May/2016   Juan Tagle  Migración a CEN                           */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_personifica_libreta')
    drop proc sp_personifica_libreta
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_personifica_libreta (
    @s_ssn          int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int = null,
    @s_term         varchar(10),
    @s_ofi          smallint,
    @s_rol          smallint,
    @s_org          char(1),
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(30) = null,
    @t_trn          int,
    @t_show_version bit = 0,
    @i_cta_banco    cuenta,
    @i_moneda       tinyint,
    @o_nombre       varchar(64)=null  out,
    @o_identifica   varchar(15)=null  out,
    @o_nombre2      varchar(30)=null out,
    @o_identifica2  varchar(15)=null out,
    @o_ssn          int = null out
)
as
declare @w_return       int,
        @w_sp_name      varchar(30),
        @w_contador     smallint,
        @w_secuencial   int,
        @w_clave        int

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_personifica_libreta'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @o_ssn = @s_ssn

/*  Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
        t_file      = @t_file,
        t_from      = @t_from,
        i_cta_banco = @i_cta_banco
    exec cobis..sp_end_debug
end


/* lee tabla de ctas de ahorros */

select  @o_nombre        = substring(ah_nombre,1,64),
    @o_identifica    = ah_ced_ruc,
        @o_nombre2       = substring(ah_nombre1,1,30),
        @o_identifica2   = ah_cedruc1
from cob_ahorros..ah_cuenta
where ah_cta_banco = @i_cta_banco
  and ah_moneda = @i_moneda

 if @@rowcount = 0
                begin
                  exec cobis..sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 201004
                    /* 'No existe perfil'*/
                  return 1
                end
return 0

go

