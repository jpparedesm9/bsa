/*   Base de datos:  	  cob_interfase                                 */
/*   Producto:            Plazo Fijo                                    */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  19 de Julio de 2016                           */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA". Su uso no autorizado queda expresamente prohibido asi    */
/*   como cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Creacion Stored Procedure Cascara para instalacion de Plazo Fijo   */
/*   Version Davivienda                                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   19/Jul/2016        Oscar Saavedra    Instalador Version Davivienda */
/************************************************************************/
use cob_sbancarios
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_imprimir_lotes')
   drop proc sp_imprimir_lotes
go

create proc sp_imprimir_lotes(
@s_ssn                                     int              = null,
@s_date                                    datetime         = null,
@s_user                                    varchar(30)      = null,
@s_term                                    varchar(10)      = null,
@s_ofi                                     smallint         = null,
@s_lsrv                                    varchar(30)      = null,
@s_srv                                     varchar(30)      = null,
@t_debug                                   char(1)          = 'N', 
@t_file                                    varchar(14)      = null,
@t_trn                                     smallint         = null,
@i_batch                                   char(1)          = 'N', 
@i_oficina_origen                          smallint         = null,
@i_ofi_destino                             smallint,               
@i_area_origen                             smallint,               
@i_func_solicitante                        smallint         = null,
@i_fecha_solicitud                         datetime,               
@i_producto                                tinyint,                
@i_instrumento                             smallint,               
@i_subtipo                                 int,                    
@i_valor                                   money,                  
@i_beneficiario                            varchar(64),            
@i_tipo_benef                              char(1)          = null,
@i_referencia                              int              = null,
@i_campo1                                  varchar(20)      = null,
@i_campo2                                  varchar(20)      = null,
@i_campo3                                  varchar(20)      = null,
@i_campo4                                  varchar(20)      = null,
@i_campo5                                  varchar(20)      = null,
@i_campo6                                  varchar(20)      = null,
@i_campo7                                  varchar(20)      = null,
@i_campo8                                  varchar(20)      = null,
@i_campo9                                  varchar(20)      = null,
@i_campo10                                 varchar(20)      = null,
@i_campo11                                 varchar(20)      = null,
@i_campo12                                 varchar(20)      = null,
@i_campo13                                 varchar(20)      = null,
@i_campo14                                 varchar(20)      = null,
@i_campo15                                 varchar(20)      = null,
@i_campo16                                 varchar(20)      = null,
@i_campo17                                 varchar(20)      = null,
@i_campo18                                 varchar(20)      = null,
@i_campo19                                 varchar(20)      = null,
@i_campo20                                 varchar(20)      = null,
@i_campo21                                 varchar(20)      = null,
@i_campo22                                 varchar(20)      = null,
@i_campo23                                 varchar(20)      = null,
@i_campo24                                 varchar(20)      = null,
@i_campo25                                 varchar(20)      = null,
@i_campo26                                 varchar(20)      = null,
@i_campo27                                 varchar(20)      = null,
@i_campo28                                 varchar(20)      = null,
@i_campo29                                 varchar(20)      = null,
@i_campo30                                 varchar(20)      = null,
@i_campo31                                 varchar(20)      = null,
@i_campo32                                 varchar(20)      = null,
@i_campo33                                 varchar(20)      = null,
@i_campo34                                 varchar(20)      = null,
@i_campo35                                 varchar(20)      = null,
@i_campo36                                 varchar(20)      = null,
@i_campo37                                 varchar(20)      = null,
@i_campo38                                 varchar(20)      = null,
@i_campo39                                 varchar(20)      = null,
@i_campo40                                 varchar(20)      = null,
@i_campo41                                 varchar(20)      = null,
@i_campo42                                 varchar(20)      = null,
@i_campo43                                 varchar(20)      = null,
@i_campo44                                 varchar(20)      = null,
@i_campo45                                 varchar(20)      = null,
@i_campo46                                 descripcion      = null,
@i_campo47                                 descripcion      = null,
@i_campo48                                 descripcion      = null,
@i_campo49                                 descripcion      = null,
@i_campo50                                 descripcion      = null,
@i_archivo                                 descripcion      = null,
@i_serie_lit                               varchar(10)      = '',  
@i_serie_numerica                          money            = null,
@i_estado                                  char(1)          = 'D', 
@i_banco                                   smallint         = null,
@i_desc_banco                              varchar(64)      = null,
@i_moneda                                  tinyint          = 0,   
@i_num_cuenta                              varchar(64)      = null,
@o_error_cod                               int              = null OUT, 
@o_error_msg                               varchar(64)      = null OUT,
@o_idlote                                  int              = 0    OUT,
@o_secuencial                              int              = 0    OUT)
as
declare 
@w_sp_name                                 varchar(32),
@w_hora                                    varchar(10),
@w_user                                    smallint,   
@w_cod                                     int,        
@w_return                                  int,        
@w_cta_ger                                 varchar(20),
@w_cont                                    int,
@w_param_ofi                               char(1)

select @o_error_cod = 0
select @o_error_msg 
select @o_idlote    
select @o_secuencial
return 0 
go
