/************************************************************************/
/*  Archivo:                         ofidepart.sp                       */
/*  Stored procedure:                sp_ofi_depart                      */
/*  Base de datos:                   cob_conta                          */
/*  Producto:                        CONTABILIDAD                       */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/* ASOCIAR OFICINAS A UNA DEPARTAMENTAL O CONSOLIDADORA  		*/
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/************************************************************************/
use cob_conta
go

if object_id('sp_ofi_depart') is not null
   drop proc sp_ofi_depart
go

create proc sp_ofi_depart(
	@s_ssn		        int 	       	= null,
	@s_date		        datetime 	= null,
	@s_user		        login 		= null,
	@s_term		        descripcion 	= null,
	@s_corr		        char(1) 	= null,
	@s_ssn_corr	        int 		= null,
    	@s_ofi		        smallint	= null,
    	@s_srv                	varchar(30)     = null,
   	@t_rty		        char(1) 	= null,
    	@t_trn		        int    	        = null,
	@t_debug	        char(1) 	= 'N',
	@t_file		        varchar(14)  	= null,
	@t_from		        varchar(30) 	= null,
    	@i_tabla              	varchar(30)     = null,
	@i_operacion	     	char(1)		= null,
	@i_modo		        smallint	= null,
	@i_oficina_consolida  	smallint	= null,
    	@i_oficina_asociada  	smallint	= null,
    	@i_cuenta            	cuenta_contable = null,
    	@i_cod_declaracion   	char(2)         = null,
    	@i_declaracion       	varchar(60)     = null,
     	@i_valadxofi         	money           = null,
    	@i_codimpuesto       	char(2)         = null,
    	@i_icareteica        	char(1)         = null,
    	@i_vlabomberil       	int             = null,
    	@i_fpagobomberil     	char(2)         = null,
    	@i_porbomberil      	float         	= 0,
    	@i_abierta_pub        	char(1)         = null,
    	@i_fechaini          	datetime        = null,
    	@i_fechafin          	datetime        = null,
    	@i_empresa	        tinyint         = null,
    	@i_codcatalogos      	char(2)         = null,
    	@i_llave              	varchar(14) 	= null
)
as 
declare
    @w_return	     int,		/* valor que retorna */
    @w_sp_name	     varchar(32),	/* nombre del stored procedure*/
    @w_oficina	     smallint,
    @w_corteini      int,
    @w_cortefin	     int,
    @w_periodoini    int,
    @w_periodofin    int,
    @w_saldo_ini     money,
    @w_saldo_fin     money,
    @w_debito        money,
    @w_credito       money,
    @w_debito_ini    money,
    @w_credito_ini   money,
    @w_movneto       money,
    @w_estado_corte  CHAR(1),
    @w_categoria     char(1)

select @w_sp_name = 'sp_ofi_depart'

-- Validacion de transacciones y operaciones
if (@t_trn <> 6266 and @i_operacion = 'I')or
   (@t_trn <> 6266 and @i_operacion = 'A')or
   (@t_trn <> 6267 and @i_operacion = 'D')or
   (@t_trn <> 6266 and @i_operacion = 'C')or
   (@t_trn <> 6266 and @i_operacion = 'B')or
   (@t_trn <> 6266 and @i_operacion = 'E')or
   (@t_trn <> 6266 and @i_operacion = 'Q')or
   (@t_trn <> 6266 and @i_operacion = 'Z')or
   (@t_trn <> 6266 and @i_operacion = 'W')or
   (@t_trn <> 6266 and @i_operacion = 'T')or
   (@t_trn <> 6266 and @i_operacion = 'U')

begin
	-- 'Transaccion no corresponde'
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 3075000
	return 1
end

