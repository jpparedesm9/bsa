/************************************************************************/
/*	Archivo:		ctasasoc.sp.				                        */
/*	Stored procedure:	sp_consulta_cuentas              				*/
/*	Base de datos:		cobis											*/
/*	Producto: Cobis ATM                     							*/
/*	Disenado por:  Gustavo Calderon										*/
/*	Fecha de escritura: 29-Sep-1995										*/
/************************************************************************/
/*				IMPORTANTE												*/
/*	Este programa es parte de los paquetes bancarios propiedad de		*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 			*/
/*	'NCR CORPORATION'.													*/
/*	Su uso no autorizado queda expresamente prohibido asi como			*/
/*	cualquier alteracion o agregado hecho por alguno de sus				*/
/*	usuarios sin el debido consentimiento por escrito de la 			*/
/*	Presidencia Ejecutiva de MACOSA o su representante.					*/
/************************************************************************/
/*				PROPOSITO												*/
/*	Este programa procesa la consulta de cuentas asociadas a un 		*/
/*  producto.															*/
/*	Transaccion 14547													*/
/*																		*/
/************************************************************************/
/*				MODIFICACIONES											*/
/*	FECHA		AUTOR		RAZON										*/
/* Jul/11/1997	  Ximena Cartagena U   Validar que la cta. sea del clte.*/
/* 2005/10/18     Carlos Cruz D.       Mostrar cuentas dado el cliente  */
/*                                     que es cotitular                 */
/* 2011/04/19     SMolano              Filtrar cuentas de Ahorro        */
/*                                     Contratual(no se presentan       */
/* 2016/02/05     A.Zuluaga            Desacople                        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_cuentas')
   drop proc sp_consulta_cuentas
go

create proc sp_consulta_cuentas (
  @s_ssn			int 		= null,
  @s_user			login 		= null,
  @s_term			varchar(30) = null,
  @s_date			datetime 	= null,
  @s_srv			varchar(30) = null,
  @s_lsrv			varchar(30) = null,
  @s_ofi			smallint 	= null,
  @s_org			char(1) 	= null,
  @t_debug			char(1) 	= 'N',
  @t_file			varchar(10) = null,
  @t_from			varchar(32) = null,
  @t_trn			int 		= null,
  @i_modo			int			= null,
  @i_producto		tinyint		= null,
  @i_cliente		int			= null,
  @i_cuenta			cuenta		= null,
  @i_operacion		char(1)		= 'H',
  @i_moneda			smallint,
  @i_banco_ach		int			= null	--LIM 30/ENE/2006
)
with encryption
as

declare 
@w_sp_name				varchar(32),
@w_cod_cliente 			int,
@w_nom_cliente 			descripcion,
@w_prod_banc            int,
@w_error                int,
@w_existe_cta           int,
@w_existe_cta_ac        int,
@w_existe_cte           int,
@w_return               int,
@w_existe_remesas       char(1) 

select @w_sp_name = 'sp_consulta_cuentas',
       @i_operacion = isnull(@i_operacion,'H') --xca

select @w_prod_banc = C.codigo 
from cobis..cl_tabla T, cobis..cl_catalogo C 
where T.tabla = 're_pro_banc_cb'
and   T.codigo = C.tabla
and   C.estado = 'V'

--Consulta cuentas asociadas a un producto 
if @t_trn <> 14440
begin
	exec cobis..sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 161500
	return 1
end
if @i_operacion = 'T'				--LIM 30/ENE/2006
begin

    exec @w_return = cob_interfase..sp_iremesas
         @i_operacion        = '*',
         @o_existe_remesas   = @w_existe_remesas out

    if @w_existe_remesas = 'S'
    begin
       exec @w_return = cob_interfase..sp_iremesas
            @i_operacion  = 'B',
            @i_producto   = @i_producto
         
       if @w_return <> 0
          return @w_return
    end     
    
end
else

if @i_operacion = 'H'
begin
  set rowcount 20
  -- CUENTAS CORRIENTES 
  if @i_producto = 3
  begin
  
     create table #cc_ctacte (
     cct_cta_banco       varchar(24)    null,    
     cct_estado          char(1)        null	  
     )

     insert into #cc_ctacte
     select dp_cuenta, 'X'
     from  cobis..cl_det_producto,
	       cobis..cl_cliente,
           cobis..cl_ente
     where dp_producto = 3
       and dp_moneda = @i_moneda
       and dp_det_producto = cl_det_producto
       and ((cl_cliente = @i_cliente) or (@i_cliente is null))
       and cl_rol in ('T', 'C')
       and en_ente = cl_cliente	
       	 
	 exec @w_return = cob_interfase..sp_icuentas
	      @i_operacion = 'T',
	      @i_moneda    = @i_moneda,
	      @i_cliente   = @i_cliente  

     if @i_modo = 0
     begin       
	  select 'CUENTA'	    = cc_cta_banco,
	   		 'COD. CLIENTE'	= cl_cliente,
	  		 'NOM. CLIENTE'	= en_nomlar
	  from	cobis..cl_det_producto,
	 		cobis..cl_cliente,
	 		cobis..cl_ente,
	 		#cc_ctacte
	  where	dp_producto	= 3
	    and dp_moneda	= @i_moneda
	    and dp_det_producto	= cl_det_producto
	    and	((cl_cliente = @i_cliente) or (@i_cliente is null))
	    and	cl_rol		in ('T', 'C')
	    and	en_ente      = cl_cliente	
	    and	cct_cta_banco = dp_cuenta
	    and	cct_estado	  = 'A'
	  order by dp_cuenta
	 end
         
	if @i_modo = 1
	begin
	  select 'CUENTA'		= cc_cta_banco,
	  		 'COD. CLIENTE'	= cl_cliente,
	  		 'NOM. CLIENTE'	= en_nomlar
	  from	cobis..cl_det_producto,
	  		cobis..cl_cliente,
	  		cobis..cl_ente,
	  		#cc_ctacte
	  where	dp_det_producto	= cl_det_producto
	    and	cl_cliente	= en_ente
	    and	dp_cuenta	= cct_cta_banco
	    and	dp_producto	= 3
	    and	cct_estado	= 'A'
	    and	dp_moneda	= @i_moneda
	    and	cl_rol		in ('T', 'C')
	    and	dp_cuenta	> @i_cuenta
	    and	((cl_cliente = @i_cliente) or (@i_cliente is null))
	  order by dp_cuenta
    end
  end
   
  --CUENTAS DE AHORROS
  if @i_producto = 4
  begin
    if @i_modo = 0
    begin          

       --DESACOPLE
       exec @w_error = cob_interfase..sp_iahorros
            @i_operacion = 'X',
            @i_modo      = 0,
            @i_moneda    = @i_moneda,
            @i_cliente   = @i_cliente,
            @i_cuenta    = @i_cuenta
 
       if @w_error <> 0
       begin
  	      exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_msg  = 'Error ejecucion cob_interfase..sp_iahorros (Busqueda de Cuentas de Ahorros)', --LIM 01/NOV/2005
               @i_num  = 141047
          return 1
       end
    end

    if @i_modo = 1
    begin
       exec @w_error = cob_interfase..sp_iahorros
            @i_operacion = 'X',
            @i_modo      = 1,
            @i_moneda    = @i_moneda,
            @i_cliente   = @i_cliente,
            @i_cuenta    = @i_cuenta
 
       if @w_error <> 0
       begin
  	      exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_msg  = 'Error ejecucion cob_interfase..sp_iahorros (Busqueda de Cuentas de Ahorros)', --LIM 01/NOV/2005
               @i_num  = 141047
          return 1
       end
    end
end
else  --@i_operacion <> 'H' 
begin
  set rowcount 20
  -- CUENTAS CORRIENTES 
  if @i_producto = 3
  begin

    exec @w_return = cob_interfase..sp_icuentas 
         @i_operacion  = 'A',
         @i_cta_ger    = @i_cuenta,
         @i_moneda     = @i_moneda,
         @o_existe_cte = @w_existe_cte out

    if @w_existe_cte > 0
    begin
       exec @w_return = cob_interfase..sp_icuentas 
            @i_operacion  = 'S',
            @i_cta_ger    = @i_cuenta,
            @i_moneda     = @i_moneda

       if @w_return <> 0
          return @w_return

    end
    else
    begin
    if @w_existe_cte is null
   	  begin
  	  exec cobis..sp_cerror
  	       @t_debug	= @t_debug,
  	  	   @t_file		= @t_file,
  	  	   @t_from		= @w_sp_name,
  	  	   @i_msg      = 'Ctacte. no existe/Cerrada/Inactiva',		--LIM 01/NOV/2005
  	  	   @i_num		= 141047
  	       return 1
       end
     end
  end

  --CUENTAS DE AHORROS 
  if @i_producto = 4
  begin

    exec @w_error = cob_interfase..sp_iahorros
         @i_operacion     = 'Y',
         @i_cuenta_banco  = @i_cuenta,
         @i_prod_banc     = @w_prod_banc,
         @o_existe_cta    = @w_existe_cta    out,
         @o_existe_cta_ac = @w_existe_cta_ac out

    if @w_error <> 0
    begin
  	  exec cobis..sp_cerror
  	       @t_debug	= @t_debug,
               @t_file  = @t_file,
               @t_from = @w_sp_name,
               @i_msg = 'Error ejecutando sp_iahorros <Existencia de Cuenta>', --LIM 01/NOV/2005
               @i_num = 141047
  	  return 1
    end

    if @w_existe_cta_ac is null
    begin
	   exec cobis..sp_cerror
  	       @t_debug	= @t_debug,
  	  	   @t_file		= @t_file,
  	  	   @t_from		= @w_sp_name,
  	  	   @i_msg		= 'Cta. Ahorro no existe',		--LIM 01/NOV/2005
  	  	   @i_num		= 141048
  	   return 1
    end
    
    if @w_existe_cta_ac is null
    begin

  	  exec cobis..sp_cerror
  	       @t_debug		= @t_debug,
  	       @t_file		= @t_file,
  	       @t_from		= @w_sp_name,
  	       @i_msg		= 'Cta. Ahorro no existe/Cerrada/Inactiva',		--LIM 01/NOV/2005
  	       @i_num		= 141048
  	  return 1
    end

    if @w_existe_cta_ac > 0
    begin
       --DESACOPLE
       exec @w_error = cob_interfase..sp_iahorros
            @i_operacion = 'X',
            @i_modo      = 0,
            @i_moneda    = @i_moneda,
            @i_cliente   = @i_cliente,
            @i_cuenta    = @i_cuenta
 
       if @w_error <> 0
       begin
  		  exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_msg  = 'Error ejecucion cob_interfase..sp_iahorros (Busqueda de Cuentas de Ahorros)', --LIM 01/NOV/2005
               @i_num  = 141047
          return 1
       end
    end
end
end
end
return 0
go

