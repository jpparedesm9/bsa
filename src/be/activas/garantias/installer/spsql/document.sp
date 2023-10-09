/************************************************************************/
/*	Archivo: 	        document.sp                            */
/*	Stored procedure:       sp_documentos                           */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Xavier Tapia                     	*/
/*	Fecha de escritura:     Octubre-1999  				*/
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
/*	Ingreso,Modificacion y Consulta de los Documentos (Factoring)   */
/*				MODIFICACIONES				*/
/* Etiqueta  FECHA	AUTOR	       	RAZON				*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_documentos')
    drop proc sp_documentos
go
create proc sp_documentos (
   @s_ssn                int          = null,
   @s_date               datetime     = null,
   @s_user               login        = null,
   @s_term               varchar(64)  = null,
   @s_ofi                smallint     = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @t_trn                smallint     = null, 
   @i_operacion          char(1)      = null,
   @i_modo               smallint     = null,  
   @i_filial             tinyint      = null,
   @i_sucursal           smallint     = null,
   @i_nro_documento      varchar(16)  = null,
   @i_proveedor          int = null,
   @i_cliente            int = null,
   @i_valor_bruto        money = null,
   @i_valor_neg          money = null,
   @i_anticipos          money = null,
   @i_por_impuestos      float = null,
   @i_por_retencion      float = null,
   @i_valor_neto         money = null,
   @i_fecha_emision      datetime = null,
   @i_fecha_vtodoc       datetime = null,
   @i_fecha_inineg       datetime = null,
   @i_fecha_vtoneg       datetime = null,
   @i_fecha_pago         datetime = null,
   @i_base_calculo       catalogo = null,
   @i_dias_negocio       int = null,
   @i_num_dex            varchar(16) = null,
   @i_fecha_dex          datetime = null,
   @i_comprador          int = null,
   @i_resp_pago          int = null,
   @i_resp_dscto         int = null,
   @i_num_negocio        varchar(64) = null,
   @i_fecha_proc         datetime = null,
   @i_tipo_doc           varchar(64)  = null,
   @i_moneda             int = null,
   @i_ciudad             int = null,
   @i_observaciones      varchar(255) = null,
   @i_estado             catalogo = null,
   @i_agrupado		 char(1) = null,
   @i_grupo		 int = null,
   @i_fecha_proceso	 datetime = null,
   @i_tipo_doc_sig       varchar(64)  = '0',
   @i_proveedor_sig 	 int = 0,
   @i_num_doc_sig	 varchar(16)  = '0',
   @i_banco              varchar(24) = null,
   @i_fecha_bl           datetime = null
)
as
declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_sucursal           smallint,
   @w_operacion          char(1),
   @w_modo               smallint,
   @w_filial             tinyint,
   @w_nro_documento      varchar(16),
   @w_proveedor          int,
   @w_cliente            int,
   @w_valor_bruto        money,
   @w_anticipos          money,
   @w_por_impuestos      float,
   @w_por_retencion      float,
   @w_valor_neto         money,
   @w_valor_neg          money,
   @w_fecha_emision      datetime,
   @w_fecha_vtodoc       datetime,
   @w_fecha_inineg       datetime,
   @w_fecha_vtoneg       datetime,
   @w_fecha_pago         datetime,
   @w_base_calculo       catalogo,
   @w_dias_negocio       int,
   @w_num_dex            varchar(16),
   @w_fecha_dex          datetime,
   @w_comprador          int,
   @w_resp_pago          int,
   @w_resp_dscto         int,
   @w_num_negocio        varchar(64),
   @w_fecha_proc         datetime,
   @w_tipo_doc           descripcion,
   @w_moneda             int,
   @w_ciudad             int,
   @w_observaciones      varchar(255),
   @w_estado             catalogo,
   @w_agrupado		 char(1),
   @w_grupo		 int,
   @w_fecha_proceso	 datetime,
   @w_descripcion_tipo   descripcion,
   @w_des_estado         descripcion,
   @w_dias_cuota         varchar(254),
   @w_des_cliente	 varchar(254),
   @w_des_proveedor	 varchar(254),
   @w_des_comprador	 varchar(254),
   @w_des_resp_pago	 varchar(254),
   @w_des_resp_dscto	 varchar(254),
   @w_des_est_custodia   varchar(64),
   @w_des_ciudad	 varchar(64),
   @w_des_base_calculo	 varchar(30),
   @w_des_moneda         varchar(30),
   @w_def_moneda         tinyint,
   @w_tramite            int,              --MVI  07/11/2000
   @w_fecha_bl           datetime --EMG 11/28/2000





select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_documentos'

-- print '%1!  op: %2! trn: %3!'+ @w_sp_name + @t_trn + @i_operacion
 
/***********************************************************/

