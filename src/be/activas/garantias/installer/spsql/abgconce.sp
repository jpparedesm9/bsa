/************************************************************************/
/*	Archivo: 	        abgconce.sp  			                         */
/*	Stored procedure:       sp_abg_concepto	        		             */
/*	Base de datos:  	cob_custodia				                     */
/*	Producto:               garantias               		             */
/*	Disenado por:           Rodrigo Garces                               */
/*			        Luis Alfredo Castellanos              	             */
/*	Fecha de escritura:     Junio-1995  				                 */
/*************************************************************************/
/*				IMPORTANTE				                                 */
/*	Este programa es parte de los paquetes bancarios propiedad de	     */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	         */
/*	"NCR CORPORATION".						                             */
/*	Su uso no autorizado queda expresamente prohibido asi como	         */
/*	cualquier alteracion o agregado hecho por alguno de sus		         */
/*	usuarios sin el debido consentimiento por escrito de la 	         */
/*	Presidencia Ejecutiva de MACOSA o su representante.		             */
/*				PROPOSITO				 */
/*	Este programa registra los resultados de asesorias legales       */ 
/*      realizadas por un abogado a una Garantia                         */
/*				MODIFICACIONES				 */
/*           FECHA    AUTOR	      RAZON				 */
/*	     Jun/1995 L. Castellanos  Emision Inicia                     */
/*									 */
/*************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_abg_concepto')
    drop proc sp_abg_concepto
go
create proc sp_abg_concepto (
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @w_secservicio_corr   int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_filial             tinyint  = null,
   @i_sucursal           smallint  = null,
   @w_secservicio        int      = null,
   @i_tipo_cust          descripcion  = null,
   @i_custodia           int  = null,
   @i_fecha_conce        datetime  = null,
   @i_fecha_cobro        datetime  = null,
   @i_fenvio_carta       datetime  = null,
   @i_fecha_insp         datetime  = null,
   @i_inspector          int  = null,
   @i_abogado            descripcion  = null, --emg
   @i_estado             catalogo  = null,
   @i_factura            varchar(20)  = null,
   @i_valor_fact         money  = 0,
   @i_observaciones      varchar(255)  = null,
   @i_instruccion        varchar(255)  = null,
   @i_motivo             catalogo  = null,
   @i_cond2              catalogo  = null,
   @i_cond1              catalogo  = null,
   @i_valor_avaluo       money  = null,
   @i_estado_tramite     char(1) = null,
   @i_suflegal           char(1) = null,
   @i_cobjuridico        char(1) = null,
   @i_gtiapara           char(1) = null,
   @i_periodicidad       catalogo = null,
   @i_tipo_cust1         descripcion = null,
   @i_custodia1          int = null,
   @i_custodia2          int = null,
   @i_custodia3          int = null,
   @i_fecha_conce1       datetime = null,
   @i_fecha_conce2       datetime = null,
   @i_fecha_conce3       datetime = null,
   @i_fecha_insp1        datetime = null,
   @i_fecha_insp2        datetime = null,
   @i_fecha_insp3        datetime = null,
   @i_oficial1           int = null,--emg
   @i_oficial2           int = null,--emg
   @i_formato_fecha	 int = null,  --PGA 16/06/2000
   @i_todas              char(1) = null,
   @i_cliente            int = null,
   @i_fecha_reporte      datetime = null,
   @i_lote               tinyint  = null
)
as
declare
   @w_today              datetime,      
   @w_return             int,          
   @w_sp_name            varchar(32),  
   @w_existe             tinyint,      
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo_cust          descripcion,
   @w_custodia           int,
   @w_fecha_insp         datetime,
   @w_inspector          int,
   @w_estado             catalogo,
   @w_factura            varchar( 20),
   @w_valor_fact         money,
   @w_observaciones      varchar(255),
   @w_instruccion        varchar(255),
   @w_motivo             catalogo,
   @w_valor_avaluo       money,
   @w_estado_tramite	 char(1),
   @w_abogado	         catalogo,
   @w_error 		 int,
   @w_periodicidad       catalogo,
   @w_des_periodicidad   descripcion,
   @w_des_est_inspeccion descripcion,
   @w_des_cliente        varchar(255),
   @w_des_inspector      descripcion,
   @w_des_tipo 		 descripcion,
   @w_des_tipogtia	 descripcion,
   @w_valor_actual       money,
   @w_valor_total        money,
   @w_debcred            char(1),
   @w_descripcion        descripcion,
   @w_valor_tran         money,
   @w_num_inspeccion     tinyint,
   @w_ultima_fecha       datetime,
   @w_fecha_carta        datetime,
   @w_fecha_conce        datetime,
   @w_fecha_asig         datetime, 
   @w_fecha_cobro        datetime, 
   @w_status		 int,
   @w_nombre_cliente     varchar(64),
   @w_codigo_externo     varchar(64),
   @w_nro_clientes       tinyint,
   @w_valor_intervalo    tinyint,
   @w_estado_garantia    char(1),
   @w_suflegal           char(1),
   @w_cobjuridico        char(1),
   @w_tipogtia           char(1),
   @w_valor_anterior     money,
   @w_valor              money,
   @w_fenvio_carta       datetime,
   @w_frecep_reporte     datetime,
   @w_ultimo             tinyint


--select @w_today = convert(varchar(10),getdate(),101)

if @i_formato_fecha is null 
   select @i_formato_fecha = 101


select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_abg_concepto'


/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19821 and @i_operacion = 'I') or
   (@t_trn <> 19822 and @i_operacion = 'U') or
   (@t_trn <> 19823 and @i_operacion = 'D') or
   (@t_trn <> 19824 and @i_operacion = 'V') or
   (@t_trn <> 19825 and @i_operacion = 'S') or
   (@t_trn <> 19826 and @i_operacion = 'Q') or
   (@t_trn <> 19827 and @i_operacion = 'A') or 
   (@t_trn <> 19828 and @i_operacion = 'C') or 
   (@t_trn <> 19829 and @i_operacion = 'Z') or
   (@t_trn <> 19830 and @i_operacion = 'M') or
   (@t_trn <> 19831 and @i_operacion = 'B') 
--   (@t_trn <> 19832 and @i_operacion = 'N') se va a necesitar NVR
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end
/* Chequeo de Existencias */
/**************************/



