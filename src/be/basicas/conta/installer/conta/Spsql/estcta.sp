/************************************************************************/
/*	Archivo: 		estcta.sp				*/
/*	Stored procedure: 	sp_estcta				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     26-Enero-1995 				*/
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
/*	   Mantenimiento al catalogo de Estados de cuenta               */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	26/Ene/1995	G Jaramillo     Emision Inicial			*/
/*	06/Nov/1996     D.Guerrero      Consulta de asientos contables  */
/*	                                relacionados a transacciones 'R'*/
/*	07/Abr/1999	Juan C. G¢mez	Cambio de tablas y nuevo	*/
/*					par metro JCG10			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_estcta')
	    drop proc sp_estcta
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_estcta (
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
   @i_banco              varchar( 20)  = null,
   @i_fecha              datetime  = null ,
   @i_fecha_tran         datetime  = null ,
   @i_detalle		 smallint = null,
   @i_saldo_ini		 money = null,
   @i_saldo_fin		 money = null,
   @i_banco1		 varchar(20) = null,
   @i_fecha1		 datetime = null,
   @i_formato_fecha	 smallint = null,
   @i_relacionado  	 char(1) = null,
   @i_cuenta		 cuenta = null,	  
   @i_definitivo  	 char(1) = 'N',
   @i_ordenar       char(1)  = 'F'   		
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_banco              varchar( 20),
   @w_fecha              datetime,
   @w_fecha_conc         datetime,	 
   @w_saldo_ini          money,
   @w_saldo_fin          money,
   @w_cuenta		 cuenta, 	
   @w_definitivo  	 char(1),
   @w_resp               tinyint,
   @w_cadena_select             varchar(255),
   @w_cadena_from               varchar(255),
   @w_cadena_where              varchar(255),
   @w_cadena_order              varchar(255),
   @w_cadena_where2             varchar(255),
   @w_cadena_where3             varchar(255)
    	

select @w_today = getdate()
select @w_sp_name = 'sp_estcta'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6771 and @i_operacion = 'I') or
   (@t_trn <> 6772 and @i_operacion = 'U') or
   (@t_trn <> 6773 and @i_operacion = 'D') or
   (@t_trn <> 6775 and @i_operacion = 'S') or
   (@t_trn <> 6776 and @i_operacion = 'Q') or
   (@t_trn <> 6778 and @i_operacion = 'R') or
   (@t_trn <> 6779 and @i_operacion = 'V')

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 

end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A' and @i_operacion <> 'V' 
begin
    select 
         @w_empresa = es_empresa,
         @w_banco = es_banco,
         @w_fecha = es_fecha,
         @w_saldo_ini = es_saldo_ini,
         @w_saldo_fin = es_saldo_fin,
	 @w_cuenta = es_cuenta,		
	 @w_definitivo = es_definitivo	
    from cob_conta_tercero..ct_estcta
    where 
         es_empresa = @i_empresa and
         es_banco = @i_banco and
         es_fecha = @i_fecha and
	 es_cuenta = @i_cuenta		

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end


/* Insercion del registro */
/**************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
    begin tran
    	delete cob_conta_tercero..ct_estcta	
    	where es_empresa = @i_empresa and
          es_banco = @i_banco and
          es_fecha = @i_fecha and
	  es_cuenta = @i_cuenta		

    	delete cob_conta_tercero..ct_detest	
    	where de_empresa = @i_empresa and
          de_banco = @i_banco and
          de_fecha = @i_fecha and
	  de_cuenta = @i_cuenta			

         insert into cob_conta_tercero..ct_estcta(	
              es_empresa, es_banco, es_fecha, es_saldo_ini, es_saldo_fin, es_cuenta, es_definitivo)	
         select te_empresa, te_banco, te_fecha, te_saldo_ini, te_saldo_fin, te_cuenta, @i_definitivo   
     	 from cob_conta_tercero..ct_testcta	
	 where te_empresa = @i_empresa and
		te_banco = @i_banco and
		te_fecha = @i_fecha and
		te_cuenta = @i_cuenta	

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603059

	     delete cob_conta_tercero..ct_testcta	
	     where te_empresa = @i_empresa and
		   te_banco = @i_banco and
		   te_fecha = @i_fecha and
		   te_cuenta = @i_cuenta	

	     delete cob_conta_tercero..ct_tdetest	
	     where td_empresa = @i_empresa and
		   td_banco = @i_banco and
		   td_fecha = @i_fecha and
		   td_cuenta = @i_cuenta	
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_estcta
         values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
         @i_empresa, @i_banco, @i_fecha, @i_saldo_ini, @i_saldo_fin)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1 
         end

	insert into cob_conta_tercero..ct_detest (	--JCG10
	       de_empresa,de_banco,de_fecha,de_detalle,de_operacion,
	       de_referencia,de_valor,de_debcred, de_cuenta,de_fecha_tran)	--JCG10
	select td_empresa,td_banco,td_fecha,td_detalle,td_operacion,
	       td_referencia,td_valor,td_debcred, td_cuenta,td_fecha_tran	--JCG10 
	from cob_conta_tercero..ct_tdetest	--JCG10
	where td_empresa = @i_empresa and
		td_banco = @i_banco and
		td_fecha = @i_fecha and
		td_cuenta = @i_cuenta	--JCG10

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603059

	     delete cob_conta_tercero..ct_testcta	
	     where te_empresa = @i_empresa and
		   te_banco = @i_banco and
		   te_fecha = @i_fecha and
		   te_cuenta = @i_cuenta	

	     delete cob_conta_tercero..ct_tdetest	
	     where td_empresa = @i_empresa and
		   td_banco = @i_banco and
		   td_fecha = @i_fecha and
		   td_cuenta = @i_cuenta	
             return 1 
         end
	 delete cob_conta_tercero..ct_testcta	
	 where te_empresa = @i_empresa and
	   te_banco = @i_banco and
	   te_fecha = @i_fecha and
	   te_cuenta = @i_cuenta	

	 delete cob_conta_tercero..ct_tdetest	
	 where td_empresa = @i_empresa and
	   td_banco = @i_banco and
	   td_fecha = @i_fecha and
	   td_cuenta = @i_cuenta	
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 607021
        return 1 
    end

/***** Integridad Referencial *****/
/*****                        *****/


    begin tran
         delete cob_conta_tercero..ct_estcta	--JCG10
         where 
         es_empresa = @i_empresa and
         es_banco = @i_banco and
         es_fecha = @i_fecha and
	 es_cuenta = @i_cuenta	--JCG10

	 delete cob_conta_tercero..ct_detest	--JCG10
	 where de_empresa = @i_empresa and
		de_banco = @i_banco and
		de_fecha = @i_fecha and
		de_cuenta = @i_cuenta	--JCG10        
                    
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 607022
             return 1 
         end

            


         /* Transaccion de Servicio */
         /***************************/

         insert into ts_estcta
         values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
         @w_empresa,
         @w_banco,
         @w_fecha,
         @w_saldo_ini,
         @w_saldo_fin)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1 
         end
    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	   if @w_existe = 1
           begin
              select @w_empresa, @w_banco, @w_fecha, @w_saldo_ini, @w_saldo_fin, @w_cuenta, @w_definitivo	


	      select de_detalle,de_operacion,de_referencia,de_valor,de_debcred, de_cuenta,
                     convert(char(10),de_fecha_tran,@i_formato_fecha)	
	      from cob_conta_tercero..ct_detest	
	      where de_empresa = @i_empresa and
		de_banco = @i_banco and
		de_fecha = @i_fecha and
		de_cuenta = @i_cuenta	
             order by de_fecha_tran

	      if @@rowcount = 0
              begin
    		 /*Registro no existe */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1 
              end
           end
    	   else begin
    		/*Registro no existe */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601159
              return 1 
           end
	end
	else begin
	      select de_detalle,de_operacion,de_referencia,de_valor,de_debcred, de_cuenta,
                     convert(char(10),de_fecha_tran,@i_formato_fecha)
	      from cob_conta_tercero..ct_detest	
	      where de_empresa = @i_empresa and
		de_banco = @i_banco and
		de_fecha = @i_fecha and
		de_cuenta = @i_cuenta and	
		de_fecha_tran >= @i_fecha_tran and	
		de_detalle > @i_detalle
		order by de_fecha_tran

	      if @@rowcount = 0
	      begin
    		/*No existen mas registros*/
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
                return 1 
              end

	end
	return 0	
