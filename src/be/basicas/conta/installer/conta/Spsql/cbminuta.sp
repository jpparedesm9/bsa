/************************************************************************/
/*      Archivo:                cbminuta.sp                             */
/*      Stored procedure:       sp_cob_minuta                           */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Maria Claudia Morales M                 */
/*      Fecha de escritura:     25-Septiembre-1997                      */
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
/*      Este programa muestra los saldos a la fecha y fecha anterior con*/
/*      su variacion absoluta y relativa. Reporte Minuta Gerencia EXCEL */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */ 
/*     13/03/1998     Maria Victoria Garay   consideracion moneda       */ 
/*                                            extranjera                */ 
/*     29/03/2004     Monica L. Llano C.     Modificacion (B. Agrario)  */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cob_minuta')
	drop proc sp_cob_minuta
go

create proc sp_cob_minuta   (
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
        @i_operacion    char(1),
	@i_cuenta       cuenta,
	@i_empresa      tinyint,
        @i_oficina      smallint,
        @i_fecha        datetime,
        @i_fecha_ant    datetime = null,
        @i_area         smallint
)
as 
declare
	@w_hoy          datetime,
	@w_return       int,
	@w_sp_name      varchar(32),
        @w_estado       char(1),
        @w_online       char(1),
        @w_empresa      tinyint,
        @w_tipo         char(1),
        @w_valor_hoy    money,
	@w_valor_ayer	money,
	@w_corte	int,
	@w_corte_ant	int,
        @w_corte_anterior int,
	@w_periodo	int,
	@w_periodo_ant	int,
        @w_periodo_anterior int,
	@w_estado_corte char(1),
        @w_fecha_ayer   datetime,
        @w_fecha_ant    datetime,
        @w_absoluta     money,
        @w_cuenta       cuenta,
        @w_nombre       varchar(80),
        @w_mes_hoy      varchar(2),
        @w_ano_hoy      varchar(4),
        @w_mes_ant      varchar(2),
        @w_ano_ant      varchar(4),
        @w_fecha_ini    char(10),
        @w_fecha_fin    char(10),
        @w_fecha_ini1   datetime,
        @w_fecha_fin1   datetime,          
        @w_relativa     float,
        @w_categoria    char(1)
	

select @w_sp_name = 'sp_cob_minuta'

/*  Tipo de Transaccion = 			*/
if (@t_trn <> 6973 and (@i_operacion = 'M' or @i_operacion = 'B'))
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
/* -- MLLC Marzo 29 de 2004
  select @w_cuenta = pg_cuenta 
    from cb_plan_general
   where pg_empresa = @i_empresa
   and pg_oficina >= 0
   and pg_area >= 0
   and pg_cuenta = @i_cuenta

  if @@rowcount = 0
	return 1
*/
  select @w_nombre = cu_nombre
  from cb_cuenta
  where cu_empresa = @i_empresa
  and cu_cuenta = @i_cuenta

select  @w_corte = co_corte,
        @w_periodo = co_periodo,
        @w_estado_corte = co_estado
  from  cb_corte
where   co_empresa = @i_empresa and
        co_fecha_ini <= @i_fecha and
        co_fecha_fin >= @i_fecha


select @w_fecha_ant = @i_fecha_ant
select @w_fecha_ayer = dateadd(dd,-1,@i_fecha)

select  @w_corte_ant = co_corte,
        @w_periodo_ant = co_periodo
  from  cb_corte
where   co_empresa = @i_empresa and
        co_fecha_ini <= @w_fecha_ayer and
        co_fecha_fin >= @w_fecha_ayer

select  @w_corte_anterior = co_corte,
        @w_periodo_anterior = co_periodo
  from  cb_corte
where   co_empresa = @i_empresa and
        co_fecha_ini <= @w_fecha_ant and
        co_fecha_fin >= @w_fecha_ant

if @i_operacion = 'M'
begin
        if @w_estado_corte = 'A'
        begin

     	  select @w_valor_hoy   = sum(sa_saldo) + sum(sa_saldo_me),
                 @w_categoria   = cu_categoria
            from cb_saldo, cb_cuenta
           where sa_empresa = @i_empresa
             and sa_periodo = @w_periodo
             and sa_corte   = @w_corte
             and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and sa_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_hoy = @w_valor_hoy * -1
	

     	  select @w_valor_ayer   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_empresa = @i_empresa
             and hi_periodo = @w_periodo_ant
             and hi_corte   = @w_corte_ant
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and hi_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_ayer = @w_valor_ayer * -1

	   select @w_valor_hoy, @w_valor_ayer
	end
            
	else /* El corte es Vigente (V) */
	begin

     	  select @w_valor_hoy   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_empresa = @i_empresa
             and hi_periodo = @w_periodo
             and hi_corte   = @w_corte
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and hi_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_hoy = @w_valor_hoy * -1
	

     	  select @w_valor_ayer   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_empresa = @i_empresa
             and hi_periodo = @w_periodo_ant
             and hi_corte   = @w_corte_ant
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and hi_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_ayer = @w_valor_ayer * -1

	   select @w_valor_hoy, @w_valor_ayer
	end
end

if @i_operacion = 'B'
begin
        if @w_estado_corte = 'A'
        begin

     	  select @w_valor_hoy   = sum(sa_saldo) + sum(sa_saldo_me),
                 @w_categoria   = cu_categoria
            from cb_saldo, cb_cuenta
           where sa_empresa = @i_empresa
             and sa_periodo = @w_periodo
             and sa_corte   = @w_corte
             and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and sa_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_hoy = @w_valor_hoy * -1
	

     	  select @w_valor_ayer   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_empresa = @i_empresa
             and hi_periodo = @w_periodo_anterior
             and hi_corte   = @w_corte_anterior
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and hi_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_ayer = @w_valor_ayer * -1

	   select @w_nombre, @w_valor_hoy, @w_valor_ayer
	end
            
	else /* El corte es Vigente (V) */
	begin

     	  select @w_valor_hoy   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_empresa = @i_empresa
             and hi_periodo = @w_periodo
             and hi_corte   = @w_corte
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and hi_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_hoy = @w_valor_hoy * -1
	

     	  select @w_valor_ayer   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_empresa = @i_empresa
             and hi_periodo = @w_periodo_anterior
             and hi_corte   = @w_corte_anterior
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
             and hi_cuenta  = @i_cuenta
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_ayer = @w_valor_ayer * -1

	   select @w_nombre, @w_valor_hoy, @w_valor_ayer
        end

end

go
