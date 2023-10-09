/************************************************************************/
/*	Archivo: 	        consult1.sp                             */ 
/*	Stored procedure:       sp_consult1                             */ 
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
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta los valores mas importantes de una garantia            */
/*	                                                                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Nov/1995		     Emision Inicial			*/
/*      Dic/2002        JVelandia    cambio nombre de valor actual      */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_consult1')
    drop proc sp_consult1


go
create proc sp_consult1  (
   @s_date               datetime    = null,
   @t_trn                int         = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_filial             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_tipo_cust          varchar(64) = null,
   @i_custodia           int         = null,
   @i_codigo_compuesto   varchar(64) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_estado             catalogo,
   @w_des_est_custodia   descripcion,
   @w_des_ciudad         descripcion,
   @w_des_clase_custodia descripcion,   --FCP Clase de la garantia 
   @w_valor_inicial      float,		--money NVR Mar-5-99,
   @w_moneda             tinyint,
   @w_valor_actual       float,		--money NVR Mar-5-99,
   @w_descripcion        descripcion,
   @w_des_moneda         descripcion,
   @w_fecha_ingreso      datetime,
   @w_cliente            int,
   @w_nombre_cliente     descripcion,
   @w_abierta_cerrada    char(1),
   @w_garante            int,
   @w_des_garante        descripcion,
   @w_des_grado          descripcion,
   @w_estado_comp        descripcion,
   @w_moneda_comp        descripcion,
   @w_cliente_comp       descripcion,
   @w_garante_comp       descripcion,
   @w_ciudad             descripcion,  --MVI 07/11/96 mayor inf.
   @w_direccion          descripcion,
   @w_telefono           varchar(20),
   @w_grado	         tinyint,       
   @w_compartida	 char(1),	
   @w_cuantia            float,          --XVe Oct 25/99
   @w_clase              char(1),
   @w_num_acciones	 int,
   @w_valor_accion	 money,
   @w_entidad_emisora	 int,
   @w_fecha_accion	 datetime,
   @w_des_entidad	 descripcion

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_consult1'

/***********************************************************/
/* Codigos de Transacciones                                */

--if (@t_trn <> 19455 and @i_operacion = 'Q') 
        if @i_codigo_compuesto is not  null
        begin
           exec sp_compuesto
           @t_trn = 19245,
           @i_operacion = 'Q',
           @i_compuesto = @i_codigo_compuesto,
           @o_filial    = @i_filial out,
           @o_sucursal  = @i_sucursal out,
           @o_tipo      = @i_tipo_cust out,
           @o_custodia  = @i_custodia out
       end


if @i_operacion = 'Q'
begin
       select
	   @w_estado            = cu_estado,
	   @w_abierta_cerrada   = cu_clase_custodia, --cu_abierta_cerrada,
	   @w_descripcion       = cu_descripcion,
	   @w_fecha_ingreso     = convert(varchar(10),cu_fecha_ingreso,101),
	   @w_valor_inicial      = isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0)),
	   @w_moneda            = cu_moneda,
	   @w_valor_actual       = isnull(cu_valor_actual, isnull(cu_valor_refer_comis,0)),
	   @w_garante           = cu_garante,
	   @w_ciudad            = convert(varchar(10),cu_ciudad_prenda),
	   @w_direccion         = cu_direccion_prenda,
	   @w_telefono          = cu_telefono_prenda,
	   -- XVE @w_grado             = cu_grado_comp,   --LAL
	   @w_compartida	= cu_compartida,		
	   @w_cuantia           = isnull(cu_vlr_cuantia,0),
	   @w_clase             = cu_abierta_cerrada,
	   @w_num_acciones	= cu_num_acciones,
	   @w_valor_accion	= cu_valor_accion,
	   @w_entidad_emisora	= cu_entidad_emisora,
	   @w_fecha_accion	= cu_fecha_vencimiento -- pga 14jun2001 cu_fecha_accion
	   from cu_custodia
	   where cu_filial   = @i_filial
	   and cu_sucursal = @i_sucursal
	   and cu_tipo     = @i_tipo_cust
	   and cu_custodia = @i_custodia

   if @@rowcount > 0
      select @w_existe = 1
   else
       select @w_existe = 0 

   if @w_existe = 1
   begin

      select @w_des_est_custodia = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla and
      B.tabla = 'cu_est_custodia' and
      A.codigo = @w_estado
      set transaction isolation level read uncommitted

        -- FCP : Inicio 
      select @w_des_clase_custodia = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla and
      B.tabla = 'cu_clase_custodia' and
      A.codigo = @w_abierta_cerrada
      set transaction isolation level read uncommitted

	-- FCP : FIN
