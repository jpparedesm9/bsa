/************************************************************************/
/*      Archivo:                sp_cucdt.sp                             */
/*      Stored procedure:       sp_custodia_cdt                         */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Credito                                 */
/*      Disenado por:           JLatorre                                */
/*      Fecha de escritura:     Marzo 2002                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA"							*/
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Generar el cargue automatico de cdts como garantia idonea       */
/************************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = "sp_custodia_cdt")
   drop proc sp_custodia_cdt 
go




create proc sp_custodia_cdt (
   @s_ssn                int          = null,   @s_date               datetime     = null,
   @s_user               login        = null,   @s_term               varchar(64)  = null,
   @s_corr               char(1)      = null,   @s_ssn_corr           int          = null,
   @s_ofi                smallint     = null,   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,   @t_rty                char(1)      = null,
   @t_from               varchar(30)  = null,   @t_trn                smallint     = null,
   @i_operacion          char(1)      = null,   @i_modo               smallint     = null,
   @i_filial             tinyint      = null,   @i_sucursal           smallint     = null,
   @i_tipo               varchar(64)  = null,   @i_custodia           int          = null,
   @i_propuesta          int          = null,   @i_estado             catalogo     = null,
   @i_fecha_ingreso      datetime     = null,   @i_valor_inicial      float        = null,
   @i_valor_actual       float        = null,   @i_moneda             tinyint      = null,
   @i_garante            int          = null,   @i_instruccion        varchar(255) = null,
   @i_descripcion        varchar(255) = null,   @i_poliza             varchar( 20) = null,
   @i_inspeccionar       char(  1)    = null,   @i_motivo_noinsp      catalogo     = null,
   @i_suficiencia_legal  char(1)      = null,   @i_fuente_valor       catalogo     = null,
   @i_situacion          char(  1)    = null,   @i_almacenera         smallint     = null,
   @i_aseguradora        varchar(20)  = null,   @i_tipo_cta           varchar(8)   = null, -- null
   @i_cta_inspeccion     ctacliente   = null,   @i_direccion_prenda   varchar(255) = null,      --NVR-BE
   @i_ciudad_prenda      int          = null,   @i_telefono_prenda    varchar( 20) = null,
   @i_mex_prx_inspec     tinyint      = null,   @i_fecha_modif        datetime     = null,
   @i_fecha_const        datetime     = null,   @i_porcentaje_valor   float        = null,
   @i_formato_fecha      int          = null,   @i_periodicidad   	 catalogo     = null,
   @i_depositario   	 varchar(255) = null,   @i_posee_poliza	 char(1)      = null,
   @i_cobranza_judicial	 char(1)      = null,   @i_fecha_retiro	 datetime     = null, --NULL
   @i_fecha_devolucion   datetime     = null,   @i_estado_poliza      char(1)      = null, --NULL
   @i_cobrar_comision    char(1)      = null,   @i_cuenta_dpf         varchar(30)  = null,--NULL
   @i_abierta_cerrada    char(1)      = null,   @i_adecuada_noadec    char(1)      = null,
   @i_propietario        varchar(64)  = null,   @i_plazo_fijo         varchar(30)  = null,
   @i_monto_pfijo        money        = null,   @i_oficina_contabiliza smallint  = null,
   @i_compartida         char(1)      = null,   @i_valor_compartida   money        = null,
   @i_valor_cobertura    float        = null,   @i_num_acciones	 int        = null,		
   @i_valor_accion 	 money        = null,   @i_vlr_cuantia          money      = null,
   @i_ubicacion		   catalogo   = null,   --@i_entidad		   int        = null,	--NVR-BE
   @i_porcentaje_comp	   float      = null,   @i_cuantia		   char(1)    = null,  	--NVR-BE
   @i_num_dcto		   varchar(14)= null,   @i_valor_refer_comis	   money      = null,	--NVR-BE
   @i_entidad_esp	   catalogo   = null,   @i_fecha_desde	   datetime   = null,	--NVR-BE
   @i_fecha_hasta	   datetime   = null,   @i_fec_impred	   datetime   = null, 
   @i_directo              char(1)    = null,   @i_licencia             varchar(20)= null,	--NVR1
   @i_fecha_vcto           datetime   = null,   @i_fecha_aval           datetime   = null,   /*XVE*/   
   @i_fec_venci            datetime   = null,   @i_porcentaje_cobertura float      = null,   /*XVE may 13/99*/ 
   @i_valor_cuantia        money      = null,   @i_entidad_emisora      int        = null,
   @i_fuente_valor_accion  catalogo   = null,   @i_fecha_accion         datetime   = null, 
   @i_valor_comision       money      = null,   @o_num_banco            varchar(30)= null out,
   @o_cuenta_dpf           varchar(30)= null out,
   @i_grado_gar		   catalogo   = null,   @i_provisiona           char       = null,
   @i_fnro_documento       varchar(16)= null,   @i_fvalor_bruto         money      = null,
   @i_fanticipos           money      = null,   @i_fpor_impuestos       float      = null,
   @i_fpor_retencion       float      = null,   @i_fvalor_neto          money      = null,
   @i_ffecha_emision       datetime   = null,   @i_ffecha_vtodoc        datetime   = null,
   @i_ffecha_inineg        datetime   = null,   @i_ffecha_vtoneg        datetime   = null,
   @i_ffecha_pago          datetime   = null,   @i_fbase_calculo        catalogo   = null,
   @i_fdias_negocio        int        = null,   @i_fnum_dex             varchar(16)= null,
   @i_ffecha_dex           datetime   = null,   @i_fproveedor           int        = null,
   @i_fcomprador           int        = null,   @i_fresp_pago           int        = null,
   @i_fresp_dscto          int        = null,   @i_ftasa                float      = null,
   @i_disponible           float      = null,   @i_codigo_externo       varchar    = null,
   @i_siniestro            char(1)    = null,   @i_castigo              char(1)    = null,
   @i_codigo_compuesto	   varchar(64)  = null, @i_agotada              char(1)    = null,
   -- valores de clientes
   @i_codigo_migrar        float         = null,   @i_en_tipo_cedp          catalogo  = null,
   @i_garantizado1         varchar(30)   = null,   @i_en_tipo_ced1          catalogo  = null,
   @i_garantizado2         varchar(30)   = null,   @i_en_tipo_ced2         catalogo  = null,
   @i_garantizado3         varchar(30)   = null,   @i_en_tipo_ced3          catalogo  = null,
   @i_tramite              int           = null,   @i_opbanco               varchar(24) = null,
   @i_clase_gar            varchar(20)
)
as
declare
   @w_today              datetime,     /* fecha del dia */    
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo               varchar(64),
   @w_custodia           int,
   @w_propuesta          int,      -- no se utiliza, sirve para
   @w_num_inspecc        tinyint,  -- numero de inspecciones
   @w_estado             catalogo,
   @w_fecha_ingreso      datetime,
   @w_valor_inicial      float,
   @w_valor_actual       float,
   @w_moneda             tinyint,
   @w_garante            int,
   @w_codoficial         int,
   @w_instruccion        varchar(255),
   @w_descripcion        varchar(255),
   @w_poliza             varchar( 20),
   @w_inspeccionar       char(  1),
   @w_fuente_valor       catalogo,
   @w_situacion          char(  1),
   @w_almacenera         smallint,
   @w_aseguradora        varchar( 20),
   @w_cta_inspeccion     ctacliente,
