/************************************************************************/
/*	Archivo: 		consu.sp			        */
/*	Stored procedure: 	sp_consu				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     					*/
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
/*	Este programa agrupa los comprobantes auxiliares y los pasa	*/
/*      a definitivos.                                                  */
/*	                                        			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

set nocount on
go

--------------------------------------------
-- REALIZAMOS INTO #_TMP PARA COMPILAR SP --
--------------------------------------------
select 	sc_producto,		sc_fecha_tran,	sc_comprobante,
	sc_oficina_orig,	sc_area_orig,
	sc_perfil,		sa_oficina_dest,
	sa_area_dest,		sa_cuenta,
	sa_tipo_doc,		sa_debito,
	sa_credito,		sa_debito_me,
	sa_credito_me,		sa_concepto, 
	sc_descripcion
into   	#_tmp
from   	cob_interfase..ct_scomprobante,
       	cob_interfase..ct_sasiento 
where  1=2


----------------------------------------------
-- ELIMINAMOS Y CREAMOS SP_CONSU Y DECLARE  --
----------------------------------------------
if exists (select * from sysobjects where name = 'sp_consu')
	drop proc sp_consu
go

create proc sp_consu (
	@i_empresa 	  tinyint	= null,
	@i_digitador	  descripcion	= null,
	@i_producto	  int		= null
)
as

declare 
	@w_return         	int,
	@w_oficina_orig   	smallint,
	@w_area_orig      	smallint,
	@w_oficina_dest   	smallint,
	@w_area_dest      	smallint,
	@w_perfil	  	varchar(20),
	@w_oficina_orig_tmp  	smallint,
	@w_area_orig_tmp  	smallint,
	@w_perfil_tmp	  	varchar(20),
	@w_cuenta		cuenta_contable,
	@w_tipo_doc		char(1),
	@w_debito		money,
	@w_debito_me		money,
	@w_credito		money,
	@w_credito_me		money,
	@w_tot_debito		money,
	@w_tot_debito_me	money,
	@w_tot_credito		money,
	@w_tot_credito_me	money,
	@w_fecha_hoy		datetime,
	@w_descripcion		descripcion,
	@w_concepto             descripcion,
	@w_comp_temp		int,
	@w_comp_def		int,
	@w_comprobante          int,
	@w_comprobante_tmp      int,
	@w_cotizacion		money,
	@w_detalle		int,
	@w_detalles		int,
	@w_paso			tinyint,
	@w_error_comp		tinyint,
	@w_desc_error		descripcion,
	@w_producto		tinyint,
   	@w_producto_tmp		tinyint,
   	@w_producto_cont	tinyint,
	@w_fecha_tran		datetime,
   	@w_fecha_tran_tmp	datetime,
   	@w_comp_aux		int,
   	@w_comp_tmp		int,
   	@w_msg_error		char(100),
   	@w_sa_ente              int,
	@w_sa_ente_tipo         char(2),
	@w_sa_ente_id           char(13),
	@w_sa_asiento           int,
	@w_sa_cuenta            cuenta_contable

select @w_fecha_hoy = getdate(),
       @w_paso = 0


select @w_producto_cont = @i_producto
  /******************************************************************/
  /******************************************************************/
  /*	 MANEJO DE TODOS LOS PRODUCTOS Y SIDAC NO DIFERIDOS  	    */
  /******************************************************************/
  /******************************************************************/

  ----------------------------------------------------------
  --  SI EL PRODUCTO ES 6 INCLUIMOS EL CAMPO SA_CONCEPTO  --
  ----------------------------------------------------------
  if @w_producto_cont = 6
  begin
  
     declare resumen cursor for
     select 	sc_fecha_tran, 			sc_producto,		 	sc_oficina_orig,
     		sc_area_orig,			sc_perfil,		 	sa_oficina_dest,
     		sa_area_dest,			sa_cuenta,			sa_tipo_doc,
		isnull(sa_debito,0),	        isnull(sa_credito,0),	        isnull(sa_debito_me,0),
		isnull(sa_credito_me,0),	sa_concepto,                    sc_descripcion,
		sc_comprobante
     from       #_tmp
     where      sc_producto = @w_producto_cont
     order by sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil, sc_comprobante
     FOR READ ONLY 
--print '1'
     open resumen

     fetch resumen into	
		@w_fecha_tran,		@w_producto,	        @w_oficina_orig,	
		@w_area_orig,		@w_perfil,		@w_oficina_dest,	
		@w_area_dest,		@w_cuenta,		@w_tipo_doc,
		@w_debito,		@w_credito,		@w_debito_me,	
		@w_credito_me,          @w_concepto,            @w_descripcion,
		@w_comprobante
		
  end -- FIN DE if @w_producto_cont = 6
  -------------------------------------------------------------------
  --  SI EL PRODUCTO ES 48 NO INCLUIMOS COMPROBANTES CON DIFERIDOS --
  -------------------------------------------------------------------
  else if @w_producto_cont = 48
  begin

     --ALMACENAMOS LOS COMPROBANTES Y LA FECHA DE DIFERIDOS
     select distinct sc_comprobante, sc_fecha_tran
     into #tmp_comp
     from   #_tmp,
            cob_conta..cb_cuenta_proceso
     where  cp_empresa     = 1
     and    cp_proceso     = 6980
     and    cp_cuenta      = sa_cuenta
     and    sc_producto    = @w_producto_cont
     
     --CREAMOS UNA NUEVA TABLA PARA COLOCAR UN CAMPO FLAG
     select *,'flag'=0,'sa_fecha_fin_difer'='Apr 21 2005 12:00AM','sa_plazo_difer'=0,sa_desc_difer='                    ',
              'sa_empresa'=0,'sa_asiento'=0
     into #tmp_flag
     from #_tmp

     --ACTUALIZAMOS EL CAMPO FLAG EN 1 PARA LOS COMPROBANTES QUE SON DE DIFERIDOS
     UPDATE #tmp_flag
     set flag = 1
     FROM #tmp_flag t, #tmp_comp c
     where t.sc_fecha_tran = c.sc_fecha_tran
     and t.sc_comprobante  = c.sc_comprobante
     and t.sc_perfil       = 'CP.CREADIF'
     
     --ARMAMOS EL CURSOR DE LA TABLA #TMP_FLAG PARA TODOS LOS QUE TIENEN FLAG=0
     declare resumen cursor for
     select 	sc_fecha_tran, 			sc_producto,			sc_oficina_orig,
     		sc_area_orig,			sc_perfil,			sa_oficina_dest,
     		sa_area_dest,			sa_cuenta,			sa_tipo_doc,
		sum(isnull(sa_debito,0)),	sum(isnull(sa_credito,0)),	sum(isnull(sa_debito_me,0)),
		sum(isnull(sa_credito_me,0))
     from	#tmp_flag
     where      flag = 0
     group by 	sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil,
		sa_oficina_dest, sa_area_dest, sa_cuenta, sa_tipo_doc
     order by sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil
     FOR READ ONLY 

     open resumen

     fetch resumen into	
		@w_fecha_tran,		@w_producto,	        @w_oficina_orig,	
		@w_area_orig,		@w_perfil,		@w_oficina_dest,	
		@w_area_dest,		@w_cuenta,		@w_tipo_doc,
		@w_debito,		@w_credito,		@w_debito_me,	
		@w_credito_me,          @w_concepto,            @w_descripcion,
		@w_comprobante
--print '2'		
  end -- FIN DE ELSE if @w_producto_cont = 48
  ---------------------------------------------------------------
  --  SI EL PRODUCTO ES !=6 NO INCLUIMOS EL CAMPO SA_CONCEPTO  --
  ---------------------------------------------------------------
  else
  begin

     declare resumen cursor for
     select 	sc_fecha_tran, 			sc_producto,			sc_oficina_orig,
     		sc_area_orig,			sc_perfil,			sa_oficina_dest,
     		sa_area_dest,			sa_cuenta,			sa_tipo_doc,
		sum(isnull(sa_debito,0)),	sum(isnull(sa_credito,0)),	sum(isnull(sa_debito_me,0)),
		sum(isnull(sa_credito_me,0))
     from	#_tmp
     where      sc_producto = @w_producto_cont
     group by 	sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil,
		sa_oficina_dest, sa_area_dest, sa_cuenta, sa_tipo_doc
     order by sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil
     FOR READ ONLY 

     open resumen

     fetch resumen into	
		@w_fecha_tran,		@w_producto,	        @w_oficina_orig,	
		@w_area_orig,		@w_perfil,		@w_oficina_dest,	
		@w_area_dest,		@w_cuenta,		@w_tipo_doc,
		@w_debito,		@w_credito,		@w_debito_me,	
		@w_credito_me
--print '3'		
  end  -- FIN DE ELSE if @w_producto_cont = 6

  /******************************************************************/
  /******************************************************************/
  /*	CURSOR QUE MANEJA LOS ASIENTOS SEGUN EL PRODUCTO    	    */
  /******************************************************************/
  /******************************************************************/
  while (@@fetch_status = 0)
  BEGIN

     --print '++++++++++++++++SECCION DE COMPROBANTES NORMALES+++++++++++++++++++'
     ----------------------------------------------------------------
     --  VALIDAMOS SI LAS TMP TIENEN INFORMACION Y SI SON IGUALES  --
     --  SON ASIENTOS DEL MISMO COMPROBANTE DE LO CONTRARIO ES UN  --
     --  COMPROBANTE NUEVO					   --
     ----------------------------------------------------------------
     
     
     IF  @w_fecha_tran_tmp	 = @w_fecha_tran
	 and @w_producto_tmp	 = @w_producto
	 and @w_oficina_orig_tmp = @w_oficina_orig 
	 and @w_area_orig_tmp    = @w_area_orig
	 and @w_perfil_tmp       = @w_perfil 
     BEGIN
/*print '%1!',@w_comprobante_tmp
print '%1!',@w_comprobante
print '%1!',@w_producto_tmp*/

/*******valida producto 6*************/        
        IF @w_producto_tmp = 6 
           and  @w_comprobante_tmp <> @w_comprobante
        BEGIN
           goto LABEL_SEIS
        END
/******************************************/      

        -------------------------------------------------------------
        --  SI NO HUBO ERROR Y EL ASIENTO ES DE NATURALEZA DEBITO  --
        -------------------------------------------------------------
        if @w_error_comp = 0 and @w_debito <> 0
	begin
	   
	   select @w_cotizacion = 0,
		  @w_detalle    = @w_detalle + 1

	   if @w_debito_me <> 0
	      select @w_cotizacion = @w_debito / @w_debito_me
