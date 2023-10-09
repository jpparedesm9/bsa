/*************************************************************************/
/*      Archivo:                confrafu.sp 			         */
/*      Stored procedure:       sp_consulta_frafus			 */
/*      Base de datos:          cobis                                  	 */
/*      Producto:               Plazo Fijo                               */
/*      Disenado por:           Ximena Cartagena U                       */
/*      Fecha de documentacion: 23-May-2000                              */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      'MACOSA', representantes exclusivos para el Ecuador de la        */
/*      'NCR CORPORATION'.                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*************************************************************************/
/*                              PROPOSITO                                */
/*      Permitir la consula de los titulos que han sido fraccionados	 */
/*      o fusionados							 */
/*************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_frafus')
   drop proc sp_consulta_frafus
go

create proc sp_consulta_frafus(
  @s_ssn                  int             = NULL,
  @s_user                 login           = NULL,
  @s_term                 varchar(30)     = NULL,
  @s_date                 datetime        = NULL,
  @s_sesn                 int             = NULL,
  @s_srv                  varchar(30)     = NULL,
  @s_lsrv                 varchar(30)     = NULL,
  @s_ofi                  smallint        = NULL,
  @s_rol                  smallint        = NULL,
  @t_debug                char(1)         = 'N',
  @t_file                 varchar(10)     = NULL,
  @t_from                 varchar(32)     = NULL,
  @t_trn                  smallint        = NULL,
  @i_num_banco     	  cuenta,
  @i_tipo                 varchar(3), --FUS/FRA
  @i_operacion		  char(1),
  @i_formato_fecha        int  	
)
with encryption
as
declare 
  @w_sp_name		    varchar(32),
	@w_return		      smallint,
	@w_operacionpf		int,
	@w_oper_detalle		int,
	@w_valor_detalle	money,
	@w_operacion_hijo	int,
	@w_tipo_tran		  char(1),
	@w_tipo			      char(3),
	@w_autorizo		    char(100),
	@w_iva			      money,
	@w_capital		    money,
  @w_estado         catalogo

select @w_sp_name = 'sp_consulta_frafus'

/**  VERIFICAR CODIGO DE TRANSACCION PARA CONSULTA DE FRACCION Y FUSION  **/
if (( @t_trn <> 14417 ) and @i_operacion<>'S')
begin
  /**  ERROR : CODIGO DE TRANSACCION**/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141112
  return 1
end

select @w_operacionpf = op_operacion,
       @w_estado      = op_estado
from pf_operacion, pf_fusfra 
where op_num_banco = @i_num_banco
and ((op_operacion = fu_operacion) or (op_operacion = fu_operacion_new))
and fu_mnemonico   = @i_tipo
if @@rowcount = 0
begin
  exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                        @t_from  = @w_sp_name, @i_num   = 141142
  return 1
end