/************************************************/
/* 		Modo Debug			*/
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
			s_ssn		     = @s_ssn,
			s_date		     = @s_date,
			s_user		     = @s_user,
			s_term		     = @s_term,
			s_corr		     = @s_corr,
			s_ssn_corr	     = @s_ssn_corr,
			s_ofi		     = @s_ofi,

			t_rty		     = @t_rty,
			t_trn		     = @t_trn,
			t_debug		     = @t_debug,
			t_file		     = @t_file,
			t_from		     = @t_from,

			i_operacion	     = @i_operacion,
			i_modo		     = @i_modo,
            		i_oficina_consolida  = @i_oficina_consolida,
            		i_oficina_asociada   = @i_oficina_asociada

	exec cobis..sp_end_debug
end

/****************************************************************/
/*	CALCULO DE PERIODOS Y CORTES SEGUN FECHAS INI Y FIN	*/
/****************************************************************/
select 	@w_corteini     = co_corte, 
	    @w_periodoini   = co_periodo
from 	cob_conta..cb_corte
where 	co_empresa   = @i_empresa 
and   	co_fecha_ini = @i_fechaini 

select 	@w_cortefin     = co_corte, 
	    @w_periodofin   = co_periodo
from 	cob_conta..cb_corte
where 	co_empresa   = @i_empresa 
and   	co_fecha_ini = @i_fechafin 

 select @w_saldo_ini= 0,
        @w_debito = 0,
        @w_debito_ini= 0,
        @w_credito= 0,
        @w_credito_ini= 0,
        @w_movneto= 0,
        @w_saldo_fin= 0
        
/****************************************************************/
/* Ingreso de ofic. Pagadoras y Ofic. Asociadas a Declaraciones */
/****************************************************************/
if @i_operacion = 'I'
begin
    /* Verificar que no existe el registro de la oficina pagadora que se va a insertar */    
    if not exists(select of_oficina_consolida
                    from cob_conta..cb_ofpagadora
                   where of_oficina_consolida = @i_oficina_consolida
                     and of_cod_declaracion   = @i_cod_declaracion
                 )
    BEGIN
    BEGIN TRAN
             insert into cob_conta..cb_ofpagadora
	           (of_oficina_consolida,of_cuenta,of_cod_declaracion,
                    of_declaracion,of_valadxofi,of_icareteica,
                    of_vlabomberil, of_fpagobomberil,of_porbomberil
                    )
              values
           	    (@i_oficina_consolida,@i_cuenta,@i_cod_declaracion,
                     @i_declaracion,@i_valadxofi,@i_icareteica,
                     @i_vlabomberil,@i_fpagobomberil,@i_porbomberil
                    )
             if @@error <> 0
	        begin
		   /* 'Error No se pudo insertar la oficina pagadora' */
		   exec cobis..sp_cerror
		       @t_debug = @t_debug,
		       @t_file	 = @t_file,
		       @t_from	 = @w_sp_name,
		       @i_num	 = 609303
		       ROLLBACK TRAN
		       return 1
             	end
    COMMIT TRAN
    END
 
    if exists (select * from cob_conta..cb_aso_oficonsol
	        where ao_oficina_consolida = @i_oficina_consolida
                  and ao_oficina_asociada  = @i_oficina_asociada
                  and ao_cod_declaracion   = @i_cod_declaracion)
        begin
	   /*'Error Ya existe esta oficina ASOCIADA'*/
	   exec cobis..sp_cerror
	       @t_debug = @t_debug,
	       @t_file  = @t_file,
	       @t_from  = @w_sp_name,
	       @i_num   = 609304
	       return 1
	end
    else
        BEGIN TRAN
        BEGIN
            if @i_oficina_asociada <> null
               begin 
                  select 1 from cb_aso_oficonsol
                   where ao_oficina_consolida = @i_oficina_consolida
                     and ao_oficina_asociada  = @i_oficina_asociada
                     and ao_cod_declaracion   = @i_cod_declaracion
                     and ao_cuenta            = @i_cuenta
                  if @@rowcount = 0
                  begin
                     insert into cob_conta..cb_aso_oficonsol
		            (ao_oficina_consolida,ao_oficina_asociada,ao_cuenta,
                             ao_cod_declaracion,ao_declaracion,ao_abierta_alpublico)
                     values (@i_oficina_consolida,@i_oficina_asociada,@i_cuenta,
                             @i_cod_declaracion,@i_declaracion,@i_abierta_pub)
                     if @@error <> 0
	             begin
		        /* 'Error No se pudo insertar la oficina asociada' */
		        exec cobis..sp_cerror
		            @t_debug = @t_debug,
		            @t_file  = @t_file,
		            @t_from  = @w_sp_name,
		            @i_num   = 609305
		            ROLLBACK TRAN
		            return 1
	             end
	          end
	          else
	          begin
	             /* 'Ya existe esta oficina ASOCIADA' */
		     exec cobis..sp_cerror
		         @t_debug = @t_debug,
		         @t_file  = @t_file,
		         @t_from  = @w_sp_name,
		         @i_num   = 609304
		         ROLLBACK TRAN
		         return 1
	          end
	    end
  	COMMIT TRAN
        END

