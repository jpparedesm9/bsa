/************************************************************************/
/*      Archivo:                consop_bv.sp                            */
/*      Stored procedure:       sp_cons_operacion_bv                    */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo-Banca Virtual                */
/*      Disenado por:           Ricardo Alvarez                         */
/*      Fecha de documentacion: 04/18/2000                              */
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
/*      Este programa procesa las transacciones de QUERY a la tabla     */
/*      de operaciones 'pf_operacion' retornando el registro completo   */
/*      con todas las descripciones de las tablas foraneas 'cl_ente',   */
/*      'cl_oficina', 'cl_funcionario', 'cl_producto', 'cl_moneda',     */
/*      'cl_tabla', 'cl_catalogo' y 'pf_ppago',pf_tipo_deposito         */
/*                                                                      */   
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      0/18/2000  Ricardo Alvarez    Creacion                          */
/*      09/20/2001 Memito Saborio     Revision con datos actualizados   */
/*                                    para banca virtual.               */
/************************************************************************/   
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_cons_operacion_bv') is not null
   drop proc sp_cons_operacion_bv
go

create proc sp_cons_operacion_bv (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_operacion            char(1),
      @i_flag                 char(1)           ='N',
      @i_estado1   	          catalogo		='%',	      
      @i_estado2   	          catalogo		='%',
      @i_estado3   	          catalogo		='%',
      @i_accion_sgte          catalogo		='%',
      @i_cuenta               cuenta,
      @i_formato_fecha        int = 0 )  /* GESCY2K B248 */
with encryption
as
declare
      @w_sp_name              varchar(32),
      @o_cant_cupones         smallint,
      @o_op_cupon             char(1),
      @o_num_banco            cuenta,
      @o_cert_origen          cuenta,
      @o_fecha_cert_origen    datetime,
      @o_fecha_cert_origen_temp    datetime,
      @o_tasa_congelado       float,
      @o_num_banco_new        cuenta,
      @o_operacion            int,
      @o_operacion_new        int,
      @o_ente                 int,
      @o_en_nombre_completo   varchar(254),
      @o_toperacion           catalogo,
      @o_desc_toperacion      descripcion,
      @o_categoria            catalogo,
      @o_desc_categoria       descripcion,
      @o_producto             tinyint,
      @o_pd_descripcion       descripcion,
      @o_oficina              smallint,
      @o_ced_ruc              numero,
      @o_of_nombre            descripcion,
      @o_moneda               tinyint,
      @o_mo_descripcion       descripcion,
      @o_num_dias             smallint,
      @o_dias_anio            smallint,
      @o_monto                money,
      @o_monto_pg_int         money,
      @o_moneda_pg           char(2),
      @o_monto_pgdo           money,
      @o_monto_blq            money,
      @o_tasa                 money,
      @o_meses                tinyint,
      @o_int_ganado           money,
      @o_int_estimado         money,
      @w_total                money,
      @o_int_pagados          money,
      @o_int_provision        money,
      @o_total_int_ganados    money,
      @o_total_int_pagados    money,
      @o_total_int_estimado   money,
      @o_total_int_retenido   money,
      @o_tcapitalizacion      char(1),
      @o_fpago                char(3),
      @w_msg                  varchar(30),
      @o_ppago                char(3),
      @o_pp_descripcion       descripcion,
      @o_dia_pago             smallint,
      @o_historia             smallint,
      @o_duplicados           tinyint,
      @o_renovaciones         smallint,
      @o_numdoc               smallint,
      @o_estado               catalogo,
      @o_pignorado            char(1),
      @o_oficial              login,
      @o_telefono             varchar(8),
      @o_telefono2            varchar(8),
      @o_direccion            tinyint,
      @o_casilla              tinyint,
      @o_cd_descripcion       descripcion,
      @o_fu_nombre            descripcion,
      @o_descripcion          varchar(255),
      @o_accion_sgte          catalogo,
      @o_fecha_valor          datetime,
      @o_fecha_ven            datetime,
      @o_fecha_can            datetime,
      @o_fecha_pg_int         datetime,
      @o_fecha_ult_pg_int     datetime,
      @o_fecha_crea           datetime,
      @o_fecha_ult_calculo    datetime,
      @o_fecha_ing            datetime,
      @o_dia_vencido          int,
      @o_ciudad	              descripcion,
      @o_preimpreso           int,
      @o_condicion2           char(1),
      @o_condicion3           char(1),
      @w_dia_vencido	        int,
      @o_retienimp            char(1),
      @o_impuesto	            money,
      @w_tasa	      	        float,
      @w_condicion3	          tinyint,
      @w_condicion2	          tinyint,
      @w_condicion1	          tinyint,
      @w_ente2		            int,
      @w_ente3		            int,
      @w_dias	      	        float,
      @o_fecha_mod            datetime,
      @o_mantiene             char(1),
      @o_alterno3	            char(30),
      @o_disponible           int,
      @o_factor_en_meses      tinyint,
      @o_alterno              char(30),
      @o_num_imp_orig         tinyint,
      @o_dias_antes_impresion tinyint,
      @o_impuesto_capital     money,
      @o_capital_pagado       money,
      @o_ley    	            char(1),
      @o_fecha_cal_tasa       datetime,
      @w_operacion_reprog     int,
      @w_certificado_origen   int,
      @w_tasa_moneda          char(3),
      @o_anio_comercial       char(1), --04/04/2000 Fecha Comercial
      @o_saldo                money,
      @w_return               int,     -- GES 10/04/01 CUZ-031-019
      @o_desc_fpago           descripcion,  -- GES 11/08/01      
      @o_retenido             char(1),      -- GES 11/08/01
      @o_en_subtipo           char(1)