if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select 
    @w_filial = ra_filial,
    @w_sucursal = ra_sucursal,
    @w_tipo_cust = ra_tipo_cust,
    @w_custodia = ra_custodia,
    @w_fecha_conce = ra_fecha_concep,
    @w_abogado = ra_abogado,
    @w_factura = ra_factura,
    @w_valor_fact =ra_valor_fact,
    @w_observaciones = ra_informe_gral,
    @w_instruccion   = ra_concepto_final,
    @w_codigo_externo = ra_codigo_externo
    from cob_custodia..cu_resul_abg
    where ra_filial           = @i_filial 
    and ra_sucursal         = @i_sucursal 
    and ra_tipo_cust        = @i_tipo_cust 
    and ra_custodia         = @i_custodia 
    and (ra_fecha_concep     = convert(datetime,@i_fecha_conce,@i_formato_fecha) or @i_fecha_conce is null)
    and ra_abogado          = @i_abogado
    and ra_fenvio_carta     = convert(datetime,@i_fenvio_carta,@i_formato_fecha)
    and ra_lote             = @i_lote

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end
/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_filial is NULL or 
         @i_sucursal is NULL or 
         @i_tipo_cust is NULL or 
         @i_custodia is NULL or 
         @i_fecha_conce is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end
    if @i_valor_fact = 0 or @i_valor_fact is null
       select @i_estado_tramite = 'S'
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
   /* Ya existe el registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903002
      return 1 
   end
   else
   begin
   begin tran
      exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
      @w_codigo_externo out

	 /*Deja insertar otro concepto con diferente fecha*/

      insert into cu_resul_abg(
      ra_filial, ra_sucursal, ra_abogado,
      ra_fecha_recep, ra_custodia, ra_tipo_cust,
      ra_fecha_concep, ra_sufici_legal, ra_tipo_asig,
      ra_cobro_juridico, ra_fecha_cobro,ra_factura, ra_valor_fact,
      ra_informe_gral, ra_concepto_final, ra_codigo_externo,
      ra_lote, ra_estado_tramite,ra_fenvio_carta ,ra_pago)
      values (
      @i_filial, @i_sucursal, @i_abogado,
      @i_fecha_reporte, @i_custodia, @i_tipo_cust,
      @i_fecha_conce, @i_suflegal, @i_gtiapara,
      @i_cobjuridico, @i_fecha_cobro,@i_factura, @i_valor_fact,
      @i_observaciones, @i_instruccion, @w_codigo_externo,
      @i_lote,'N',@i_fenvio_carta,'N')


      if @@error <> 0 
      begin
      /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
      end
         -- INGRESA UN REGISTRO EN GASTOS ADMINISTRATIVOS

      /*select
      @w_ultimo = isnull(max(ga_gastos),0)+1
      from cob_custodia..cu_gastos
      where ga_filial    = @i_filial 
      and ga_sucursal  = @i_sucursal
      and ga_tipo_cust = @i_tipo_cust
      and ga_custodia  = @i_custodia*/
      /*exec @w_ultimo = sp_gen_sec

      insert into cu_gastos(
      ga_filial, ga_sucursal, ga_tipo_cust,
      ga_custodia, ga_gastos, ga_descripcion,
      ga_monto, ga_fecha, ga_codigo_externo)
      values (
      @i_filial, @i_sucursal, @i_tipo_cust,
      @i_custodia, @w_ultimo, @i_gtiapara,--Cancel o Constituc 
      @i_valor_fact, @i_fecha_conce, @w_codigo_externo)   */



         -- MODIFICA  VALOR EN CONTROL_DE_ABOGADOS

      if exists (select * from cu_control_abogado
                 where ca_abogado = @i_abogado )
      begin
         select
         @w_valor_anterior = isnull(ca_valor_facturado,0)
         from cu_control_abogado
         where ca_abogado    = @i_abogado

         select @w_valor_anterior = isnull(@w_valor_anterior,0)
 
         update cu_control_abogado set
         ca_valor_facturado = isnull(@w_valor_anterior,0)+
                                   isnull(@i_valor_fact,0),
         ca_frecep_reporte = @i_fecha_reporte 
         where  ca_abogado    = @i_abogado

	 if @@error <> 0 
         begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
         end



      end
      else
      begin
          /*Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903005
         return 1
      end   

        -- OBTENGO EL ESTADO DE LA GARANTIA

      select @w_estado_garantia = cu_estado
      from cu_custodia
      where cu_codigo_externo = @w_codigo_externo

     --  No se afecta nada en cu_custodia
            
       -- SE ACTUALIZA LA TABLA cu_gar_abogado 

      update cob_custodia..cu_gar_abogado
      set ga_revisado = 'S',
          ga_abogado_ant=ga_abogado_asig,
          ga_fecha_ant=ga_fecha_asig,
          ga_frecep_reporte = @i_fecha_reporte
      where  ga_filial         = @i_filial and
             ga_sucursal       = @i_sucursal and
             ga_codigo_externo = @w_codigo_externo

      if @@error <> 0 
      begin
      /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
      end


      /* Transaccion de Servicio */
      /***************************/

      exec @w_secservicio = sp_gen_sec
      @i_garantia = @w_codigo_externo


      select @w_secservicio = @w_secservicio + 1

      /*si existen  varios resultados para garantias con primera vez genera error

      insert into ts_resul_abg values (
      @w_secservicio,@t_trn,'N',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_resul_abg', @i_filial,
      @i_sucursal, @i_abogado, @i_fenvio_carta,
      @i_fecha_reporte, @i_custodia, @i_tipo_cust,
      @i_fecha_conce, @i_suflegal, @i_gtiapara,
      @i_cobjuridico, @i_fecha_cobro, @i_factura,
      @i_valor_fact, @i_observaciones, @i_instruccion,
      @w_codigo_externo )

      if @@error <> 0 
      begin
      --Error en insercion de transaccion de servicio 
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end   */
   commit tran
   return 0
   end 
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin

    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end
    else
    begin
         begin tran

         exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                         @w_codigo_externo out

         if @w_estado_tramite = 'S'
         begin
         /* No se puede modificar una inspeccion cobrada */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905011
            return 1 
        end
         
         update cob_custodia..cu_resul_abg
         set 
         ra_abogado         = @i_abogado,
         ra_factura         = @i_factura,
         ra_valor_fact      = @i_valor_fact,
         ra_informe_gral    = @i_observaciones,
         ra_concepto_final  = @i_instruccion,
         ra_codigo_externo  = @w_codigo_externo,
         ra_sufici_legal    = @i_suflegal,
         ra_fecha_concep    = @i_fecha_conce
         where ra_filial    = @i_filial
           and ra_sucursal  = @i_sucursal 
           and ra_tipo_cust = @i_tipo_cust 
           and ra_custodia  = @i_custodia
         -- ra_fecha_concep = @i_fecha_conce
           and ra_abogado   = @i_abogado
           and ra_fenvio_carta = @i_fenvio_carta
           and ra_lote         = @i_lote

        if @@error <> 0 
        begin
        /* Error en insercion de registro */
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1905001
           return 1 
        end


         -- MODIFICA LA TABLA DE GASTOS ADMINISTRATIVOS
   
        /* update cob_custodia..cu_gastos
         set 
             ga_fecha = convert(varchar(10),@s_date,101),
             ga_monto = @i_valor_fact
         where 
             ga_filial     = @i_filial and
             ga_sucursal   = @i_sucursal and
             ga_tipo_cust  = @i_tipo_cust and
             ga_custodia   = @i_custodia and
             ga_fecha      = @i_fecha_conce */

         

         /* Transaccion de Servicio */
         /***************************/
 /*
         exec @w_secservicio = sp_gen_sec
         @i_garantia = @w_codigo_externo

         insert into ts_resul_abg
         values (
         @w_secservicio,@t_trn,'P',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_resul_abg', @w_filial,
         @w_sucursal, @w_abogado, @w_fecha_carta,
         @w_fecha_reporte, @w_custodia, @w_tipo_cust,
         @w_fecha_conce, @w_suflegal, @w_gtiapara,
         @w_cobjuridico, @w_fecha_cobro, @w_factura,
         @w_valor_fact, @w_observaciones, @w_instruccion,
         @w_codigo_externo)

         if @@error <> 0 
         begin
          Error en insercion de transaccion de servicio 
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end*/


      exec @w_secservicio = sp_gen_sec
      @i_garantia = @w_codigo_externo

      select @w_secservicio = @w_secservicio + 1

      insert into ts_resul_abg 
      values (
      @w_secservicio,@t_trn,'A',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_resul_abg', @i_filial,
      @i_sucursal, @i_abogado, @i_fenvio_carta,
      @i_fecha_reporte, @i_custodia, @i_tipo_cust,
      @i_fecha_conce, @i_suflegal, @i_gtiapara,
      @i_cobjuridico, @i_fecha_cobro, @i_factura,
      @i_valor_fact, @i_observaciones, @i_instruccion,
      @w_codigo_externo )
      if @@error <> 0 
      begin
       /*Error en insercion de transaccion de servicio */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903003
          return 1 
      end
    commit tran
    return 0
    end
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
        @i_num   = 1907002
        return 1 
    end

    if @w_estado_tramite = 'S'
    begin
    /* No se puede modificar una inspeccion cobrada */
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file, 
       @t_from  = @w_sp_name,
       @i_num   = 1905011
       return 1 
    end
         
