/************************************************************************/
/*	Archivo: 		rtefte.sp  			        */
/*	Stored procedure: 	sp_rte_fuente_nit			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Octavio Hoyos F.   	        	*/
/*	Fecha de escritura:     23-Febrero-1996				*/
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
/*	   Consulta para el informe de rte fte por nit                 	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	23/Feb/1996	O. Hoyos        Emision Inicial			*/
/*	15/Dic/1997	J. Gomez        Ingreso de nuevos parametros    */
/*	31/May/1999	J. Gomez 	COR092 JCG20			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_rte_fuente_nit')
   drop proc sp_rte_fuente_nit
go

create proc sp_rte_fuente_nit(
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			char(14) = null,
	@t_from			char(30) = null,
	@i_operacion		char(1),
        @i_empresa              tinyint = null,   /* JCG10 */
	@i_identificacion	char(13) = null,
        @i_ente                 int = null,
	@i_desde		datetime = null,
	@i_hasta		datetime = null,
        @i_tipo_ced             char(2)  = 'N',
	@i_modo                 int      = 0,
        @i_fecha_tran 		datetime = '01/01/1900',
        @i_comprobante		int	 = 0,
        @i_asiento		int      = 0,
	@i_siguiente            int      = 0,
        @i_concepto             char(255)= null,
	@i_cuenta		char(255)= null,
	@i_sub_secuencia        int      = 0,
	@i_secuencia            int      = 0,
	@i_producto		char(3)  = null,
	@i_oficina		smallint = null
)
as
declare	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_codigo	smallint, 
        @w_ente         int,
	@w_msg		varchar(60),
	@w_pos		int,
        @w_aux_concepto char(255),
        @w_cod_ret	varchar(5),                
        @w_tasa1        float,
        @w_tasa2        float

select @w_today = getdate(),
       @w_sp_name = 'sp_rte_fuente_nit'


/************************************************/

if (@t_trn <> 6008 and (@i_operacion = 'E' or @i_operacion = 'F' or 
                        @i_operacion = 'S' or @i_operacion = 'T' or                         
                        @i_operacion = 'W' or @i_operacion = 'Q' or
                        @i_operacion = 'P'))
begin
      /* 'Tipo de transaccion no corresponde' */
     exec cobis..sp_cerror
   	   @t_debug = @t_debug,
 	   @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_num   = 601077
     return 1
end
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
                i_empresa       = @i_empresa,
		i_operacion	= @i_operacion
	exec cobis..sp_end_debug
end

/**** Search ****/
/****************/
if @i_operacion = 'S'
begin
       select 'Fecha ' = sa_fecha_tran,		--JCG20
              'Base Retencion' = sa_base,	--JCG20
              'Valor Retenido' = sa_valret,	--JCG20
              'Concepto' = cr_descripcion
 	 from cob_conta_tercero..ct_sasiento,
--	      cob_conta..cb_tercero,
	      cob_conta..cb_conc_retencion
	where sa_fecha_tran   >=  @i_desde
	  and sa_fecha_tran   <=  @i_hasta
--        and sa_identifica = @i_identificacion
--	  and te_identifica = sa_identifica
          and sa_ente = @i_ente
	  and cr_empresa = @i_empresa   /* JCG10 */
	  and cr_codigo = sa_con_rete
        order by sa_fecha_tran			--JCG20

	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
		exec cobis..sp_cerror
		     @t_debug = @t_debug,
		     @t_file  = @t_file,
		     @t_from  = @w_sp_name,
		     @i_num   = 601146
	   	set rowcount 0
	   	return 1
        end
	set rowcount 0
	return 0
end

/**** Excel ****/
/****************/
if @i_operacion = 'E'
begin
       select 'Fecha ' = convert(varchar,sa_fecha_tran,103),		--JCG20
              'Base Retencion' = sa_base,	--JCG20
              'Valor Retenido' = sa_valret,	--JCG20
              'Concepto' = cr_descripcion
 	 from cob_conta_tercero..ct_sasiento,
	      cobis..cl_ente,
	      cob_conta..cb_conc_retencion
	where sa_fecha_tran   >=  @i_desde
	  and sa_fecha_tran   <=  @i_hasta
--        and sa_identifica = @i_identificacion
--	  and te_identifica = sa_identifica
          and sa_ente = en_ente
	  and en_ced_ruc = @i_identificacion
	  and cr_empresa = @i_empresa   /* JCG10 */
	  and cr_codigo = sa_con_rete
        order by sa_fecha_tran			--JCG20

	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
	   	set rowcount 0
	   	return 1
        end
	set rowcount 0
	return 0
