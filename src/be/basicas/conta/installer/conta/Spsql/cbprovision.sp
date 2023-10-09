/************************************************************************/
/*      Archivo:                cbprovision.sp                          */
/*      Stored procedure:       sp_cob_provision                        */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Sandra Yanira Rpbayo Rico               */
/*      Fecha de escritura:     12-Marzo-1998                           */
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
/*      Este programa muestra los saldos a la fecha.                    */
/*      Reporte Provision de Impuesto de Renta EXCEL                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cob_provision')
	drop proc sp_cob_provision  




go
create proc sp_cob_provision  (
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
        @w_valor_hoy    money,
	@w_valor_anterior  money,
	@w_corte	int,
	@w_maxcorte	int,
	@w_periodo	int,
	@w_estado_corte char(1),
        @w_mes_ant      varchar(2),
        @w_valor_total  money,
        @w_year         smallint,
        @w_mes          tinyint,
        @w_dia          tinyint,
        @w_fecha_tot    varchar(10),
        @w_fecha        varchar(30),
        @w_mes_letra    varchar(3),
        @w_cuenta       cuenta,
        @w_categoria    char(1)
	

select @w_sp_name = 'sp_cob_provision'

/*  Tipo de Transaccion = 			*/
if (@t_trn <> 6298 and (@i_operacion = 'M' or @i_operacion = 'S'))
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
  select @w_cuenta = pg_cuenta 
    from cb_plan_general
   where pg_empresa = @i_empresa
     and pg_cuenta = @i_cuenta

  if @@rowcount = 0
	return 1

select @w_valor_hoy = 0
select @w_valor_anterior = 0
select @w_valor_total = 0


select  @w_corte = co_corte,
        @w_periodo = co_periodo,
        @w_estado_corte = co_estado
  from  cb_corte
where   co_empresa = @i_empresa and
        co_fecha_ini <= @i_fecha and
        co_fecha_fin >= @i_fecha


        if @w_estado_corte = 'A'
        begin

     	  select @w_valor_hoy   = sum(sa_saldo) + sum(sa_saldo_me), 
                 @w_categoria   = cu_categoria
            from cb_saldo, cb_cuenta
           where sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa 
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
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_hoy = @w_valor_hoy * -1
	
	end
            
	else /* El corte es Vigente (V) */
	begin

     	  select @w_valor_hoy   = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria   = cu_categoria
            from cob_conta_his..cb_hist_saldo, cb_cuenta
           where hi_cuenta  = @i_cuenta
             and hi_empresa = @i_empresa 
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
             and cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
     		select @w_valor_hoy = @w_valor_hoy * -1
	
	end

        if @i_operacion = 'M'
	   select @w_valor_hoy


        if @i_operacion = 'S'
        begin
           /* tomar ano, mes, dia de la fecha */

           select @w_year = datepart(yy, @i_fecha)
           select @w_mes = datepart(mm, @i_fecha)
           select @w_dia = datepart(dd, @i_fecha)

           if @w_mes = 1
           begin
              select @w_year = @w_year - 1 
              select @w_mes = 12    
           end
           else
              select @w_mes = @w_mes - 1

           if @w_mes = 2 and @w_dia > 28
              select @w_dia = 28
  
           if (@w_mes = 4 or @w_mes = 6 or @w_mes = 9 or @w_mes = 11) and
               @w_dia > 30
             select @w_dia = 30
                


           select @w_periodo = @w_year
           select @w_fecha_tot = CONVERT(varchar(02),@w_mes) + '/' 
           select @w_fecha_tot =@w_fecha_tot + CONVERT(varchar(2),@w_dia) + '/' 
           select @w_fecha_tot = @w_fecha_tot + CONVERT(varchar(4),@w_year)


           select @w_fecha = CONVERT(datetime,@w_fecha_tot)

           select @w_mes_letra = SUBSTRING(@w_fecha, 1, 3) 
  
           select @w_maxcorte = max(co_corte)
           from cb_corte
           where
              co_periodo = @w_year and
              co_fecha_ini like @w_mes_letra + '%'

           /* saldo para el corte del ultimo dia del mes anterior */

           if @w_estado_corte = 'A'
           begin

     	      select @w_valor_anterior  = sum(sa_saldo) + sum(sa_saldo_me),
                     @w_categoria   = cu_categoria
              from cb_saldo, cb_cuenta
              where sa_cuenta  = @i_cuenta
                and sa_empresa = @i_empresa 
                and sa_periodo = @w_periodo
                and sa_corte   = @w_maxcorte
                and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
                and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
                and cu_empresa = @i_empresa
                and cu_cuenta  = @i_cuenta
              Group by cu_categoria

              if @w_categoria = 'C'
     		select @w_valor_anterior = @w_valor_anterior * -1
           end
           else
	   begin

     	      select @w_valor_anterior = sum(hi_saldo) + sum(hi_saldo_me),
                     @w_categoria = cu_categoria
              from cob_conta_his..cb_hist_saldo, cb_cuenta
              where hi_cuenta  = @i_cuenta
                and hi_empresa = @i_empresa 
                and hi_periodo = @w_periodo
                and hi_corte   = @w_maxcorte
                and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
                and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))
                and cu_empresa = @i_empresa
                and cu_cuenta  = @i_cuenta
              Group by cu_categoria

              if @w_categoria = 'C'
     		  select @w_valor_anterior = @w_valor_anterior * -1
	
          end

          select @w_valor_total = @w_valor_hoy - @w_valor_anterior
          select @w_valor_total

       end
go
