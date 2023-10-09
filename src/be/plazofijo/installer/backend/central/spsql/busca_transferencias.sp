/************************************************************************/
/*      Archivo:                b_transferencia.sp                      */
/*      Stored procedure:       sp_busca_transferencias                 */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 12-Mar-2003                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Procedimiento que realiza la consulta de aquellos Depositos     */
/*      que se realizaron por Transferencias, por lo general son los    */
/*      overnight.                                                      */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA             AUTOR              RAZON                      */
/*      12-Mar-2003       N. Silva           Emision Inicial            */
/*      21-Feb-2007       H.Ayarza           Aumento @w_tr_cta_corresp  */
/*                                           varchar(34).               */
/*      30/11/2016        A.Zuluaga          Desacople                  */
/************************************************************************/
use cob_pfijo
go

set ansi_nulls off
go

if exists ( select name from sysobjects where type = 'P' and
		name = 'sp_busca_transferencias')
	drop proc sp_busca_transferencias
go
create proc sp_busca_transferencias (
	@s_ssn                  int             = NULL,
	@s_user                 login           = NULL,
        @s_sesn                 int             = NULL,
	@s_term                 varchar(30)     = NULL,
	@s_date                 datetime        = NULL,
	@s_srv                  varchar(30)     = NULL,
	@s_lsrv                 varchar(30)     = NULL,
	@s_ofi                  smallint        = NULL,
	@s_org                  char(1)         = NULL,
	@s_rol                  smallint        = NULL,
	@t_debug                char(1)         = 'N',
	@t_file                 varchar(10)     = NULL,
	@t_from                 varchar(32)     = NULL,
	@t_trn                  smallint        = NULL,
	@i_operacion            char(1),
        @i_en_linea             char(1)         = 'S', 
	@i_tipo                 char(1)	        = 'C',
	@i_operacionpf          int             = NULL,
	@i_fecha_mov            datetime	= NULL,
	@i_secuencial           int		= 0,
	@i_secuencia            int		= 0,
	@i_sub_secuencia        int		= 0,
	@i_numero               int        	= 99999999,
	@i_descripcion          descripcion    	= '',
        @i_producto             catalogo        = NULL,
        @i_formato_fecha        int             = 0,
        @i_tr_cod_transf        int             = NULL
 )  
as
declare @w_sp_name              descripcion,
        @w_return               int,
        @w_tr_cta_corresp       varchar(34),	--HA20070221
        @w_tr_cod_corresp       catalogo,
        @w_tr_cod_corresp_int   int,
        @w_tr_benef_corresp     varchar(245),
        @w_tr_ofic_corresp      int,
        @w_tr_monto             money,
        @w_of_continente        varchar(7),
        @w_of_ciudad            int,
        @w_of_pais              smallint,
        @w_pa_descripcion       descripcion,
        @w_ci_descripcion       descripcion
select @w_sp_name = 'sp_busca_transferencias'
/*---------------------------------*/
/* Verificar codigo de Transaccion */
/*---------------------------------*/
if @t_trn <> 14460
begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141112
    return 1
end
-----------------------------------------------------------------------
-- Proceso de Seleccion de Datos para consultar Transferencias (Search)
-----------------------------------------------------------------------
if @i_operacion = 'S'
begin
   set rowcount 20
   select     'Num. Dep¢sito'= substring(op_num_banco,1,20),
              'Transacci¢n'= substring(tn_descripcion,1,25),
	      'Ordenante'= ec_descripcion,
              'Monto'= tr_monto,
              'Fecha solicitud'= rtrim(convert(varchar,tr_fecha,@i_formato_fecha)), 
	      'Op'= ec_operacion,
	      'Moneda' = tr_moneda, 
              'Sec'= ec_secuencia,
              'SSec'= ec_sub_secuencia,
              'Cuenta'= tr_cta_corresp,
              'Cod.Transf'= tr_cod_transf
        from cob_pfijo..pf_emision_cheque,
             cobis..cl_ttransaccion, 
             cob_pfijo..pf_operacion,
             cob_pfijo..pf_mov_monet,
             cob_pfijo..pf_transferencias_tmp
       where datediff(dd,ec_fecha_mov,@i_fecha_mov) >= 0 
         and ec_fecha_emision is null
         and ec_fpago = 'TRANS'
         and (@i_descripcion is null or (
	  ec_descripcion > @i_descripcion
          or (ec_descripcion = @i_descripcion and ec_operacion > @i_operacionpf)
          or (ec_descripcion = @i_descripcion and ec_operacion = @i_operacionpf and ec_secuencia > @i_secuencia)
          or (ec_descripcion = @i_descripcion and ec_operacion = @i_operacionpf and ec_secuencia = @i_secuencia
            and tr_cod_transf > @i_tr_cod_transf)
         ))
         and ec_tipo = 'C' 
         and tn_trn_code = 14903
         and ec_tran = tn_trn_code 
         and ec_secuencia = mm_secuencia
         and ec_sub_secuencia = mm_sub_secuencia
         and ec_operacion = mm_operacion
         and op_operacion    = ec_operacion
         and op_operacion = tr_cod_operacion
         and ec_sub_secuencia = tr_sec_pago
         and tr_estado = 'V'                        -- Transferencia Vigente
       order by ltrim(ec_descripcion), ec_operacion, ec_secuencia, tr_cod_transf
   set rowcount 0
