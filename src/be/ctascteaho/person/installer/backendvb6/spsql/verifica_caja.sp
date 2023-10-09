/****************************************************************************/
/*     Archivo:     verifica_caja.sp                                        */
/*     Stored procedure: sp_verifica_caja                                   */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_verifica_caja')
  drop proc sp_verifica_caja
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
CREATE proc sp_verifica_caja(
  @t_trn           int,
  @s_term          varchar(10) = null,
  @s_date          datetime,
  @s_user          varchar(32),
  @s_ofi           smallint    = null,
  @s_srv           varchar(30) = null,
  @i_filial        tinyint,
  @i_srv           varchar(30) = null,
  @i_ofi           smallint,
  @i_mon           tinyint,
  @i_idcaja        int,
  @i_pit           char(1) = 'N', --Parametro usado por la interface PIT
  @i_verif_caja    char(1) = 'S'
)                  
as                 
declare            
  @w_return        int,
  @w_sp_name       varchar(64),
  @w_tipo          varchar(3),
  @w_horafin       datetime,
  @w_mensaje       mensaje,
  @w_fecha_proc    datetime,
  @w_servidor      varchar(50),
  @w_ossn          int,
  @w_ssn           int

  select @w_sp_name = 'sp_verifica_caja'

  -- Si la Terminal == SAFE se apertura la caja automaticamente
   
  --print 'Prueba OLF - COBIS: s_term = %1!',@s_term
  if @i_pit = 'S'
    select @s_term = 'PIT'
    
  if @s_term in ('SAFE','FX11','PIT')
  begin
      if not exists (select 1 from  cob_remesas..re_caja
                     where  cj_filial      = @i_filial
                     and    cj_oficina     = @i_ofi
                     and    cj_fecha       = @s_date
                     and    cj_operador    = @s_user
                     and    cj_moneda      = @i_mon
                     and    cj_transaccion = 15
                     and    cj_id_caja     = @i_idcaja)
      begin
     
         select @w_servidor = nl_nombre
         from   cobis..ad_nodo_oficina
         where  nl_nodo = 1
         
         -- Se toma Numero de Secuencial inicial 
         select @w_ssn = se_numero + 4800
         from cobis..ba_secuencial
         
         if @@rowcount <> 1
         begin
            -- Error en lectura de SSN
            select @w_mensaje = 'ERROR EN LECTURA DE SSN'
            exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_msg   = @w_mensaje,
               @i_sev   = 0, --Evita hacer Rollback
               @i_num = 201163
            return 201163
         end
         
         -- Actualizar Secuencial
         update cobis..ba_secuencial
         set se_numero = @w_ssn
         
         if @@rowcount <> 1
         begin
              -- Error en actualizacion de SSN
              exec cobis..sp_cerror
                   @i_num = 205031
              return 205031
         end
         --print 'Prueba OLF - COBIS: @w_servidor = %1!',@w_servidor
         --print 'Prueba OLF - COBIS: @i_ofi = %1!',@i_ofi
         --print 'Prueba OLF - COBIS: @s_date = %1!',@s_date
         --print 'Prueba OLF - COBIS: @s_user = %1!',@s_user
         --print 'Prueba OLF - COBIS: @i_mon = %1!',@i_mon
         --print 'Prueba OLF - COBIS: @i_idcaja = %1!',@i_idcaja
         --print 'Prueba OLF - COBIS: Ejecuta sp_apertura_caja'
         
         exec @w_return = cob_remesas..sp_apertura_caja
              @s_ssn        = @w_ssn,
              @s_ssn_branch = @w_ssn,
              @s_lsrv       = @w_servidor,
              @s_date       = @s_date,
              @s_org        = 'U',
              @s_srv        = @w_servidor,
              @s_user       = @s_user,
              @s_term       = @s_term,
              @s_ofi        = @i_ofi,
              @s_rol        = 11,
              @t_trn        = 15,
              @i_val        = 0,
              @i_mon        = 0,
              @i_sld_caja   = 0,
              @i_idcierre   = 1,
              @i_idcaja     = @i_idcaja,
              @i_filial     = 1,
              @i_pit        = 'S',
              @o_ssn        = @w_ossn out
              
         if @w_return <> 0
         begin
            --print 'Prueba OLF - COBIS: Error abriendo la caja'
            exec cobis..sp_cerror
                 @t_file   = @w_sp_name,
                 @t_from   = @w_sp_name,
                 @i_num    = @w_return
            return @w_return 
         end
      end
  end
  
  select @w_tipo    = ci_tipo,
         @w_horafin = ci_hora_fin
  from   cob_remesas..re_cierre
  where  ci_id_cierre = (select max(ci_id_cierre)
                         from  cob_remesas..re_cierre
                         where ci_filial   = @i_filial
                         and   ci_oficina  = @i_ofi
                         and   ci_fecha    = @s_date -- Fecha de Proceso
                         and   ci_id_caja  = @i_idcaja -- Identificador de caja por filial
                         and   ci_moneda   = @i_mon)
  and    ci_moneda  = @i_mon
  and    ci_filial  = @i_filial
  and    ci_oficina = @i_ofi
  and    ci_fecha   = @s_date
  and    ci_id_caja = @i_idcaja

  if @@rowcount = 0
  begin
    -- Error Caja no Aperturada solamente si es requisito aperturar caja
     if @i_verif_caja = 'S'
     begin
        exec cobis..sp_cerror1
             @t_from  = @w_sp_name,
             @i_num = 351075,
             @i_pit = @i_pit
        return 351075
     end
  end
  else
  begin
     -- REGISTRO DE CAJA YA APERTURADO
     if @i_verif_caja = 'N' and @w_horafin is null
     begin
         select @w_mensaje = 'REGISTRO DE CAJA YA APERTURADO'
         exec cobis..sp_cerror1
              @t_from  = @w_sp_name,
              @i_msg   = @w_mensaje,
              @i_num = 351076,
              @i_pit = @i_pit
         return 351076
     end
  end
  
  -- Si el maximo periodo de cierre existente ha sido ya cuadrado con el caracter de Total
  -- durante la jornada entonces no se puede ya transaccionar
  if @w_tipo = 'T' and @w_horafin is not null 
  begin
     -- NO PUEDE TRANSACCIONAR, SU CAJA HA SIDO CERRADA
     select @w_mensaje = 'REGISTRO DE CAJA YA APERTURADO'
     
     exec cobis..sp_cerror1
          @t_from  = @w_sp_name,
          @i_msg   = @w_mensaje,
          @i_num   = 351077,
          @i_pit   = @i_pit 
     return 351077
  end
return 0


go