if @i_operacion = 'S'
  if @i_tipo in('FUS', 'FRA')
  begin 
    /* Proceso para insertar en una tabla temporal los datos a */
    /* consultar.                                              */

    create table #tempfus(
             operacion          int      NOT  NULL,
             operacion_new      int      NOT  NULL,
             fecha_valor        datetime NULL,
             fecha_crea         datetime NOT  NULL,
             monto              money    NOT  NULL,
             impuesto           float    NULL,
             tot_int_ganado     money    NULL,
             tot_int_pagados    money    NULL,
             oficina_aper       smallint NULL,
             oficina_fus        smallint NULL,
             preimpreso         int      NULL,
             nomlar             varchar(96) NULL,
             mnemonico          char(5)  NULL,
             monto_fusfra       money    NOT  NULL)

    if @w_estado = 'ACT'
    begin
      insert into #tempfus
      select fu_operacion,fu_operacion_new,fu_fecha_valor, 
             fu_fecha_crea, fu_monto, fu_impuesto, fu_tot_int_acumulado,	--+-+ganado  - fu_tot_int_pagados , 
             fu_tot_int_pagados, fu_oficina_apertura, fu_oficina_fusion, 
             fu_preimpreso, fu_nomlar, 
             case fu_mnemonico
             when 'FUS' then
                  'CON'
             else
	          fu_mnemonico
             end, 
             fu_monto_fusionar
      from pf_fusfra, pf_operacion
      where op_num_banco = @i_num_banco
        and op_operacion = fu_operacion_new
    end
    else --Cualquier otro estado
    begin
      insert into #tempfus
      select fu_operacion, fu_operacion_new,fu_fecha_valor, 
             fu_fecha_crea, fu_monto, fu_impuesto, fu_tot_int_ganado - fu_tot_int_pagados , 
             fu_tot_int_pagados, fu_oficina_apertura, fu_oficina_fusion, 
             fu_preimpreso, fu_nomlar, 
             case fu_mnemonico
             when 'FUS' then
                  'CON'
             else
	          fu_mnemonico
             end, 
	     fu_monto_fusionar
      from pf_fusfra, pf_operacion
      where op_num_banco = @i_num_banco
        and op_operacion = fu_operacion
        and	fu_estado = 'A'
    end

	  if @@rowcount=0
    begin
	    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
             @t_from  = @w_sp_name, @i_num   = 141142
  	  return 1
	  end

    /* Fin proceso insercion en tabla temporal los datos a consultar */

    /* Proceso para devolver informacion a consultar al front_end.   */
    if @w_estado = 'ACT'
    begin
      if @i_tipo = 'FUS'
	     select 'OPERACION ORIGINAL '         = op_num_banco, --GAR 1-mar-2005 DP00133 
                    'SALDO CAPITAL '              = monto,
                    'INTERESES ACUMULADOS '       = tot_int_ganado, 
                    'INTERESES PAGADOS '          = tot_int_pagados, 
                    'OFIC. APERTURA '             = (select of_nombre from cobis..cl_oficina where  of_oficina  = b.op_oficina),  --+-+a.oficina_aper), 
                    'OFIC. CONSOLIDACION '        = (select of_nombre from cobis..cl_oficina where  of_oficina  = a.oficina_fus) ,
                    'TITULAR OPERACION NUEVA'     = nomlar, --GAR 1-mar-2005 DP00133 
                    'CODIGO TRANSACCION '         = mnemonico, 
                    'FECHA DE APERTURA '          = convert(varchar(10),fecha_crea,@i_formato_fecha),	--+-+convert(varchar(10),fecha_valor,@i_formato_fecha),
                    'FECHA DE CONSOLIDACION '     = convert(varchar(10),fecha_crea,@i_formato_fecha),
                    'ESTADO '                     = op_estado,
                    'No. OPERACION ORIGINAL '     = operacion --GAR 1-mar-2005 DP00133 
        from  #tempfus a, cob_pfijo.. pf_operacion b
        where op_operacion = operacion

      if @i_tipo = 'FRA'
             select 'OPERACION ORIGINAL '        = op_num_banco, --GAR 1-mar-2005 DP00133 
                    'SALDO CAPITAL '             = op_monto,	--+-+ monto_fusfra,
                    'INTERESES ACUMULADOS '      = op_total_int_ganados - op_total_int_pagados,	--+-+tot_int_ganado, 
                    'INTERESES PAGADOS '         = op_total_int_pagados,	--+-+tot_int_pagados, 
                    'OFIC. APERTURA '            = (select of_nombre from cobis..cl_oficina where  of_oficina  = b.op_oficina), --+-+a.oficina_aper), 
                    'OFIC. FRACCIONAMIENTO '     = (select of_nombre from cobis..cl_oficina where  of_oficina  = a.oficina_fus) ,
                    'TITULAR OPERACION'    = op_descripcion,	--+-+nomlar, --GAR 1-mar-2005 DP00133 
                    'MNEMONICO TRANSACCION '     = mnemonico, 
                    'FECHA DE APERTURA ' = convert(varchar(10),fecha_crea,@i_formato_fecha),	--+-+convert(varchar(10),fecha_valor,@i_formato_fecha),
                    'FECHA DE FRACCIONAMIENTO '   = convert(varchar(10),fecha_crea,@i_formato_fecha),
                    'ESTADO '            = op_estado,
                    'No. OPERACION ORIGINAL '     = operacion --GAR 1-mar-2005 DP00133 
        from  #tempfus a , cob_pfijo.. pf_operacion b 
        where op_operacion = operacion
    end
    else --Cualquier otro estado
    begin
      if @i_tipo = 'FUS'
          select 'OPERACION NUEVA '           = op_num_banco, --GAR 1-mar-2005 DP00133 
                 'SALDO CAPITAL '             = op_monto,	--+-+monto,
                 'INTERESES ACUMULADOS'       = op_total_int_ganados - op_total_int_pagados,	--+-+tot_int_ganado, 
                 'INTERESES PAGADOS '         = op_total_int_pagados,	--+-+tot_int_pagados, 
                 'OFIC. APERTURA '            = (select of_nombre from cobis..cl_oficina where  of_oficina  = b.op_oficina), --+-+a.oficina_aper) , 
                 'OFIC. CONSOLIDACION '	      = (select of_nombre from cobis..cl_oficina where  of_oficina  = a.oficina_fus) ,
                 'TITULAR OPERACION NUEVA'    = op_descripcion,	--+-+nomlar, --GAR 1-mar-2005 DP00133 
                 'CODIGO TRANSACCION '        = mnemonico, 
	         'FECHA DE APERTURA ' = convert(varchar(10),fecha_crea,@i_formato_fecha),	--+-+convert(varchar(10),fecha_valor,@i_formato_fecha),
                 'FECHA DE CONSOLIDACION '    = convert(varchar(10),fecha_crea,@i_formato_fecha),
                 'ESTADO '                    = op_estado,
                 'No. OPERACION NUEVA '       = operacion_new --GAR 1-mar-2005 DP00133 
        from  #tempfus a, cob_pfijo.. pf_operacion b 
        where op_operacion = operacion_new

      if @i_tipo = 'FRA'
             select 'OPERACION NUEVA '            = op_num_banco,  --GAR 1-mar-2005 DP00133 
                    'SALDO CAPITAL '              = monto_fusfra,
                    'INTERESES ACUMULADOS'        = tot_int_ganado, 
                    'INTERESES PAGADOS '          = tot_int_pagados, 
                    'OFIC. APERTURA '             = (select of_nombre from cobis..cl_oficina where  of_oficina  = b.op_oficina), --+-+a.oficina_aper), 
                    'OFIC. FRACCIONAMIENTO '      = (select of_nombre from cobis..cl_oficina where  of_oficina  = a.oficina_fus)  ,
                    'TITULAR OPERACION'     = nomlar, --GAR 1-mar-2005 DP00133 
                    'CODIGO TRANSACCION '         = mnemonico, 
                    'FECHA DE APERTURA '          = convert(varchar(10),fecha_crea,@i_formato_fecha),	--+-+convert(varchar(10),fecha_valor,@i_formato_fecha),
                    'FECHA DE FRACCIONAMIENTO '   = convert(varchar(10),fecha_crea,@i_formato_fecha),
                    'ESTADO '                     = op_estado,
                    'No. OPERACION NUEVA '        = operacion_new --GAR 1-mar-2005 DP00133 
         from  #tempfus a, cob_pfijo.. pf_operacion b
         where op_operacion = operacion_new
    end
  end -- @i_tipo in('FUS','FRA')
  /* Fin proceso para devolver informacion a consultar al front_end.   */

  /***** QUERY *****/

