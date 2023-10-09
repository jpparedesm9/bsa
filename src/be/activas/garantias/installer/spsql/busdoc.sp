/************************************************************************/
/*	Archivo: 	        busdoc.sp                               */
/*	Stored pro cedure: 	sp_buscar_documentos			*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Ximena Vega Armas                   	*/
/*	Fecha de escritura:     Noviembre 1999 				*/
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
/*	Permite realizar busqueda de Documentos - Factoring             */
/*      de acuerdo a los par metros enviados por front - end            */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_buscar_documentos')
    drop proc sp_buscar_documentos

go
create proc sp_buscar_documentos
(
   @s_date		 datetime    = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_formato_fecha      int         = null,  --PGA 16/06/2000
   @i_filial             tinyint     = null,
   @i_moneda             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_oficina            smallint    = null,
   @i_tipo               varchar(64) = null,
   @i_estado             catalogo    = null,
   @i_tipo1              descripcion = null,
   @i_cliente            int         = null,
   @i_oficial            int         = null,
   @i_codigo_externo     varchar(64) = null,
   @i_siguiente          varchar(64) = '0',
   @i_condicion_est      tinyint     = null,
   @i_proveedor          int         = null,
   @i_comprador          int         = null,
   @i_fecha_ingreso1     datetime    = null,
   @i_fecha_ingreso2     datetime    = null,
   @i_fecha_vencimiento1 datetime    = null,
   @i_fecha_vencimiento2 datetime    = null,
   @i_fecha_pronto1      datetime    = null,
   @i_fecha_pronto2      datetime    = null,
   @i_documento          varchar(16) = null,
   @i_negocio            varchar(16) = null,
   @i_cliente_sig        int         = 0,
   @i_proveedor_sig      int         = 0,
   @i_num_doc_sig        varchar(16) = '0',
   @i_tipo_doc_sig       varchar(64) = '0'

)
as


declare
   @w_return             int,          /* valor que retorna */
   @w_opcion	         int,
   @w_error              int,          
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_print		 datetime
 

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_buscar_documentos'

if (@t_trn <> 19888)
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1
end           



select @w_error  = 0

if @w_opcion > 15 begin 
   select @w_error  = 10
   goto ERROR
end
 

if @i_operacion = 'S'
begin

   set rowcount 16
   select 
   "TIPO DOCUMENTO"   = convert (varchar(15),B.do_tipo_doc),
   "DESCRIPCION TIPO" = convert(varchar(30),tc_descripcion),
   "No. DOCUMENTO"    = B.do_num_doc,
   "No. NEGOCIO"      = B.do_num_negocio,
   "COD. CLIENTE"     = B.do_proveedor,
   "CLIENTE"          = (select substring(en_nomlar,1,50) from cobis..cl_ente A where en_ente = B.do_proveedor),
   "VLR. NEGOCIACION" = B.do_valor_bruto,
   "VLR. NETO"        = B.do_valor_neto,
   "INI NEGOCIO"      = convert(char(10),B.do_fecha_inineg,103),--@i_formato_fecha),
   "VTO NEGOCIO"      = convert(char(10),B.do_fecha_vtoneg,103),--@i_formato_fecha),
   "COD.PROVEEDOR"    = B.do_cliente,
   "PROVEEDOR"        = (select substring(en_nomlar,1,50) from cobis..cl_ente A where en_ente = B.do_cliente),
   "COD.ESTADO"       = B.do_estado,
   "ESTADO"           = (select valor from cobis..cl_catalogo X, cobis..cl_tabla Y
                            where X.tabla = Y.codigo
                            and Y.tabla = 'cu_est_custodia'
                            and B.do_estado = X.codigo),   
   "MONEDA" = (select mo_descripcion from cobis..cl_moneda
               where mo_moneda = B.do_moneda),
   "AGRUPADO" = B.do_agrupado
  from cu_documentos B, cu_tipo_custodia
  where do_tipo_doc    = tc_tipo
   and B.do_filial     = @i_filial
   and (B.do_sucursal  = @i_sucursal or @i_sucursal is null)
   and (B.do_moneda   = @i_moneda or @i_moneda is null)
   and (B.do_estado   = @i_estado or @i_estado is null)
   and (B.do_tipo_doc = @i_tipo or @i_tipo is null)
   and (B.do_proveedor  = @i_proveedor or @i_proveedor is null)
   and (B.do_cliente = @i_cliente or @i_cliente is null)
   and (B.do_comprador = @i_comprador or @i_comprador is null)
   and (B.do_num_doc = @i_documento or @i_documento is null)
   and (B.do_num_negocio = @i_negocio or @i_negocio is null)
   and (B.do_fecha_inineg >= @i_fecha_ingreso1 or @i_fecha_ingreso1 is null)
   and (B.do_fecha_inineg <= @i_fecha_ingreso2 or @i_fecha_ingreso2 is null)
   and (B.do_fecha_vtoneg >= @i_fecha_vencimiento1 or @i_fecha_vencimiento1 is null)
   and (B.do_fecha_vtoneg <= @i_fecha_vencimiento2 or @i_fecha_vencimiento2 is null)
   and ((B.do_tipo_doc = @i_tipo_doc_sig and B.do_num_doc = @i_num_doc_sig
	     and B.do_proveedor = @i_proveedor_sig and B.do_cliente > @i_cliente_sig)
	or (B.do_tipo_doc = @i_tipo_doc_sig and B.do_num_doc = @i_num_doc_sig
	     and B.do_proveedor > @i_proveedor_sig)
	or (B.do_tipo_doc = @i_tipo_doc_sig and B.do_num_doc > @i_num_doc_sig)
	or (B.do_tipo_doc > @i_tipo_doc_sig))

   order by 
	B.do_tipo_doc,
	B.do_num_doc,
	B.do_proveedor,
	B.do_cliente


   if @@rowcount = 0
   begin
     select @w_error = 1
     goto ERROR
   end
end
return 0
ERROR:
if @w_error = 1 
begin
   print "No existen mas garantias"
   return 1 
end
go