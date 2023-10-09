/************************************************************************/
/*      Archivo:            numoper.sp                                  */
/*      Stored procedure:   sp_numero_oper                              */
/*      Base de datos:      cob_pfijo                                   */
/*      Producto:           Cuentas Corrientes                          */
/*      Disenado por:       Mauricio Bayas/Miryam Davila                */
/*      Fecha de escritura: 20/Oct/1993                                 */
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
/*      Este programa realiza la generacion del numero de banco         */
/*      e interno para operacion.                                       */ 
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      29/Jun/1994     S. Ortiz      Emision inicial                   */
/*      05/05/2002      W. Solis        Cambio # Cuenta                 */
/*      01-Abr-2005     N. Silva        Correccion /Indentacion         */
/*      04-Abr-2005     K. Tamayo       Nueva definici¢n de num. banco  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_numero_oper')
   drop proc sp_numero_oper
go
create proc sp_numero_oper (
@t_debug          char(1)     = 'N',
@t_file           varchar(14) = NULL,
@t_from           varchar(32) = NULL,
@i_oficina        smallint,
@i_toperacion     catalogo,
@i_moneda         smallint,
@i_es_lote        char(1)     = 'N',
@o_operacion      int out,
@o_num_banco      cuenta out)
with encryption
as
declare
@w_return         int,
@w_sp_name        varchar(30),
@w_numero_oper    int,
@w_cta_ofi        cuenta,
@w_cta_ofi1       cuenta,
@w_operacion      cuenta,
@w_pesos          cuenta,
@w_num_banco      cuenta,
@w_codigo         cuenta,
@w_indice_ope     int,
@w_indice_pesos   int,
@w_long_max_ope   int,
@w_long_ope       int,
@w_suma           smallint,
@w_cuantos        smallint,
@w_valor_ope      smallint,
@w_valor_pesos    smallint,
@w_digito         int,
@w_residuo        int,
@w_modulo         int,
@w_moneda         varchar(2),
@w_coficina       varchar(3),
@w_ceros          int,
@w_secuencial     cuenta,  --KTA GAP-DP00102
@w_ceros_sec      int, --KTA GAP-DP00102
@w_ceros_ofi      int, --KTA GAP-DP00102
@w_oficina        varchar(4),--KTA GAP-DP00102         -- GAL 16/SEP/2009 - RVVCOL
@o_siguiente      int,
@w_toperacion     catalogo   --CVA Set-24-05

------------------------------------------
-- Captura del nombre del Stored Procedure
------------------------------------------
select @w_sp_name = 'sp_numero_oper'


begin tran
   ---------------------------------------------------------
   -- Encontrar un nuevo secuencial para la nueva operacion 
   ---------------------------------------------------------
   exec @w_return    = cobis..sp_cseqnos
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_tabla     = 'pf_operacion',
         @o_siguiente = @o_operacion out

   if @w_return <> 0
      return @w_return

   ---------------------------------------------------
   -- Si el secuencial exede el limite regresar a uno 
   ---------------------------------------------------
   if @o_operacion > 2147483640
   begin
      select @o_operacion = 1
      
      update cobis..cl_seqnos
         set siguiente = @o_operacion
       where tabla     = 'pf_operacion'
   end

   select @w_numero_oper = @o_operacion
   select @w_cta_ofi = convert(varchar, @i_oficina)
   select @w_moneda  = convert(varchar, @i_moneda)

   ----------------------------------
   -- Calculo del D¡gito Verificador
   ----------------------------------
   select @w_pesos = pa_char
     from cobis..cl_parametro
    where pa_nemonico = 'POP'
      and pa_producto = 'PFI'
   
   select @w_long_max_ope = pa_tinyint  --11 para definici¢n GB
     from cobis..cl_parametro
    where pa_nemonico = 'LOP'
      and pa_producto = 'PFI'

   select @w_modulo = pa_tinyint
     from cobis..cl_parametro
    where pa_nemonico = 'MOP'
      and pa_producto = 'PFI'

   select @w_codigo = convert(varchar(24), @w_numero_oper)
 
   if datalength(@i_toperacion) > 3         
      select @i_toperacion = substring(@i_toperacion,1,datalength(@i_toperacion)-1)
   
   select @w_ceros  = @w_long_max_ope - datalength(@i_toperacion) - datalength(@w_cta_ofi) - datalength(rtrim(ltrim(@w_codigo))) - 1

   select @w_codigo = replicate('0', @w_ceros) + ltrim(rtrim(@w_codigo))
   select @w_operacion  = @w_cta_ofi + @w_codigo
   select @w_long_ope   = datalength(@w_operacion), 
          @w_suma       = 0, 
          @w_indice_ope = 1
   
   select @w_indice_pesos = @w_long_max_ope - @w_long_ope 

   while @w_indice_pesos < @w_long_max_ope
   begin
      select  @w_valor_ope     = convert(smallint, substring(@w_operacion, @w_indice_ope, 1))
      select  @w_valor_pesos   = convert(smallint, substring(@w_pesos, @w_indice_pesos, 1))
      select  @w_suma          = @w_suma + @w_valor_ope * @w_valor_pesos
      select  @w_indice_ope    = @w_indice_ope + 1
      select  @w_indice_pesos  = @w_indice_pesos + 1
   end

   select @w_residuo = @w_suma % @w_modulo

   if (@w_residuo = 0) or (@w_residuo = 1) 
      select @w_digito = 0
   else
      select @w_digito = @w_modulo - @w_residuo

   ------------------------------------------------------------
   -- Construccion de el codigo de oficina que va en la cuenta  
   ------------------------------------------------------------
   select @w_ceros_ofi = 4 - datalength(convert(varchar,@i_oficina))                            -- GAL 16/SEP/2009 - RVVCOL
   select @w_oficina   = replicate('0',@w_ceros_ofi) + ltrim(rtrim(convert(varchar,@i_oficina)))

   if @i_es_lote = 'L'
      select @w_oficina = 'L' + @w_oficina
   if @i_es_lote = '1'
      select @w_oficina = '1' + @w_oficina
   if @i_es_lote = 'N'
      select @w_oficina = @w_oficina

   --------------------------------------------------------------
   -- Construccion del codigo del secuencial que va en la cuenta  
   --------------------------------------------------------------
   select @w_secuencial = convert(varchar(24), @w_numero_oper)
   select @w_ceros_sec  = @w_long_max_ope - datalength(@w_oficina) - datalength(@i_toperacion) - datalength(Rtrim(Ltrim(@w_secuencial))) - 1
   select @w_secuencial = replicate('0', @w_ceros_sec) + ltrim(rtrim(@w_secuencial))

   ----------------------------------------
   -- Construccion del n£mero de operaci¢n
   ----------------------------------------
   if @i_es_lote = '1'
      select @o_num_banco = @w_secuencial  + convert(char(1), @w_digito)
   else
      select @o_num_banco = @w_oficina + @i_toperacion + @w_secuencial  + convert(char(1), @w_digito)



commit tran

return 0
go
