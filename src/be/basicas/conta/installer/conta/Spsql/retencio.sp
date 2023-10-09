/************************************************************************/
/*	Archivo: 		retencio.sp  				*/
/*	Stored procedure: 	sp_retencion				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     25-Enero-1996 				*/
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
/*	   Mantenimiento de la tabla cb_retencion                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	25/Ene/1996	M.Morales       Emision Inicial			*/
/*	05/May/1997	F.Salgado	Personalizacion CajaCoop	*/
/*					Adicion en opcion 'Q' de los    */
/*					nuevos campos de cb_retencion	*/
/*      20/Nov/1997     Sandra Robayo.  Personalizacion B.Estado        */
/*                                      insercion de nuevos campos      */
/*                                      Esto para Reteica, iva, renta   */
/*      21/Jun/1999     Fabio Cardona   Manejo de terceros desde MIS    */
/*	01/Ago/1999	Juan C. Gomez	Aumenta tamanio de campo JCG	*/
/*	20/Ene/2006	Mauricio Rincon Consulta Certif conta_historico	*/
/*	                                si sa_fecha_tran <= Fecha Depur	*/
/*      15/Jun/2006     Rafael Adames   Optimizacion - Refactorizacion  */
/************************************************************************/

use cob_conta
go
if exists (select 1 from sysobjects where name = 'sp_retencion')
    drop proc sp_retencion
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_retencion (
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
   @i_cuenta             cuenta = null,
   @i_forma		 tinyint=null,
   @i_operacion          char(1)  = null,
   @i_modo		 tinyint = 0,
   @i_codigo		 smallint = NULL,
   @i_oficina		 smallint = 255,
   @i_oficina_orig       smallint = null,
   @i_area		 smallint = 255,
   @i_comprobante	 int = NULL,
   @i_empresa		 tinyint = NULL,
   @i_asiento		 smallint = null,
   @i_ente		 int = NULL,			
   @i_tipoid		 char(2) = null,
   @i_identif		 char(13) = null,
   @i_concepto		 char(4) = '0',
   @i_fecha		 datetime = NULL,
   @i_cuenta_ini	 cuenta = NULL,
   @i_base		 float = 0,
   @i_retencion		 float = 0,
   @i_valorete           money = 0,
   @i_calculado          money = 0,
   @i_formato_fecha	 tinyint = null,
   @i_fecha_i            datetime = null,
   @i_fecha_f            datetime = null,
   @i_documento		 varchar(24) = '.',
   @i_operrete           char(1)  = null,
   @i_spid               int      = null,
   @i_ciudad             int      = null,
   @i_secuencial         numeric = null
)
as
declare
   @w_return             int,            /* valor que retorna  */
   @w_sp_name            varchar(32),    /* nombre stored proc */
   @w_existe             tinyint,        /* existe el registro */
   @w_empresa		 tinyint,
   @w_comprobante	 int,
   @w_asiento		 smallint,
   @w_identif		 char(13), --JCG
   @w_tipoid		 char(2),
   @w_ente		 int,
   @w_concepto		 char(4),
   @w_conica             char(4),
   @w_coniva             char(4),
   @w_contimbre          char(4),
   @w_base		 float,
   @w_retencion		 float,
   @w_reteiva            float,
   @w_reteica            float,
   @w_retetimbre         float,
   @w_cuenta		 cuenta,
   @w_ret_calculado      float,
   @w_iva_calculado      float,
   @w_ica_calculado      float,
   @w_timbre_calculado   float,
   @w_fecha_ini          datetime,
   @w_fecha_fin          datetime,
   @w_fecha_dep		 datetime,
   @w_spid               int,
   @w_fecha_hoy 	 smalldatetime,
   @w_conteo 		 int
   
select @w_sp_name = 'sp_retencion'

select @w_fecha_dep = pa_datetime
  from cobis..cl_parametro
 where pa_producto = 'CON'
   and pa_nemonico = 'FCHDEP'
    set transaction isolation level read uncommitted
    
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6060 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6061 and @i_operacion = 'E') or /* Existencia */
   (@t_trn <> 6062 and @i_operacion = 'Q') or /* Query de uno */
   (@t_trn <> 6062 and @i_operacion = 'X') or /* Consulta Historica*/
   (@t_trn <> 6062 and @i_operacion = 'K') or /* Query de uno */
   (@t_trn <> 6062 and @i_operacion = 'S') or /* Query de uno */
   (@t_trn <> 6062 and @i_operacion = 'V') or /* Query de uno */
   (@t_trn <> 6062 and @i_operacion = 'Z') or /* Query de uno */
   (@t_trn <> 6063 and @i_operacion = 'U') or /* Update de nombre */
   (@t_trn <> 6064 and @i_operacion = 'A') or /* Search de todos */
   (@t_trn <> 6065 and @i_operacion = 'D')    /* Eliminacion */
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end