if (@t_trn <> 19887 and @i_operacion = 'I') or
   (@t_trn <> 19887 and @i_operacion = 'U') or
   (@t_trn <> 19887 and @i_operacion = 'Q') or
   (@t_trn <> 19887 and @i_operacion = 'N') or
   (@t_trn <> 19887 and @i_operacion = 'F') or
   (@t_trn <> 19887 and @i_operacion = 'D') or
   (@t_trn <> 19887 and @i_operacion = 'C') or  --MVI 07/11/2000 
   (@t_trn <> 19887 and @i_operacion = 'M') or
   (@t_trn <> 19887 and @i_operacion = 'S')
begin

/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
--    @t_debug = @t_debug,
--    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end
 
--MVI 07/11/2000 manejo de cotizaciones

/* Seleccion de codigo de moneda local */
select @w_def_moneda = pa_tinyint  
from cobis..cl_parametro  
where pa_nemonico = 'MLOCR'  
set transaction isolation level read uncommitted

/* Creacion de tabla temporal para las cotizaciones de las monedas */
CREATE TABLE #cr_cotiz
(	moneda			tinyint null,
	cotizacion		money null
)

/* Manejo de cotizacion */
insert into #cr_cotiz (moneda, cotizacion)
select a.cv_moneda, a.cv_valor
from   cob_conta..cb_vcotizacion a
where  cv_fecha = (select max(b.cv_fecha)
	           from cob_conta..cb_vcotizacion b
	           where b.cv_moneda = a.cv_moneda
	             and b.cv_fecha <= @w_today)

/* insertar un registro para la moneda local */
if not exists (select * from #cr_cotiz
	       where moneda = @w_def_moneda)
   insert into #cr_cotiz (moneda, cotizacion)
   values (@w_def_moneda, 1)

--  print 'do_num_doc %1! do_proveedor %2! do_filial %3! do_num_negocio %4! '+  @i_nro_documento + @i_proveedor + @i_filial + @i_num_negocio 


select 
    @w_filial = do_filial,
    @w_sucursal = do_sucursal,
    @w_num_negocio = do_num_negocio,
    @w_nro_documento = do_num_doc,
    @w_fecha_proc= do_fecha_proc,
    @w_tipo_doc = do_tipo_doc,
    @w_moneda = do_moneda,
    @w_valor_bruto = do_valor_bruto,
    @w_anticipos = do_anticipos,
    @w_por_impuestos  = do_por_impuestos,
    @w_por_retencion = do_por_retencion,
    @w_valor_neto = do_valor_neto,
    @w_ciudad = do_ciudad,
    @w_fecha_emision = do_fecha_emision,
    @w_fecha_vtodoc = do_fecha_vtodoc,
    @w_fecha_inineg = do_fecha_inineg,
    @w_fecha_vtoneg = do_fecha_vtoneg,
    @w_fecha_pago = do_fecha_pago,
    @w_base_calculo = do_base_calculo,
    @w_dias_negocio = do_dias_negocio,
    @w_num_dex = do_num_dex,
    @w_fecha_dex = do_fecha_dex,
    @w_cliente = do_cliente,
    @w_proveedor = do_proveedor,
    @w_comprador = do_comprador,
    @w_resp_pago = do_resp_pago,
    @w_resp_dscto = do_resp_dscto,
    @w_observaciones = do_observaciones,
    @w_estado = do_estado,
    @w_agrupado = do_agrupado,
    @w_grupo = do_grupo,
    @w_valor_neg = do_valor_neg,
    @w_fecha_bl  = do_fecha_bl

from
    cu_documentos
where
    do_num_doc         = @i_nro_documento
    and do_proveedor   = @i_proveedor
    and do_num_negocio = @i_num_negocio
    and do_filial      = @i_filial
  

if @@rowcount > 0
    select @w_existe = 1
else
    select @w_existe = 0




