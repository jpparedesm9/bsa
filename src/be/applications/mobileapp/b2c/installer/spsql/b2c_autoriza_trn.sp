use cob_bvirtual
go
if object_id('sp_autoriza_servicio_bv') is not null
        drop proc sp_autoriza_servicio_bv
go
/******************************************************************************/  
/*   ARCHIVO:         b2c_autoriza_trn.sp                                      */  
/*   NOMBRE LOGICO:   sp_autoriza_servicio_bv                                 */  
/*   PRODUCTO:        ADMINBV                                                 */  
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                     PROPOSITO                                              */  
/*   Autorizar las Transacciones que en BVI se manejan a un                   */  
/*   perfil determinado                                                       */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        VERSION  AUTOR            RAZON                               */
/******************************************************************************/
/* 31/Ene/2017             DJM              Emision Inicial                   */
/******************************************************************************/  
  
create proc sp_autoriza_servicio_bv(
@i_servicio      int          = null,
@i_cliente       int          = null,
@i_perfil        int          = null,
@i_id_servicio   varchar(30)  = null,
@i_login         varchar(30)  = null,
@i_clase         varchar(30)  = null,
@o_msg           varchar(200) = null output
)
as
return 0
go
