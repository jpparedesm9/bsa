


USE cob_ahorros_his
go



/***********************************************************************/
/*  Archivo:            depura_historico_ah.sp                         */
/*  Stored procedure:   sp_depura_historico_ah                        */
/*  Base de datos:      cob_ahorros_his                                */
/*  Producto:           Cuentas de Ahorros                             */
/*  Disenado por:                                                      */
/*  Fecha de escritura:                                                */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                              PROPOSITO                              */
/* Depuracion de los historiales de AHORROS.                           */
/***********************************************************************/
/*                          MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                              */
/*  02/Mayo/2016   Walther Toledo   Migración a CEN                    */
/***********************************************************************/

/****** Object:  StoredProcedure sp_depura_historico_ah    Script Date: 04/05/2016 15:26:42 ******/
SET ANSI_NULLS OFF
go


SET QUOTED_IDENTIFIER OFF
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_depura_historico_ah')
  drop proc sp_depura_historico_ah
go

CREATE proc sp_depura_historico_ah (
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(30) = null,
    @t_show_version bit   = 0,
    @i_fecha_inicio     smalldatetime,
    @i_tipo         char(1)

)
as
declare @w_sp_name              varchar(30),
    @w_contador             int,
    @w_cuantos      int,
    @w_residuo      int,
    @w_porcentaje       int,
    @w_mensaje      varchar(80),
    @w_total        int,
    @w_total_reg            varchar(10)

/*  Captura nombre del stored procedure   */
select  @w_sp_name = 'sp_depura_historico_ah',
    @w_contador  = 1,
    @w_cuantos   = 0,
    @w_residuo   = 5000

        ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
    if @t_show_version = 1
    begin
        print 'Stored Procedure='+@w_sp_name+' Version=4.0.0.0'
        return 0
    end
    
if @i_tipo = 'M'
 begin

    select @w_total = count(1)
     from cob_ahorros_his..ah_his_movimiento
          where hm_fecha <= @i_fecha_inicio
           and  hm_oficina > 0

  while @w_contador = 1
   begin
    set rowcount 1000


     delete cob_ahorros_his..ah_his_movimiento
      where hm_fecha <= @i_fecha_inicio
       and  hm_oficina > 0

    if @@rowcount >= 1000
     begin
    select @w_cuantos = @w_cuantos + 1000
      --dump tran cob_ahorros_his with no_log
     end
    else
         begin
      select @w_contador = 2
         end

     if (@w_cuantos % @w_residuo ) = 0
      begin
       print'SE HAN BORRADO DEL HISTORICO DE MOVIMIENTOS: ' + convert(varchar(10),@w_cuantos)
      end

   end -- while

     select @w_total_reg   = convert(varchar(10),@w_total)
     select @w_mensaje = 'EL TOTAL DE REGISTROS BORRADOS EN AH_HIS_MOVIMIENTO SON: ' + @w_total_reg
     insert into cob_remesas..re_error_batch values ('0',@w_mensaje)
     print @w_mensaje

 end  -- if

if @i_tipo = 'S'
 begin

    select @w_total = count(1)
     from cob_ahorros_his..ah_his_servicio
          where hs_tsfecha <= @i_fecha_inicio
           and  hs_oficina > 0

  while @w_contador = 1
   begin
    set rowcount 1000


         delete cob_ahorros_his..ah_his_servicio
          where hs_tsfecha <= @i_fecha_inicio
           and  hs_oficina > 0


        if @@rowcount >= 1000
         begin
      select @w_cuantos = @w_cuantos + 1000
          --dump tran cob_ahorros_his with no_log
         end
        else
         begin
          select @w_contador = 2
         end

    if (@w_cuantos % @w_residuo ) = 0
         begin
           print'SE HAN BORRADO DEL HISTORICO DE SERVICIO: ' + convert(varchar(10),@w_cuantos)
          end


   end -- while

      select @w_total_reg   = convert(varchar(10),@w_total)
      select @w_mensaje = 'EL TOTAL DE REGISTROS BORRADOS EN AH_HIS_SERVICIO   SON: ' + @w_total_reg
      insert into cob_remesas..re_error_batch values ('0',@w_mensaje)
      print @w_mensaje



  end --if

return 0


go