/***** Integridad Referencial *****/

    /*if exists (select * from cu_custodia
                     where cu_tipo = @i_tipo_cust
                       and cu_custodia = @i_custodia)
    begin
      select @w_error = 1907015
      goto error
    end */
 
    begin tran

       delete cob_custodia..cu_resul_abg
       where ra_filial       = @i_filial and
             ra_sucursal     = @i_sucursal and
             ra_tipo_cust    = @i_tipo_cust and
             ra_custodia     = @i_custodia and
           --ra_fecha_concep = @i_fecha_conce and 
             ra_abogado      = @i_abogado and
             ra_fenvio_carta = @i_fenvio_carta and
             ra_lote         = @i_lote 

                                      
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

         -- ELIMINA EL VALOR DEL GASTO
       
        /* delete cu_gastos
          where ga_filial = @i_filial
            and ga_sucursal = @i_sucursal
            and ga_tipo_cust = @i_tipo_cust
            and ga_custodia  = @i_custodia
            and ga_fecha     = @i_fecha_conce  */

         -- ELIMINA EL VALOR DEL CONTROL DE ABOGADOS
	--Se debe restar el vlr.de la factura, al vlr.facturado

	 select @w_valor_anterior = isnull(ca_valor_facturado,0)
         from cu_control_abogado
         where ca_abogado    = @i_abogado
         and   ca_fenvio_carta = @i_fenvio_carta
         and   ca_lote         = @i_lote

         select @w_valor_anterior = isnull(@w_valor_anterior,0) -
                                    isnull(@w_valor_fact,0)
          update cu_control_abogado
          set ca_valor_facturado = isnull(@w_valor_anterior,0)
          where  ca_abogado      = @i_abogado
            and  ca_fenvio_carta = @i_fenvio_carta
            and  ca_lote         = @i_lote

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
         end




         -- ACTUALIZO LA TABLA GARANTIAS POR ABOGADO
         -- **************************************
	  update cu_gar_abogado
          set ga_revisado = 'N'
          where ga_filial = @i_filial
          and ga_sucursal = @i_sucursal
          and ga_tipo     = @i_tipo_cust
	  and ga_custodia = @i_custodia
	  and ga_revisado = 'S'
          and ga_fenvio_carta = convert(datetime,@i_fenvio_carta)
          and ga_lote     = @i_lote
	  if @@error <> 0 
          begin
          /* Error en insercion de registro */
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1905001
           return 1 
          end


    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'

