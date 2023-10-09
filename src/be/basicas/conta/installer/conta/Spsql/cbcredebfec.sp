/************************************************************************/
/*      Archivo:                cbcredebfec.sp                          */
/*      Stored procedure:       sp_cob_cre_deb_fecha                    */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Maria Claudia Morales M                 */
/*      Fecha de escritura:     21-Octubre-1997                         */
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
/*      Este programa se encarga enviar los movimientos  de las cuentas */
/*      para las fechas de entrada y calcula su variacion absoluta y   	*/
/*      relativa. EXCEL                                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cob_cre_deb_fecha')
	drop proc sp_cob_cre_deb_fecha

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_cob_cre_deb_fecha   (
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
        @i_fecha_ant    datetime,
        @i_fecha_inm    datetime,
        @i_area         smallint,
        @i_movimiento   char(1),
        @i_operacion    char(1)
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
        @w_corte_num_hoy    smallint,
        @w_periodo_hoy  int,
        @w_corte_num_ant    smallint,
        @w_corte_inm_ant    smallint,
        @w_periodo_ant  int,
        @w_periodo_inm  int,
        @w_estado_hoy   char(1),
        @w_estado_ant   char(1),
        @w_estado_inm   char(1),
        @w_valor_hoy    money,
        @w_valor_hoy1   money,
        @w_valor_ant    money,
        @w_valor_inm    money,
        @w_fechafin     datetime,
        @w_fechaini     datetime,
        @w_valor_ant1   money,
        @w_cre_hoy      money,
        @w_deb_hoy      money,
        @w_cre_ant      money,
        @w_deb_ant      money,
        @w_cre_hoy1     money,
        @w_deb_hoy1     money,
        @w_cre_ant1     money,
        @w_deb_ant1     money,
        @w_mes_hoy      char(2),
        @w_ano_hoy      char(4),
        @w_mes_ant      char(2),
        @w_ano_ant      char(4),
        @w_fecha_ini    char(10),
        @w_fecha_fin    char(10),
        @w_fecha_hoy    char(10),
        @w_fecha_ant    char(10),
        @w_fecha_ini1   datetime,
        @w_fecha_fin1   datetime,
        @w_absoluta     money,
        @w_nombre       varchar(80),
        @w_categoria    char(1),
        @w_relativa     money
	

select @w_sp_name = 'sp_cob_cre_deb_fecha'

/*  Tipo de Transaccion = 			*/

if @t_trn <> 6975 and (@i_operacion = 'P' or @i_operacion = 'Q') 
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


select @w_nombre = cu_nombre
from cb_cuenta
where
     cu_cuenta = @i_cuenta 
 and cu_empresa = @i_empresa


