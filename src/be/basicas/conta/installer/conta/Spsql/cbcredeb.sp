/************************************************************************/
/*      Archivo:                cbcredeb.sp                             */
/*      Stored procedure:       sp_cob_cre_deb                          */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Maria Victoria Garay                    */
/*      Fecha de escritura:     30-Marzo-1998                           */
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
/*      Este programa se encarga de sumarizar los movimientos creditos  */
/*      y debitos para las cuentas de entrada . EXCEL.                 	*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_conta

go

if exists (select * from sysobjects where name = 'sp_cob_cre_deb')
	drop proc sp_cob_cre_deb  
go
create proc sp_cob_cre_deb   (
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
        @i_oficina      smallint = null,
        @i_fecha        datetime,
        @i_area         smallint = null
)
as 
declare
	@w_hoy          datetime,
        @w_periodo      int,
        @w_periodo1      int,
        @w_periodo2      int,
        @w_periodo_ant  int,
        @w_corte        int,     
        @w_categoria    char(1),
	@w_return       int,
	@w_sp_name      varchar(32),
	@w_existe       int,
	@w_parametro    varchar(10),
        @w_cuenta       cuenta,
        @w_tipo         char(1),
        @w_moneda       tinyint,
        @w_valor        money,
        @w_mes_ant     int, 
        @w_mes_ant1     char(2), 
        @w_corte_ant     int, 
        @w_mes          tinyint,
        @w_nombre       varchar(40),
        @w_contador       tinyint,
        @w_fecha_ant     char(10), 
        @w_val_anterior    money,
        @w_deb_mes_ant    money, 
        @w_deb_pro        money,
        @w_cre_pro        money,
        @w_subtipo        char(2),
        @w_valor_vari     money
	

select @w_sp_name = 'sp_cob_cre_deb'


/*  Tipo de Transaccion = 			*/

if @t_trn <> 6974 
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


   select  @w_corte = co_corte,
           @w_periodo = co_periodo,
           @w_tipo = co_estado
   from  cb_corte
   where   co_empresa = @i_empresa and
           co_fecha_ini <= @i_fecha and
           co_fecha_fin >= @i_fecha   

/****************************************************/
/* extrae mes y periodo de la fecha de entrada      */
/****************************************************/

  select @w_mes = datepart(mm,@i_fecha)

/***selecciona el nombre de  la cuenta **/

   Select @w_nombre = cu_nombre
   from cb_cuenta
   Where cu_empresa = @i_empresa
     and cu_cuenta = @i_cuenta   

   if @@rowcount = 0
   begin
     /* 'Cuenta no existe   ' */

     select @w_nombre = 'CUENTA NO MANEJADA POR EL BANCO',
            @w_valor = 0

     select @w_nombre, 
          @w_valor,
          @w_mes

     return 0

   end   


/******** saldo para la fecha ingresada *********/ 

   if @w_tipo = 'A'
   begin

       select @w_valor = sum(sa_saldo) + sum(sa_saldo_me),
              @w_categoria = cu_categoria
       from cob_conta..cb_saldo, cob_conta..cb_cuenta
       Where
              sa_empresa = @i_empresa
          and sa_cuenta = @i_cuenta 
          and sa_corte   = @w_corte
          and sa_periodo = @w_periodo
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
          group by cu_categoria
       if @w_categoria = 'C'
           select @w_valor = @w_valor * (-1)

    end
    else
    begin 
 
       select @w_valor = sum(hi_saldo) + sum(hi_saldo_me),
              @w_categoria = cu_categoria
       from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
       Where
              hi_empresa = @i_empresa
          and hi_cuenta = @i_cuenta 
          and hi_corte   = @w_corte
          and hi_periodo = @w_periodo
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
        group by cu_categoria
       if @w_categoria = 'C'
           select @w_valor = @w_valor * (-1)

   end


   select @w_nombre, 
          @w_valor,
          @w_mes

   return 0

                  
go