select @w_sp_name = 'sp_cons_operacion_bv',
	@o_num_banco_new=null,
	@o_mantiene='N',
	@o_disponible=0,
	@o_numdoc=0,
	@o_num_imp_orig=0
         
if @t_debug = 'S'
begin
  exec cobis..sp_begin_debug @t_file = @t_file
  select 
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn                       = @s_ssn,
      s_user                      = @s_user,
      s_term                      = @s_term,
      s_date                      = @s_date,
      s_srv                       = @s_srv,
      s_lsrv                      = @s_lsrv,
      s_ofi                       = @s_ofi,
      s_rol                       = @s_rol,
      t_trn                       = @t_trn,
      t_file                      = @t_file,
      t_from                      = @t_from,
      i_cuenta                    = @i_cuenta,
	    i_estado1			= @i_estado1,
	    i_estado2			= @i_estado2,
	    i_estado3			= @i_estado3,
      i_flag                      = @i_flag,
	    i_accion_sgte		= @i_accion_sgte

  exec cobis..sp_end_debug
end

/**  VERIFICAR CODIGO DE TRANSACCION PARA QUERY  **/
if ( @i_operacion = 'Q' ) and ( @t_trn <> 14449 )
begin
  /**  ERROR : CODIGO DE TRANSACCION PARA QUERY NO VALIDO  **/
  exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141042
  return 1
end
  
