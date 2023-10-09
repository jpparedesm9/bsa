/************************************************************************/
/*	Archivo: 		asicon.sp				*/
/*	Stored procedure: 	sp_asicon				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Consulta de asientos para conciliacion bancaria              */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	09/Feb/1995	G Jaramillo     Emision Inicial			*/
/*	12/04/1999	O. Escandon 	Cambiar el uso de cb_conciliacion*/
/*					por ct_conciliacion		*/
/*	25/May/1999	O. Escandon     Devolver los cambios anteriores */
/*					para usar cb_conciliacion de 	*/
/*					cob_conta			*/
/*  05/Jun/2008 M. Rey          Consulta de extractos y auxiliares por  */
/*                              criterios de ordenamiento. NR 775       */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_asicon')
    drop proc sp_asicon
go
create proc sp_asicon (
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
   @i_empresa            tinyint  = null,
   @i_fecha_tran1        datetime  = null,
   @i_fecha              datetime  = null,
   @i_comprobante1       int  = null,
   @i_comprobante        int  = null,
   @i_scomprobante       int  = null,
   @i_asiento1           smallint = null,
   @i_asiento            smallint = null,
   @i_formato_fecha      smallint =null,
   @i_oficina            smallint = null,
   @i_oficina_orig       smallint = null,
   @i_area               smallint = null,
   @i_cuenta             cuenta = null,
   @i_debcred            char(1) = null,
   @i_valor	             money = null,
   @i_modulo             tinyint = null,
   @i_operac             descripcion = null,
   @i_beneficiario       descripcion = null,
   @i_cheque             descripcion = null,
   @i_relacionado        char(1) = 'N',
   @i_producto           tinyint = null,     -- OJE
   @i_banco              varchar(4) = null,
   @i_opc_orden          char(1) = null,
   @i_oper_banco         char(4) = null,
   @i_origen             char(1) = NULL
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_moneda		 tinyint,      /* moneda de la cuenta */
   @w_moneda_base        tinyint,      /* moneda base de la empresa*/
   @w_extranjera	 tinyint,      /* flag */
   @w_existe             tinyint,       /* existe el registro*/
   @w_cad1               varchar(1024),
   @w_cad2               varchar(1024),
   @w_siguiente                 int,
   @w_traslado                  char(1),
   @w_comprobante               int,
   @w_fecha_tran                datetime,
   @w_oficina_orig              smallint,
   @w_area_orig                 smallint,
   @w_fecha_dig                 datetime,
   @w_fecha_mod                 datetime,
   @w_digitador                 descripcion,
   @w_descripcion               descripcion,
   @w_comp_tipo                 int,
   @w_detalles                  smallint,
   @w_tot_debito                money,
   @w_tot_credito               money,
   @w_tot_debito_me             money,
   @w_tot_credito_me            money,
   @w_automatico                int,
   @w_reversado                 char(1),
   @w_autorizado                char(1),
   @w_autorizante               descripcion,
   @w_referencia                varchar(10),
   @w_causa_anula               char(2),
   @w_tipo_compro               char(1),
   @w_estado                    char(1),
   @w_asiento                   smallint

select @w_today = getdate()
select @w_sp_name = 'sp_asicon'


/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6835 and @i_operacion in ('R','S')) or
   (@t_trn <> 6835 and @i_operacion = 'B') or
   (@t_trn <> 6870 and @i_operacion = 'C') or
   (@t_trn <> 6871 and @i_operacion = 'I') or
   (@t_trn <> 6871 and @i_operacion = 'G') or
   (@t_trn <> 6873 and @i_operacion = 'D')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end


/* Consulta opcion SEARCH */
/*************************/

if @i_operacion = 'S'
begin
	set rowcount 20
    
    select @w_cad1 = '',
           @w_cad2 = ''
    if @i_modo = 0
    begin