end



/**** Excel *****/
/****************/
if @i_operacion = 'F'
begin        
              
         select
		'Concepto Operacion'=  cr_descripcion,                 
		'Cod Producto'      =  pd_producto,
		'Producto'          =  pd_descripcion,
		'Cuenta'            =  sa_cuenta,
		'Intereses Pagados' =  sa_base,
		'Vr. Rte. Fte'      =  sa_valret                       	              
 	 from cob_conta_tercero..ct_sasiento,
	      cobis..cl_ente, cobis..cl_producto,
	      cob_conta..cb_conc_retencion
	where sa_fecha_tran   >=  @i_desde
	  and sa_fecha_tran   <=  @i_hasta
          and sa_ente = en_ente
	  and en_ced_ruc = @i_identificacion
	  and cr_empresa = @i_empresa  
	  and cr_codigo = sa_con_rete
	  and pd_producto = sa_producto
	  and pd_producto in (14, 4)
        order by sa_fecha_tran		

	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
	   	set rowcount 0
	   	return 1
        end
	set rowcount 0
	return 0
end



/**** Excel *****/
/****************/
if @i_operacion = 'G'
begin                   
 
     set rowcount 25
     if @i_modo = 0
     begin
   
        select 'Oficina'            = convert(varchar(5),of_oficina) + ' - ' + substring(of_descripcion,1,35), 
               'Espacio1'           = '',            --Espacio para mapeo en celdas combinadas excel
               'Concepto Operacion' = cr_descripcion,                 
               'Compro'             = sa_comprobante,
               'Comprobante'        = convert(varchar(12),sa_producto)+"/"+convert(varchar(12),sc_comp_definit), 
               'F. Cont'            = convert(varchar,sa_fecha_tran,103),	
               'Base Impuesto'      = round(sa_base,0),
               '%'                  = ((sa_valret * 100)/sa_base),
               'Vr. Retefuente'     = round(sa_valret,0),
               'Fecha Next'         = convert(varchar(10),sa_fecha_tran,101),
               'Comp  Next'         = sa_comprobante,
               'Asie  Next'         = sa_asiento
        from cob_conta_tercero..ct_sasiento,
             cob_conta_tercero..ct_scomprobante,
	     cob_conta..cb_conc_retencion,
     	     cob_conta..cb_oficina,
             cobis..cl_producto
        where sa_fecha_tran >= @i_desde
          and sa_fecha_tran <= @i_hasta
          and sa_mayorizado  = 'S'
          and sa_ente        = @i_ente
          and sa_debcred     = '2' 
	  and sc_producto    = sa_producto
          and sc_fecha_tran  = sa_fecha_tran
          and sc_comprobante = sa_comprobante
          and sc_empresa     = sa_empresa
          and cr_empresa     = @i_empresa   
          and cr_codigo      = sa_con_rete
          and cr_debcred     = 'C'
          and cr_tipo        = 'R'
          and pd_producto    = sa_producto
          and of_oficina     = sa_oficina_dest
        order by sa_fecha_tran, sa_comprobante, sa_asiento
     end 
     else begin

        select 'Oficina'            = convert(varchar(5),of_oficina) + ' - ' + substring(of_descripcion,1,35), 
               'Espacio1'           = '',             --Espacio para mapeo en celdas combinadas excel
               'Concepto Operacion' = cr_descripcion,                 
               'Compro'             = sa_comprobante,
               'Comprobante'        = convert(varchar(12),sa_producto)+"/"+convert(varchar(12),sc_comp_definit), 
               'F. Cont'            = convert(varchar,sa_fecha_tran,103),	
               'Base Impuesto'      = round(sa_base,0),
               '%'                  = ((sa_valret * 100)/sa_base),
               'Vr. Retefuente'     = round(sa_valret,0),   
               'Fecha Next'         = convert(varchar(10),sa_fecha_tran,101),
               'Comp  Next'         = sa_comprobante,
               'Asie  Next'         = sa_asiento
        from cob_conta_tercero..ct_sasiento,
             cob_conta_tercero..ct_scomprobante,
	     cob_conta..cb_conc_retencion,
     	     cob_conta..cb_oficina,
             cobis..cl_producto
        where sa_fecha_tran >= @i_desde
          and sa_fecha_tran <= @i_hasta
          and sa_mayorizado  = 'S'
          and sa_ente        = @i_ente
          and sa_debcred     = '2'
	  and sc_producto    = sa_producto
          and sc_fecha_tran  = sa_fecha_tran
          and sc_comprobante = sa_comprobante
          and sc_empresa     = sa_empresa
          and cr_empresa     = @i_empresa   
          and cr_codigo      = sa_con_rete
          and cr_debcred     = 'C'
          and cr_tipo        = 'R'
          and pd_producto    = sa_producto
          and of_oficina     = sa_oficina_dest
          and (sa_fecha_tran > @i_fecha_tran 
               or (sa_fecha_tran      = @i_fecha_tran 
                   and sa_comprobante > @i_comprobante)
               or (sa_fecha_tran      = @i_fecha_tran 
                   and sa_comprobante = @i_comprobante
                   and sa_asiento     > @i_asiento))
         order by sa_fecha_tran, sa_comprobante, sa_asiento


     end 


     if @@rowcount = 0
     begin       
          /* 'No existen registros de retencion */
          select @w_msg = '[' + @w_sp_name + '] ' + 'No existen registros'
	  exec cobis..sp_cerror
	       @t_debug = @t_debug,
	       @t_file  = @t_file,
	       @t_from  = @w_sp_name,
	       @i_num   = 601146,
	       @i_msg   = @w_msg
	  set rowcount 0
	  return 1
     end
     set rowcount 0
     return 0