/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion =  'I' or @i_operacion = 'U' 
begin
   if
   @i_nro_documento is null or
   @i_proveedor  is null or
   @i_filial   is null or
   @i_cliente       is null
 
   begin
    /* Campo NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
end


/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
   begin
    /* Registro ya existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1 
   end
   begin tran


      if @i_estado <> 'P'   --Estado Diferente de Propuesto  
      begin
      /* Registro ya existe */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903013
         return 1 
      end

      select @i_dias_negocio = abs(datediff(dd,@i_fecha_vtoneg,@i_fecha_inineg))

/* INSERTA CAMPOS  */  
      insert into cu_documentos(
	do_filial,  do_sucursal,      do_num_negocio,
	do_num_doc, do_fecha_proc,    do_tipo_doc,
	do_moneda,  do_valor_bruto,   do_anticipos,
	do_por_impuestos, do_por_retencion, do_valor_neto,
	do_ciudad,  do_fecha_emision, do_fecha_vtodoc,
	do_fecha_inineg,  do_fecha_vtoneg, do_fecha_pago,
	do_base_calculo,  do_dias_negocio, do_num_dex,
	do_fecha_dex,     do_cliente,      do_proveedor,
	do_comprador,     do_resp_pago,    do_resp_dscto,
	do_observaciones, do_estado,       do_agrupado,
	do_grupo,         do_valor_neg,    do_fecha_bl)
      values(
	@i_filial,        @i_sucursal,    @i_num_negocio,
	@i_nro_documento, @i_fecha_proc,  @i_tipo_doc,
	@i_moneda,        @i_valor_bruto, @i_anticipos ,
	@i_por_impuestos, @i_por_retencion, @i_valor_neto,
	@i_ciudad,        @i_fecha_emision, @i_fecha_vtodoc,
	@i_fecha_inineg,  @i_fecha_vtoneg,  @i_fecha_pago,
	@i_base_calculo,  @i_dias_negocio,  @i_num_dex,
	@i_fecha_dex,     @i_cliente,       @i_proveedor,
	@i_comprador,     @i_resp_pago,     @i_resp_dscto,
	@i_observaciones, @i_estado,        @i_agrupado,
	@i_grupo,         @i_valor_neg,     @i_fecha_bl)
  
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
     end 
   commit tran

/*  select sum(do_valor_neg)
   from cu_documentos 
   where do_num_negocio = @i_num_negocio
*/
   return 0
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
   if @w_existe = 0
   begin
    /* Registro a actualizar no existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905002
      return 1 
   end

   if @i_estado = 'C'
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905016
      return 1 
   end


     if ((@w_agrupado = 'S') --@i_estado = 'P' and @w_grupo is not null)
          or @i_estado = 'V')  --Estado Vigente o  Propuesto  Agrupado
      begin
      /* Registro porque tiene referencias en otras tablas  */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 2107003
         return 1 
      end

      select @i_dias_negocio = abs(datediff(dd,@i_fecha_vtoneg,@i_fecha_inineg))

   begin tran

         update cob_custodia..cu_documentos
         set do_fecha_proc    = @i_fecha_proc,
	     do_tipo_doc      = @i_tipo_doc,
	     do_moneda        = @i_moneda,
	     do_valor_bruto   = @i_valor_bruto,
	     do_anticipos     = @i_anticipos,
	     do_por_impuestos = @i_por_impuestos,
	     do_por_retencion = @i_por_retencion,
	     do_valor_neto    = @i_valor_neto,
	     do_ciudad        = @i_ciudad,
	     do_fecha_emision = @i_fecha_emision,
	     do_fecha_vtodoc  = @i_fecha_vtodoc,
	     do_fecha_inineg  = @i_fecha_inineg,
	     do_fecha_vtoneg  = @i_fecha_vtoneg,
	     do_fecha_pago    = @i_fecha_pago,
	     do_base_calculo  = @i_base_calculo,
	     do_dias_negocio  = @i_dias_negocio,
	     do_num_dex       = @i_num_dex,
	     do_fecha_dex     = @i_fecha_dex,
	     do_cliente       = @i_cliente,
	     do_proveedor     = @i_proveedor,
	     do_comprador     = @i_comprador,
	     do_resp_pago     = @i_resp_pago,
	     do_resp_dscto    = @i_resp_dscto,
	     do_observaciones = @i_observaciones,
	     do_estado        = @i_estado,
	     do_agrupado      = @i_agrupado,
	     do_grupo         = @i_grupo,
	     do_valor_neg     = @i_valor_neg,
             do_fecha_bl      = @i_fecha_bl
         where   
            do_filial          = @i_filial
	    and do_num_doc     = @i_nro_documento
	    and do_proveedor   = @i_proveedor
            and do_num_negocio = @i_num_negocio



     if @@error <> 0 
     begin
         /* Error en insercion de transaccion de servicio */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1903003
        return 1 
     end

   commit tran
   return 0