--		  cl_refinterna           
--		from cob_conta..cb_conciliacion
        
        select @w_cad1 = 'select convert(char(10), cl_fecha_tran,' + convert(varchar,@i_formato_fecha) + '), ' +
                'cl_comprobante, cl_asiento, cl_debcred, cl_valor, cl_oper_banco, cl_cheque, cl_banco, cl_cuenta ' +
                'from cob_conta_tercero..ct_conciliacion, cob_conta_tercero..ct_scomprobante ' +
                'where cl_empresa = ' + convert(varchar,@i_empresa) +
                ' and cl_cuenta_cte = '+'''' + @i_cuenta +
                ''''+' and cl_comprobante is not NULL ' +
                ' and cl_relacionado = '+'''' + @i_relacionado +
                ''''+' and cl_banco = '+'''' + @i_banco +
                ''''+' and cl_fecha_tran <= '+'''' + convert(varchar, @i_fecha) + ''''  +
		        ' and sc_empresa = cl_empresa' +
		        ' and sc_producto = cl_producto' + 
		        ' and sc_fecha_tran = cl_fecha_tran' +
		        ' and sc_comprobante = cl_comprobante' +
		        ' and sc_estado = '+''''+'P'+''''
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
           	/*Registro no existe */
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
        select @w_cad1 = 'select convert(char(10), cl_fecha_tran,' + convert(varchar,@i_formato_fecha) + '), ' +
                'cl_comprobante, cl_asiento, cl_debcred, cl_valor, cl_oper_banco, cl_cheque, cl_banco, cl_cuenta ' +
                'from cob_conta_tercero..ct_conciliacion, cob_conta_tercero..ct_scomprobante ' + 
                'where cl_empresa = ' + convert(varchar,@i_empresa) +
                ' and cl_cuenta_cte = '+'''' + @i_cuenta +
                ''''+' and cl_banco = '+'''' + @i_banco +
                ''''+' and cl_comprobante is not NULL ' +
                ' and cl_relacionado = '+'''' + @i_relacionado +
                ''''+' and cl_fecha_tran <= '+'''' + convert(varchar, @i_fecha) + '''' +
		        ' and sc_empresa = cl_empresa' +
		        ' and sc_producto = cl_producto' + 
		        ' and sc_fecha_tran = cl_fecha_tran' +
		        ' and sc_comprobante = cl_comprobante' +
		        ' and sc_estado = '+ ''''+ 'P'+ ''''
        if @i_opc_orden is null or @i_opc_orden = 'F'
        begin
            select @w_cad2 = ' and ( (cl_fecha_tran = '+'''' + convert(varchar, @i_fecha_tran1) + '''' +
                   ' and cl_comprobante = ' + convert(varchar, @i_comprobante1) + 
                   ' and cl_asiento > ' + convert(varchar, @i_asiento1) +  ')' +
                   ' or (cl_fecha_tran = '+'''' + convert(varchar, @i_fecha_tran1) + '''' +
	               ' and cl_comprobante > ' + convert(varchar, @i_comprobante1) + ')' +
	               ' or (cl_fecha_tran > '+'''' + convert(varchar, @i_fecha_tran1) + ''''+' ))' +
		           ' order by cl_fecha_tran, cl_comprobante, cl_asiento'
        end
        else if @i_opc_orden = 'O'
        begin
            select @w_cad2 = ' and (( cl_oper_banco = '+'''' + @i_oper_banco + '''' +
                   ' and cl_comprobante = ' + convert(varchar, @i_comprobante1) + 
                   ' and cl_asiento > ' + convert(varchar, @i_asiento1) +  ')' +
                   ' or (cl_oper_banco = '+'''' +  @i_oper_banco + '''' +
	               ' and cl_comprobante > ' + convert(varchar, @i_comprobante1) + ')' +
	               ' or (cl_oper_banco > '+'''' + @i_oper_banco + ''''+' ))' +
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
       	   /*Registro no existe */
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

-- Inicio - Operacion B