-- @w_direccion_prenda   varchar(64),
   @w_direccion_prenda   varchar(255),	--NVR-BE
-- @w_ciudad_prenda      varchar(64),
   @w_ciudad_prenda      int,
   @w_telefono_prenda    varchar(20),
   @w_mex_prx_inspec     tinyint,
   @w_fecha_modif        datetime,
   @w_fecha_const        datetime,
   @w_porcentaje_valor   float,
   @w_suficiencia_legal  char(1),
   @w_motivo_noinsp      catalogo,
   @w_des_est_custodia   varchar(64),
   @w_des_fuente_valor   varchar(64),
   @w_des_motivo_noinsp  varchar(20), 
   @w_des_inspeccionar   varchar(64),
   @w_des_tipo           varchar(64),
   @w_des_moneda         varchar(30),
   @w_periodicidad  	 catalogo,
   @w_des_periodicidad	 catalogo,
   @w_depositario    	 varchar(255),
   @w_estado_aux         catalogo,
   @w_posee_poliza	 char(1),
   @w_des_garante        varchar(64),
   @w_des_almacenera	 varchar(64),
   @w_des_aseguradora 	 varchar(64),
   @w_valor_intervalo    tinyint,
   @w_error		 int,
   @w_cobranza_judicial  char(1),
   @w_contabilizar       char(1),
   @w_fecha_retiro       datetime, 
   @w_fecha_devolucion   datetime,
   @w_fecha_modificacion datetime,
   @w_usuario_crea	 login,
   @w_usuario_modifica	 login,
   @w_estado_poliza      char(1),
   @w_des_estado_poliza  varchar(64),
   @w_cobrar_comision    char(1),
   @w_abr_cer            char(1),
   @w_status		 int,
   @w_perfil		 varchar(10),
   @w_tipo_cta		 varchar(8),
   @w_abierta_aux        char(1),
   @w_valor_conta        money,
   @w_cuenta_dpf         varchar(30),
   @w_cliente            int,
   @w_des_cliente        varchar(64),
   @w_nro_cliente        tinyint,
   @w_ente               int,
   @w_codigo_externo     varchar(64),
   @w_abierta_cerrada    char(1),
   @w_riesgos            char(1),
   @w_adecuada_noadec    char(1),
   @w_oficial            varchar(64),
   @w_propietario        varchar(64),
   @w_fsalida_colateral  datetime,
   @w_fretorno_colateral datetime,
   @w_plazo_fijo         varchar(30),
   @w_monto_pfijo        money,