begin



   if @w_existe = 1
   begin
   
      select @w_des_tipo = tc_descripcion
      from cu_tipo_custodia 
      where tc_tipo = @w_tipo_cust
    
   /* CAMBIO LAS CONDICIONES DE LAS DOSCONSULTAS PORQUE ESTBA SOLO TIPO DE */
   /* CUST. Y CUSTODIA, NO CONSIDERABA SUCURSAL Y FILIIAL */

      select --@w_fenvio_carta   = ga_fenvio_carta,
      @w_frecep_reporte = ga_frecep_reporte
      from cu_gar_abogado
      where ga_codigo_externo = @w_codigo_externo
      and   ga_abogado_asig   = @i_abogado 
      and   ga_fenvio_carta   = convert(datetime,@i_fenvio_carta,@i_formato_fecha)
      and   ga_lote           = @i_lote


      select @w_suflegal       = ra_sufici_legal,
             @w_cobjuridico    = ra_cobro_juridico, /*es de Mod.credito*/
             @w_tipogtia       = ra_tipo_asig,
             @w_fecha_cobro    = ra_fecha_cobro
      from cu_resul_abg
      where ra_codigo_externo = @w_codigo_externo
      and   ra_abogado        = @i_abogado 
      and   ra_fenvio_carta   = convert(datetime,@i_fenvio_carta,@i_formato_fecha)
      and   ra_lote           = @i_lote

      select @w_des_tipogtia = B.valor
      from cobis..cl_tabla A, cobis..cl_catalogo B
      where B.codigo = @w_tipogtia
      and   A.tabla  = 'cu_tipo_asig'
      and   A.codigo = B.tabla
      set transaction isolation level read uncommitted

        /* CONTROL DEL NUMERO DE CLIENTES  */
 
      select @w_des_cliente = convert(varchar(10),cg_ente) + '  ' +
      cg_nombre
      from cu_cliente_garantia
      where cg_codigo_externo = @w_codigo_externo
     
      select
      @w_filial,
      @w_sucursal,
      @w_tipo_cust,
      @w_des_tipo,
      @w_custodia,
      @w_des_cliente, 
      @w_factura,
      @w_valor_fact,
      convert(char(10),@w_fecha_conce,@i_formato_fecha),
      @w_observaciones,  -- 10 
      @w_instruccion,
      convert(char(10),@i_fenvio_carta,@i_formato_fecha),
      convert(char(10),@w_frecep_reporte,@i_formato_fecha),
      @w_suflegal,
      @w_cobjuridico,
      convert(char(10),@w_fecha_cobro,@i_formato_fecha),
      @w_tipogtia,
      @w_abogado,
      @w_des_tipogtia

   end
   else
   begin
    /*Registro no existe 
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901005    -- No existen inspecciones*/


      select @w_codigo_externo = ga_codigo_externo
      from cu_gar_abogado
      where ga_filial  = @i_filial  
      and ga_sucursal = @i_sucursal
      and ga_tipo    = @i_tipo_cust
      and ga_custodia =@i_custodia

      select @w_codigo_externo
 
      return 1 
   end
   return 0