if @i_operacion = 'B'
begin
	set rowcount 20
	begin
		if @i_modo = 0
		begin
	   	select 
		  cl_comprobante,
                  cl_asiento,
		  cl_operacion,	
		  cl_cheque
		from cob_conta..cb_conciliacion
	   	where    cl_empresa      = @i_empresa and
			 cl_comprobante  = @i_comprobante and
                         cl_fecha        = @i_fecha and
                         cl_oficina_orig = @i_oficina_orig
			 order by cl_asiento

	   	if @@rowcount = 0
       	   	begin
           	/*Registro no existe */
            		--exec cobis..sp_cerror
        		--@t_debug = @t_debug,
        		--@t_file  = @t_file, 
        		--@t_from  = @w_sp_name,
        		--@i_num   = 601159
        		return 1 
    	   	end

		end
		else begin
	   	select
		  cl_comprobante,
                  cl_asiento,
		  cl_operacion,	
		  cl_cheque
		from cob_conta..cb_conciliacion
	   	where    cl_empresa      = @i_empresa and
			 cl_comprobante  = @i_comprobante and
                         cl_fecha        = @i_fecha and 
                         cl_oficina_orig = @i_oficina_orig and
                         cl_asiento      > @i_asiento1
			 order by cl_asiento

	
		   if @@rowcount = 0
       		   begin
       	    		/*Registro no existe */
       	     		--exec cobis..sp_cerror
        		--@t_debug = @t_debug,
        		--@t_file  = @t_file, 
        		--@t_from  = @w_sp_name,
        		--@i_num   = 601159
        		return 1 
    	   	   end
		end
	end
    return 0
end


-- Fin - Operacion B


if @i_operacion = 'C' -- Informacion extra
begin
   select --"MODULO      "=cl_modulo,
          'OPERACION   '=cl_operacion,
--          'BENEFICIARIO'=cl_beneficiario, 
          'CHEQUE      '=cl_cheque
 from cob_conta..cb_conciliacion
   where cl_empresa       = @i_empresa
     and cl_fecha         = @i_fecha
     and cl_comprobante   = @i_comprobante 
     and cl_oficina_orig  = @i_oficina_orig
     and cl_asiento       = @i_asiento
--     and cl_cuenta        = @i_cuenta   --OJE
end

/* Insercion */
if @i_operacion = 'I'
begin
   begin tran
   if @i_origen = 'C'
   begin
           CREATE TABLE #sasiento
           (sa_producto       tinyint         NULL,
           sa_comprobante     int             NULL,
           sa_empresa         tinyint         NULL,
           sa_fecha_tran      datetime        NULL,
           sa_asiento         smallint        NULL,
           sa_cuenta          char(14)        NULL,
           sa_oficina_dest    smallint        NULL,
           sa_area_dest       smallint        NULL,
           sa_credito         money           NULL,
           sa_debito          money           NULL,
           sa_concepto        varchar(160)    NULL,
           sa_credito_me      money           NULL,
           sa_debito_me       money           NULL,
           sa_cotizacion      money           NULL,
           sa_tipo_doc        char(1)         NULL,
           sa_tipo_tran       char(1)         NULL,
           sa_moneda          tinyint         NULL,
           sa_opcion          tinyint         NULL,
           sa_ente            int             NULL,
           sa_con_rete        char(4)         NULL,
           sa_base            money           NULL,
           sa_valret          money           NULL,
           sa_con_iva         char(4)         NULL,
           sa_valor_iva       money           NULL,
           sa_iva_retenido    money           NULL,
           sa_con_ica         char(4)         NULL,
           sa_valor_ica       money           NULL,
           sa_con_timbre      char(4)         NULL,
           sa_valor_timbre    money           NULL,
           sa_con_iva_reten   char(4)         NULL,
           sa_con_ivapagado   char(4)         NULL,
           sa_valor_ivapagado money           NULL,
           sa_documento       char(24)        NULL,
           sa_mayorizado      char(1)         NULL,
           sa_origen_mvto     varchar(20)     NULL,
           sa_con_dptales     char(4)         NULL,
           sa_valor_dptales   money           NULL)
                  