set rowcount 1
      select @w_cliente = cg_ente
      from cu_cliente_garantia
      where cg_filial     = @i_filial
      and cg_sucursal   = @i_sucursal
      and cg_tipo_cust  = @i_tipo_cust
      and cg_custodia   = @i_custodia 
      and cg_principal  = 'D'  --XTA 14/OCT/1999
set rowcount 0
      select @w_nombre_cliente = p_p_apellido+' '+p_s_apellido+' '+en_nombre
      from cobis..cl_ente
      where en_ente = @w_cliente
      set transaction isolation level read uncommitted

      select @w_des_entidad = p_p_apellido+' '+p_s_apellido+' '+en_nombre
      from cobis..cl_ente
      where en_ente = @w_entidad_emisora
      set transaction isolation level read uncommitted

      select @w_des_moneda = mo_descripcion
      from cobis..cl_moneda
      where mo_moneda = @w_moneda
         
      select @w_des_ciudad = ci_descripcion
      from cobis..cl_ciudad
      where ci_ciudad = convert(int,@w_ciudad)
      set transaction isolation level read uncommitted

      select @w_des_garante = p_p_apellido+' '+p_s_apellido+' '+en_nombre
      from cobis..cl_ente
      where en_ente = @w_garante 
      set transaction isolation level read uncommitted

      select @w_estado_comp = @w_estado + '   ' + @w_des_est_custodia,
             @w_moneda_comp=convert(varchar(2),@w_moneda)+'   '+@w_des_moneda,
             @w_cliente_comp=convert(varchar(10),@w_cliente)+'   '+@w_nombre_cliente,
             @w_garante_comp=convert(varchar(10),@w_garante)+'   '+@w_des_garante 
      if @w_compartida = 'N'
      begin
         select @w_des_grado = A.valor
         from cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla and
         B.tabla = 'cu_grado_gtia' --and
         --XVE  A.codigo = convert(varchar(1),@w_grado)
         set transaction isolation level read uncommitted
      end 
      select 
      'ESTADO'            = @w_estado_comp,
      'CLASE'             = @w_abierta_cerrada + '   ' + @w_des_clase_custodia, -- FCP 03/10/97 CLASE por ABIERTA/CERRADA
      'FECHA INGRESO'     = convert(varchar(10),@w_fecha_ingreso,103),
    --  'DUENIO'           = @w_cliente_comp,  XTA   14/MAY/1999
	'CONSTITUYENTE'     = @w_cliente_comp,  
      'VALOR GARANTIA'     = convert(money,@w_valor_inicial),
      'VALOR ACEPTADO'      = convert(money,@w_valor_actual),   
      'MONEDA'            = @w_moneda_comp,
      'DESCRIPCION'       = @w_descripcion,
    --'GARANTE'           = @w_garante_comp, --FCP 03/10/97 no se requiere
      'CIUDAD'            = @w_des_ciudad,  --MVI 07/11/96 mas inf.
      'DIRECCION'         = @w_direccion,
      'TELEFONO'          = @w_telefono,
      'COMPARTIDA'	  = @w_compartida,   
      'VALOR CUANTIA'     = convert(money,@w_cuantia),
     -- XVE 'GRADO'             = convert(char(1),@w_grado) + ' ' + @w_des_grado
      'No. ACCIONES'	  = @w_num_acciones,
      'VALOR ACCION'	  = @w_valor_accion,
      'ENTIDAD EMISORA'   = convert(varchar(10),@w_entidad_emisora) +' '+@w_des_entidad,
      'FECHA VENCIMIENTO' = convert(varchar(10),@w_fecha_accion,103)
      select @w_clase
    end
    else
    begin
    /*Registro no existe 
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901005 */
    return 1 
    end  
return 0
end
go