end

  
/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
    /* Registro a eliminar no existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1907002
      return 1 
   end

      if ((@i_estado = 'P' and @w_grupo is not null)
          or @i_estado = 'V')  --Estado Vigente o  Propuesto  Agrupado
      begin
      /* Registro porque tiene referencias en otras tablas  */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 2107003
         return 1 
      end

    begin tran

       delete cu_documentos
       where
    	do_num_doc = @i_nro_documento
    	and do_proveedor = @i_proveedor
    	and do_filial = @i_filial

   commit tran
   return 0
end


/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
--   print 'antes de existe operacion Q'   
   if @w_existe = 1
   begin
--   print ' operacion Q'   
   select @w_descripcion_tipo = tc_descripcion
   from cu_tipo_custodia
   where tc_tipo = @w_tipo_doc
   
   select @w_des_estado = valor 
   from cobis..cl_catalogo X, cobis..cl_tabla Y
        where X.tabla = Y.codigo
        and Y.tabla = 'cu_est_custodia'
        and  X.codigo = @w_estado
	set transaction isolation level read uncommitted

  
   select @w_des_cliente = en_nomlar 
   from cobis..cl_ente where en_ente = @w_cliente
   set transaction isolation level read uncommitted

   select @w_des_proveedor = en_nomlar 
   from cobis..cl_ente where en_ente = @w_proveedor
   set transaction isolation level read uncommitted

   select @w_des_comprador = en_nomlar
   from cobis..cl_ente where en_ente = @w_comprador
   set transaction isolation level read uncommitted

   select @w_des_resp_pago = en_nomlar 
   from cobis..cl_ente where en_ente = @w_resp_pago
   set transaction isolation level read uncommitted


   select @w_des_resp_dscto = en_nomlar 
   from cobis..cl_ente where en_ente = @w_resp_dscto
   set transaction isolation level read uncommitted



   select @w_des_ciudad = ci_descripcion
   from cobis..cl_ciudad
   where ci_ciudad = @w_ciudad
   and ci_estado = 'V' 
   set transaction isolation level read uncommitted

   select @w_des_base_calculo = A.valor
   from cobis..cl_catalogo A,cobis..cl_tabla B
   where B.codigo = A.tabla
   and B.tabla = 'cu_base_calculo'
   and A.codigo = @w_base_calculo
   set transaction isolation level read uncommitted

   select @w_des_moneda = mo_descripcion
   from cobis..cl_moneda
   where mo_moneda = convert(tinyint,@w_moneda) --emg Ene-16-01 optimizacion

   select 
    @w_filial,  --1
    @w_sucursal,
    @w_num_negocio, 
    @w_nro_documento,
    convert(varchar(10),@w_fecha_proc,103),
    @w_tipo_doc,
    @w_moneda,
    @w_valor_bruto,
    @w_anticipos,
    @w_por_impuestos, --10
    @w_por_retencion,
    @w_valor_neto,
    @w_ciudad,
    convert(varchar(10),@w_fecha_emision,103),
    convert(varchar(10),@w_fecha_vtodoc,103),
    convert(varchar(10),@w_fecha_inineg,103),
    convert(varchar(10),@w_fecha_vtoneg,103),
    convert(varchar(10),@w_fecha_pago,103),
    @w_base_calculo,
    @w_dias_negocio,   --20
    @w_num_dex,
    convert(varchar(10),@w_fecha_dex,103),
    @w_cliente,
    @w_proveedor,
    @w_comprador,
    @w_resp_pago,
    @w_resp_dscto,
    @w_observaciones,
    @w_estado,
    @w_agrupado,    --30
    @w_grupo,        
    @w_valor_neg,
    @w_descripcion_tipo,
    @w_des_estado,	--34
    @w_des_cliente,	
    @w_des_proveedor,	
    @w_des_comprador,	
    @w_des_resp_pago,	
    @w_des_resp_dscto,
    @w_des_ciudad,	--40
    @w_des_base_calculo,
    @w_des_moneda,
    convert(varchar(10),@w_fecha_bl,103)

    return 0
   end
   else
    return 1 
