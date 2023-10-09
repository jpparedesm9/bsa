/************************************************************************/
/*	Archivo: 		gmf.sp                                  */
/*	Stored procedure: 	sp_gmf                                  */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTABILIDAD                            */
/*	Disenado por:           Wladimir Ruiz G.                        */
/*	Fecha de escritura:     05/Abril/2004                           */
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/* Permite obtener Gravamen movimiento financiero                       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	05-Abr-04	W. Ruiz 	Tuning				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_gmf')
	drop proc sp_gmf
go

create proc sp_gmf (	
        @s_ssn                  int             = NULL,
        @s_user                 login           = NULL,
        @s_term                 varchar(30)     = NULL,
        @s_date                 datetime        = NULL,
        @s_sesn                 int             = NULL,
        @s_ssn_branch           int             = null, 
        @s_srv                  varchar(30)     = NULL,
        @s_lsrv                 varchar(30)     = NULL,
        @s_ofi                  smallint        = NULL,
        @s_rol                  smallint        = NULL,
        @t_debug                char(1)         = 'N',
        @t_file                 varchar(10)     = NULL,
        @t_from                 varchar(32)     = NULL,
        @t_trn                  smallint        = NULL,
	@i_empresa		tinyint 	= null,
	@i_cuenta               cuenta          = null,	
	@i_fecha_ini		datetime	= null,
	@i_fecha_fin		datetime	= null,
	@i_oficina              int             = null,
	@i_operacion            char(1)         = 'E' ,
	@i_producto             int             = null,
	@i_beneficiario         int             = null
	
)
as

/*DECLARACION DE VARIABLES TEMPORALES*/
declare @w_sp_name              varchar(32),
        @w_estado		char(1),         
        @w_corte		int,	
	@w_periodo		int,		
	@w_corte_ant		int,	
	@w_periodo_ant		int,		
	@w_fecha_tmp		datetime,		
	@w_debito_tmp           money,
	@w_debito_ini           money,
	@w_debito_fin           money,
	@w_valor                money,
	@w_saldo                money,
	@w_debito               money,
	@w_credito              money,
	@w_contador             int 


/*INICIALIZACION DE VARIABLES TEMPORALES*/
select @w_sp_name  = 'sp_gmf',
       @w_contador = 1,
       @w_debito_ini = 0,
       @w_debito_fin = 0


/**  VERIFICAR CODIGO DE TRANSACCION DE ACTIVACION  **/
if   (@t_trn != 6949) and (@i_operacion = 'E' or @i_operacion = 'F' )
begin
   exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                         @t_from  = @w_sp_name, @i_num = 607123
   return 1
end




if @i_operacion = 'E'
begin

WHILE (@w_contador <= 2)
begin

   if @w_contador = 1   
      select @w_fecha_tmp = @i_fecha_ini 
   else
      select @w_fecha_tmp = @i_fecha_fin  
           
   /* CALCULA EL PERIODO Y CORTE DE UNA FECHA */
   select   @w_corte   = co_corte,
            @w_periodo = co_periodo,
	    @w_estado  = co_estado
   from  cob_conta..cb_corte
   where co_empresa = @i_empresa
   and   co_periodo >= 0
   and   co_corte >= 0
   and   co_fecha_ini >= @w_fecha_tmp
   and   co_fecha_fin <= @w_fecha_tmp
   if @@rowcount = 0
   begin
      print "ERROR (1): Corte de la fecha de reporte no encontrado"
      return 1
   end


   if @w_estado <> 'A'
   begin

      select @w_debito_tmp = isnull(sum(hi_debito),0)
      from cob_conta_his..cb_hist_saldo
      where hi_empresa = @i_empresa
      and   hi_periodo = @w_periodo
      and   hi_corte   = @w_corte
      and   hi_cuenta  = @i_cuenta

   end
   else --@w_estado = 'V', 'C'
   begin

      select @w_debito_tmp = isnull(sum(sa_debito),0)
      from cob_conta..cb_saldo
      where sa_empresa = @i_empresa
      and   sa_periodo = @w_periodo
      and   sa_corte   = @w_corte
      and   sa_cuenta  = @i_cuenta

   end 

   if @w_contador = 1   
      select @w_debito_ini = @w_debito_tmp 
   else
      select @w_debito_fin = @w_debito_tmp

   select @w_contador = @w_contador +1

