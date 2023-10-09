/************************************************************************/
/*      Archivo:                ctasavar.sp                             */
/*      Stored procedure:       sp_cons_tasa_var                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Nancy Usina (tesoreria)                 */
/*      Fecha de documentacion: 06-Jun-96                               */
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
/*      Este script consulta la ultima tasa variable que se encuentra   */
/*	    en la tabla pizarra de tesoreria. Fue creado en cob_tesoreria   */
/*	    y se copio para utilizarlo en plazo fijo sin que los cambios	*/
/*	    que realice tesoreria afecten la consulta de pfijo.		        */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA       	AUTOR              RAZON                        */
/*      04-Oct-2001 	N. Silva          Cambios para funcionamiento   */
/*		07-Nov-2014  	E.Ochoa			  CDT tasa variable IBR -       */
/*                                        Cálculo de tasa IBR - RQ455   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_tasa_var' and type = 'P')
   drop proc sp_cons_tasa_var
go

create proc sp_cons_tasa_var(
	@s_ssn                  int         = null,
	@s_user                 login       = null,
	@s_sesn			        int = null,
	@s_term                 varchar(30) = null,
	@s_date                 datetime    = null,
	@s_srv                  varchar(30) = null,
	@s_lsrv                 varchar(30) = null,
	@s_ofi                  smallint    = null,
	@s_rol                  smallint    = NULL,
	@t_trn                  smallint,
	@t_debug        	    char(1)     = 'N',
	@t_file       	  	    varchar(14) = null,
	@t_from       	  	    varchar(32) = null,
	@i_operacion     	    char(1),
    @i_cod_tasa_ref      	char(10),               -- Codigo de tasa referencial
    @i_fecha                datetime,               -- Fecha de consulta
	@i_moneda	      	    tinyint = 0,  	        -- Moneda de la negociacion
	/* la siguiente variable es por si se consulta por internet (Especial)*/
        /* y no se encuentra el valor de la tasa vigente, de lo contrario     */
        /* sera Normal */
	@i_tipo			        char(1)     = 'N',
    @i_batch                char(1)     = 'N',       -- Tasa Variable
    @i_toperacion           varchar(30),             --Tipo de operación IBR RQ455   
    @o_valor_ref            float       = 0    out,  -- Tasa Variable
    @o_fecha_rev            datetime    = null out   -- Fecha de revision para cambio de tasa
    
)
with encryption
as
declare @w_return               int,
        @w_sp_name              varchar(30),
        @w_valor_ref          	float,                -- Retorna el valor de la tasa de interes
        @w_modalidad_tasa     	char(1),
        @w_periodo_tasa       	smallint,
        @w_max_fecha_ini 	    datetime,
        @w_fecha_ini		    datetime,
        @w_fecha_fin		    datetime,
        @w_max_id  		        int,
        @w_fecha_rev            datetime,
        @w_salida               datetime;

/* Asignacion del nombre del SP a variable */
select @w_sp_name='sp_cons_tasa_var'

/*-------------------------------------------------*/
/*  VERIFICAR CODIGO DE TRANSACCION PARA CONSULTA  */
/*-------------------------------------------------*/
if ( @i_operacion <> 'Q' or  @t_trn <> 14416)
begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
      return 141040
end

-----------------------------------------
-- valor de la tasa para la fecha exacta
-----------------------------------------

--(RQ455) CDT TASA VARIABLE IBR - CALCULO DE TASA IBR -EOCHOA

if exists(select 1 from cobis..cl_tabla t, cobis..cl_catalogo c
          where t.tabla  = 'pf_tasa_dia_ant'
          and   t.codigo = c.tabla
          and   c.codigo = @i_cod_tasa_ref)
begin
-- Calcula el proximo dia habil
   exec sp_primer_dia_labor     
        @i_tipo_deposito = @i_toperacion,
        @s_ofi           = @s_ofi,
        @i_operacion     = 'X',
        @i_fecha         = @i_fecha,--aaaa-mm-dd '2014-09-01 00:00:00.000'
        @o_fecha_labor   = @w_salida out
select @i_fecha          = @w_salida  
end

--llamado sp
select @w_valor_ref 	 = pi_valor,
       @w_modalidad_tasa = pi_modalidad,
       @w_periodo_tasa 	 = (select isnull(ca_periodo,3) from cobis..te_caracteristicas_tasa where ca_tasa    = pi_referencia),
       @w_fecha_ini 	 = null,
       @w_fecha_fin 	 = null/*,
       @w_fecha_rev      = pi_fecha_rev*/
