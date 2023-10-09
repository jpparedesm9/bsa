/************************************************************************/
/*      Archivo:                obtsaldoter.sp                          */
/*      Stored procedure:       sp_obtener_saldo_tercero                */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Pedro Coello Ramirez                    */
/*      Fecha de escritura:     29-Agosto-2000                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*         Obtener Saldo, Movimientos de terceros                       */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      29/Ago/2000     P Coello R.     Emision Inicial                 */
/*      06/Sep/2000     J.Rodriguez     Operacion Q                     */
/************************************************************************/ 
use cob_conta
go

if exists (select * from sysobjects
          where name = 'sp_obtener_saldo_tercero')
      drop proc sp_obtener_saldo_tercero
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
 

create proc sp_obtener_saldo_tercero (
        @s_ssn          int = null,
        @s_date         datetime = null,
        @s_user         login = null,
        @s_term         descripcion = null,
        @s_corr         char(1) = null,
        @s_ssn_corr     int = null,
        @s_ofi          tinyint = null,
        @t_rty          char(1) = null,
        @t_trn          smallint = 6373,
        @t_debug        char(1) = 'N',
        @t_file         varchar(14) = null,
        @t_from         varchar(30) = null,
        @i_empresa      tinyint = null,
        @i_operacion    char(1) = null,
        @i_opcion       tinyint = null,
        @i_fecha        datetime = null,
        @i_cuenta       cuenta = null,
        @i_oficina      smallint  = null,
        @i_area         smallint = null,
        @i_ente         int = null,
        @i_documento    char(24) = null,
        @o_saldo        money = null output,
        @o_saldo_me     money = null output,
        @o_debitos      money = null output,
        @o_creditos     money = null output 
)
as

declare @w_today        datetime,
        @w_return       int,
        @w_sp_name      varchar(32),
	@w_fecha_ant    datetime,
        @w_corte_ant    int,
        @w_periodo_ant  int,
	@w_cuenta       cuenta,
	@w_fecha_max    datetime,
	@w_comp_max     int,
	@w_empresa      tinyint,
	@w_oficina      smallint,
	@w_area         smallint,
        @w_ente         int,
	@w_documento    char(24),
        @w_saldo_ant    money,
        @w_saldo_me_ant money,
        @w_debitos      money,
        @w_debitos1     money,
        @w_debitos_me   money,
        @w_creditos     money,
        @w_creditos1    money,
        @w_creditos_me  money

select @w_today = getdate()
select @w_sp_name = 'sp_obtener_saldo_tercero'


/************************************************/
/*  Tipo de Transaccion                         */

if (@t_trn <> 6373)
begin
        /* 'Tipo de transaccion no corresponde' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601077
        return 1
end
/************************************************/ 
--Determina el ultimo dia del mes anterior en base a la fecha enviada
--Tambien se determina el periodo y corte de esa fecha

select @w_fecha_ant = dateadd(dd,datepart(dd,@i_fecha)*-1,@i_fecha)

if @i_operacion = 'I'
begin

select @w_corte_ant = co_corte,
       @w_periodo_ant = co_periodo
from cb_corte
where co_empresa = @i_empresa
  and co_fecha_ini >= @w_fecha_ant
  and co_fecha_ini <= @w_fecha_ant

if @@rowcount <> 0
begin
   insert into cob_conta_tercero..ct_saldo_tercero_tmp
   select *
   from cob_conta_tercero..ct_saldo_tercero
   where st_empresa = @i_empresa
    and  st_periodo = @w_periodo_ant
    and  st_corte   = @w_corte_ant
    
   if @@error != 0
      begin
        /* 'Error al Insertar en Tabla Temporal*/
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_mensaje = 'Error al Insertar en Tabla Temporal',
        @i_num   = 999999
        return 1     
      end
