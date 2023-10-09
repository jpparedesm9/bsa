/************************************************************************/
/*	Archivo: 	        cart_ins.sp                             */
/*	Stored procedure:       sp_carta_inspeccion      		*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
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
/*	Obtener la informacion necesaria para llenar la Carta de la     */
/*	inspeccion del o los inspectores ya sea de una carta nueva o    */
/*      una existente.                                                  */    
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995  L.Castellanos       Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_carta_inspeccion')
    drop proc sp_carta_inspeccion
go
create proc sp_carta_inspeccion (
   @s_ssn                int          = null,
   @s_date               datetime     = null,
   @s_user               login        = null,
   @s_term               descripcion  = null,
   @s_corr               char(1)      = null,
   @s_ssn_corr           int          = null,
   @s_ofi                smallint     = null,
   @t_rty                char(1)      = null,
   @t_trn                smallint     = null,
   @t_debug              char(1)      = 'N',
   @t_file               varchar(14)  = null,
   @t_from               varchar(30)  = null,
   @i_operacion          char(1)      = null,
   @i_modo               smallint     = null,
   @i_filial             tinyint      = null,
   @i_tipo               descripcion  = null,
   @i_custodia           int          = null,
   @i_status             char(1)      = null,
   @i_fecha              datetime     = null,
   @i_formato_fecha      int          = null,  --PGA 16/06/2000
   @i_inspector		 int      = null,
   @i_oficial            smallint     = null,
   @i_genlote            tinyint      = null,
   @i_fecha_max_rep      datetime     = null   
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_oficina            descripcion,
   @w_tipo               descripcion,
   @w_custodia           int,
   @w_status             char(  1),
   @w_fecha_ant          datetime,
   @w_inspector          int,
   @w_estado_ant         catalogo,
   @w_inspector_asig     int,
   @w_fecha              datetime,
   @w_principal          descripcion,
   @w_cargo              descripcion,
   @w_nombre             descripcion, 
   @w_mes_actual         tinyint, 
   @w_nro_contratos      tinyint, 
   @w_intervalo          tinyint,
   @w_estado             catalogo,
   @w_cta_inspector      ctacliente,
   @w_especialidad       descripcion,
   @w_direccion          descripcion,
   @w_telefono           char(15),
   @w_nombre_oficial     char(25),
   @w_cont               tinyint, /* Flag para saber si existen prendas */
   @w_lote               tinyint


--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)

select @w_sp_name = 'sp_carta_inspeccion'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19295 and @i_operacion = 'Q') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'Q'
begin


   select 
   @w_inspector = is_inspector,
   @w_cta_inspector = is_cta_inspector,
   @w_nombre = is_nombre,
   @w_especialidad = is_especialidad,
   @w_direccion = is_direccion,
   @w_telefono = is_telefono,
   @w_principal = is_principal,
   @w_cargo = is_cargo
   from cob_custodia..cu_inspector
   where 
   is_inspector = @i_inspector 
   --is_tipo_inspector = 'A'


   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'Q'
begin

   if @i_inspector is NULL or @i_fecha_max_rep is NULL 
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end

/* Consulta opcion QUERY */
/*************************/

   if @i_modo = 1   
   begin
      select @w_nombre = is_nombre
      from cu_inspector
      where is_inspector = @i_inspector
      --and   is_tipo_inspector = 'A'

      select @w_oficina = of_nombre
      from cobis..cl_oficina
      where of_oficina = @s_ofi
      set transaction isolation level read uncommitted

      select 
      @i_inspector, --pga 3jun2001 0,
      @w_nombre,
      @w_principal,
      (select ci_descripcion    --CIUDAD DONDE SE ENVIA LA CARTA 
      from cobis..cl_ciudad
      where ci_ciudad = (select of_ciudad
                         from cobis..cl_oficina
                         where of_oficina = @s_ofi)),
      0,
      convert(char(10),@i_fecha,101),
      "",
      convert(char(10),@i_fecha_max_rep,101),
      @w_oficina

      return 0
   end 
   select 
   @w_inspector = is_inspector,
   @w_cta_inspector = is_cta_inspector,
   @w_nombre = is_nombre,
   @w_especialidad = is_especialidad,
   @w_direccion = is_direccion,
   @w_telefono = is_telefono,
   @w_principal = is_principal,
   @w_cargo = is_cargo
   from cob_custodia..cu_inspector,cu_por_inspeccionar
   where 
   is_inspector = @i_inspector
   and is_inspector = pi_inspector_asig
   --and is_tipo_inspector = 'A'

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
    
   if @w_existe = 1
   begin
      select @w_nro_contratos = 0
      select @w_nro_contratos = count(*)
      from cu_por_inspeccionar,cu_cliente_garantia
      where pi_inspector_asig = @i_inspector
      and pi_inspeccionado  = 'N'  -- (N)o inspeccionadas
      and cg_codigo_externo = pi_codigo_externo
      and (cg_oficial       = @i_oficial or @i_oficial is null)

      select @w_nombre_oficial = fu_nombre
      from cobis..cl_funcionario,cobis..cc_oficial
      where oc_oficial     = @i_oficial
      and oc_funcionario = fu_funcionario
      set transaction isolation level read uncommitted

      select  @w_lote = (select isnull(max(pi_lote),0)+1
                         from cu_por_inspeccionar 
                         where pi_fenvio_carta = @s_date
                         and  pi_codigo_externo > '')

      if @i_genlote = 1 
         select @w_lote = @w_lote - 1
   
      update cu_por_inspeccionar set
      pi_fenvio_carta          = convert(varchar(10),@s_date,101),
      pi_lote                  = @w_lote 
      from   cu_cliente_garantia
      where  pi_inspector_asig = @i_inspector
      and  cg_codigo_externo   = pi_codigo_externo
      and  pi_fenvio_carta   is null
      and  (cg_oficial         = @i_oficial or @i_oficial is null)

      insert into cu_control_inspector(
      ci_inspector, ci_fenvio_carta, ci_fmaxrecep, 
      ci_lote, ci_pago ) 
      values (
      @i_inspector, convert(varchar(10),@s_date,101), convert(varchar(10),
                                                    @i_fecha_max_rep,101),
      @w_lote, 'N')

      select @w_oficina = of_nombre
      from cobis..cl_oficina
      where of_oficina = @s_ofi
      set transaction isolation level read uncommitted

      
      select 
      @w_inspector,
      @w_nombre,
      @w_principal,
      (select ci_descripcion    --CIUDAD DONDE SE ENVIA LA CARTA BCO ESTADO
       from cobis..cl_ciudad
       where ci_ciudad = (select of_ciudad
                          from cobis..cl_oficina
                          where of_oficina = @s_ofi)),
      @w_nro_contratos,
      convert(char(10),@s_date,101),
      @w_nombre_oficial,
      convert(char(10),@i_fecha_max_rep,101),
      @w_oficina 
            
   end

   else
   begin
   /*Registro no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end
   return 0
end
go