from   cobis..te_tpizarra
where  pi_referencia   =  ltrim(rtrim(@i_cod_tasa_ref))
and    pi_fecha_inicio <= @i_fecha
and    pi_fecha_fin    >= @i_fecha
and    pi_moneda       =  @i_moneda
and    pi_tipo_tasa    = 'P'

if @@rowcount <> 1 and @i_tipo = 'N'
begin
   print 'No ha sido ingresado el nuevo valor de tasa, se tomara el ultimo ingresado'
   select @w_valor_ref 	 = pi_valor,
       @w_modalidad_tasa = pi_modalidad,
       @w_periodo_tasa 	 = (select isnull(ca_periodo,3) from cobis..te_caracteristicas_tasa where ca_tasa    = pi_referencia),
       @w_fecha_ini 	 = null,
       @w_fecha_fin 	 = null/*,
       @w_fecha_rev      = pi_fecha_rev */
   from   cobis..te_tpizarra
  where  pi_referencia   =  ltrim(rtrim(@i_cod_tasa_ref))
    and pi_fecha_fin    >= (select max(pi_fecha_fin) 
                             from cobis..te_tpizarra 
                            where pi_referencia = ltrim(rtrim(@i_cod_tasa_ref))
                              and pi_moneda = @i_moneda
                              and pi_tipo_tasa = 'P')
    and pi_moneda       =  @i_moneda
    and pi_tipo_tasa    = 'P'
end

----------------------------------------------------------------------------------
-- Solo si se consulta por internet (Especial) se traera la ultima tasa ingresada
----------------------------------------------------------------------------------
if @i_tipo = 'E'
begin
        ---------------------------------------------------
	-- Consulta de la ultima fecha de inicio ingresada
        ---------------------------------------------------
	select @w_max_fecha_ini = MAX(pi_fecha_inicio)
	  from cobis..te_tpizarra
	 where pi_fecha_inicio < @i_fecha
	   and pi_referencia   = ltrim(rtrim(@i_cod_tasa_ref))
	   and pi_moneda       = @i_moneda

        ----------------------------------------------------------------------------
	-- Se elije el ultimo registro de la tasa en el caso en que hayan
	-- ingresado dos para la misma fecha de inicio (este caso no deberia pasar)
        ----------------------------------------------------------------------------
	select @w_max_id        = MAX(pi_cod_pizarra)
          from cobis..te_tpizarra
	 where pi_fecha_inicio = @w_max_fecha_ini
	   and pi_referencia   = ltrim(rtrim(@i_cod_tasa_ref))
	   and pi_moneda       = @i_moneda
           and pi_tipo_tasa    = 'P'
	
	select @w_valor_ref 	 = pi_valor,
	       @w_modalidad_tasa = pi_modalidad,
	       @w_periodo_tasa 	 = (select isnull(ca_periodo,3) from cobis..te_caracteristicas_tasa where ca_tasa    = pi_referencia),
	       @w_fecha_ini 	 = pi_fecha_inicio,
	       @w_fecha_fin 	 = pi_fecha_fin/*,
               @w_fecha_rev      = pi_fecha_rev*/
          from cobis..te_tpizarra
	 where pi_referencia   = ltrim(rtrim(@i_cod_tasa_ref))
	   and pi_fecha_inicio = @w_max_fecha_ini  -- la ultima fecha de inicio
	   and pi_moneda       = @i_moneda
	   and pi_cod_pizarra  = @w_max_id         -- el ultimo registro
           and pi_tipo_tasa    = 'P'

        ------------------------------------------------
	-- Si definitivamente no encuentra ningun valor
        ------------------------------------------------
	if @@rowcount <> 1  
	begin
		exec cobis..sp_cerror
   	 	@t_debug	= @t_debug,
		@t_file 	= @t_file,
	 	@i_num		= 141159
		return 141159
    	 end
    	 
    	 set rowcount 0
end  --de si @i_homebanking = 'S'

--------------------------------------------------------
-- Controlar si el proceso no es llamado desde el batch
--------------------------------------------------------
if @i_batch = 'N'
begin
    select   '14997'= @w_valor_ref, 
  	     '14998'= @w_modalidad_tasa,
	     '14999'= @w_periodo_tasa,
	     '15000'= convert(varchar,@w_fecha_ini,101),
	     '15001'= convert(varchar,@w_fecha_fin,101)
end
else
begin
  select  @o_valor_ref = @w_valor_ref
  select  @o_fecha_rev = @i_fecha /*@w_fecha_rev*/
end

return 0
go