if @i_operacion = 'P'
begin

     /****************************************************/
     /* Trae corte y periodo para la fecha actual        */
     /****************************************************/

     select @w_corte_num_hoy = co_corte,
       @w_periodo_hoy = co_periodo, 
       @w_estado_hoy = co_estado
     from cb_corte
     where co_empresa = @i_empresa
       and co_fecha_ini <= @i_fecha 
       and co_fecha_fin >= @i_fecha 

     /****************************************************/
     /* Trae corte y periodo para la fecha anterior      */
     /****************************************************/
     select @w_corte_num_ant = co_corte,
            @w_periodo_ant = co_periodo, 
            @w_estado_ant = co_estado
     from cb_corte
     where co_empresa = @i_empresa
       and co_fecha_ini <= @i_fecha_ant 
       and co_fecha_fin >= @i_fecha_ant 


     /****************************************************/
     /* Trae corte y periodo para la fecha inm. anterior */
     /****************************************************/
     select @w_corte_inm_ant = co_corte,
            @w_periodo_inm = co_periodo, 
            @w_estado_inm = co_estado
     from cb_corte
     where co_empresa = @i_empresa
       and co_fecha_ini <= @i_fecha_inm 
       and co_fecha_fin >= @i_fecha_inm 

     /*****************************************************/ 
     /* Extracta el movimiento de la fecha actual segun   */
     /* su estado                                         */
     /*****************************************************/ 

     if @w_estado_hoy = 'A'
     begin

        select @w_valor_hoy = sum(sa_saldo) + sum(sa_saldo_me),
               @w_categoria = cu_categoria
        from cb_saldo, cb_cuenta
        Where sa_cuenta = @i_cuenta
          and sa_corte  = @w_corte_num_hoy
          and sa_periodo = @w_periodo_hoy
          and sa_empresa = @i_empresa
          and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
          and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))           
          and cu_empresa = @i_empresa
          and cu_cuenta = @i_cuenta 
        Group by cu_categoria
    
        if @w_categoria = 'C'
           select @w_valor_hoy = @w_valor_hoy * -1
   
     end
     else
     begin
         select @w_valor_hoy = sum(hi_saldo) + sum(hi_saldo_me),
                @w_categoria = cu_categoria
         from cob_conta_his..cb_hist_saldo, cb_cuenta
         Where hi_cuenta = @i_cuenta
           and hi_corte  = @w_corte_num_hoy
           and hi_periodo = @w_periodo_hoy
           and hi_empresa = @i_empresa
           and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
           and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))           
           and cu_empresa = @i_empresa 
           and cu_cuenta = @i_cuenta
         Group by cu_categoria

         if @w_categoria = 'C'
            select @w_valor_hoy = @w_valor_hoy * -1
     end

     /*****************************************************/ 
     /* Extracta el movimiento de la fecha anterior segun */
     /* su estado                                         */
     /*****************************************************/ 

     if @w_estado_ant = 'A'
     begin
        select @w_valor_ant = sum(sa_saldo) + sum(sa_saldo_me),
               @w_categoria = cu_categoria
        from cb_saldo, cb_cuenta
        Where sa_cuenta = @i_cuenta
          and sa_corte  = @w_corte_num_ant
          and sa_periodo = @w_periodo_ant
          and sa_empresa = @i_empresa
          and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
          and sa_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))           
          and cu_empresa = @i_empresa
          and cu_cuenta = @i_cuenta
        Group by cu_categoria

        if @w_categoria = 'C'
          select @w_valor_ant = @w_valor_ant * -1
     
     end
     else
     begin
          select @w_valor_ant = sum(hi_saldo) + sum(hi_saldo_me),
                 @w_categoria = cu_categoria
          from cob_conta_his..cb_hist_saldo, cb_cuenta
          Where hi_cuenta = @i_cuenta
            and hi_corte  = @w_corte_num_ant
            and hi_periodo = @w_periodo_ant
            and hi_empresa = @i_empresa
            and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
            and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                            (ja_area_padre = @i_area or
                            ja_area = @i_area))           
            and cu_empresa = @i_empresa
            and cu_cuenta = @i_cuenta
          Group by cu_categoria

          if @w_categoria = 'C'
              select @w_valor_ant = @w_valor_ant * -1

     end

     /*****************************************************/ 
     /* Extracta el movimiento de la fecha anterior segun */
     /* su estado                                         */
     /*****************************************************/ 

     if @i_movimiento = 'M'
     begin
        if @w_estado_inm = 'A'
        begin
           select @w_valor_inm = sum(sa_saldo) + sum(sa_saldo_me),
                  @w_categoria = cu_categoria
           from cb_saldo, cb_cuenta
           Where sa_cuenta = @i_cuenta
             and sa_corte  = @w_corte_inm_ant
             and sa_periodo = @w_periodo_inm
             and sa_empresa = @i_empresa
             and sa_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                            (je_oficina_padre = @i_oficina or
                            je_oficina = @i_oficina))
             and sa_area in (select ja_area from cb_jerararea
                              where ja_empresa = @i_empresa and
                                   (ja_area_padre = @i_area or
                                    ja_area = @i_area))           
             and cu_empresa = @i_empresa
             and cu_cuenta = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
              select @w_valor_inm = @w_valor_inm * -1
     
        end
        else
        begin
           select @w_valor_inm = sum(hi_saldo) + sum(hi_saldo_me),
                  @w_categoria = cu_categoria
           from cob_conta_his..cb_hist_saldo, cb_cuenta
           Where hi_cuenta = @i_cuenta
             and hi_corte  = @w_corte_inm_ant
             and hi_periodo = @w_periodo_inm
             and hi_empresa = @i_empresa
             and hi_oficina in (select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa and
                                 (je_oficina_padre = @i_oficina or
                                  je_oficina = @i_oficina))
             and hi_area in (select ja_area from cb_jerararea
                            where ja_empresa = @i_empresa and
                                 (ja_area_padre = @i_area or
                                  ja_area = @i_area))           
             and cu_empresa = @i_empresa
             and cu_cuenta = @i_cuenta
           Group by cu_categoria

           if @w_categoria = 'C'
              select @w_valor_inm = @w_valor_inm * -1

        end
     end

     if @i_movimiento = 'M'
     begin
  
         if CONVERT(varchar(20),@w_valor_hoy) is null and 
            CONVERT(Varchar(20),@w_valor_ant) is not null 

           select @w_valor_hoy = 0

         if CONVERT(varchar(20),@w_valor_hoy) is not null and 
            CONVERT(varchar(20),@w_valor_ant) is null

           select @w_valor_ant = 0 

         if CONVERT(varchar(20),@w_valor_inm) is null and 
            CONVERT(varchar(20),@w_valor_ant) is not null

             select @w_valor_inm = 0 

         if CONVERT(varchar(20),@w_valor_inm) is not null and 
            CONVERT(varchar(20),@w_valor_ant) is null

             select @w_valor_ant = 0 

         select @w_valor_hoy = @w_valor_hoy - @w_valor_ant
         select @w_valor_ant = @w_valor_ant - @w_valor_inm

     end 

     /*select @w_absoluta = @w_valor_hoy - @w_valor_ant  
     if @w_valor_ant <> 0 
        select @w_relativa = (@w_valor_hoy / @w_valor_ant) / 100
     else
        select @w_relativa = 0*/

     select @w_nombre, 
            @w_valor_hoy, 
            @w_valor_ant  