end

   insert into cob_conta_tercero..ct_saldo_tercero_tmp
   select @i_empresa,co_periodo,co_corte,sa_cuenta,sa_oficina_dest,sa_area_dest,
          sa_ente,
          isnull(sa_debito - sa_credito,0),
          isnull(sa_debito_me - sa_credito_me,0),
          isnull(sa_debito,0),
          isnull(sa_credito,0),
          isnull(sa_debito_me,0),
	  isnull(sa_credito_me,0)
 
   from cob_conta_tercero..ct_sasiento,cb_corte,
        cob_conta_tercero..ct_scomprobante
   where sa_empresa = @i_empresa
    and  sa_fecha_tran >  @w_fecha_ant
    and  sa_fecha_tran <= @i_fecha
    and  co_empresa = @i_empresa
    and  co_fecha_ini = sa_fecha_tran
    and  sa_mayorizado = 'S'
    and  (sa_ente is not NULL and sa_ente <> 0)
    and  sc_empresa = @i_empresa
    and  sc_empresa = sa_empresa
    and  sc_producto = sa_producto
    and  sc_comprobante = sa_comprobante
    and  sc_fecha_tran = sa_fecha_tran
 
    /* ACTUALIZAR LA ULTIMA FECHA DE ACTUALIZACION POR CADA CUENTA */
    /* DEFINE UN CURSOR CON TODAS LAS CUENTAS EXISTENTES EN LA TEMPORAL */
    /* Y POR CADA CUENTA BUSCA LA ULTIMA FECHA DE ACTUALIZACION */
    /* YA QUE ESTA NO ES LA MISMA PARA TODAS LAS CUENTAS */

/*
    declare cursor_ctas cursor for
        select  distinct st_empresa,st_cuenta,st_oficina,
			 st_area,st_ente
        from cob_conta_tercero..ct_saldo_tercero_tmp

    open cursor_ctas

    fetch cursor_ctas into @w_empresa,@w_cuenta,@w_oficina,@w_area,@w_ente
			   
    while @@fetch_status = 0
        begin
	  select @w_fecha_max = max(st_ult_fecha)
            from cob_conta_tercero..ct_saldo_tercero_tmp
           where st_empresa = @w_empresa
             and st_cuenta  = @w_cuenta
	     and st_oficina = @w_oficina
	     and st_area    = @w_area
	     and st_ente    = @w_ente
	     

          update cob_conta_tercero..ct_saldo_tercero_tmp
             set st_ult_fecha = @w_fecha_max
	   from cob_conta_tercero..ct_saldo_tercero_tmp
	   where st_empresa = @w_empresa
             and st_cuenta  = @w_cuenta
             and st_oficina = @w_oficina
             and st_area    = @w_area
             and st_ente    = @w_ente

   
          if @@error != 0
             begin
             /* 'Error al Actualizar Maximo Comprobante y Fecha'*/
             exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_mensaje = 'Error al Actualizar Maximo Comprobante y Fecha',
               @i_num   = 999999
               return 1
             end                  
	  
	   select @w_comp_max = max(st_ult_comp)
            from cob_conta_tercero..ct_saldo_tercero_tmp
	    where st_empresa = @w_empresa
             and st_cuenta  = @w_cuenta
             and st_oficina = @w_oficina
             and st_area    = @w_area
             and st_ente    = @w_ente


	   update cob_conta_tercero..ct_saldo_tercero_tmp
             set st_ult_comp = @w_comp_max
           from cob_conta_tercero..ct_saldo_tercero_tmp
	    where st_empresa = @w_empresa
             and st_cuenta  = @w_cuenta
             and st_oficina = @w_oficina
             and st_area    = @w_area
             and st_ente    = @w_ente


           if @@error != 0
             begin
             /* 'Error al Actualizar Maximo Comprobante y Fecha'*/
             exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_mensaje = 'Error al Actualizar Maximo Comprobante y Fecha',
               @i_num   = 999999
               return 1
             end 
	   fetch cursor_ctas into @w_empresa,@w_cuenta,@w_oficina,@w_area,
				  @w_ente,@w_documento   
        end
	close cursor_ctas
        deallocate cursor_ctas
*/


   return 0
end

