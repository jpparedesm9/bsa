/************************************************************************/
/*      Archivo:             casilla.sp                                 */
/*      Stored procedure:    sp_casilla                                 */
/*      Base de datos:       cob_pfijo                                  */
/*      Producto:            Plazo Fijo (tomado de Cuenta Corriente)    */
/*      Disenado por:        Mauricio Bayas/Miryam Davila               */
/*      Fecha de escritura:  13-Jul-1994                                */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                        PROPOSITO                                     */
/*      Este programa procesa las transacciones de consulta             */
/*      de toda la informacion referente a una casilla dada             */
/*                        MODIFICACIONES                                */
/*      FECHA            AUTOR            RAZON                         */
/*      13-Jul-1994     J Navarrete       Emision inicial               */
/*      29-Nov-1994     Ricardo Valencia  Adecuacion para Plazo Fijo    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_casilla')
   drop proc sp_casilla
go

create proc sp_casilla (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint,
@i_operacion            char(1),
@i_tipo_help            char(1)         = 'A',
@i_cliente              int,
@i_casilla              tinyint         = NULL )
with encryption
as
declare 
@w_prov                 smallint,
@w_sp_name              varchar(32)

select @w_sp_name = 'sp_casilla'


/**  VERIFICAR CODIGO DE TRANSACCION PARA HELP  **/
if ( @i_operacion = 'H') and ( @t_trn <> 14809)
begin
  /**  ERROR : CODIGO DE TRANSACCION PARA HELP NO VALIDO  **/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141091
  return 1
end

if @i_tipo_help = 'A'
begin
  select 'No.' = cs_casilla, 
  	     'Casilla' = rtrim(pa_descripcion + '-' + ci_descripcion + '-' 
             + cs_valor ) /*+ '-' + cs_zona)gca*/
  from   cobis..cl_casilla, cobis..cl_ciudad, cobis..cl_pais
  where  cs_ente   = @i_cliente
    and    cs_ciudad = ci_ciudad
    and    ci_pais   = pa_pais

  if @@rowcount = 0
    select 'No.' = cs_casilla, 
           'Casilla' = rtrim(pa_descripcion + '-' + ci_descripcion + '-' 
                + cs_valor ) /*gca+ '-' + cs_zona)*/
    from cobis..cl_casilla, cobis..cl_ciudad, cobis..cl_pais, 
         cobis..cl_provincia
    where  cs_ente      = @i_cliente
      and    cs_ciudad    = ci_ciudad
      and    ci_provincia = pv_provincia
      and    pv_pais      = pa_pais
end

if @i_tipo_help = 'B'
begin
  /***************************************************
  select 'Casilla' = rtrim(pa_descripcion + '-' + ci_descripcion + '-' 
             + cs_valor ) /*+ '-' + cs_zona)gca*/
  from   cobis..cl_casilla, cobis..cl_ciudad, cobis..cl_pais
  where  cs_ente   = @i_cliente
    and    cs_casilla = @i_casilla
    and    cs_ciudad = ci_ciudad
    and    ci_pais   = pa_pais

  if @@rowcount = 0
	begin 
	*****************************************************/
  
  select  rtrim(pa_descripcion + '-' + pv_descripcion + '-' 
             + cs_valor ) /*+ '-' + cs_zona)gca*/
  from cobis..cl_casilla, cobis..cl_provincia, cobis..cl_pais
  where cs_ente   = @i_cliente
    and cs_casilla = @i_casilla
    and cs_provincia = pv_provincia
    and pv_pais   = pa_pais
--	end
	
	if @@rowcount = 0
	begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 101106 
    return 1
  end   	
end
else
begin
  select @w_prov    = ci_provincia
  from   cobis..cl_casilla, cobis..cl_ciudad, cobis..cl_provincia,
         cobis..cl_pais
  where  cs_ente    = @i_cliente
    and    cs_casilla = @i_casilla
    and    cs_ciudad  = ci_ciudad

  if @w_prov is not null
  begin
    select rtrim(pa_descripcion + '-' + ci_descripcion + '-' +
                   cs_valor ) /*gca+ '-' + cs_zona)*/
    from   cobis..cl_casilla, cobis..cl_ciudad, cobis..cl_pais,
           cobis..cl_provincia
    where  cs_ente      = @i_cliente
      and    cs_casilla   = @i_casilla
      and    cs_ciudad    = ci_ciudad
      and    ci_provincia = pv_provincia
      and    pv_pais      = pa_pais
  end
  else
  begin
    select rtrim(pa_descripcion + '-' + ci_descripcion + '-' +
                   cs_valor ) /*gca+ '-' + cs_zona)*/
    from   cobis..cl_casilla, cobis..cl_ciudad, cobis..cl_pais
    where  cs_ente    = @i_cliente
      and    cs_casilla = @i_casilla
      and    cs_ciudad  = ci_ciudad
      and    ci_pais    = pa_pais
  end
end

return 0
go