end /*	 ---->>Fin operacion I	*/
/****************************************************************/
/*	Consulta las oficinas asociadas a Oficinas Pagadoras    */
/****************************************************************/
if @i_operacion = 'A'
Begin
  set rowcount 20
  if @i_modo = 0
  begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
     	    "**ASO"		= ao_oficina_asociada,
     	    "**PUB"		= ao_abierta_alpublico,
            "DEC ICA-RETEICA"	= of_icareteica,
   	    "VLR OFIC ADIC"	= of_valadxofi,
            "VALOR BOMBERIL"	= of_vlabomberil,
            "TIPO CALC BOM"	= of_fpagobomberil,
            "PORC CALC BOM"	= of_porbomberil,
            "LLAVE"		= right("000000"+convert(varchar,ao_oficina_consolida),6) +
                                  right("000000"+convert(varchar,ao_oficina_asociada),6)  +
                                  right("00"+convert(varchar,ao_cod_declaracion),2)
       from cb_ofpagadora,cb_aso_oficonsol
      where of_oficina_consolida = ao_oficina_consolida
        and of_cod_declaracion = ao_cod_declaracion
        and of_cod_declaracion = @i_cod_declaracion
      order by of_cod_declaracion,ao_oficina_consolida, ao_oficina_asociada
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	     @t_debug = @t_debug,
	     @t_file  = @t_file,
	     @t_from  = @w_sp_name,
	     @i_num	  = 601153-- *** No existen registros para la consulta dada ***
	 return 1
      end
   end
   if @i_modo = 1
   begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
     	    "**ASO"		= ao_oficina_asociada,
     	    "**PUB"		= ao_abierta_alpublico,     	    
            "DEC ICA-RETEICA"	= of_icareteica,
   	    "VLR OFIC ADIC"	= of_valadxofi,
            "VALOR BOMBERIL"	= of_vlabomberil,
            "TIPO CALC BOM"	= of_fpagobomberil,
            "PORC CALC BOM"	= of_porbomberil,
            "LLAVE"		= right("000000"+convert(varchar,ao_oficina_consolida),6) +
                                  right("000000"+convert(varchar,ao_oficina_asociada),6)  +
                                  right("00"+convert(varchar,ao_cod_declaracion),2)
       from cb_ofpagadora,cb_aso_oficonsol
      where of_oficina_consolida = ao_oficina_consolida
        and of_cod_declaracion   = ao_cod_declaracion
        and of_cod_declaracion   = @i_cod_declaracion
        and right("000000"+convert(varchar,ao_oficina_consolida),6) +
            right("000000"+convert(varchar,ao_oficina_asociada),6)  +
            right("00"+convert(varchar,ao_cod_declaracion),2) > @i_llave        
      order by of_cod_declaracion,ao_oficina_consolida, ao_oficina_asociada    
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 601150-- *** NO HAY MAS REGISTROS ***
	 return 1
      end
   end
   if @i_modo = 2
   begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
     	    "**ASO"		= ao_oficina_asociada,
     	    "**PUB"		= ao_abierta_alpublico,
            "DEC ICA-RETEICA"	= of_icareteica,
            "LLAVE"		= right("000000"+convert(varchar,ao_oficina_consolida),6) +
                                  right("000000"+convert(varchar,ao_oficina_asociada),6)  +
                                  right("00"+convert(varchar,ao_cod_declaracion),2)
       from cb_ofpagadora,cb_aso_oficonsol
      where of_oficina_consolida = ao_oficina_consolida
        and of_cod_declaracion   = ao_cod_declaracion
        and of_cod_declaracion   = @i_cod_declaracion
      order by of_cod_declaracion,ao_oficina_consolida, ao_oficina_asociada
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	     @t_debug = @t_debug,
	     @t_file  = @t_file,
	     @t_from  = @w_sp_name,
	     @i_num	  = 601153-- *** No existen registros para la consulta dada ***
	 return 1
      end
   end
   if @i_modo = 3
   begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
     	    "**ASO"		= ao_oficina_asociada,
     	    "**PUB"		= ao_abierta_alpublico,     	    
            "DEC ICA-RETEICA"	= of_icareteica,
            "LLAVE"		= right("000000"+convert(varchar,ao_oficina_consolida),6) +
                                  right("000000"+convert(varchar,ao_oficina_asociada),6)  +
                                  right("00"+convert(varchar,ao_cod_declaracion),2)
       from cb_ofpagadora,cb_aso_oficonsol
      where of_oficina_consolida = ao_oficina_consolida
        and of_cod_declaracion   = ao_cod_declaracion
        and of_cod_declaracion   = @i_cod_declaracion
        and right("000000"+convert(varchar,ao_oficina_consolida),6) +
            right("000000"+convert(varchar,ao_oficina_asociada),6)  +
            right("00"+convert(varchar,ao_cod_declaracion),2) > @i_llave        
      order by of_cod_declaracion,ao_oficina_consolida, ao_oficina_asociada
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 601150-- *** NO HAY MAS REGISTROS ***
	 return 1
      end
   end
   if @i_modo = 4
   begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
     	    "**ASO"		= ao_oficina_asociada,
     	    "**PUB"		= ao_abierta_alpublico,
            "LLAVE"		= right("000000"+convert(varchar,ao_oficina_consolida),6) +
                                  right("000000"+convert(varchar,ao_oficina_asociada),6)  +
                                  right("00"+convert(varchar,ao_cod_declaracion),2)
       from cb_ofpagadora,cb_aso_oficonsol
      where of_oficina_consolida = ao_oficina_consolida
        and of_cod_declaracion   = ao_cod_declaracion
        and of_cod_declaracion   = @i_cod_declaracion
      order by of_cod_declaracion,ao_oficina_consolida, ao_oficina_asociada
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 601150-- *** NO HAY MAS REGISTROS ***
	 return 1
      end
   end
   if @i_modo = 5
   begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
     	    "**ASO"		= ao_oficina_asociada,
     	    "**PUB"		= ao_abierta_alpublico,     	    
            "LLAVE"		= right("000000"+convert(varchar,ao_oficina_consolida),6) +
                                  right("000000"+convert(varchar,ao_oficina_asociada),6)  +
                                  right("00"+convert(varchar,ao_cod_declaracion),2)
       from cb_ofpagadora,cb_aso_oficonsol
      where of_oficina_consolida = ao_oficina_consolida
        and of_cod_declaracion   = ao_cod_declaracion
        and of_cod_declaracion   = @i_cod_declaracion
        and right("000000"+convert(varchar,ao_oficina_consolida),6) +
            right("000000"+convert(varchar,ao_oficina_asociada),6)  +
            right("00"+convert(varchar,ao_cod_declaracion),2) > @i_llave        
      order by of_cod_declaracion,ao_oficina_consolida, ao_oficina_asociada
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 601150-- *** NO HAY MAS REGISTROS ***
	 return 1
      end
   end
   if @i_modo = 6
   begin
     select "COD. IMP"	       = of_cod_declaracion,
     	    "DESC IMPUESTO"    = of_declaracion,
     	    "OFIC PAGA"	       = of_oficina_consolida,
            "DEC ICA-RETEICA"  = of_icareteica,
            "LLAVE"	       = right("000000"+convert(varchar,of_oficina_consolida),6) +
                                 right("00"+convert(varchar,of_cod_declaracion),2)
       from cb_ofpagadora
      where of_cod_declaracion = @i_cod_declaracion
        and of_icareteica      = "S"
      order by of_oficina_consolida,of_cod_declaracion
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	     @t_debug = @t_debug,
	     @t_file  = @t_file,
	     @t_from  = @w_sp_name,
	     @i_num	  = 601153-- *** No existen registros para la consulta dada ***
	 return 1
      end
   end
   if @i_modo = 7
   begin
     select "COD. IMP"		= of_cod_declaracion,
     	    "DESC IMPUESTO"	= of_declaracion,
     	    "OFIC PAGA"		= of_oficina_consolida,
            "DEC ICA-RETEICA"	= of_icareteica,
            "LLAVE"		= right("000000"+convert(varchar,of_oficina_consolida),6) +
                                  right("00"+convert(varchar,of_cod_declaracion),2)
       from cb_ofpagadora
      where of_cod_declaracion = @i_cod_declaracion
        and of_icareteica = "S"
        and right("000000"+convert(varchar,of_oficina_consolida),6) +
            right("00"+convert(varchar,of_cod_declaracion),2) > @i_llave        
      order by of_oficina_consolida,of_cod_declaracion
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 601150-- *** NO HAY MAS REGISTROS ***
	 return 1
      end
   end
   if @i_modo = 8
   begin
     select "COD. IMP"	       = of_cod_declaracion,
     	    "DESC IMPUESTO"    = of_declaracion,
     	    "OFIC PAGA"	       = of_oficina_consolida,
            "DEC ICA-RETEICA"  = of_icareteica,
   	    "VLR OFIC ADIC"    = of_valadxofi,
            "VALOR BOMBERIL"   = of_vlabomberil,
            "TIPO CALC BOM"    = of_fpagobomberil,
            "PORC CALC BOM"    = of_porbomberil,
            "LLAVE"	       = right("000000"+convert(varchar,of_oficina_consolida),6) +
                                 right("00"+convert(varchar,of_cod_declaracion),2)
       from cb_ofpagadora
      where of_cod_declaracion = @i_cod_declaracion
        and of_icareteica      = "S"
      order by of_oficina_consolida,of_cod_declaracion
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	     @t_debug = @t_debug,
	     @t_file  = @t_file,
	     @t_from  = @w_sp_name,
	     @i_num	  = 601153-- *** No existen registros para la consulta dada ***
	 return 1
      end
   end
   if @i_modo = 9
   begin
     select "COD. IMP"	       = of_cod_declaracion,
     	    "DESC IMPUESTO"    = of_declaracion,
     	    "OFIC PAGA"	       = of_oficina_consolida,
            "DEC ICA-RETEICA"  = of_icareteica,
   	    "VLR OFIC ADIC"    = of_valadxofi,
            "VALOR BOMBERIL"   = of_vlabomberil,
            "TIPO CALC BOM"    = of_fpagobomberil,
            "PORC CALC BOM"    = of_porbomberil,
            "LLAVE"	       = right("000000"+convert(varchar,of_oficina_consolida),6) +
                                 right("00"+convert(varchar,of_cod_declaracion),2)
       from cb_ofpagadora
      where of_cod_declaracion = @i_cod_declaracion
        and of_icareteica      = "S"
        and right("000000"+convert(varchar,of_oficina_consolida),6) +
            right("00"+convert(varchar,of_cod_declaracion),2) > @i_llave
      order by of_oficina_consolida,of_cod_declaracion
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 601150-- *** NO HAY MAS REGISTROS ***
	 return 1
      end
   end
