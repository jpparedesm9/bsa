/************************************************************************/
/*	Archivo: 	        migracion.sp                             */ 
/*	Stored procedure:       sp_migracion                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
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
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*      Migracion de las Garantias                                      */
/*	                                                                */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Ene/1997    L.Castellanos      Emision Inicial            	*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_migracion')
    drop proc sp_migracion
go
create proc sp_migracion  (
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
   @i_producto           char(64) = null,
   @i_modo               smallint = null,
   @i_cliente            int = null,
   @i_ente               int = null,
   @i_filial 		 tinyint = null,
   @i_sucursal		 smallint = null,
   @i_tipo_cust		 varchar(64) = null,
   @i_custodia 		 int = null,
   @i_moneda             tinyint = null,
   @i_garante  		 int = null,
   @i_opcion             tinyint = null,
   @i_codigo_externo     varchar(64) = null,
   @i_operacion          cuenta      = null,
   @i_formato_fecha      int         = null,
   @i_gasto_adm          smallint    = null,
   @i_pasar              char(1)     = null,
   @i_consulta           char(1)     = null,
   @i_login              varchar(30) = null,
   @i_accion             char(1)     = null,
   @i_operacion_ant      cuenta      = null,
   @i_externo            varchar(64) = null, --pga27ago2001
   @i_operacion_cartera  int         = null  

)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_status             int,
   @w_contador           tinyint,
   @w_riesgos            char(1),
   @w_abierta_cerrada    char(1),
   @w_codigo_externo     varchar(64),
   @w_des_est_custodia   varchar(64),
   @w_des_abcerrada      varchar(64),
   @w_estado             catalogo,
   @w_moneda             tinyint,
   @w_valor_actual       money,
   @w_oficina            tinyint,
   @w_ente               int,
   @w_cliente            descripcion,
   @w_ofi_contabiliza    smallint,
   @w_contabilizar       char(1),
   @w_operacion_ant      varchar(30),
   @w_operacion_cartera  int,
   @w_desc_estado        varchar(30),  --pga27ago2001
   @w_accion             char(1)

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_migracion'

/***********************************************************/
/* Codigos de Transacciones                                */

/*pga  
if (@t_trn <> 19741 and @i_operacion = 'S')   
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end
pga */

