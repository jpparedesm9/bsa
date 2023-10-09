/************************************************************************/
/*	Archivo: 	        micligar.sp                             */ 
/*	Stored procedure:       sp_micligar                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Jennifer Velandia               	*/
/*	Fecha de escritura:     marzo 2003  				*/
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
/*  migra a la cu_cliente garantia las garantias que faltan             */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      marzo   2003    JENNIFER VELANDIA                               */ 
/************************************************************************/

        
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_micligar')
    drop proc sp_micligar
go
create proc sp_micligar  (
   @s_ssn                  int      = NULL,
   @s_date                 datetime = NULL,
   @s_user                 login    = NULL,
   @s_term                 descripcion = NULL,
   @s_corr                 char(1)  = NULL,
   @s_ssn_corr             int      = NULL,
   @s_ofi                  smallint  = NULL,
   @s_sesn                 int       = NULL,
   @t_rty                  char(1)  = NULL,
   @t_trn                  smallint = NULL,
   @t_debug                char(1)  = 'N',
   @t_file                 varchar(14) = NULL,
   @t_from                 varchar(30) = NULL,
   @i_archivo_gar          varchar(30) = NULL,
   @i_user                 int         = null,
   @i_usuario              login       = null,
   @i_archivo_pol          varchar(30) = NULL,
   @i_filial               tinyint     = NULL,
   @i_sucursal             smallint    = NULL,
   @i_fecha                 datetime = NULL,
   @o_archivo_cargado      char(1) = "N" out
)
as

