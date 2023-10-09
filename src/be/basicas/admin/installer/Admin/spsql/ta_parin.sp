/******************************************************************/ 
/*  Archivo:              ta_parin.sp                             */
/*  Stored procedure:     sp_tare_busca_param                     */
/*  Base de datos:        cobis                                   */
/*  Producto:             Admin                                   */
/*  Disenado por:         Santiago Garces G.                      */
/*  Fecha:                05-Jul-96                               */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este stored procedure permite la busqueda de parametros ini-  */
/*  ciales para carga del modulo principal                        */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*  05-Jul-96      S. Garces       Emision inicial                */
/*  16-May-00      R. Minga        RMI16May00: Adaptacion tasas   */
/*                                 referenciales ADMIN            */
/******************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_busca_param')
        drop proc sp_tare_busca_param
go
create proc sp_tare_busca_param
(
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		tinyint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,

	@o_fechahoy	char(10) = null out,
	@o_codmonnac    tinyint = 0 out,
	@o_decmonnac    tinyint = 0 out,
	@o_decmonext    tinyint = 2 out,
	@o_coddolar     tinyint = 1 out
)
as

declare	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32)     /* nombre del stored procedure*/

/* Asignar el nombre del stored procedure */
select  @w_sp_name = 'sp_tare_busca_param'

if @t_trn <> 15215
begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151051
	return 1
end


/* buscar fecha de proceso */
select @o_fechahoy = rtrim(convert(char(10),getdate(),103))

/* buscar codigo moneda nacional */
select @o_codmonnac = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'CMNAC'

if @@rowcount = 0
begin
    /* 'No existen datos buscados '*/
    exec cobis..sp_cerror
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_num       = 151116
    return 1
end

select * from cl_moneda
/* buscar numero de decimales de moneda nacional */
select @o_decmonnac = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'DECMN'

if @@rowcount = 0
begin
    /* 'No existen datos buscados '*/
    exec cobis..sp_cerror
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_num       = 151116
    return 1
end

/* buscar numero de decimales de moneda extranjera */
select @o_decmonext = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'DECME'

if @@rowcount = 0
begin
    /* 'No existen datos buscados '*/
    exec cobis..sp_cerror
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_num       = 151116
    return 1
end


/* buscar codigo del DOLAR */
select @o_coddolar = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'CDOLAR'

if @@rowcount = 0
begin
    /* 'No existen datos buscados '*/
    exec cobis..sp_cerror
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_num       = 151116
    return 1
end
return 0
go