--print '@i_comprobante: '+cast(@i_comprobante as varchar)
--print '@i_fecha: '+cast(@i_fecha as varchar)
--print '@i_oficina: '+cast(@i_oficina as varchar)
--print '@i_empresa: '+cast(@i_empresa as varchar)

          select 
          @w_comprobante = co_comprobante,           
          @w_fecha_tran = convert(varchar(10),co_fecha_tran,101),
          @w_oficina_orig = co_oficina_orig,
          @w_area_orig = co_area_orig,
          @w_fecha_dig = co_fecha_dig,
          @w_fecha_mod = co_fecha_mod,
          @w_digitador = co_digitador,
          @w_descripcion = co_descripcion,
          @w_comp_tipo = co_comp_tipo,
          @w_detalles = co_detalles,
          @w_tot_debito = co_tot_debito,
          @w_tot_credito = co_tot_credito,
          @w_tot_debito_me = co_tot_debito_me,
          @w_tot_credito_me = co_tot_credito_me,
          @w_automatico = co_automatico,
          @w_reversado = co_reversado,
          @w_autorizado = co_autorizado,
          @w_autorizante = co_autorizante,
          @w_referencia = co_referencia,
          @w_causa_anula = co_causa_anula,
          @w_tipo_compro = co_tipo_compro,
          @w_estado = co_estado
          from cob_conta..cb_comprobante
          where co_empresa = @i_empresa
          and   co_autorizado  = 'S'
          and   isnull(co_traslado,'N') <> 'S'
          and   co_comprobante = @i_comprobante
          and   co_fecha_tran = @i_fecha
          and   co_oficina_orig = @i_oficina 
          
          if @@rowcount = 0
          begin
              print 'No existen registros'
              rollback tran
              return 1
          end
          
--	      print '@w_fecha_tran: ' + cast(@w_fecha_tran as varchar)
--	      print '@w_comprobante: ' + cast(@w_comprobante as varchar)             
          
          exec @w_return = cob_conta..sp_cseqcomp
              @i_tabla     = 'cb_scomprobante',
              @i_empresa   = @i_empresa,
              @i_fecha     = @i_fecha,
              @i_modulo    = 6,
              @i_modo	     = 0, /* 0 para numerar por empresa */
              @o_siguiente = @w_siguiente out
          if @w_return <> 0
          begin	/* Error en insercion de header de comprobante en tabla temporal */
              print 'Error en insercion de header de comprobante en tabla temporal'
              rollback tran
              return 603019
          end
          
	      insert into cob_conta_tercero..ct_scomprobante (
	      	   sc_producto,sc_comprobante,sc_empresa,sc_fecha_tran,
	      	   sc_oficina_orig,sc_area_orig,sc_fecha_gra,sc_digitador,
	      	   sc_descripcion,sc_perfil,sc_detalles,sc_tot_debito,
	      	   sc_tot_credito,sc_tot_debito_me,sc_tot_credito_me,sc_automatico,
	      	   sc_reversado,sc_estado,sc_mayorizado,sc_observaciones,
	      	   sc_comp_definit,sc_usuario_modulo,sc_causa_error,sc_comp_origen,
	      	   sc_tran_modulo)
	      values (6,@w_siguiente,@i_empresa,@w_fecha_tran,
	      	   @w_oficina_orig,@w_area_orig,@w_today,@w_digitador,
	      	   @w_descripcion,' ',@w_detalles,@w_tot_debito,
	      	   @w_tot_credito,@w_tot_debito_me,@w_tot_credito_me,@w_automatico,
	      	   @w_reversado,'P','N',null,
	      	   @w_comprobante,@w_digitador,null,null,null)
	      if @@error <> 0 or @@rowcount = 0
	      begin	/* Error en insercion de header de comprobante en tabla temporal */
            print 'Error en insercion de header de comprobante en tabla temporal'
	      	rollback tran
	      	return 603019
	      end
          