declare
   @w_error                     int        ,
   @w_sp_name 			char(30),
   @w_msg 			varchar(255),
   @w_porcentaje                float,
   @w_filial                      tinyint,
   @w_sucursal                    smallint,
   @w_tipo                        descripcion  ,
   @w_custodia                    int          ,
   @w_propuesta                   int          ,
   @w_estado                      catalogo     ,
   @w_fecha_ingreso               datetime     ,
   @w_valor_inicial               float        ,
   @w_valor_actual                float        ,
   @w_moneda                      tinyint     ,
   @w_garante                     int        ,
   @w_instruccion                 varchar(255),            
   @w_descripcion                 varchar(255),            
   @w_poliza                      varchar(20),
   @w_inspeccionar                char       ,
   @w_motivo_noinsp               catalogo   ,
   @w_suficiencia_legal           char       ,
   @w_fuente_valor                catalogo   ,
   @w_situacion                   char       ,
   @w_almacenera                  smallint   ,
   @w_aseguradora                 varchar(20),             
   @w_cta_inspeccion              ctacliente,
   @w_tipo_cta                    varchar(8),
   @w_direccion_prenda            varchar(255),            
   @w_ciudad_prenda               int        ,
   @w_telefono_prenda             varchar(20),
   @w_mex_prx_inspec              tinyint     ,
   @w_fecha_modif                 datetime    ,
   @w_fecha_const                 datetime    ,
   @w_porcentaje_valor            float       ,
   @w_periodicidad                catalogo    ,
   @w_depositario                 varchar(255),
   @w_posee_poliza                char        ,
   @w_nro_inspecciones            tinyint     ,
   @w_intervalo                   tinyint     ,
   @w_cobranza_judicial           char        ,
   @w_fecha_retiro                datetime    ,
   @w_fecha_devolucion            datetime    ,
   @w_fecha_modificacion          datetime     ,
   @w_usuario_crea                descripcion ,
   @w_usuario_modifica            descripcion,
   @w_estado_poliza               catalogo ,
   @w_cobrar_comision             char    ,
   @w_cuenta_dpf                  varchar(30),
   @w_codigo_externo              varchar(64), 
    @w_codigo_exreico             varchar(64),             
   @w_fecha_insp                  datetime ,
   @w_abierta_cerrada             char    ,
   @w_adecuada_noadec             char   ,
   @w_propietario                 varchar(64),
   @w_plazo_fijo                  varchar(30),
   @w_monto_pfijo                 money       ,
   @w_oficina                     smallint    ,
   @w_oficina_contabiliza         smallint    ,
   @w_compartida                  char        ,
   @w_valor_compartida            money       ,
   @w_fecha_reg                   datetime    ,
   @w_fecha_prox_insp             datetime    ,
   @w_num_acciones                int         ,
   @w_valor_accion                money      ,
   @w_porcentaje_comp             float     ,
   @w_ubicacion                   catalogo ,
   @w_estado_credito              catalogo,
   @w_cuantia                     char ,
   @w_vlr_cuantia                 money,
   @w_num_dcto                    varchar(13),             
   @w_valor_refer_comis           money     ,
   @w_fecha_desde                 datetime ,
   @w_fecha_hasta                 datetime ,
   @w_fecha_impred                datetime,
   @w_clase_cartera               char  ,
   @w_acum_ajuste                 money,
   @w_autoriza                    varchar(25),
   @w_licencia                    varchar(20),
   @w_fecha_vcto                  datetime     ,
   @w_fecha_vencimiento           datetime     ,
   @w_porcentaje_cobertura        float        ,
   @w_fecha_avaluo                datetime     ,
   @w_entidad_emisora             int          ,
   @w_fuente_valor_accion         catalogo     ,
   @w_fecha_accion                datetime     ,
   @w_valor_cobertura             float        ,
   @w_entidad_esp                 catalogo     ,
   @w_valor_comision              money       ,
   @w_grado_gar                   catalogo   ,
   @w_provisiona                  char      ,
   @w_fnro_documento              varchar(16),             
   @w_fvalor_bruto                money   ,
   @w_fanticipos                  money  ,
   @w_fpor_impuestos              float ,
   @w_fpor_retencion              float ,
   @w_fvalor_neto                 money,
   @w_ffecha_emision              datetime,
   @w_ffecha_vtodoc               datetime,
   @w_ffecha_inineg               datetime,
   @w_ffecha_vtoneg               datetime,
   @w_ffecha_pago                 datetime,
   @w_fbase_calculo               catalogo,
   @w_fdias_negocio               int      ,
   @w_fnum_dex                    varchar(16),           
   @w_ffecha_dex                  datetime      ,
   @w_fproveedor                  int           ,
   @w_fcomprador                  int           ,
   @w_fresp_pago                  int           ,
   @w_fresp_dscto                 int           ,
   @w_ftasa                       float         ,
   @w_disponible                  float         ,
   @w_pago                        char          ,
   @w_siniestro                   char          ,
   @w_castigo                     char          ,
   @w_agotada                     char          ,
   @w_clase_custodia              char          ,
   @w_fecha_sol_exp               datetime     ,
   @w_fecha_apr_pre               datetime    ,
   @w_fecha_apr                   datetime   ,
   @w_num_acta_apr_pre            varchar(16),             
   @w_num_acta_apr                varchar(16),             
   @w_fecha_sol_rec               datetime      ,
   @w_fecha_sol_ren               datetime     ,
   @w_fecha_pro                   datetime    ,
   @w_clase_vehiculo              varchar(10),
   @w_secuencia                   int,
   @w_gargpe                      varchar(10),
   @w_contador                    int,
   @w_ced_ruc                     varchar(30),
   @w_tipo_ced                    char(2),
   @w_ente                        int,
   @w_factor                      smallint,
   /* tabla de cliente gar */
   @w_cfilialc		         tinyint ,	
   @w_csucursalc		 smallint,	
   @w_ctipo_custc		 descripcion,	
   @w_ccustodiac		 int,		
   @w_centec		         int,		
   @w_cprincipalc                char(1),         
   @w_ccodigo_externoc           varchar(64),     
   @w_coficialc                  int,             
   @w_cpropietarioc	         char(1),		
   @w_ctipo_garantec	         catalogo,	
   @w_cvinculoc 	         catalogo,	
   @w_cnombrec                   varchar(64),     
   @w_cced_rucc                  varchar(30),    
   @w_ctipo_cedc                 char(2),
   -- gar_propuesta
   @w_ptramite                     int          ,
   @w_pgarantia                    varchar (64) ,
   @w_pclasificacion               char (1)     ,
   @w_pexceso                      char (1)     ,
   @w_pmonto_exceso                money        ,
   @w_pabierta                     char(1)      ,
   @w_pdeudor                      int          ,
   @w_pest_garantia                char(1)      ,
   @w_pporcentaje		   float	  ,	  
   @w_pvalor_resp_garantia	   money	  ,
   @w_pfecha_mod		   datetime     ,	
   @w_pproceso 		           char(1) ,     
   --  @w_pced_rucc                varchar(30)  ,
   --  @w_ptipo_cedc               char(2)      	
   @w_cced_ruccemi                 varchar(30),    
   @w_ctipo_cedcemi                Char(2),
   @w_externo                      varchar(64) ,
   @w_cobcobisgarantia             varchar(64),
   @w_oficialmig                   int,
   @w_mensaje                      varchar(100),
   @w_cod_cobis                    char(10),
   @w_tipo_reico                   descripcion,
   @w_tipo_cobis                   descripcion,
   @w_cod_cobishom                 varchar(20),
   @w_cod_reicohom                 varchar(20) ,
   @w_fag                          descripcion ,
   @w_it_item                      tinyint     
         	
        