/***
if @i_operacion = 'Q' or @i_operacion = 'X'
--   delete from tmp_siento_comp where spid = @@spid
/*
begin
create table #tran_ter(
sa_fecha_tran datetime null,
sc_comp_definit int null,
sa_asiento int null,
sa_cuenta varchar(20) null,
sa_debito money null,
sa_credito money null,
sa_debito_me money null,
sa_credito_me money null,
sa_con_rete char(4) null,
sa_con_iva char(4) null,
sa_con_ica char(4) null,
sa_con_timbre char(4) null,
sa_con_ivapagado char(4) null,
sa_base money null,
sc_digitador varchar(255) null,
sa_producto tinyint null,          
sa_comprobante int null, 
sc_automatico int null,
sc_fecha_gra datetime null,
indice numeric(6,0)   identity)
end
*/
/* Chequeo de Existencias */

/**************************/

********/


if @i_operacion <> 'A' and @i_operacion <> 'Q' and @i_operacion <> 'X'
begin
  select 
        @w_empresa = re_empresa,
	@w_comprobante = re_comprobante,
	@w_asiento = re_asiento,
        @w_identif = re_identifica,		
        @w_tipoid = re_tipo,			
	@w_ente = re_ente,
	@w_concepto = re_concepto,
        @w_coniva = re_con_iva,
        @w_conica = re_con_ica,
        @w_contimbre = re_con_timbre,
	@w_base	= re_base,
	@w_retencion = re_valret,
        @w_reteiva = re_valor_iva,
        @w_reteica = re_valor_ica,
        @w_retetimbre = re_valor_timbre,
	@w_cuenta = re_cuenta,
        @w_ret_calculado = re_retencion_calculado,
        @w_iva_calculado = re_iva_calculado,
        @w_ica_calculado = re_ica_calculado,
        @w_timbre_calculado = re_timbre_calculado
   from cob_conta..cb_retencion
  where re_empresa = @i_empresa
    and	re_comprobante = @i_comprobante
    and	re_asiento = @i_asiento 
    and re_fecha = @i_fecha
    and re_oficina_orig = @i_oficina_orig

    if @@rowcount > 0
       select @w_existe = 1
    else
       select @w_existe = 0
end

if @i_operacion = 'E'
  select @w_existe

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin

    if  @i_empresa is NULL or
	@i_comprobante is NULL or
	@i_asiento is NULL or
        @i_identif is NULL or  
        @i_cuenta is NULL or
        @i_tipoid is NULL or
        @i_oficina_orig is NULL
    begin

    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1
    end
end
/* Consulta opcion QUERY */
/* Trae todos los movimientos de un tercero */
/*************************/

if @i_operacion = 'Q'
begin
	
	select @w_fecha_hoy = convert(smalldatetime,convert(varchar,getdate(), 103),103)

        select @w_spid = @i_spid