End

/****************************************************************/
/*	Consulta para llenar la grilla de Oficinas Asociadas    */
/****************************************************************/

if @i_operacion = 'B'
Begin
     set rowcount 0   
     select "OFIC ASOCIADA"   = ao_oficina_asociada,
            "NOM ASOCIADA"    = of_descripcion,
            "ABIERTA PUBLICO" = ao_abierta_alpublico
       from cb_aso_oficonsol,cb_oficina
      where ao_oficina_consolida = @i_oficina_consolida
        and ao_oficina_asociada  = of_oficina
        and ao_cod_declaracion   = @i_cod_declaracion
      order by ao_oficina_asociada
End

/****************************************************************/
/*	borrado de una oficina 					*/
/****************************************************************/

if @i_operacion = 'D'
begin
    	delete cob_conta..cb_aso_oficonsol
         where ao_oficina_consolida = @i_oficina_consolida
         and   ao_oficina_asociada  = @i_oficina_asociada
         and   ao_cuenta            = @i_cuenta
         and   ao_cod_declaracion   = @i_cod_declaracion
		if @@rowcount = 0
		Begin
			/* 'Error No pudo Borrar esta oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 609307
			return 1
		End
       
        select ao_oficina_consolida
        from cob_conta..cb_aso_oficonsol
         where ao_oficina_consolida = @i_oficina_consolida
         and   ao_cod_declaracion   = @i_cod_declaracion
         
        if @@rowcount = 0
        begin
            delete cob_conta..cb_ofpagadora
            where of_oficina_consolida = @i_oficina_consolida
            and   of_cod_declaracion   = @i_cod_declaracion
        end
        
end
/**************************************************/
/*	Consulta de Oficinas asociadas para EXCEL */
/**************************************************/