--print 'asiento 1'
	   execute @w_return = sp_asientot_consu
		@t_trn          = 6341,
		@i_operacion    = 'I',
		@i_modo         = 0,
		@i_empresa      = @i_empresa,
		@i_comprobante  = @w_comp_temp,
		@i_fecha_tran   = @w_fecha_tran,
		@i_asiento      = @w_detalle,
		@i_cuenta       = @w_cuenta,
		@i_oficina_dest = @w_oficina_dest,
		@i_oficina_orig = @w_oficina_orig,
		@i_area_dest    = @w_area_dest,
		@i_tipo_doc     = @w_tipo_doc,
		@i_tipo_tran    = 'A',
		@i_credito      = 0,
		@i_debito       = @w_debito,
		@i_credito_me   = 0,
		@i_debito_me    = @w_debito_me,
		@i_cotizacion   = @w_cotizacion,
		@i_concepto     = @w_concepto,
		@i_mayorizado   = 'N',
		@i_autorizado   = 'S',
		@i_consolidado  = 'N'

	   if @w_return <> 0
	   begin	
		
	      insert into cob_conta..cb_errores_consu
	     		(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
	      values
		  	(@i_empresa,@w_producto,@w_fecha_tran,
			 @w_oficina_orig,@w_area_orig,@w_perfil,
			 'Error en Insersion de Asiento Temporal')
	      
	      delete cob_conta..cb_tasiento
	      where	ta_fecha_tran = @w_fecha_tran_tmp 
	      and	ta_comprobante = @w_comp_temp 
	      and	ta_empresa = @i_empresa 
	      and       ta_oficina_orig = @w_oficina_orig_tmp

	      delete cob_conta..cb_tcomprobante
	      where 	ct_fecha_tran = @w_fecha_tran_tmp 
	      and       ct_comprobante = @w_comp_temp 
	      and	ct_empresa = @i_empresa 
	      and       ct_oficina_orig = @w_oficina_orig_tmp

	      select @w_error_comp = 1
	   
	   end -- FIN DE if @w_return <> 0
	   
        end -- FIN DE if @w_error_comp = 0 and @w_debito <> 0

        --------------------------------------------------------------
        --  SI NO HUBO ERROR Y EL ASIENTO ES DE NATURALEZA CREDITO  --
        --------------------------------------------------------------
        if @w_error_comp = 0 and @w_credito <> 0
        begin
		
	   select @w_cotizacion = 0,
	   	  @w_detalle = @w_detalle + 1

	   if @w_credito_me <> 0
	      select @w_cotizacion = @w_credito / @w_credito_me

	   execute @w_return = sp_asientot_consu
	   	@t_trn          = 6341,
		@i_operacion    = 'I',
		@i_modo         = 0,
		@i_empresa      = @i_empresa,
		@i_comprobante  = @w_comp_temp,
		@i_fecha_tran   = @w_fecha_tran,
		@i_asiento      = @w_detalle,
		@i_cuenta       = @w_cuenta,
		@i_oficina_dest = @w_oficina_dest,
		@i_oficina_orig = @w_oficina_orig,
		@i_area_dest    = @w_area_dest,
		@i_tipo_doc     = @w_tipo_doc,
		@i_tipo_tran    = 'A',
		@i_credito      = @w_credito,
		@i_debito       = 0,
		@i_credito_me   = @w_credito_me,
		@i_debito_me    = 0,
		@i_cotizacion   = @w_cotizacion,
		@i_concepto     = @w_concepto,
		@i_mayorizado   = 'N',
		@i_autorizado   = 'S',
		@i_consolidado  = 'N'
--print 'asiento 2'			
	   if @w_return <> 0
	   begin	
					
	      insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
	      values
			(@i_empresa,@w_producto,@w_fecha_tran,
			 @w_oficina_orig,@w_area_orig,@w_perfil,
			 'Error en Insersion de Asiento Temporal')
	
	      delete cob_conta..cb_tasiento
	      where  	ta_fecha_tran = @w_fecha_tran_tmp and
			ta_comprobante = @w_comp_temp and
			ta_empresa = @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

	      delete cob_conta..cb_tcomprobante
	      where 	ct_fecha_tran = @w_fecha_tran_tmp and
			ct_comprobante = @w_comp_temp and
			ct_empresa = @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
                                                        
	      select @w_error_comp = 1
	   end				
	end   -- FIN DE if @w_error_comp = 0 and @w_credito <> 0
	
	
	----------------------------------------------------------------
        --  SI NO HUBO ERROR Y EL ASIENTO NO ES DE CREDITO NI DEBITO  --
        ----------------------------------------------------------------
        if @w_error_comp = 0 and @w_credito = 0 and @w_debito = 0
        begin
        
	   select @w_cotizacion = 0,
	   	  @w_detalle = @w_detalle + 1

	   if @w_credito_me <> 0
	      select @w_cotizacion = @w_credito / @w_credito_me

	   execute @w_return = sp_asientot_consu
	   	@t_trn          = 6341,
		@i_operacion    = 'I',
		@i_modo         = 0,
		@i_empresa      = @i_empresa,
		@i_comprobante  = @w_comp_temp,
		@i_fecha_tran   = @w_fecha_tran,
		@i_asiento      = @w_detalle,
		@i_cuenta       = @w_cuenta,
		@i_oficina_dest = @w_oficina_dest,
		@i_oficina_orig = @w_oficina_orig,
		@i_area_dest    = @w_area_dest,
		@i_tipo_doc     = @w_tipo_doc,
		@i_tipo_tran    = 'A',
		@i_credito      = @w_credito,
		@i_debito       = 0,
		@i_credito_me   = @w_credito_me,
		@i_debito_me    = 0,
		@i_cotizacion   = @w_cotizacion,
		@i_concepto     = @w_concepto,
		@i_mayorizado   = 'N',
		@i_autorizado   = 'S',
		@i_consolidado  = 'N'
--print 'asiento 3'			
	   if @w_return <> 0
	   begin	
	   
	      insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
	      values
			(@i_empresa,@w_producto,@w_fecha_tran,
			 @w_oficina_orig,@w_area_orig,@w_perfil,
			 'Error en Insersion de Asiento Temporal')
	
	      delete cob_conta..cb_tasiento
	      where  	ta_fecha_tran 	= @w_fecha_tran_tmp and
			ta_comprobante 	= @w_comp_temp and
			ta_empresa 	= @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

	      delete cob_conta..cb_tcomprobante
	      where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
			ct_comprobante 	= @w_comp_temp and
			ct_empresa 	= @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
                                                        
	      select @w_error_comp = 1
	      
	   end				
        end   -- FIN DE if @w_error_comp = 0 and @w_credito = 0 and @w_debito = 0
        
        
     
     END  -- FIN DE IF  @w_fecha_tran_tmp	 = @w_fecha_tran EL COMPROBANTE ES NUEVO
     ----------------------------------------------------------
     --  SI ES EL 1ER COMPROBANTE O EL COMPROBANTE ES NUEVO  --
     ----------------------------------------------------------
     ELSE
     BEGIN
LABEL_SEIS:     
	----------------------------------------------------------------
        --  SI YA SE CREO LA CABECERA DEL COMPROBANTE Y NO HAY ERROR  --
        --  SE MIGRA Y SE ACTUALIZA EL COMPROBANTE		      --
        ----------------------------------------------------------------
        if @w_paso = 1 and @w_error_comp = 0
	begin

	   execute @w_return = sp_interna_consu
		@t_trn          = 6727,
		@i_operacion    = 'I',
		@i_empresa      = @i_empresa,
		@i_comprobante  = @w_comp_temp,
		@i_fecha_tran   = @w_fecha_tran_tmp,
		@i_oficina_orig = @w_oficina_orig_tmp,
		@i_detalles     = @w_detalle,
		@i_batch        = 1,
		@o_desc_error   = @w_desc_error out
--print 'comprobante 1'
	   if @w_return <> 0 /*1*/
	   begin	
	
	      insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
	      values
			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
			 @w_desc_error)
					
	      select @w_error_comp = 1
					
	      delete cob_conta..cb_tinterna 
	      where	ti_empresa 	= @i_empresa and
			ti_fecha_tran 	= @w_fecha_tran_tmp and
			ti_comprobante 	= @w_comp_temp and
			ti_asiento 	>= 0 and
			ti_oficina_dest >= 0 and
			ti_area_dest 	>= 0 and
			ti_oficina_orig = @w_oficina_orig_tmp
					
	      delete cob_conta..cb_tasiento
	      where  	ta_fecha_tran 	= @w_fecha_tran_tmp and
			ta_comprobante 	= @w_comp_temp and
			ta_empresa 	= @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

	      delete cob_conta..cb_tcomprobante
	      where 	ct_fecha_tran = @w_fecha_tran_tmp and
			ct_comprobante = @w_comp_temp and
			ct_empresa = @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
			
	   end	-- FIN DE if @w_return <> 0 /*1*/
 	   else
 	   begin
					
	      select @w_detalles = count(1)
	      from   cob_conta..cb_tasiento
	      where  ta_empresa = @i_empresa
		     and    ta_fecha_tran   = @w_fecha_tran_tmp
		     and    ta_comprobante  = @w_comp_temp
		     and    ta_oficina_orig = @w_oficina_orig_tmp

	      execute @w_return = sp_posicion_consu
			@i_operacion    = 'I',
			@i_empresa      = @i_empresa,
			@i_comprobante  = @w_comp_temp,
			@i_fecha_tran   = @w_fecha_tran_tmp,
			@i_oficina_orig = @w_oficina_orig_tmp,
			@i_detalles     = @w_detalles,
			@o_desc_error   = @w_desc_error out

	      if @w_return <> 0 /*2*/
	      begin	
		
		 insert into cob_conta..cb_errores_consu
				(ec_empresa,ec_producto,ec_fecha,
				 ec_oficina_orig,ec_area_orig,ec_perfil,
				 ec_descripcion)
		 values
				(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
				 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
				 @w_desc_error)

		 delete  cob_conta..cb_posicion
     		 where 	po_empresa    = @i_empresa
       			and po_fecha_tran   = @w_fecha_tran_tmp
       			and po_comprobante  = @w_comp_temp
       			and po_oficina_orig = @w_oficina_orig_tmp 
       							
       		 delete cob_conta..cb_tasiento
		 where 	ta_fecha_tran 	= @w_fecha_tran_tmp and
			ta_comprobante 	= @w_comp_temp and
			ta_empresa 	= @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

		 delete cob_conta..cb_tcomprobante
		 where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
			ct_comprobante 	= @w_comp_temp and
			ct_empresa 	= @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
			
		 select @w_error_comp = 1
					
	      end -- FIN DE if @w_return <> 0 /*2*/
	      else
	      begin
		
		 select @w_detalles = count(1),
			@w_tot_debito 	  = sum(ta_debito),
			@w_tot_credito    = sum(ta_credito),
			@w_tot_debito_me  = sum(ta_debito_me),
			@w_tot_credito_me = sum(ta_credito_me)
		 from   cob_conta..cb_tasiento
		 where  ta_empresa = @i_empresa
			and    ta_fecha_tran   = @w_fecha_tran_tmp
			and    ta_comprobante  = @w_comp_temp
			and    ta_oficina_orig = @w_oficina_orig_tmp

		 update cob_conta..cb_tcomprobante
		 set 	ct_detalles = @w_detalles,
			ct_tot_debito = @w_tot_debito,
			ct_tot_credito = @w_tot_credito,
			ct_tot_debito_me = @w_tot_debito_me,
			ct_tot_credito_me = @w_tot_credito_me
		 where  ct_empresa = @i_empresa
		 	and	 ct_fecha_tran = @w_fecha_tran_tmp
			and	 ct_comprobante = @w_comp_temp
			and    ct_oficina_orig = @w_oficina_orig_tmp

    		 BEGIN TRAN

		    execute @w_return = sp_compmig_consu
			@t_trn          	= 6342,
			@i_operacion    	= 'I',
			@i_empresa      	= @i_empresa,
			@i_producto     	= @w_producto_tmp,
			@i_detalles     	= @w_detalles,
			@i_comprobante  	= @w_comp_temp,
			@i_fecha_tran   	= @w_fecha_tran_tmp,
			@i_oficina_orig 	= @w_oficina_orig_tmp,
			@i_tot_debito   	= @w_tot_debito,
			@i_tot_credito  	= @w_tot_credito,
			@i_tot_debito_me 	= @w_tot_debito_me,
			@i_tot_credito_me 	= @w_tot_credito_me,
			@i_traslado     	= 'S',
			@o_comp_def     	= @w_comp_def out
