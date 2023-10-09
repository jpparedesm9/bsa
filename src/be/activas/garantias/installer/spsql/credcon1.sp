/************************************************************************/
/*	Archivo: 	        credcon1.sp                             */
/*	Stored procedure:       sp_credcon1                             */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces			      	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de Garantias por Cliente                               */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995      L.Castellanos  Emision Inicial			*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_credcon1')
    drop proc sp_credcon1
go
create procedure sp_credcon1(
        @s_ssn                int      = null,
        @s_date               datetime = null,
        @s_user               login    = null,
        @s_term               varchar(64) = null,
        @s_corr               char(1)  = null,
        @s_ssn_corr           int      = null,
        @s_ofi                smallint  = null,
        @t_rty                char(1)  = null,
        @t_trn                smallint = null,
        @t_debug              char(1)  = 'N',
        @t_file               varchar(14) = null,
        @t_from               varchar(30) = null,
        @i_operacion          char(1)  = null,
        @i_modo               smallint = null,
        @i_cliente            int      = null,
        @i_estado             catalogo = null,
        @i_estado1            tinyint  = null,
        @i_codigo_externo     varchar(64) = null,
        @o_total_gar          money out,
        @o_total_op           money out)
as
declare  
        @w_today              datetime,     /* fecha del dia */ 
        @w_return             int,          /* valor que retorna */
        @w_sp_name            varchar(32),  /* nombre stored proc*/

        /* Variables de la operacion de Consulta */
        @w_custodia          int,
        @w_tipo              varchar(64),
        @w_descripcion       varchar(64),
        @w_codigo_externo    varchar(64),
        @w_garantia          varchar(64),
        @w_tramite           int,
        @w_rol               char(1),
        @w_moneda            tinyint,
        @w_valor_actual      money,
        @w_total             money,
        @w_cotizacion        money,
        @w_valor_mn          money,
        @w_valor_me          money,
        @w_total_op          money,
        @w_monto             money,
        @w_estado            catalogo,
        @w_tipo_ant          varchar(64),
        @w_custodia_ant      int,
        @w_ayer              datetime,
        @w_contador          smallint,
        @w_vcu               varchar(64), 
        @w_gar               varchar(64), 
        @w_gac               varchar(64), 
        @w_valor_total       money


select @w_today = @s_date
select @w_sp_name = 'sp_credcon1'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19415 and @i_operacion = 'S') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin

   select @w_gar = pa_char + '%' -- TIPO GARANTIA
  from cobis..cl_parametro
  where pa_producto = 'GAR'
  and pa_nemonico = 'GAR'
  set transaction isolation level read uncommitted

select @w_gac = pa_char + '%' -- TIPO GARANTIA AL COBRO
  from cobis..cl_parametro
  where pa_producto = 'GAR'
  and pa_nemonico = 'GAC'
  set transaction isolation level read uncommitted

select @w_vcu = pa_char + '%' -- TIPO VALORES EN CUSTODIA
  from cobis..cl_parametro
 where pa_producto = 'GAR'
   and pa_nemonico = 'VCU'
  set transaction isolation level read uncommitted

select @w_ayer = convert(char(10),dateadd(dd,-1,@s_date),101)

