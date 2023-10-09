/************************************************************************/
/*      Archivo:                compastt.sp                             */
/*      Stored procedure:       sp_sasiento                             */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Inversiones                             */
/*      Disenado por:           Gustavo Calderon .                      */
/*      Fecha de escritura:     10/Oct/1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Inserta los asientos de un comprobante a la tabla cb_sasiento a */
/*      no realiza validacion, esta la realiza bt_conta.sp              */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      10-Oct/1995     G.Calderon       Emision Inicial                */
/*      12-Oct/1999     M.Cartagena      Adicion error SQLSE65-E005     */
/*                                       cambio de char_length a        */
/*                                       datalength                     */
/************************************************************************/   
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_sasiento') IS not  NULL
   drop proc sp_sasiento
go

create proc sp_sasiento   (
   @s_ssn               int          = NULL,
   @s_date              datetime     = NULL,
   @s_user              login        = NULL,
   @s_term              descripcion  = NULL,
   @s_corr              char(1)      = NULL,
   @s_ssn_corr          int          = NULL,
   @s_ofi               int          = NULL,
   @t_rty               char(1)      = NULL,
   @t_trn               int          = NULL,
   @t_debug             char(1)      = 'N',
   @t_file              varchar(14)  = NULL,
   @t_from              varchar(30)  = NULL,
   @i_operacion         char(1)      = NULL,
   @i_fecha_tran        datetime     = NULL,
   @i_comprobante       int          = NULL,    
   @i_empresa           int          = NULL,
   @i_producto          int          = NULL,
   @i_asiento           smallint     = NULL,
   @i_cuenta            varchar(20)  = NULL,
   @i_oficina_dest      int          = NULL,
   @i_area_dest         int          = NULL,
   @i_valor             money        = 0,
   @i_ente              int          = NULL,
   @i_valor_me          money        = 0,
   @i_debcred           char(1)      = NULL,
   @i_concepto          varchar(150) = NULL,
   @i_cotizacion        money        = NULL,  
   @i_tipo_tran         char(1)      = NULL,
   @i_tipo_doc          char(1)      = NULL,
   @i_moneda            int,
   @i_param1            varchar(20)  = NULL,
   @i_param2            varchar(20)  = NULL,
   @i_param3            varchar(20)  = NULL,
   @i_param4            varchar(20)  = NULL,
   @i_param5            varchar(20)  = NULL,
   @i_param6            varchar(20)  = NULL,
   @i_param7            varchar(20)  = NULL,
   @i_param8            varchar(20)  = NULL,
   @i_param9            varchar(20)  = NULL,
   @i_param10           varchar(20)  = NULL,
   @i_fecha_valor_old   datetime     = NULL  -- GES 04/08/1999 Contab.congeladas
)
with encryption
as 
declare
   @w_return            int,        /* valor que retorna */
   @w_sp_name           varchar(32),    /* nombre del stored procedure*/
   @w_moneda            int,        /* codigo de moneda de la cuenta */
   @w_cuenta            varchar(20),
   @w_debito            money,
   @w_credito           money,
   @w_debito_me         money,
   @w_credito_me        money,
   @w_moneda_base       int,
   @w_posini            int,
   @w_posfin            int,
   @w_count             int,
   @w_clave             varchar(20),
   @w_string            varchar(20),
   @w_string2           varchar(30),
   @w_paso              int,
   @w_moneda_cuenta     int,
   @w_ley               char(1),
   @w_flag              char(1),
   @w_num_anterior      cuenta,
   @w_monto_total       money,
   @w_valor_renovado    money,
   @w_mm_subsecuencia   tinyint,
   @w_fecha_valor       datetime,
   @w_reestruc          char(1),
   @w_usadeci           char(1),
   @w_numdeci           tinyint,
   @w_fecha_tran        datetime,  -- GES 12/17/01 CUZ-053-003
   @w_oficina_dest      int         -- GES 04/23/2002 CUZ-071-001
        

select 
   @w_sp_name = 'sp_sasiento',
   @w_cuenta  = ''


