/************************************************************************/
/*	Archivo: 	        transac1.sp                             */ 
/*	Stored procedure:       sp_transac1                             */ 
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
/*	Consulta de la descripcion y la existencia de las Garantias     */
/*      para las Transacciones de una Garantia                          */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995  L.Castellanos      Emision Inicial            	*/
/*	Dic/1998  N.Velasco          Mapeo campo nuevo autoriza  	*/
/*      Feb/2002  Milena Gonzalez retorno clase custodia y clase cartera*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_transac1')
    drop proc sp_transac1
go
create proc sp_transac1  (
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
   @i_garante  		 int = null,
   @i_opcion             tinyint = null,
   @i_codigo_externo     varchar(64) = null,
   @i_operacion          cuenta      = null,
   @i_formato_fecha      int         = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_contador           tinyint,
   @w_ente               int,
   @w_cliente            descripcion,
   @w_moneda             tinyint,
   @w_codigo_externo     varchar(64),
   @w_autoriza           varchar(25),
   @w_valor_actual       float,
   @w_num_acciones       float,		
   @w_valor_accion	 money,		
   @w_valor_comercial    money,
   @w_porcen_compartida  float,
   @w_valor_recuperado   money,
   @w_cuantia		 char(1),
   @w_valor_cuantia	 money,
   @w_clase_cartera      char(1), --emg
   @w_clase_custodia     char(1), --emg
   @w_des_clase_cartera  descripcion, --emg
   @w_des_clase_custodia descripcion --emg

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_transac1'
/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19584 and @i_operacion = 'S') 
     
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
      exec @w_return = sp_tipo_custodia
      @i_tipo = @i_tipo_cust,
      @t_trn  = 19123,
      @i_operacion = 'V',
      @i_modo = 0

      if @w_return <> 0 
      begin
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

      select cu_estado from cu_custodia
       where cu_filial   = @i_filial
         and cu_sucursal = @i_sucursal
         and cu_tipo     = @i_tipo_cust
         and cu_custodia = @i_custodia 

    -- MVI 07/22/96 para mas informaciona en Modificacion de Valor de Garantia
     exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
          @w_codigo_externo out

     select @w_ente = cg_ente,
            @w_cliente = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
            @w_moneda = cu_moneda,
            @w_valor_actual = isnull(cu_valor_actual, isnull(cu_valor_refer_comis,0)),
	    @w_num_acciones = cu_num_acciones,
	    @w_valor_accion = cu_valor_accion,
	    @w_autoriza = cu_autoriza,	--NVR1
            @w_valor_comercial = cu_valor_inicial,
            @w_porcen_compartida = cu_porcentaje_comp,
            @w_clase_cartera    = cu_clase_cartera, --emg
            @w_clase_custodia   = cu_clase_custodia --emg
     from cu_custodia,cu_cliente_garantia,cobis..cl_ente
     where  cu_codigo_externo = @w_codigo_externo
       and  cg_codigo_externo = @w_codigo_externo
       and  cg_principal      = 'D' --LAL DE S
       and  cg_ente            = en_ente


       select @w_des_clase_cartera = b.valor
       from   cobis..cl_tabla a, cobis..cl_catalogo b
       where  a.tabla = 'cr_clase_cartera'
       and    a.codigo =  b.tabla
       and    b.codigo = @w_clase_cartera
       set transaction isolation level read uncommitted


       select @w_des_clase_custodia = b.valor
       from   cobis..cl_tabla a, cobis..cl_catalogo b
       where  a.tabla = 'cu_clase_custodia'
       and    a.codigo =  b.tabla
       and    b.codigo = @w_clase_custodia
       set transaction isolation level read uncommitted



     	select @w_valor_recuperado = isnull(sum(isnull(re_valor,0)),0)
	from cu_recuperacion
	where re_codigo_externo = @w_codigo_externo
	select @w_cuantia = cu_cuantia,
    	       @w_valor_cuantia = isnull(cu_vlr_cuantia,0)
	from cu_custodia
	where cu_codigo_externo = @w_codigo_externo

     select @w_ente,
            @w_cliente,
            @w_moneda,
            @w_valor_actual,
            convert(char(10),@s_date,@i_formato_fecha), --MVI 08/09/96 
	    @w_num_acciones,
	    @w_valor_accion,
	    @w_autoriza,		
            @w_valor_comercial,
            @w_porcen_compartida,
	    @w_valor_recuperado,
	    @w_cuantia,
	    @w_valor_cuantia,            
            @w_clase_cartera, --emg
            @w_des_clase_cartera, --emg
            @w_clase_custodia, --emg
            @w_des_clase_custodia --emg
  
end
go