select @w_sp_name = 'sp_ micligar'

declare cursor_cliente cursor for
select
cm_ente_migracion  ,        cm_tipo_migracion,   cm_ced_rucc_migracion ,        
cm_garantia,                cm_tipo_reico  ,     --cm_tcliente_gar,               
cm_cobcobisgarantia ,       cm_cobsecuencial ,             
cm_oficialmig  ,            cm_nombre    
from cm_migracion_garantia
where   cm_tcliente_gar <> 'S'
order by cm_cobcobisgarantia
for read only
               
open cursor_cliente

fetch cursor_cliente into 
@w_garante ,          @w_tipo_ced  ,            @w_ced_ruc  ,        
@w_codigo_exreico,    @w_tipo,                  --' '          ,  
@w_codigo_externo   , --@w_cod_cobishom ,       
@w_custodia ,
@w_oficialmig,        @w_propietario
        
        
        
  while @@fetch_status = 0
    begin
       if @@fetch_status = -1
         begin
           select @w_error   = 1909001
           goto ERROR
        end   
        
         select
         @w_filial   =  cu_filial ,                 
         @w_sucursal =  cu_sucursal  
         from  cu_custodia
         where
         cu_codigo_externo = @w_codigo_externo
         
         if @@rowcount = 0 
         begin
         print 'no existe garantia en cu_custodia' + @w_codigo_externo
         end
         
         insert into cu_cliente_garantia(
         cg_filial,	     cg_sucursal,       	cg_tipo_cust,		
         cg_custodia,	     cg_ente	,               cg_principal,            
         cg_codigo_externo,  cg_oficial  ,        	cg_propietario	,	
         cg_tipo_garante,    cg_vinculo,                cg_nombre)
         values                (
         @w_filial  	     ,@w_sucursal,      	@w_tipo ,	
         @w_custodia ,          @w_garante ,              'D'  ,            
         @w_codigo_externo,     @w_oficialmig ,           null,	
         'C',                   null,                    @w_propietario) 
	
	
        if @@error <> 0 
         begin
           select @w_error   = 1912005
           goto ERROR
         end
    
       fetch cursor_cliente into 
       @w_garante ,          @w_tipo_ced  ,            @w_ced_ruc  ,        
       @w_codigo_exreico,    @w_tipo,                  --' '          ,  
       @w_codigo_externo   , --@w_cod_cobishom ,   
             @w_custodia ,
       @w_oficialmig,        @w_propietario
        
        
    end         --begin
    close cursor_cliente
    deallocate cursor_cliente
    return 0
    
    ERROR: 
    
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
        
go