-- @w_oficina            tinyint,
   @w_oficina            int,
-- @w_oficina_contabiliza smallint,
   @w_oficina_contabiliza int,
   @w_des_oficina        varchar(64),
   @w_compartida         char(1),
   @w_valor_compartida   money,
   @w_fecha_avaluo       datetime,  /*XVE YA EXISTE; NO SE CREA  CORFINSURA*/ 
   @w_fecha_reg          datetime,
   @w_fecha_prox_insp    datetime,
   @w_contabiliza        char(1) ,
   @w_perfil1            char(1) ,
   @w_sector             char(1), 
   @w_valor_cobertura    float,		
   @w_num_acciones	 int,		
   @w_valor_accion	 money,		
   @w_aux                char(30) ,
   @w_des_adecuada       descripcion,    
   @w_des_grado	         descripcion,    
   @w_cuenta_inspeccion  ctacliente ,
   @w_ubicacion		 catalogo,	--NVR-BE
   @w_des_ubicacion	 varchar(64),   --NVR-BE
   @w_tipogarante	 catalogo,	--NVR-BE
   @w_des_tipogarante	 varchar(64),   --NVR-BE
   @w_des_entidad	 varchar(64),   --NVR-BE
   @w_des_entidad_esp	 varchar(64),   --NVR-BE
   @w_entidad		 int,           --NVR-BE
   @w_fecha_comp	 datetime,	--NVR-BE
   @w_grado_comp 	 tinyint,	--NVR-BE
   @w_grado_gar 	 catalogo,
   @w_porcentaje_comp	 float,		--NVR-BE
   @w_cuantia		 char(1),	--NVR-BE
   @w_vlr_cuantia	 money,		--NVR-BE
   @w_num_dcto		 varchar(13),	--NVR-BE
   @w_valor_refer_comis	 money,		--NVR-BE
   @w_entidad_esp	 varchar(10),	--NVR-BE
   @w_fecha_desde	 datetime,	--NVR-BE
   @w_fecha_hasta	 datetime,	--NVR-BE
   @w_fec_impred	 datetime,
   @w_secservicio        int,           --LAL-BE
   @w_directo            char(1),       --BE
   @w_des_ciudad_prenda  varchar(64),	--NVR-BE
   @w_licencia		 varchar(20),   --NVR1
   @w_fecha_vcto	 datetime,	--NVR1
   @w_fec_venci          datetime,       /*XVE may 12/99*/   
   @w_fecha_aval         datetime,       /*XVE avaluo*/
   @w_porcentaje_cobertura   float,        /*XVE may 13/99*/ 
   @w_entidad_emisora    int,
   @w_fuente_valor_emisora   catalogo,  
   @w_desc_entidad_emisora  descripcion,
   @w_desc_fuente_emisora   descripcion,
   @w_fecha_accion       datetime,
   @w_gquir              varchar(64),
   @w_valor_comision     money,
   @w_recupera           float,
   @w_dif_valor			money,  --XTA 057AGO/1999 para registrar cambio de valor
   @w_debcred		char(1),
   @w_nuevo_comercial	money,
   @w_jre		char(2),
   @w_t_garante         char(1),
   @w_n_garante         descripcion,
   @w_provisiona        char,
   @w_fnro_documento    varchar(16),
   @w_fvalor_bruto      money,
   @w_fanticipos        money,
   @w_fpor_impuestos    float,
   @w_fpor_retencion       float,
   @w_fvalor_neto          money,
   @w_ffecha_emision       datetime,
   @w_ffecha_vtodoc        datetime,
   @w_ffecha_inineg        datetime,
   @w_ffecha_vtoneg        datetime,
   @w_ffecha_pago          datetime,
   @w_fbase_calculo        catalogo,
   @w_fdias_negocio        int,
   @w_fnum_dex             varchar(16),
   @w_ffecha_dex           datetime,
   @w_fproveedor           int,
   @w_fcomprador           int,
   @w_fresp_pago           int,
   @w_fresp_dscto          int,
   @w_ftasa                float,
   @w_des_base_calculo     catalogo,
   @w_nom_proveedor        varchar(64),
   @w_nom_comprador        varchar(64),
   @w_nom_pago             varchar(64),
   @w_nom_descuento        varchar(64),
   @w_tipo_superior        varchar(64),
   @w_siniestro            char(1),
   @w_castigo              char(1),
   @w_agotada              char(1),
   @w_en_ente              int,
   @w_en_oficial           int,
   @w_enced_ruc            varchar(30),
   @w_en_nomlar            descripcion,
   @w_tiene_gar              int,
   --- tabla cdt migrados
   @w_cc_operacion     varchar(24),
   @w_cc_id            varchar(14),
   @w_cc_tipoid        char(2),
   @w_cc_status        char(1),
   @w_cc_operarcioncar varchar(14),
   @w_rowcount         int,
   @w_msg			   varchar(132)
        
   

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_custodia'
/***********************************************************/