/**  BUSQUEDA DE OPERACIONES  **/
if @i_operacion = 'Q'
begin
  /**  LECTURA DEL REGISTRO DE OPERACIONES  **/
  select @o_num_banco          = op_num_banco,
         @o_operacion          = op_operacion,
         @o_ente               = op_ente,
         @o_toperacion         = op_toperacion,
         @o_categoria          = op_categoria,
         @o_producto           = op_producto,
         @o_oficina            = op_oficina,
         @o_moneda             = op_moneda,
         @o_num_dias           = op_num_dias,
         @o_telefono           = op_telefono,
         @o_dias_anio          = op_base_calculo,
         @o_monto              = op_monto,
         @o_monto_pg_int       = op_monto_pg_int,
         @o_monto_pgdo         = op_monto_pgdo,
         @o_monto_blq          = op_monto_blq,
         @o_tasa               = convert(money,op_tasa),
         @o_int_ganado         = op_int_ganado,
         @o_int_estimado       = op_int_estimado,
         @o_int_pagados        = op_int_pagados,
         @o_int_provision      = op_int_provision,
         @o_total_int_ganados  = op_total_int_ganados,
         @o_total_int_pagados  = op_total_int_pagados,
         @o_total_int_estimado = op_total_int_estimado,
         @o_total_int_retenido = op_total_int_retenido,
         @o_tcapitalizacion    = op_tcapitalizacion,
         @o_fpago              = op_fpago,
         @o_ppago              = op_ppago,
         @o_dia_pago           = op_dia_pago,
         @o_direccion          = op_direccion,
         @o_casilla            = op_casilla,
         @o_historia           = op_historia,
         @o_duplicados         = op_duplicados,
         @o_renovaciones       = op_renovaciones,
         @o_estado             = op_estado,
         @o_pignorado          = op_pignorado,
         @o_oficial            = op_oficial,
         @o_descripcion        = op_descripcion,
         @o_fecha_ing          = op_fecha_ingreso,
         @o_fecha_valor        = op_fecha_valor,
         @o_fecha_ven          = op_fecha_ven,
         @o_fecha_pg_int       = op_fecha_pg_int,
         @o_fecha_ult_pg_int   = op_fecha_ult_pg_int,
         @o_fecha_ult_calculo   = op_ult_fecha_calculo,
         @o_accion_sgte        = op_accion_sgte,
         @o_fecha_crea         = op_fecha_crea,
         @o_retienimp          = op_retienimp, 
         @o_moneda_pg          = op_moneda_pg, 
         @o_fecha_mod          = op_fecha_mod,
         @o_fecha_can	   = op_fecha_cancela,
         @o_preimpreso         = op_preimpreso,
         @o_num_imp_orig       = op_num_imp_orig ,
         @o_impuesto_capital   = op_impuesto_capital,
         @o_ley   		   = op_ley, 
         @o_fecha_cal_tasa	   = op_ult_fecha_cal_tasa,
	 @o_op_cupon		 = op_cupon