end
---------
-- Query
---------
if @i_operacion = 'Q'
begin
   --------------------------------------------------------------------
   -- Busqueda de otros datos para envio al Front-End en transmisiones
   --------------------------------------------------------------------
   select @w_tr_cta_corresp    = tr_cta_corresp,
          @w_tr_cod_corresp    = tr_cod_corresp,
          @w_tr_benef_corresp  = tr_benef_corresp,
          @w_tr_ofic_corresp   = tr_ofic_corresp,
          @w_tr_monto          = tr_monto
     from cob_pfijo..pf_transferencias_tmp
    where tr_cod_operacion = @i_operacionpf
      and tr_cod_transf = @i_tr_cod_transf

    select @w_tr_cod_corresp_int = convert(int,@w_tr_cod_corresp)

   --DESACOPLE
   exec @w_return = cob_interfase..sp_icomext
        @i_operacion      = 'D',
        @i_banco          = @w_tr_cod_corresp_int,
        @i_oficina        = @w_tr_ofic_corresp,
        @o_of_continente  = @w_of_continente    out,
        @o_of_pais        = @w_of_pais          out,
        @o_of_ciudad      = @w_of_ciudad        out,
        @o_pa_descripcion = @w_pa_descripcion   out,
        @o_ci_descripcion = @w_ci_descripcion   out
        
   if @w_return <> 0
      return @w_return

   -------------------------------
   -- Envio de datos al Front-End
   -------------------------------
   select o_num_banco         = op_num_banco,
          o_beneficiario      = ec_descripcion,
          o_numero            = ec_numero,
          o_valor             = @w_tr_monto,
          o_cod_ente          = op_ente,
          o_fpago             = ec_fpago,
          o_moneda            = ec_moneda,
          o_cuenta            = ec_cuenta,
          o_mm_cta_corresp    = @w_tr_cta_corresp,
          o_mm_cod_corresp    = @w_tr_cod_corresp,
          o_benef_corresp     = @w_tr_benef_corresp,
          o_mm_ofic_corresp   = @w_tr_ofic_corresp,
          o_desc_moneda       = mo_descripcion,
          o_of_continente     = @w_of_continente,
          o_of_pais           = @w_of_pais,
          o_of_ciudad         = @w_of_ciudad,
          o_pa_descripcion    = @w_pa_descripcion,
          o_ci_descripcion    = @w_ci_descripcion    
     from cob_pfijo..pf_emision_cheque,
          cob_pfijo..pf_operacion,
          cobis..cl_moneda
    where ec_sub_secuencia   = @i_sub_secuencia  
      and ec_secuencia       = @i_secuencia  
      and ec_operacion       = @i_operacionpf
      and mo_moneda          = ec_moneda
      and ec_fecha_emision   is null
      and op_operacion    = ec_operacion
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name, 
           @i_num   = 141095
      return 1
   end
end
if @i_operacion = 'H'
begin
   select tr_cod_corresp,
          tr_cta_corresp,
          tr_benef_corresp,
          tr_ofic_corresp,
          tr_monto,
          tr_sec_pago,
          tr_porcentaje
   from   pf_transferencias_tmp
   where  tr_cod_operacion = @i_operacionpf
     and  tr_estado = 'V'

end
return 0
go
