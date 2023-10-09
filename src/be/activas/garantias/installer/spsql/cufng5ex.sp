/******************************************************************/
/*  Archivo:            cufng5ex.sp                               */
/*  Stored procedure:   sp_fng_5_ex                               */
/*  Base de datos:      cob_custodia                              */
/*  Producto:           Custodia                                  */
/*  Disenado por:       Gabriel Alvis                             */
/*  Fecha de escritura: 22/Abr/2009                               */
/******************************************************************/
/*                          IMPORTANTE                            */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA'                                                      */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Reemplazar al fng_5.sqr en funciones sirviendo de             */
/*  procedimiento cáscara en invocacion del SP                    */
/*  cob_credito..sp_opp                                           */
/******************************************************************/
/*                          MODIFICACIONES                        */
/*  FECHA       AUTOR       RAZON                                 */
/*  22/Abr/09   G. Alvis    Emision Inicial                       */
/******************************************************************/

use cob_custodia
go

if object_id('sp_fng_5_ex') is not null
   drop proc sp_fng_5_ex
go

---ORS 000347
create proc sp_fng_5_ex
   @i_param1   varchar(255) = null,
   @i_param2   varchar(255) = null
as

declare 
   @w_return      int,
   @i_fecha       datetime,
   @i_report      varchar(64)
   
select 
   @i_fecha      = convert(datetime,    @i_param1),  
   @i_report     = convert(varchar(64), @i_param2)

if @i_report = 0
   select @i_report = null
   
if object_id('cob_credito..cr_fng1_tmp') is not null
   drop table cob_credito..cr_fng1_tmp
   
create table cob_credito..cr_fng1_tmp(
   ref_archi         varchar(10),  
   nit_inter         varchar(20),  
   cod_sucur         varchar(10),  
   nomlar            varchar(40),  
   tipo_id           varchar(4),  ---cambio  Campo 5 Columna E
   num_id            varchar(16),          
   fec_nac           varchar(8),   
   gen_deudor        varchar(1),   
   est_ci_deudor     varchar(2) NULL,      
   nivel_estu        varchar(1) NULL,   
   dir_deudor        varchar(60) NULL,  
   tipo_id_rl        varchar(3) NULL,   
   id_rl             char(1) NULL,          
   nomlar_rl         varchar(40) NULL,  
   munic_deudor      varchar(5) NULL, ---cambio  campo 15 Colomna O        
   tel1_deudor       varchar(16) NULL,  
   tel2_deudor       varchar(16) NULL,  
   fax_deudor        varchar(16) NULL ,  
   email_deudor      varchar(30) NULL,  
   ciiu              char(4),      ---cambio  campo 20 columna  T
   acti_total        varchar(15) NULL,  ---cambio  campo 21 colmna   U
   pasi_total        numeric(12,0) NULL,
   ing_deudor        numeric(12,0) NULL,
   egr_deudor        numeric(12,0) NULL,
   cam_r1            varchar(1) NULL,   
   cam_r2            varchar(1) NULL,   
   ref_credito       varchar(18) NULL, ---cambio   campo 27 columna  AA  
   num_pagare        varchar(18) NULL, ---cambio   campo 28 columna  AB
   cod_moneda        varchar(3) NULL,      
   valor_monto       numeric(11,0), ---cambio campo 30 columna AD
   num_cup_rot       char(1) NULL,          
   cam_r3            varchar(1) NULL,   
   cam_r4            varchar(1) NULL,   
   fec_desem         varchar(8) NULL,  --- revision 34 columna AH  
   cod_plazo_o       tinyint, ---cambio  campo 35 columna AI 
   plazo             tinyint, ---cambio  campo 36 columna AJ        
   cod_tasa_index    varchar(3) NULL,
   signo_puntos      varchar(1) NULL,   
   puntos_tasa       numeric(5, 2) NULL,
   cod_perio_tasa    varchar(2) NULL,   
   mod_tasa          varchar(1) NULL,   
   per_amorti        varchar(3) NULL,---revision campo 43 columna AP
   calif_r_obli      varchar(2) NULL, ---cambio  campo 44  columna AQ	
   cam_r5            varchar(1) NULL,   
   per_gra_capi      varchar(3) NULL,   
   tipo_car          varchar(2) NULL, ---revision   campo 47 columna AT
   desti_credito     varchar(3) NULL, ---cambio     campo 48 columna AU
   tipo_recur        varchar(1) NULL,   
   val_redes         char(1) NULL,
   porc_redes        char(1) NULL,          
   nit_enti_redes    char(1) NULL,
   cam_r6            varchar(1) NULL,   
   cam_r7            varchar(1) NULL,   
   cam_r8            varchar(1) NULL,   
   cam_r9            varchar(1) NULL,   
   val_gar_rea_af    numeric(12, 0) NULL,
   fec_val_gar_af    varchar(8) NULL,   
   desc_gar_af       varchar(60) NULL,  
   desc_ogar_af      varchar(60) NULL,  
   cod_prod_gar      varchar(6),  ---revision  campo 61   columna BH
   num_gar_fng       varchar(10), ---cambio    campo 62 columna BI     
   porc_cober        float NULL,          
   per_cobr_comi     varchar(2) NULl,   
   nit_ecap          char(1) NULL,
   razsoci_ecap      varchar(40) NULL,  
   cod_mun_ecap      char(1) NULL,          
   dir_domi_ecap     varchar(60) NULL,  
   tipo_id_rl_ecamp  varchar(3) NULL,   
   id_rl_ecamp       char(1) NULL,          
   nomlar_rl_ecamp   varchar(40) NULL,  
   cap_susypag_antes char(1) NULL,
   cap_susypag       char(1) NULL,
   fec_cap           varchar(8) NULL,   
   val_aval_inmu     char(1) NULL,
   dir_inmu          varchar(60) NULL,  
   matri_inmu        varchar(18) NULL,  
   cod_muni_inmu     char(1) NULL,          
   val_subsidio      char(1) NULL,
   estrato           varchar(2) NULL,   
   tipo_vivienda     char(1) NULL,          
   porc_finan_vivi   varchar(2) NULL,   
   cam_r10           varchar(1) NULL,   
   cam_r11           varchar(1) NULL,   
   val_finan         char(1) NULL,
   cam_r12           varchar(1) NULL,   
   canon             char(1)
)                                  
      
exec @w_return = cob_credito..sp_opp
   @i_fecha      = @i_fecha,     
   @i_report     = @i_report
   
return @w_return
   
go
