/*******************************************************************/
/*    Archivo:              comprobf.sp                            */
/*    Stored procedure:     sp_comprobante                         */
/*    Base de datos:        cob_conta                              */
/*    Producto:             contabilidad                           */
/*    Disenado por:                                                */
/*    Fecha de escritura:   30-julio-1993                          */
/*******************************************************************/
/*                IMPORTANTE                                       */
/*    Este programa es parte de los paquetes bancarios propiedad de*/
/*    'MACOSA', representantes exclusivos para el Ecuador de la    */
/*    'NCR CORPORATION'.                                           */
/*    Su uso no autorizado queda expresamente prohibido asi como   */
/*    cualquier alteracion o agregado hecho por alguno de sus      */
/*    usuarios sin el debido consentimiento por escrito de la      */
/*    Presidencia Ejecutiva de MACOSA o su representante.          */
/*                            PROPOSITO                            */
/*    Este programa procesa las transacciones de:                  */
/*    copia desde las tablas temporales de comprobantes y asientos */
/*    a las tablas definitivas, Mayorizacion de los asientos       */
/*                          MODIFICACIONES                         */
/*    FECHA        AUTOR          RAZON                            */
/*    30/Jul/1993  G. Jaramillo   Emision Inicial                  */
/*    21/Jun/1994  G. Jaramillo   Eliminacion de secciones         */
/*    10/Mar/1995  E. Suasti      Pase Parametro de Autorizado     */
/*    16/Mar/1995  M. Suarez      implementacion de opcion Search  */
/*    30/ene/1996  M. Suarez      implementacion de opcion Update  */
/*    25/Ene/1997  R. Villota     RV001, RV002, RV003              */
/*    01/Jun/1998  F. Salgado     Arreglo inconsistencia tablas    */
/*    05/Mar/1999  C. De Orcajo   Especificacion COR037            */
/*    21/Jun/1999  F. Cardona     Manejo de terceros desde MIS     */
/*    26/Mar/2003  A. Nunz        Esp. CO00040 Se añade reversado  */
/*    21/Oct/2005  M. Rincon      Transacciones de Servicio        */
/*    12/Ago/2006  M. Rincon      Control Ejecucion Mayorizacion   */
/*    12/Ago/2017  X. Almache     Corrección Mayorizacion          */
/*    25/Sep/2017  X. Almache     Campo as_concepto_adi            */
/*    15/Ene/2017  D. Cumbal      Quitar parametro APLRET          */
/*******************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comprobante')
    drop proc sp_comprobante
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_comprobante (
       @s_ssn              int = null,
       @s_date             datetime = null,
       @s_user             login = null,
       @s_term             descripcion = null,
       @s_corr             char(1) = null,
       @s_ssn_corr         int = null,
       @s_ofi              smallint = null,
       @t_rty              char(1) = null,
       @t_trn              smallint = null,
       @t_debug            char(1) = 'N',
       @t_file             varchar(14) = null,
       @t_from             varchar(30) = null,
       @i_operacion        char(1) = null,
       @i_modo             smallint = null,
       @i_empresa          tinyint = null, 
       @i_fecha_tran       datetime = null,
       @i_comprobante      int = null, 
       @i_oficina          smallint = null,
       @i_mayorizar        char(1) = null,
       @i_asiento          smallint = null,
       @i_detalles         smallint = null,
       @i_tot_debito       money = null,
       @i_tot_credito      money = null,
       @i_tot_debito_me    money = null,
       @i_tot_credito_me   money = null,
       @i_formato_fecha    tinyint = 1,
       @i_autorizado       char(1) = null,
       @i_autorizante      descripcion = null,
       @i_anula            char(2) = null ,    
       @i_mayorizado       char(1) = 'N',
       @i_comprobante1     int     = null,
       @i_msg              tinyint = 0,
       @i_usuario          login = null,
       @i_tipo_compro      char(1) = null,  /*RV001*/
       @i_estado           char(1) = null,   /*RV001*/        
       @i_cuenta           cuenta = null, /*RV003*/
       @i_oficina_orig     smallint = null,
       @i_proceso          char(1)  = null,
       @i_reversa          char(1)  = null,
       @i_fecha_tran1      datetime = null,
       @i_comprobante2     int = null,
       @i_origen           char(1) = 'B'
)
as 

declare @w_today               char(12),      /* fecha del dia */
        @w_return              int,        /* valor que retorna */
        @w_sp_name             varchar(32),    /* nombre del stored procedure*/
        @w_siguiente           int,
        @w_numero              int,
        @w_numeretencion       int,
        @w_comprobante         int,
        @w_empresa             tinyint,
        @w_oficina_dest        smallint,
        @w_oficina_orig        smallint,
        @w_area_orig           smallint,
        @w_detalles            int,
        @w_reversado           char(1),
        @wa_reversado          char(1),
        @w_autorizado          char(1),
        @w_tipo_doc            char(1),
        @wa_autorizado         char(1),
        @w_tipo_tran           char(1),
        @w_tot_debito          money,
        @w_tot_credito         money,
        @w_tot_debito_me       money,
        @w_tot_credito_me      money,
        @w_td_detalles         int,
        @w_td_debito           money,
        @w_td_credito          money,
        @flag1                 int,
        @w_fecha_tran          datetime,
        @w_asiento             int,
        @w_cuenta              cuenta,
        @w_debito              money,
        @w_credito             money,
        @w_debito_me           money,
        @w_credito_me          money,
        @w_moneda              tinyint,
        @w_area_dest           smallint,
        @wa_area_orig          smallint,
        @w_operacion           int,
        @w_descripcion         char(255),
        @w_comp_tipo           int,
        @wt_mayorizado         char(1),
        @wta_concepto          descripcion, 
        @w_num_reg             int,
        @w_mayorizado          char(1),
        @w_mayoriza            char(1),
        @wa_oficina_orig       smallint,
        @wa_depto_orig         tinyint,
        @wa_fecha_tran         datetime,
        @wa_descripcion        char(255),
        @wa_comp_tipo          int,
        @wa_detalles           smallint,
        @wa_tot_debito         money,
        @wa_tot_credito        money,
        @wa_tot_debito_me      money,
        @wa_tot_credito_me     money,
        @wa_oficina_dest       smallint,
        @w_cotizacion          money,
        @wa_automatico         smallint,
        @w_automatico          smallint,
        @w_numerror            int,
        @w_salida              varchar(20),
        @w_tabla               int,
        @w_tipo                varchar(3),
        @w_error               int,
        @w_cuenta_ind          cuenta_contable,
        @w_cuenta_ind_base     cuenta_contable,
        @w_cuenta_ind_max      cuenta_contable,
        @w_asientos_cuenta     int,
        @w_i                   int,
        @w_td_debito_bal       money,
        @w_td_credito_bal      money,
        @w_aplica_retencion    char(1),
        @w_otro_user           char(1)

select @w_today = convert(char(12),getdate(),@i_formato_fecha)
select @w_sp_name = 'sp_comprobante' , @w_numerror = 0
-- temporal error del kernel select @s_user =@i_usuario

select @w_aplica_retencion = isnull(pa_char,'S') --Parametro de retencion en caso de no aplicar se coloca N 
from cobis..cl_parametro with (nolock)
where pa_nemonico = 'APLRET'
  and pa_producto = 'CON'


/************************************************/
/*  Tipo de Transaccion = 611X             */

if (@t_trn <> 6342 and @i_operacion = 'I') or
   (@t_trn <> 6112 and @i_operacion = 'M') or
   (@t_trn <> 6113 and @i_operacion = 'U') or
   (@t_trn <> 6116 and @i_operacion = 'Q') or
   (@t_trn <> 6116 and @i_operacion = 'R') or
   (@t_trn <> 6114 and @i_operacion = 'S') or
   (@t_trn <> 6117 and @i_operacion = 'A') or
   (@t_trn <> 6110 and @i_operacion = 'P') or  /*RV002*/
   (@t_trn <> 6613 and @i_operacion = 'B')  /* Busqueda de Facturas */
begin
    /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @i_num     = 601077
    return 1
end
/************************************************/



select @w_operacion   = 1,
       @wt_mayorizado = 'N'

/*    
if @i_origen = 'B'
begin
     select @s_user = 'operador'
     select @s_term = 'vbatch'
     select @s_ofi  = 9000
     select @i_proceso = 'R'
end     
*/