if @i_operacion = 'S' 
begin
   -- CODIGO EXTERNO
   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                   @w_codigo_externo out
   select @w_estado = cu_estado, 
          @w_moneda = cu_moneda,
          @w_valor_actual = cu_valor_actual,
          @w_abierta_cerrada = cu_abierta_cerrada,
          @w_oficina = cu_oficina,
          @w_ofi_contabiliza = cu_oficina_contabiliza
     from cu_custodia
    where cu_codigo_externo = @w_codigo_externo

   select @w_operacion_ant     = go_operacion,
          @w_operacion_cartera = go_operacion_cartera
     from cu_garantia_operacion
    where go_codigo_externo    = @w_codigo_externo
      and go_operacion         = @i_operacion_ant
      --and go_operacion_cartera = @i_operacion_cartera
    order by go_codigo_externo

    if @@rowcount = 0
    begin 
       select @w_accion = 'I'
    end
    else
       begin
          select @w_accion = 'U'
       end

   select @w_ente    = cg_ente,
          @w_cliente = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
   from cu_custodia,cu_cliente_garantia,cobis..cl_ente 
   where cu_codigo_externo = @w_codigo_externo
     and cg_codigo_externo = @w_codigo_externo
     and cg_principal      = 'S'
     and cg_ente           = en_ente

   if @i_consulta = 'S'
   begin
      exec @w_return = sp_tipo_custodia
      @i_tipo = @i_tipo_cust,
      @t_trn  = 19123,
      @i_operacion = 'V',
      @i_modo = 0

      if @w_return <> 0 
      begin
      /* Error de ejecucion  
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 */
         return 1 
      end 

      exec @w_return = sp_custopv
      @i_filial     = @i_filial,
      @i_sucursal   = @i_sucursal,
      @i_tipo       = @i_tipo_cust,
      @i_custodia   = @i_custodia,
      @t_trn        = 19565,
      @i_operacion  = 'B',
      @i_modo       = 0
 
      if @w_return <> 0 
      begin
         return 1 
      end 

      if @w_abierta_cerrada = 'A'
         select @w_des_abcerrada = 'ABIERTA'
      else
         select @w_des_abcerrada = 'CERRADA'

      select @w_des_est_custodia = A.valor
        from cobis..cl_catalogo A,cobis..cl_tabla B
       where B.codigo = A.tabla and
             B.tabla = 'cu_est_custodia' and
             A.codigo = @w_estado
       set transaction isolation level read uncommitted

      select @w_estado,
             @w_des_est_custodia,
             @w_des_abcerrada,
             @w_valor_actual, 
             @w_moneda,
             @w_ente,
             @w_cliente,
             @w_codigo_externo,
             null,
             null
   end  -- Fin de la Consulta
   else -- Se realiza la Transaccion
   begin
      if @w_accion = 'I'
      begin
      begin tran
         --print 'No existe registro'
         insert into cu_garantia_operacion (
                        go_filial,
                        go_sucursal,
                        go_tipo_cust,
                        go_custodia,
                        go_operacion,
                        go_operacion_cartera,
                        go_fecha,
                        go_codigo_externo)                
               values (
                        @i_filial,
                        @i_sucursal,
                        @i_tipo_cust,
                        @i_custodia,
                        @i_operacion_ant,
                        @i_operacion_cartera,
                        @s_date,
                        @w_codigo_externo)
         commit tran
         end  -- Pasar (S)i
         if @w_accion = 'U'
         begin
         begin tran 
               print 'Ya existe registro'
               update cu_garantia_operacion
                  set go_operacion         = @i_operacion_ant,
                      go_operacion_cartera = @i_operacion_cartera,
                      go_fecha             = @s_date    
                where go_codigo_externo = @w_codigo_externo 
                  and go_operacion      = @i_operacion_ant
         commit tran
         end   
   end  -- Transaccion 
end

if @i_operacion = 'C'
begin
   -- CODIGO EXTERNO
   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                   @w_codigo_externo out

   select @w_operacion_ant     = go_operacion,
          @w_operacion_cartera = go_operacion_cartera
     from cu_garantia_operacion
    where go_codigo_externo    = @i_externo
      and go_operacion         = @i_operacion_ant
    order by go_codigo_externo
    select @w_operacion_cartera
-- select * from cob_cartera..ca_operacion
-- where op_estado = 1
end

--pga 27ago2001
if @i_operacion = 'Z'
begin
   select @w_estado          = cu_estado,
          @w_desc_estado     = eg_descripcion, 
          @w_abierta_cerrada = cu_abierta_cerrada,
          @w_valor_actual    = cu_valor_actual,
          @w_moneda          = cu_moneda  
      from cob_custodia..cu_custodia,
           cob_custodia..cu_estados_garantia
      where cu_filial         = @i_filial and
            cu_codigo_externo = @i_externo and
            cu_estado         = eg_estado 
      if @@rowcount = 0 
      begin
         /* No existe el registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1901005
             return 1 
      end

      if @w_abierta_cerrada = 'A'
         select @w_des_abcerrada = 'ABIERTA'
      else
         select @w_des_abcerrada = 'CERRADA'


   select @w_ente    = cg_ente,
          @w_cliente = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
   from cu_custodia,cu_cliente_garantia,cobis..cl_ente 
   where cu_codigo_externo = @i_externo
     and cg_codigo_externo = @i_externo
     and cg_principal      = 'D'
     and cg_ente           = en_ente

   select @w_estado,
          @w_desc_estado,
          @w_abierta_cerrada,
          @w_des_abcerrada,
          @w_valor_actual,
          @w_ente,
          @w_cliente,
          @w_moneda
end
--pga 27ago2001
go