--	      print '@w_fecha_tran: ' + cast(@w_fecha_tran as varchar)
--	      print '@w_comprobante: ' + cast(@w_comprobante as varchar)
	      insert #sasiento
	      	    (sa_producto,sa_comprobante,sa_empresa,sa_fecha_tran,
	      	    sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
	      	    sa_credito,sa_debito,sa_concepto,sa_credito_me,
	      	    sa_debito_me,sa_cotizacion,sa_tipo_doc,sa_tipo_tran,
	      	    sa_moneda,sa_opcion,sa_ente,sa_con_rete,
	      	    sa_base,sa_valret,sa_con_iva,sa_valor_iva,
	      	    sa_iva_retenido,sa_con_ica,sa_valor_ica,sa_con_timbre,
	      	    sa_valor_timbre,sa_con_iva_reten,sa_con_ivapagado,sa_valor_ivapagado,
	      	    sa_documento,sa_mayorizado,sa_origen_mvto,sa_con_dptales,
	      	    sa_valor_dptales)
	      select  6,@w_comprobante,as_empresa,as_fecha_tran,
	       	as_asiento,as_cuenta,as_oficina_dest,as_area_dest,
	       	as_credito,as_debito,as_concepto,as_credito_me,
	       	as_debito_me,as_cotizacion,as_tipo_doc,isnull(as_tipo_tran,'N'),
	       	as_moneda,as_opcion,NULL,NULL,
	       	NULL,NULL,NULL,NULL,
	       	NULL,NULL,NULL,NULL,
	       	NULL,NULL,NULL,NULL,
	       	NULL,'N',NULL,NULL,
	       	NULL
	      from cob_conta..cb_asiento
	      where as_empresa	= @i_empresa
	      and as_fecha_tran	= @w_fecha_tran
	      and as_comprobante	= @w_comprobante
	      and as_asiento		>= 0
	      and as_oficina_orig	= @w_oficina_orig
	      if @@error <> 0 or @@rowcount = 0
	      begin	/* 'Error en insercion de Detalle de Comprobante en tabla temporal' */
	        print 'Error en insercion de Detalle de Comprobante en tabla temporal'
	      	rollback tran
	      	return 603020
	      end	   
	      
          insert cob_conta_tercero..ct_conciliacion (
          cl_producto,        cl_comprobante,         cl_empresa,
          cl_fecha_tran,      cl_asiento,             cl_cuenta,
          cl_oficina_dest,    cl_area_dest,           cl_debcred,
          cl_valor,           
          cl_oper_banco,      cl_doc_banco,           cl_banco,           
          cl_fecha_est,       cl_cuenta_cte,          cl_detalle,         
          cl_relacionado,     cl_modulo,              cl_beneficiario,    
          cl_cheque,          cl_refinterna,          cl_fecha_conc)
          
          select 
          6,                  @w_siguiente,           @i_empresa,
          @i_fecha,           as_asiento,             as_cuenta,
          as_oficina_dest,    as_area_dest,           case as_debito_me - as_credito_me when 0 then
                                                      case as_debito when 0 then 'C' else 'D' end
                                                      else
                                                          case as_debito_me when 0 then 'C' else 'D' end	--ES ME
                                                      end,
          case as_debito_me - as_credito_me when 0 then
          case as_debito when 0 then as_credito else as_debito end           --ES MN
          else
          case as_debito_me when 0 then as_credito_me else as_debito_me end  --ES ME
          end,
          @i_oper_banco,        NULL,                   @i_banco,
          NULL,               ba_ctacte,              NULL,
          'N',                NULL,                   NULL,
          @i_cheque,          NULL,                   NULL
          from cob_conta..cb_comprobante,
               cob_conta..cb_asiento,
               cob_conta..cb_banco
          where co_fecha_tran   = @i_fecha
          and   co_comprobante  = @i_comprobante
          and   co_oficina_orig = @i_oficina
          and   co_empresa      = @i_empresa
          and   as_fecha_tran   = co_fecha_tran
          and   as_comprobante  = co_comprobante
          and   as_asiento      > 0
          and   as_oficina_orig = co_oficina_orig
          and   as_empresa      = co_empresa
          and   ba_banco        = @i_banco
          and   as_cuenta       = ba_cuenta
          
          if @@error <> 0
	      begin	/* 'Error en insercion de datos de conciliacion' */
	         print 'Error en insercion de datos de conciliacion'
             rollback tran
             return 603060
          end
