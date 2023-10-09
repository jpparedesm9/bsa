/************************************************************************/
/*	Archivo: 	        cons_pol.sp  			        */
/*	Stored procedure:       sp_cons_pol 		                */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Nydia Velasco			      	*/
/*	Fecha de escritura:     Febrero-1998  				*/
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
/*	Consulta de polizas de una garantia.    			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cons_pol')
    drop proc sp_cons_pol

go
create proc sp_cons_pol (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
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
   @i_formato_fecha      int      = null,  --PGA 16/06/2000
   @i_filial             tinyint  = null,
   @i_sucursal           smallint = null,
   @i_tipo               descripcion = null,
   @i_custodia           int  = null, 
   @i_cliente            int  = null,
   @i_poliza1            varchar(20)  = null,
   @i_poliza2            varchar(20)  = null,
   @i_poliza3            varchar(20)  = null,
   @i_fecha_vigencia1    datetime  = null,
   @i_fecha_vigencia2    datetime  = null,
   @i_aseguradora        varchar(20)  = null,
   @i_aseguradora1        varchar(20)  = null,
   @i_estado	         catalogo  = null

)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo               descripcion,
   @w_custodia           int,
   @w_estado             catalogo,
   @w_valor_inicial      money,
   @w_valor_actual       money,
   @w_moneda             tinyint,
   @w_cliente            int,
   @w_descripcion        varchar(255),
   @w_des_aseguradora    varchar(255),
   @w_error		 int,
   @w_abier_cerrada      char(1) 

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_cons_pol'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19851 and @i_operacion = 'S') or
   (@t_trn <> 19851 and @i_operacion = 'C') 
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
      set rowcount 20

      if @i_modo = 0
      begin
         select "SECUENCIAL" = cu_custodia,
		"COD.GARANTIA" = substring(p.po_codigo_externo,1,20),
                "TIPO" = cu_tipo,
		"No.POLIZA" =p.po_poliza,
		"ASEG." = p.po_aseguradora,
		"NOM.ASEGURADORA" = valor, --@w_des_aseguradora,
                "ESTADO" = -- p.po_estado_poliza + ' ' +  XTA 21/MAY/1999
                        (select substring(b.valor,1,30)
                         from cobis..cl_tabla a, cobis..cl_catalogo b
                         where a.tabla = 'cu_estado_poliza'
                         and   a.codigo = b.tabla
                         and   b.codigo = p.po_estado_poliza),
      "FECHA VTO INICIO" = convert(char(10),p.po_fvigencia_inicio,@i_formato_fecha),
      "FECHA VTO FIN" = convert(char(10),p.po_fvigencia_fin,@i_formato_fecha),
      "FECHA INICIO ENDOSO " = convert(char(10),p.po_fecha_endozo,@i_formato_fecha),
      "FECHA FIN ENDOSO" = convert(char(10),p.po_fendozo_fin,@i_formato_fecha),
                "OFICINA" = of_nombre
         from cu_custodia,cobis..cl_oficina,cu_poliza p,
		cobis..cl_catalogo A,cobis..cl_tabla B
         where (cu_filial = @i_filial) and               
	       (cu_codigo_externo=po_codigo_externo) and 
               (p.po_poliza >= @i_poliza1 or @i_poliza1 is null) and
               (p.po_poliza <= @i_poliza2 or @i_poliza2 is null) and
            (convert(int,p.po_aseguradora) = convert(int,@i_aseguradora) or convert(int,@i_aseguradora) is null) and
               (p.po_estado_poliza = @i_estado or @i_estado is null) and
               (p.po_fvigencia_fin >= @i_fecha_vigencia1 or
                @i_fecha_vigencia1 is null) and
               (p.po_fvigencia_fin <= @i_fecha_vigencia2 or
                @i_fecha_vigencia2 is null) and
	        B.codigo = A.tabla	and
		B.tabla = 'cu_des_aseguradora'  and
		A.codigo = p.po_aseguradora
                and cu_oficina = of_oficina
                group by convert(int,p.po_aseguradora),p.po_poliza, p.po_codigo_externo,cu_custodia, cu_tipo, valor, p.po_aseguradora,
                                 po_estado_poliza,po_fvigencia_inicio,po_fvigencia_fin,po_fecha_endozo, po_fendozo_fin,of_nombre
                order by convert(int,p.po_aseguradora),p.po_poliza, p.po_codigo_externo,cu_custodia, cu_tipo, valor, p.po_aseguradora,
                                 po_estado_poliza,po_fvigencia_inicio,po_fvigencia_fin,po_fecha_endozo, po_fendozo_fin,of_nombre
-- pga24jul2001  order by cu_tipo,cu_custodia
         if @@rowcount = 0
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1901003
           return 1   -- No existen registros
      end
      else
      begin
         select "SECUENCIAL" = cu_custodia,
		"COD.GARANTIA" = substring(p.po_codigo_externo,1,20),
                "TIPO" = cu_tipo,
		"No.POLIZA" =p.po_poliza,
		"ASEG." = p.po_aseguradora,
		"NOM.ASEGURADORA" = valor, --@w_des_aseguradora,
                "ESTADO" = -- p.po_estado_poliza + ' ' +  XTA 21/MAY/1999
                        (select substring(b.valor,1,30)
                         from cobis..cl_tabla a, cobis..cl_catalogo b
                         where a.tabla = 'cu_estado_poliza'
                         and   a.codigo = b.tabla
                         and   b.codigo = p.po_estado_poliza),
      "FECHA VTO INICIO" = convert(char(10),p.po_fvigencia_inicio,@i_formato_fecha),
      "FECHA VTO FIN" = convert(char(10),p.po_fvigencia_fin,@i_formato_fecha),
      "FECHA INICIO ENDOSO " = convert(char(10),p.po_fecha_endozo,@i_formato_fecha),
      "FECHA FIN ENDOSO" = convert(char(10),p.po_fendozo_fin,@i_formato_fecha),
                "OFICINA" = of_nombre
         from cu_custodia,cobis..cl_oficina,cu_poliza p,
		cobis..cl_catalogo A,cobis..cl_tabla B
         where (cu_filial = @i_filial) and
	       (cu_codigo_externo = po_codigo_externo) and 
               (p.po_poliza >= @i_poliza1 or @i_poliza1 is null) and
               (p.po_poliza <= @i_poliza2 or @i_poliza2 is null) and
               (convert(int,p.po_aseguradora) = convert(int,@i_aseguradora) or convert(int,@i_aseguradora) is null) and
               (p.po_estado_poliza = @i_estado or @i_estado is null) and
               (p.po_fvigencia_fin >= @i_fecha_vigencia1
                or @i_fecha_vigencia1 is null) and             
               (p.po_fvigencia_fin <= @i_fecha_vigencia2
                or @i_fecha_vigencia2 is null) and
               (convert(int,p.po_aseguradora) > convert(int,@i_aseguradora1) or (convert(int,p.po_aseguradora) = convert(int,@i_aseguradora1)
                 and p.po_poliza > @i_poliza3)) and
	        B.codigo = A.tabla	and
		B.tabla = 'cu_des_aseguradora'  and
		A.codigo = p.po_aseguradora
                and cu_oficina = of_oficina
-- pga24jul2001 order by p.po_aseguradora,p.po_poliza 
                group by convert(int,p.po_aseguradora),p.po_poliza, p.po_codigo_externo,cu_custodia, cu_tipo, valor, p.po_aseguradora,
                                 po_estado_poliza,po_fvigencia_inicio,po_fvigencia_fin,po_fecha_endozo, po_fendozo_fin,of_nombre
                order by convert(int,p.po_aseguradora),p.po_poliza, p.po_codigo_externo,cu_custodia, cu_tipo, valor, p.po_aseguradora,
                                 po_estado_poliza,po_fvigencia_inicio,po_fvigencia_fin,po_fecha_endozo, po_fendozo_fin,of_nombre
         if @@rowcount = 0
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1901004
           return 2  -- No existen mas registros
      end
end

if @i_operacion = 'C'
begin

      set rowcount 20

      if @i_modo = 0
      begin
         select distinct "SECUENCIAL" = cu_custodia,
		"COD.GARANTIA" = substring(po_codigo_externo,1,20),
                "TIPO" = cu_tipo,
		"No.POLIZA" =po_poliza,
		"ASEG." = po_aseguradora,
		"NOM.ASEGURADORA" = valor, --@w_des_aseguradora,
                "ESTADO" = po_estado_poliza,
                "FECHA VTO INICIO" = convert(char(10),po_fvigencia_inicio,@i_formato_fecha),
      "FECHA VTO FIN" = convert(char(10),po_fvigencia_fin,@i_formato_fecha),
      "FECHA INICIO ENDOSO " = convert(char(10),po_fecha_endozo,@i_formato_fecha),
      "FECHA FIN ENDOSO" = convert(char(10),po_fendozo_fin,@i_formato_fecha),
                "OFICINA" = of_nombre
         from cu_custodia,cobis..cl_oficina,cu_poliza,cu_cliente_garantia,
		cobis..cl_catalogo A,cobis..cl_tabla B
         where --(of_oficina = @i_sucursal) and
               (cu_filial = @i_filial) and
               --(cu_sucursal = @i_sucursal) and
	       (cu_codigo_externo=po_codigo_externo) and 
               (po_poliza >= @i_poliza1 or @i_poliza1 is null) and
               (po_poliza <= @i_poliza2 or @i_poliza2 is null) and
               (po_aseguradora like @i_aseguradora or @i_aseguradora is null) and
               (po_estado_poliza = @i_estado or @i_estado is null) and
               (po_fvigencia_fin >= @i_fecha_vigencia1 or
                @i_fecha_vigencia1 is null) and
               (po_fvigencia_fin <= @i_fecha_vigencia2 or
                @i_fecha_vigencia2 is null) and
	       (cg_codigo_externo= cu_codigo_externo) and
               (cg_ente = @i_cliente or @i_cliente is null) and
	        B.codigo = A.tabla	and
		B.tabla = 'cu_des_aseguradora'  and
		A.codigo = po_aseguradora
                and cu_oficina = of_oficina

         order by cu_tipo,cu_custodia
         if @@rowcount = 0
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1901003
           return 1   -- No existen registros
      end
      else
      begin
         select distinct "SECUENCIAL" = cu_custodia,
		"COD.GARANTIA" = substring(po_codigo_externo,1,20),
                "TIPO" = cu_tipo,
		"No.POLIZA" =po_poliza,
		"ASEGURADORA" = po_aseguradora,
		"NOM.ASEGURADORA" = valor, --@w_des_aseguradora,
                "ESTADO" = po_estado_poliza,
                "FECHA VENCIMIENTO" = convert(char(10),po_fvigencia_fin,@i_formato_fecha),
                "FECHA ENDOSO" = convert(char(10),po_fecha_endozo,@i_formato_fecha),
                "OFICINA" = of_nombre
         from cu_custodia,cobis..cl_oficina,cu_poliza,cu_cliente_garantia,
		cobis..cl_catalogo A,cobis..cl_tabla B
         where --(of_oficina = @i_sucursal) and
               (cu_filial = @i_filial) and
               --(cu_sucursal = @i_sucursal) and
	       (cu_codigo_externo = po_codigo_externo) and 
               (po_poliza >= @i_poliza1 or @i_poliza1 is null) and
               (po_poliza <= @i_poliza2 or @i_poliza2 is null) and
               (po_aseguradora like @i_aseguradora or @i_aseguradora is null) and
               (po_estado_poliza = @i_estado or @i_estado is null) and
               (po_fvigencia_fin >= @i_fecha_vigencia1
                or @i_fecha_vigencia1 is null) and             
               (po_fvigencia_fin <= @i_fecha_vigencia2
                or @i_fecha_vigencia2 is null) and
               (po_aseguradora > @i_aseguradora1 or (po_aseguradora = @i_aseguradora1
                 and po_poliza > @i_poliza3)) and

	        B.codigo = A.tabla	and
		B.tabla = 'cu_des_aseguradora'  and
		A.codigo = po_aseguradora
                and cu_oficina = of_oficina

         order by po_aseguradora,po_poliza 
         if @@rowcount = 0
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1901004
           return 2  -- No existen mas registros
      end

end

go 