if @i_operacion = 'Q'
Begin
	select 'OFI ASOCIADA' = ao_oficina_asociada 
	  from cob_conta..cb_aso_oficonsol
         where ao_oficina_consolida = @i_oficina_consolida
           and ao_cod_declaracion   = @i_cod_declaracion
         group by ao_oficina_asociada
End

/*************************************************************************/
/*	Consulta de Valores adicionales de la oficina pagadorapara EXCEL */
/*************************************************************************/

if @i_operacion = 'Z'
Begin
     select    of_valadxofi ,
               (select count(1)
                  from cob_conta..cb_aso_oficonsol
                 where ao_oficina_consolida  = @i_oficina_consolida
                   and ao_cod_declaracion    = @i_cod_declaracion
                   and ao_abierta_alpublico = 'S'),
                case when of_vlabomberil = 0 then of_porbomberil
                     else of_vlabomberil  end,
                of_fpagobomberil,
                of_icareteica
	    from cob_conta..cb_ofpagadora
        where of_oficina_consolida  = @i_oficina_consolida
        and   of_cod_declaracion    = @i_cod_declaracion
End

/**************************************************************/
/*	Consulta del Saldo de la cuenta 4 pagadora para EXCEL */
/**************************************************************/

if @i_operacion = 'W'
Begin

    select @w_estado_corte  = co_estado
      from cob_conta..cb_corte
     where co_empresa = @i_empresa
       and co_fecha_ini >= @i_fechafin
       and co_fecha_fin <= @i_fechafin
       
    select @w_categoria = cu_categoria
      from cob_conta..cb_cuenta
     where cu_cuenta = @i_cuenta
       and cu_empresa = @i_empresa

    if @w_estado_corte = 'A'
       begin
          select @w_saldo_ini = isnull(sum(sa_saldo),0)
     	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_corteini
      	     and sa_periodo = @w_periodoini
             and sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa 
      
          select @w_saldo_fin = isnull(sum(sa_saldo),0)
      	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_cortefin
      	     and sa_periodo = @w_periodofin
             and sa_cuenta  = @i_cuenta
      	     and sa_empresa = @i_empresa              
      
          select @w_debito = isnull(sum(sa_debito),0)
      	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_cortefin
      	     and sa_periodo = @w_periodofin
             and sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa 
      
          select @w_credito = isnull(sum(sa_credito),0)
      	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_cortefin
      	     and sa_periodo = @w_periodofin
             and sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa
       end
    else
       begin
	      select @w_saldo_ini = isnull(sum(hi_saldo),0),
                 @w_debito_ini = isnull(sum(hi_debito),0),
                 @w_credito_ini = isnull(sum(hi_credito),0)
            from cob_conta_his..cb_hist_saldo
           where hi_corte   = @w_corteini
    	     and hi_periodo = @w_periodoini	     
             and hi_cuenta  = @i_cuenta
             and hi_empresa = @i_empresa

      	  select @w_saldo_fin = isnull(sum(hi_saldo),0),
                 @w_debito = isnull(sum(hi_debito),0),
                 @w_credito = isnull(sum(hi_credito),0)
	        from cob_conta_his..cb_hist_saldo
	       where hi_corte   = @w_cortefin
    	     and hi_periodo = @w_periodofin
             and hi_cuenta  = @i_cuenta
             and hi_empresa = @i_empresa
       end
       
    -- MOVIMIENTO NETO
    select @w_movneto = @w_saldo_fin - @w_saldo_ini

   -- print 'categoria %1!',@w_categoria
    if @w_categoria = 'D'
        select @w_saldo_ini,@w_debito-@w_debito_ini,@w_credito-@w_credito_ini,@w_movneto,@w_saldo_fin
    else
        select (@w_saldo_ini*-1),(@w_debito_ini-@w_debito),(@w_credito_ini-@w_credito),(@w_movneto*-1),(@w_saldo_fin*-1)