end

/* Consulta opcion SEARCH*/
/*************************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	      select 'Banco' = es_banco,
		     'Fecha' = convert(char(10),es_fecha,@i_formato_fecha),
		     'Saldo Inicial' = es_saldo_ini,
		     'Saldo Final' = es_saldo_fin,
		     'Cuenta' = es_cuenta	
	      from cob_conta_tercero..ct_estcta	
	      where es_empresa = @i_empresa and
		   (es_banco = @i_banco or @i_banco is NULL) and
		   (es_fecha = @i_fecha or @i_fecha is NULL) 
	      order by es_banco, es_fecha

	      if @@rowcount = 0
              begin
    		 /* No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1 
              end
	end
	else begin
	      select 'Banco' = es_banco,
		     'Fecha' = convert(char(10),es_fecha,@i_formato_fecha),
		     'Saldo Inicial' = es_saldo_ini,
		     'Saldo Final' = es_saldo_fin,
		     'Cuenta' = es_cuenta	
	      from cob_conta_tercero..ct_estcta	
	      where es_empresa = @i_empresa and
		   (es_banco = @i_banco or @i_banco = NULL) and
		   (es_fecha = @i_fecha or @i_fecha = NULL) and
		  ((es_banco = @i_banco1 and es_fecha > @i_fecha1) or
		   (es_banco > @i_banco1))
	      order by es_banco, es_fecha

	      if @@rowcount = 0
	      begin
    		/*No existen mas registros*/
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601159
                return 1 
              end
	end
	return 0