if @i_operacion = 'Q'
begin
select @w_saldo_ant    = 0
select @w_saldo_me_ant = 0
select @w_debitos      = 0
select @w_debitos1     = 0
select @w_debitos_me   = 0
select @w_creditos     = 0
select @w_creditos1    = 0
select @w_creditos_me  = 0 
select @w_fecha_ant    = dateadd(dd,datepart(dd,@i_fecha)*-1,@i_fecha)
if @i_opcion = 1
begin
  select @w_corte_ant   = co_corte,
         @w_periodo_ant = co_periodo
  from   cob_conta..cb_corte
  where  co_empresa = @i_empresa
  and    co_fecha_ini <= @i_fecha
  and    co_fecha_fin >= @i_fecha

  if @@rowcount = 0
  begin
          /* 'Periodo o corte no existe'*/
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 601078
          return 1
  end 

  select @w_saldo_ant     = sum(st_saldo),
         @w_saldo_me_ant  = sum(st_saldo_me),
         @w_debitos1      = sum(st_mov_debito),
         @w_creditos1     = sum(st_mov_credito)
  from   cob_conta_tercero..ct_saldo_tercero
  where  st_empresa       = @i_empresa
  and    st_periodo       = @w_periodo_ant
  and    st_corte         = @w_corte_ant
  and    st_oficina       in (select je_oficina
                              from   cob_conta..cb_jerarquia
                              where  je_empresa       = @i_empresa
                              and    je_oficina_padre = @i_oficina)
  and    st_area          in (select ja_area
                              from   cob_conta..cb_jerararea
                              where  ja_empresa    = @i_empresa
                              and    ja_area_padre = @i_area)
  and    st_cuenta        like @i_cuenta + '%'
  and    st_ente          = @i_ente


end

if @i_opcion = 2
begin
  select @w_corte_ant = co_corte,
         @w_periodo_ant = co_periodo
  from   cob_conta..cb_corte
  where  co_empresa = @i_empresa
  and    co_fecha_ini <= @w_fecha_ant
  and    co_fecha_fin >= @w_fecha_ant

  if @@rowcount <> 0
  begin

    select @w_saldo_ant     = sum(st_saldo),
           @w_saldo_me_ant  = sum(st_saldo_me),
           @w_debitos1      = sum(st_mov_debito),
           @w_creditos1     = sum(st_mov_credito)
    from   cob_conta_tercero..ct_saldo_tercero
    where  st_empresa       = @i_empresa
    and    st_periodo       = @w_periodo_ant
    and    st_corte         = @w_corte_ant
    and    st_oficina       in (select je_oficina
                                from   cob_conta..cb_jerarquia
                                where  je_empresa       = @i_empresa
                                and    je_oficina_padre = @i_oficina)
    and    st_area          in (select ja_area
                                from   cob_conta..cb_jerararea
                                where  ja_empresa    = @i_empresa
                                and    ja_area_padre = @i_area)
    and    st_cuenta        like @i_cuenta + '%'
    and    st_ente          = @i_ente

  end

  select @w_debitos       = sum(sa_debito),
         @w_creditos      = sum(sa_credito),
         @w_debitos_me    = sum(sa_debito_me),
         @w_creditos_me   = sum(sa_credito_me)
  from   cob_conta_tercero..ct_sasiento --(index i_as_cuenta2)
  where  sa_empresa       = @i_empresa
  and    sa_fecha_tran between dateadd(dd,1,@w_fecha_ant) and @i_fecha
  and    sa_cuenta        like   @i_cuenta + '%'
  and    sa_oficina_dest  in (select je_oficina
                              from   cob_conta..cb_jerarquia
                              where  je_empresa = @i_empresa
                              and    je_oficina_padre = @i_oficina)
  and    sa_area_dest     in (select ja_area
                              from   cob_conta..cb_jerararea
                              where  ja_empresa = @i_empresa
                              and    ja_area_padre = @i_area)
  and    sa_ente          = @i_ente
  and    sa_documento     like @i_documento       
  and    sa_mayorizado    = 'S'
end

select @w_saldo_ant = isnull(@w_saldo_ant,0)
select @w_debitos   = isnull(@w_debitos,0)
select @w_creditos  = isnull(@w_creditos,0)
select @w_debitos1  = isnull(@w_debitos1,0)
select @w_creditos1 = isnull(@w_creditos1,0)
select @w_saldo_me_ant = isnull(@w_saldo_me_ant,0)
select @w_debitos_me   = isnull(@w_debitos_me,0)
select @w_creditos_me  = isnull(@w_creditos_me,0)

select @o_saldo    = @w_saldo_ant + @w_debitos - @w_creditos
select @o_saldo_me = @w_saldo_me_ant + @w_debitos_me - @w_creditos_me   
select @o_debitos  = @w_debitos1 + @w_debitos
select @o_creditos = @w_creditos1 + @w_creditos

return 0
end


go