/* Se cambio insert a modo 0 */
	if @i_modo = 0
        begin
        	
	   select @w_spid = @@spid        	
        	
           select @w_conteo = 0 
           
           delete from tmp_siento_comp where spid = @@spid
           
           delete from tmp_sasiento where spid = @@spid
           
           insert into tmp_sasiento
           select  
           sa_fecha_tran,
           sa_producto,          
           sa_comprobante, 
           sa_asiento,
           sa_cuenta,
           sa_debito,
           sa_credito,
           sa_debito_me,
           sa_credito_me,
           sa_con_rete,
           sa_con_iva,
           sa_con_ica,
           sa_con_timbre,
           sa_con_ivapagado,
           sa_base,
           @@spid,
           @w_fecha_hoy
           from  cob_conta_tercero..ct_sasiento
           where  sa_empresa = @i_empresa
           and  sa_fecha_tran >= @i_fecha_i 
           and  sa_fecha_tran <= @i_fecha_f 
           and  sa_comprobante > 0
           and  sa_cuenta = @i_cuenta_ini
           and  sa_oficina_dest  = @i_oficina
           and  sa_area_dest  = @i_area
           and  sa_ente = @i_ente
           and  sa_mayorizado = 'S'

	   insert into tmp_siento_comp
	   select            
	   sa_fecha_tran,
           sc_comp_definit,
           sa_asiento,
           sa_cuenta,
           sa_debito,
           sa_credito,
           sa_debito_me,
           sa_credito_me,
           sa_con_rete,
           sa_con_iva,
           sa_con_ica,
           sa_con_timbre,
           sa_con_ivapagado,
           sa_base,
           sc_digitador,
           sa_producto,          
           sa_comprobante, 
           sc_automatico,
           sc_fecha_gra,
	   @@spid,
	   20,
	   fecha
           from  tmp_sasiento ,cob_conta_tercero..ct_scomprobante
           where  
		spid = @@spid
           and  sa_fecha_tran  = sc_fecha_tran
           and  sa_producto    = sc_producto
	   and  sa_comprobante  = sc_comprobante
	   and  sc_empresa = @i_empresa
           order by sa_fecha_tran, sc_comp_definit, sa_asiento
  
  	   delete from tmp_sasiento where spid = @@spid 
  	   
  	   
       end 
 
       set rowcount 20
       select  
	           'FECHA' = convert(char(12),sa_fecha_tran,@i_formato_fecha),
                   'COMPROB.' = sc_comp_definit,
	           'ASIENTO' = sa_asiento,
		   'CUENTA' = sa_cuenta,
                   'DEBITO MN' = sa_debito,
                   'CREDITO MN' = sa_credito,
                   'DEBITO ME' = sa_debito_me,
                   'CREDITO ME' = sa_credito_me,
                   'RENTA' = sa_con_rete,
		   'RETEIVA' = sa_con_iva,
		   'RETEICA' = sa_con_ica,
		   'TIMBRE' = sa_con_timbre,
                   'IVA' = sa_con_ivapagado,
	           'VALOR BASE' = sa_base,
		   'USUARIO' = sc_digitador,
                   'PRODUCTO' = sa_producto,          
                   'COMP. TEMPORAL' = sa_comprobante, 
                   'TIPO COMPROBANTE' = sc_automatico,
                   'FECHA PROCESO' = convert(char(12),sc_fecha_gra,@i_formato_fecha),
                   'INDICE' =  indice,
                   'SPID' = spid
	 from  tmp_siento_comp
        where spid = @w_spid      
        order by spid, sa_fecha_tran, sc_comp_definit, sa_asiento

       if @@error <> 0
       begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 605082
  
               set rowcount 0
               return 1 
       end
	
       select @w_conteo = @w_conteo + @@rowcount
	
       delete from tmp_siento_comp where spid = @w_spid
		    
       set rowcount 0
       
       return 0
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601160
        return 1 
    end

    begin tran

        if @i_operrete = 'I'
        begin
           insert into cb_retencion(
             re_empresa,
	     re_comprobante,
             re_fecha,
	     re_asiento,
	     re_cuenta,
	     re_tipo,		
             re_identifica,	
	     re_ente,
             re_con_iva,
             re_valor_asiento,
	     re_base,
	     re_valor_iva,
             re_iva_calculado,
             re_oficina_orig)
           values (
	     @i_empresa,
	     @i_comprobante,
	     @i_fecha,
	     @i_asiento,
	     @i_cuenta,
             @i_tipoid,		
             @i_identif,	
	     @i_ente,
             @i_concepto,
             @i_retencion,
	     @i_base,
	     @i_valorete,
             @i_calculado,
             @i_oficina_orig)

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*           @i_tipoid, 	*/
/*           @i_identif,	*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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

*/
        end
        if @i_operrete = 'C'
        begin
           insert into cb_retencion(
             re_empresa,
	     re_comprobante,
             re_fecha,
	     re_asiento,
	     re_cuenta,
	     re_tipo,		
             re_identifica,	
             re_ente,
             re_con_ica,
             re_valor_asiento,
	     re_base,
	     re_valor_ica,
             re_ica_calculado,
             re_oficina_orig)
           values (
	     @i_empresa,
	     @i_comprobante,
	     @i_fecha,
	     @i_asiento,
	     @i_cuenta,
             @i_tipoid,		
             @i_identif,	
             @i_ente,
             @i_concepto,
             @i_retencion,
	     @i_base,
	     @i_valorete,
             @i_calculado,
             @i_oficina_orig)

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/

        end
        if @i_operrete = 'T'
        begin
           insert into cb_retencion(
             re_empresa,
	     re_comprobante,
             re_fecha,
	     re_asiento,
	     re_cuenta,
	     re_tipo,		
             re_identifica,	
             re_ente,
             re_con_timbre,
             re_valor_asiento,
	     re_base,
	     re_valor_timbre,
             re_timbre_calculado,
             re_oficina_orig)
           values (
	     @i_empresa,
	     @i_comprobante,
	     @i_fecha,
	     @i_asiento,
	     @i_cuenta,
             @i_tipoid,		
             @i_identif,	
             @i_ente,
             @i_concepto,
             @i_retencion,
	     @i_base,
	     @i_valorete,
             @i_calculado,
             @i_oficina_orig)

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end

        if @i_operrete = 'P' 
        begin
           insert into cb_retencion(
             re_empresa,
	     re_comprobante,
             re_fecha,
	     re_asiento,
	     re_cuenta,
	     re_tipo,		
             re_identifica,	
             re_ente,
             re_con_ivapagado,
             re_valor_asiento,
	     re_base,
	     re_valor_ivapagado,
             re_ivapagado_calculado,
             re_oficina_orig)
           values (
	     @i_empresa,
	     @i_comprobante,
	     @i_fecha,
	     @i_asiento,
	     @i_cuenta,
             @i_tipoid,		
             @i_identif,	
             @i_ente,
             @i_concepto,
             @i_retencion,
	     @i_base,
	     @i_valorete,
             @i_calculado,
             @i_oficina_orig)

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end 

        if @i_operrete = 'R' OR @i_operrete is null
        begin
           insert into cb_retencion(
             re_empresa,
	     re_comprobante,
             re_fecha,
	     re_asiento,
	     re_cuenta,
	     re_tipo,		
             re_identifica,	
	     re_ente,
             re_concepto,
             re_valor_asiento,
	     re_base,
	     re_valret,
             re_retencion_calculado,
             re_oficina_orig)
           values (
	     @i_empresa,
	     @i_comprobante,
	     @i_fecha,
	     @i_asiento,
	     @i_cuenta,
             @i_tipoid,		
             @i_identif,	
             @i_ente,
             @i_concepto,
             @i_retencion,
	     @i_base,
	     @i_valorete,
             @i_calculado,
             @i_oficina_orig)

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end

    commit tran 
    return 0
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 605082

        return 1 
    end

    begin tran
        if @i_operrete = 'I'
        begin
           update cob_conta..cb_retencion
           set re_ente = @i_ente,
	       re_identifica = @i_identif,	
	       re_tipo = @i_tipoid,		
	       re_con_iva = @i_concepto,
               re_con_ica = null,
               re_con_timbre = null,
               re_concepto = null,
	       re_base = @i_base,
	       re_cuenta = @i_cuenta,
	       re_valor_asiento = @i_retencion ,
	       re_fecha = @i_fecha,
               re_valor_iva = @i_valorete,
               re_valor_ica = null,
               re_valor_timbre = null,
               re_valret = null,
               re_iva_calculado = @i_calculado,
               re_ica_calculado = null,
               re_timbre_calculado = null,
               re_retencion_calculado = null
      	   where re_empresa = @i_empresa
    	     and re_comprobante = @i_comprobante
    	     and re_asiento = @i_asiento 
             and re_fecha = @i_fecha
             and re_oficina_orig = @i_oficina_orig

           if @@error <> 0 
           begin
             /* Error en actualizacion de registro */
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 605081
               return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
	   @w_empresa,
	   @w_comprobante,
	   @w_asiento,