End

/**************************************************************************/
/*	Consulta Saldos Cuentas Contables parametrizadas en la Hoja EXCEL */
/**************************************************************************/

if @i_operacion = 'Y'
Begin
  
    select @w_estado_corte  = co_estado
      from cob_conta..cb_corte
     where co_empresa = @i_empresa
       and co_fecha_ini >= @i_fechafin
       and co_fecha_fin <= @i_fechafin
   
       
    select @w_categoria = cu_categoria
      from cob_conta..cb_cuenta
     where cu_cuenta = @i_cuenta
       and cu_empresa = @i_empresa
          
    if @w_estado_corte = 'A'
       begin
          select @w_saldo_ini = isnull(sum(sa_saldo),0)
     	    from cob_conta..cb_saldo, cob_conta..cb_aso_oficonsol
           where ao_oficina_consolida  = @i_oficina_consolida
             and ao_cod_declaracion    = @i_cod_declaracion
      	     and sa_corte   = @w_corteini
      	     and sa_periodo = @w_periodoini
      	     and sa_oficina = ao_oficina_asociada
             and sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa 
      
          select @w_saldo_fin = isnull(sum(sa_saldo),0)
      	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_cortefin
      	     and sa_periodo = @w_periodofin
      	     and sa_oficina = @i_oficina_consolida
             and sa_cuenta  = @i_cuenta
      	     and sa_empresa = @i_empresa              
      
          select @w_debito = isnull(sum(sa_debito),0)
      	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_cortefin
      	     and sa_periodo = @w_periodofin
      	     and sa_oficina = @i_oficina_consolida
             and sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa 
      
          select @w_credito = isnull(sum(sa_credito),0)
      	    from cob_conta..cb_saldo
      	   where sa_corte   = @w_cortefin
      	     and sa_periodo = @w_periodofin
      	     and sa_oficina = @i_oficina_consolida
             and sa_cuenta  = @i_cuenta
             and sa_empresa = @i_empresa
       end
    else       
       begin
   --       print 'corte historico'
          select @w_saldo_ini = isnull(sum(hi_saldo),0),
                 @w_debito_ini = isnull(sum(hi_debito),0),
                 @w_credito_ini = isnull(sum(hi_credito),0)
            from cob_conta_his..cb_hist_saldo, cob_conta..cb_aso_oficonsol
           where ao_oficina_consolida  = @i_oficina_consolida
             and ao_cod_declaracion    = @i_cod_declaracion
             and hi_corte   = @w_corteini
             and hi_periodo = @w_periodoini
             and hi_oficina = ao_oficina_asociada
             and hi_cuenta  = @i_cuenta
             and hi_empresa = @i_empresa
      
          select @w_saldo_fin = isnull(sum(hi_saldo),0),
                 @w_debito = isnull(sum(hi_debito),0),
                 @w_credito = isnull(sum(hi_credito),0)
            from cob_conta_his..cb_hist_saldo, cob_conta..cb_aso_oficonsol
           where ao_oficina_consolida  = @i_oficina_consolida
             and ao_cod_declaracion    = @i_cod_declaracion
             and hi_corte   = @w_cortefin
             and hi_periodo = @w_periodofin
             and hi_oficina = ao_oficina_asociada
             and hi_cuenta  = @i_cuenta
             and hi_empresa = @i_empresa
       end

    -- MOVIMIENTO NETO
    select @w_movneto = @w_saldo_fin - @w_saldo_ini