end

if @i_operacion = 'Q'
begin

   /**********************************************************/
   /* Trae saldos al primer dia de cada uno de los meses de  */
   /* las fechas de ingreso                                  */ 
   /**********************************************************/

   select @w_fecha_fin = CONVERT(char(2),datepart(mm,@i_fecha))+'/'+'01'+'/' 
   select @w_fecha_fin = @w_fecha_fin + CONVERT(char(4),datepart(yy,@i_fecha))

   select @w_fecha_ini=CONVERT(char(2),datepart(mm,@i_fecha_ant))+'/'+'01'+'/' 
   select @w_fecha_ini=@w_fecha_ini+CONVERT(char(4),datepart(yy,@i_fecha_ant))

   select @w_fechafin = @w_fecha_fin
   select @w_fechaini = @w_fecha_ini

   /****************************************************/
   /* Trae corte y periodo para la fecha fin           */
   /****************************************************/

   select @w_corte_num_hoy = co_corte,
       @w_periodo_hoy = co_periodo, 
       @w_estado_hoy = co_estado
   from cb_corte
   where co_empresa = @i_empresa
       and co_fecha_ini <= @w_fechafin
       and co_fecha_fin >= @w_fechafin 

   /****************************************************/
   /* Trae corte y periodo para la fecha ini           */
   /****************************************************/
   select @w_corte_num_ant = co_corte,
          @w_periodo_ant = co_periodo, 
          @w_estado_ant = co_estado
   from cb_corte
   where co_empresa = @i_empresa
       and co_fecha_ini <= @w_fechaini
       and co_fecha_fin >= @w_fechaini 


   if @w_estado_hoy = 'A'
   begin

      select @w_valor_hoy1 = sum(sa_saldo) + sum(sa_saldo_me),
          @w_categoria = cu_categoria
      from cb_saldo, cb_cuenta
      Where sa_cuenta = @i_cuenta
        and sa_corte  = @w_corte_num_hoy
        and sa_periodo = @w_periodo_hoy
        and sa_empresa = @i_empresa
        and sa_oficina in (select je_oficina from cb_jerarquia
                         where je_empresa = @i_empresa and
                         (je_oficina_padre = @i_oficina or
                         je_oficina = @i_oficina))
        and sa_area in (select ja_area from cb_jerararea
                         where ja_empresa = @i_empresa and
                         (ja_area_padre = @i_area or
                         ja_area = @i_area))           
        and cu_empresa = @i_empresa
        and cu_cuenta = @i_cuenta
       Group by cu_categoria

     if @w_categoria = 'C'
        select @w_valor_hoy1 = @w_valor_hoy1 * -1
  end
  else
  begin
      select @w_valor_hoy1 = sum(hi_saldo) + sum(hi_saldo_me),
          @w_categoria = cu_categoria
      from cob_conta_his..cb_hist_saldo, cb_cuenta
      Where hi_cuenta = @i_cuenta
        and hi_corte  = @w_corte_num_hoy
        and hi_periodo = @w_periodo_hoy
        and hi_empresa = @i_empresa
        and hi_oficina in (select je_oficina from cb_jerarquia
                         where je_empresa = @i_empresa and
                         (je_oficina_padre = @i_oficina or
                         je_oficina = @i_oficina))
        and hi_area in (select ja_area from cb_jerararea
                         where ja_empresa = @i_empresa and
                         (ja_area_padre = @i_area or
                         ja_area = @i_area))           
        and cu_empresa = @i_empresa
        and cu_cuenta = @i_cuenta
       Group by cu_categoria

     if @w_categoria = 'C'
        select @w_valor_hoy1 = @w_valor_hoy1 * -1
  end

  if @w_estado_ant = 'A'
  begin

     select @w_valor_ant1 = sum(sa_saldo) + sum(sa_saldo_me),
            @w_categoria = cu_categoria
     from cob_conta..cb_saldo, cb_cuenta
     Where sa_cuenta = @i_cuenta
       and sa_corte  = @w_corte_num_ant
       and sa_periodo = @w_periodo_ant
       and sa_empresa = @i_empresa
       and sa_oficina in (select je_oficina from cb_jerarquia
                         where je_empresa = @i_empresa and
                         (je_oficina_padre = @i_oficina or
                         je_oficina = @i_oficina))
       and sa_area in (select ja_area from cb_jerararea
                         where ja_empresa = @i_empresa and
                         (ja_area_padre = @i_area or
                         ja_area = @i_area))           
       and cu_empresa = @i_empresa
       and cu_cuenta = @i_cuenta
      Group by cu_categoria

     if @w_categoria = 'C'
        select @w_valor_ant1 = @w_valor_ant1 * -1
  end
  else
  begin

      select @w_valor_ant1 = sum(hi_saldo) + sum(hi_saldo_me),
             @w_categoria = cu_categoria
      from cob_conta_his..cb_hist_saldo, cb_cuenta
      Where hi_cuenta = @i_cuenta
        and hi_corte  = @w_corte_num_ant
        and hi_periodo = @w_periodo_ant
        and hi_empresa = @i_empresa
        and hi_oficina in (select je_oficina from cb_jerarquia
                         where je_empresa = @i_empresa and
                         (je_oficina_padre = @i_oficina or
                         je_oficina = @i_oficina))
        and hi_area in (select ja_area from cb_jerararea
                         where ja_empresa = @i_empresa and
                         (ja_area_padre = @i_area or
                         ja_area = @i_area))           
        and cu_empresa = @i_empresa
        and cu_cuenta = @i_cuenta
      Group by cu_categoria

     if @w_categoria = 'C'
        select @w_valor_ant1 = @w_valor_ant1 * -1

  end

  select  @w_valor_hoy1,
          @w_valor_ant1,
          @w_fecha_ini,
          @w_fecha_fin

end 

go