end


/** Excel IVA  **/
/****************/
if @i_operacion = 'K' --- Consulta para certificado de Retencion de IVA 
begin

     create table #codigos
     (codigo char(4) null)

     select @w_aux_concepto = @i_concepto,
            @w_pos = 1
     
     while @w_pos != 0
     begin
           select @w_pos = charindex(',',@w_aux_concepto)

           if @w_pos = 0 or @w_pos is null
              break
      
           insert into #codigos
           values (substring(@w_aux_concepto,1,@w_pos-1))

           select @w_aux_concepto = substring(@w_aux_concepto,@w_pos+1,datalength(@w_aux_concepto))

     end

     set rowcount 20

     if @i_modo = 0
     begin    

        -- Obtiene datos desde los asientos contables
        select 'Oficina ' = convert(varchar(5),of_oficina) + ' - ' + substring(of_descripcion,1,35), 
               'Espacio1' = '',        
               'Concepto' = iva_descripcion,                 
               'Espacio2' = sa_comprobante,
               'Comprob ' = convert(varchar(12),sa_producto)+"/"+convert(varchar(12),sc_comp_definit), 
               'Fecha   ' = convert(varchar,sa_fecha_tran,103),	
               'VAnt IVA' = convert(money,round(sa_valor_iva * 100/iva_des_porcen,0)),
               'Val. IVA' = round(sa_valor_iva,0),   
               '%    IVA' = iva_porcentaje,
               'Ret. IVA' = round(sa_iva_retenido,0),
               'Campo1  ' = '',
               'Campo2  ' = '',
               'Campo3  ' = '',
               'Campo4  ' = '',
               'Campo5  ' = '',
               'FechaNxt' = convert(varchar(10),sa_fecha_tran,101),
               'ComprNxt' = sa_comprobante,
               'AsienNxt' = sa_asiento,
               'Bimestre' = convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2)),
               'RangoBmt' = convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),103) /*+ ' - ' +
                            convert(char(10), dateadd(dd,-1,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),103)*/
        from cob_conta_tercero..ct_sasiento,
             cob_conta_tercero..ct_scomprobante,
	     cob_conta..cb_iva,
     	     cob_conta..cb_oficina,
             cobis..cl_producto,
             #codigos
        where sa_fecha_tran >= @i_desde
          and sa_fecha_tran <= @i_hasta
          and sa_mayorizado  = 'S'
          and sa_ente        = @i_ente
          and sa_empresa     = @i_empresa
          and sa_debcred     = '1'
          and sc_producto    = sa_producto 
          and sc_fecha_tran  = sa_fecha_tran
          and sc_comprobante = sa_comprobante
          and sc_empresa     = sa_empresa
          and iva_empresa    = sa_empresa
          and iva_codigo     = sa_con_iva
          and iva_debcred    = 'D'
          and iva_codigo     = codigo
          and pd_producto    = sa_producto
          and of_empresa     = sa_empresa
          and of_oficina     = sc_oficina_orig
        order by sa_fecha_tran, sa_comprobante, sa_asiento         
      
  
       /*
       -- Obtiene datos desde la tabla de movimientos del sidac       
       select 'Oficina ' = convert(char(5),of_oficina) + ' - ' + substring(of_descripcion,1,35),
              'Espacio1' = '',
              'Concepto' = (select a.valor
                            from cobis..cl_catalogo a,
                            cobis..cl_tabla b
                            where a.tabla  = b.codigo
                              and b.tabla  = 'ac_conceptos_cxp'
                              and a.codigo = c.tm_concepto
                            ),
              'Espacio2' = tm_secuencial,
              'Comprob ' = tm_secuencial,
              'Fecha   ' = convert(char(10),tm_fecha,103),
              'VAnt IVA' = convert(money,round(tm_base * 100/iva_des_porcen,2)),
              'Val. IVA' = tm_base,
              '%    IVA' = tm_porcentaje,
              'Ret. IVA' = tm_valor, 
              'Campo1  ' = '',
              'Campo2  ' = '',
              'Campo3  ' = '',
              'Campo4  ' = '',
              'Campo5  ' = '',
              'FechaNxt' = convert(char(10),tm_fecha,101),
              'ComprNxt' = tm_secuencial,
              'Campo6  ' = '',
              'Bimestre' = convert(int,ceiling(convert(float,datepart(mm,tm_fecha_movimiento))/2)),
              'RangoBmt' = convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,tm_fecha_movimiento))/2))*2,dateadd(dd,-datepart(dy,tm_fecha_movimiento)+1,tm_fecha_movimiento))),103) /*+ ' - ' +
                           convert(char(10),dateadd(dd,-1,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,tm_fecha_movimiento))/2))*2,dateadd(dd,-datepart(dy,tm_fecha_movimiento)+1,tm_fecha_movimiento))),103)*/
       from cob_sidac..sid_tran_monet_his c,
            cob_conta..cb_oficina,
            cob_conta..cb_iva,
            #codigos
       where tm_fecha_movimiento >= @i_desde
         and tm_fecha_movimiento <= @i_hasta
         and tm_filial   = @i_empresa
         and tm_ente     = @i_ente
	 and tm_contabiliza = 'S'
         and tm_concepto_movimiento like 'RET%'
         and of_empresa  = tm_filial
         and of_oficina  = tm_oficina_movimiento 
         and iva_codigo  = tm_concepto_impuesto  
         and iva_debcred = 'D'
         and iva_codigo  = codigo
       order by tm_fecha, tm_secuencial
       */

     end 
     else begin

        -- Obtiene datos desde los asientos contables
        select 'Oficina ' = convert(varchar(5),of_oficina) + ' - ' + substring(of_descripcion,1,35), 
               'Espacio1' = '',        
               'Concepto' = iva_descripcion,                 
               'Espacio2' = sa_comprobante,
               'Comprob ' = convert(varchar(12),sa_producto)+"/"+convert(varchar(12),sc_comp_definit), 
               'Fecha   ' = convert(varchar,sa_fecha_tran,103),	
               'VAnt IVA' = convert(money,round(sa_valor_iva * 100/iva_des_porcen,0)),
               'Val. IVA' = round(sa_valor_iva,0),   
               '%    IVA' = iva_porcentaje,
               'Ret. IVA' = round(sa_iva_retenido,0),
               'Campo1  ' = '',
               'Campo2  ' = '',
               'Campo3  ' = '',
               'Campo4  ' = '',
               'Campo5  ' = '',
               'FechaNxt' = convert(varchar(10),sa_fecha_tran,101),
               'ComprNxt' = sa_comprobante,
               'AsienNxt' = sa_asiento,
               'Bimestre' = convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2)),
               'RangoBmt' = convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),103) /*+ ' - ' +
                            convert(char(10), dateadd(dd,-1,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),103)*/
        from cob_conta_tercero..ct_sasiento,
             cob_conta_tercero..ct_scomprobante,
	     cob_conta..cb_iva,
     	     cob_conta..cb_oficina,
             cobis..cl_producto,
	     #codigos
        where sa_fecha_tran >= @i_desde
          and sa_fecha_tran <= @i_hasta
          and sa_mayorizado  = 'S'
          and sa_ente        = @i_ente
          and sa_empresa     = @i_empresa
          and sa_debcred     = '1'
          and sc_producto    = sa_producto 
          and sc_fecha_tran  = sa_fecha_tran
          and sc_comprobante = sa_comprobante
          and sc_empresa     = sa_empresa
          and iva_empresa    = sa_empresa
          and iva_codigo     = sa_con_iva
          and iva_debcred    = 'D'
          and iva_codigo     = codigo
          and pd_producto    = sa_producto
          and of_empresa     = sa_empresa
          and of_oficina     = sc_oficina_orig
          and (sa_fecha_tran > @i_fecha_tran 
               or (sa_fecha_tran      = @i_fecha_tran 
                   and sa_comprobante > @i_comprobante)
               or (sa_fecha_tran      = @i_fecha_tran 
                   and sa_comprobante = @i_comprobante
                   and sa_asiento     > @i_asiento))
         order by sa_fecha_tran, sa_comprobante, sa_asiento 
       

       /*              
       -- Obtiene datos desde la tabla de movimientos del sidac
       select 'Oficina ' = convert(char(5),of_oficina) + ' - ' + substring(of_descripcion,1,35),
              'Espacio1' = '',
              'Concepto' = (select a.valor
                            from cobis..cl_catalogo a,
                            cobis..cl_tabla b
                            where a.tabla  = b.codigo
                              and b.tabla  = 'ac_conceptos_cxp'
                              and a.codigo = c.tm_concepto
                            ),
              'Espacio2' = tm_secuencial,
              'Comprob ' = tm_secuencial,
              'Fecha   ' = convert(char(10),tm_fecha,103),
              'VAnt IVA' = convert(money,round(tm_base * 100/iva_des_porcen,2)),
              'Val. IVA' = tm_base,
              '%    IVA' = tm_porcentaje,
              'Ret. IVA' = tm_valor,
              'Campo1  ' = '',
              'Campo2  ' = '',
              'Campo3  ' = '',
              'Campo4  ' = '',
              'Campo5  ' = '',
              'FechaNxt' = convert(char(10),tm_fecha,101),
              'ComprNxt' = tm_secuencial,
              'Campo6  ' = '',
              'Bimestre' = convert(int,ceiling(convert(float,datepart(mm,tm_fecha_movimiento))/2)),
              'RangoBmt' = convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,tm_fecha_movimiento))/2))*2,dateadd(dd,-datepart(dy,tm_fecha_movimiento)+1,tm_fecha_movimiento))),103) /*+ ' - ' +
                           convert(char(10),dateadd(dd,-1,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,tm_fecha_movimiento))/2))*2,dateadd(dd,-datepart(dy,tm_fecha_movimiento)+1,tm_fecha_movimiento))),103)*/
       from cob_sidac..sid_tran_monet_his c,
            cob_conta..cb_oficina,
            cob_conta..cb_iva,
            #codigos
       where tm_fecha_movimiento >= @i_desde
         and tm_fecha_movimiento <= @i_hasta
         and tm_filial   = @i_empresa
         and tm_ente     = @i_ente
	 and tm_contabiliza = 'S'
         and tm_concepto_movimiento like 'RET%'
         and of_empresa  = tm_filial
         and of_oficina  = tm_oficina_movimiento 
         and iva_codigo  = tm_concepto_impuesto  
         and iva_debcred = 'D'
         and iva_codigo  = codigo
         and (tm_fecha   > @i_fecha_tran 
               or (tm_fecha = @i_fecha_tran
                   and tm_secuencial > @i_comprobante))               
       order by tm_fecha, tm_secuencial
       */
       
     end 


     if @@rowcount = 0
     begin       
          /* 'No existen registros de retencion */
          select @w_msg = '[' + @w_sp_name + '] ' + 'No existen registros'
	  exec cobis..sp_cerror
	       @t_debug = @t_debug,
	       @t_file  = @t_file,
	       @t_from  = @w_sp_name,
	       @i_num   = 601146,
	       @i_msg   = @w_msg
	  set rowcount 0
	  return 1
     end
     set rowcount 0
     return 0
