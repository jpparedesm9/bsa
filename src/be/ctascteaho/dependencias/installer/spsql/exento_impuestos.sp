/************************************************************************/
/*      Archivo:                exento_impuestos.sp                     */
/*      Stored procedure:       sp_exento_impuestos                     */
/*      Base de datos:          cob_cuentas                             */
/*      Producto:               Contabilidad                            */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza las transacciones de:                     */
/*      Excencion y Porcentaje de Impuestos                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR           RAZON                                 */
/*  19/Sep/2016   J. Salazar      Migracion CobisCloud                  */
/************************************************************************/
use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_exento_impuestos')
  drop proc sp_exento_impuestos
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_exento_impuestos
(
--	@s_ssn           int         = null,
--	@s_date          datetime    = null,
--	@s_user          varchar(14) = null,
--	@s_term          varchar(64) = null,
--	@s_corr          char(1)     = null,
--	@s_ssn_corr      int         = null,
--	@t_rty           char(1)     = null,
--  @t_trn           smallint    = null,
    @t_debug         char(1)     = 'N',
    @t_file          varchar(14) = null,
    @t_from          varchar(30) = null,
    @t_show_version  bit          = 0,
--	@i_operacion     char(1),
    @i_trn           int,
    @i_empresa       tinyint     = 1,
    @i_impuesto      char(1)     = null,
    @i_causal        varchar(10) = null,
    @i_debcred       char(1)     = null,
    @i_oforig_admin  int,
    @i_ofdest_admin  int,
    @i_ente          int,
    @i_producto      tinyint     = null,
    @i_pit           char(1)     = 'N',
    @o_exento        char(1)     = 'N' out,
    @o_base          money       out,
    @o_porcentaje    float       out
)
as 
declare
   @w_sp_name   varchar(32),	/* nombre del stored procedure*/
   @w_concepto  char(4),
   @w_return    int,
   @w_mensaje   varchar(128)

select @w_sp_name = 'sp_exento_impuestos'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

select @w_mensaje = 'No existe definicion de exencion de Impuestos en la transaccion ' + convert (char(6), @i_trn) + ' Causal: ' + @i_causal

select @w_concepto = ci_concepto
  from cob_remesas..re_concepto_imp
 where ci_tran = @i_trn
   and ci_causal = @i_causal
   and ci_impuesto = @i_impuesto

if @@rowcount <> 1 
begin
    /*** Error: NO EXISTE DEFINICION DE CONCEPTO CONTABLE	***/
      exec cobis..sp_cerror1
           @t_debug  = @t_debug,
     	   @t_file   = @t_file,
     	   @t_from   = @w_sp_name,
     	   @i_num    = 201232,
	       @i_msg    =  @w_mensaje,
           @i_pit    = @i_pit
	  return 201232
end

exec @w_return = cob_conta..sp_exenciu    
     @t_trn 		   = 6251,
     @i_operacion	   = 'F',
     @i_empresa	   = @i_empresa,
     @i_impuesto	   = @i_impuesto,
     @i_concepto     = @w_concepto,
     @i_debcred	   = @i_debcred,
     @i_oforig_admin = @i_oforig_admin,
     @i_ofdest_admin = @i_ofdest_admin,
     @i_ente         = @i_ente,
     @i_producto     = @i_producto,
     @i_pit          = @i_pit,
     @o_exento       = @o_exento out

if @w_return <> 0
    return @w_return

select @o_base       = 0,
       @o_porcentaje = 0

if @o_exento = 'N'
begin
	if @i_impuesto = 'V'	/*** 	IVA	****/
	begin
		select 
            @o_base	      = iva_base,
            @o_porcentaje = iva_des_porcen
          from cob_conta..cb_iva
         where iva_empresa  = @i_empresa
           and iva_codigo   = @w_concepto
           and iva_debcred  = @i_debcred
       
        if @@rowcount <> 1
        begin
           select  @w_mensaje = @w_mensaje + ' en Contabilidad'
           /*** Error: NO EXISTE CONCEPTO CONTABLE EN CONTABILIDAD	***/
           exec cobis..sp_cerror1 
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 201232,
                @i_msg    = @w_mensaje,
                @i_pit    = @i_pit
           return 201232	
		end
	end

    if @i_impuesto = 'R'	/****	Retencion	***/
    begin
       select 
       	   @o_base       = cr_base,
       	   @o_porcentaje = cr_porcentaje  
         from cob_conta..cb_conc_retencion
        where cr_empresa = @i_empresa
          and cr_codigo  = @w_concepto
          and cr_debcred = @i_debcred                 
          and cr_tipo    = 'R'

       if @@rowcount <> 1
       begin
          exec cobis..sp_cerror1 
          	   @t_debug  = @t_debug,
          	   @t_file   = @t_file,
          	   @t_from   = @w_sp_name,
          	   @i_num    = 201232,
               @i_msg    =  @w_mensaje,
               @i_pit    = @i_pit

       	  /*** Error: NO EXISTE CONCEPTO CONTABLE EN CONTABILIDAD	***/
       	  return 201232
       end
    end
end
return 0
go

