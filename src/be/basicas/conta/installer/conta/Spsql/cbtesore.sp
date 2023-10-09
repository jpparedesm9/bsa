/************************************************************************/
/*      Archivo:                cbtesore.sp                             */
/*      Stored procedure:       sp_cob_tesoreria                        */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Maria Claudia Morales M                 */
/*      Fecha de escritura:     22-Septiembre-1997                      */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa muestra los saldos de las diferentes cuentas, si  */
/*      cuenta es de movimiento sumariza. Reporte de Tesoreria.        	*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cob_tesoreria')
	drop proc sp_cob_tesoreria  










go
create proc sp_cob_tesoreria   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null,
	@t_from         varchar(30) = null,
	@i_cuenta       cuenta,
	@i_empresa      tinyint,
        @i_oficina      smallint,
        @i_fecha        datetime,
        @i_area         smallint
)
as 
declare
	@w_hoy          datetime,
	@w_return       int,
	@w_sp_name      varchar(32),
	@w_existe       int,
	@w_parametro    varchar(10),
        @w_estado       char(1),
        @w_online       char(1),
        @w_resumen      char(1),
        @w_cuenta       cuenta,
        @w_empresa      tinyint,
        @w_tipo         char(1),
        @w_moneda       tinyint,
        @w_valor        money,
        @w_corte        char(1),
        @w_nombre       varchar(30),
        @w_corte_num    int,
        @w_periodo      int,
        @w_valor_e      money,
        @w_categoria    char(1)
	

select @w_sp_name = 'sp_cob_tesoreria'


/*  Tipo de Transaccion = 			*/

if @t_trn <> 6998 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_cuenta        = @i_cuenta,       
		i_empresa       = @i_empresa,
                i_oficina       = @i_oficina,
                i_fecha         = @i_fecha
	exec cobis..sp_end_debug
end
/****************************************************/
/* verifica existencia de la cuenta en la tabla     */
/* cb_cuenta                                        */
/****************************************************/
  select @w_tipo = cu_movimiento,
         @w_moneda = cu_moneda,
         @w_nombre = cu_nombre
  from cb_cuenta
  where cu_cuenta = @i_cuenta
    and cu_empresa = @i_empresa

  if @@rowcount = 0
   begin
        select @w_nombre = 'CUENTA NO MANEJADA POR EL BANCO'
        select @w_valor = 0
        select @w_valor_e = 0
     /* 'Cuenta no existe   ' */
        select @w_nombre, @w_valor, @w_valor_e
	return 1
   end

/****************************************************/
/* Valida si la fecha pertenece al corte actual     */
/****************************************************/
select @w_corte   = co_estado,
       @w_periodo = co_periodo,
       @w_corte_num = co_corte
from cb_corte
where co_empresa = @i_empresa
  and co_fecha_ini <= @i_fecha
  and co_fecha_fin >= @i_fecha
if @w_corte = 'A'
   begin
    select @w_valor     = sum(sa_saldo),
           @w_categoria = cu_categoria
    from cb_cuenta,cb_saldo
    where cu_empresa = @i_empresa
      and cu_cuenta  = @i_cuenta
      and cu_moneda  = 0
      and sa_cuenta  = @i_cuenta
      and sa_empresa = @i_empresa 
      and sa_periodo = @w_periodo
      and sa_corte   = @w_corte_num
      and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
      and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
    Group by cu_categoria
   /* MCM001 valida categoria */
    if @w_categoria = 'C'
       select @w_valor = @w_valor * -1
    select @w_valor_e   = sum(sa_saldo),
           @w_categoria = cu_categoria
    from cb_cuenta,cb_saldo
    where cu_empresa = @i_empresa
      and cu_cuenta = @i_cuenta
      and cu_moneda <> 0
      and sa_cuenta  = @i_cuenta
      and sa_empresa = @i_empresa 
      and sa_periodo = @w_periodo
      and sa_corte   = @w_corte_num
      and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
      and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
    Group by cu_categoria
   /* MCM001 valida categoria */
    if @w_categoria = 'C'
       select @w_valor_e = @w_valor_e * -1
   end
else 
   begin
    select @w_valor   = sum(hi_saldo),
           @w_categoria = cu_categoria
    from cb_cuenta,cob_conta_his..cb_hist_saldo
    where cu_empresa = @i_empresa
      and cu_moneda  = 0
      and cu_cuenta  = @i_cuenta 
      and hi_cuenta  = @i_cuenta
      and hi_empresa = @i_empresa 
      and hi_periodo = @w_periodo
      and hi_corte   = @w_corte_num
      and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
      and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
    Group by cu_categoria
   /* MCM001 valida categoria */
    if @w_categoria = 'C'
       select @w_valor = @w_valor * -1
    select @w_valor_e   = sum(hi_saldo),
           @w_categoria = cu_categoria
    from cb_cuenta,cob_conta_his..cb_hist_saldo
    where cu_empresa = @i_empresa
      and cu_cuenta = @i_cuenta
      and cu_moneda <> 0
      and hi_cuenta  = cu_cuenta
      and hi_empresa = @i_empresa 
      and hi_periodo = @w_periodo
      and hi_corte   = @w_corte_num
      and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
      and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
    Group by cu_categoria
   /* MCM001 valida categoria */
    if @w_categoria = 'C'
       select @w_valor_e = @w_valor_e * -1
   end
 
select @w_nombre, @w_valor, @w_valor_e
go