end


/* Consulta opcion VALUE*/
/*************************/

if @i_operacion = 'V'
begin

if exists ( select *
	      from cob_conta_tercero..ct_estcta	
	      where es_empresa = @i_empresa 
              and   es_banco   = @i_banco  
	      and   es_fecha   = @i_fecha 
              and   es_cuenta  = @i_cuenta)
begin
  select @w_resp = 1
end
else
begin
  select @w_resp = 0
end

select @w_resp

return 0
end

/* Consulta del detalle de esatdos de cuentas no relacionados a asientos*/
/************************************************************************/

if @i_operacion = 'R'
begin
 	set rowcount 20

	/*select @w_fecha_conc=isnull(max(bc_fecha),'01/01/1900') from cob_conta_tercero..ct_banco_conciliado
                                  where bc_banco = @i_banco and bc_cuenta = @i_cuenta
	*/
/*	if @@rowcount = 0
	begin
		select @w_fecha_conc = '01/01/1900'	
	end
	print 'fecha de inicio %1!', @w_fecha_conc */

	if @i_modo = 0
	begin
/*	   select convert(char(10),de_fecha_tran,@i_formato_fecha),
		substring(de_referencia,1,10),de_detalle,
		de_debcred,de_valor,de_operacion,de_refinterna, de_cuenta	
	   from cob_conta_tercero..ct_detest,	
                cob_conta_tercero..ct_estcta 
	   where de_empresa = @i_empresa and
		de_banco = @i_banco and
		isnull(de_relacionado,'N') = @i_relacionado and  
		de_cuenta = @i_cuenta and
--		de_fecha_tran >= @w_fecha_conc and
                es_empresa = de_empresa and
                es_banco = de_banco and
                es_fecha = de_fecha and
                es_cuenta = de_cuenta and
                es_definitivo = 'S'   and
                de_fecha_tran <= @i_fecha  
	   order by de_fecha_tran,de_detalle
*/
        if @i_ordenar = 'F'
            select @w_cadena_order  = ' order by de_fecha_tran,de_detalle'
        if @i_ordenar = 'V'
            select @w_cadena_order  = ' order by de_valor, de_detalle'
            
       select @w_cadena_select = 'select convert(char(10),de_fecha_tran,'+ cast(@i_formato_fecha as varchar) + '),'
       select @w_cadena_select = @w_cadena_select + ' substring(de_referencia,1,10),de_detalle,de_debcred,de_valor,de_operacion,de_refinterna, de_cuenta '
       select @w_cadena_from = 'from cob_conta_tercero..ct_detest, cob_conta_tercero..ct_estcta '
       select @w_cadena_where = 'where de_empresa = ' + cast(@i_empresa as varchar) + ' and de_banco = ' + ''''+ cast(@i_banco as varchar) + '''' + ' and isnull(de_relacionado,' + ''''+'N'+''''+') = ' + '''' + cast(@i_relacionado as varchar) + ''''
       select @w_cadena_where = @w_cadena_where + ' and  de_cuenta = ' + '''' + cast(@i_cuenta as varchar) + '''' + ' and '
       select @w_cadena_where2 = 'es_empresa = de_empresa and es_banco = de_banco and es_fecha = de_fecha and es_cuenta = de_cuenta and '
       select @w_cadena_where2 = @w_cadena_where2 + ' es_definitivo = '+ '''' + 'S' +'''' +'  and de_fecha_tran <= ' + ''''+ cast(@i_fecha as varchar)+ ''''
       
       exec (@w_cadena_select+ @w_cadena_from+ @w_cadena_where+ @w_cadena_where2+ @w_cadena_order)
       
	   if @@rowcount = 0
           begin
    	 /* No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
                return 1 
           end
	end
	else begin
/*
	   select convert(char(10),de_fecha_tran,@i_formato_fecha),
		substring(de_referencia,1,10),de_detalle,
		de_debcred,de_valor,de_operacion, de_refinterna,de_cuenta	
	   from cob_conta_tercero..ct_detest, 	
                cob_conta_tercero..ct_estcta   
	   where de_empresa = @i_empresa and
		de_banco = @i_banco and
		isnull(de_relacionado,'N') = @i_relacionado and	
		de_cuenta = @i_cuenta and	
	      ((de_fecha_tran = @i_fecha1 and de_detalle > @i_detalle) or
		de_fecha_tran > @i_fecha1) and
                es_empresa = de_empresa and
                es_banco = de_banco and
                es_fecha = de_fecha and
                es_cuenta = de_cuenta and
                es_definitivo = 'S'  and
                de_fecha_tran <= @i_fecha 
	   order by de_fecha_tran,de_detalle
*/
        if @i_ordenar = 'F'
            select @w_cadena_order  = ' order by de_fecha_tran,de_detalle'
        if @i_ordenar = 'V'
            select @w_cadena_order  = ' order by de_valor, de_detalle'
            
       select @w_cadena_select = 'select convert(char(10),de_fecha_tran,'+ cast(@i_formato_fecha as varchar) + '),'
       select @w_cadena_select = @w_cadena_select + ' substring(de_referencia,1,10),de_detalle,de_debcred,de_valor,de_operacion,de_refinterna, de_cuenta '
       select @w_cadena_from = 'from cob_conta_tercero..ct_detest, cob_conta_tercero..ct_estcta '
       select @w_cadena_where = 'where de_empresa = ' + cast(@i_empresa as varchar) + ' and de_banco = ' + ''''+ cast(@i_banco as varchar) + '''' + ' and isnull(de_relacionado,' + ''''+'N'+''''+') = ' + '''' + cast(@i_relacionado as varchar) + ''''
       select @w_cadena_where = @w_cadena_where + ' and  de_cuenta = ' + '''' + cast(@i_cuenta as varchar) + '''' + ' and'
       select @w_cadena_where2 = ' ((de_fecha_tran = ' + '''' + cast(@i_fecha1 as varchar) + '''' + ' and de_detalle > ' + cast(@i_detalle as varchar) + ') or de_fecha_tran > ' + ''''+ cast(@i_fecha1 as varchar) + '''' + ') and es_empresa = de_empresa and '
       select @w_cadena_where3 = ' es_banco = de_banco and es_fecha = de_fecha and es_cuenta = de_cuenta and es_definitivo = '+ ''''+ 'S' + ''''+ ' and de_fecha_tran <= '+ ''''+ cast(@i_fecha as varchar)+''''
       
       exec(@w_cadena_select+@w_cadena_from+@w_cadena_where+@w_cadena_where2+@w_cadena_where3+@w_cadena_order)
       
	   if @@rowcount = 0
           begin
    	 /* No existen mas registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
	   end

	end
return 0
end

go