if (@s_ofi is null or @s_term is null or @s_user is null)
begin
     select @s_ofi     = 9000,
            @s_term    = 'consola',
            @s_user    = 'operador',
            @i_proceso = 'R'
end

if @i_operacion = 'I' or @i_operacion = 'U'
begin
        select @w_today = getdate()
    /********* LEE CABECERA DEL COMPROBANTE  ****/
    select     @w_detalles     = @i_detalles,
         @w_tot_debito     = ct_tot_debito,
        @w_tot_credito    = ct_tot_credito,
        @w_tot_debito_me = ct_tot_debito_me,
        @w_tot_credito_me = ct_tot_credito_me,
        @w_fecha_tran     = ct_fecha_tran ,
        @w_descripcion    = ct_descripcion,
        @w_comp_tipo    = ct_comp_tipo,
        @w_mayoriza    = ct_mayoriza,
        @w_automatico    = ct_automatico,
        @w_oficina_orig = ct_oficina_orig,
        @w_area_orig    = ct_area_orig,
        @w_reversado    = ct_reversado,
        @w_autorizado    = ct_autorizado
    from cob_conta..cb_tcomprobante
    where     ct_fecha_tran     = @i_fecha_tran and
        ct_comprobante     = @i_comprobante and
        ct_empresa     = @i_empresa and
                ct_oficina_orig = @i_oficina_orig

    if @@rowcount <> 1 
    begin
    --Codigo de Comprobante NO existe o esta duplicado en tabla temporal
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601062

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig
         
         delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        



            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and 
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and  
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 


        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end
    /******** VALIDACION DE CUADRE DE CUENTAS DE BALANCE *****/
    select     @w_td_debito_bal     = isnull(sum(ta_debito),0),
               @w_td_credito_bal    = isnull(sum(ta_credito),0)
    from cb_tasiento
    where     ta_empresa = @i_empresa and
            ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_oficina_orig = @i_oficina_orig and
            substring(ta_cuenta,1,1) in (select cp_cuenta 
                                         from cob_conta..cb_cuenta_proceso
                                         where cp_proceso = 6005)

    if round(@w_td_debito_bal,2) <> round(@w_td_credito_bal,2)
    begin
    /* Total Creditos diferente al total registrado en tabla temporal */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601186

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

        delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        


            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end
    /******** LEE DATOS DE LOS DETALLES *****/
    /* 1) TOTAL DE DEBITOS Y CREDITOS       */
    /* 2) NUMERO DE DETALLES                */

    select     @w_td_debito     = sum(ta_debito),
               @w_td_credito     = sum(ta_credito),
        @w_td_detalles     = count(*)
    from cb_tasiento
    where     ta_empresa = @i_empresa and
        ta_fecha_tran = @i_fecha_tran and
        ta_comprobante = @i_comprobante and
                ta_oficina_orig = @i_oficina_orig

    /******** COMPARA CON DATOS DE CABECERA ********/
    if @i_detalles <> @w_td_detalles 
    begin
     /* Nro. de detalles diferente al total registrado en tabla temporal */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601057

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

         delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        


            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end 

    if round(@i_tot_debito,2) <> round(@w_td_debito,2)
    begin
    /* Total de Debitos diferente al total registrado en tabla temporal */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601058

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

        delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        


            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end

    if round(@i_tot_credito,2) <> round(@w_td_credito,2) 
    begin
    /* Total Creditos diferente al total registrado en tabla temporal */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601059

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

        delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        


            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end
    /*if @w_td_debito <> @w_td_credito
    begin
        -- Total de debitos y creditos en tabla temporal descuadrados
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601056

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end */

if @i_operacion = 'U'
begin

     if exists (select * from cb_asiento 
                where as_empresa       = @i_empresa
                and as_fecha_tran      = @i_fecha_tran
                and as_comprobante     = @i_comprobante1
                and as_oficina_orig    = @i_oficina_orig
                and as_mayorizado      = 'S')
            
      begin
      
             -- Comprobante/Asiento esta mayorizado no puede ser modificado
             exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num     = 607056
             delete cob_conta..cb_tasiento
             where  ta_fecha_tran   = @i_fecha_tran     and
                       ta_comprobante  = @i_comprobante    and
                    ta_empresa      = @i_empresa        and
                    ta_oficina_orig = @i_oficina_orig

             delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        

               delete cob_conta..cb_tretencion
                  where   tr_fecha         = @i_fecha_tran     and
                          tr_comprobante   = @i_comprobante    and
                          tr_empresa       = @i_empresa        and
                          tr_oficina_orig  = @i_oficina_orig

             -- Inicio - Conciliacion 
             delete cob_conta..cb_tconciliacion
             where  tc_fecha        = @i_fecha_tran    and
                    tc_comprobante  = @i_comprobante   and
                    tc_empresa      = @i_empresa       and
                    tc_oficina_orig = @i_oficina_orig
             -- Fin - Conciliacion 

            delete cob_conta..cb_tcomprobante
            where  ct_fecha_tran      = @i_fecha_tran     and
                   ct_comprobante     = @i_comprobante    and
                   ct_empresa         = @i_empresa        and
                   ct_oficina_orig    = @i_oficina_orig
                  
            return 1
           
           end


           
           select @w_today      = co_fecha_dig,
                  @w_autorizado = co_autorizado 
           from cb_comprobante 
           where co_empresa      = @i_empresa
           and co_fecha_tran     = @i_fecha_tran
           and co_comprobante    = @i_comprobante1
           and co_oficina_orig   = @i_oficina_orig
           if @w_autorizado <> 'N'
           begin
           
                   -- Comprobante aprobado o anulado, no puede modificarse
                      exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num     = 607053

                  delete cob_conta..cb_tasiento
                  where  ta_fecha_tran    = @i_fecha_tran     and
                         ta_comprobante   = @i_comprobante    and
                         ta_empresa       = @i_empresa        and
                         ta_oficina_orig  = @i_oficina_orig

                 delete cob_conta..cb_tconcepto_asiento
                 where  ca_fecha_tran    = @i_fecha_tran      
                 and    ca_comprobante   = @i_comprobante    
                 and    ca_empresa       = @i_empresa        


               delete cob_conta..cb_tretencion
               where   tr_fecha       = @i_fecha_tran     and
                       tr_comprobante = @i_comprobante    and
                       tr_empresa     = @i_empresa        and
                       tr_oficina_orig = @i_oficina_orig

                -- Inicio - Conciliacion 
               delete cob_conta..cb_tconciliacion
               where   tc_fecha           = @i_fecha_tran     and
                       tc_comprobante     = @i_comprobante    and
                       tc_empresa         = @i_empresa        and
                       tc_oficina_orig    = @i_oficina_orig
              -- Fin - Conciliacion 

              delete cob_conta..cb_tcomprobante
              where  ct_fecha_tran        = @i_fecha_tran     and
                     ct_comprobante       = @i_comprobante    and
                     ct_empresa           = @i_empresa        and
                     ct_oficina_orig      = @i_oficina_orig
            return 1
       
       end
       select @w_siguiente = @i_comprobante1

 end

if @i_operacion = 'I'
begin
            if @i_reversa = 'S'
            begin
               select 1 from cob_conta..cb_comprobante
               where co_fecha_tran = @i_fecha_tran1
               and   co_comprobante = @i_comprobante2
               and   co_oficina_orig = @i_oficina_orig
               and   co_empresa = @i_empresa
               and   co_automatico in (select ba_batch from cobis..ba_batch
                                       where ba_arch_fuente = 'cb_consu.sqr')           
               if @@rowcount > 0
               begin
                  print 'Comprobante No puede ser reversado'
                  return 1
               end
            end
            -- Obtiene el numero secuencial definitivo
            exec @w_return      = cob_conta..sp_cseqcomp
                 @i_empresa     = @i_empresa,
                 @i_fecha       = @i_fecha_tran,
                 @i_tabla       = 'cb_comprobante',
                 @i_modulo      = 6,
                 @i_modo        = 3,
                 @i_oficina     = @w_oficina_orig,
                 @o_siguiente   = @w_siguiente out
                 if @w_return <> 0
                    begin
                         return @w_return
                    end
