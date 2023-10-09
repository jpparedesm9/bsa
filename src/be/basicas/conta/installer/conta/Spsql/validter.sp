/************************************************************************/
/*      Archivo:                validter.sp                             */
/*      Stored procedure:       sp_valida_tercero                       */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Maria Claudia Morales M                 */
/*      Fecha de escritura:     24-Noviembre-1997                       */
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
/*      Este programa valida que la cuenta a ser ingresada no posea     */
/*      saldo.                                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_valida_tercero')
        drop proc sp_valida_tercero
go

create proc sp_valida_tercero   (
	@s_ssn		    int = null,
	@s_date		    datetime = null,
	@s_user		    login = null,
	@s_term		    descripcion = null,
	@s_corr		    char(1) = null,
	@s_ssn_corr	    int = null,
    @s_ofi	        smallint = null,
	@t_rty		    char(1) = null,
    @t_trn		    smallint,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null,
	@t_from         varchar(30) = null,
	@i_cuenta       cuenta,
	@i_empresa      tinyint,
    @i_oficina      smallint,
    @i_area         smallint,
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
    @w_cuenta          cuenta,
    @w_empresa      tinyint,
    @w_tipo         char(1),
    @w_valor        money,
    @w_nombre       varchar(30),
    @w_area         smallint,
    @w_oficina      smallint,
    @w_error        char(1),
    @w_num          int,
    @w_operacion    char(1),
    @w_contador     int,
    @w_respuesta    char(1) 

select @w_respuesta = 'N'    
select @w_sp_name = 'sp_valida_tercero'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6281  and @i_operacion  <> 'Q') and
   (@t_trn <> 6283  and @i_operacion  <> 'S') and 
   (@t_trn <> 6286  and @i_operacion  <> 'E') and  
   (@t_trn <> 6287  and @i_operacion  <> 'T')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 609126
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
                i_area          = @i_area,
                i_operacion     = @i_operacion
	exec cobis..sp_end_debug
end
/* Valida si la cuenta ingresada posee saldo */

if @i_operacion = 'Q'
begin
   select @w_contador = 0

   select @w_contador = count(1)
   from cb_saldo
   where sa_empresa = @i_empresa 
   and sa_cuenta  = @i_cuenta
   and (sa_saldo <> 0 or sa_saldo_me <> 0)

   if @w_contador > 0
      select @w_respuesta = 'S'
   else
   begin
      select @w_respuesta = 'N'
   end

   select ''
   select @w_respuesta

   return 0
end
/* Valida si la cuenta ingresada posee tiene saldo cero MVG */
if @i_operacion = 'E'
   begin
       select 1 from cb_saldo
       where sa_empresa = @i_empresa 
         and sa_area    = @i_area
         and sa_oficina = @i_oficina
         and sa_cuenta  = @i_cuenta
         and sa_saldo   = 0 
       
       if @@rowcount <> 0
            select 'S'
       else
            select 'N' 
  return 0
end  
/* Valida que la cuenta a ser eliminada no posea saldo  */
/* en la tabla de saldos de tercero                     */
if @i_operacion = 'S'
   begin
    --select * from cb_saldo_tercero
    select 1 from cob_conta_tercero..ct_saldo_tercero
    where st_empresa    = @i_empresa
      and st_cuenta     = @i_cuenta
      and st_oficina    = @i_oficina
      and st_area       = @i_area
      and st_saldo      <> 0
    if @@rowcount <> 0
         select 'S'
    else
--    begin
       --if exists (select * from cob_conta_his..cb_hist_saldo_tercero
       --where ht_empresa = @i_empresa 
         --and ht_cuenta = @i_cuenta
	 --and ht_oficina = @i_oficina
	 --and ht_area = @i_area
         --and ht_saldo <> 0)
--
        --if @@rowcount <> 0 
            --select 'S'
       --else
            select 'N'
 --   end
    return 0
   end
/* Valida que la cuenta a ser eliminada este en ceros  */
/* en la tabla de saldos de tercero                     */
if @i_operacion = 'T'
   begin
  --  select * from cb_saldo_tercero
    select 1 from cob_conta_tercero..ct_saldo_tercero
    where st_empresa    = @i_empresa
      and st_cuenta     = @i_cuenta
      and st_oficina    = @i_oficina
      and st_area       = @i_area
      and st_saldo      = 0
    if @@rowcount <> 0
         select 'S'
    else
         select 'N'
    return 0
 end              

go
