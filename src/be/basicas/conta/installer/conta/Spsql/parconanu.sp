/************************************************************************/
/*	Archivo:            parconanu.sp                                    */
/*	Stored procedure: 	sp_part_cont_anuladas                           */
/*	Base de datos:  	cob_conta                                       */
/*	Producto:           contabilidad                                    */
/*	Disenado por:       Martha Rey                                      */
/*	Fecha de escritura: 27-junio-2008                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de       */
/*	"MACOSA", representantes exclusivos para el Ecuador de la           */
/*	"NCR CORPORATION".                                                  */
/*	Su uso no autorizado queda expresamente prohibido asi como          */
/*	cualquier alteracion o agregado hecho por alguno de sus             */
/*	usuarios sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                             PROPOSITO                                */
/*  Consultar y desconciliar las partidas contables anuladas.           */
/*                             MODIFICACIONES                           */
/*  FECHA                      AUTOR                  RAZON             */
/*  30/Jun/2008	               M. Rey       Emision Inicial             */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_part_cont_anuladas')
    drop proc sp_part_cont_anuladas
go
create proc sp_part_cont_anuladas (
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               descripcion = null,
   @s_corr               char(1)     = null,
   @s_ssn_corr           int         = null,
   @s_ofi                smallint    = null,
   @t_rty                char(1)     = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_empresa            tinyint     = null,
   @i_fecha              datetime    = null,
   @i_fecha_tran1        datetime    = null,
   @i_comprobante        int         = null,
   @i_comprobante1       int         = null,
   @i_asiento            smallint    = null,
   @i_asiento1           smallint    = null,
   @i_formato_fecha      smallint    = null,
   @i_oficina            smallint    = null,
   @i_area               smallint    = null,
   @i_cuenta             cuenta      = null,
   @i_debcred            char(1)     = null,
   @i_valor	             money       = null,
   @i_relacionado        char(1)     = 'N',
   @i_producto           tinyint     = null,
   @i_banco              varchar(4)  = null,
   @i_opc_orden          char(1)     = null,
   @i_oper_banco         char(4)     = null,
   @i_tipo_conciliacion  char(1)     = null,
   @i_refinterna         int         = null
)
as

declare
   @w_today              datetime,     -- fecha del dia 
   @w_return             int,          -- valor que retorna
   @w_sp_name            varchar(32),  -- nombre stored proc
   @w_moneda             tinyint,      -- moneda de la cuenta
   @w_moneda_base        tinyint,      -- moneda base de la empresa
   @w_extranjera         tinyint,      -- flag
   @w_existe             tinyint,       -- existe el registro
   @w_cad1               varchar(1024),
   @w_cad2               varchar(1024)

select @w_today = getdate()
select @w_sp_name = 'sp_part_cont_anuladas'



-- Codigos de Transacciones

if (@t_trn <> 6855 and @i_operacion = 'S') or
   (@t_trn <> 6856 and @i_operacion = 'D')
begin
 --  tipo de transaccion no corresponde
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end