/*        
	      update #sasiento set sa_comprobante = @w_siguiente
	      if @@error <> 0
	      begin	
	       	rollback tran
	       	return 605088
	      end
*/        
	      insert cob_conta_tercero..ct_sasiento
	      (sa_producto,sa_comprobante,sa_empresa,sa_fecha_tran,
	      sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
	      sa_credito,sa_debito,sa_concepto,sa_credito_me,
	      sa_debito_me,sa_cotizacion,sa_tipo_doc,sa_tipo_tran,
	      sa_moneda,sa_opcion,sa_ente,sa_con_rete,
	      sa_base,sa_valret,sa_con_iva,sa_valor_iva,
	      sa_iva_retenido,sa_con_ica,sa_valor_ica,sa_con_timbre,
	      sa_valor_timbre,sa_con_iva_reten,sa_con_ivapagado,sa_valor_ivapagado,
	      sa_documento,sa_mayorizado,sa_origen_mvto,sa_con_dptales,
	      sa_valor_dptales)
	      select 
	      sa_producto,@w_siguiente,sa_empresa,sa_fecha_tran,
	      sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
	      sa_credito,sa_debito,sa_concepto,sa_credito_me,
	      sa_debito_me,sa_cotizacion,sa_tipo_doc,sa_tipo_tran,
	      sa_moneda,sa_opcion,sa_ente,sa_con_rete,
	      sa_base,sa_valret,sa_con_iva,sa_valor_iva,
	      sa_iva_retenido,sa_con_ica,sa_valor_ica,sa_con_timbre,
	      sa_valor_timbre,sa_con_iva_reten,sa_con_ivapagado,sa_valor_ivapagado,
	      sa_documento,sa_mayorizado,sa_origen_mvto,sa_con_dptales,
	      sa_valor_dptales
	      from #sasiento
	      if @@error <> 0
	      begin	/* 'Error en insercion de Detalle de Comprobante en tabla temporal' */
	        print 'Error en insercion de Detalle de Comprobante en tabla temporal'
	      	rollback tran
	      	return 603020
	      end
          
	      update cob_conta..cb_comprobante set co_traslado = 'S'
	      where  co_empresa	= @i_empresa
	      and    co_fecha_tran	= @w_fecha_tran
	      and    co_comprobante	= @w_comprobante
	      and    co_oficina_orig	= @w_oficina_orig
	      if @@error <> 0
	      begin	/* 'Error en actualizacion de estado del comprobante' */
	        print 'Error en actualizacion de estado del comprobante'
	      	rollback tran
	      	return 603022
	      end	   	
          select @w_traslado = 'S'
          
          
          select @i_asiento = 1
          select @i_scomprobante = @i_comprobante
          select @i_oficina_orig = @i_oficina
          select @i_operac = @i_oper_banco
       
   end
        insert into cob_conta..cb_conciliacion (
             --   cl_producto,   -- OJE
		cl_empresa,
		cl_fecha,
		cl_comprobante,
--                cl_scomprobante,
		cl_asiento,
--		cl_cuenta, --OJE
--		cl_debcred,
--		cl_valor,
--		cl_modulo,
		cl_operacion,
--		cl_oficina,
--		cl_area,	
--		cl_beneficiario,	
		cl_cheque,
                cl_oficina_orig)