end


if @i_operacion = 'S'
begin

   set rowcount 20
   select
   "GARANTIA" = ra_custodia, 
   "TIPO" = ra_tipo_cust,
   "DESC" = tc_descripcion,
   "FECHA CONCEPTO" = convert(varchar(10),ra_fecha_concep,@i_formato_fecha),
   "ABOGADO" = ra_abogado,
   "LOTE" = ra_lote,
   "F. ENVIO CARTA" =convert(varchar(10), ra_fenvio_carta, @i_formato_fecha),
   "OFICINA" = ra_sucursal
   from cu_resul_abg,cu_custodia,cu_tipo_custodia, cu_cliente_garantia
   where (ra_filial = @i_filial) and
         --(ra_sucursal = @i_sucursal) and emg sep-6-03  
         (ra_codigo_externo = cu_codigo_externo) and
         (ra_sucursal = cu_sucursal) and
         (tc_tipo = cu_tipo) and
         (cg_codigo_externo   = cu_codigo_externo) and
          cg_principal        = 'D' and  -- pga26jun2001
         (cg_oficial >= @i_oficial1 or @i_oficial1 is null) and
         (cg_oficial <= @i_oficial2 or @i_oficial2 is null) and -- pga26jun2001
         (ra_tipo_cust like @i_tipo_cust or @i_tipo_cust is null) and
         (ra_custodia >= @i_custodia1 or @i_custodia1 is null) and
         (ra_custodia <= @i_custodia2 or @i_custodia2 is null) and
         (ra_fecha_concep >= @i_fecha_conce1 or @i_fecha_conce1 is null) and
         (ra_fecha_concep <= @i_fecha_conce2 or @i_fecha_conce2 is null) and
         (ra_abogado = @i_abogado or @i_abogado is null) and
         ((ra_tipo_cust > @i_tipo_cust1 or (ra_tipo_cust = @i_tipo_cust1
          and ra_custodia > @i_custodia3) or (ra_tipo_cust = @i_tipo_cust1
          and ra_custodia = @i_custodia3 and ra_fecha_concep >@i_fecha_conce3)) 
          or @i_custodia3 is null)
    group by ra_tipo_cust, ra_custodia, ra_fecha_concep,tc_descripcion,ra_abogado,ra_lote,ra_fenvio_carta,ra_sucursal
    order by ra_tipo_cust, ra_custodia, ra_fecha_concep,tc_descripcion,ra_abogado,ra_lote,ra_fenvio_carta,ra_sucursal
   if @@rowcount = 0
   begin
      if @i_custodia is null /* Modo 0 */
               return 1 --select @w_error  = 1901003--No Existen Reg 
            else
               return 2 --select @w_error  = 1901004  --No Existen Mas Reg
          /*  exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1 */
         end 
         return 0