end
delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
insert cob_conta..cb_usu_capt_comp values (@s_ofi,@s_term,@s_user,@i_proceso,'E',getdate())
begin tran 
/******** GRABA LA CABECERA DEL COMPROBANTE *******/
if @i_operacion = 'U'
begin
                        delete cb_comprobante 
                        where co_empresa      = @i_empresa
                        and   co_fecha_tran   = @i_fecha_tran
                        and   co_comprobante  = @i_comprobante1
                        and   co_oficina_orig = @i_oficina_orig
                        if @@error <> 0
                           begin
                                -- Error al borrar el comprobante 
                                exec cobis..sp_cerror
                                     @t_debug  = @t_debug,
                                     @t_file   = @t_file,
                                     @t_from   = @w_sp_name,
                                      @i_num       = 607055

                                  delete cob_conta..cb_tasiento
                                where ta_fecha_tran   = @i_fecha_tran 
                                and   ta_comprobante  = @i_comprobante 
                                and   ta_empresa      = @i_empresa 
                                and   ta_oficina_orig = @i_oficina_orig



                                delete cob_conta..cb_tconcepto_asiento
                                where  ca_fecha_tran    = @i_fecha_tran      
                                and    ca_comprobante   = @i_comprobante    
                                and    ca_empresa       = @i_empresa        




                                delete cob_conta..cb_tretencion
                                where   tr_fecha        = @i_fecha_tran 
                                and     tr_comprobante  = @i_comprobante 
                                and     tr_empresa      = @i_empresa 
                                and     tr_oficina_orig = @i_oficina_orig

                                -- Inicio - Conciliacion 
                                delete cob_conta..cb_tconciliacion
                                where  tc_fecha        = @i_fecha_tran 
                                and    tc_comprobante  = @i_comprobante 
                                and    tc_empresa      = @i_empresa 
                                and    tc_oficina_orig = @i_oficina_orig
                                -- Fin - Conciliacion 

                               delete cob_conta..cb_tcomprobante
                               where  ct_fecha_tran    = @i_fecha_tran 
                               and    ct_comprobante   = @i_comprobante 
                               and    ct_empresa       = @i_empresa 
                               and    ct_oficina_orig  = @i_oficina_orig
                                  
                               return 1
                         end
           
                    delete cb_asiento 
                    where as_empresa    = @i_empresa
                    and as_fecha_tran   = @i_fecha_tran
                    and as_comprobante  = @i_comprobante1 
                    and as_oficina_orig = @i_oficina_orig
                   if @@error <> 0
                       begin
                               -- Error al borrar los asientos del comprob.  
                              exec cobis..sp_cerror
                                  @t_debug   = @t_debug,
                                  @t_file     = @t_file,
                                  @t_from     = @w_sp_name,
                                  @i_num     = 607054

                              delete cob_conta..cb_tasiento
                              where   ta_fecha_tran   = @i_fecha_tran 
                              and     ta_comprobante  = @i_comprobante 
                              and     ta_empresa      = @i_empresa 
                              and     ta_oficina_orig = @i_oficina_orig

                              delete cob_conta..cb_tconcepto_asiento
                              where  ca_fecha_tran    = @i_fecha_tran      
                              and    ca_comprobante   = @i_comprobante    
                              and    ca_empresa       = @i_empresa        


                              delete cob_conta..cb_tretencion
                              where  tr_fecha         = @i_fecha_tran 
                              and    tr_comprobante   = @i_comprobante 
                              and    tr_empresa       = @i_empresa 
                              and    tr_oficina_orig  = @i_oficina_orig

                              -- Inicio - Conciliacion 
                              delete cob_conta..cb_tconciliacion
                              where  tc_fecha          = @i_fecha_tran 
                              and    tc_comprobante    = @i_comprobante 
                              and    tc_empresa        = @i_empresa 
                              and    tc_oficina_orig   = @i_oficina_orig
                               -- Fin - Conciliacion 

                              delete cob_conta..cb_tcomprobante
                              where ct_fecha_tran     = @i_fecha_tran 
                              and      ct_comprobante    = @i_comprobante 
                              and    ct_empresa        = @i_empresa 
                              and   ct_oficina_orig   = @i_oficina_orig
                             return 1
                       end
                    -- *** SOLO PARA MO`VIMIENTOS DE PROVISION ***
                     delete cob_conta..cb_concepto_asiento 
                    where ca_empresa    = @i_empresa
                    and ca_fecha_tran   = @i_fecha_tran
                    and ca_comprobante  = @i_comprobante1 
                    and ca_oficina_ori = @i_oficina_orig
                    if @@error <> 0
                       begin
                               -- Error al borrar los asientos del comprob.  
                              exec cobis..sp_cerror
                                  @t_debug   = @t_debug,
                                  @t_file     = @t_file,
                                  @t_from     = @w_sp_name,
                                  @i_num     = 607054

                              delete cob_conta..cb_tasiento
                              where   ta_fecha_tran   = @i_fecha_tran 
                              and     ta_comprobante  = @i_comprobante 
                              and     ta_empresa      = @i_empresa 
                              and     ta_oficina_orig = @i_oficina_orig

                              delete cob_conta..cb_tconcepto_asiento
                              where  ca_fecha_tran    = @i_fecha_tran      
                              and    ca_comprobante   = @i_comprobante    
                              and    ca_empresa       = @i_empresa        


                              delete cob_conta..cb_tretencion
                              where  tr_fecha         = @i_fecha_tran 
                              and    tr_comprobante   = @i_comprobante 
                              and    tr_empresa       = @i_empresa 
                              and    tr_oficina_orig  = @i_oficina_orig

                              -- Inicio - Conciliacion 
                              delete cob_conta..cb_tconciliacion
                              where  tc_fecha          = @i_fecha_tran 
                              and    tc_comprobante    = @i_comprobante 
                              and    tc_empresa        = @i_empresa 
                              and    tc_oficina_orig   = @i_oficina_orig
                               -- Fin - Conciliacion 

                              delete cob_conta..cb_tcomprobante
                              where ct_fecha_tran     = @i_fecha_tran 
                              and      ct_comprobante    = @i_comprobante 
                              and    ct_empresa        = @i_empresa 
                              and   ct_oficina_orig   = @i_oficina_orig
                             return 1
                       end





                  delete cb_retencion
                  where re_empresa      = @i_empresa 
                  and   re_fecha        = @i_fecha_tran 
                  and   re_comprobante  = @i_comprobante1 
                  and   re_oficina_orig = @i_oficina_orig
           
                 if @@error <> 0
                   begin
                         -- Error al borrar los datos de retencion
                         exec cobis..sp_cerror
                              @t_debug    = @t_debug,
                              @t_file      = @t_file,
                              @t_from      = @w_sp_name,
                              @i_num      = 607126

                         delete cob_conta..cb_tasiento
                         where  ta_fecha_tran     = @i_fecha_tran 
                         and    ta_comprobante    = @i_comprobante 
                         and    ta_empresa        = @i_empresa 
                         and    ta_oficina_orig   = @i_oficina_orig

                         delete cob_conta..cb_tconcepto_asiento
                        where  ca_fecha_tran    = @i_fecha_tran      
                        and    ca_comprobante   = @i_comprobante    
                        and    ca_empresa       = @i_empresa        


                        delete cob_conta..cb_tretencion
                        where   tr_fecha        = @i_fecha_tran 
                        and       tr_comprobante  = @i_comprobante 
                        and        tr_empresa      = @i_empresa 
                        and     tr_oficina_orig = @i_oficina_orig

                        -- Inicio - Conciliacion 
                        delete cob_conta..cb_tconciliacion
                        where   tc_fecha           = @i_fecha_tran 
                        and       tc_comprobante     = @i_comprobante 
                        and        tc_empresa         = @i_empresa 
                        and     tc_oficina_orig    = @i_oficina_orig
                        -- Fin - Conciliacion 

                       delete cob_conta..cb_tcomprobante
                       where     ct_fecha_tran    = @i_fecha_tran 
                       and        ct_comprobante   = @i_comprobante 
                       and        ct_empresa       = @i_empresa 
                       and       ct_oficina_orig  = @i_oficina_orig
                       return 1
                   end
             -- Inicio - Conciliacion
             delete cb_conciliacion
             where cl_empresa       = @i_empresa 
             and   cl_fecha         = @i_fecha_tran 
             and   cl_comprobante   = @i_comprobante1 
             and   cl_oficina_orig  = @i_oficina_orig

           if @@error <> 0
               begin
                   -- Error al borrar los datos de retencion
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num     = 607126

                  delete cob_conta..cb_tasiento
                  where   ta_fecha_tran       = @i_fecha_tran
                  and     ta_comprobante      = @i_comprobante
                  and     ta_empresa          = @i_empresa 
                  and     ta_oficina_orig     = @i_oficina_orig


                  delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        


                  delete cob_conta..cb_tretencion
                  where   tr_fecha              = @i_fecha_tran 
                  and     tr_comprobante        = @i_comprobante 
                  and     tr_empresa            = @i_empresa 
                  and     tr_oficina_orig       = @i_oficina_orig

                  -- Inicio - Conciliacion 
                  delete cob_conta..cb_tconciliacion
                  where tc_fecha                = @i_fecha_tran 
                  and   tc_comprobante          = @i_comprobante 
                  and   tc_empresa              = @i_empresa 
                  and   tc_oficina_orig         = @i_oficina_orig
                  -- Fin - Conciliacion 

                  delete cob_conta..cb_tcomprobante
                  where     ct_fecha_tran          = @i_fecha_tran 
                  and    ct_comprobante         = @i_comprobante 
                  and    ct_empresa             = @i_empresa 
                  and    ct_oficina_orig        = @i_oficina_orig
                  return 1
               end -- Fin - Conciliacion
end

     /***************************/
     /* TRANSACCION DE SERVICIO    */
     /***************************/
     insert into ts_comprobante
          values (@i_comprobante,@t_trn,'I',getdate(),@s_user,
                 @s_term,@s_ofi,@i_empresa,@wa_oficina_dest,@i_comprobante,
                 @w_oficina_orig,@w_area_orig,@w_fecha_tran,@w_descripcion,@w_comp_tipo,
                 @w_detalles,@w_tot_debito,@w_tot_credito,@w_tot_debito_me,@w_tot_credito_me)
     if @@error <> 0
     begin
     /* 'Error en insercion de transaccion de servicio' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 603032
         return 1
     end
      insert into cb_comprobante
                ( co_comprobante,co_empresa,co_fecha_tran,
                  co_oficina_orig,co_area_orig,co_fecha_dig,
                  co_fecha_mod,co_digitador,co_descripcion,
                  co_mayorizado,co_comp_tipo,co_detalles,
                  co_tot_debito,co_tot_credito,co_tot_debito_me,
                  co_tot_credito_me,co_automatico,co_reversado,
                  co_autorizado,co_autorizante,co_referencia,
                  co_tipo_compro,co_estado,co_traslado)  /*RV001*/
       select     @w_siguiente,ct_empresa,ct_fecha_tran,
                ct_oficina_orig,ct_area_orig,@w_today,
                ct_fecha_mod,ct_digitador,ct_descripcion,
                @wt_mayorizado,ct_comp_tipo,@i_detalles,
                @i_tot_debito,@i_tot_credito,@i_tot_debito_me,
                @i_tot_credito_me,ct_automatico,ct_reversado,
                ct_autorizado,ct_autorizante,ct_referencia,
                @i_tipo_compro,@i_estado,'N'
       from cb_tcomprobante
       where ct_fecha_tran      = @i_fecha_tran 
       and   ct_comprobante   = @i_comprobante 
       and     ct_empresa       = @i_empresa 
       and   ct_oficina_orig  = @i_oficina_orig

       if @@error <> 0
           begin
--print '1'
        -- Error en insercion de comprobante
                  exec cobis..sp_cerror
                      @t_debug   = @t_debug,
                      @t_file     = @t_file,
                      @t_from     = @w_sp_name,
                      @i_num     = 603025
                      --print 'insercion %1!', @w_siguiente
                      print '603025 4'
                  delete cob_conta..cb_tasiento
                  where ta_fecha_tran     = @i_fecha_tran 
                  and   ta_comprobante    = @i_comprobante 
                  and   ta_empresa        = @i_empresa 
                  and   ta_oficina_orig   = @i_oficina_orig
         
                  delete cob_conta..cb_tconcepto_asiento
                  where  ca_fecha_tran    = @i_fecha_tran      
                  and    ca_comprobante   = @i_comprobante    
                  and    ca_empresa       = @i_empresa        

                  delete cob_conta..cb_tretencion
                  where  tr_fecha          = @i_fecha_tran 
                  and       tr_comprobante    = @i_comprobante 
                  and    tr_empresa        = @i_empresa 
                  and    tr_oficina_orig   = @i_oficina_orig

                  -- Inicio - Conciliacion 
                  delete cob_conta..cb_tconciliacion
                  where   tc_fecha         = @i_fecha_tran 
                  and     tc_comprobante   = @i_comprobante 
                  and     tc_empresa       = @i_empresa 
                  and     tc_oficina_orig  = @i_oficina_orig
                  -- Fin - Conciliacion 

                  delete cob_conta..cb_tcomprobante
                  where     ct_fecha_tran    = @i_fecha_tran 
                  and       ct_comprobante   = @i_comprobante 
                  and        ct_empresa       = @i_empresa 
                  and       ct_oficina_orig  = @i_oficina_orig
                  return 1
           end

           --MAYORIZA Y GRABA CADA UNO DE LOS ASIENTOS
              select *
              into #_cuentas_tmp
              from cb_cuentas_tmp
              where 1=2
              
              create NONCLUSTERED INDEX cuentas_tmp_Key on #_cuentas_tmp (tmp_cuenta)
              
           select @flag1 = 1,  @w_asiento = 1
           while @flag1 > 0
                 begin
                      select     @w_empresa         = ta_empresa,
                                @w_oficina_dest  = ta_oficina_dest,
                                @w_area_dest     = ta_area_dest,
                                @w_cuenta          = ta_cuenta,
                                @w_credito          = ta_credito,
                                @w_debito          = ta_debito,
                                @w_credito_me     = ta_credito_me,
                                @w_debito_me     = ta_debito_me,
                                @w_cotizacion     = ta_cotizacion,
                                @w_mayorizado     = ta_mayorizado,
                                @w_tipo_doc         = ta_tipo_doc,
                                @w_tipo_tran     = ta_tipo_tran,
                                @w_moneda         = ta_moneda
                      from cb_tasiento
                      where    ta_fecha_tran    = @i_fecha_tran 
                      and   ta_comprobante  = @i_comprobante 
                      and   ta_empresa        = @i_empresa 
                      and   ta_asiento         = @w_asiento 
                      and   ta_oficina_orig = @i_oficina_orig
                      if @@rowcount > 0
                          begin
                              if @w_mayoriza = 'S'
                                  begin  -- Mayoriza el asiento 
                                  --XAL inserción en tabla #_cuentas_tmp
                                         delete #_cuentas_tmp
                                         if @@error <> 0
                                         begin    /* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
                                         exec cobis..sp_cerror
                                         @t_debug  = @t_debug,
                                         @t_file   = @t_file,
                                         @t_from   = @w_sp_name,
                                          @i_num       = 603024
                                         end
                                        select @w_i = 1
                                        insert #_cuentas_tmp values (@w_i, @w_cuenta,'U', 1)
                                        if @@error <> 0
                                        begin    /* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
                                         exec cobis..sp_cerror
                                         @t_debug  = @t_debug,
                                         @t_file   = @t_file,
                                         @t_from   = @w_sp_name,
                                          @i_num       = 603024
                                        end

                                        while 1=1
                                        begin
                                           select @w_i = @w_i + 1
                                        
                                           select @w_cuenta = cu_cuenta_padre
                                           from   cb_cuenta
                                           where  cu_empresa = @i_empresa
                                           and    cu_cuenta  = @w_cuenta
                                           
                                           if @@rowcount = 0
                                           begin    /* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
                                             exec cobis..sp_cerror
                                             @t_debug  = @t_debug,
                                             @t_file   = @t_file,
                                             @t_from   = @w_sp_name,
                                             @i_num       = 603024
                                              print 'Error: cuenta %1! no existe'+ @w_cuenta
                                           end
                                           
                                           if @w_cuenta = '' or @w_cuenta is null
                                              break
                                        
                                           insert #_cuentas_tmp values (@w_i, @w_cuenta,'U', 0)
                                           if @@error <> 0
                                           begin    /* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
                                             exec cobis..sp_cerror
                                             @t_debug  = @t_debug,
                                             @t_file   = @t_file,
                                             @t_from   = @w_sp_name,
                                             @i_num       = 603024
                                           end
                                        end

                                         exec @w_return = cob_conta..sp_mayoriza 
                                           null,null,null,null,null,null,null,null,
                                           6301,'N',null,null,
                                           @i_empresa,@w_fecha_tran,@w_cuenta,
                                           @w_oficina_dest,@w_area_dest,@w_credito,
                                           @w_debito,@w_credito_me,@w_debito_me,@w_operacion 
                                           if @w_return <> 0
                                              begin
                                                    -- Error al mayorizar
                                                    exec cobis..sp_cerror
                                                    @t_debug = @t_debug,
                                                    @t_file     = @t_file,
                                                    @t_from     = @w_sp_name,
                                                    @i_num     = 603021

                                                    delete cob_conta..cb_tasiento
                                                    where   ta_fecha_tran   = @i_fecha_tran 
                                                    and     ta_comprobante  = @i_comprobante 
                                                    and        ta_empresa      = @i_empresa 
                                                    and        ta_oficina_orig = @i_oficina_orig

                                                    delete cob_conta..cb_tconcepto_asiento
                                                    where  ca_fecha_tran    = @i_fecha_tran      
                                                    and    ca_comprobante   = @i_comprobante    
                                                    and    ca_empresa       = @i_empresa        


                                                    delete cob_conta..cb_tretencion
                                                    where   tr_fecha         = @i_fecha_tran 
                                                    and        tr_comprobante   = @i_comprobante 
                                                    and     tr_empresa       = @i_empresa 
                                                    and        tr_oficina_orig  = @i_oficina_orig

                                                   -- Inicio - Conciliacion 
                                                   delete cob_conta..cb_tconciliacion
                                                   where   tc_fecha            = @i_fecha_tran 
                                                   and     tc_comprobante      = @i_comprobante 
                                                   and     tc_empresa          = @i_empresa 
                                                   and       tc_oficina_orig     = @i_oficina_orig
                                                  -- Fin - Conciliacion 

                                                   delete cob_conta..cb_tcomprobante
                                                   where  ct_fecha_tran        = @i_fecha_tran 
                                                   and      ct_comprobante       = @i_comprobante 
                                                   and    ct_empresa           = @i_empresa 
                                                   and    ct_oficina_orig      = @i_oficina_orig
                                                   return 1
                                           end-- Error al mayorizar
                                           select @wt_mayorizado = 'S'
                                  end--@w_mayoriza = 'S'
                                   insert into cb_asiento(as_fecha_tran, as_comprobante,
                                                         as_empresa, as_asiento,as_cuenta,
                                                         as_oficina_dest, as_area_dest,
                                                         as_credito, as_debito,
                                                         as_concepto, as_credito_me,
                                                         as_debito_me, as_cotizacion,
                                                         as_mayorizado, as_tipo_doc,
                                                         as_tipo_tran,as_moneda,as_opcion,
                                                         as_fecha_est, as_detalle,
                                                         as_consolidado,as_oficina_orig,
                                                         as_concepto_adi) 
                                                select ta_fecha_tran, @w_siguiente, ta_empresa,
                                                       ta_asiento, ta_cuenta, ta_oficina_dest,
                                                       ta_area_dest,ta_credito,ta_debito,
                                                       ta_concepto, ta_credito_me, ta_debito_me,
                                                       ta_cotizacion, ta_mayorizado, ta_tipo_doc,
                                                       ta_tipo_tran, ta_moneda, ta_opcion,
                                                       ta_fecha_est, ta_detalle, ta_consolidado,ta_oficina_orig,
                                                       ta_concepto_adi
                                                from cb_tasiento
                                                where ta_fecha_tran   = @i_fecha_tran 
                                                and   ta_comprobante  = @i_comprobante 
                                                and   ta_empresa      = @i_empresa 
                                                and   ta_asiento      = @w_asiento 
                                                and   ta_oficina_orig = @i_oficina_orig
 
                                                /* SOLO PARA INGRSO DE COMPROBANTES MANUALES DE MOVIMIENTOS DE PROVICION */  
                                                insert  into cob_conta..cb_concepto_asiento
                                                        select  ca_empresa ,
                                                                ca_producto ,
                                                                ca_fecha_tran ,
                                                                @w_siguiente ,
                                                                @w_asiento , 
                                                                ca_cod_concepto , 
                                                                ca_concepto,
                                                                ca_oficina_ori  
                                                        from cob_conta..cb_tconcepto_asiento
                                                        where ca_fecha_tran   = @i_fecha_tran 
                                                        and   ca_comprobante  = @i_comprobante 
                                                        and   ca_empresa      = @i_empresa 
                                                        and   ca_asiento      = @w_asiento 
                                                        and   ca_oficina_ori  = @i_oficina_orig     
                                            
                                               

                                   select @w_asiento = @w_asiento + 1
                   end
                else 
                select @flag1 = 0
           end -- del while 

        /* validaciones de retencion en comprobante */
    if (@w_aplica_retencion = 'S') begin  --Parametro de Retencion
    
        select @w_numero = count(distinct ta_asiento)  
        from cb_tasiento, cb_cuenta_proceso
        where ta_comprobante    = @i_comprobante and
              ta_fecha_tran     = @i_fecha_tran and
              ta_empresa        = @i_empresa and
              ta_oficina_orig   = @i_oficina_orig and
              ta_tipo_tran <> 'A' and
              ta_cuenta like rtrim(cp_cuenta) + '%' and
              cp_empresa = ta_empresa and  -- JR060599
              cp_proceso IN (6003,6095)
      end --Parametro de Retencion
/*** SE REGRESA A ESQUEMA ANTERIOR JRMZ  *****/
/*****************MODIFICACION VALIDACION******************/

--print '@i_comprobante ' + cast(@i_comprobante as varchar)
/*
select @w_cuenta_ind_base = min(ta_cuenta)
from cb_tasiento
where ta_comprobante    = @i_comprobante and
      ta_fecha_tran     = @i_fecha_tran and
      ta_empresa        = @i_empresa and
      ta_oficina_orig   = @i_oficina_orig and
      ta_tipo_tran <> 'A'

select @w_cuenta_ind_max = max(ta_cuenta)
from cb_tasiento
where ta_comprobante    = @i_comprobante and
      ta_fecha_tran     = @i_fecha_tran and
      ta_empresa        = @i_empresa and
      ta_oficina_orig   = @i_oficina_orig and
      ta_tipo_tran <> 'A'

select @w_cuenta_ind = @w_cuenta_ind_base,
    @w_numero = 0

set rowcount 1
while @w_cuenta_ind <= @w_cuenta_ind_max
begin
   if exists(select 1 
       from cb_cuenta_proceso
       where @w_cuenta_ind like cp_cuenta + '%' and
       cp_empresa = 1 and
       cp_proceso IN (6003,6095))
   begin
    select @w_asientos_cuenta = 0
       select @w_asientos_cuenta = count(1)
       from cb_tasiento
       where ta_comprobante    = @i_comprobante and
             ta_fecha_tran     = @i_fecha_tran and
             ta_empresa        = @i_empresa and
             ta_oficina_orig   = @i_oficina_orig and
             ta_tipo_tran <> 'A'
       and ta_cuenta = @w_cuenta_ind

        select @w_numero  = @w_numero + @w_asientos_cuenta
   end
      
   select @w_cuenta_ind = ta_cuenta
   from cb_tasiento
   where ta_comprobante    = @i_comprobante and
         ta_fecha_tran     = @i_fecha_tran and
         ta_empresa        = @i_empresa and
         ta_oficina_orig   = @i_oficina_orig and
         ta_tipo_tran <> 'A'
   and ta_cuenta > @w_cuenta_ind_base

   if @@rowcount = 0
      break

   select @w_cuenta_ind_base = @w_cuenta_ind
end
*/
set rowcount 0
/**********************************************************/        
if (@w_aplica_retencion  = 'S') begin   --Parametro de Retencion

        select @w_numeretencion = count(*)
        from cb_tretencion
        where  tr_empresa = @i_empresa and
               tr_comprobante = @i_comprobante and
               tr_fecha = @i_fecha_tran and
               tr_oficina_orig = @i_oficina_orig
    
        if @w_numero <> @w_numeretencion
        begin 
--print '2'        
--print '@w_numeretencion ' + cast(@w_numeretencion as varchar)
--print '@w_numero ' + cast(@w_numero as varchar)

        -- Error en insercion de comprobante por retencion
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 603025
        print '603025-1'

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig
         delete cob_conta..cb_concepto_asiento
                  where  ca_fecha_tran   = @i_fecha_tran      and
                         ca_comprobante   = @i_comprobante    and
                         ca_empresa       = @i_empresa        

        delete cob_conta..cb_concepto_asiento
        where  ca_fecha_tran   = @i_fecha_tran      and
               ca_comprobante   = @i_comprobante    and
               ca_empresa       = @i_empresa        
        

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig

        return 1
        end


        insert into cb_retencion(re_comprobante,
               re_empresa, re_asiento,re_ente,
           re_identifica,re_tipo,re_fecha, re_cuenta, 
               re_concepto, re_base, re_valret,
               re_valor_asiento, re_valor_iva,
               re_valor_ica, re_iva_retenido,
               re_con_iva, re_con_timbre, 
               re_valor_timbre, re_retencion_calculado,
               re_iva_calculado, re_ica_calculado,
               re_timbre_calculado, re_con_ica, 
               re_con_ivapagado, re_ivapagado_calculado,
               re_valor_ivapagado,re_documento,re_oficina_orig,
               re_con_dptales ,re_valor_dptales) /*CMDO*/ 
        select @w_siguiente, tr_empresa, tr_asiento,
           tr_ente, tr_identifica,tr_tipo,tr_fecha, tr_cuenta, 
               tr_concepto, tr_base,tr_valret, 
               tr_valor_asiento, tr_valor_iva,
           tr_valor_ica, tr_iva_retenido,
           tr_con_iva, tr_con_timbre,
           tr_valor_timbre, tr_retencion_calculado,
               tr_iva_calculado, tr_ica_calculado,
               tr_timbre_calculado, tr_con_ica,
               tr_con_ivapagado, tr_ivapagado_calculado,
               tr_valor_ivapagado,tr_documento,tr_oficina_orig, 
               tr_con_dptales, tr_valor_dptales   /*CMDO*/
       from cb_tretencion
    where tr_fecha =  @i_fecha_tran and
          tr_comprobante = @i_comprobante and
          tr_empresa     = @i_empresa and
          tr_oficina_orig = @i_oficina_orig


    if @@error <> 0
    begin
--print '3'
          -- Error en insercion de comprobante por retencion
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 603025
        print '603025 2'
        --print 'comprobante %1!'
        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig
         delete cob_conta..cb_concepto_asiento
                  where  ca_fecha_tran   = @i_fecha_tran      and
                         ca_comprobante   = @i_comprobante    and
                         ca_empresa       = @i_empresa        

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end
end --Parametro de Retencion
-- Inicio - Conciliacion
        insert into cb_conciliacion(
               cl_empresa,
           cl_fecha,
               cl_comprobante,
               cl_asiento,
               cl_operacion,
               cl_cheque,
               cl_oficina_orig
        )
        select tc_empresa,
               tc_fecha,
               @w_siguiente,
               tc_asiento,
               tc_operacion,
               tc_cheque,
               tc_oficina_orig
       from cb_tconciliacion
    where tc_fecha =  @i_fecha_tran and
          tc_comprobante = @i_comprobante and
          tc_empresa     = @i_empresa and
              tc_oficina_orig = @i_oficina_orig
        

    if @@error <> 0
    begin
--print '4'
          -- Error en insercion de comprobante por retencion
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 603025
        print '603025 3'
        --print 'comprobante %1!'
        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig
         delete cob_conta..cb_concepto_asiento
                  where  ca_fecha_tran   = @i_fecha_tran      and
                         ca_comprobante   = @i_comprobante    and
                         ca_empresa       = @i_empresa        

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
    end

-- Fin - Conciliacion



/******* actualizacion de status de mayorizados ******/

/******* actualizacion de status de mayorizados ******/

    if @w_mayoriza = 'S' and @wt_mayorizado = 'S'
    begin
        update cob_conta..cb_comprobante
        set co_mayorizado = @wt_mayorizado
        where     co_fecha_tran = @i_fecha_tran and
            co_comprobante = @w_siguiente and
            co_empresa = @i_empresa and
                        co_oficina_orig = @i_oficina_orig

        if @@error <> 0
        begin
         -- Error en actualizacion de codigo mayorizado o no
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 603022

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
        end

        update cb_asiento
        set as_mayorizado = @wt_mayorizado
        where     as_fecha_tran = @i_fecha_tran and
            as_comprobante = @w_siguiente and
            as_empresa = @i_empresa and
                        as_oficina_orig = @i_oficina_orig

        if @@error <> 0
        begin
         -- Error en actualizacion de codigo mayorizado o no
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 603022

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
            delete cob_conta..cb_tconciliacion
            where   tc_fecha = @i_fecha_tran and
                    tc_comprobante = @i_comprobante and
                    tc_empresa = @i_empresa and
                        tc_oficina_orig = @i_oficina_orig
        -- Fin - Conciliacion 

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
        end
    end
    select @w_siguiente
commit tran
    delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
        -- Borrar Tablas temporales
    delete cob_conta..cb_tasiento
    where   ta_fecha_tran = @i_fecha_tran and
        ta_comprobante = @i_comprobante and
        ta_empresa = @i_empresa and
                ta_oficina_orig = @i_oficina_orig

    delete cob_conta..cb_tcomprobante
    where     ct_fecha_tran = @i_fecha_tran and
        ct_comprobante = @i_comprobante and
        ct_empresa = @i_empresa and
                ct_oficina_orig = @i_oficina_orig

        delete cob_conta..cb_tretencion
        where   tr_fecha = @i_fecha_tran and
                tr_comprobante = @i_comprobante and
                tr_empresa = @i_empresa and
                tr_oficina_orig = @i_oficina_orig

        -- Inicio - Conciliacion 
        delete cob_conta..cb_tconciliacion
        where   tc_fecha = @i_fecha_tran and
                tc_comprobante = @i_comprobante and
                tc_empresa = @i_empresa and
                tc_oficina_orig = @i_oficina_orig
    -- Fin - Conciliacion 

return 0
end -- Fin de ingreso/update ('I' or 'U')

/****************** UPDATE (APROBAR) *****************/
   
if @i_operacion = 'M'
begin
    delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
    insert cob_conta..cb_usu_capt_comp values (@s_ofi,@s_term,@s_user,@i_proceso,'E',getdate())
    
    select co_autorizado
    from cob_conta..cb_comprobante
    where co_fecha_tran   = @i_fecha_tran 
    and   co_comprobante  = @i_comprobante 
    and   co_empresa      = @i_empresa  
    and   co_oficina_orig = @i_oficina_orig
    and   isnull(co_traslado, 'N') = 'N'
    if @@rowcount > 0
    begin
        begin tran
        update cob_conta..cb_comprobante
          set 
            co_fecha_mod     = getdate(),
            co_autorizado    = @i_autorizado,
            co_autorizante      = @i_autorizante ,
            co_causa_anula    = @i_anula
        from cob_conta..cb_comprobante
        where     co_fecha_tran    = @i_fecha_tran and    
            co_comprobante     = @i_comprobante and
            co_empresa    = @i_empresa and
                        co_oficina_orig = @i_oficina_orig
        if @@error <> 0
        begin
        /* 'error en actualizacion de comprobante' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 603022
            return 1
        end
        /***************************/
        /* TRANSACCION DE SERVICIO */
        /***************************/
        insert into ts_comprobante
         values (@i_comprobante,@t_trn,'U',getdate(),@s_user,
              @s_term,@s_ofi,@i_empresa,@wa_oficina_dest,@i_comprobante,
              @wa_oficina_orig,@wa_depto_orig,@wa_fecha_tran,@wa_descripcion,@wa_comp_tipo,
              @wa_detalles,@wa_tot_debito,@wa_tot_credito,@wa_tot_debito_me,@wa_tot_credito_me)
        if @@error <> 0
        begin
        /* 'Error en insercion de transaccion de servicio' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 603032
            return 1
        end
        commit tran
        delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
        return 0
     end
     else begin
        /* 'No existen Comprobantes ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
             @t_file = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601060
            return 1
    end
end
   
/********************** ALL   SEARCH *****************/

/* Operacion search retorna comprobantes nomayorizados y del grabados en 
   en el dia */

if @i_operacion = 'S' 
begin

     if @i_modo in (0,1)
        select @w_otro_user = pa_char
        from cobis..cl_parametro
        where pa_producto = 'CON'
          and pa_nemonico = 'OTRUS'
     
     set rowcount 20

     if @i_modo = 0
     begin
          select 'Oficina'   = co_oficina_orig,
                 'No.Comp.'  = co_comprobante,
                 'Fecha'     = convert(char(10),co_fecha_tran,@i_formato_fecha),
                 'Digitado'  = convert(char(10),co_fecha_dig,@i_formato_fecha),
                 'Digitador' = co_digitador,
                 'Aut.'      = co_autorizado,
                 'May.'      = co_mayorizado
          from cob_conta..cb_comprobante, 
               cob_conta..cb_control b
          where co_mayorizado  = @i_mayorizado
            and ((co_digitador  = @s_user and @w_otro_user != 'S') 
             or  (co_digitador != @s_user and @w_otro_user = 'S'))
            and co_fecha_tran >= '01/01/1900'
            and co_empresa     = @i_empresa 
            and co_oficina_orig in (select je_oficina
                                    from cb_jerarquia
                                    where je_empresa = 1 
                                      and (je_oficina = b.cn_oficina or je_oficina_padre = b.cn_oficina)) 
                                      and co_area_orig in (select ja_area
                                                           from cb_jerararea
                                                           where ja_empresa = 1 
                                                             and (ja_area = b.cn_area or ja_area_padre =b.cn_area))
            and cn_empresa = @i_empresa
            and cn_login   = @s_user
            and cn_tipo    = 'M'
          order by co_fecha_tran, co_oficina_orig,co_comprobante

          if @@rowcount = 0
          begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 601060
               set rowcount 0
               return 1
          end
          set rowcount 0
          return 0
     end
     
     if  @i_modo = 1
     begin
          select 'Oficina'   = co_oficina_orig,
                 'No.Comp.'  = co_comprobante,
                 'Fecha'     = convert(char(10),co_fecha_tran,@i_formato_fecha),
                 'Digitado'  = convert(char(10),co_fecha_dig,@i_formato_fecha),
                 'Digitador' = co_digitador,
                 'Aut.'      = co_autorizado,
                 'May.'      = co_mayorizado
          from cob_conta..cb_comprobante, 
               cob_conta..cb_control b
          where co_mayorizado  = @i_mayorizado
            and ((co_digitador  = @s_user and @w_otro_user != 'S') 
             or  (co_digitador != @s_user and @w_otro_user = 'S'))
            and co_fecha_tran >= '01/01/1900'
            and co_empresa     = @i_empresa 
            and co_oficina_orig in (select je_oficina
                                    from cb_jerarquia
                                    where je_empresa = 1 
                                      and (je_oficina = b.cn_oficina or je_oficina_padre = b.cn_oficina)) 
                                      and co_area_orig in (select ja_area
                                                           from cb_jerararea
                                                           where ja_empresa = 1 
                                                             and (ja_area = b.cn_area or ja_area_padre =b.cn_area))
            and ((co_fecha_tran > @i_fecha_tran) 
             or (co_fecha_tran = @i_fecha_tran and co_oficina_orig > @i_oficina) 
             or (co_fecha_tran = @i_fecha_tran and co_oficina_orig = @i_oficina and co_comprobante > @i_comprobante))
            and cn_empresa     = @i_empresa
            and cn_login       = @s_user
            and cn_tipo        = 'M'
          order by co_fecha_tran, co_oficina_orig,co_comprobante

          if @@rowcount = 0
          begin           
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 601060
               set rowcount 0
               return 1
          end
          
          set rowcount 0
          return 0
     end

    if  @i_modo = 2
    begin

        select co_comprobante,
               convert(char(10),co_fecha_tran,@i_formato_fecha),
               co_mayorizado,
               convert(char(12),co_fecha_dig,@i_formato_fecha),
               convert(char(12),getdate(),@i_formato_fecha),
               co_oficina_orig, co_area_orig
            from cob_conta..cb_comprobante, cb_control
             where co_empresa = @i_empresa 
          and co_fecha_tran = @i_fecha_tran
                  and co_comprobante = @i_comprobante
                  and co_oficina_orig >= 0
                  and cn_empresa = @i_empresa
                  and cn_login = @s_user
                  and cn_oficina = co_oficina_orig 
                  and cn_area = co_area_orig 

        if @@rowcount = 0
        begin
            /* 'No existen Comprobantes ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601060
            set rowcount 0
            return 1
        end
        set rowcount 0
        return 0
    end

    if  @i_modo = 3
        begin
        set rowcount 1
        select co_comprobante,
               convert(char(10),co_fecha_tran,@i_formato_fecha),
               co_mayorizado,
               convert(char(12),co_fecha_dig,@i_formato_fecha),
               convert(char(12),getdate(),@i_formato_fecha)
            from cob_conta..cb_comprobante, cob_conta..cb_control
             where co_empresa = @i_empresa 
                  and co_mayorizado = 'N' 
                  and co_comprobante > @i_comprobante
                  and cn_login = @s_user
                  and co_oficina_orig = cn_oficina
                  and co_area_orig    = cn_area
                  and cn_empresa = @i_empresa
                  and cn_login = @s_user
                  and cn_oficina = co_oficina_orig
                  and cn_area = co_area_orig
                  order by co_comprobante 

        if @@rowcount = 0
        begin
            /* 'No existen Comprobantes ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601060
            set rowcount 0
            return 1
        end
        set rowcount 0
        return 0
    end

    if  @i_modo = 4
        begin
        set rowcount 1
        select co_comprobante,
               convert(char(10),co_fecha_tran,@i_formato_fecha),
               co_mayorizado,
               convert(char(12),co_fecha_dig,@i_formato_fecha),
               convert(char(12),getdate(),@i_formato_fecha)
            from cob_conta..cb_comprobante, cob_conta..cb_control
             where co_empresa = @i_empresa 
                  and co_mayorizado = 'N' 
                  and co_comprobante < @i_comprobante
                  and co_oficina_orig = cn_oficina
                  and co_area_orig    = cn_area
                  and cn_empresa = @i_empresa
                  and cn_login = @s_user
                  and cn_oficina = co_oficina_orig
                  and cn_area = co_area_orig
                  order by co_comprobante desc

        if @@rowcount = 0
        begin
            /* 'No existen Comprobantes ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601060
            set rowcount 0
            return 1
        end
        set rowcount 0
        return 0
    end

end


if @i_operacion = 'A' 
begin
    set rowcount 20
    if @i_modo = 0
    begin
        select convert(char(12),co_fecha_tran,@i_formato_fecha),
            co_comprobante
            from cob_conta..cb_comprobante
        where co_empresa = @i_empresa
          and co_fecha_tran >= '01/01/1900'
                  and co_comprobante >= 0
                  and co_oficina_orig >= 0
           order by co_fecha_tran,co_comprobante,co_oficina_orig

        if @@rowcount = 0
        begin
            /* 'No existen Comprobantes ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
             @t_file = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601060
            set rowcount 0
            return 1
        end
        set rowcount 0
            return 0
    end
    if  @i_modo = 1
    begin
        select convert(char(12),co_fecha_tran,@i_formato_fecha),
            co_comprobante
        from cob_conta..cb_comprobante
        where     co_empresa = @i_empresa and (
            (co_comprobante > @i_comprobante) or
                        ((co_comprobante = @i_comprobante) and (co_oficina_orig > @i_oficina_orig))
                        )
 
        order by co_fecha_tran,co_comprobante,co_oficina_orig

        if @@rowcount = 0
        begin
            /* 'No existen Comprobantes ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601060
            set rowcount 0
            return 1
        end
        set rowcount 0
        REturn 0
    end
end

/********* Query *******/
if @i_operacion = 'Q'
begin
    set rowcount 20
    if @i_modo = 0 
    begin
   
    select     co_oficina_orig,
            co_area_orig,
            co_comprobante,
            substring(co_descripcion,1,120),
            convert(char(12),co_fecha_tran,@i_formato_fecha),
            co_mayorizado,
            co_comp_tipo,
            co_tot_debito,
            co_tot_credito,
            co_tot_debito_me,
            co_tot_credito_me,
             substring(of_descripcion,1,40),
            substring(ar_descripcion,1,40), 
            co_autorizado,
            substring(co_digitador,1,15),
            substring(co_autorizante,1,15),
            substring(co_referencia,1,10),
            co_estado,co_tipo_compro, 
            convert(char(12),co_fecha_dig,@i_formato_fecha),
            co_causa_anula, 
            co_reversado
  
        from     cob_conta..cb_comprobante ,
                cob_conta..cb_oficina , 
                cob_conta..cb_area 
        where     co_fecha_tran      =       @i_fecha_tran       and
                co_empresa         =       @i_empresa          and
                co_comprobante     =       @i_comprobante      and
                co_oficina_orig    =       @i_oficina_orig     and
                of_empresa         =       @i_empresa          and
                of_oficina         =       co_oficina_orig     and
                ar_empresa         =       @i_empresa          and
                ar_area            =       co_area_orig        



        if @@rowcount = 0
        begin
            /* 'Comprobante consultado no existe'*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601061
            return 1
        end


        

select  as_oficina_dest,
        as_area_dest,
        as_cuenta,
        as_tipo_doc,
        as_debito,
        as_credito,
        as_debito_me,
        as_credito_me,
        as_cotizacion,
        as_tipo_tran,
        substring(as_concepto,1,60),
        as_moneda,
        ca_cod_concepto = (select ca_cod_concepto
                              from cob_conta..cb_concepto_asiento
                              where ca_comprobante = a.as_comprobante 
                              and   ca_asiento     = a.as_asiento),    
         ca_concepto = (select ca_concepto
                              from cob_conta..cb_concepto_asiento
                              where ca_comprobante = a.as_comprobante 
                              and   ca_asiento     = a.as_asiento)
        from cob_conta..cb_asiento a
        where as_fecha_tran   = @i_fecha_tran     and
              as_comprobante  = @i_comprobante    and
              as_empresa      = @i_empresa         and
              as_oficina_orig = @i_oficina_orig
   order by as_asiento

    end
    else begin
        select  as_oficina_dest,as_area_dest,as_cuenta,
            as_tipo_doc,as_debito,as_credito,as_debito_me,
            as_credito_me,as_cotizacion,as_tipo_tran,
            substring(as_concepto,1,60),as_moneda,
        ca_cod_concepto = (select ca_cod_concepto
                              from cob_conta..cb_concepto_asiento
                              where ca_comprobante = a.as_comprobante 
                              and   ca_asiento     = a.as_asiento),    
         ca_concepto = (select ca_concepto
                              from cob_conta..cb_concepto_asiento
                              where ca_comprobante = a.as_comprobante 
                              and   ca_asiento     = a.as_asiento)
        from cob_conta..cb_asiento a
        where     as_fecha_tran = @i_fecha_tran and
            as_comprobante = @i_comprobante and
            as_empresa = @i_empresa and
                        as_oficina_orig = @i_oficina_orig and
            as_asiento > @i_asiento
        order by as_asiento
        
        if @@rowcount = 0 
        begin
                 /*  if @i_msg = 0 */
                 /*    begin */
            /* 'Comprobante consultado no existe'*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601150
                /*    end */
            return 1
        end
    end
    return 0
end

/********* consulta *******/
if @i_operacion = 'R'
begin
    set rowcount 20
    if @i_modo = 0 
    begin
        select     co_oficina_orig,co_area_orig,
            co_comprobante,substring(co_descripcion,1,120),
            convert(char(12),co_fecha_tran,@i_formato_fecha),
            co_mayorizado,
            co_comp_tipo,co_tot_debito,
            co_tot_credito, co_tot_debito_me, co_tot_credito_me,
             substring(of_descripcion,1,40),
            substring(ar_descripcion,1,40), co_autorizado,
                        substring(co_digitador,1,15),
            substring(co_autorizante,1,15),
            substring(co_referencia,1,10),
            co_estado,co_tipo_compro, 
            convert(char(12),co_fecha_dig,@i_formato_fecha),
                        co_causa_anula, co_reversado
        from     cb_comprobante,cb_oficina, cb_area
        where     co_fecha_tran = @i_fecha_tran 
            and  co_empresa = @i_empresa 
            and co_comprobante = @i_comprobante 
            and co_oficina_orig = @i_oficina_orig 
                        and of_empresa = @i_empresa 
            and of_oficina = co_oficina_orig 
            and ar_empresa = @i_empresa 
            and ar_area = co_area_orig
            and co_mayorizado=@i_mayorizado
            
        if @@rowcount = 0
        begin
            /* 'Comprobante consultado no existe'*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601061
            return 1
        end
        select  as_oficina_dest,as_area_dest,as_cuenta,
            as_tipo_doc,as_debito,as_credito,as_debito_me,
            as_credito_me,as_cotizacion,as_tipo_tran,
            substring(as_concepto,1,60),as_moneda
        from cob_conta..cb_asiento
        where     as_fecha_tran = @i_fecha_tran and
            as_comprobante = @i_comprobante and
            as_empresa = @i_empresa and
                        as_oficina_orig = @i_oficina_orig
        order by as_asiento

    end
    else begin
        select  as_oficina_dest,as_area_dest,as_cuenta,
            as_tipo_doc,as_debito,as_credito,as_debito_me,
            as_credito_me,as_cotizacion,as_tipo_tran,
            substring(as_concepto,1,60),as_moneda
        from cob_conta..cb_asiento
        where     as_fecha_tran = @i_fecha_tran and
            as_comprobante = @i_comprobante and
            as_empresa = @i_empresa and
                        as_oficina_orig = @i_oficina_orig and
            as_asiento > @i_asiento
        order by as_asiento
        
        if @@rowcount = 0 
        begin
                 /*  if @i_msg = 0 */
                 /*    begin */
            /* 'Comprobante consultado no existe'*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num     = 601150
                /*    end */
            return 1
        end
    end
    return 0
end




/* RV002 */
/********* Pago Provision y de Facturas *******/




if @i_operacion = 'P'
begin
        begin tran
    update cob_conta..cb_comprobante
    set co_estado = 'P'
    where co_comprobante = @i_comprobante 
          and co_empresa = @i_empresa 
              and co_oficina_orig = @i_oficina_orig
              
          /*and co_tipo_compro = 'P'*/
        if @@error <> 0
            begin
            -- Error en el pago de comprobante
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num     = 601168

        delete cob_conta..cb_tasiento
        where   ta_fecha_tran = @i_fecha_tran and
            ta_comprobante = @i_comprobante and
            ta_empresa = @i_empresa and
                        ta_oficina_orig = @i_oficina_orig

            delete cob_conta..cb_tretencion
            where   tr_fecha = @i_fecha_tran and
                    tr_comprobante = @i_comprobante and
                    tr_empresa = @i_empresa and
                        tr_oficina_orig = @i_oficina_orig

        delete cob_conta..cb_tcomprobante
        where     ct_fecha_tran = @i_fecha_tran and
            ct_comprobante = @i_comprobante and
            ct_empresa = @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
        return 1
                end
    commit tran
    return 0
end

/* RV003 */
/******** Busqueda de Comprobantes ******/
/* Dependiendo del numero de proceso, encuentra una cuenta asociada
   que determina a que tipo de cuenta corresponde            */

if @i_operacion = 'B'
begin
  select distinct @w_tipo = cp_condicion
  from cb_oficina,cb_cuenta, cb_cuenta_proceso
  where of_empresa = @i_empresa
  and cp_empresa = @i_empresa
  and (cp_proceso = 6970 or cp_proceso = 6980 or cp_proceso = 6990 or 
       cp_proceso = 6960)
  /*and cp_proceso = 6980*/
  and cu_cuenta = @i_cuenta 
  and cu_empresa  = @i_empresa
  and cp_cuenta  = cu_cuenta
  and cu_movimiento = 'S'

  select @w_tipo
end

go