/*           @w_tipoid,		*/
/*         @w_identif,		*/
           @w_ente,
           @w_coniva,
	   @w_base,
	   @w_reteiva,
	   @w_cuenta)

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

           /* Transaccion de Servicio */
           /***************************/

           insert into ts_retencion
           values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end
        if @i_operrete = 'C'
        begin
           update cob_conta..cb_retencion
           set re_ente = @i_ente,
	       re_identifica = @i_identif,	
	       re_tipo = @i_tipoid,		
	       re_con_ica = @i_concepto,
               re_con_iva = null,
               re_concepto = null,
               re_con_timbre = null,
	       re_base = @i_base,
	       re_cuenta = @i_cuenta,
	       re_valor_asiento = @i_retencion ,
	       re_fecha = @i_fecha,
               re_valor_ica = @i_valorete,
               re_valor_iva = null,
               re_valor_timbre = null,
               re_valret = null,
               re_ica_calculado = @i_calculado,
               re_iva_calculado = null,
               re_timbre_calculado = null,
               re_retencion_calculado = null
      	   where re_empresa = @i_empresa
    	     and re_comprobante = @i_comprobante
    	     and re_asiento = @i_asiento 
             and re_fecha = @i_fecha
             and re_oficina_orig = @i_oficina_orig

           if @@error <> 0 
           begin
             /* Error en actualizacion de registro */
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 605081
               return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
	   @w_empresa,
	   @w_comprobante,
	   @w_asiento,
/*         @w_tipoid,		*/
/*         @w_identif,		*/
	   @w_ente,
           @w_conica,
	   @w_base,
	   @w_reteica,
	   @w_cuenta)

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
           
           /* Transaccion de Servicio */
           /***************************/

           insert into ts_retencion
           values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end
        if @i_operrete = 'T'
        begin
           update cob_conta..cb_retencion
           set re_ente = @i_ente,
	       re_identifica = @i_identif,	
	       re_tipo = @i_tipoid,		
	       re_con_timbre = @i_concepto,
               re_con_iva = null,
               re_con_ica = null, 
               re_concepto = null,
	       re_base = @i_base,
	       re_cuenta = @i_cuenta,
	       re_valor_asiento = @i_retencion ,
	       re_fecha = @i_fecha,
               re_valor_timbre = @i_valorete,
               re_valor_ica = null,
               re_valor_iva = null,
               re_valret = null,
               re_timbre_calculado = @i_calculado,
               re_iva_calculado = null,
               re_ica_calculado = null,
               re_retencion_calculado = null
      	   where re_empresa = @i_empresa
    	     and re_comprobante = @i_comprobante
    	     and re_asiento = @i_asiento 
             and re_fecha = @i_fecha
             and re_oficina_orig = @i_oficina_orig

           if @@error <> 0 
           begin
             /* Error en actualizacion de registro */
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 605081
               return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
	   @w_empresa,
	   @w_comprobante,
	   @w_asiento,
/*         @w_tipoid,		*/
/*         @w_identif,		*/
	   @w_ente,
           @w_contimbre,
	   @w_base,
	   @w_retetimbre,
	   @w_cuenta)

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

           /* Transaccion de Servicio */
           /***************************/

           insert into ts_retencion
           values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end

        if @i_operrete = 'P'  
        begin 
           update cob_conta..cb_retencion
           set re_ente = @i_ente,
	       re_identifica = @i_identif,	
	       re_tipo = @i_tipoid,		
	       re_concepto = null,
               re_con_iva = null,
               re_con_ica = null,
               re_con_timbre = null,
               re_con_ivapagado = @i_concepto,
	       re_base = @i_base,
	       re_cuenta = @i_cuenta,
	       re_valret = null,
               re_valor_iva = null,
               re_valor_ica = null,
               re_valor_timbre = null,
               re_valor_ivapagado = @i_retencion,
	       re_fecha = @i_fecha,
               re_retencion_calculado = null,
               re_iva_calculado = null, 
               re_ica_calculado = null,
               re_timbre_calculado = null,
               re_ivapagado_calculado = @i_calculado
      	   where re_empresa = @i_empresa
    	     and re_comprobante = @i_comprobante
    	     and re_asiento = @i_asiento 
             and re_fecha = @i_fecha
             and re_oficina_orig = @i_oficina_orig

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
	   @w_empresa,
	   @w_comprobante,
	   @w_asiento,
