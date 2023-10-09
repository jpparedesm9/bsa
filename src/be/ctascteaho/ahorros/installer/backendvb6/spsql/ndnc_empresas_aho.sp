/************************************************************************/
/*  Archivo:            ndnc_empresas_aho.sp                            */
/*  Stored procedure:   sp_ndnc_empresas_aho                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Julio Navarrete/Xavier Bucheli   */
/*  Fecha de escritura: 12-Ene-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de ND y NC otras            */
/*  fuentes (automaticas).                                              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR             RAZON                             */
/*  25/Jul/1995     J Navarrete V.  Emision inicial                     */
/*  15/Sep/1995     A Villarreal    Revision General                    */
/*  15/Oct/1996     E Guerrero A.   Utilizar ssn kernel cobis           */
/*  14/Sep/1999     V Molina E.     Banco del Caribe                    */
/*  20/Jul/2000     Yenny Rivero    Programacion para que no che--      */
/*                                  queara si la cuenta esta blo--      */
/*                                  queada para el caso de Inager y     */
/*                                  Pensionados                         */
/*  21/Jul/2000     Yenny Rivero    Programacion para que activara      */
/*                                  la cuenta, en caso de que este      */
/*                                  inactiva, para el caso de Fidei-    */
/*                                  comiso                              */
/*  02/May/2016     Juan Tagle      Migración a CEN                     */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_ndnc_empresas_aho')
    drop proc sp_ndnc_empresas_aho
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_ndnc_empresas_aho (
        @s_srv                  varchar(30),
        @s_ssn                  int,
        @s_ssn_branch           int = null,
        @t_corr                 char(1) = 'N',
        @t_ssn_corr             int = null,
        @t_show_version         bit = 0,
        @i_cuenta               cuenta,
        @i_val                  money,
        @i_cau                  varchar(4),
        @i_mon                  tinyint,
        @i_operacion            char(1),
        @i_oficina              smallint,
        @i_sec                  int,
        @i_tipo_pago            varchar(3) = null,
        @i_domiciliacion        char(1)= null,
        @i_fecha                datetime ,
        @i_devolucion_imp       money = 0,
        @o_procesado            char(1) = 'S' out,
        @o_monto_imp            money = 0 out
)
as
declare @w_return       int,
    @w_estado       char(1),
    @w_mensaje      varchar(254),
    @w_valor        money,
    @w_fecha        datetime,
    @w_ssn          int,
    @w_trn          int,
    @w_letra            char(1),
    @w_longitud         tinyint,
    @w_verificar_blq    char(1),
    @w_activar_cta      char(1),
    @w_imp          char(1),
    @w_sp_name      varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_ndnc_empresas_aho'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

   begin tran
     select @o_procesado = 'S'

     if @t_corr = 'N'
     begin
         if @i_domiciliacion = 'S'
         begin

            select @w_letra =  right(@i_tipo_pago,1)
            select @w_longitud =  datalength(@i_tipo_pago)-1

            if @w_letra = 'V' or @w_letra = 'M'
               select @i_tipo_pago = substring(@i_tipo_pago,1,@w_longitud)


            if not exists (select 1
                             from  cob_remesas..re_tipo_pago
                            where tp_producto = 4
                              and tp_cuenta = @i_cuenta
                              and tp_tipo_pago = @i_tipo_pago)
              begin
                print 'Cuenta con error: ' + @i_cuenta
                select @w_mensaje= 'CUENTA NO TIENE DOMICILIACION DE PAGOS'

                 insert into cob_ahorros..re_error_batch values
                        (@i_cuenta,@w_mensaje)
                  if @@error <> 0
                   begin
                        rollback tran
                        exec cobis..sp_cerror
                                @i_num    = 203035
                        return 1
                   end

                update cob_remesas..re_ndc_automatica
                   set na_estado = 'E',
                       na_mensaje = @w_mensaje
                 where na_cuenta = @i_cuenta and
                       na_sec    = @i_sec

               select @o_procesado = 'N'
               commit tran
               return 0
         end
      end
     end

    if @i_operacion = 'D'
       select @w_trn = 264,
          @w_imp = 'S'
    else
       select @w_trn = 253,
                  @w_imp = 'N'


        /* No se puede hacerse begin tran para multiples registros */
        /* pues puede fallar una nota por una razon valida         */

    if @i_tipo_pago = '8' or @i_tipo_pago = '12'   -- Pensionados e Inager cuentas bloque.
       select @w_verificar_blq = 'N'
    else
       select @w_verificar_blq = 'S'

    if @i_tipo_pago = '6' -- Fideicomiso
       select @w_activar_cta = 'S'
    else
       select @w_activar_cta = 'N'



    exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv = @s_srv,
        @s_ofi = @i_oficina,
        @s_ssn = @s_ssn,
        @s_ssn_branch = @s_ssn_branch,
                @s_user = 'ibatch',
                @t_corr = @t_corr,
                @t_ssn_corr = @t_ssn_corr,
        @t_trn = @w_trn,
        @i_cta = @i_cuenta,
        @i_val = @i_val,
        @i_cau = @i_cau,
        @i_mon = @i_mon,
        @i_fecha = @i_fecha,
                @i_imp = @w_imp,
        @i_verificar_blq = @w_verificar_blq,
        @i_activar_cta = @w_activar_cta,
                @i_devolucion_imp  = @i_devolucion_imp,
                @o_monto_imp = @o_monto_imp out

    if @w_return <> 0
    begin
        rollback tran

    print 'Cuenta con error: ' + @i_cuenta

        select @w_mensaje = mensaje
          from cobis..cl_errores
         where numero = @w_return

             if @t_corr = 'N'
                if @w_mensaje is null
           select @w_mensaje = 'Error en la Ejecucion de la Nota D/C'
             else
                 if @w_mensaje is null
                      select @w_mensaje = 'Error en reverso de Nota de D/C'

        insert into cob_ahorros..re_error_batch values
            (@i_cuenta,@w_mensaje)
        if @@error <> 0
        begin
                    exec cobis..sp_cerror
                            @i_num    = 203035
            rollback tran
                return 1
        end

        update cob_remesas..re_ndc_automatica
           set na_estado = 'E',
               na_mensaje = @w_mensaje --,
               --na_num_error = @w_return
         where na_cuenta = @i_cuenta and
               na_sec    = @i_sec

               select @o_procesado = 'N'
    end
    else
    begin
            if @t_corr = 'S'
              select @w_estado = 'R'
            else
              select @w_estado = 'P'

         update cob_remesas..re_ndc_automatica
            set na_estado = @w_estado --,
                --na_num_error = 0
         where na_cuenta = @i_cuenta and
                       na_sec    = @i_sec

        end

select @o_procesado
commit tran
return 0

go