--		cl_banco,	
--		cl_fecha_est,
--                cl_relacionado,  -- OJE
--		cl_detalle)
	values (
              --  @i_producto,     -- OJE
		@i_empresa,
		@i_fecha,
		@i_scomprobante,
--		@i_scomprobante,
		@i_asiento,
--		@i_cuenta,
--		@i_debcred,
--		@i_valor,
--		@i_modulo,
		@i_operac,
--		@i_oficina,
--		@i_area,	
--		@i_beneficiario,	
		@i_cheque,
                @i_oficina_orig)
--		NULL,     
--		NULL,                 
--	        @i_relacionado,     -- OJE   OJOJOJOJOJO
--        	NULL)
    commit tran
    select @w_asiento = cl_asiento 
    from cob_conta_tercero..ct_conciliacion
    where cl_comprobante = @w_siguiente
    
    select @w_siguiente
    select @w_asiento
end



-- Inicio - Operacion G
if @i_operacion = 'G'
begin  
   begin tran
        insert into cob_conta..cb_tconciliacion (
		tc_empresa,
		tc_fecha,
		tc_comprobante,
		tc_asiento,
		tc_operacion,
		tc_cheque,
                tc_oficina_orig)
	values (
		@i_empresa,
		@i_fecha,
		@i_comprobante,
		@i_asiento,
		@i_operac,
		@i_cheque,
                @i_oficina_orig)

    commit tran
end
-- Fin - Operacion G



if @i_operacion = 'D'
begin
     begin tran

         delete cob_conta..cb_conciliacion where 
		cl_empresa = @i_empresa and
		cl_comprobante = @i_comprobante and
		cl_fecha = @i_fecha and
                cl_oficina_orig = @i_oficina_orig and
--		cl_cuenta = @i_cuenta and
 		(cl_asiento = @i_asiento or @i_asiento = null)

	 update cob_conta..cb_conciliacion
		set cl_asiento = cl_asiento -1
	 where	cl_empresa = @i_empresa and
		cl_comprobante = @i_comprobante and
		cl_fecha = @i_fecha and
		cl_asiento > @i_asiento and
                cl_oficina_orig = @i_oficina_orig
--		cl_cuenta = @i_cuenta

	 if @@error <> 0
       	   begin
          	/*Error en eliminacion de datos de conciliacion */
       	     	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 601164
        	return 1 
    	  end
      commit tran
return 0
end

/* Consulta opcion SEARCH */
/*************************/