-- Consulta opcion SEARCH 
if @i_operacion = 'S'
begin
	set rowcount 20
    
    select @w_cad1 = '',
           @w_cad2 = ''
    if @i_modo = 0
    begin        
        select @w_cad2 = 'select cl_producto, convert(char(10), cl_fecha_tran,' + convert(varchar,@i_formato_fecha) + '), ' +
                'cl_comprobante, cl_asiento, cl_cuenta, cl_debcred, cl_valor, cl_oper_banco, c.valor, cl_banco, cl_cuenta_cte, ' +
                'cl_detalle, cl_cheque, cl_refinterna, cl_fecha_conc, cl_tipo_conciliacion ' +
                'from cob_conta_tercero..ct_conciliacion, cobis..cl_tabla t, cobis..cl_catalogo c ' +
                'where cl_empresa = ' + convert(varchar,@i_empresa) +
                ' and cl_producto = ' + convert(varchar,@i_producto) +
                ' and cl_comprobante is not NULL ' +
                ' and cl_relacionado = '+'''' + 'S' + ''''+
                ' and cl_tipo_conciliacion = ' + 'M' +
                ' and cl_fecha_conc = '+ '''' + convert(varchar, @i_fecha) + '''' +
                ' and t.codigo = c.tabla' +
		        ' and t.tabla = '+ ''''+ 'cb_operacion_entidad'+'''' +
		        ' and c.codigo = cl_oper_banco' 
        if @i_opc_orden is null or @i_opc_orden = 'F'
        begin
             select @w_cad2 = ' order by cl_fecha_tran, cl_comprobante, cl_asiento'
        end
        else if @i_opc_orden = 'O'
        begin
             select @w_cad2 = ' order by cl_oper_banco, cl_comprobante, cl_asiento'
        end
        else if @i_opc_orden = 'V'
        begin
             select @w_cad2 = ' order by cl_valor, cl_comprobante, cl_asiento'
        end
        
        exec (@w_cad1 + @w_cad2)
        
	   	if @@rowcount = 0
      	begin
           	  -- Registro no existe 
                --exec cobis..sp_cerror
        		--@t_debug = @t_debug,
        		--@t_file  = @t_file, 
        		--@t_from  = @w_sp_name,
        		--@i_num   = 601159
        	return 1 
    	end
	end
    else 
    begin
        select @w_cad1 = 'select cl_producto, convert(char(10), cl_fecha_tran,' + convert(varchar,@i_formato_fecha) + '), ' +
                'cl_comprobante, cl_asiento, cl_cuenta, cl_debcred, cl_valor, cl_oper_banco, c.valor, cl_banco, cl_cuenta_cte, ' +
                'cl_detalle, cl_cheque, cl_refinterna, cl_fecha_conc, cl_tipo_conciliacion ' +
               'from cob_conta_tercero..ct_conciliacion, cobis..ct_tabla t, cobis..cl_catalogo c ' +
               'where cl_empresa = ' + convert(varchar,@i_empresa) +
               ' and cl_producto = ' + convert(varchar,@i_producto) +
               ' and cl_comprobante is not NULL ' +
                ' and cl_relacionado = '+'''' + @i_relacionado  + ''''+
               ' and cl_tipo_conciliacion = ' + @i_tipo_conciliacion +
               ' and cl_fecha_conc = '+'''' + convert(varchar, @i_fecha) + '''' +
               ' and t.codigo = c.tabla' +
               ' and t.tabla = cb_operacion_entidad' + 
               ' and c.codigo = cl_oper_banco' 
        if @i_opc_orden is null or @i_opc_orden = 'F'
        begin
            select @w_cad2 = ' and ( (cl_fecha_tran = '+ '''' + convert(varchar, @i_fecha_tran1) + '''' +
                   ' and cl_comprobante = ' + convert(varchar, @i_comprobante1)  +
                   ' and cl_asiento > ' + convert(varchar, @i_asiento1) +  ')' +
                   ' or (cl_fecha_tran = ' + '''' + convert(varchar, @i_fecha_tran1) + '''' +
	               ' and cl_comprobante > ' + convert(varchar, @i_comprobante1) + ')' +
	               ' or (cl_fecha_tran > '''' + convert(varchar, @i_fecha_tran1) + '''' ))' +
		           ' order by cl_fecha_tran, cl_comprobante, cl_asiento'
        end
        else if @i_opc_orden = 'O'
        begin
              select @w_cad2 = ' and (( cl_oper_banco = ' + ''''  + @i_oper_banco + ''''+
                   ' and cl_comprobante = ' + convert(varchar, @i_comprobante1) +
                   ' and cl_asiento > ' + convert(varchar, @i_asiento1) +  ')' +
                   ' or (cl_oper_banco = '+ '''' +  @i_oper_banco + '''' +
	               ' and cl_comprobante > ' + convert(varchar, @i_comprobante1) + ')' +
	               ' or (cl_oper_banco > '''' + @i_oper_banco + '''' ))' +
                   ' order by cl_oper_banco, cl_comprobante, cl_asiento'
        end
        else if @i_opc_orden = 'V'
        begin
            select @w_cad2 = ' and (( cl_valor = ' + convert(varchar, @i_valor) + 
                   ' and cl_comprobante = ' + convert(varchar, @i_comprobante1) + 
                   ' and cl_asiento > ' + convert(varchar, @i_asiento1) + ')' +
                   ' or (cl_valor = ' + convert(varchar, @i_valor) + 
	               ' and cl_comprobante > ' + convert(varchar, @i_comprobante1) + ')' +
	               ' or (cl_valor > ' + convert(varchar, @i_valor) + ' ))' +
                   ' order by cl_valor, cl_comprobante, cl_asiento'
        end
        exec (@w_cad1 + @w_cad2)
        
        if @@rowcount = 0
       	begin
       	    -- Registro no existe 
       	     	--exec cobis..sp_cerror
                --@t_debug = @t_debug,
                --@t_file  = @t_file, 
                --@t_from  = @w_sp_name,
                --@i_num   = 601159
            return 1 
    	end
	end
    return 0
end

-- Consulta opcion UPDATE
if @i_operacion = 'D'
begin
    update cob_conta_tercero..ct_conciliacion
    set    cl_detalle           = null,
           cl_relacionado       = 'N',
           cl_refinterna        = null,
           cl_fecha_conc        = null,
           cl_tipo_conciliacion = null
    where  cl_tipo_conciliacion = 'C'
    and    cl_refinterna        = @i_refinterna
    and    cl_empresa           = @i_empresa

	if @@error <> 0
	begin
		-- Error en desconciliacion
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 605083
		return 1 
    end
end


go