end


/**** Search ****/
/****************/
if @i_operacion = 'Q'
begin
        select 'Fecha ' = datepart(mm, re_fecha),
               'Concepto' = re_concepto,
               'Valor Retenido' =sum(re_valret),
	       'Base Gravada' = sum(re_base)
	from cob_conta..cb_retencion
	where re_fecha   >=  @i_desde
	  and re_fecha   <=  @i_hasta
        group by datepart( mm , re_fecha ),
	      re_concepto
	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
	   	set rowcount 0
	   	return 1
        end
end



/**** Search ****/
/****************/
if @i_operacion = 'T'
begin
       select 'Fecha ' = convert(varchar,sa_fecha_tran,103),		--JCG20
              'Base Retencion' = sa_base,	--JCG20
              'Valor Retenido' = sa_valor_timbre,	--JCG20
              'Concepto' = cr_descripcion
 	 from cob_conta_tercero..ct_sasiento,
--	      cob_conta..cb_tercero,
	      cob_conta..cb_conc_retencion
	where sa_fecha_tran   >=  @i_desde
	  and sa_fecha_tran   <=  @i_hasta
--        and sa_identifica = @i_identificacion
--	  and te_identifica = sa_identifica
          and sa_ente = @i_ente
	  and cr_empresa = @i_empresa   /* JCG10 */
	  and cr_codigo = sa_con_timbre
	  and isnull(sa_mayorizado,'N') = 'S'
          and cr_tipo = 'T'
        order by sa_fecha_tran			--JCG20

	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
	   	set rowcount 0
	   	return 1
        end
	set rowcount 0
	return 0
