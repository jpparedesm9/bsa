/************************************************************************/
/*      Archivo:                b_hiscamb.sp                            */
/*      Stored procedure:       sp_busca_historia_cambios               */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           I. Torres                               */
/*      Fecha de escritura:     24-May-2005                             */
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
/*  Este programa realiza la búsqueda de los datos de dep=sito a Plazo  */
/*  de una cuenta.                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */
/*                                             Emision inicial          */
/************************************************************************/
/*                    PERSONALIZACION BANCO DE PRESTAMOS                */
/*      24-MAY-2005   IVONNE TORRES       Emision inicial               */
/*      03-Ago-2006   Ricardo Ramos       A¤adir campo de fideicomiso   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_busca_historia_cambios')
   drop proc sp_busca_historia_cambios
go

create proc sp_busca_historia_cambios(
@s_ssn               int,
@s_srv               varchar(30),
@s_lsrv              varchar(30),
@s_user              varchar(30),
@s_sesn              int             = null,
@s_term              varchar(10),
@s_date              datetime,
@s_ofi               smallint,                    -- Localidad origen transaccion
@s_rol               smallint,
@s_org               char(1),
@t_corr              char(1)         = null,
@t_ssn_corr          int             = null,      -- Trans a ser reversada 
@t_debug             char(1)         = 'N',
@t_file              varchar(14)     = null, 
@t_from              varchar(32)     = null,  
@t_rty               char(1)         = 'N',
@t_trn               smallint,
@i_num_banco         varchar(15),                 --lleva el c=digo de dep=sito o cuenta que es objeto de consulta
@i_secuencial        int		   =-1,
@i_formato_fecha     int            = null      --CVA Nov-02-05
)
with encryption
as
declare @w_sp_name       varchar(30)
/* Asignacion del nombre del sp a variable */

select @w_sp_name = 'sp_busca_historia_cambios'

/*------------------------*/
/*       DEBUG            */
/*------------------------*/

if @t_debug = 'S'
begin
   exec cobis..sp_begin_debug @t_file = @t_file
   select '/** Store Procedure **/ ' = @w_sp_name,
          t_file          = @t_file,
          t_from          = @t_from
end

/*------------------------*/
/*  Tipo de Transaccion   */
/*------------------------*/

if @t_trn <> 14559
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018 
   return 1
end

-----------------------------------
-- Traer los registros de 20 en 20 
-----------------------------------

set rowcount 20

------------------------------------
-- Envio de Datos al Front - End
------------------------------------
Select
 'FECHA TRAN.'           = convert(varchar(10),co_fecha,@i_formato_fecha), 
 'FECHA VALOR TRAN.'     = convert(varchar(10),co_fecha_valor,@i_formato_fecha), 	
 'SECUENCIAL'            = co_secuencial,
 'OPERACION'             = co_operacion, 
 'NUMERO DE DPF'         = co_num_banco, 
 'USUARIO'               = co_funcionario,
 'TIPO DE DPF'           = co_toperacion,
 'TIP. DE DPF ANTERIOR'  = co_toperacion_ant,
 'CAPITALIZACION'        = co_tcapitalizacion,
 'CAPITALIZACION ANTERIOR' = co_tcapitalizacion_ant,
 'OFICINA'               = co_oficina,
 'OFICINA ANTERIOR'      = co_oficina_ant,
 'CATEGORIA'             = co_categoria,
 'CATEGORIA ANTERIOR'    = co_categoria_ant,
 'BASE CALCULO'          = co_base_calculo,
 'BASE CALCULO ANTERIOR' = co_base_calculo_ant,
 'FPAGO'                 = co_fpago,
 'FPAGO ANTERIOR'        = co_fpago_ant,
 'FREC. PAGO'            = co_ppago,
 'FREC. PAGO ANTERIOR'   = co_ppago_ant,
 'PLAZO'                 = co_num_dias,
 'PLAZO ANTERIOR'        = co_num_dias_ant,
 'PLAZO OPE.'            = co_plazo_orig,
 'PLAZO OPE. ANTERIOR'   = co_plazo_orig_ant,
 'DIAS CALENDARIO'       = co_dias_reales, 
 'DIAS CALENDARIO ANTERIOR' = co_dias_reales_ant,
 'TASA'                  = co_tasa,
 'TASA ANTERIOR'         = co_tasa_ant,
 'FECHA VALOR'           = convert(varchar(10),co_fecha_valop,@i_formato_fecha),
 'FECHA VALOR ANTERIOR'  = convert(varchar(10),co_fecha_valop_ant,@i_formato_fecha),
 'FECHA VENCIMIENTO'             = convert(varchar(10),co_fecha_ven,@i_formato_fecha),
 'FECHA VENCIMIENTO ANTERIOR'    = convert(varchar(10),co_fecha_ven_ant,@i_formato_fecha),            
 'DIA DE PAGO'           = co_dia_pago,
 'DIA DE PAGO ANTERIOR'  = co_dia_pago_ant,
 'OFICIAL PRINCIPAL'            = co_oficial_prin,
 'OFICIAL PRINCIPAL ANTERIOR'   = co_oficial_prin_ant,
 'OFICIAL SECUNDARIO'           = co_oficial_sec,
 'OFICIAL SECUNDARIO ANTERIOR'  = co_oficial_sec_ant,
 'TITULARES/CONDICION'            = co_titulares,
 'TITULARES/CONDICION ANTERIOR'   = co_titulares_ant,
 'FIRMANTES/CONDICION'            = co_firmantes,
 'FIRMANTES/CONDICION ANTERIOR'   = co_firmantes_ant,
 'ESTADO'                	= co_estado,
 'FIDEICOMISO'                  = co_fideicomiso,
 'FIDEICOMISO ANTERIOR'         = co_fideicomiso_ant,
 'DESMATERIALIZA' = co_desmaterializa,
 'DESMATERIALIZA ANTERIOR' = co_desmaterializa_ant
 from cob_pfijo..pf_cambio_oper
where co_num_banco   = @i_num_banco
  and co_secuencial  > @i_secuencial

set rowcount 0

return 0
go