-- exec @w_secservicio = sp_gen_sec
/* Chequeo de Existencias */
/**************************/
if @i_operacion is not null or @i_operacion <> ""
begin
   if @i_periodicidad = '1' /* Mensual */
      select @w_valor_intervalo = 1, @w_num_inspecc = 12
   if @i_periodicidad = '2' /* Bimensual */
      select @w_valor_intervalo = 2, @w_num_inspecc = 6
   if @i_periodicidad = '3' /* Trimestral */
      select @w_valor_intervalo = 3, @w_num_inspecc = 4
   if @i_periodicidad = '6' /* Semestral */
      select @w_valor_intervalo = 6, @w_num_inspecc = 2
   if @i_periodicidad = '12' /* Anual */
      select @w_valor_intervalo = 12, @w_num_inspecc = 1
   if @i_periodicidad = '24' /* 2 Anios */
      select @w_valor_intervalo = 24
   if @i_periodicidad = '36' /* 3 Anios */
      select @w_valor_intervalo = 36
    /* Si se trata del codigo compuesto, dividirlo */ 
        
   if exists (select *   
              from cob_custodia..cu_custodia
              where 
              cu_filial   = @i_filial and
              cu_sucursal = @i_sucursal and
              cu_tipo     = @i_tipo and
              cu_custodia = @i_custodia)
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'P'
begin
   if @i_filial is NULL or @i_sucursal is NULL or @i_tipo is NULL 
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
end