if @i_operacion = 'Q'
begin
  if @i_tipo in('FUS', 'FRA')
  begin
    if @w_estado = 'ACT' -- operacion nueva resultado de la fusion
    begin
      set rowcount 1
      select @w_autorizo =fu_nombre
      from cobis..cl_funcionario,
           cob_pfijo..pf_fusfra, pf_operacion
      where op_num_banco = @i_num_banco
        and op_operacion = fu_operacion_new 
        and fu_oficial_fusion  = fu_login

      set rowcount 0				   
      select fu_fecha_valor,
                 fu_fecha_crea,
                 fu_monto,
                 fu_impuesto,
                 fu_tot_int_ganado,
                 fu_tot_int_pagados,
                 fu_oficina_apertura,
                 fu_oficina_fusion,
                 fu_preimpreso,
                 fu_nomlar,
                 fu_mnemonico,
                 fu_operacion
      from  pf_fusfra, pf_operacion
      where  op_num_banco =  @i_num_banco
        and op_operacion =  fu_operacion_new  

      if @@rowcount=0
	    begin
        exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
              @t_from  = @w_sp_name, @i_num   = 141142
        return 1
      end
    end
    else --est. CAN consulta una de las operaciones padres que genero la nueva
    begin
      set rowcount 1
      select @w_autorizo =fu_nombre
      from cobis..cl_funcionario,
           cob_pfijo..pf_fusfra, pf_operacion
      where op_num_banco = @i_num_banco
        and op_operacion = fu_operacion 
        and fu_oficial_fusion  = fu_login

      set rowcount 0				   
      select fu_fecha_valor,
                 fu_fecha_crea,
                 fu_monto,
                 fu_impuesto,
                 fu_tot_int_ganado,
                 fu_tot_int_pagados,
                 fu_oficina_apertura,
                 fu_oficina_fusion,
                 fu_preimpreso,
                 fu_nomlar,
                 fu_mnemonico,
                 fu_operacion
      from  pf_fusfra, pf_operacion
      where  op_num_banco =  @i_num_banco
        and op_operacion =  fu_operacion

      if @@rowcount=0
	    begin
        exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
              @t_from  = @w_sp_name, @i_num   = 141142
        return 1
      end
    end --fin del begin else
  end /*  @i_tipo in('FUS', 'FRA') */
end --@i_operacion = 'Q'
return 0

go

