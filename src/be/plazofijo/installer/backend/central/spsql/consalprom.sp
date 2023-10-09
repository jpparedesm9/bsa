/************************************************************************/
/*      Archivo:                conestado.sp                            */
/*      Stored procedure:       sp_consalprom                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ximena Cartagena U                      */
/*      Fecha de documentacion: 20/Dic/96                               */
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
/*      Este programa procesa las transacciones de SEARCH a la tabla    */
/*      de operaciones 'pf_operacion'.                                  */
/*                                                                      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */   
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de SEARCH a la tabla    */
/*      de operaciones 'pf_operacion'.                                  */
/*                                                                      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR               RAZON                            */   
/*      20-Dic-96  Ximena Cartagena U  Creacion                         */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_consalprom') is not null
   drop proc sp_consalprom
go

create proc sp_consalprom (
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
      @i_nivel                char(2)         = NULL, /* F, O,C,R,T */
      @i_valor                varchar(15)= '%',
      @i_tipo_deposito        catalogo  = '%',
      @i_tipo_plazo           catalogo  = '%',
      @i_tipo_monto           catalogo  = '%',
      @i_num_banco            cuenta       = '0',
      @i_modo                 int       = 0,
      @i_fecha1	      	      datetime  = '01/01/1902',
      @i_fecha2	      	      datetime  = '01/01/2200',
      --@i_fechai1	      datetime  = '01/01/1902',
      --@i_fechai2     	      datetime  = '01/01/2200',
      @i_estado               catalogo = '%',
      @i_moneda		      varchar(2)= '%',
      @i_formato_fecha        int = 0)  /* GESCY2K B242 */
with encryption
as
declare
   @w_sp_name              varchar(32)

/* Comentariado por XCA
if @i_propietario = '%' -- para que no saque claves duplicadas
	select @i_propietario = 'AAAAA'
FIN Comentario */

select @w_sp_name = 'sp_consalprom'

if @i_fecha2 = '01/01/1900'
	select @i_fecha2 = '01/01/2200'

--if @i_fechai2 = '01/01/1900'
--	select @i_fechai2 = '01/01/2200'


/**  VERIFICAR CODIGO DE TRANSACCION PARA SEARCH  **/
if  @t_trn <> 14706
begin
  /**  ERROR : CODIGO DE TRANSACCION PARA SEARCH NO VALIDO  **/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
  return 1
end

/**  BUSQUEDA DE OPERACIONES POR Oficial  **/
If @i_nivel  = 'F'
begin
  set rowcount 20
  if @i_modo = 0
  begin
    /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                                 @i_formato_fecha)
           /* GESCY2K B230 */
    from pf_operacion
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and op_oficial = @i_valor      
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > ''
    order by op_num_banco,op_oficina,op_toperacion
  end

  if @i_modo = 1
  begin
    /**  EXTRAE LOS SIGUIENTES 20 CHEQUES  **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha)
                   /* GESCY2K B231 */
    from pf_operacion
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and op_oficial = @i_valor     
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > @i_num_banco
    order by op_num_banco,op_oficina,op_toperacion
  end
end


/* BUSQUEDA DE OPERACIONES POR OFICINA */  
If @i_nivel  = 'O'
begin
  set rowcount 20
  if @i_modo = 0
  begin
    /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
               @i_formato_fecha)
           /* GESCY2K B232 */
    from pf_operacion
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_oficina = convert(int,@i_valor)
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > ''
    order by op_num_banco,op_oficina,op_toperacion
  end                            

  if @i_modo = 1
  begin
    /**  EXTRAE LOS SIGUIENTES 20 CHEQUES  **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha) /* GESCY2K B233 */
    from pf_operacion
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_oficina = convert(int,@i_valor)                   
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > @i_num_banco
    order by op_num_banco,op_oficina,op_toperacion
  end
end                                   

/* BUSQUEDA DE OPERACIONES POR CIUDAD */  
If @i_nivel  = 'C'
begin
  set rowcount 20
  if @i_modo = 0
  begin
    /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                    @i_formato_fecha)  /*GESCY2K B234 */
    from pf_operacion, cobis..cl_oficina
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_oficina = of_oficina
      and of_ciudad = convert(int,@i_valor)     
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > ''
    order by op_num_banco,op_oficina,op_toperacion
  end

  if @i_modo = 1
  begin
    /**  EXTRAE LOS SIGUIENTES 20 CHEQUES  **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha)  /* GESCY2K B235 */
    from pf_operacion,cobis..cl_oficina
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_oficina = of_oficina
      and of_ciudad = convert(int,@i_valor)     
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > @i_num_banco
    order by op_num_banco,op_oficina,op_toperacion
  end
end

/* BUSQUEDA DE OPERACIONES  POR REGIONAL OPERATIVA  */  