end 

if @i_operacion = 'Z'
begin
      set rowcount 20
         select "GARANTIA" = ra_custodia, 
                "TIPO" = ra_tipo_cust,
                "DESC" = tc_descripcion,
                "FECHA" = convert(char(10),ra_fecha_concep,@i_formato_fecha),
                "GERENTE" = cg_oficial, --en_oficial,
                "CLIENTE" = cg_nombre
         from cu_resul_abg,cu_custodia, --cobis..cl_ente,
              cu_cliente_garantia, cu_tipo_custodia
         where (ra_filial = @i_filial) and
            (ra_sucursal = @i_sucursal) and
            (ra_codigo_externo = cu_codigo_externo) and
            (tc_tipo = cu_tipo) and
            (ra_codigo_externo = cg_codigo_externo) and
            (ra_tipo_cust like @i_tipo_cust or @i_tipo_cust is null) and
            (ra_custodia >= @i_custodia1 or @i_custodia1 is null) and
            (ra_custodia <= @i_custodia2 or @i_custodia2 is null) and
            (ra_fecha_concep >= @i_fecha_conce1
             or @i_fecha_conce1 is null) and
            (ra_fecha_concep <= @i_fecha_conce2
             or @i_fecha_conce2 is null) and
            (ra_abogado = @i_abogado or @i_abogado is null) and
            (cg_oficial >= @i_oficial1 or @i_oficial1 is null) and
            (cg_ente = @i_cliente or @i_cliente is null) and
            ((ra_tipo_cust > @i_tipo_cust1 or (ra_tipo_cust = @i_tipo_cust1
            and ra_custodia > @i_custodia3) or (ra_tipo_cust = @i_tipo_cust1
          and ra_custodia = @i_custodia3 and ra_fecha_concep >@i_fecha_conce3)) 
            or @i_custodia3 is null)
            group by ra_tipo_cust, ra_custodia, ra_fecha_concep,tc_descripcion,ra_abogado,ra_lote,ra_fenvio_carta,ra_sucursal,
                     cg_oficial, cg_nombre
            order by ra_tipo_cust, ra_custodia, ra_fecha_concep,tc_descripcion,ra_abogado,ra_lote,ra_fenvio_carta,ra_sucursal,
                     cg_oficial, cg_nombre                     
        if @@rowcount = 0
         begin
            if @i_custodia is null /* Modo 0 */
               select @w_error  = 1901003 --No Exist Reg
            else
               select @w_error  = 1901004 --No exist Mas Regs
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
         end 
         return 0