/* Encuentra parametro de decimales */
select @w_usadeci = isnull(mo_decimales, 'S')
from cobis..cl_moneda
where mo_moneda = @i_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,2)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0                        


   select @w_moneda_base = em_moneda_base
   from cob_conta..cb_empresa where em_empresa = @i_empresa

   select @w_posini = 1, @w_posfin = 0, @w_count = 0
   
   while @w_posfin < datalength(@i_cuenta)  -- Reemplazar parametros 
                                            -- SQLSE65-MCA-E005 10/12/1999
     begin
        select @w_string = substring(@i_cuenta,@w_posini,datalength(@i_cuenta))
                                            -- SQLSE65-MCA-E005 10/12/1999

        select @w_posfin = charindex('.',@w_string)
        if @w_posfin = 0
           select @w_posfin = datalength(@i_cuenta)
                                            -- SQLSE65-MCA-E005 10/12/1999
        else
           select @w_posfin = @w_posfin - 1
                       
        select @w_string = substring(@i_cuenta,@w_posini,@w_posfin)

        if ascii(@w_string) > 47 and ascii(@w_string) < 58 -- Es Parte numerica
        begin
           select @w_cuenta = @w_cuenta + rtrim(@w_string)
           select @w_posini = @w_posini + @w_posfin + 1 --No considera el punto 
           continue
        end
        select @w_count = @w_count + 1
        select @w_paso = 0
        if @w_count = 1
        begin 
           select @w_clave = @i_param1
           goto ObtieneSubstring
        end
        if @w_count = 2
        begin 
           select @w_clave = @i_param2
           goto ObtieneSubstring
        end
        if @w_count = 3
        begin 
           select @w_clave = @i_param3
           goto ObtieneSubstring
        end
        if @w_count = 4
        begin 
           select @w_clave = @i_param4
           goto ObtieneSubstring
        end
        if @w_count = 5
        begin 
           select @w_clave = @i_param5
           goto ObtieneSubstring
        end
        if @w_count = 6
        begin 
           select @w_clave = @i_param6
           goto ObtieneSubstring
        end
        if @w_count = 7
        begin 
           select @w_clave = @i_param7
           goto ObtieneSubstring
        end
        if @w_count = 8
        begin 
           select @w_clave = @i_param8
           goto ObtieneSubstring
        end
        if @w_count = 9
        begin 
           select @w_clave = @i_param9
           goto ObtieneSubstring
        end
        if @w_count = 10
        begin 
           select @w_clave = @i_param10
           goto ObtieneSubstring
        end

        ObtieneSubstring:
        if @w_clave = '' 
           if @w_string = 'CAJERO' 
              select @w_paso = 1
           else 
              select @w_paso = 0
  
        if @w_paso = 0
        begin  
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
           from cob_conta..cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @w_clave
           if @@rowcount = 0 and @w_paso = 0
           begin
              print 'SASIENTO.SP PARAMETRO, CLAVE, EMPRESA: '+ @w_string + ', ' + @w_clave + ', ' + cast(@i_empresa as varchar)
              return 141145
           end           
        end 

        select @w_posini = @w_posini + @w_posfin + 1 --No considera el punto 
   End -- fin del while