/*         @w_tipoid,		*/
/*         @w_identif,		*/
	   @w_ente,
           @w_concepto,
	   @w_base,
	   @w_retencion,
	   @w_cuenta)

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

           /* Transaccion de Servicio */
           /***************************/

           insert into ts_retencion
           values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end

        if @i_operrete = 'R' OR @i_operrete is null
        begin
           update cob_conta..cb_retencion
           set re_ente = @i_ente,
	       re_identifica = @i_identif,		
	       re_tipo = @i_tipoid,			
	       re_concepto = @i_concepto,
               re_con_iva = null,
               re_con_ica = null,
               re_con_timbre = null,
	       re_base = @i_base,
	       re_cuenta = @i_cuenta,
	       re_valret = @i_retencion ,
               re_valor_iva = null,
               re_valor_ica = null,
               re_valor_timbre = null,
	       re_fecha = @i_fecha,
               re_retencion_calculado = @i_calculado,
               re_iva_calculado = null, 
               re_ica_calculado = null,
               re_timbre_calculado = null
      	   where re_empresa = @i_empresa
    	     and re_comprobante = @i_comprobante
    	     and re_asiento = @i_asiento 
             and re_fecha = @i_fecha
             and re_oficina_orig = @i_oficina_orig

           if @@error <> 0 
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601161
              return 1 
           end

           /* Transaccion de Servicio */
           /***************************/
/*
           insert into ts_retencion
           values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
	   @w_empresa,
	   @w_comprobante,
	   @w_asiento,
/*         @w_tipoid,		*/
/*         @w_identif,		*/
	   @w_ente,
           @w_concepto,
	   @w_base,
	   @w_retencion,
	   @w_cuenta)

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

           /* Transaccion de Servicio */
           /***************************/

           insert into ts_retencion
           values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
	   @i_empresa,
	   @i_comprobante,
	   @i_asiento,
/*         @i_tipoid,		*/
/*         @i_identif,		*/
           @i_ente,
           @i_concepto,
	   @i_base,
	   @i_retencion,
	   @i_cuenta)

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
*/
        end

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

    if @i_forma = 0
      if exists (select * from cb_comprobante
	          where co_comprobante = @i_comprobante 
		    and co_empresa = @i_empresa
                    and co_oficina_orig = @i_oficina_orig)
      begin
      /* Registro a eliminar esta relacionado con otra tabla */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 607023
          return 1 
      end

    begin tran
         delete cob_conta..cb_retencion
          where re_empresa = @i_empresa
	    and re_comprobante = @i_comprobante
	    and re_asiento = @i_asiento
            and re_fecha = @i_fecha
            and re_oficina_orig = @i_oficina_orig
                            
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
/*
         insert into ts_retencion
         values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
	 @w_empresa,
	 @w_comprobante,
	 @w_asiento,
/*       @w_tipoid,		*/
/*       @w_identif,		*/
	 @w_ente,
         @w_concepto,
	 @w_base,
	 @w_retencion,
	 @w_cuenta)

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
*/
    commit tran
    return 0
end

/* Consulta Historica  */
/* Trae Todos los Movimientos Historicos de un Tercero */
/*************************/


if @i_operacion = 'X'
begin
/* Se cambio insert a modo 0 */
	if @i_modo = 0
        begin

	   select @w_fecha_hoy = convert(smalldatetime,convert(varchar,getdate(), 103),103)        

           delete from tmp_siento_comp where spid = @@spid

           insert into tmp_siento_comp
           select  
           sa_fecha_tran,
           sc_comp_definit,
           sa_asiento,
           sa_cuenta,
           sa_debito,
           sa_credito,
           sa_debito_me,
           sa_credito_me,
           sa_con_rete,
           sa_con_iva,
           sa_con_ica,
           sa_con_timbre,
           sa_con_ivapagado,
           sa_base,
           sc_digitador,
           sa_producto,          
           sa_comprobante, 
           sc_automatico,
           sc_fecha_gra,
           @@spid,
           20,
           @w_fecha_hoy
           from  cob_conta_historico..ct_sasiento,cob_conta_historico..ct_scomprobante
           where  sa_empresa    = @i_empresa
           and  sa_fecha_tran   >= @i_fecha_i 
           and  sa_fecha_tran   <= @i_fecha_f 
           and  sa_comprobante  > 0
           and  sa_cuenta       = @i_cuenta_ini
           and  sa_oficina_dest = @i_oficina
           and  sa_area_dest    = @i_area
           and  sa_ente         = @i_ente
           and  sa_empresa      = sc_empresa
           and  sa_fecha_tran   = sc_fecha_tran
           and  sa_comprobante  = sc_comprobante
           and  sa_producto     = sc_producto
           and  sa_mayorizado   = 'S'
           order by sa_fecha_tran, sc_comp_definit, sa_asiento
           select @w_spid = @@spid

           set rowcount 20
	   select  
	           'FECHA' = convert(char(12),sa_fecha_tran,@i_formato_fecha),
                   'COMPROB.'   = sc_comp_definit,
	           'ASIENTO'    = sa_asiento,
		   'CUENTA'     = sa_cuenta,
                   'DEBITO MN'  = sa_debito,
                   'CREDITO MN' = sa_credito,
                   'DEBITO ME'  = sa_debito_me,
                   'CREDITO ME' = sa_credito_me,
                   'RENTA'      = sa_con_rete,
		   'RETEIVA'    = sa_con_iva,
		   'RETEICA'    = sa_con_ica,
		   'TIMBRE'     = sa_con_timbre,
                   'IVA'        = sa_con_ivapagado,
	           'VALOR BASE' = sa_base,
		   'USUARIO'    = sc_digitador,
                   'PRODUCTO'   = sa_producto,          
                   'COMP. TEMPORAL'   = sa_comprobante, 
                   'TIPO COMPROBANTE' = sc_automatico,
                   'FECHA PROCESO'    = convert(char(12),sc_fecha_gra,@i_formato_fecha),
                   'INDICE'     =  indice,
                   'SPID'       = spid
	     from  tmp_siento_comp
             where spid = @w_spid      
             order by spid, sa_fecha_tran, sc_comp_definit, sa_asiento

	    if @@error <> 0
	    begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 605082
  
               set rowcount 0