end


if @i_operacion = 'C' --Conceptos Juridicos a Cobrar 
begin
   set rowcount 20
   select distinct 
   "GARANTIA"	      = ra_custodia,
   "TIPO"	      = ra_tipo_cust,
   "FECHA"	      = convert(char(10),ra_fecha_concep,@i_formato_fecha),
   "FACTURA"          = ra_factura,
   "VALOR FACTURA"    = (ra_valor_fact - ga_valor_anticipo),
   "CLIENTE"          = cg_ente,
   "NOMBRE CLIENTE"   = cg_nombre,
   "CTA CLIENTE"      = cu_cta_inspeccion,
   "TIPO CTA CLIENTE" = cu_tipo_cta,
   "CATEGORIA" = ' ',
   "ABOGADO" = ab_abogado,	--ab_nombre,
   "CUENTA"  =ab_cuenta,
   "TIPO CTA ABOGADO" = ab_tipo_cuenta,
   "LOTE"    = ra_lote
   from cu_custodia,cu_cliente_garantia,cu_resul_abg,
   cob_credito..cr_abogado, cu_gar_abogado
   where cu_filial   = @i_filial
   and   cu_sucursal = @i_sucursal
   and   cg_principal = 'D'
   and   ra_estado_tramite <> 'S'   -- LAL PARA CONSULTAR SOLO LAS NO COBRADAS
   and   cu_codigo_externo   = cg_codigo_externo
   and   cu_codigo_externo   = ra_codigo_externo
   and   ab_abogado = ra_abogado
   and   ra_codigo_externo   = ga_codigo_externo
   and   ra_abogado = ga_abogado_asig
   and   ra_fenvio_carta = ga_fenvio_carta
   and   ra_lote         = ga_lote 
   and   ab_tipo = 'E'
   and   ra_codigo_externo > ''
   and   ra_fecha_concep is not null

   if @@rowcount = 0
   begin
     /*exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901003 */
      return 1 
   end 
      return 0
end

if @i_operacion = 'T'
begin
   select @w_valor_total = sum(isnull(ra_valor_fact,0))
   from cu_resul_abg
   where ra_abogado = @i_abogado 
end

if @i_operacion = 'M' --PENDIENTE POR PROBAR 
begin
   set rowcount 20
   
   select distinct 	
          "GARANTIA"      =ra_custodia,
          "TIPO"          =ra_tipo_cust,
          "VALOR FACTURA" =ra_valor_fact,
          "FECHA"	  =convert(char(10),ra_fecha_concep,@i_formato_fecha),
          "CLIENTE"	  =cg_ente, 
          "NOMBRE CLIENTE"=cg_nombre ,  
          "CTA CLIEN"	  =cu_cta_inspeccion,
          "TCC"	          =cu_tipo_cta,
          "ABOGADO"	  =ra_abogado,
          "NOMBRE ABOGADO"=ab_nombre ,
          "ESTADO"	  =ra_estado_tramite 
   from cu_resul_abg,
        -- cobis..cl_ente,
        cob_credito..cr_abogado,
        cu_custodia,cu_cliente_garantia
   where ra_filial         = @i_filial
     and ra_sucursal       = @i_sucursal
     and ra_estado_tramite = 'S' 
     and cu_filial         = @i_filial
     and cu_sucursal       = @i_sucursal
     and cu_tipo           = ra_tipo_cust
     and cu_custodia       = ra_custodia
     and cg_codigo_externo = cu_codigo_externo
     and cg_principal      = 'D'
     and ra_abogado        = ab_abogado
     and ra_valor_fact     <> 0
     and (((ra_tipo_cust > @i_tipo_cust) 
          or (ra_tipo_cust = @i_tipo_cust and ra_custodia > @i_custodia))
          or @i_tipo_cust is null)
     and ab_tipo = 'E'
     and ra_codigo_externo = ''
     and  ra_fecha_concep is not null

     
     if @@rowcount = 0
     begin
     /*exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901003 */
      return 1 
     end 
      return 0