--     @o_anio_comercial     = isnull(op_anio_comercial,'N') --04/04/2000 Fecha Comercial    GES 06/01/2000 Comentado version BCA
  from   pf_operacion
  where  op_num_banco          = @i_cuenta 

  /**  VERIFICAR SI SE ENCONTRO LA OPERACION DESEADA  **/
  if @@rowcount = 0
  begin
    /**  ERROR : NO EXISTE OPERACION  **/
    exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141051
    return 1
  end
	else
	begin
    /* GES 10/18/2000 BCA-062-001 */
    if @o_estado <> 'ACT'
    begin
      exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 141000
      return 1
    end
              
	  if @o_fpago in ('PER','PRA') -- 13-Mar-2000 PRA
	  begin
			select @o_factor_en_meses = pp_factor_en_meses
			from pf_ppago 
			where pp_codigo= @o_ppago
	  end
	end

 	if @o_op_cupon = 'S'
		select @o_cant_cupones = isnull(count(*),0)
		from pf_cuotas
		where cu_operacion = @o_operacion

  if @i_flag = 'S'
  begin
    if exists(select * from pf_tipo_deposito
              where td_mnemonico = @o_toperacion
                and td_mantiene_stock = 'S')      
    begin
      exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 141149
      return 1
    end
  end

 	if @i_flag='N'
	begin
    select @o_mantiene = td_mantiene_stock,
           @o_disponible = td_stock
    from pf_tipo_deposito 
		where td_mantiene_stock = 'S'
      and td_mnemonico = @o_toperacion

		if @o_mantiene = 'S'
		  select @o_numdoc=(select count(*) 
			from pf_det_lote
			where dl_lote=@i_cuenta)  
		end

    if not ((@o_estado like @i_estado1 ) 
       or (@o_estado like @i_estado2  and @o_accion_sgte like @i_accion_sgte)
       or ( @o_estado like @i_estado3 ))
	  begin
      exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141112
      return 1
    end        


    /**VERIFICAR SI LA OPERACION ESTA CONGELADA Y OBTENER EL NUMERO DE CERTIFICADO ANTERIOR**/
	  if @o_ley is not null 
	  begin
			select @w_operacion_reprog = @o_operacion
			while (1=1) 
			begin

				select @w_certificado_origen = re_operacion
				from pf_renovacion,pf_operacion
				where re_operacion = op_operacion 
					and	re_operacion_new = @w_operacion_reprog 
					and op_fecha_valor >= '03/15/1999'

				if @@rowcount > 0 
				begin
			  	select @w_operacion_reprog = @w_certificado_origen
				end
				else
				begin
					--select @w_cert_origen = @w_operacion_reprog
					break
				end

			end	

			select @o_fecha_cert_origen = op_fecha_valor
			from pf_operacion
			where op_operacion = @w_operacion_reprog


			select @w_operacion_reprog = @o_operacion
			while (1=1) 
			begin

				select @w_certificado_origen = re_operacion
				from pf_renovacion,pf_operacion
				where re_operacion = op_operacion 
					and	re_operacion_new = @w_operacion_reprog 
				if @@rowcount > 0 
				begin
			  	select @w_operacion_reprog = @w_certificado_origen
				end
				else
				begin
					--select @w_cert_origen = @w_operacion_reprog
					break
				end
			end	

			select @o_cert_origen = op_num_banco
			from pf_operacion
			where op_operacion = @w_operacion_reprog

			if @o_fecha_cert_origen <'06/14/1999'
			begin
				if @o_moneda = 0
					select @o_tasa_congelado = 40
				if @o_moneda = 1
					select @o_tasa_congelado = 9
				if @o_moneda = 32
					select @o_tasa_congelado = 7
			end
			else
				if @o_fecha_cert_origen <'09/13/1999'
				begin
					if @o_moneda = 0
						select @o_tasa_congelado = 35.62
					if @o_moneda = 1
						select @o_tasa_congelado = 7.31
					if @o_moneda = 32
						select @o_tasa_congelado = 7
				end
				else
				begin
					if @o_moneda = 0
						select @w_tasa_moneda = 'TRS'
					if @o_moneda = 1
						select @w_tasa_moneda = 'TRD'
					if @o_moneda = 32
						select @w_tasa_moneda = 'TRU'

					select @o_tasa_congelado = pa_float 
					from cobis..cl_parametro
					where pa_nemonico = @w_tasa_moneda
						and pa_producto = 'PFI'
				end
			end

      /**  LECTURA DE LOS REGISTROS RELACIONADOS EL REGISTRO DE OPERACION  **/

      select @o_en_nombre_completo = p_p_apellido + ' ' + p_s_apellido + ' '+en_nombre,
      @o_ced_ruc = en_ced_ruc,
      @o_en_subtipo = en_subtipo 
      from   cobis..cl_ente
      where  en_ente           = @o_ente 

      /**************************************
			select @o_pd_descripcion = pd_descripcion
      from   cobis..cl_producto
      where  pd_producto       = @o_producto
			***************************************/

      select 	@o_of_nombre      = of_nombre,
	     				@o_ciudad	       = ci_descripcion
      from cobis..cl_oficina, cobis..cl_ciudad
      where of_oficina        = @o_oficina 
				and of_ciudad	       = ci_ciudad

      select @o_mo_descripcion = mo_descripcion
      from   cobis..cl_moneda
      where  mo_moneda         = @o_moneda

      select 	@o_pp_descripcion = pp_descripcion,
	     				@o_meses = pp_factor_en_meses
      from   pf_ppago
      where  pp_codigo         = @o_ppago 

      select @o_fu_nombre      = fu_nombre
      from   cobis..cl_funcionario
      where  fu_login          = @o_oficial

      select @o_desc_toperacion = td_descripcion
      from pf_tipo_deposito  
      where  @o_toperacion = td_mnemonico    

      select @o_desc_categoria = y.valor
      from   cobis..cl_tabla    x, 
             cobis..cl_catalogo y,
             pf_operacion
      where  x.tabla  = 'pf_categoria'
      	and    x.codigo = y.tabla
      	and    y.codigo = @o_categoria

      if @o_direccion  is not null
	  		select @o_cd_descripcion = di_descripcion
				from cobis..cl_direccion
				where di_ente = @o_ente
		 			and  di_direccion  = @o_direccion
      else
        if @o_casilla is not null
	     		select @o_cd_descripcion = cs_valor 
		   		from cobis..cl_casilla
		   		where cs_ente = @o_ente
		    		and  cs_casilla  = @o_casilla
	  		else
	     		select @o_cd_descripcion = 'Retiene en el BANCO'

      select @w_dia_vencido = datediff(dd,@s_date,@o_fecha_ven)

      if @w_dia_vencido >=0
				select @o_dia_vencido = 0
      else
				select @o_dia_vencido = -@w_dia_vencido