end --WHILE

select @w_valor= @w_debito_fin - @w_debito_ini
select @w_valor

end -- @i_operacion = 'E'




if @i_operacion = 'F'
begin      

      ---------------------------------------
      --CALCULA DEL SALDO INICIAL DEL PERIODO
      ---------------------------------------
      select   @w_corte   = co_corte,
            @w_periodo = co_periodo,
	    @w_estado  = co_estado
      from  cob_conta..cb_corte
      where co_empresa = @i_empresa
      and   co_periodo >= 0
      and   co_corte >= 0
      and   co_fecha_ini >= @i_fecha_ini
      and   co_fecha_fin <= @i_fecha_ini
      if @@rowcount = 0
      begin
         print "ERROR (1): Corte de la fecha de reporte no encontrado"
         return 1
      end

      if @w_corte = 1 
      begin
   		select @w_periodo_ant = pe_periodo
     		from cob_conta..cb_periodo
    		where pe_empresa = @i_empresa
    		and   pe_periodo = @w_periodo - 1
   		if @@rowcount = 0
   		begin
      			select @w_saldo = 1      			
   		end
      		else 
      		begin
      			select @w_saldo = 0      		
      			select @w_corte_ant = max(co_corte)
      			from cob_conta..cb_corte
      			where co_empresa = @i_empresa
			and   co_periodo = @w_periodo_ant
      		end                  
      end
      else
      begin
   		select @w_corte_ant = @w_corte - 1
   		select @w_periodo_ant = @w_periodo 
	   	select @w_saldo = 0	   	
      end

      select @w_saldo = isnull(sum(hi_saldo),0)
      from cob_conta_his..cb_hist_saldo
      where hi_empresa = @i_empresa
      and   hi_periodo = @w_periodo_ant
      and   hi_corte   = @w_corte_ant
      and   hi_cuenta  = @i_cuenta      

      ---------------------------------------------
      --CALCULA DEL DEBITOS Y CREDITOS DEL PERIODO
      --------------------------------------------  
      select 
	@w_debito  = isnull(sum(as_debito),0),
	@w_credito = isnull(sum(as_credito),0)       
      from cob_conta..cb_asiento, cob_conta..cb_comprobante
      where as_empresa = @i_empresa
      and as_fecha_tran between @i_fecha_ini and @i_fecha_fin
      and as_comprobante = co_comprobante
      and as_asiento >= 0
      and as_oficina_orig = co_oficina_orig
      and as_cuenta = @i_cuenta
      and as_oficina_dest in (select je_oficina from cb_jerarquia)				       
      and as_area_dest    in (select ja_area from cb_jerararea) 
      and as_mayorizado = 'S'
      and co_empresa = as_empresa         
      and co_fecha_tran = as_fecha_tran    
                  
      -----------------------------------------
      --ENVIO A LA HOJA EXCEL DATOS PARA 4X1000      
      -----------------------------------------
      select @w_saldo,
     	     @w_debito,
	     @w_credito                                                       
  
   -----------------------------------------------
   --RUTINA UTILIZANDO TABLA TEMPORAL PARA  4X1000
   -----------------------------------------------
   /*
   	select                       
     		isnull(sum (@w_saldo),0),             
     		isnull(sum (gm_debito) ,0),
     		isnull(sum (gm_credito),0)       
   	from cb_gravamen_mf
   	where gm_cuenta = @i_cuenta
   	and   gm_fecha_ini = @i_fecha_ini
   	and   gm_fecha_fin = @i_fecha_fin 
   	if @@rowcount = 0
   	begin
       		exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                	              @t_from=@w_sp_name, @i_num = 601159
       		return  1
   	end
   */   
   
end 

return 0

go


