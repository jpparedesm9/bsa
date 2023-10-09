/************************************************************************/
/*	Archivo:                heregar.sp                              */
/*	Stored procedure:       sp_heredar_gar                          */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Janeth Solano                    	*/
/*	Fecha de escritura:     Septiembre 14 - 1999			*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa obtiene las garantias de una operacion de CEX     */
/*      y las enlaza automaticamente a un financiamiento originado      */
/*      para la misma operacion, el financiamiento es una op. diferente */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Sep/1999        J.Solano      Emision Inicial			*/
/*      Feb/2001        Zulma Reyes   ZR CD00064 Tequendama             */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_heredar_gar')
    drop proc sp_heredar_gar
go
create proc sp_heredar_gar (
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
   @i_numoperacion       varchar(24) = null,     --numero de banco de la op. padre de CEX
   @i_toperacion         varchar(10) = null, 
   @i_tramite            int      = null     --numero de tramite del financiamiento
)
as

declare
   @w_sp_name            varchar(32),
   @w_return             int,
   @w_tramite            int,
   @w_codigo_externo     varchar(64),
   @w_deudor             int,
   @w_clase              char(1)


select @w_sp_name = 'sp_heredar_gar'

/***********************************************************/
/* Codigos de Transacciones                                */

/*
if (@t_trn <> 19017 )
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end
*/


   /* VALIDACION DE CAMPOS NULOS */
   /******************************/
   if @i_numoperacion is NULL or
      @i_tramite  is NULL
   begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
   end

   /*Obtener el numero de tramite de la operacion de CEX*/
   select @w_tramite = tr_tramite
   from cob_credito..cr_tramite
   where tr_numero_op_banco = @i_numoperacion

   --JSB 2000-02-03 comentario
   --select @w_tramite = @i_tramite_main 

   /* Obtener las garantias de la operacion de CEX y registrarlas en cr_gar_propuesta*/
   if @w_tramite is not NULL
   begin
        insert into cob_credito..cr_gar_propuesta(
                 gp_tramite,      gp_garantia,       gp_clasificacion,      
	         gp_exceso,       gp_monto_exceso,   gp_abierta,
	         gp_deudor,       gp_est_garantia,   gp_fecha_mod)		--ZR
         select  @i_tramite,      gp_garantia,       'a', 
                 NULL,            NULL,              gp_abierta,  
                 gp_deudor,       gp_est_garantia,   @s_date	--ZR 
               from cob_credito..cr_tramite, cob_credito..cr_gar_propuesta
               where tr_tramite = @w_tramite          --tramite de la op de CEX
               and tr_tramite   = gp_tramite
               and gp_est_garantia  not in ('A', 'C') -- solo vigentes o propuestas
   end
/* pga 2ago2001
   else
   begin
      --No existe el tramite, registro no existe 
       exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = "sp_heredar_gar",
         @i_num   = 2101005
         return 1 
   end
*/

return 0
go