end


if @i_operacion = 'F'
begin
  set rowcount 20
  select 
    'TIPO DOCUMENTO'   = do_tipo_doc,
    'NUMERO DOCUMENTO' = do_num_doc,
    'PROVEEDOR'        = do_cliente,
    'FECHA INI.NEG.'   = convert(char(10),do_fecha_inineg,103),
    'FECHA VCTO.NEG.'  = convert(char(10),do_fecha_vtoneg,103),
    'VALOR NEGOCIO'    = do_valor_neg,
    'VALOR BRUTO'      = do_valor_bruto, 
    'VALOR NEGOCIO ML' = do_valor_neg*(isnull(cotizacion,1)),
    'VALOR NEGOCIO ME' = do_valor_neg,
    'MONEDA' = do_moneda,
    'GRUPO' = do_grupo
  from cu_documentos, #cr_cotiz
  where do_num_negocio = @i_num_negocio
    and do_proveedor = @i_cliente
    and do_moneda = moneda
    and ((do_tipo_doc = @i_tipo_doc_sig  and do_cliente = @i_proveedor_sig 
                and do_num_doc > @i_num_doc_sig)
          or (do_tipo_doc = @i_tipo_doc_sig  and do_cliente > @i_proveedor_sig)
	  or (do_tipo_doc > @i_tipo_doc_sig)) 
  order by 
    do_tipo_doc,
    do_proveedor,   
    do_num_doc
    
  if @@rowcount = 0
  begin
    PRINT 'entro a error por que no encontro registros para el cliente %1!' + cast(@i_cliente as varchar)
    exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = 1901004
     return 1
  end

   select sum(do_valor_neg* isnull(cotizacion,1))
   from cu_documentos,#cr_cotiz 
   where do_num_negocio = @i_num_negocio
     and do_moneda = moneda

end







/*LLamada al sp de cartera para calculo del No. de dias*/
/*******************************************************/
if @i_operacion = 'C'
begin
/*
 exec @w_return = cob_cartera..sp_dias_base_comercial
        @i_fecha_ini = @i_fecha_inineg,
        @i_fecha_ven = @i_fecha_vtoneg,
        @i_opcion    = 'D',
        @o_dias_int  = @w_dias_cuota out

  select @w_dias_cuota
*/
return 0
end


if @i_operacion = 'M'
begin
  set rowcount 20
  select 
    'TIPO DOCUMENTO' = do_tipo_doc,
    'NUMERO DOCUMENTO' = do_num_doc,
    'PROVEEDOR' = do_proveedor,
    'FECHA INI.NEG.' = convert(char(10),do_fecha_inineg,101),
    'FECHA VCTO.NEG.' = convert(char(10),do_fecha_vtoneg,101),
    'VALOR NEGOCIO' = do_valor_neg,
    'MONEDA' = do_moneda,
    'GRUPO' = do_grupo
  from cu_documentos
  where do_num_negocio = @i_num_negocio
    and do_proveedor = @i_cliente
    --and do_grupo is null 
    and (do_moneda = convert(tinyint,@i_moneda) or @i_moneda is null)
    and ((do_tipo_doc = @i_tipo_doc_sig  and do_cliente = @i_proveedor_sig 
                and do_num_doc > @i_num_doc_sig)
          or (do_tipo_doc = @i_tipo_doc_sig  and do_cliente > @i_proveedor_sig)
	  or (do_tipo_doc > @i_tipo_doc_sig)) 
  order by 
    do_tipo_doc,
    do_proveedor,   
    do_num_doc
    
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = 1901004
     return 1
  end
end


if @i_operacion = 'S'
begin

  select @w_tramite = op_tramite
  from cob_cartera..ca_operacion
  where op_banco = @i_banco

  set rowcount 20
  select 'NUMERO DOCUMENTO' = fa_referencia,
         'VALOR DOCUMENTO' = fa_valor,
         'MONEDA' = fa_moneda,
         'FECHA INI.NEG.' = convert(char(10),fa_fecini_neg,101),
         'FECHA VCTO.NEG.' = convert(char(10),fa_fecfin_neg,101),
         'PORCENTAJE' = fa_porcentaje
  from cob_credito..cr_facturas
  where fa_tramite = @w_tramite

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = 1901004
     return 1
  end

  return 0
end

return 0
go