end


/**** Search ****/
/****************/
if @i_operacion = 'W'
begin
 
   set rowcount 20
         
   if @i_modo = 0
   begin
          
     select 'Fecha ' = convert(varchar,sa_fecha_tran,103),		
                'Base Retencion' = round(sa_base,0),	
                'Valor Retenido' = round(sa_valor_timbre,0),
                'Comprob '       = convert(varchar(12),sa_producto)+"/"+convert(varchar(12),sc_comp_definit), 
                'Concepto'       = cr_descripcion,                 
                'Blaco2'         = null,                                                 
                'Blaco3'         = null,                                                      
                'Blaco4'         = null,       
                'Blaco5'         = null,                                                      
                'Blaco6'         = null,                                                
                'Comprobante'    = sa_comprobante,  
                'Asiento'        = sa_asiento                                                                                  
 	 from cob_conta_tercero..ct_sasiento,
              cob_conta_tercero..ct_scomprobante,
	      cob_conta..cb_conc_retencion
	where sa_fecha_tran >=  @i_desde
	  and sa_fecha_tran <=  @i_hasta
          and sa_ente        = @i_ente
          and sa_debcred     = '2'
          and sc_producto    = sa_producto 
          and sc_fecha_tran  = sa_fecha_tran
          and sc_comprobante = sa_comprobante
          and sc_empresa     = sa_empresa
	  and cr_empresa     = @i_empresa
	  and cr_codigo      = sa_con_timbre
	  and isnull(sa_mayorizado,'N') = 'S'
          and cr_tipo        = 'T'
          and cr_debcred     = 'C'                       
        order by sa_fecha_tran, sa_comprobante, sa_asiento 	     


	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
               select @w_msg = '[' + @w_sp_name + '] ' + 'No existen registros'
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146,
	        @i_msg   = @w_msg
	   	set rowcount 0
	   	return 1
        end                  
        
    end 
    else
    begin        
    
          select 'Fecha ' = convert(varchar,sa_fecha_tran,103),		
                'Base Retencion' = round(sa_base,0),	
                'Valor Retenido' = round(sa_valor_timbre,0),
                'Comprob '       = convert(varchar(12),sa_producto)+"/"+convert(varchar(12),sc_comp_definit), 
                'Concepto'       = cr_descripcion,  
                'Blaco2'         = null,                                                 
                'Blaco3'         = null,                                                      
                'Blaco4'         = null,                                                      
                'Blaco5'         = null,                                                      
                'Blaco6'         = null,                                                
                'Comprobante'    = sa_comprobante,  
                'Asiento'        = sa_asiento                                                                                   
 	 from cob_conta_tercero..ct_sasiento,
 	      cob_conta_tercero..ct_scomprobante,
	      cob_conta..cb_conc_retencion
	where sa_fecha_tran   >=  @i_desde
	  and sa_fecha_tran   <=  @i_hasta
          and sa_ente          = @i_ente
          and sa_debcred       = '2'
          and sc_producto      = sa_producto 
          and sc_fecha_tran    = sa_fecha_tran
          and sc_comprobante   = sa_comprobante
          and sc_empresa       = sa_empresa
	  and cr_empresa       = @i_empresa 
	  and cr_codigo        = sa_con_timbre
	  and isnull(sa_mayorizado,'N') = 'S'
          and cr_tipo          = 'T'
          and cr_debcred       = 'C'    
          and ( sa_fecha_tran > @i_fecha_tran 
               			 or (sa_fecha_tran  = @i_fecha_tran 
                   		 and sa_comprobante > @i_comprobante)
               			 or (sa_fecha_tran  = @i_fecha_tran 
                   		 and sa_comprobante = @i_comprobante
                   		 and sa_asiento     > @i_asiento) )                   
        order by sa_fecha_tran, sa_comprobante, sa_asiento 	

	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
               select @w_msg = '[' + @w_sp_name + '] ' + 'No existen registros'
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146,
	        @i_msg   = @w_msg
	   	set rowcount 0
	   	return 1
        end                         
    
    end
    
        
	set rowcount 0
	return 0