--               delete from tmp_siento_comp where spid = @@spid
               return 1 
	    end

            set rowcount 20
            delete from tmp_siento_comp where spid = @@spid
--            return 0
        end
	else
        begin
           set rowcount 20
	   select  

	           'FECHA'      = convert(char(12),sa_fecha_tran,@i_formato_fecha),
                   'COMPROB.'   = sc_comp_definit,
	           'ASIENTO'    = sa_asiento,
		   'CUENTA'     = sa_cuenta,
                   'DEBITO MN'  = sa_debito,
                   'CREDITO MN' = sa_credito,
                   'DEBITO ME'  = sa_debito_me,
                   'CREDITO ME' = sa_credito_me,
                   'RENTA'      = sa_con_rete,
		   'RETEIVA'    = sa_con_iva,
		   'RETEICA'    = sa_con_ica,
		   'TIMBRE'     = sa_con_timbre,
                   'IVA'        = sa_con_ivapagado,
	           'VALOR BASE' = sa_base,
		   'USUARIO'    = sc_digitador,
                   'PRODUCTO'   = sa_producto,          
                   'COMP. TEMPORAL'   = sa_comprobante, 
                   'TIPO COMPROBANTE' = sc_automatico,
                   'FECHA PROCESO'    = convert(char(12),sc_fecha_gra,@i_formato_fecha),
                   'INDICE'     =  indice,
                   'SPID'       =  spid
	            from tmp_siento_comp
	            where indice > @i_secuencial
                    and   spid   = @w_spid
                    order by indice
	    if @@error <> 0
	    begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 605082
--               delete from tmp_siento_comp where spid = @@spid
               return 1 
	    end


--            delete from tmp_siento_comp where spid = @@spid
--            return 0
      end

     set rowcount 0
     return 0
     
end




/* Consulta opcion ALL */
/***********************/