if @i_operacion = 'M'
begin
    set rowcount 20
    begin
        select @w_cad1 = '',
               @w_cad2 = ''
        if @i_modo = 0
        begin
            -- from cob_conta..cb_conciliacion
            select @w_cad1 = 'select convert(char(10),cl_fecha_tran,' + convert(varchar,@i_formato_fecha) + '),' +
                   'cl_comprobante, cl_asiento, cl_debcred,	cl_valor, cl_oper_banco, cl_cheque, cl_banco, cl_refinterna, cl_cuenta ' +
                   'from cob_conta_tercero..ct_conciliacion ' +
                   'where cl_empresa = ' + convert(varchar,@i_empresa) + ' and ' +
	           'cl_cuenta_cte = '+'''' + @i_cuenta + ''''+' and ' + --OJE
                   'cl_comprobante is not NULL and ' +
                   'cl_relacionado = '+'''' + @i_relacionado + ''''+' and ' +
                   'cl_banco = '+'''' + @i_banco + ''''+' and ' +
                   'cl_tipo_conciliacion in('+''''+'A'+''''+','+''''+'M'+''''+')' 

            if @i_opc_orden is null or @i_opc_orden = 'F'
			begin
                select @w_cad2 = ' order by cl_fecha_tran,cl_comprobante,cl_asiento'
            end
            else if @i_opc_orden = 'O'
            begin
                select @w_cad2 = ' order by cl_oper_banco,cl_comprobante,cl_asiento'
            end
            else if @i_opc_orden = 'V'
            begin
                select @w_cad2 = ' order by cl_valor,cl_comprobante,cl_asiento'
            end
            exec (@w_cad1 + @w_cad2)
            
            if @@rowcount = 0
       	   	begin
           	/*Registro no existe */
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
            --  from cob_conta..cb_conciliacion
	   	    select @w_cad1 = 'select convert(char(10),cl_fecha_tran,' + convert(varchar,@i_formato_fecha) + '),' +
		           'cl_comprobante,cl_asiento, cl_debcred, cl_valor, cl_oper_banco, cl_cheque, cl_banco, cl_refinterna, cl_cuenta ' +
		           'from cob_conta_tercero..ct_conciliacion ' +
	   	           'where cl_empresa = ' + convert(varchar,@i_empresa) + ' and ' +
         		       'cl_cuenta_cte = '+'''' + @i_cuenta + '+'''' and ' +	--OJE
                               'cl_banco = '+'''' + @i_banco + ''''+' and ' +
			       'cl_comprobante is not NULL and ' +
			       'cl_relacionado = '+'''' + @i_relacionado + ''''+' and ' +
			       'cl_tipo_conciliacion in('+''''+'A'+''''+','+''''+'M'+''''+')' 
			if @i_opc_orden is null or @i_opc_orden = 'F'
			begin
			    select @w_cad2 = '(( cl_fecha_tran = '+'''' + convert(varchar, @i_fecha_tran1) + ''''+' and ' +
			       'cl_comprobante = ' + convert(varchar, @i_comprobante1) + ' and ' +
			       'cl_asiento > ' + convert(varchar,@i_asiento1) + ') or ' +
			       '(cl_fecha_tran = '+'''' + convert(varchar, @i_fecha_tran1) + ''''+' and ' +
			       'cl_comprobante > ' + convert(varchar, @i_comprobante1) + ') or ' +
			       '(cl_fecha_tran > '+'''' + convert(varchar,@i_fecha_tran1) + ''''+'))' +
                   ' order by cl_fecha_tran,cl_comprobante,cl_asiento'
            end
            else if @i_opc_orden = 'O'
            begin
                select @w_cad2 = '(( cl_oper_banco = '+'''' + @i_oper_banco + ''''+' and ' +
			       'cl_comprobante = ' + convert(varchar, @i_comprobante1) + ' and ' +
			       'cl_asiento > ' + convert(varchar,@i_asiento1) + ') or ' +			       
			       '(cl_oper_banco = '+'''' + @i_oper_banco + ''''+' and ' +
			       'cl_comprobante > ' + convert(varchar, @i_comprobante1) + ') or ' +
			       '(cl_oper_banco > '+'''' + @i_oper_banco + ''''+'))' +
                   ' order by cl_oper_banco,cl_comprobante,cl_asiento'
            end
            else if @i_opc_orden = 'V'
            begin
                select @w_cad2 = '(( cl_valor = ' + convert(varchar, @i_valor) + ' and ' +
			       'cl_comprobante = ' + convert(varchar, @i_comprobante1) + ' and ' +
			       'cl_asiento > ' + convert(varchar,@i_asiento1) + ') or ' +
			       '(cl_valor = ' + convert(varchar, @i_valor) + ' and ' +
			       'cl_comprobante > ' + convert(varchar, @i_comprobante1) + ') or ' +
			       '(cl_valor > ' + convert(varchar,@i_valor) + '))' +
                   ' order by cl_valor,cl_comprobante,cl_asiento'
            end
            exec (@w_cad1 + @w_cad2)
	
		    if @@rowcount = 0
       		begin
       	    		/*Registro no existe */
       	     		--exec cobis..sp_cerror
        		--@t_debug = @t_debug,
        		--@t_file  = @t_file, 
        		--@t_from  = @w_sp_name,
        		--@i_num   = 601159
        	    return 1 
    	   	end
		end
	end
    return 0
end

if @i_operacion = 'R'
begin
    select 1
    from cob_conta..cb_cuenta_proceso
    where cp_proceso in (6003,6095)
    and   cp_oficina >= 0 
    and   cp_area >= 0 
    and   cp_cuenta = @i_cuenta
    and   cp_empresa = @i_empresa
    
    return 0
end