end



/**** RENDIMIENTOS FINANCIEROS PLAZO FIJO y AHO ****/
/***************************************************/
if @i_operacion = 'P'
begin

   --BUSCA % DE RETENCION
   select @w_cod_ret =  pa_char	
   from cobis..cl_parametro
   where pa_nemonico  = "IMP"
     and pa_producto  = "PFI"

   select @w_tasa1 = cr_porcentaje   
   from cob_conta..cb_conc_retencion
   where cr_codigo = @w_cod_ret
     and cr_tipo   = "R"    
    
   if @@rowcount = 0
   begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,   
              @i_num   = 148145
       	 return 1
   end

   select @w_tasa2 = pa_float
   from cobis..cl_parametro
   where pa_nemonico = "BRTF"
     and pa_producto = "CTE"

   
   if @@rowcount = 0
   begin
         select @w_msg = '[' + @w_sp_name + '] ' + 'No existe parametro de retencion en la fuente'

         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,   
              @i_msg   = @w_msg,
              @i_num   = 201196
       	 return 1    
   end


   set rowcount 20
      
   if @i_modo = 0  --20 Primeros Registros
   begin    
  
    	select Oficina        = convert(varchar(10),mm_oficina) +"-"+ substring(of_descripcion,1,35),
	       Espacio1       = null,
	       pd_abreviatura,
	       Concepto       = 'REND. FINAN.',
	       Num_Banco      = op_num_banco,		
	       Saldo	      = op_monto,
	       Interes        = sum(isnull(mm_valor,0)) + sum(isnull(mm_impuesto,0)) + sum(isnull(mm_ica,0)),
	       Base_Gravable  = (sum (isnull(mm_impuesto,0))*100)/@w_tasa1,       	             
               Total_Impuesto = sum (isnull(mm_impuesto,0)),
               Espacio2       = null,
               Espacio3       = null,
	       OfiNext	      = of_oficina,
               Siguiente      = op_operacion
	from cob_pfijo..pf_mov_monet,
             cob_pfijo..pf_operacion,
             cob_conta..cb_oficina,
	     cobis..cl_producto
	where mm_operacion > 0
  	  and mm_tran      in (14905, 14903)
  	  and mm_secuencia > 0
  	  and mm_secuencia > 0
  	  and mm_estado    = 'A'
  	  and mm_fecha_aplicacion between @i_desde  and @i_hasta
  	  and mm_impuesto  > 0
  	  and mm_beneficiario = @i_ente
  	  and op_operacion = mm_operacion
  	  and of_oficina   = mm_oficina
	  and pd_producto  = 14
	group by pd_abreviatura, mm_oficina,of_descripcion, op_num_banco, op_operacion, of_oficina, op_monto
        union 
        select Oficina       = convert(varchar(10),ah_oficina) +"-"+ substring(of_nombre,1,35),
               Espacio1      = null,
               Producto      = 'AHO',
	       Concepto       = 'REND. FINAN.',
	       Num_Banco     = ah_cta_banco,	
	       Saldo	     = isnull(ah_disponible,0),
               Interes       = isnull(ah_interes_anio,0),
	       Base_Gravable = isnull(ah_rtefte_anio,0)/@w_tasa2,
               Total_Impuesto= isnull(ah_rtefte_anio,0),
               Espacio2      = null,
               Espacio3      = null,
               OfiNext	     = of_oficina,	
	       Siguiente     = ah_cuenta	
        from cob_ahorros..ah_cuenta,
             cobis..cl_oficina,
	     cobis..cl_producto
	where ah_cliente  = @i_ente
          and ah_oficina  = of_oficina
	  and pd_producto = 4
	order by pd_abreviatura, Oficina, Siguiente


	if @@rowcount = 0
	begin
	       /* 'No existen registros de retencion */
               select @w_msg = '[' + @w_sp_name + '] ' + 'No existen registros'
	       exec cobis..sp_cerror
		    @t_debug = @t_debug,
   		    @t_file  = @t_file,
 		    @t_from  = @w_sp_name,
		    @i_num   = 601146,
	            @i_msg   = @w_msg
	       set rowcount 0
	       return 1
        end                
		    
   end
   else
   begin  --20 Siguientes Registros


 	select Oficina         = convert(varchar(10),mm_oficina) +"-"+ substring(of_descripcion,1,35),
	       Espacio1        = null,
	       pd_abreviatura,
	       Concepto       = 'REND. FINAN.',
	       Num_Banco       = op_num_banco,		
	       Saldo	       = op_monto,
	       Interes        = sum(isnull(mm_valor,0)) + sum(isnull(mm_impuesto,0)) + sum(isnull(mm_ica,0)),
	       Base_Gravable   = (sum (isnull(mm_impuesto,0))*100)/@w_tasa1,       	             
               Total_Impuesto  = sum (isnull(mm_impuesto,0)),
               Espacio2        = null,
               Espacio3        = null,
	       OfiNext	       = of_oficina,
               Siguiente       = op_operacion	
	from cob_pfijo..pf_mov_monet,
             cob_pfijo..pf_operacion,
             cob_conta..cb_oficina,
	     cobis..cl_producto
	where mm_operacion >= 0
  	  and mm_tran      in (14905, 14903)
     	  and mm_secuencia >= 0
    	  and mm_secuencia >= 0
  	  and mm_estado    = 'A'
  	  and mm_fecha_aplicacion between @i_desde  and @i_hasta
  	  and mm_impuesto  > 0
  	  and mm_beneficiario = @i_ente
  	  and op_operacion    = mm_operacion
  	  and of_oficina      = mm_oficina
	  and pd_producto     = 14
  	  and (pd_abreviatura > @i_producto 
               or (pd_abreviatura   = @i_producto 
                   and op_oficina   > @i_oficina)
               or (pd_abreviatura   = @i_producto 
                   and op_oficina   = @i_oficina
                   and op_operacion > @i_siguiente)) 
	group by pd_abreviatura, mm_oficina, of_descripcion, op_num_banco, op_operacion, op_monto, of_oficina
        union 
        select Oficina       = convert(varchar(10),ah_oficina) +"-"+ substring(of_nombre,1,35),
               Espacio1      = null,
               pd_abreviatura,
	       Concepto       = 'REND. FINAN.',
	       Num_Banco     = ah_cta_banco,	
	       Saldo	     = isnull(ah_disponible,0),
               Interes       = isnull(ah_interes_anio,0),
	       Base_Gravable = isnull(ah_rtefte_anio,0)/@w_tasa2,
               Total_Impuesto= isnull(ah_rtefte_anio,0),
               Espacio2      = null,
               Espacio3      = null,
	       OfiNext	     = of_oficina,
	       Siguiente     = ah_cuenta	
        from cob_ahorros..ah_cuenta,
             cobis..cl_oficina,
	     cobis..cl_producto
	where ah_cliente  = @i_ente
          and ah_oficina  = of_oficina
	  and pd_producto = 4
  	  and (pd_abreviatura > @i_producto 
               or (pd_abreviatura   = @i_producto 
                   and ah_oficina   > @i_oficina)
               or (pd_abreviatura   = @i_producto 
                   and ah_oficina   = @i_oficina
                   and ah_cuenta    > @i_siguiente)) 
	order by pd_abreviatura, Oficina, Siguiente

	if @@rowcount = 0
	begin
	      /* 'No existen registros de retencion */
              select @w_msg = '[' + @w_sp_name + '] ' + 'No existen registros'

    	      exec cobis..sp_cerror
	 	   @t_debug = @t_debug,
	   	   @t_file  = @t_file,
		   @t_from  = @w_sp_name,
		   @i_num   = 601146,
	           @i_msg   = @w_msg
	      set rowcount 0
	      return 1
         end              	
	  
   end
   
   set rowcount 0
   return 0
   
end


go