/* GES 02/10/1999 MANEJO DE EXCEPCIONES DE ACUERDO A LA MONEDA DE LA CUENTA*/

      if @i_moneda <> @w_moneda_base 
      begin
         select @w_moneda_cuenta = cu_moneda
         from cob_conta..cb_cuenta
         where cu_empresa = @i_empresa
         and   cu_cuenta = @w_cuenta
         and   cu_movimiento = 'S'
         if @@rowcount = 0 
         begin
            print 'sasiento.sp NO ENCUENTRA CUENTA %1! '+ cast(@w_cuenta      as varchar)
            return 141156
         end
         else
         if @w_moneda_cuenta = @w_moneda_base
         begin
            select @i_moneda = @w_moneda_cuenta, @i_valor_me =0    
         end
      end 



       /******** ******************************** ***************/

       if (@i_tipo_doc <> 'N' and @i_moneda = @w_moneda_base) or
          (@i_tipo_doc =  'C' and @i_debcred <> '1') or
          (@i_tipo_doc =  'V' and @i_debcred <> '2')
       begin
          return     141146
       end
       
       select @w_debito    = 0, @w_credito    = 0,
              @w_debito_me = 0, @w_credito_me = 0
              
       if @i_debcred = '1'
          begin
          select @w_debito    = isnull(@i_valor,0)
          select @w_debito_me = isnull(@i_valor_me,0)
          end
       else 
        begin
          select @w_credito   = isnull(@i_valor,0)
          select @w_credito_me = isnull(@i_valor_me,0)
        end
       if @i_moneda <> @w_moneda_base 
          select @i_cotizacion = round(@i_cotizacion,@w_numdeci)
       else select @i_cotizacion = 0

       --I. CVA Jun-14-06 Obtener fecha con la que se grabaran los comprobantes contables
       exec sp_fecha_contable
          @i_fecha_proceso  = @i_fecha_tran,
          @o_fecha_contable = @w_fecha_tran out 
          
       if @w_fecha_tran is null
       begin
         exec sp_primer_dia_labor 
            @t_debug       = @t_debug, 
            @t_file        = @t_file,
            @t_from        = @w_sp_name, 
            @i_fecha       = @i_fecha_tran,
            @s_ofi         = @s_ofi,
            -- @i_flag_conta  = 1,               GAL 21/AGO/2009 - CSQL
            @o_fecha_labor = @w_fecha_tran out
       end
       --F. CVA Jun-14-06 Obtener fecha con la que se grabaran los comprobantes contables         


   /* Si es un impuesto debe registrarse!! */
   if @w_string not in ('RETE','IVA', 'ICA') --NYM DPF00015 ICA   --ral06-13-2000 Contab. Tercero
      select @w_string = NULL

        -- GES 04/23/2002 CUZ-071-002 Oficina 99 para camara de compensacion
        if @w_cuenta = '112011000101' or @w_cuenta = '112012000101'
           select @w_oficina_dest = 99
        else
           select @w_oficina_dest = @i_oficina_dest
-- print 'Cta: ' + @w_cuenta + ',Cr: ' + cast(@w_credito as varchar) + ',Db: ' + cast(@w_debito as varchar) + 'Conc: ' + @i_concepto 
-- print 'Cr me:' + cast(@w_credito_me as varchar) + 'Db me:' + cast(@w_debito_me as varchar)+ 'Str: ' + @w_string
   insert into pf_sasiento     (
      sa_fecha_tran,sa_comprobante,sa_empresa,
      sa_asiento,sa_cuenta,sa_moneda,sa_tipo_tran,
      sa_oficina_dest,sa_area_dest,sa_tipo_doc,
      sa_credito,sa_debito,sa_concepto,sa_estado,
      sa_credito_me,sa_debito_me,sa_cotizacion,
      sa_ente,sa_param_imp)   --ral06-13-2000 Contab. Terceros
      
   values (@w_fecha_tran,@i_comprobante,@i_empresa,  -- CUZ-053-002
      @i_asiento,@w_cuenta,@i_moneda,'I',
      @w_oficina_dest,   -- GES 04/23/2002 CUZ-071-003
                @i_area_dest,@i_tipo_doc,
      @w_credito,@w_debito,@i_concepto,'I',
      @w_credito_me,@w_debito_me,@i_cotizacion,
      @i_ente,@w_string)   --ral06-13-2000 Contab. Terceros

   if @@error <> 0  
   begin
--print 'moneda base %1!', @w_moneda_base
--print 'cotizacion %1!', @i_cotizacion

--print 'FECHA %1!, COMPROBANTE %2!, EMPRESA %3!', @i_fecha_tran, @i_comprobante, @i_empresa
--print 'ASIENTO %1!, CUENTA %2!, MONEDA %3!', @i_asiento, @w_cuenta, @i_moneda
--print 'OFICINA %1!, AREA %2!, TIPO_DOC %3!', @i_oficina_dest, @i_area_dest, @i_tipo_doc
--print 'CREDITO %1!, DEBITO %2!, CONCEPTO %3!', @w_credito, @w_debito, @i_concepto
--print 'sasiento.sp CREDITO_ME %1!, DEBITO_ME %2!, COTIZACION %3!', @w_credito_me, @w_debito_me, @i_cotizacion
               -- print 'ERROR INSERCION PF_SASIENTO '
      delete pf_sasiento
            where   sa_fecha_tran = @i_fecha_tran and
         sa_comprobante = @i_comprobante and
              sa_empresa = @i_empresa 
      return     141086
   end
return 0


go