/* GES 10/04/01 CUZ-031-019 COMENTADO
      select @w_tasa = pa_float from cobis..cl_parametro
			where pa_nemonico = 'IMP'
		  	and pa_producto = 'PFI'
   FIN COMENTADO */

      /* GES 09/10/01 CUZ-031-019 BUSQUEDA DE TASA DE RETENCION */
      exec @w_return = sp_impuesto_renta
      @t_trn = 14813,
      @i_tipo = 'N',
      @i_num_banco = @i_cuenta,
      @o_tasa = @w_tasa out
      if @w_return <> 0
      begin
         exec cobis..sp_cerror
         @t_debug=@t_debug,
         @t_file=@t_file,
         @t_from=@w_sp_name,
         @i_num = @w_return
         return @w_return
      end 


      if @o_fpago = 'VEN'
        if @o_total_int_ganados = 0 and @o_total_int_pagados = 0
      		select @w_total = @o_total_int_estimado  - @o_total_int_pagados
		    else
      		select @w_total = @o_total_int_ganados  - @o_total_int_pagados

         --if @o_fpago = 'ANT'
      if @o_fpago in ('ANT','PRA')  -- 13-Mar-2000 PRA
      	select @w_total = @o_total_int_ganados  - @o_total_int_estimado

      if @o_fpago = 'PER'
        if @o_int_ganado = 0 and @o_int_pagados = 0
     			select @w_total = @o_int_estimado  - @o_int_pagados
    		else
     			select @w_total = @o_int_ganado - @o_int_pagados --xca 04/17/98

 			select @o_impuesto = 0

      if @o_retienimp = 'S' 
				select @o_impuesto = @w_total * @w_tasa/100

      /**  ENVIO DE VALORES  **/
      select @w_dias = datediff(dd,@o_fecha_valor,@s_date)

      if @o_estado='REN'
      begin
				select @o_operacion_new=re_operacion_new
				from pf_renovacion
				where re_operacion=@o_operacion

				select @o_num_banco_new=op_num_banco
				from pf_operacion
				where op_operacion=@o_operacion_new
			end

			if @o_duplicados = 99
	     	select @o_duplicados = 0	

      /*******************************
  		if @o_estado = 'ING'
	   		select @o_fecha_ven =  ,
		  				 @o_num_dias = ,
		           @o_fecha_valor =  ,
		  				 @o_int_estimado =
		  				 @o_total_int_estimado
			********************************/

      select @o_dias_antes_impresion = pa_tinyint from cobis..cl_parametro
			where pa_nemonico = 'DIC'
		  	and pa_producto = 'PFI'

			/* CONDICIONES*/
			select @w_condicion1 =dc_condicion
      from pf_det_condicion
      where dc_operacion=@o_operacion
        and dc_ente=@o_ente

			set rowcount  1
			select @w_ente2 =be_ente 
			from pf_beneficiario
			where be_operacion = @o_operacion
				and be_rol = 'A'
			if @@rowcount <> 0 
	  	begin	
      	select @o_alterno = p_p_apellido + ' ' + p_s_apellido + ' '+en_nombre
      	from   cobis..cl_ente
      	where  en_ente           = @w_ente2 

				select @w_condicion2 =dc_condicion
        from pf_det_condicion
        where dc_operacion=@o_operacion
        	and dc_ente=@w_ente2

				if @w_condicion1 <> @w_condicion2
					select @o_condicion2 = 'O'
				else 
					select @o_condicion2 = 'Y'

				set rowcount 1
				select @w_ente3 =be_ente 
				from pf_beneficiario
				where be_operacion = @o_operacion
					and be_rol = 'A'
					and be_ente <> @w_ente2
		
				if @@rowcount <> 0
				begin
     			select @o_alterno3 = p_p_apellido + ' ' + p_s_apellido + ' '+en_nombre
     			from   cobis..cl_ente
     			where  en_ente           = @w_ente3 

				select @w_condicion3 =dc_condicion
        from pf_det_condicion
        where dc_operacion=@o_operacion
        	and dc_ente=@w_ente3

				if @w_condicion2 <> @w_condicion3
					select @o_condicion3 = 'O'
				else 
					select @o_condicion3 = 'Y'
			end
			else
				select @o_condicion3 = ''
		end
		else
			select @o_condicion2 = ''


		/* CAPITAL PAGADO*/
 		select @o_capital_pagado =pa_money 
		from cobis..cl_parametro
    where pa_nemonico = 'PROVCB' 

		/* SEGUNGO TELEFONO*/
 		select @o_telefono2 =te_valor 
		from cobis..cl_telefono
    where te_ente = @o_ente 
			and te_direccion = @o_direccion 
			and te_secuencial = 2

    /* GES 11/08/01 Se aumenta descripcion de forma de pago */
    select @o_desc_fpago = a.valor
    from cobis..cl_catalogo a, cobis..cl_tabla b
    where a.codigo = @o_fpago
    and a.tabla = b.codigo
    and b.tabla = 'pf_forma_pago'
    

    select @o_saldo = @o_monto + @o_total_int_ganados /* GES 07/24/2000 Saldo para enviar a consulta de IVR */

    select 'Tipo de operacion'     = @o_desc_toperacion,
           'N£mero de Dep¢sito'    = @o_num_banco, --GB-DP00158
           'Bloqueado'             = @o_retenido, 
           'Pignorado'             = @o_pignorado,
           'Moneda'                = substring(@o_mo_descripcion,1,7),
           'Monto'                 = @o_monto,
           'Monto + Interes gan. ' = @o_saldo,
           'Plazo (dias)'          = @o_num_dias,
           'Interes'               = @o_int_ganado, 
           'Fecha de Apertura'     = convert(char(10),@o_fecha_ing,@i_formato_fecha),
           'Fecha de Inicio'       = convert(char(10),@o_fecha_valor, @i_formato_fecha), --GB-DP00158
           'Fecha de Vencimiento'  = convert(char(10),@o_fecha_ven, @i_formato_fecha),
           'Tasa (%)'              = @o_tasa,
           'Proximo pago de int.'  = convert(char(10),@o_fecha_pg_int,@i_formato_fecha),
           'Forma de pago'         = @o_desc_fpago,
           'Cantidad de cupones'   = @o_cant_cupones,
           'Cliente'               = @o_ente, 
           'Tipo'                  = @o_en_subtipo,
           'Nombre'                = @o_en_nombre_completo,
           'Intereses Devengados'  = @o_total_int_ganados --GAR GB-DP00158
    
    
     /*******************************************************************************         
       'TOTAL INT PAGADOS: ' = @o_total_int_pagados,
       'TOTAL INT ESTIMADOS:'= @o_total_int_estimado,
       'CLIENTE TITULAR: ' = @o_ente,
       'NOMBRE:         '  = @o_en_nombre_completo,
       'CATEGORIA:         ' = @o_desc_categoria,
       'OFICINA APERTURA:  ' = @o_of_nombre, 
       'MONTO ACTUAL:  '     = @o_monto_pg_int, 
       'MONTO EN GARANTIA: ' = @o_monto_pgdo,
       'MONTO BLOQUEADO '    = @o_monto_blq,
			 'CAPITALIZA INTERESES: '=@o_tcapitalizacion, 
       'PERIODO CAP/PAGO: '    =@o_pp_descripcion,
       'DUPLICADOS:       '    =@o_duplicados,
       'RENOVACIONES:     '    =@o_renovaciones,
       'ESTADO:           '    =@o_estado,
       'ESTA EN GARANTIA? '    =@o_pignorado,
       'OFICIAL:          '    =@o_fu_nombre,
       'DESCRIPCION:      '    =@o_descripcion,
       'INTERESES ESTIMADO: '= @o_int_estimado,
       'INTERESES PAGADOS:  '= @o_int_pagados,
       'Intereses devengados ' = @o_total_int_ganados,
       'FECHA ULT PG INT: '   =convert(char(10),@o_fecha_ult_pg_int, @i_formato_fecha),
       'FECHA ULT CALCULO:'   =convert(char(10),@o_fecha_ult_calculo, @i_formato_fecha),
	     'RETIENE IMP: '        = @o_retienimp,
	     'IMPUESTO X RETENER: ' = @o_impuesto, /*36*/
 	     'DIAS VENCIDOS ' 			= @o_dia_vencido,
       'BASE DE CALCULO: ' 		= @o_dias_anio,
       'DESCRIPCION: ' 				= @o_pd_descripcion,
       'DIA DE PAGO: ' 				= @o_dia_pago, /*40*/
	     'COD: TIPO OP: ' 			= @o_toperacion,
	     'COD. MONEDA: '  			= @o_moneda,
	     'COD CATEGORIA: ' 			= @o_categoria,
	     'COD: FORMA PAGO: ' 		= @o_ppago,
	     'ACCION SIGUIENTE: ' 	=@o_accion_sgte,
       'TOTAL IMPUESTO RETENIDO' = @o_total_int_retenido,
	     'FECHA DE CANCELACION' = convert(char(10),@o_fecha_can, @i_formato_fecha),
	     'TASA DE IMPUESTO' 	 	=	@w_tasa,
	     'DIAS'		 							= @w_dias,
	     'NUEVA OPERACION'   		= @o_num_banco_new, /*50*/
	     'CED RUC'  	 					= @o_ced_ruc,
	     'DIRECC/CASILLA/NN' 		= @o_cd_descripcion,
	     'TELEFONO' 	 					= @o_telefono,
	     'CONVERSION' 	 				= @o_meses,
	     'NUM. DOCUMENTOS'   		= @o_numdoc,
       'MANTIENE INVENTARIO'	= @o_mantiene,
       'DISPONIBLE'        		= @o_disponible,
       'MONEDA PAGO'        	= @o_moneda_pg,
       'COD DIRECCI'        	= @o_direccion,
       'CIUDAD'            		= @o_ciudad, /*60*/
       'No. PREIMPRESO'    		= @o_preimpreso ,
	     'FACTOR EN MESES'   		= @o_factor_en_meses,
	     'NOMBRE ALTERNO '   		= @o_alterno,
        'OPERACION'         	= @o_operacion,
       'OFICINA'           		= @o_oficina,
       'NUM.IMP.ORIG'      		= @o_num_imp_orig,
       'DIAS ANTES IMPR.CERT'	= @o_dias_antes_impresion,
	     'IMPUESTO AL CAPITAL' 	= @o_impuesto_capital,
	     'CONDICION 2'         	= @o_condicion2, 
	     'CONDICION 3'         	= @o_condicion3, /*70*/
	     'CAPITAL PAGADO'      	= @o_capital_pagado ,
	     'ALTERNO 3 '          	= @o_alterno3,
	     'TELEFONO 2'	   				= @o_telefono2,
	     'LEY'		   						= @o_ley,
	     'ORIGINAL ' 	   				= @o_cert_origen,
	     'FECHA CAMB.TASA '	   	= @o_fecha_cal_tasa,
	     'FECHA REPROGRAMACION' =convert(char(10),@o_fecha_cert_origen, @i_formato_fecha),
	     'TASA CONGELADO'       = @o_tasa_congelado,
	     'FECHA COMERCIAL'      = @o_anio_comercial --04/04/2000 Fecha Comercial
 ****************************************************************************************/
end
return 0

go
