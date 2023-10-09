/************************************************************************/
/*      Archivo:                c_armacuenta                            */
/*      Stored procedure:       sp_arma_cuenta                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Inversiones                             */
/*      Disenado por:           N. Silva                                */
/*      Fecha de escritura:     10/Oct/1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Inserta los asientos de un comprobante a la tabla cb_sasiento a */
/*      no realiza validacion, esta la realiza bt_conta.sp              */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      26-Oct-2001     N. Silva        Emision Inicial                 */
/************************************************************************/   
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_arma_cuenta')
   drop proc sp_arma_cuenta
go

create proc sp_arma_cuenta(
@s_ssn	             int            = null,
@s_date	             datetime       = null,
@s_user	             login          = null,
@s_term	             descripcion    = null,
@s_corr	             char(1)        = null,
@s_ssn_corr          int            = null,
@s_ofi	             int            = null,
@t_rty	             char(1)        = null,
@t_trn	             int            = null,
@t_debug             char(1)        = 'N',
@t_file	             varchar(14)    = null,
@t_from	             varchar(30)    = null,
@i_operacion         char(1)        = null,
@i_fecha_tran        datetime       = null,
@i_empresa           tinyint        = null,
@i_producto 	     int            = null,
@i_cuenta   	     varchar(20)    = null,
@i_oficina_dest      int            = null,
@i_tipo_tran         char(1)        = null,
@i_tipo_doc          char(1)        = null,
@i_moneda            int            = 0,
@i_param1            varchar(20)    = null,
@i_param2            varchar(20)    = null,
@i_param3            varchar(20)    = null,
@i_param4            varchar(20)    = null,
@i_param5            varchar(20)    = null,
@i_param6            varchar(20)    = null,
@i_param7            varchar(20)    = null,
@i_param8            varchar(20)    = null,
@i_param9            varchar(20)    = null,
@i_param10           varchar(20)    = null,
@o_cuenta            varchar(20)    = null out)
with encryption
as 
declare
	@w_today 	   datetime,  	 -- fecha del dia
	@w_return	   int,		 -- valor que retorna
	@w_sp_name	   varchar(32),  -- nombre del stored procedure
	@w_moneda	   int,          -- codigo de moneda de la cuenta
	@w_cuenta	   varchar(20),
        @w_moneda_base     int,
	@w_posini	   int,
        @w_posfin          int,
        @w_count           int,
        @w_clave           varchar(20),
        @w_string          varchar(20),
        @w_string2         varchar(30),
        @w_paso            int,
        @w_moneda_cuenta   int,
        @w_ley             char(1),
        @w_flag            char(1),
        @w_num_anterior    cuenta,
        @w_monto_total     money,
        @w_valor_renovado  money,
        @w_mm_subsecuencia tinyint,
        @w_fecha_valor     datetime,
        @w_reestruc        char(1)        
        
select @w_sp_name = 'sp_arma_cuenta'

-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_today = getdate()
select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa 
 where em_empresa = @i_empresa

select @w_posini = 1, @w_posfin = 0, @w_count = 0

----------------------------------------------------------
-- Proceso para armar cuentas con reemplazo de parametros
----------------------------------------------------------
while @w_posfin < datalength(@i_cuenta)  
begin
   select @w_string = substring(@i_cuenta,@w_posini,datalength(@i_cuenta))
   select @w_posfin = charindex('.',@w_string)
   if @w_posfin = 0
      select @w_posfin = datalength(@i_cuenta)
   else
      select @w_posfin = @w_posfin - 1 
   select @w_string = substring(@i_cuenta,@w_posini,@w_posfin)
   if ascii(@w_string) > 47 and ascii(@w_string) < 58 -- Es Parte numerica
   begin
      select @w_cuenta = @w_cuenta + rtrim(@w_string)
      select @w_posini = @w_posini + @w_posfin + 1 --No considera el punto 
      continue
   end
   select @w_count = @w_count + 1
   select @w_paso = 0
   if @w_count = 1
   begin 
      select @w_clave = @i_param1
      goto ObtieneSubstring
   end
   if @w_count = 2
   begin 
      select @w_clave = @i_param2
      goto ObtieneSubstring
   end
   if @w_count = 3
   begin 
      select @w_clave = @i_param3
      goto ObtieneSubstring
   end
   if @w_count = 4
   begin 
      select @w_clave = @i_param4
      goto ObtieneSubstring
   end
   if @w_count = 5
   begin 
      select @w_clave = @i_param5
      goto ObtieneSubstring
   end
   if @w_count = 6
   begin 
      select @w_clave = @i_param6
      goto ObtieneSubstring
   end
   if @w_count = 7
   begin 
      select @w_clave = @i_param7
      goto ObtieneSubstring
   end
   if @w_count = 8
   begin 
      select @w_clave = @i_param8
      goto ObtieneSubstring
   end
   if @w_count = 9
   begin 
      select @w_clave = @i_param9
      goto ObtieneSubstring
   end
   if @w_count = 10
   begin 
      select @w_clave = @i_param10
      goto ObtieneSubstring
   end

   ------------------------------------------
   -- Obtencion de Substring contable final
   ------------------------------------------
   ObtieneSubstring:
       if @w_clave is null 
       begin 
          if @w_string = 'OFIP' 
             select @w_paso = 1
       end   
       else 
          select @w_paso = 0

       select @w_cuenta = @w_cuenta + rtrim(re_substring)
         from cob_conta..cb_relparam where re_empresa = @i_empresa 
          and re_parametro = @w_string
          and re_clave = @w_clave

       if @@rowcount = 0 and @w_paso = 0
       begin
          return 141145
       end
       select @w_posini = @w_posini + @w_posfin + 1 -- No considera el punto 

End -- fin del while

---------------------------------------------------------------------------------------------------------------------
-- Manejo de excepciones en la contabilizacion contabiliza en moneda nacional o a moneda extranjera
---------------------------------------------------------------------------------------------------------------------
if @i_moneda <> @w_moneda_base 
begin
   select @w_moneda_cuenta = cu_moneda
     from cob_conta..cb_cuenta
    where cu_empresa = @i_empresa
      and cu_cuenta = @w_cuenta
      and cu_movimiento = 'S'
   if @@rowcount = 0 
   begin
       return 141156
   end
   else
      if @w_moneda_cuenta = 0             
      begin
         select @i_moneda = 0
      end
end 

--------------------------------------
-- Si es un impuesto debe registrarse 
--------------------------------------
if @w_string not in ('RETE','IVA')
   select @w_string = null

select @o_cuenta = @w_cuenta

return 0
go