/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
    /* Registro ya existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1 
   end

   begin tran -- inicio de la transaccion
    
      -- tomar el secuencial
    
      select @w_custodia = null
        
      select @w_custodia = isnull(max(se_actual),0) +1
      from cu_seqnos
      where se_filial = @i_filial
      and se_sucursal = @i_sucursal        
      and se_tipo_cust = @i_tipo

      if @w_custodia = 1
      begin
         insert into cu_seqnos values
         (@i_filial,@i_sucursal,@i_tipo,1)
          select @w_custodia = 1
      end
      else
          update cu_seqnos
            set se_actual = se_actual + 1
          where se_filial    = @i_filial
            and se_sucursal  = @i_sucursal
            and se_tipo_cust = @i_tipo       
        
      if @i_periodicidad is not null

         select @w_fecha_prox_insp = dateadd(mm,@w_valor_intervalo,@s_date)

      if @i_estado = 'C'  --Estado Cancelado
      begin
      /* Registro ya existe */
         select @w_error = 20040 --Registro anulado por estado de la custodia
		 select @w_msg = 'Registro anulado por estado de la custodia'			
		 rollback tran 
		 goto ERROR
      end

      if @i_estado = 'A'  --Estado Anulado
      begin
        /* Registro ya existe */
		 select @w_error = 20040 --Registro anulado por estado de la custodia
		 select @w_msg = 'Registro anulado por estado de la custodia'			
		 rollback tran 
		 goto ERROR
      end

      select @w_custodia
      -- CODIGO EXTERNO

      exec @w_retorno = sp_externo 
      @i_filial,@i_sucursal,
      @i_tipo,
      @w_custodia,
      @w_codigo_externo out

      SELECT @w_codigo_externo

      if @w_retorno = 1
      begin 
         select @w_error = 20010 --No existe codigo externo
		 select @w_msg = 'No existe codigo externo'			
		 rollback tran 
		 goto ERROR
      end

      exec @w_secservicio = sp_gen_sec @i_garantia = @w_codigo_externo
      
      SELECT @w_secservicio

      select @w_contabilizar = tc_contabilizar
        from cu_tipo_custodia
       where tc_tipo = @i_tipo

      if @w_contabilizar = 'N' and @i_estado = 'C'
      begin
        /* Registro ya existe */
         select @w_error = 20040 --Registro anulado por estado de la contablidad
		 select @w_msg = 'Registro anulado por estado de la contablidad'			
		 rollback tran 
		 goto ERROR 
      end


      if @i_cuantia = 'D' and @i_compartida = 'N'
          select @i_valor_actual = @i_valor_cuantia

      if @i_cuantia = 'I' and @i_compartida = 'N'
          select @i_valor_actual = @i_valor_inicial 

      --- VALIDACION DE LA OFICINA ---
 
      IF  @s_ofi is null
         SELECT @s_ofi = 1,
         @i_oficina_contabiliza = 1
  
          --  valida la ciudad de la oficina  --
      
      select @i_ciudad_prenda = of_ciudad
      from cobis..cl_oficina
      where of_oficina = @s_ofi
      select @i_fecha_ingreso = @s_date      
      set transaction isolation level read uncommitted

      insert into cu_custodia(
      cu_filial,       cu_sucursal, 
      cu_tipo,      cu_custodia, 
      cu_propuesta,       cu_estado,
      cu_fecha_ingreso,       cu_valor_inicial, 
      cu_valor_actual,      cu_moneda, cu_garante, cu_instruccion,
      cu_descripcion, cu_poliza, cu_inspeccionar,
      cu_motivo_noinsp, cu_suficiencia_legal, cu_fuente_valor,
      cu_situacion, cu_almacenera, cu_aseguradora,
      cu_cta_inspeccion, cu_direccion_prenda, cu_ciudad_prenda,
      cu_telefono_prenda, cu_mex_prx_inspec, cu_fecha_const,
      cu_porcentaje_valor, cu_periodicidad, cu_depositario,
      cu_posee_poliza, cu_nro_inspecciones, cu_intervalo,
      cu_cobranza_judicial, cu_fecha_retiro, cu_fecha_devolucion,
      cu_fecha_modificacion, cu_usuario_crea, cu_usuario_modifica,
      cu_estado_poliza, cu_cobrar_comision, cu_cuenta_dpf,
      cu_codigo_externo, cu_fecha_insp,  cu_abierta_cerrada,
      cu_adecuada_noadec, cu_propietario, cu_plazo_fijo,
      cu_monto_pfijo, cu_oficina, cu_oficina_contabiliza,
      cu_compartida, cu_valor_compartida, cu_fecha_reg,/*F, REG. GAR*/
      cu_fecha_prox_insp, cu_valor_cobertura,	cu_num_acciones,	
      cu_valor_accion, cu_ubicacion, 
      -- MVI 01/06/99 cu_entidad,cu_fecha_comp, cu_grado_comp, 
      cu_porcentaje_comp,
      cu_cuantia, cu_vlr_cuantia, cu_num_dcto,
      cu_valor_refer_comis, cu_entidad_esp, cu_fecha_desde,
      cu_fecha_hasta, cu_fecha_impred, cu_clase_cartera,
      cu_tipo_cta, cu_licencia, cu_fecha_vcto, 
      cu_fecha_vencimiento, cu_porcentaje_cobertura,cu_fecha_avaluo,
      cu_entidad_emisora, cu_fuente_valor_accion, cu_fecha_accion,
      cu_valor_comision, cu_grado_gar, cu_provisiona,
      cu_fnro_documento, cu_fvalor_bruto, cu_fanticipos,
      cu_fpor_impuestos, cu_fpor_retencion, cu_fvalor_neto,
      cu_ffecha_emision, cu_ffecha_vtodoc, cu_ffecha_inineg,
      cu_ffecha_vtoneg, cu_ffecha_pago, cu_fbase_calculo,
      cu_fdias_negocio, cu_fnum_dex, cu_ffecha_dex,
      cu_fproveedor, cu_fcomprador, cu_fresp_pago,
      cu_fresp_dscto, cu_ftasa, cu_disponible,cu_siniestro,cu_castigo,
      cu_agotada,cu_clase_custodia)
      values (
      @i_filial, @i_sucursal, @i_tipo,
      @w_custodia, @i_propuesta,    @i_estado,
      @i_fecha_ingreso, @i_valor_inicial, @i_valor_actual,
      @i_moneda, @i_garante, @i_instruccion,
      @i_descripcion, @i_poliza, @i_inspeccionar,
      @i_motivo_noinsp, @i_suficiencia_legal, @i_fuente_valor,
      @i_situacion, @i_almacenera, @i_aseguradora,
      @i_cta_inspeccion, @i_direccion_prenda, @i_ciudad_prenda,
      @i_telefono_prenda, @i_mex_prx_inspec, @i_fecha_const,
      @i_porcentaje_valor, @i_periodicidad, @i_depositario,
      @i_posee_poliza, 0, @w_valor_intervalo,
      @i_cobranza_judicial, @i_fecha_retiro, @i_fecha_devolucion,
      NULL, @s_user, NULL,
      @i_estado_poliza, @i_cobrar_comision, @i_cuenta_dpf,
      @w_codigo_externo, @s_date,substring(@i_abierta_cerrada,1,1),
      @i_adecuada_noadec, @i_propietario, @i_plazo_fijo,
      @i_monto_pfijo, @s_ofi, @i_oficina_contabiliza,
      @i_compartida, @i_valor_compartida, @s_date,
      @w_fecha_prox_insp, @i_valor_actual,	@i_num_acciones,	
      @i_valor_accion, @i_ubicacion, 
      -- MVI 01/06/99 @i_entidad,@i_fecha_comp, @i_grado_comp, 
      @i_porcentaje_comp,
      @i_cuantia, @i_vlr_cuantia, @i_num_dcto,
      @i_valor_refer_comis, @i_entidad_esp, @i_fecha_desde,
      @i_fecha_hasta, @i_fec_impred, @i_directo,
      @i_tipo_cta, @i_licencia, @i_fecha_vcto, 
      @i_fec_venci, @i_porcentaje_cobertura,@i_fecha_aval,
      @i_entidad_emisora, @i_fuente_valor_accion, @i_fecha_accion,
      @i_valor_comision, @i_grado_gar, @i_provisiona,
      @i_fnro_documento, @i_fvalor_bruto, @i_fanticipos,
      @i_fpor_impuestos, @i_fpor_retencion, @i_fvalor_neto,
      @i_ffecha_emision, @i_ffecha_vtodoc, @i_ffecha_inineg,
      @i_ffecha_vtoneg, @i_ffecha_pago,
      @i_fbase_calculo, @i_fdias_negocio, @i_fnum_dex,
      @i_ffecha_dex, @i_fproveedor, @i_fcomprador,
      @i_fresp_pago, @i_fresp_dscto, @i_ftasa,  @i_disponible,@i_siniestro,
      @i_castigo,@i_agotada,substring(@i_clase_gar,1,1)) 

      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         select @w_error = 20001 --No se pudo crear la garantia
		 select @w_msg = 'No se pudo crear la garantia'			
		 rollback tran 
		 goto ERROR  
      end

     -- verificar 
     if exists (select *   
              from cob_custodia..cu_custodia
              where 
              cu_filial   = @i_filial and
              cu_sucursal = @i_sucursal and
              cu_tipo     = @i_tipo and
              cu_codigo_externo = @w_codigo_externo)
      begin


                -- declara el cursor de clientes y operaciones  
               
               declare  cdt cursor for select 
               cc_operacion,
               cc_id,
               cc_tipoid,
               cc_status,
               cc_operarcioncar
               from cu_cliente_cdt
               where cc_operacion = @i_opbanco

                
	       open cdt
	       fetch cdt into
               @w_cc_operacion,
               @w_cc_id,
               @w_cc_tipoid,
               @w_cc_status,
               @w_cc_operarcioncar


	      while @@fetch_status = 0
	      begin
	        if (@@fetch_status = -1)
	          begin
		        select @w_error = 190020 --No se crear el cursor
				select @w_msg = 'No se crear el cursor'			
				rollback tran 
				goto ERROR   
			  end


                select @w_en_ente = en_ente, 
                       @w_en_nomlar = en_nomlar,
                       @w_en_oficial = en_oficial 
                from cobis..cl_ente 
                where en_ced_ruc = @w_cc_id
                and en_tipo_ced = @w_cc_tipoid
                select @w_rowcount = @@rowcount
	        set transaction isolation level read uncommitted

          	if @w_rowcount > 0
                begin               
                       
                   insert into cob_custodia..cu_cliente_garantia values 
          	   (@i_filial, @i_sucursal,@i_tipo,
                    @w_custodia,@w_en_ente,'D',@w_codigo_externo,
                    @w_en_oficial,null,@w_cc_status,null,@w_en_nomlar)  
	           
                   if @@error <> 0 and @w_cc_status = "P"
        	   begin           		
                        /*Error en insercion de transaccion de servicio*/ 
					select @w_error = 190020 --No se pudo ingresar el cliente asociado
					select @w_msg = 'No se pudo ingresar el cliente asociado'			
					rollback tran 
					goto ERROR   	 
         	   end
               end
 
               if substring(@i_abierta_cerrada,1,1) = "C" 
   
               begin
                  if @w_cc_operarcioncar <> ""   
                   begin
                     select @i_tramite = tr_tramite 
                     from cob_credito..cr_tramite 
                     where tr_numero_op_banco = @w_cc_operarcioncar 
                     
                     if @i_tramite not in (null,0)
                     begin
                       
                       exec cob_credito..sp_migra_garantia  
                       @s_date       = @s_date,
                       @i_tramite    = @i_tramite,
                       @i_garantia   = @w_codigo_externo,
                       @i_banco      = @w_cc_operarcioncar,
                       @i_cliente    = @w_en_ente,
                       @o_tiene_gar  = @w_tiene_gar output
                        
                       if @@error <> 0
                       begin               /*Error en insercion de transaccion de servicio*/ 
						select @w_error = 20002 --No se pudo ingresar el cliente amparado
						select @w_msg = 'No se pudo ingresar el cliente amparado'			
						rollback tran 
						goto ERROR   
                       end    
                   end
                  end
                 end
                 else                
                 begin 

                 declare tramite cursor for select 
                 op_tramite,
                 op_banco 
                 from cob_cartera..ca_operacion
                 where op_cliente =  @w_en_ente
                 and op_toperacion in (select dt_toperacion 
                                     from cob_cartera..ca_default_toperacion 
                                     where dt_naturaleza = "A")
                 
                 
                 open tramite 

                 fetch tramite into 
                 @i_tramite,
                 @w_cc_operarcioncar

                 while @@fetch_status = 0                            
                 begin
                   
                       exec cob_credito..sp_migra_garantia  
                       @s_date       = @s_date,
                       @i_tramite    = @i_tramite,
                       @i_banco      = @w_cc_operarcioncar,
                       @i_garantia   = @w_codigo_externo,
                       @i_cliente    = @w_en_ente,
                       @o_tiene_gar  = @w_tiene_gar output
                       if @@error <> 0
                       begin               /*Error en insercion de transaccion de servicio*/ 
						select @w_error = 20002 --No se pudo asociar a los tramites del cliente amparado
						select @w_msg = 'No se pudo asociar a los tramites del cliente amparado'			
						rollback tran 
						goto ERROR    
                       end    
                              
                       fetch tramite into 
                       @i_tramite,
                       @w_cc_operarcioncar

                 end
                 
                 close tramite
                 deallocate tramite
                   


                 end 

                 fetch cdt into
                 @w_cc_operacion,
                 @w_cc_id,
                 @w_cc_tipoid,
                 @w_cc_status,
                 @w_cc_operarcioncar

           end 

           close cdt
           deallocate cdt
           
    


   end  
    
   if (select count(*) from cob_custodia..cu_cliente_garantia where cg_codigo_externo = @w_codigo_externo) = 0
      begin     
                /*Error en insercion de transaccion de servicio*/ 
       		select @w_error = 20002 --No se pudo encontrar ningun cliente amparado
			select @w_msg = 'No se pudo encontrar ningun cliente amparado'			
			rollback tran 
			goto ERROR    
      end    

   if (select count(*) from cob_credito..cr_gar_propuesta where gp_garantia = @w_codigo_externo) = 0
     begin     
        exec cob_custodia..sp_vigencia
        @s_date = @s_date,
        @s_user = "crebatch",
        @s_term = "consola",
        @i_operacion  = "I",
        @i_estado_ini = "P",  
        @i_estado_fin = "F",
        @i_codigo_externo = @w_codigo_externo,
        @i_descripcion = "Cambio de estado automatico por migracion"

        if @@error <> 0
        begin   /*Error en insercion de transaccion de servicio*/ 
			select @w_error = 20002 --No se contablizar la garantia
			select @w_msg = 'No se contablizar la garantia'			
			rollback tran 
			goto ERROR     
        end    

     end    
     else
     begin

        exec cob_custodia..sp_vigencia
        @s_date = @s_date,
        @s_user = "crebatch",
        @s_term = "consola",
        @i_operacion  = "I",
        @i_estado_ini = "P",  
        @i_estado_fin = "F",
        @i_codigo_externo = @w_codigo_externo,
        @i_descripcion = "Cambio de estado automatico por migracion"

        if @@error <> 0
        begin   /*Error en insercion de transaccion de servicio*/ 
			select @w_error = 20002 --No se contablizar la garantia
			select @w_msg = 'No se contablizar la garantia'			
			rollback tran 
			goto ERROR     
        end    
 
        exec cob_custodia..sp_cambios_estado
        @s_date  = @s_date,
        @s_user  = "crebatch",
        @s_term  = "consola",
        @i_operacion = "I",
        @i_estado_ini  = "F",  
        @i_estado_fin  = "V" ,
        @i_codigo_externo = @w_codigo_externo,
        @i_descripcion = "Cambio de estado automatico por migracion",
        @i_banderafe   = " "

        if @@error <> 0
        begin   /*Error en insercion de transaccion de servicio*/ 
			select @w_error = 20002 --No se contablizar la garantia
			select @w_msg = 'No se contablizar la garantia'			
			rollback tran 
			goto ERROR     
        end    


     end       

  end

commit tran 

return 0

ERROR:
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
	    @i_msg 	  = @w_msg
   return @w_error 

go