--    print 'categoria %1! saldo %2!',@w_categoria,@w_saldo_fin
    if @w_categoria = 'D'
    -- envio a excel
        select @w_saldo_ini,@w_debito-@w_debito_ini,@w_credito-@w_credito_ini,@w_movneto,@w_saldo_fin
    else
        select (@w_saldo_ini*-1),(@w_debito_ini-@w_debito),(@w_credito_ini-@w_credito),(@w_movneto*-1),(@w_saldo_fin*-1)

End

/*******************************************************************************/
/*	Consulta de catalogo de impuestos para fron-end asociacion de oficinas */
/*******************************************************************************/

if @i_operacion = 'T'
Begin
  select a.valor
    from cobis..cl_catalogo a
   where a.tabla = (select b.codigo 
                      from cobis..cl_tabla b
                     where tabla = @i_tabla)
     and a.codigo = @i_codcatalogos

     if @@rowcount = 0
	begin
	    exec cobis..sp_cerror
 	  		@t_debug = @t_debug,
	   	    	@t_file  = @t_file,
	    	    	@t_from  = @w_sp_name,
	     		@i_num   = 601159
	    return 1
	end    
End

if @i_operacion = 'U'
begin
    /* Verificar que si existe el registro de la oficina pagadora que se va a modificar */
    if exists(select of_oficina_consolida
                from cob_conta..cb_ofpagadora
               where of_oficina_consolida = @i_oficina_consolida
                 and of_cod_declaracion   = @i_cod_declaracion
                 )
    BEGIN
    BEGIN TRAN
              update cob_conta..cb_ofpagadora
	             set of_valadxofi     = @i_valadxofi,
                         of_icareteica    = @i_icareteica,
                         of_vlabomberil   = @i_vlabomberil,
                         of_fpagobomberil = @i_fpagobomberil,
                         of_porbomberil   = @i_porbomberil,
                         of_cuenta        = @i_cuenta
                from cob_conta..cb_ofpagadora
               where of_oficina_consolida = @i_oficina_consolida
                 and of_cod_declaracion   = @i_cod_declaracion
             if @@error <> 0
	        begin
		   /* 'Error al modificar informacion de la oficina pagadora' */
		   exec cobis..sp_cerror
		       @t_debug = @t_debug,
		       @t_file	 = @t_file,
		       @t_from	 = @w_sp_name,
		       @i_num	 = 609309
		       ROLLBACK TRAN
		       return 1
             	end
    COMMIT TRAN
    END
end

/*** FIN DEL SP ***/
return 0
go