end

/*AUMENTO PARA CONSULTA DE FECHA DE ENVIO CARTA LA OPE A Y V */

if @i_operacion = 'A'
begin
   set rowcount 20
   if @i_fenvio_carta is null
      select @i_fenvio_carta = convert(datetime,@i_cond2,@i_formato_fecha)
   if @i_abogado is null
      select @i_abogado = @i_cond1
   select 
   "ABOGADO" = ga_abogado_asig,
   "FECHA ENVIO CARTA" = convert(varchar(10),ga_fenvio_carta,@i_formato_fecha)
   from cu_gar_abogado
   where (ga_abogado_asig = @i_abogado or @i_abogado is null)
   and (ga_fenvio_carta > @i_fenvio_carta or @i_fenvio_carta is null)
   and ga_codigo_externo > '' 
   and ga_lote is not null  
   if @@rowcount = 0
   begin

      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1
   end
end

if @i_operacion = 'V'
begin
   if exists (select * from cu_gar_abogado
              where ga_abogado_asig = @i_abogado
              and convert(varchar(10),ga_fenvio_carta ,@i_formato_fecha) =
              convert(varchar(10),@i_fenvio_carta,@i_formato_fecha)
              and ga_codigo_externo > '' 
              and ga_lote is not null  )
      select  1 --@w_aux = @w_valor_facturado
   else
   begin

      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1
   end 
end

/* FIN DE AUMENTO*/

if @i_operacion = 'B' --Cartas enviadas por abogado  -NVR
begin
   set rowcount 20
   --print '@i_fenvio_carta:' + cast (@i_fenvio_carta as varchar)
   --print '@i_tipo_cust:' + cast(@i_tipo_cust as varchar)
   --print '@i_custodia:' + cast(@i_custodia as varchar)
   select
   "LOTE"        = ga_lote, 
   "GARANTIA"    = ga_custodia,
   "TIPO"        = ga_tipo,
   "DESCRIPCION" = tc_descripcion,
   "CLIENTE"     = cg_ente,
   "NOMBRE"      = cg_nombre,
   "TIPO.ASIG."  = ga_tipo_asig,
   "DESC.ASIG."  = C1.valor
   from cu_gar_abogado,cu_custodia,
   cu_tipo_custodia,cu_cliente_garantia,
   cobis..cl_catalogo C1, cobis..cl_tabla T1
   where  ga_filial         = @i_filial
   and  ga_sucursal       = @i_sucursal   
   and  ga_abogado_asig   = @i_abogado
   and  ga_fenvio_carta = convert(datetime,@i_fenvio_carta)
   and  ga_tipo           = tc_tipo
   and  ga_codigo_externo = cu_codigo_externo
   and  cg_codigo_externo = ga_codigo_externo
   and  cg_principal      = 'D'
   and  ga_revisado       = 'N'
   and  T1.codigo = C1.tabla
   and  T1.tabla  = 'cu_tipo_asig'
   and  C1.codigo = ga_tipo_asig
   and  ((ga_tipo = @i_tipo_cust and ga_custodia > @i_custodia) 
          or ga_tipo > @i_tipo_cust  
          or @i_tipo_cust is null)
   and ga_lote is not null
   and ga_codigo_externo > ''
        
         if @@rowcount = 0
         begin
            /*exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 1901003 */
            return 1 
         end 
         return 0
end

return 0

error:    /* Rutina que dispara sp_cerror dado el codigo de error */

             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = @w_error
             return 1 

go