--print 'compmig_consu inicial'
		    if @w_return <> 0 /*3*/
		    begin	
                    
                       ROLLBACK TRAN
		       insert into cob_conta..cb_errores_consu
				(ec_empresa,ec_producto,ec_fecha,
				 ec_oficina_orig,ec_area_orig,ec_perfil,
				 ec_descripcion)
		       values
				(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
				 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
				 'Error en Creacion de Comprobante Definitivo 1')

  		       delete cob_conta..cb_tasiento
		       where  	ta_fecha_tran 	= @w_fecha_tran_tmp and
				ta_comprobante 	= @w_comp_temp and
				ta_empresa 	= @i_empresa and
                                ta_oficina_orig = @w_oficina_orig_tmp

		       delete cob_conta..cb_tcomprobante
		       where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
				ct_comprobante 	= @w_comp_temp and
				ct_empresa 	= @i_empresa and
                                ct_oficina_orig = @w_oficina_orig_tmp

		       select @w_error_comp = 1
		    
		    end	-- FIN DE if @w_return <> 0 /*3*/
		    else
		    begin
			
		       update cob_interfase..ct_scomprobante
		       set sc_estado = 'P', sc_comp_definit = @w_comp_def
		       from cob_interfase..ct_scomprobante --(index i_ct_scomp_1)
		       where 	sc_empresa     		= @i_empresa
				and   sc_producto    	= @w_producto_tmp
				and   sc_fecha_tran  	= @w_fecha_tran_tmp
				and   sc_comprobante 	> 0
				and   sc_oficina_orig 	= @w_oficina_orig_tmp
				and   sc_area_orig    	= @w_area_orig_tmp
				and   sc_perfil	      	= @w_perfil_tmp
				and   sc_estado 	= 'B'						

		       if (@@error <> 0 or @@rowcount = 0) 
                       begin	
			
			  ROLLBACK TRAN
			  insert into cob_conta..cb_errores_consu
				(ec_empresa,ec_producto,ec_fecha,
				 ec_oficina_orig,ec_area_orig,ec_perfil,
				 ec_descripcion)
			  values
				(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
				 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
				 'Error en Actualizacion de auxiliar 1')

			  select @w_error_comp = 1
		       end 
		       else 
		       begin
			  COMMIT TRAN
		       end	
		    end -- FIN DE ELSE if @w_return <> 0 /*3*/
		 -- BEGIN TRAN
	      end -- FIN DE ELSE if @w_return <> 0 /*2*/
	   end -- FIN DE ELSE if @w_return <> 0 /*1*/
	end -- FIN DE if @w_paso = 1 and @w_error_comp = 0
			
        
        if @w_producto_cont <> 6
	begin
	   
	   select @w_descripcion = ''
	   select @w_descripcion = pe_descripcion
	   from   cob_conta..cb_perfil
	   where  pe_empresa = @i_empresa
		  and    pe_producto = @w_producto
		  and    pe_perfil = @w_perfil
	end
		       
	select @w_detalle = 1,
	@w_error_comp = 0

	----------------------------------------------------------------
        --  CREAMOS LA CABECERA DEL COMPROBANTE 		      --
        ----------------------------------------------------------------
	execute @w_return = sp_comprobt_consu
		@t_trn          = 6111,
		@t_debug        = 'N',
		@i_automatico   = 6084,
		@i_operacion    = 'I',
		@i_modo         = 0,
		@i_empresa      = @i_empresa,
		@i_oficina_orig = @w_oficina_orig,
		@i_area_orig    = @w_area_orig,
		@i_fecha_tran   = @w_fecha_tran,
		@i_fecha_mod    = @w_fecha_hoy,
		@i_fecha_dig    = @w_fecha_hoy,
		@i_digitador    = @i_digitador,
		@i_descripcion  = @w_descripcion,  
		@i_mayoriza     = 'N',
		@i_mayorizado   = 'N',
		@i_autorizado   = 'S', 
		@i_autorizante  = @i_digitador,
		@i_reversado    = 'N', 
		@i_detalles     = 0,
		@i_tot_debito   = 0,
		@i_tot_credito  = 0,
		@i_tot_debito_me  = 0,
		@i_tot_credito_me = 0,
		@o_tcomprobante  = @w_comp_temp out
--print 'comprobante 2'
        if @w_return <> 0 /*1*/
        begin	
	
	   insert into cob_conta..cb_errores_consu
		(ec_empresa,ec_producto,ec_fecha,
		 ec_oficina_orig,ec_area_orig,ec_perfil,
		 ec_descripcion)
	   values
		(@i_empresa,@w_producto,@w_fecha_tran,
		 @w_oficina_orig,@w_area_orig,@w_perfil,
		 'Error en Insersion de Comprobante Temporal')

	   select @w_error_comp = 1
        end			
        else
        begin
	
	   ----------------------------------------------------------------
           --  CREAMOS ASIENTO DE NATURALEZA DEBITO                      --
           ----------------------------------------------------------------
	   if @w_debito <> 0
	   begin
	
	      select @w_cotizacion = 0
	      if @w_debito_me <> 0
		 select @w_cotizacion = @w_debito / @w_debito_me

	      execute @w_return = sp_asientot_consu
			@t_trn          = 6341,
			@i_operacion    = 'I',
			@i_modo         = 0,
			@i_empresa      = @i_empresa,
			@i_comprobante  = @w_comp_temp,
			@i_fecha_tran   = @w_fecha_tran,
			@i_asiento      = @w_detalle,
			@i_cuenta       = @w_cuenta,
			@i_oficina_dest = @w_oficina_dest,
			@i_oficina_orig = @w_oficina_orig,
			@i_area_dest    = @w_area_dest,
			@i_tipo_doc     = @w_tipo_doc,
			@i_tipo_tran    = 'A',
			@i_credito      = 0,
			@i_debito       = @w_debito,
			@i_credito_me   = 0,
			@i_debito_me    = @w_debito_me,
			@i_cotizacion   = @w_cotizacion,
			@i_concepto     = @w_concepto,
			@i_mayorizado   = 'N',
			@i_autorizado   = 'S',
			@i_consolidado  = 'N'
--print 'asiento 12'
--print '%1!'+@w_debito
	      if @w_return <> 0
	      begin	
	
	         insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
		 values
			(@i_empresa,@w_producto,@w_fecha_tran,
			 @w_oficina_orig,@w_area_orig,@w_perfil,
			 'Error en Insersion de Asiento Temporal')
       							
       		 delete cob_conta..cb_tasiento
		 where  ta_fecha_tran 	= @w_fecha_tran_tmp and
			ta_comprobante 	= @w_comp_temp and
			ta_empresa 	= @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

		 delete cob_conta..cb_tcomprobante
		 where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
			ct_comprobante 	= @w_comp_temp and
			ct_empresa 	= @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
                                                        
		 select @w_error_comp = 1
	      end			
	   end -- FIN DE if @w_debito <> 0

	   ----------------------------------------------------------------
           --  CREAMOS ASIENTO DE NATURALEZA CREDITO                      --
           ----------------------------------------------------------------
	   if @w_credito <> 0
	   begin
	
	      select @w_cotizacion = 0
	      if @w_credito_me <> 0
		 select @w_cotizacion = @w_credito / @w_credito_me

	      if @w_debito <> 0
		 select @w_detalle = @w_detalle + 1

	      execute @w_return = sp_asientot_consu
			@t_trn          = 6341,
			@i_operacion    = 'I',
			@i_modo         = 0,
			@i_empresa      = @i_empresa,
			@i_comprobante  = @w_comp_temp,
			@i_fecha_tran   = @w_fecha_tran,
			@i_asiento      = @w_detalle,
			@i_cuenta       = @w_cuenta,
			@i_oficina_dest = @w_oficina_dest,
			@i_oficina_orig = @w_oficina_orig,
			@i_area_dest    = @w_area_dest,
			@i_tipo_doc     = @w_tipo_doc,
			@i_tipo_tran    = 'A',
			@i_credito      = @w_credito,
			@i_debito       = 0,
			@i_credito_me   = @w_credito_me,
			@i_debito_me    = 0,
			@i_cotizacion   = @w_cotizacion,
			@i_concepto     = @w_concepto,
			@i_mayorizado   = 'N',
			@i_autorizado   = 'S',
			@i_consolidado  = 'N'
--print 'asiento 22'
--print '%1!'+@w_credito
	      if @w_return <> 0
	      begin	
	
	         insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
		 values
			(@i_empresa,@w_producto,@w_fecha_tran,
			 @w_oficina_orig,@w_area_orig,@w_perfil,
			 'Error en Insersion de Asiento Temporal')
						
		 delete cob_conta..cb_tasiento
		 where  ta_fecha_tran 	= @w_fecha_tran_tmp and
			ta_comprobante 	= @w_comp_temp and
			ta_empresa 	= @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

		 delete cob_conta..cb_tcomprobante
		 where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
			ct_comprobante 	= @w_comp_temp and
			ct_empresa 	= @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
						
		 select @w_error_comp = 1
	      end			
	   end -- FIN DE if @w_credito <> 0

	   ----------------------------------------------------------------
           --  SI EL MOVIMIENTO NO ES CREDITO NI DEBITO                  --
           ----------------------------------------------------------------
	   if @w_credito = 0 and @w_debito = 0
	   begin
	
	      select @w_cotizacion = 0
	      if @w_credito_me <> 0
	         select @w_cotizacion = @w_credito / @w_credito_me

	      if @w_debito <> 0
	         select @w_detalle = @w_detalle + 1

	      execute @w_return = sp_asientot_consu
			@t_trn          = 6341,
			@i_operacion    = 'I',
			@i_modo         = 0,
			@i_empresa      = @i_empresa,
			@i_comprobante  = @w_comp_temp,
			@i_fecha_tran   = @w_fecha_tran,
			@i_asiento      = @w_detalle,
			@i_cuenta       = @w_cuenta,
			@i_oficina_dest = @w_oficina_dest,
			@i_oficina_orig = @w_oficina_orig,
			@i_area_dest    = @w_area_dest,
			@i_tipo_doc     = @w_tipo_doc,
			@i_tipo_tran    = 'A',
			@i_credito      = @w_credito,
			@i_debito       = 0,
			@i_credito_me   = @w_credito_me,
			@i_debito_me    = 0,
			@i_cotizacion   = @w_cotizacion,
			@i_concepto     = @w_concepto,
			@i_mayorizado   = 'N',
			@i_autorizado   = 'S',
			@i_consolidado  = 'N'
--print 'asiento 33'
	      if @w_return <> 0
	      begin	
	      
	         insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
		 values
			(@i_empresa,@w_producto,@w_fecha_tran,
			 @w_oficina_orig,@w_area_orig,@w_perfil,
			 'Error en Insersion de Asiento Temporal')
						
		 delete cob_conta..cb_tasiento
		 where  ta_fecha_tran = @w_fecha_tran_tmp and
			ta_comprobante = @w_comp_temp and
			ta_empresa = @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

		 delete cob_conta..cb_tcomprobante
		 where 	ct_fecha_tran = @w_fecha_tran_tmp and
			ct_comprobante = @w_comp_temp and
			ct_empresa = @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp
						
		 select @w_error_comp = 1
	      end			
	   end -- FIN DE if @w_credito = 0 and @w_debito = 0
        end -- FIN DE ELSE if @w_return <> 0 /*1*/
	
	select 	@w_fecha_tran_tmp	= @w_fecha_tran,
		@w_producto_tmp		= @w_producto,
		@w_oficina_orig_tmp	= @w_oficina_orig,
		@w_area_orig_tmp	= @w_area_orig,
		@w_perfil_tmp		= @w_perfil,
		@w_comprobante_tmp      = @w_comprobante
     
     END -- FIN DE ELSE IF  @w_fecha_tran_tmp	 = @w_fecha_tran EL COMPROBANTE ES NUEVO

     select @w_paso = 1
		
     if @w_producto_cont = 6
     begin
     
        fetch resumen into	
		@w_fecha_tran,		@w_producto,	        @w_oficina_orig,	
		@w_area_orig,		@w_perfil,		@w_oficina_dest,	
		@w_area_dest,		@w_cuenta,		@w_tipo_doc,
		@w_debito,		@w_credito,		@w_debito_me,	
		@w_credito_me,          @w_concepto,            @w_descripcion,
		@w_comprobante
     end 
     else
     begin
	
        fetch resumen into	
		@w_fecha_tran,		@w_producto,		@w_oficina_orig,	
		@w_area_orig,		@w_perfil,		@w_oficina_dest,	
		@w_area_dest,		@w_cuenta,		@w_tipo_doc,
		@w_debito,		@w_credito,		@w_debito_me,	
		@w_credito_me,          @w_concepto,            @w_descripcion,
		@w_comprobante
     end

  END -- FIN DE while (@@fetch_status = 0) CURSOR RESUMEN
	
  close resumen
  deallocate resumen

  if @w_paso = 1 and @w_error_comp = 0
  begin

     execute @w_return = sp_interna_consu
	@t_trn          = 6727,
	@i_operacion    = 'I',
	@i_empresa      = @i_empresa,
	@i_comprobante  = @w_comp_temp,
	@i_fecha_tran   = @w_fecha_tran_tmp,
	@i_oficina_orig = @w_oficina_orig_tmp,
	@i_detalles     = @w_detalle,
	@i_batch        = 1,
	@o_desc_error   = @w_desc_error out
				
     if @w_return <> 0 /*1*/
     begin	
	
        insert into cob_conta..cb_errores_consu
		(ec_empresa,ec_producto,ec_fecha,
		 ec_oficina_orig,ec_area_orig,ec_perfil,
		 ec_descripcion)
        values
		(@i_empresa,@w_producto_tmp, @w_fecha_tran_tmp,
		 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
		 @w_desc_error)
			
        delete cob_conta..cb_tinterna 
	where	ti_empresa 	= @i_empresa and
		ti_fecha_tran 	= @w_fecha_tran_tmp and
		ti_comprobante 	= @w_comp_temp and
		ti_asiento 	>= 0 and
		ti_oficina_dest >= 0 and
		ti_area_dest 	>= 0 and
		ti_oficina_orig = @w_oficina_orig_tmp
					
        delete cob_conta..cb_tasiento
	where  	ta_fecha_tran 	= @w_fecha_tran_tmp and
		ta_comprobante 	= @w_comp_temp and
		ta_empresa 	= @i_empresa and
                ta_oficina_orig = @w_oficina_orig_tmp
                                                        
        delete cob_conta..cb_tcomprobante
        where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
		ct_comprobante 	= @w_comp_temp and
		ct_empresa 	= @i_empresa and
                ct_oficina_orig = @w_oficina_orig_tmp

        select @w_error_comp = 1
     
     end -- FIN DE if @w_return <> 0 /*1*/
     else
     begin
     
        select  @w_detalles = count(1)
	from cob_conta..cb_tasiento
	where 	ta_empresa 		= @i_empresa
		and   ta_fecha_tran 	= @w_fecha_tran_tmp
		and   ta_comprobante 	= @w_comp_temp
		and   ta_oficina_orig 	= @w_oficina_orig_tmp