if @i_operacion = 'A'
begin
        set rowcount 20

	if @i_modo = 0
	begin
	     select 'ASIENTO'		= re_asiento,
		    'CUENTA' 		= re_cuenta,
		    'IDENTIFICACION'	= re_identifica,	
		    'TIPO ID'  		= re_tipo,		
		    'CONCEPTO'		= re_concepto,
                    'CONCEPTO IVA'      = re_con_iva,
                    'CONCEPTO ICA'      = re_con_ica,
                    'CONCEPTO TIMBRE'   = re_con_timbre,
		    'BASE'		= re_base,
                    'VALOR ASIENTO'     = re_valor_asiento,
                    'RETENCION CALC.'   = re_retencion_calculado,
                    'IVA CALCULADO'     = re_iva_calculado,
                    'ICA CALCULADO'     = re_ica_calculado,
                    'TIMBRE CALCULADO'  = re_timbre_calculado,
		    'RETENCION'		= re_valret,
                    'VALOR IVA'         = re_valor_iva,
                    'VALOR ICA'         = re_valor_ica,
                    'VALOR TIMBRE'      = re_valor_timbre,
                    'CONCEPTO PAGADO'   = re_con_ivapagado,
                    'CALCULADO PAGADO'  = re_ivapagado_calculado,
                    'VALOR PAGADO'      = re_valor_ivapagado,
		    'ENTE'      	= re_ente,
                    'DOCUMENTO'         = re_documento
	      from cob_conta..cb_retencion
	     where re_empresa = @i_empresa
	       and re_comprobante = @i_comprobante 
               and re_fecha = @i_fecha
               and re_oficina_orig = @i_oficina_orig
	     order by re_asiento

	     if @@rowcount = 0
    	     begin
               /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 609125

                set rowcount 0
                return 1 
             end

             set rowcount 0
             return 0
	end
	else 
	begin
	     select 'ASIENTO'		= re_asiento,
		    'CUENTA' 		= re_cuenta,
		    'IDENTIFICACION'	= re_identifica,		
		    'TIPO ID'  		= re_tipo,			
		    'CONCEPTO'		= re_concepto,
                    'CONCEPTO IVA'      = re_con_iva,
                    'CONCEPTO ICA'      = re_con_ica,
                    'CONCEPTO TIMBRE'   = re_con_timbre,
		    'BASE'		= re_base,
                    'VALOR ASIENTO'     = re_valor_asiento,
                    'RETENCION CALC.'   = re_retencion_calculado,
                    'IVA CALCULADO'     = re_iva_calculado,
                    'ICA CALCULADO'     = re_ica_calculado,
                    'TIMBRE CALCULADO'  = re_timbre_calculado,
		    'RETENCION'		= re_valret,
                    'VALOR IVA'         = re_valor_iva,
                    'VALOR ICA'         = re_valor_ica,
                    'VALOR TIMBRE'      = re_valor_timbre,
                    'CONCEPTO PAGADO'   = re_con_ivapagado,
                    'CALCULADO PAGADO'  = re_ivapagado_calculado,
                    'VALOR PAGADO'      = re_valor_ivapagado,
		    'ENTE'	        = re_ente,
                    'DOCUMENTO'         = re_documento
	      from cob_conta..cb_retencion
	     where re_empresa = @i_empresa
               and re_fecha = @i_fecha
	       and re_comprobante = @i_comprobante 
	       and re_asiento > @i_codigo
               and re_oficina_orig = @i_oficina_orig
	     order by re_asiento

	     if @@rowcount = 0
    	     begin
               /*No existen mas registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
                return 1 
             end
             set rowcount 0
             return 0
        end
	return 0
end   

if @i_operacion = 'S'
begin

	   select  
		   'BASE' = sum(sa_base),
		   'RETEIVA' = sum(sa_valor_iva),
		   'VALOR TRANSACCION' = sum(sa_valret),
                   'RENTA' = sum(sa_valret),
		   'VALOR IVA' = sum(sa_valor_iva),
		   'ICA' = sum(sa_valor_ica),
                   'IVA' = sum(sa_iva_retenido),
		   'TIMBRE' = sum(sa_valor_timbre)
	     from  cob_conta_tercero..ct_sasiento 
	    where  sa_empresa = @i_empresa
              and  sa_cuenta  > '0'
              and  sa_ente = @i_ente
              and  sa_fecha_tran >= @i_fecha_i 
              and  sa_fecha_tran <= @i_fecha_f 
	      and  sa_con_iva is not NULL
              and  sa_mayorizado = 'S'
end

if @i_operacion = 'V'
begin
	   select  
		   'BASE' = sum(sa_base),
		   'RETEIVA' = sum(sa_valor_iva),
		   'VALOR TRANSACCION' = sum(sa_valret),
                   'RENTA' = sum(sa_valret),
		   'VALOR IVA' = sum(sa_valor_iva),
		   'ICA' = sum(sa_valor_ica),
                   'IVA' = sum(sa_iva_retenido),
		   'TIMBRE' = sum(sa_valor_timbre)
	     from  cob_conta_tercero..ct_sasiento 
	    where  sa_empresa = @i_empresa
              and  sa_cuenta  > '0'
              and  sa_ente = @i_ente
              and  sa_fecha_tran >= @i_fecha_i 
              and  sa_fecha_tran <= @i_fecha_f 
	      and  sa_con_ica is not NULL
              and  sa_mayorizado = 'S'
end

if @i_operacion = 'K'
begin	 

create table #tempsaldos(
             cod_oficina      varchar(10)  null,
             nom_oficina  varchar(35)  null,
             des_ica      varchar(35)  null,
             comprobante  varchar(35)  null,
             x_mil        float        null,
             fecha        datetime     null,
             base         money        null,
             valorica     money        null,
             espacio1     varchar(10)  null,
             siguiente1   int          null,
             siguiente2   datetime     null,
             siguiente3   int          null,
             siguiente4   smallint     null,                          
             bimestre     int          null,
             rangobmt     datetime     null
)

   select @w_fecha_ini = @i_fecha_i,
          @w_fecha_fin = @i_fecha_f

   while (@w_fecha_ini <= @w_fecha_fin)
   begin
           insert into #tempsaldos
	   select           
                'Cod. Oficina ' = convert(varchar(5),of_oficina),
                'Nom. Oficina'  = substring(of_nombre,1,35), 
                'Des. ICA'      = convert(varchar(35),ic_descripcion),                
                'Comprob '      = convert(varchar(12),sa_producto)+'/'+convert(varchar(12),sc_comp_definit), 
                'X MIL'         = ic_porcentaje, 
                'Fecha'         = sa_fecha_tran,
                'Base'          =              
                CASE 
                      WHEN sa_debito <> 0 THEN round(sa_base,0) * -1 
           	   	   ELSE 
                           round(sa_base,0)
                       END,               
                'Valor'         =             
                CASE 
                      WHEN sa_debito <> 0 THEN round(sa_valor_ica,0) * -1 
	      	           ELSE 
                           round(sa_valor_ica,0)
                      END,                          
                'Espacio1'      = '',
                'Siguientes1'   = ic_ciudad,
                'Siguientes2'   = sa_fecha_tran,
                'Siguientes3'   = sa_comprobante,
                'Siguientes4'   = sa_asiento,                             
                'Bimestre'      = convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2)),                         
                'RangoBmt'      = convert(datetime,convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),101),101)                                                             
               from cob_sit..ct_sasiento_imp, 
                    cob_sit..ct_scomprobante_imp,
                    cobis..cl_oficina,
                    cob_conta..cb_ica,
                    cob_conta..cb_cuenta_proceso
               where sa_fecha_tran  = @w_fecha_ini
               and   sa_mayorizado  =  'S'  
               and   sa_ente        = @i_ente
               and   sa_empresa     = @i_empresa
               and   sa_cuenta      > '0'
               and   sa_comprobante > 0
               and   sa_producto    > 0
               and   sa_con_ica     is not NULL
               --and   sa_debcred     = '2'
               and   sa_con_ica     = ic_codigo       
               and   sc_producto    = sa_producto                
               and   sc_fecha_tran  = sa_fecha_tran
               and   sc_comprobante = sa_comprobante
               and   sc_empresa     = sa_empresa
               and   of_oficina     = sa_oficina_dest
               and   of_ciudad      = ic_ciudad       
               and   ic_empresa     = @i_empresa
               --and   ic_debcred     = 'C'
               and   ((ic_debcred     = 'C' and sa_credito <> 0)
                or    (ic_debcred     = 'D' and sa_debito <> 0))            
               and   ic_codigo      > '0'
               and   ic_ciudad      > 0
               and   cp_empresa     = @i_empresa
               and   cp_proceso     = 6095
               and   cp_cuenta      = sa_cuenta
               order by of_ciudad, sa_fecha_tran, sa_comprobante, sa_asiento
	select @w_fecha_ini = DATEADD(day, 1, @w_fecha_ini)
   end 

   set rowcount 20
	 
   if @i_modo = 0 
   begin   	
 	select 
             'Cod. Oficina '= cod_oficina,  
             'Nom. Oficina' = nom_oficina,  
             'Des. ICA'     = des_ica,      
             'Comprob '     = comprobante,                  
             'X MIL'        = x_mil,   
             'Fecha'        = convert(varchar, fecha,103),
             'Base'         = base,         
             'Valor'        = valorica,     
             'Espacio1'     = espacio1,    
             'Siguientes1'  = siguiente1,  
             'Siguientes2'  = convert(varchar, siguiente2,103),
             'Siguientes3'  = siguiente3,  
             'Siguientes4'  = siguiente4,  
             'Bimestre'     = bimestre,    
             'RangoBmt'     = convert(varchar, rangobmt,103)
	from #tempsaldos
	order by siguiente1,siguiente2, siguiente3, siguiente4		
   end 
   else
   begin 
        select 
             'Cod. Oficina '= cod_oficina,  
             'Nom. Oficina' = nom_oficina,  
             'Des. ICA'     = des_ica,      
             'Comprob '     = comprobante,                  
             'X MIL'        = x_mil,                
             'Fecha'        =convert(varchar, fecha,103) ,
             'Base'         = base,         
             'Valor'        = valorica,     
             'Espacio1'     = espacio1,    
             'Siguientes1'  = siguiente1,  
             'Siguientes2'  = convert(varchar, siguiente2,103),
             'Siguientes3'  = siguiente3,  
             'Siguientes4'  = siguiente4,  
             'Bimestre'     = bimestre,    
             'RangoBmt'     = convert(varchar, rangobmt,103)
	from #tempsaldos			
	where (    (siguiente1 > @i_ciudad) 
                or (siguiente1 = @i_ciudad and siguiente2  > @i_fecha) 
          	or (siguiente1 = @i_ciudad and siguiente2  = @i_fecha and siguiente3 > @i_comprobante)
          	or (siguiente1 = @i_ciudad and siguiente2  = @i_fecha and siguiente3 = @i_comprobante and siguiente4 > @i_asiento)
      	      )	
	order by siguiente1,siguiente2, siguiente3, siguiente4	

   end 

   set rowcount 0
	                                       
end

if @i_operacion = 'Z'
begin
	   select  
		   'BASE' = sum(sa_base),
		   'RETEIVA' = sum(sa_valor_iva),
		   'VALOR TRANSACCION' = sum(sa_valret),
                   'RENTA' = sum(sa_valret),
		   'VALOR IVA' = sum(sa_valor_iva),
		   'ICA' = sum(sa_valor_ica),
                   'IVA' = sum(sa_iva_retenido),
		   'TIMBRE' = sum(sa_valor_timbre)
	     from  cob_conta_tercero..ct_sasiento 
	    where  sa_empresa = @i_empresa
              and  sa_cuenta  > '0'
              and  sa_ente = @i_ente
              and  sa_fecha_tran >= @i_fecha_i 
              and  sa_fecha_tran <= @i_fecha_f 
	      and  sa_con_rete is not NULL
              and  sa_mayorizado = 'S'
end

go
