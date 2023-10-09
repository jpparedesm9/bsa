/************************************************************************/
/*  Archivo:            rev_tranmon.sp                                  */
/*  Stored procedure:   sp_rev_tran_monet                               */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           ahorros                                         */
/*  Disenado por:       Eduardo Williams                                */
/*  Fecha de escritura: 02-Ago-2016                                     */
/************************************************************************/
/*                        IMPORTANTE                                    */
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
/*                          PROPOSITO                                   */
/*  Este programa consulta las transacciones monetarias de cuentas de   */
/*  ahorros para reversos                                               */
/************************************************************************/
/*                        MODIFICACIONES                                */
/************************************************************************/
/*     FECHA     AUTOR              RAZON                               */
/* 02/Ago/2016   Eduardo Williams   Emision inicial AHO-H79808          */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rev_tran_monet')
   drop proc sp_rev_tran_monet
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_rev_tran_monet
(
 @s_ssn            int           = null,
 @s_srv            varchar(30)   = null,
 @s_user           varchar(30)   = null,
 @s_date           datetime      = null,
 @s_ofi            smallint      = null,
 @s_rol            smallint      = null,
 @t_trn            int           = null,
 @t_debug          char(1)       = 'N',
 @t_file           varchar(14)   = null,
 @t_from           varchar(32)   = null,
 @t_show_version   bit           = 0,
 @i_filial         tinyint       = 1,
 @i_oficina        smallint      = null,
 @i_mon            smallint      = 0,
 @i_usuario        varchar(30)   = null,
 @i_cta            cuenta        = null,
 @i_tran           int           = null,
 @i_secuencial     int           = 0,
 @i_cod_alterno    int           = -1,
 @i_sec_ini        int           = null,
 @i_sec_fin        int           = null,
 @i_val_ini        money         = null,
 @i_val_fin        money         = null,
 @i_formato        smallint      = 101,
 @i_hora_ini       varchar(5)    = null,
 @i_hora_fin       varchar(5)    = null
)
as
declare @w_sp_name    varchar(30),
        @w_hora       char(1),
        @w_hora_ini   smalldatetime,
        @w_hora_fin   smalldatetime
        
select @w_sp_name = 'sp_rev_tran_monet'

--VERSIONAMIENTO DEL PROGRAMA
if @t_show_version = 1
   begin
      print 'Stored Procedure = ' + @w_sp_name + ' Version = 4.0.0.0'
      return 0
   end

if @t_trn <> 500
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 151051 --Transaccion no permitida
      return 151051
   end

if @i_hora_ini is null or (@i_hora_ini = '00:00' and @i_hora_fin = '23:59')
   select @w_hora = 'N'
else
   select @w_hora = 'S',
          @w_hora_ini = convert(varchar(10), getdate(), 101) + ' ' + @i_hora_ini,
          @w_hora_fin = convert(varchar(10), getdate(), 101) + ' ' + @i_hora_fin

set rowcount 20

select 'Tran.'         = tm_tipo_tran,
       'Descripcion'   = substring(tn_descripcion, 1, 30),
       'Fecha'         = convert(varchar(10), tm_fecha, @i_formato),
       'Hora'          = substring(convert(varchar(8), tm_hora, 108), 1, 5),
       'Estado'        = isnull(tm_estado, ''),
       'Secuencial'    = tm_secuencial,
       'Sec. Branch'   = tm_ssn_branch,
       'Sec. Alt.'     = isnull(tm_cod_alterno, 0),
       'Moneda'        = tm_moneda,
       'Cuenta'        = tm_cta_banco,
       'Nombre'        = substring(ah_nombre, 1, 30),
       'Total'         = isnull(tm_valor, 0) + isnull(tm_chq_propios, 0) + isnull(tm_chq_locales, 0) + isnull(tm_chq_ot_plazas, 0),
       'Efectivo'      = isnull(tm_valor, 0),
       'Che. Propios'  = isnull(tm_chq_propios, 0),
       'Che. Locales'  = isnull(tm_chq_locales, 0),
       'Che. Remesas'  = isnull(tm_chq_ot_plazas, 0),
       'Usuario'       = tm_usuario
from cob_ahorros..ah_tran_monet,
     cob_ahorros..ah_cuenta,
     cobis..cl_ttransaccion
where  tm_cta_banco  = ah_cta_banco
  and  tm_tipo_tran  = tn_trn_code
  and  tm_oficina    = isnull(@i_oficina, @s_ofi)
  and  tm_moneda     = @i_mon
  and  tm_tipo_tran in (252, 263) --Depositos y Retiros
  and  tm_fecha      = @s_date
  and  tm_correccion = 'N'
  and (@i_usuario is null or tm_usuario = @i_usuario)
  and (@i_sec_ini is null or tm_secuencial between @i_sec_ini and @i_sec_fin)
  and (@i_tran    is null or tm_tipo_tran = @i_tran)
  and (@w_hora = 'N' or (@w_hora= 'S' and tm_hora between @w_hora_ini and @w_hora_fin))
  and (@i_val_ini is null or (isnull(tm_valor, 0) + isnull(tm_chq_propios, 0) + isnull(tm_chq_locales, 0) + isnull(tm_chq_ot_plazas, 0)) between @i_val_ini and @i_val_fin)
  and (@i_cta     is null or tm_cta_banco = @i_cta)
  and (tm_secuencial > @i_secuencial or (tm_secuencial = @i_secuencial and isnull(tm_cod_alterno, 0) > @i_cod_alterno))
order by tm_secuencial, tm_cod_alterno

if @@rowcount = 0 and @i_secuencial = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 151172 --No existen registros
      return 151172
   end

set rowcount 0

return 0

go