--print '%1!'+@w_detalles		

        execute @w_return = sp_posicion_consu
		@t_trn          = 6701,
		@i_operacion    = 'I',
		@i_empresa      = @i_empresa,
		@i_comprobante  = @w_comp_temp,
		@i_fecha_tran   = @w_fecha_tran_tmp,
		@i_oficina_orig = @w_oficina_orig_tmp,
		@i_detalles     = @w_detalles,
		@o_desc_error   = @w_desc_error out

        if @w_return <> 0 /*2*/
        begin	
	   
	   insert into cob_conta..cb_errores_consu
		(ec_empresa,ec_producto,ec_fecha,
		 ec_oficina_orig,ec_area_orig,ec_perfil,
		 ec_descripcion)
	   values
		(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
		 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
		 @w_desc_error)
				
	   delete  cob_conta..cb_posicion
     	   where 	po_empresa    = @i_empresa
       		 	and po_fecha_tran  = @w_fecha_tran_tmp
       		 	and po_comprobante = @w_comp_temp
       		 	and po_oficina_orig = @w_oficina_orig_tmp 
       							
       	   delete cob_conta..cb_tasiento
	   where 	ta_fecha_tran = @w_fecha_tran_tmp and
		 	ta_comprobante = @w_comp_temp and
		 	ta_empresa = @i_empresa and
                 	ta_oficina_orig = @w_oficina_orig_tmp
		
	   delete cob_conta..cb_tcomprobante
	   where 	ct_fecha_tran = @w_fecha_tran_tmp and
			ct_comprobante = @w_comp_temp and
			ct_empresa = @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp

	   select @w_error_comp = 1
			
        end -- FIN DE if @w_return <> 0 /*2*/
        else
        begin
	
	   select  @w_detalles = count(1),
		   @w_tot_debito = sum(ta_debito),
		   @w_tot_credito = sum(ta_credito),
		   @w_tot_debito_me = sum(ta_debito_me),
		   @w_tot_credito_me = sum(ta_credito_me)
	   from cob_conta..cb_tasiento
	   where ta_empresa = @i_empresa
		 and   ta_fecha_tran = @w_fecha_tran_tmp
		 and   ta_comprobante = @w_comp_temp
		 and   ta_oficina_orig = @w_oficina_orig_tmp

	   update cob_conta..cb_tcomprobante
	   set 	ct_detalles = @w_detalles,
		ct_tot_debito = @w_tot_debito,
		ct_tot_credito = @w_tot_credito,
		ct_tot_debito_me = @w_tot_debito_me,
		ct_tot_credito_me = @w_tot_credito_me
	   where ct_empresa = @i_empresa
		 and	ct_fecha_tran 	= @w_fecha_tran_tmp
		 and	ct_comprobante 	= @w_comp_temp
		 and    ct_oficina_orig = @w_oficina_orig_tmp

           BEGIN TRAN

	   execute @w_return = sp_compmig_consu
		@t_trn            = 6342,
		@i_operacion      = 'I',
		@i_empresa        = @i_empresa,
		@i_producto       = @w_producto_tmp,
		@i_detalles       = @w_detalles,
		@i_comprobante    = @w_comp_temp,
		@i_fecha_tran     = @w_fecha_tran_tmp,
		@i_oficina_orig   = @w_oficina_orig_tmp,
		@i_tot_debito     = @w_tot_debito,
		@i_tot_credito    = @w_tot_credito,
		@i_tot_debito_me  = @w_tot_debito_me,
		@i_tot_credito_me = @w_tot_credito_me,
		@i_traslado       = 'S',
		@o_comp_def       = @w_comp_def out