If @i_nivel  = 'RO'
begin
  set rowcount 20
  if @i_modo = 0
  begin
    /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
    select 'Sucursal'          = op_oficina, 
           'Tipo de Operacion' = op_toperacion,
           'Tasa'              = op_tasa,
           'Plazo'             = op_num_dias,
           'Monto'             = op_monto,
           'Estado'            = op_estado,
           'Cuenta'            = op_num_banco,
	         'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha)  /* GESCY2K B236 */
    from pf_operacion,
         cobis..cl_oficina,cobis..cl_ciudad, cobis..cl_provincia     
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_oficina = of_oficina
      and of_ciudad = ci_ciudad     
      and ci_provincia = pv_provincia
      and pv_region_ope = @i_valor          
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > ''
    order by op_num_banco,op_oficina,op_toperacion
  end

  if @i_modo = 1
  begin
    /**  EXTRAE LOS SIGUIENTES 20 CHEQUES  **/
    select 'Sucursal'          = op_oficina, 
                   'Tipo de Operacion' = op_toperacion,
                   'Tasa'              = op_tasa,
                   'Plazo'             = op_num_dias,
                   'Monto'             = op_monto,
                   'Estado'            = op_estado,
                   'Cuenta'            = op_num_banco,
	           'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha)  /* GESCY2K B237*/
    from pf_operacion, cobis..cl_oficina,cobis..cl_ciudad, cobis..cl_provincia
    where  op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and op_oficina = of_oficina
      and of_ciudad  = ci_ciudad
      and ci_provincia = pv_provincia
      and pv_region_ope = @i_valor
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > @i_num_banco
    order by op_num_banco,op_oficina,op_toperacion
         --order by op_num_banco
  end
end             

/* BUSQUEDA DE OPERACIONES  POR REGIONAL NATURAL  */  
If @i_nivel  = 'RN'
begin
  set rowcount 20
  
  if @i_modo = 0
  begin
    /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
    select 'Sucursal'          = op_oficina, 
                   'Tipo de Operacion' = op_toperacion,
                   'Tasa'              = op_tasa,
                   'Plazo'             = op_num_dias,
                   'Monto'             = op_monto,
                   'Estado'            = op_estado,
                   'Cuenta'            = op_num_banco,
	           'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha) /* GESCY2K B238 */
    from pf_operacion,
         cobis..cl_oficina,cobis..cl_ciudad, cobis..cl_provincia
    where op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and op_oficina = of_oficina
      and of_ciudad  = ci_ciudad
      and ci_provincia = pv_provincia
      and pv_region_nat = @i_valor
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > ''
    order by op_num_banco,op_oficina,op_toperacion
    --order by op_num_banco
  end

  if @i_modo = 1
  begin
    /**  EXTRAE LOS SIGUIENTES 20 CHEQUES  **/               
    select 'Sucursal'          = op_oficina, 
                   'Tipo de Operacion' = op_toperacion,
                   'Tasa'              = op_tasa,
                   'Plazo'             = op_num_dias,
                   'Monto'             = op_monto,
                   'Estado'            = op_estado,
                   'Cuenta'            = op_num_banco,
	           'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha)  /* GESCY2K B239 */
    from pf_operacion,
       cobis..cl_oficina,cobis..cl_ciudad, cobis..cl_provincia
    where op_toperacion like @i_tipo_deposito
      and op_estado like @i_estado
      and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
      and op_tipo_monto like @i_tipo_monto
      and op_oficina = of_oficina
      and of_ciudad  = ci_ciudad
      and ci_provincia = pv_provincia
      and pv_region_nat = @i_valor
      and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
      and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > @i_num_banco
    order by op_num_banco,op_oficina,op_toperacion
    --order by op_num_banco
  end
end                  

/* BUSQUEDA DE OPERACIONES  A NIVEL GENERAL */  
If @i_nivel  = 'T'
begin
  set rowcount 20
  if @i_modo = 0
  begin
    /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
    select 'Sucursal'          = op_oficina, 
                   'Tipo de Operacion' = op_toperacion,
                   'Tasa'              = op_tasa,
                   'Plazo'             = op_num_dias,
                   'Monto'             = op_monto,
                   'Estado'            = op_estado,
                   'Cuenta'            = op_num_banco,
	           'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha)  /* GESCY2K B240 */
    from pf_operacion 
    where  op_toperacion like @i_tipo_deposito
	    and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
      and op_toperacion like @i_tipo_deposito
	    and op_tipo_monto like @i_tipo_monto
	    and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
	    and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
	    and op_num_banco > ''
	 --order by op_num_banco
  end
  
  if @i_modo = 1
  begin
    /**  EXTRAE LOS SIGUIENTES 20 CHEQUES  **/
    select 'Sucursal'          = op_oficina, 
                   'Tipo de Operacion' = op_toperacion,
                   'Tasa'              = op_tasa,
                   'Plazo'             = op_num_dias,
                   'Monto'             = op_monto,
                   'Estado'            = op_estado,
                   'Cuenta'            = op_num_banco,
	           'Fecha Venc.'       = convert(varchar(10),op_fecha_ven,
                   @i_formato_fecha) /* GESCY2K B241 */
    from pf_operacion
    where  op_toperacion like @i_tipo_deposito
	    and convert(varchar(2),op_moneda) like @i_moneda
      and op_tipo_plazo like @i_tipo_plazo
	    and op_tipo_monto like @i_tipo_monto
	    and datediff(dd,op_fecha_ven ,@i_fecha1)<=0
	    and datediff(dd,op_fecha_ven, @i_fecha2)>= 0
      and op_num_banco > @i_num_banco
	 --order by op_num_banco
	end
end

set rowcount 0
return 0   

go