if @i_estado = 'V' or @i_estado = 'P' or @i_estado = 'E' or @i_estado is null
begin
  if @i_estado = 'V'  -- (V)igentes
  begin
      select @w_estado = @i_estado
      declare cursor_garantia cursor for
      select cu_tipo,cu_codigo_externo,tc_descripcion,cu_valor_inicial,
             cu_moneda
       from cu_cliente_garantia,cu_custodia,cu_tipo_custodia
      where cg_ente            = @i_cliente 
        and cu_filial          = cg_filial
        and cu_sucursal        = cg_sucursal
        and cu_tipo            = cg_tipo_cust
        and cu_custodia        = cg_custodia
        and cu_garante        is null  -- Excluye garantes personales
        and cu_estado          = @w_estado 
        and cu_tipo     not like @w_vcu -- Excluye Valores en custodia
        and tc_tipo            = cu_tipo
        and (cu_codigo_externo > @i_codigo_externo or @i_codigo_externo is null)
      order by cu_codigo_externo
        for read only
   end

  if @i_estado = 'P'  -- (V)igentes
  begin
      select @w_estado = @i_estado
      declare cursor_garantia cursor for
      select cu_tipo,cu_codigo_externo,tc_descripcion,cu_valor_inicial,
             cu_moneda
       from cu_cliente_garantia,cu_custodia,cu_tipo_custodia
      where cg_ente            = @i_cliente 
        and cu_filial          = cg_filial
        and cu_sucursal        = cg_sucursal
        and cu_tipo            = cg_tipo_cust
        and cu_custodia        = cg_custodia
        and cu_garante        is null  -- Excluye garantes personales
        and cu_estado          = @w_estado 
        and cu_tipo     not like @w_vcu -- Excluye Valores en custodias
        and tc_tipo            = cu_tipo
        and (cu_codigo_externo > @i_codigo_externo or @i_codigo_externo is null)
      order by cu_codigo_externo
        for read only
   end


   if @i_estado = 'E'
   begin  --  GARANTIAS EXCEPCIONADAS

     select @w_estado = @i_estado

     declare cursor_garantia cursor for
     select cu_tipo,cu_codigo_externo,tc_descripcion,cu_valor_inicial,
           cu_moneda
       from cu_cliente_garantia,cu_custodia,cu_tipo_custodia
            ,cob_credito..cr_excepciones
      where cg_ente            = @i_cliente 
        and cu_filial          = cg_filial
        and cu_sucursal        = cg_sucursal
        and cu_tipo            = cg_tipo_cust
        and cu_custodia        = cg_custodia
        and cu_garante        is null  -- Excluye garantes personales
        and cu_estado          = @w_estado 
        and cu_tipo     not like @w_vcu -- Excluye simples custodias
        and tc_tipo            = cu_tipo
        and cu_codigo_externo  = ex_garantia
        and (cu_codigo_externo > @i_codigo_externo or @i_codigo_externo is null)
      order by cu_codigo_externo
        for read only
   end

    -- CREACION DE LA TABLA TEMPORAL PARA LA CONSULTA

    create table #cu_seleccion (tipo        varchar(64) null,
                                custodia    varchar(64) null,
                                descripcion varchar(64) null,
                                valor_mn    money null,
                                moneda      tinyint null,
                                valor_me    money  null)

     select @w_valor_total    = isnull(@w_valor_total,0)

   -- EXTRACCION DE DATOS
   open cursor_garantia
   fetch cursor_garantia into @w_tipo,@w_codigo_externo,
                          @w_descripcion,@w_valor_actual,@w_moneda

   if (@@fetch_status != 0)    --  No existen garantias
   begin
     --print "No existen garantias para este cliente"
       select * from #cu_seleccion
     close cursor_garantia
     deallocate cursor_garantia
     return 0
   end

   select @w_contador = 1   -- Para ingresar solo 20 registros
   while (@@fetch_status = 0)  and (@w_contador <=20) -- Lazo de busqueda
   begin
      select @w_contador = @w_contador + 1
     

	select @w_cotizacion = cv_valor
       from cob_conta..cb_vcotizacion
      where cv_moneda     = @w_moneda
        and cv_fecha      in (select max(cv_fecha)
                                from cob_conta..cb_vcotizacion
                               where cv_fecha <= @w_today
                                 and cv_moneda = @w_moneda)


     if @w_cotizacion is null or @w_cotizacion = 0
        select @w_valor_mn = @w_valor_actual,
               @w_valor_me = 0
     else
        select @w_valor_mn = @w_valor_actual * @w_cotizacion,
               @w_valor_me = @w_valor_actual

     select @w_valor_total    = @w_valor_total+@w_valor_mn
     
     insert into #cu_seleccion values(@w_tipo,@w_codigo_externo,@w_descripcion,
                               @w_valor_mn,@w_moneda,@w_valor_me)


     fetch cursor_garantia into @w_tipo,@w_codigo_externo,
                          @w_descripcion,@w_valor_actual,@w_moneda

   end   --  FIN DEL WHILE

   if (@@fetch_status = -1)  -- ERROR DEL CURSOR
   begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909001 
         return 1 
   end
   close cursor_garantia
   deallocate cursor_garantia

   select * from #cu_seleccion
   select @o_total_gar = @w_valor_total
   select @o_total_gar
 end
end
return 0
go