--print 'compmig 1'
	   if @w_return <> 0 /*3*/
	   begin	
 	
 	      ROLLBACK TRAN
	      insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
	      values
			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
			 'Error en Creacion de Comprobante Definitivo 2')
					
	      delete cob_conta..cb_tasiento
	      where  	ta_fecha_tran 	= @w_fecha_tran_tmp and
			ta_comprobante 	= @w_comp_temp and
			ta_empresa 	= @i_empresa and
                        ta_oficina_orig = @w_oficina_orig_tmp

	      delete cob_conta..cb_tcomprobante
	      where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
			ct_comprobante 	= @w_comp_temp and
			ct_empresa 	= @i_empresa and
                        ct_oficina_orig = @w_oficina_orig_tmp

	      select @w_error_comp = 1
	   
	   end -- FIN DE  if @w_return <> 0 /*3*/
	   else
	   begin
	
	      update cob_interfase..ct_scomprobante
	      set 	sc_estado = 'P',
			sc_comp_definit = @w_comp_def
	      from cob_interfase..ct_scomprobante --(index i_ct_scomp_1)
	      where 	sc_empresa     		= @i_empresa
			and   sc_producto    	= @w_producto_tmp
			and   sc_fecha_tran  	= @w_fecha_tran_tmp
			and   sc_comprobante 	> 0
			and   sc_oficina_orig 	= @w_oficina_orig_tmp
			and   sc_area_orig    	= @w_area_orig_tmp
			and   sc_perfil	      	= @w_perfil_tmp
			and   sc_estado 	= 'B'

	      if (@@error <> 0 or @@rowcount = 0)
	      begin	
	
	         ROLLBACK TRAN
		 insert into cob_conta..cb_errores_consu
			(ec_empresa,ec_producto,ec_fecha,
			 ec_oficina_orig,ec_area_orig,ec_perfil,
			 ec_descripcion)
		 values
			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
			 'Error en Actualizacion de auxiliar 2')

		 select @w_error_comp = 1
	
	      end 
	      else 
	      begin
	         COMMIT TRAN
	      end									
	   end -- FIN DE ELSE if @w_return <> 0 /*3*/
        end -- FIN DE ELSE if @w_return <> 0 /*2*/
     end -- FIN DE ELSE if @w_return <> 0 /*1*/
  END -- FIN DE if @w_paso = 1 and @w_error_comp = 0
  
  /******************************************************************/
  /******************************************************************/
  /*	 MANEJO DE COMPROBANTES DE SIDAC PARA DIFERIDOS  	    */
  /******************************************************************/
  /******************************************************************/
  
  ---------------------------------------------------------------------
  --  SI EL PRODUCTO ES 48 SOLO INCLUIMOS COMPROBANTES CON DIFERIDOS --
  ---------------------------------------------------------------------
  IF @w_producto_cont = 48
  BEGIN

     --print '++++++++++++++++SECCION DE DIFERIDOS+++++++++++++++++++'
     select @w_paso = 0
     --ACTUALIZAMOS LOS CAMPOS DE SA_COMPROBANTES DE FLAG EN 1 PARA LOS COMPROBANTES QUE SON DE DIFERIDOS
     UPDATE #tmp_flag
     set sa_fecha_fin_difer=isnull(a.sa_fecha_fin_difer,''),
     sa_plazo_difer=isnull(a.sa_plazo_difer,0),sa_desc_difer=isnull(a.sa_desc_difer,''),sa_empresa=a.sa_empresa,sa_asiento=a.sa_asiento
     FROM #tmp_flag t, cob_interfase..ct_sasiento a
     where t.sc_fecha_tran = a.sa_fecha_tran
     and a.sa_empresa = 1
     and t.sc_producto = a.sa_producto
     and t.sc_comprobante = a.sa_comprobante
     and t.sa_oficina_dest = a.sa_oficina_dest
     and t.sa_area_dest = a.sa_area_dest
     and t.sa_cuenta = a.sa_cuenta
     and a.sa_asiento > 0
     and t.sa_debito = a.sa_debito
     and t.sa_credito = a.sa_credito
     and t.flag = 1
     
     --ARMAMOS EL CURSOR DE LA TABLA #TMP_FLAG PARA TODOS LOS QUE TIENEN FLAG=0
     declare resumen cursor for
     select 	sc_fecha_tran, 			sc_producto,			sc_oficina_orig,
     		sc_area_orig,			sc_perfil,			sa_oficina_dest,
     		sa_area_dest,			sa_cuenta,			sa_tipo_doc,
		isnull(sa_debito,0),		isnull(sa_credito,0),		isnull(sa_debito_me,0),
		isnull(sa_credito_me,0),	sc_comprobante
     from	#tmp_flag
     where      flag = 1
     order by sc_fecha_tran, sc_producto, sc_comprobante, sa_asiento--sc_oficina_orig, sc_area_orig, sc_perfil, sc_comprobante
     FOR READ ONLY 

     open resumen

     fetch resumen into
		@w_fecha_tran,		@w_producto,	        @w_oficina_orig,	
		@w_area_orig,		@w_perfil,		@w_oficina_dest,	
		@w_area_dest,		@w_cuenta,		@w_tipo_doc,
		@w_debito,		@w_credito,		@w_debito_me,	
		@w_credito_me,		@w_comp_aux
		
     /******************************************************************/
     /******************************************************************/
     /*	CURSOR QUE MANEJA LOS ASIENTOS SEGUN EL PRODUCTO    	    */
     /******************************************************************/
     /******************************************************************/
     while (@@fetch_status = 0)
     BEGIN
       
        --print '*****CompAux %1! - Perfil %2! - Cuenta %3!',@w_comp_aux,@w_perfil,@w_cuenta
        ----------------------------------------------------------------
        --  VALIDAMOS SI LAS TMP TIENEN INFORMACION Y SI SON IGUALES  --
        --  SON ASIENTOS DEL MISMO COMPROBANTE DE LO CONTRARIO ES UN  --
        --  COMPROBANTE NUEVO					   --
        ----------------------------------------------------------------
        IF  @w_fecha_tran_tmp   = @w_fecha_tran
	and @w_producto_tmp	= @w_producto
	and @w_oficina_orig_tmp = @w_oficina_orig 
	and @w_area_orig_tmp    = @w_area_orig
	and @w_perfil_tmp       = @w_perfil
	and @w_comp_tmp	        = @w_comp_aux
        BEGIN
       
           --print 'ENTRO A ASIENTOS DEL MISMO COMPROBANTE'
           --print '%1! - %2! - %3! - %4!',@w_fecha_tran,@w_oficina_orig,@w_perfil,@w_comp_aux
           -------------------------------------------------------------
           --  SI NO HUBO ERROR Y EL ASIENTO ES DE NATURALEZA DEBITO  --
           -------------------------------------------------------------
           if @w_error_comp = 0 and @w_debito <> 0
	   begin
	    
	      select @w_cotizacion = 0,
	 	     @w_detalle    = @w_detalle + 1
       
	      if @w_debito_me <> 0
	         select @w_cotizacion = @w_debito / @w_debito_me
       
              --print 'Creamos Asiento Debito %1!',@w_debito
	      execute @w_return = sp_asientot_consu
	 	@t_trn          = 6341,
	 	@i_operacion    = 'I',
	 	@i_modo         = 0,
	 	@i_empresa      = @i_empresa,
	 	@i_comprobante  = @w_comp_temp,
	 	@i_fecha_tran   = @w_fecha_tran,
	 	@i_asiento      = @w_detalle,
	 	@i_cuenta       = @w_cuenta,
	 	@i_oficina_dest = @w_oficina_dest,
	 	@i_oficina_orig = @w_oficina_orig,
	 	@i_area_dest    = @w_area_dest,
	 	@i_tipo_doc     = @w_tipo_doc,
	 	@i_tipo_tran    = 'A',
	 	@i_credito      = 0,
	 	@i_debito       = @w_debito,
	 	@i_credito_me   = 0,
	 	@i_debito_me    = @w_debito_me,
	 	@i_cotizacion   = @w_cotizacion,
	 	@i_concepto     = @w_concepto,
	 	@i_mayorizado   = 'N',
	 	@i_autorizado   = 'S',
	 	@i_consolidado  = 'N'
       
	      if @w_return <> 0
	      begin	
	 	
	         insert into cob_conta..cb_errores_consu
	      		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	         values
	 	  	(@i_empresa,@w_producto,@w_fecha_tran,
	 		 @w_oficina_orig,@w_area_orig,@w_perfil,
	 		 'Error en Insersion de Asiento Temporal')
	       
	         delete cob_conta..cb_tasiento
	         where	ta_fecha_tran = @w_fecha_tran_tmp 
	         and	ta_comprobante = @w_comp_temp 
	         and	ta_empresa = @i_empresa 
	         and    ta_oficina_orig = @w_oficina_orig_tmp
       
	         delete cob_conta..cb_tcomprobante
	         where 	ct_fecha_tran = @w_fecha_tran_tmp 
	         and    ct_comprobante = @w_comp_temp 
	         and	ct_empresa = @i_empresa 
	         and    ct_oficina_orig = @w_oficina_orig_tmp
       
	         select @w_error_comp = 1
	    
	      end -- FIN DE if @w_return <> 0
	    
           end -- FIN DE if @w_error_comp = 0 and @w_debito <> 0
       
           --------------------------------------------------------------
           --  SI NO HUBO ERROR Y EL ASIENTO ES DE NATURALEZA CREDITO  --
           --------------------------------------------------------------
           if @w_error_comp = 0 and @w_credito <> 0
           begin
	 	
	      select @w_cotizacion = 0,
	    	     @w_detalle = @w_detalle + 1
       
	      if @w_credito_me <> 0
	         select @w_cotizacion = @w_credito / @w_credito_me
       
              --print 'Creamos Asiento Credito %1!',@w_credito
	      execute @w_return = sp_asientot_consu
	    	@t_trn          = 6341,
	 	@i_operacion    = 'I',
	 	@i_modo         = 0,
	 	@i_empresa      = @i_empresa,
	 	@i_comprobante  = @w_comp_temp,
	 	@i_fecha_tran   = @w_fecha_tran,
	 	@i_asiento      = @w_detalle,
	 	@i_cuenta       = @w_cuenta,
	 	@i_oficina_dest = @w_oficina_dest,
	 	@i_oficina_orig = @w_oficina_orig,
	 	@i_area_dest    = @w_area_dest,
	 	@i_tipo_doc     = @w_tipo_doc,
	 	@i_tipo_tran    = 'A',
	 	@i_credito      = @w_credito,
	 	@i_debito       = 0,
	 	@i_credito_me   = @w_credito_me,
	 	@i_debito_me    = 0,
	 	@i_cotizacion   = @w_cotizacion,
	 	@i_concepto     = @w_concepto,
	 	@i_mayorizado   = 'N',
	 	@i_autorizado   = 'S',
	 	@i_consolidado  = 'N'
	 		
	      if @w_return <> 0
	      begin	
	 				
	         insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	         values
	 		(@i_empresa,@w_producto,@w_fecha_tran,
	 		 @w_oficina_orig,@w_area_orig,@w_perfil,
	 		 'Error en Insersion de Asiento Temporal')
	 
	         delete cob_conta..cb_tasiento
	         where  ta_fecha_tran = @w_fecha_tran_tmp and
	 		ta_comprobante = @w_comp_temp and
	 		ta_empresa = @i_empresa and
                             ta_oficina_orig = @w_oficina_orig_tmp
       
	         delete cob_conta..cb_tcomprobante
	         where 	ct_fecha_tran = @w_fecha_tran_tmp and
	 		ct_comprobante = @w_comp_temp and
	 		ct_empresa = @i_empresa and
                             ct_oficina_orig = @w_oficina_orig_tmp
                                                             
	         select @w_error_comp = 1
              end
	   end   -- FIN DE if @w_error_comp = 0 and @w_credito <> 0
	 
	 
	   ----------------------------------------------------------------
           --  SI NO HUBO ERROR Y EL ASIENTO NO ES DE CREDITO NI DEBITO  --
           ----------------------------------------------------------------
           if @w_error_comp = 0 and @w_credito = 0 and @w_debito = 0
           begin
             
	      select @w_cotizacion = 0,
	    	     @w_detalle = @w_detalle + 1
       
	      if @w_credito_me <> 0
	         select @w_cotizacion = @w_credito / @w_credito_me
       
              --print 'Creamos Asiento Diferente'
	      execute @w_return = sp_asientot_consu
	    	@t_trn          = 6341,
	 	@i_operacion    = 'I',
	 	@i_modo         = 0,
	 	@i_empresa      = @i_empresa,
	 	@i_comprobante  = @w_comp_temp,
	 	@i_fecha_tran   = @w_fecha_tran,
	 	@i_asiento      = @w_detalle,
	 	@i_cuenta       = @w_cuenta,
	 	@i_oficina_dest = @w_oficina_dest,
	 	@i_oficina_orig = @w_oficina_orig,
	 	@i_area_dest    = @w_area_dest,
	 	@i_tipo_doc     = @w_tipo_doc,
	 	@i_tipo_tran    = 'A',
	 	@i_credito      = @w_credito,
	 	@i_debito       = 0,
	 	@i_credito_me   = @w_credito_me,
	 	@i_debito_me    = 0,
	 	@i_cotizacion   = @w_cotizacion,
	 	@i_concepto     = @w_concepto,
	 	@i_mayorizado   = 'N',
	 	@i_autorizado   = 'S',
	 	@i_consolidado  = 'N'
	 		
	      if @w_return <> 0
	      begin
	    
	         insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	         values
	 		(@i_empresa,@w_producto,@w_fecha_tran,
	 		 @w_oficina_orig,@w_area_orig,@w_perfil,
	 		 'Error en Insersion de Asiento Temporal')
	 
	         delete cob_conta..cb_tasiento
	         where  ta_fecha_tran 	= @w_fecha_tran_tmp and
	 		ta_comprobante 	= @w_comp_temp and
	 		ta_empresa 	= @i_empresa and
                             ta_oficina_orig = @w_oficina_orig_tmp
       
	         delete cob_conta..cb_tcomprobante
	         where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
	 		ct_comprobante 	= @w_comp_temp and
	 		ct_empresa 	= @i_empresa and
                             ct_oficina_orig = @w_oficina_orig_tmp
                                                             
	         select @w_error_comp = 1
	       
	      end
           end   -- FIN DE if @w_error_comp = 0 and @w_credito = 0 and @w_debito = 0
             
        END  -- FIN DE IF  IF  @w_fecha_tran_tmp   = @w_fecha_tran EL COMPROBANTE ES NUEVO
        ----------------------------------------------------------
        --  SI ES EL 1ER COMPROBANTE O EL COMPROBANTE ES NUEVO  --
        ----------------------------------------------------------
        ELSE
        BEGIN
	   ----------------------------------------------------------------
           --  SI YA SE CREO LA CABECERA DEL COMPROBANTE Y NO HAY ERROR  --
           --  SE MIGRA Y SE ACTUALIZA EL COMPROBANTE		      --
           ----------------------------------------------------------------
           --print 'Paso %1! - Error %2!',@w_paso,@w_error_comp
           if @w_paso = 1 and @w_error_comp = 0
	   begin
       
	      execute @w_return = sp_interna_consu
	 	@t_trn          = 6727,
	 	@i_operacion    = 'I',
	 	@i_empresa      = @i_empresa,
	 	@i_comprobante  = @w_comp_temp,
	 	@i_fecha_tran   = @w_fecha_tran_tmp,
	 	@i_oficina_orig = @w_oficina_orig_tmp,
	 	@i_detalles     = @w_detalle,
	 	@i_batch        = 1,
	 	@o_desc_error   = @w_desc_error out
       
	      if @w_return <> 0 /*1*/
	      begin	
	 
	         insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	         values
	 		(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 		 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 		 @w_desc_error)
	 				
	         select @w_error_comp = 1
	 				
	         delete cob_conta..cb_tinterna 
	         where	ti_empresa 	= @i_empresa and
	 		ti_fecha_tran 	= @w_fecha_tran_tmp and
	 		ti_comprobante 	= @w_comp_temp and
	 		ti_asiento 	>= 0 and
	 		ti_oficina_dest >= 0 and
	 		ti_area_dest 	>= 0 and
	 		ti_oficina_orig = @w_oficina_orig_tmp
	 				
	         delete cob_conta..cb_tasiento
	         where  ta_fecha_tran 	= @w_fecha_tran_tmp and
	 		ta_comprobante 	= @w_comp_temp and
	 		ta_empresa 	= @i_empresa and
                             ta_oficina_orig = @w_oficina_orig_tmp
       
	         delete cob_conta..cb_tcomprobante
	         where 	ct_fecha_tran = @w_fecha_tran_tmp and
	 		ct_comprobante = @w_comp_temp and
	 		ct_empresa = @i_empresa and
                             ct_oficina_orig = @w_oficina_orig_tmp
	 		
              end -- FIN DE if @w_return <> 0 /*1*/
 	      else
 	      begin
	 				
	         select @w_detalles = count(1)
	         from   cob_conta..cb_tasiento
	         where  ta_empresa = @i_empresa
	 	 and    ta_fecha_tran   = @w_fecha_tran_tmp
	 	 and    ta_comprobante  = @w_comp_temp
	 	 and    ta_oficina_orig = @w_oficina_orig_tmp
       
	         execute @w_return = sp_posicion_consu
	 		@i_operacion    = 'I',
	 		@i_empresa      = @i_empresa,
	 		@i_comprobante  = @w_comp_temp,
	 		@i_fecha_tran   = @w_fecha_tran_tmp,
	 		@i_oficina_orig = @w_oficina_orig_tmp,
	 		@i_detalles     = @w_detalles,
	 		@o_desc_error   = @w_desc_error out
       
	         if @w_return <> 0 /*2*/
	         begin	
	 	
	 	    insert into cob_conta..cb_errores_consu
	 			(ec_empresa,ec_producto,ec_fecha,
	 			 ec_oficina_orig,ec_area_orig,ec_perfil,
	 			 ec_descripcion)
	 	    values
	 			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			 @w_desc_error)
       
	 	    delete  cob_conta..cb_posicion
          	    where   po_empresa      = @i_empresa
            	    and     po_fecha_tran   = @w_fecha_tran_tmp
            	    and     po_comprobante  = @w_comp_temp
            	    and     po_oficina_orig = @w_oficina_orig_tmp 
            							
            	    delete cob_conta..cb_tasiento
	 	    where  ta_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ta_comprobante  = @w_comp_temp
	 	    and    ta_empresa 	   = @i_empresa 
	 	    and    ta_oficina_orig = @w_oficina_orig_tmp
       
	 	    delete cob_conta..cb_tcomprobante
	 	    where  ct_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ct_comprobante  = @w_comp_temp
	 	    and    ct_empresa 	   = @i_empresa
	 	    and    ct_oficina_orig = @w_oficina_orig_tmp
	 		
	 	    select @w_error_comp = 1
	 				
	         end -- FIN DE if @w_return <> 0 /*2*/
	         else
	         begin
	 	
	 	    select @w_detalles = count(1),
	 		@w_tot_debito 	  = sum(ta_debito),
	 		@w_tot_credito    = sum(ta_credito),
	 		@w_tot_debito_me  = sum(ta_debito_me),
	 		@w_tot_credito_me = sum(ta_credito_me)
	 	    from   cob_conta..cb_tasiento
	 	    where  ta_empresa = @i_empresa
	 	    and    ta_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ta_comprobante  = @w_comp_temp
	 	    and    ta_oficina_orig = @w_oficina_orig_tmp
       
	 	    update cob_conta..cb_tcomprobante
	 	    set ct_detalles = @w_detalles,
	 		ct_tot_debito = @w_tot_debito,
	 		ct_tot_credito = @w_tot_credito,
	 		ct_tot_debito_me = @w_tot_debito_me,
	 		ct_tot_credito_me = @w_tot_credito_me
	 	    where  ct_empresa = @i_empresa
	 	    and    ct_fecha_tran = @w_fecha_tran_tmp
	 	    and    ct_comprobante = @w_comp_temp
	 	    and    ct_oficina_orig = @w_oficina_orig_tmp
       
                    BEGIN TRAN
       
	 	    execute @w_return = sp_compmig_consu
	 		@t_trn          	= 6342,
	 		@i_operacion    	= 'I',
	 		@i_empresa      	= @i_empresa,
	 		@i_producto     	= @w_producto_tmp,
	 		@i_detalles     	= @w_detalles,
	 		@i_comprobante  	= @w_comp_temp,
	 		@i_fecha_tran   	= @w_fecha_tran_tmp,
	 		@i_oficina_orig 	= @w_oficina_orig_tmp,
	 		@i_tot_debito   	= @w_tot_debito,
	 		@i_tot_credito  	= @w_tot_credito,
	 		@i_tot_debito_me 	= @w_tot_debito_me,
	 		@i_tot_credito_me 	= @w_tot_credito_me,
	 		@i_traslado     	= 'S',
	 		@o_comp_def     	= @w_comp_def out
       
	 	    --print 'DEFINITIVO %1!',@w_comp_def
	 	    if @w_return <> 0 /*3*/
	 	    begin	
                         
                       ROLLBACK TRAN
	 	       insert into cob_conta..cb_errores_consu
	 			(ec_empresa,ec_producto,ec_fecha,
	 			 ec_oficina_orig,ec_area_orig,ec_perfil,
	 			 ec_descripcion)
	 	       values
	 			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			 'Error en Creacion de Comprobante Definitivo 3')
       
       		       delete cob_conta..cb_tasiento
	 	       where  	ta_fecha_tran 	= @w_fecha_tran_tmp and
	 			ta_comprobante 	= @w_comp_temp and
	 			ta_empresa 	= @i_empresa and
                                     ta_oficina_orig = @w_oficina_orig_tmp
       
	 	       delete cob_conta..cb_tcomprobante
	 	       where 	ct_fecha_tran 	= @w_fecha_tran_tmp and
	 			ct_comprobante 	= @w_comp_temp and
	 			ct_empresa 	= @i_empresa and
                                     ct_oficina_orig = @w_oficina_orig_tmp
       
	 	       select @w_error_comp = 1
	 	    
                    end -- FIN DE if @w_return <> 0 /*3*/
	 	    else
	 	    begin
	 		
	 	       update cob_interfase..ct_scomprobante
	 	       set sc_estado = 'P', sc_comp_definit = @w_comp_def
	 	       from cob_interfase..ct_scomprobante --(index i_ct_scomp_1)
	 	       where 	sc_empresa     		= @i_empresa
	 			and   sc_producto    	= @w_producto_tmp
	 			and   sc_fecha_tran  	= @w_fecha_tran_tmp
	 			and   sc_comprobante 	= @w_comp_tmp
	 			and   sc_oficina_orig 	= @w_oficina_orig_tmp
	 			and   sc_area_orig    	= @w_area_orig_tmp
	 			and   sc_perfil	      	= @w_perfil_tmp
	 			and   sc_estado 	= 'B'						
       
	 	       if (@@error <> 0 or @@rowcount = 0) /*4*/
                            begin	
	 		
	 		  ROLLBACK TRAN
	 		  --print 'Error en Actualizacion de auxiliar 3 %1!',@w_comp_tmp
	 		  Select @w_msg_error = 'Error en Actualizacion de auxiliar 3 '+Convert(char(10),@w_comp_tmp)
	 		  insert into cob_conta..cb_errores_consu
	 			(ec_empresa,ec_producto,ec_fecha,
	 			 ec_oficina_orig,ec_area_orig,ec_perfil,
	 			 ec_descripcion)
	 		  values
	 			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			 @w_msg_error)
       
	 		  select @w_error_comp = 1
	 	       end 
	 	       else 
	 	       begin
	 	          
	 	          --print '***ACTUALIZACION COMP DEFINITIVO TIPO D 1*** %1!', @w_comp_def
	 	          Update cob_conta..cb_comprobante
	 	          Set co_tipo_compro    = 'D'
	 	          Where co_fecha_tran   = @w_fecha_tran_tmp
	 	          and   co_comprobante  = @w_comp_def
	 	          and   co_oficina_orig = @w_oficina_orig_tmp
	 	          and   co_empresa      = @i_empresa
	 	          
	 		  if @@error <> 0 /*1*/
	 		  begin
	 		     
	 		     ROLLBACK TRAN
	 		     insert into cob_conta..cb_errores_consu
	 			(ec_empresa,ec_producto,ec_fecha,
	 			 ec_oficina_orig,ec_area_orig,ec_perfil,
	 			 ec_descripcion)
	 		     values
	 			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			 'Error en Actualizacion Estado Comp. Definitivo')
       
	 		     select @w_error_comp = 1
	 		  end -- FIN DE if @@error <> 0
	 		  else
	 	          begin
	 	          
	 	             --print '***INSERCION DE DIFERIDOS*** %1!', @w_comp_tmp
                             Insert into cob_conta..cb_diferidos(
	 			di_empresa,di_comprobante,di_fecha_reg,di_oficina_orig,
	 			di_descripcion,di_valor_dif,di_fecha_inicio,di_fecha_final,
	 			di_saldo_dias,di_dias_base,di_concepto,di_dias_amortizados,
	 			di_amorti_acum,di_amorti_saldo,di_valor_mes_sig,di_fecha_ult_proc,
	 			di_valor_dia,di_control,di_estado,di_ajus_infl,di_depr_mes,
	 			di_am_acum_aju,di_asiento,di_ajus_infl_deprec,di_amorti_acum_ajus,
	 			di_ajus_infl_acum,di_ajus_infl_diferido,di_oficina_conta,di_fecha_conta)
          	             select 
	 			sa_empresa,@w_comp_def,sc_fecha_tran,sc_oficina_orig,
	 			sa_desc_difer,case when sa_debito > 0 then sa_debito else sa_credito end,sc_fecha_tran,sa_fecha_fin_difer,
	 			sa_plazo_difer,360,sa_concepto,0,
	 			0,case when sa_debito > 0 then sa_debito else sa_credito end,0,sc_fecha_tran,
	 			0,'D','N',0,0,
	 			case when sa_debito > 0 then sa_debito else sa_credito end,sa_asiento,0,0,
	 			0,0,sc_oficina_orig,sc_fecha_tran
          			  from   #tmp_flag,
                 			cob_conta..cb_cuenta_proceso
          			  where  cp_empresa     = 1
          			  and    cp_proceso     = 6980
          			  and    cp_cuenta      = sa_cuenta
          			  and    flag           = 1
          			  and    sc_comprobante = @w_comp_tmp
          			  
	 		     if @@error <> 0 /*2*/
	 		     begin
	 		     
	 		        ROLLBACK TRAN
	 		        insert into cob_conta..cb_errores_consu
	 			(ec_empresa,ec_producto,ec_fecha,
	 			 ec_oficina_orig,ec_area_orig,ec_perfil,
	 			 ec_descripcion)
	 		        values
	 			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			 'Error en Insercion de diferido')
       
	 		        select @w_error_comp = 1
	 		     end
	 		     else
	 		     begin
	 		        
	 		        Select @w_sa_ente = 0, @w_sa_ente_tipo = '',@w_sa_ente_id = ''
	 		        
	 		        --Consultamos el ente del comprobante auxiliar
	 		        select @w_sa_ente      = sa_ente,
	 		               @w_sa_ente_tipo = (select en_tipo_ced from cobis..cl_ente where en_ente = A.sa_ente),
	 		               @w_sa_ente_id   = (select en_ced_ruc from cobis..cl_ente where en_ente = A.sa_ente),
	 		               @w_sa_asiento   = sa_asiento,
	 		               @w_sa_cuenta    = sa_cuenta
	 		        from   cob_interfase..ct_sasiento A
	 		        where  sa_fecha_tran   = @w_fecha_tran_tmp
	 		        and    sa_producto     = @w_producto_cont
	 		        and    sa_comprobante  = @w_comp_tmp
	 		        and    sa_asiento      = (Select di_asiento from cob_conta..cb_diferidos
	 		                                  where di_empresa      = @i_empresa
	 		                                  and   di_comprobante  = @w_comp_def
	 		                                  and   di_fecha_reg    = @w_fecha_tran_tmp
	 		                                  and   di_asiento      > 0
	 		                                  and   di_oficina_orig = @w_oficina_orig_tmp)
	 		        and    sa_empresa      = @i_empresa
	 		        
	 		        -- Insertando en cb_retencion
	 		        --Print 'Insertando en retencion 1 Asiento:%1! - Ente:%2! - Cuenta:%3!',@w_sa_asiento,@w_sa_ente,@w_sa_cuenta
	 		        insert into cob_conta..cb_retencion(
	 		           re_comprobante,	re_empresa,		re_asiento,
                                   re_identifica,	re_tipo,		re_ente,
                                   re_fecha,		re_cuenta,		re_oficina_orig
	 		        )
	 		        Values (
	 		           @w_comp_def,		@i_empresa,		@w_sa_asiento,
	 		           @w_sa_ente_id,	@w_sa_ente_tipo,	@w_sa_ente,
	 		           @w_fecha_tran_tmp,	@w_sa_cuenta,		@w_oficina_orig_tmp
	 		        )
	 		        
	 		        if @@error <> 0
	 		        begin
	 		     
	 		           ROLLBACK TRAN
	 		           insert into cob_conta..cb_errores_consu
	 			   (ec_empresa,ec_producto,ec_fecha,
	 			    ec_oficina_orig,ec_area_orig,ec_perfil,
	 			    ec_descripcion)
	 		           values
	 			   (@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			    @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			    'Error en Insercion de retencion 1')
       
	 		           select @w_error_comp = 1
	 		        end
	 		        else
	 		        begin
	 		           COMMIT TRAN
	 		        end
	 		     end -- FIN DE ELSE if @@error <> 0 /*2*/
	 		  end -- FIN DE ELSE if @@error <> 0 /*1*/
                       end -- FIN DE ELSE if @w_return <> 0 /*4*/
	 	    end -- FIN DE ELSE if @w_return <> 0 /*3*/
	 	    -- BEGIN TRAN
	         end -- FIN DE ELSE if @w_return <> 0 /*2*/
	      end -- FIN DE ELSE if @w_return <> 0 /*1*/
	   end -- FIN DE if @w_paso = 1 and @w_error_comp = 0
	 		
             
           select @w_descripcion = ''
	   select @w_descripcion = pe_descripcion
	   from   cob_conta..cb_perfil
	   where  pe_empresa = @i_empresa
	   and    pe_producto = @w_producto
	   and    pe_perfil = @w_perfil
	 	       
	   select @w_detalle = 1,
	          @w_error_comp = 0
       
	   ----------------------------------------------------------------
           --  CREAMOS LA CABECERA DEL COMPROBANTE 		      --
           ----------------------------------------------------------------
	   execute @w_return = sp_comprobt_consu
	 	@t_trn          = 6111,
	 	@t_debug        = 'N',
	 	@i_automatico   = 6084,
	 	@i_operacion    = 'I',
	 	@i_modo         = 0,
	 	@i_empresa      = @i_empresa,
	 	@i_oficina_orig = @w_oficina_orig,
	 	@i_area_orig    = @w_area_orig,
	 	@i_fecha_tran   = @w_fecha_tran,
	 	@i_fecha_mod    = @w_fecha_hoy,
	 	@i_fecha_dig    = @w_fecha_hoy,
	 	@i_digitador    = @i_digitador,
	 	@i_descripcion  = @w_descripcion,  
	 	@i_mayoriza     = 'N',
	 	@i_mayorizado   = 'N',
	 	@i_autorizado   = 'S', 
	 	@i_autorizante  = @i_digitador,
	 	@i_reversado    = 'N', 
	 	@i_detalles     = 0,
	 	@i_tot_debito   = 0,
	 	@i_tot_credito  = 0,
	 	@i_tot_debito_me  = 0,
	 	@i_tot_credito_me = 0,
	 	@o_tcomprobante  = @w_comp_temp out
	 	
           --print 'COMP TEMPORAL %1!',@w_comp_temp
           --print '%1! - %2! - %3! - %4!',@w_fecha_tran,@w_oficina_orig,@w_perfil,@w_comp_aux
       
           if @w_return <> 0 /*1*/
           begin
	 
	      insert into cob_conta..cb_errores_consu
	 	(ec_empresa,ec_producto,ec_fecha,
	 	 ec_oficina_orig,ec_area_orig,ec_perfil,
	 	 ec_descripcion)
	      values
	 	(@i_empresa,@w_producto,@w_fecha_tran,
	 	 @w_oficina_orig,@w_area_orig,@w_perfil,
	 	 'Error en Insersion de Comprobante Temporal')
       
	      select @w_error_comp = 1
           end
           else
           begin
	 
	      ----------------------------------------------------------------
              --  CREAMOS ASIENTO DE NATURALEZA DEBITO                      --
              ----------------------------------------------------------------
	      if @w_debito <> 0
	      begin
	 
	         select @w_cotizacion = 0
	         if @w_debito_me <> 0
	 	    select @w_cotizacion = @w_debito / @w_debito_me
	 	    
                 --print 'Creamos Asiento Debito %1!',@w_debito
	         execute @w_return = sp_asientot_consu
	 		@t_trn          = 6341,
	 		@i_operacion    = 'I',
	 		@i_modo         = 0,
	 		@i_empresa      = @i_empresa,
	 		@i_comprobante  = @w_comp_temp,
	 		@i_fecha_tran   = @w_fecha_tran,
	 		@i_asiento      = @w_detalle,
	 		@i_cuenta       = @w_cuenta,
	 		@i_oficina_dest = @w_oficina_dest,
	 		@i_oficina_orig = @w_oficina_orig,
	 		@i_area_dest    = @w_area_dest,
	 		@i_tipo_doc     = @w_tipo_doc,
	 		@i_tipo_tran    = 'A',
	 		@i_credito      = 0,
	 		@i_debito       = @w_debito,
	 		@i_credito_me   = 0,
	 		@i_debito_me    = @w_debito_me,
	 		@i_cotizacion   = @w_cotizacion,
	 		@i_concepto     = @w_concepto,
	 		@i_mayorizado   = 'N',
	 		@i_autorizado   = 'S',
	 		@i_consolidado  = 'N'
       
	         if @w_return <> 0
	         begin
	 
	            insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	 	    values
	 		(@i_empresa,@w_producto,@w_fecha_tran,
	 		 @w_oficina_orig,@w_area_orig,@w_perfil,
	 		 'Error en Insersion de Asiento Temporal')
            							
                    delete cob_conta..cb_tasiento
	 	    where  ta_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ta_comprobante  = @w_comp_temp
	 	    and    ta_empresa 	   = @i_empresa
	 	    and    ta_oficina_orig = @w_oficina_orig_tmp
       
	 	    delete cob_conta..cb_tcomprobante
	 	    where  ct_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ct_comprobante  = @w_comp_temp
	 	    and    ct_empresa 	   = @i_empresa
	 	    and    ct_oficina_orig = @w_oficina_orig_tmp
                                                             
	 	    select @w_error_comp = 1
	         end
	      end -- FIN DE if @w_debito <> 0
       
	      ----------------------------------------------------------------
              --  CREAMOS ASIENTO DE NATURALEZA CREDITO                      --
              ----------------------------------------------------------------
	      if @w_credito <> 0
	      begin
	 
	         select @w_cotizacion = 0
	         if @w_credito_me <> 0
	 	    select @w_cotizacion = @w_credito / @w_credito_me
       
	         if @w_debito <> 0
	 	    select @w_detalle = @w_detalle + 1
       
                 --print 'Creamos Asiento Credito %1!',@w_credito
	         execute @w_return = sp_asientot_consu
	 		@t_trn          = 6341,
	 		@i_operacion    = 'I',
	 		@i_modo         = 0,
	 		@i_empresa      = @i_empresa,
	 		@i_comprobante  = @w_comp_temp,
	 		@i_fecha_tran   = @w_fecha_tran,
	 		@i_asiento      = @w_detalle,
	 		@i_cuenta       = @w_cuenta,
	 		@i_oficina_dest = @w_oficina_dest,
	 		@i_oficina_orig = @w_oficina_orig,
	 		@i_area_dest    = @w_area_dest,
	 		@i_tipo_doc     = @w_tipo_doc,
	 		@i_tipo_tran    = 'A',
	 		@i_credito      = @w_credito,
	 		@i_debito       = 0,
	 		@i_credito_me   = @w_credito_me,
	 		@i_debito_me    = 0,
	 		@i_cotizacion   = @w_cotizacion,
	 		@i_concepto     = @w_concepto,
	 		@i_mayorizado   = 'N',
	 		@i_autorizado   = 'S',
	 		@i_consolidado  = 'N'
       
	         if @w_return <> 0
	         begin
	 
	            insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	 	    values
	 		(@i_empresa,@w_producto,@w_fecha_tran,
	 		 @w_oficina_orig,@w_area_orig,@w_perfil,
	 		 'Error en Insersion de Asiento Temporal')
	 					
	 	    delete cob_conta..cb_tasiento
	 	    where  ta_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ta_comprobante  = @w_comp_temp
	 	    and    ta_empresa 	   = @i_empresa
	 	    and    ta_oficina_orig = @w_oficina_orig_tmp
       
	 	    delete cob_conta..cb_tcomprobante
	 	    where  ct_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ct_comprobante  = @w_comp_temp
	 	    and    ct_empresa 	   = @i_empresa
	 	    and    ct_oficina_orig = @w_oficina_orig_tmp
	 					
	 	    select @w_error_comp = 1
	         end
	      end -- FIN DE if @w_credito <> 0
       
	      ----------------------------------------------------------------
              --  SI EL MOVIMIENTO NO ES CREDITO NI DEBITO                  --
              ----------------------------------------------------------------
	      if @w_credito = 0 and @w_debito = 0
	      begin
	 
	         select @w_cotizacion = 0
	         if @w_credito_me <> 0
	            select @w_cotizacion = @w_credito / @w_credito_me
       
	         if @w_debito <> 0
	            select @w_detalle = @w_detalle + 1
       
                 --print 'Creamos Asiento Diferente'
	         execute @w_return = sp_asientot_consu
	 		@t_trn          = 6341,
	 		@i_operacion    = 'I',
	 		@i_modo         = 0,
	 		@i_empresa      = @i_empresa,
	 		@i_comprobante  = @w_comp_temp,
	 		@i_fecha_tran   = @w_fecha_tran,
	 		@i_asiento      = @w_detalle,
	 		@i_cuenta       = @w_cuenta,
	 		@i_oficina_dest = @w_oficina_dest,
	 		@i_oficina_orig = @w_oficina_orig,
	 		@i_area_dest    = @w_area_dest,
	 		@i_tipo_doc     = @w_tipo_doc,
	 		@i_tipo_tran    = 'A',
	 		@i_credito      = @w_credito,
	 		@i_debito       = 0,
	 		@i_credito_me   = @w_credito_me,
	 		@i_debito_me    = 0,
	 		@i_cotizacion   = @w_cotizacion,
	 		@i_concepto     = @w_concepto,
	 		@i_mayorizado   = 'N',
	 		@i_autorizado   = 'S',
	 		@i_consolidado  = 'N'
       
	         if @w_return <> 0
	         begin
	       
	            insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	 	    values
	 		(@i_empresa,@w_producto,@w_fecha_tran,
	 		 @w_oficina_orig,@w_area_orig,@w_perfil,
	 		 'Error en Insersion de Asiento Temporal')
	 					
	 	    delete cob_conta..cb_tasiento
	 	    where  ta_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ta_comprobante  = @w_comp_temp
	 	    and    ta_empresa      = @i_empresa
	 	    and    ta_oficina_orig = @w_oficina_orig_tmp
       
	 	    delete cob_conta..cb_tcomprobante
	 	    where  ct_fecha_tran   = @w_fecha_tran_tmp
	 	    and    ct_comprobante  = @w_comp_temp
	 	    and    ct_empresa      = @i_empresa
	 	    and    ct_oficina_orig = @w_oficina_orig_tmp
	 					
	 	    select @w_error_comp = 1
	         end
	      end -- FIN DE if @w_credito = 0 and @w_debito = 0
           end -- FIN DE ELSE if @w_return <> 0 /*1*/
	 
	   select @w_fecha_tran_tmp	= @w_fecha_tran,
	 	  @w_producto_tmp	= @w_producto,
	 	  @w_oficina_orig_tmp	= @w_oficina_orig,
	 	  @w_area_orig_tmp	= @w_area_orig,
	 	  @w_perfil_tmp		= @w_perfil,
	 	  @w_comp_tmp		= @w_comp_aux
          
        END -- FIN DE ELSE IF  @w_fecha_tran_tmp   = @w_fecha_tran EL COMPROBANTE ES NUEVO
       
        select @w_paso = 1
	 	
        fetch resumen into	
	 	@w_fecha_tran,		@w_producto,		@w_oficina_orig,	
	 	@w_area_orig,		@w_perfil,		@w_oficina_dest,	
	 	@w_area_dest,		@w_cuenta,		@w_tipo_doc,
	 	@w_debito,		@w_credito,		@w_debito_me,	
	 	@w_credito_me,		@w_comp_aux
       
     END -- FIN DE while (@@fetch_status = 0) CURSOR RESUMEN
	 
     close resumen
     deallocate resumen
       
     if @w_paso = 1 and @w_error_comp = 0
     begin
       
        execute @w_return = sp_interna_consu
	 @t_trn          = 6727,
	 @i_operacion    = 'I',
	 @i_empresa      = @i_empresa,
	 @i_comprobante  = @w_comp_temp,
	 @i_fecha_tran   = @w_fecha_tran_tmp,
	 @i_oficina_orig = @w_oficina_orig_tmp,
	 @i_detalles     = @w_detalle,
	 @i_batch        = 1,
	 @o_desc_error   = @w_desc_error out
	 			
        if @w_return <> 0 /*1*/
        begin	
	 
           insert into cob_conta..cb_errores_consu
	 	(ec_empresa,ec_producto,ec_fecha,
	 	 ec_oficina_orig,ec_area_orig,ec_perfil,
	 	 ec_descripcion)
           values
	 	(@i_empresa,@w_producto_tmp, @w_fecha_tran_tmp,
	 	 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 	 @w_desc_error)
	 		
           delete cob_conta..cb_tinterna 
	   where ti_empresa 	 = @i_empresa and
	 	 ti_fecha_tran 	 = @w_fecha_tran_tmp and
	 	 ti_comprobante  = @w_comp_temp and
	 	 ti_asiento 	 >= 0 and
	 	 ti_oficina_dest >= 0 and
	 	 ti_area_dest 	 >= 0 and
	 	 ti_oficina_orig = @w_oficina_orig_tmp
	 				
           delete cob_conta..cb_tasiento
	   where ta_fecha_tran 	 = @w_fecha_tran_tmp
	   and   ta_comprobante  = @w_comp_temp
	   and   ta_empresa 	 = @i_empresa
	   and   ta_oficina_orig = @w_oficina_orig_tmp
                                                             
           delete cob_conta..cb_tcomprobante
           where  ct_fecha_tran   = @w_fecha_tran_tmp
           and    ct_comprobante  = @w_comp_temp
           and    ct_empresa 	  = @i_empresa
           and    ct_oficina_orig = @w_oficina_orig_tmp
       
           select @w_error_comp = 1
          
        end -- FIN DE if @w_return <> 0 /*1*/
        else
        begin
          
           select  @w_detalles = count(1)
	   from cob_conta..cb_tasiento
	   where ta_empresa 	 = @i_empresa
	   and   ta_fecha_tran 	 = @w_fecha_tran_tmp
	   and   ta_comprobante  = @w_comp_temp
	   and   ta_oficina_orig = @w_oficina_orig_tmp
       
           execute @w_return = sp_posicion_consu
	 	@t_trn          = 6701,
	 	@i_operacion    = 'I',
	 	@i_empresa      = @i_empresa,
	 	@i_comprobante  = @w_comp_temp,
	 	@i_fecha_tran   = @w_fecha_tran_tmp,
	 	@i_oficina_orig = @w_oficina_orig_tmp,
	 	@i_detalles     = @w_detalles,
	 	@o_desc_error   = @w_desc_error out
       
           if @w_return <> 0 /*2*/
           begin
	    
	      insert into cob_conta..cb_errores_consu
	 	(ec_empresa,ec_producto,ec_fecha,
	 	 ec_oficina_orig,ec_area_orig,ec_perfil,
	 	 ec_descripcion)
	      values
	 	(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 	 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 	 @w_desc_error)
	 			
	      delete cob_conta..cb_posicion
              where  po_empresa      = @i_empresa
              and    po_fecha_tran   = @w_fecha_tran_tmp
              and    po_comprobante  = @w_comp_temp
              and    po_oficina_orig = @w_oficina_orig_tmp 
            							
              delete cob_conta..cb_tasiento
	      where  ta_fecha_tran   = @w_fecha_tran_tmp
	      and    ta_comprobante  = @w_comp_temp
	      and    ta_empresa      = @i_empresa
	      and    ta_oficina_orig = @w_oficina_orig_tmp
	 	
	      delete cob_conta..cb_tcomprobante
	      where  ct_fecha_tran   = @w_fecha_tran_tmp
	      and    ct_comprobante  = @w_comp_temp
	      and    ct_empresa      = @i_empresa
	      and    ct_oficina_orig = @w_oficina_orig_tmp
       
	      select @w_error_comp = 1
	 		
           end -- FIN DE if @w_return <> 0 /*2*/
           else
           begin
	 
	      select  @w_detalles = count(1),
	 	   @w_tot_debito = sum(ta_debito),
	 	   @w_tot_credito = sum(ta_credito),
	 	   @w_tot_debito_me = sum(ta_debito_me),
	 	   @w_tot_credito_me = sum(ta_credito_me)
	      from cob_conta..cb_tasiento
	      where ta_empresa = @i_empresa
	      and   ta_fecha_tran = @w_fecha_tran_tmp
	      and   ta_comprobante = @w_comp_temp
	      and   ta_oficina_orig = @w_oficina_orig_tmp
       
	      update cob_conta..cb_tcomprobante
	      set    ct_detalles = @w_detalles,
	 	     ct_tot_debito = @w_tot_debito,
	 	     ct_tot_credito = @w_tot_credito,
	 	     ct_tot_debito_me = @w_tot_debito_me,
	 	     ct_tot_credito_me = @w_tot_credito_me
	      where ct_empresa = @i_empresa
	      and   ct_fecha_tran 	= @w_fecha_tran_tmp
	      and   ct_comprobante 	= @w_comp_temp
	      and   ct_oficina_orig = @w_oficina_orig_tmp
       
              BEGIN TRAN
	    
	      --print 'EJECUTANDO 2DO COMPMIG'
	      execute @w_return = sp_compmig_consu
	 	@t_trn            = 6342,
	 	@i_operacion      = 'I',
	 	@i_empresa        = @i_empresa,
	 	@i_producto       = @w_producto_tmp,
	 	@i_detalles       = @w_detalles,
	 	@i_comprobante    = @w_comp_temp,
	 	@i_fecha_tran     = @w_fecha_tran_tmp,
	 	@i_oficina_orig   = @w_oficina_orig_tmp,
	 	@i_tot_debito     = @w_tot_debito,
	 	@i_tot_credito    = @w_tot_credito,
	 	@i_tot_debito_me  = @w_tot_debito_me,
	 	@i_tot_credito_me = @w_tot_credito_me,
	 	@i_traslado       = 'S',
	 	@o_comp_def       = @w_comp_def out
       
	      --print 'DEFINITIVO %1! return %2!',@w_comp_def,@w_return
	      if @w_return <> 0 /*3*/
	      begin
 	 
 	         ROLLBACK TRAN
	         insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	         values
	 		(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 		 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 		 'Error en Creacion de Comprobante Definitivo 4')
	 				
	         delete cob_conta..cb_tasiento
	         where  ta_fecha_tran 	= @w_fecha_tran_tmp
	         and    ta_comprobante 	= @w_comp_temp
	         and    ta_empresa 	= @i_empresa
	         and    ta_oficina_orig = @w_oficina_orig_tmp
       
	         delete cob_conta..cb_tcomprobante
	         where 	ct_fecha_tran 	= @w_fecha_tran_tmp
	         and    ct_comprobante 	= @w_comp_temp
	         and    ct_empresa 	= @i_empresa
	         and    ct_oficina_orig = @w_oficina_orig_tmp
       
	         select @w_error_comp = 1
	    
	      end -- FIN DE  if @w_return <> 0 /*3*/
	      else
	      begin
	 
	         update cob_interfase..ct_scomprobante
	         set 	sc_estado = 'P',
	 		sc_comp_definit = @w_comp_def
	         from cob_interfase..ct_scomprobante --(index i_ct_scomp_1)
	         where sc_empresa	= @i_empresa
	 	 and   sc_producto    	= @w_producto_tmp
	 	 and   sc_fecha_tran  	= @w_fecha_tran_tmp
	 	 and   sc_comprobante 	= @w_comp_tmp
	 	 and   sc_oficina_orig 	= @w_oficina_orig_tmp
	 	 and   sc_area_orig    	= @w_area_orig_tmp
	 	 and   sc_perfil      	= @w_perfil_tmp
	 	 and   sc_estado 	= 'B'
       
	         if (@@error <> 0 or @@rowcount = 0) /*4*/
	         begin
	 
	            ROLLBACK TRAN
	            --print 'Error en Actualizacion de auxiliar 4 %1!',@w_comp_tmp
	            Select @w_msg_error = 'Error en Actualizacion de auxiliar 4 '+Convert(char(10),@w_comp_tmp)
	 	    insert into cob_conta..cb_errores_consu
	 		(ec_empresa,ec_producto,ec_fecha,
	 		 ec_oficina_orig,ec_area_orig,ec_perfil,
	 		 ec_descripcion)
	 	    values
	 		(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 		 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 		 @w_msg_error)
       
	 	    select @w_error_comp = 1
	 
	         end 
	         else 
	         begin
                   
	 	    --print '***ACTUALIZACION COMP DEFINITIVO TIPO D 2*** %1!', @w_comp_def
	 	    Update cob_conta..cb_comprobante
	 	    Set co_tipo_compro    = 'D'
	 	    Where co_fecha_tran   = @w_fecha_tran_tmp
	 	    and   co_comprobante  = @w_comp_def
	 	    and   co_oficina_orig = @w_oficina_orig_tmp
	 	    and   co_empresa      = @i_empresa
	 	          
	 	    if @@error <> 0
	 	    begin
	 		     
	 	       ROLLBACK TRAN
	 	       insert into cob_conta..cb_errores_consu
	 			(ec_empresa,ec_producto,ec_fecha,
	 			 ec_oficina_orig,ec_area_orig,ec_perfil,
	 			 ec_descripcion)
	 	       values
	 			(@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 			 @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 			 'Error en Actualizacion Estado Comp. Definitivo')
       
	 	       select @w_error_comp = 1
	 	    end -- FIN DE if @@error <> 0
	 	    else
	 	    begin
	 		  
                       --print '***INSERCION DE DIFERIDOS 2*** %1!', @w_comp_tmp
                       Insert into cob_conta..cb_diferidos(
	 		di_empresa,di_comprobante,di_fecha_reg,di_oficina_orig,
	 		di_descripcion,di_valor_dif,di_fecha_inicio,di_fecha_final,
	 		di_saldo_dias,di_dias_base,di_concepto,di_dias_amortizados,
	 		di_amorti_acum,di_amorti_saldo,di_valor_mes_sig,di_fecha_ult_proc,
	 		di_valor_dia,di_control,di_estado,di_ajus_infl,di_depr_mes,
	 		di_am_acum_aju,di_asiento,di_ajus_infl_deprec,di_amorti_acum_ajus,
	 		di_ajus_infl_acum,di_ajus_infl_diferido,di_oficina_conta,di_fecha_conta)
          	       select 
	 		sa_empresa,@w_comp_def,sc_fecha_tran,sc_oficina_orig,
	 		sa_desc_difer,case when sa_debito > 0 then sa_debito else sa_credito end,sc_fecha_tran,sa_fecha_fin_difer,
	 		sa_plazo_difer,360,sa_concepto,0,
	 		0,case when sa_debito > 0 then sa_debito else sa_credito end,0,sc_fecha_tran,
	 		0,'D','N',0,0,
	 		case when sa_debito > 0 then sa_debito else sa_credito end,sa_asiento,0,0,
	 		0,0,sc_oficina_orig,sc_fecha_tran
                       from   #tmp_flag,
                    	      cob_conta..cb_cuenta_proceso
           	       where  cp_empresa     = 1
           	       and    cp_proceso     = 6980
           	       and    cp_cuenta      = sa_cuenta
           	       and    flag           = 1
           	       and    sc_comprobante = @w_comp_tmp
           		  
	 	       if @@error <> 0
	 	       begin
	 		     
	 	          ROLLBACK TRAN
	 	          insert into cob_conta..cb_errores_consu
	 		   (ec_empresa,ec_producto,ec_fecha,
	 		    ec_oficina_orig,ec_area_orig,ec_perfil,
	 		    ec_descripcion)
	 	          values
	 		   (@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 		    @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 		    'Error en Insercion de diferido')
        
	 	          select @w_error_comp = 1
	 	       end
	 	       else
	 	       begin
	 	       
	 		  Select @w_sa_ente = 0, @w_sa_ente_tipo = '',@w_sa_ente_id = ''
	 		  
	 		  --Consultamos el ente del comprobante auxiliar
	 		  select @w_sa_ente      = sa_ente,
	 		         @w_sa_ente_tipo = (select en_tipo_ced from cobis..cl_ente where en_ente = A.sa_ente),
	 		         @w_sa_ente_id   = (select en_ced_ruc from cobis..cl_ente where en_ente = A.sa_ente),
	 		         @w_sa_asiento   = sa_asiento,
	 		         @w_sa_cuenta    = sa_cuenta
	 		  from   cob_interfase..ct_sasiento A
	 		  where  sa_fecha_tran   = @w_fecha_tran_tmp
	 		  and    sa_producto     = @w_producto_cont
	 		  and    sa_comprobante  = @w_comp_tmp
	 		  and    sa_asiento      = (Select di_asiento from cob_conta..cb_diferidos
	 		                            where di_empresa      = @i_empresa
	 		                            and   di_comprobante  = @w_comp_def
	 		                            and   di_fecha_reg    = @w_fecha_tran_tmp
	 		                            and   di_asiento      > 0
	 		                            and   di_oficina_orig = @w_oficina_orig_tmp)
	 		  and    sa_empresa      = @i_empresa
	 		  
	 		  -- Insertando en cb_retencion
	 		  --Print 'Insertando en retencion 2 Asiento:%1! - Ente:%2! - Cuenta:%3!',@w_sa_asiento,@w_sa_ente,@w_sa_cuenta
	 		  insert into cob_conta..cb_retencion(
	 		     re_comprobante,	re_empresa,		re_asiento,
                             re_identifica,	re_tipo,		re_ente,
                             re_fecha,		re_cuenta,		re_oficina_orig
	 		  )
	 		  Values (
	 		     @w_comp_def,	@i_empresa,		@w_sa_asiento,
	 		     @w_sa_ente_id,	@w_sa_ente_tipo,	@w_sa_ente,
	 		     @w_fecha_tran_tmp,	@w_sa_cuenta,		@w_oficina_orig_tmp
	 		  )
	 		  
	 		  if @@error <> 0
	 		  begin
	 		  
	 		     ROLLBACK TRAN
	 		     insert into cob_conta..cb_errores_consu
	 		     (ec_empresa,ec_producto,ec_fecha,
	 		      ec_oficina_orig,ec_area_orig,ec_perfil,
	 		      ec_descripcion)
	 		     values
	 		     (@i_empresa,@w_producto_tmp,@w_fecha_tran_tmp,
	 		      @w_oficina_orig_tmp,@w_area_orig_tmp,@w_perfil_tmp,
	 		      'Error en Insercion de retencion 2')
                          
	 		     select @w_error_comp = 1
	 		  end
	 		  else
	 		  begin
	 		     COMMIT TRAN
	 		  end
	 	       end
	 	    end -- FIN DE ELSE if @@error <> 0
	         end -- FIN DE ELSE if @w_return <> 0 /*4*/									
	      end -- FIN DE ELSE if @w_return <> 0 /*3*/
           end -- FIN DE ELSE if @w_return <> 0 /*2*/
        end -- FIN DE ELSE if @w_return <> 0 /*1*/
     END -- FIN DE if @w_paso = 1 and @w_error_comp = 0
  END -- FIN DE ELSE if @w_producto_cont = 48

return 0
go